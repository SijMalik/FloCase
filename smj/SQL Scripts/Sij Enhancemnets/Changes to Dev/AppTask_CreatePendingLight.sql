USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[AppTask_CreatePendingLight]    Script Date: 09/24/2012 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER  PROC [dbo].[AppTask_CreatePendingLight] 
(
	@pAppTaskDefinitionCode	nvarchar(50)  = '',			-- Manditory.  Map System. 
	@pCaseID				int = 0,					-- Manditory.
	@pUserName				nvarchar(255)  = '',		-- Manditory. Use System.UserName
	@pDescription			nvarchar(255)  = '',		-- Optional. If empty, Definition Description will be used.
	@pAssignedTo			nvarchar(255)  = '',		-- Optional. If empty, CreatedBy will be used.	
	@pDueDate				smalldatetime = NULL,		-- Optional. If empty, ScheduleDefinition or Now will be used.
	@pReminderDate			smalldatetime = NULL,		-- Optional. If empty, ScheduleDefinition or Now will be used.
	@pCaseContactID			int = 0,					-- Optional
	@pDocumentID				int = 0,					-- Optional
	@pAppTaskSubTypeCode	nvarchar(50) = '',
	@pPriorityCode			nvarchar(10)  = '',
	@pKeyDateID				int = 0,
	@pReferencialCode		nvarchar(255) = '',		
	@pCreateIfNotExists		int = 0,				-- SSCF: 0 don't check, 1 check all active only, 2 check all 
	@pRoleCode				nvarchar(10) = ''
) 
		
		
AS

	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================

	SET NOCOUNT ON
	DECLARE @CreatedDate smalldatetime
	DECLARE @AppTaskTypeCode nvarchar(50)
	DECLARE @StandardDescription  nvarchar(50)	
	DECLARE @TaskExists INT
	DECLARE @AppTaskScheduleID INT 	
	DECLARE @errNoAppInsCaseID VARCHAR(50)
	DECLARE @errCTL VARCHAR(50)
	DECLARE @errNoCreatedBy VARCHAR(50)
	DECLARE @errNoAppTaskDefCode VARCHAR(50)
	DECLARE @errNoUserName VARCHAR(50)
	DECLARE @AppInsVal VARCHAR(50)
	DECLARE @AppTaskID int
	  	
  	SET @errNoAppInsCaseID = 'No @AppInstanceValue and @CaseID passed in.'  	  	
  	SET @errNoAppTaskDefCode = 'No @AppTaskDefinitionCode passed in.'
  	SET @errNoUserName = 'No @pUserName passed in.'
  	SET @errCTL = 'User is the Team Leader on the case.'

	
	BEGIN TRY	
		--Get App Instance Value here rather than doing a join
		SELECT @AppInsVal = Case_BLMREF FROM dbo.[Case] WITH (NOLOCK)
		WHERE Case_CaseID = @pCaseID
		

		--Check if task already exists
		--=========================================
		IF (@pCreateIfNotExists > 0)
		BEGIN	
			
			IF EXISTS (SELECT 1 
					FROM dbo.AppTask T WITH (NOLOCK)
					WHERE T.AppInstanceValue= @AppInsVal
					AND ((T.AppTaskDefinitionCode = @pAppTaskDefinitionCode)
						OR (ISNULL(@pAppTaskDefinitionCode,'') = ''))				
					AND ((T.AppTaskSubTypeCode = @pAppTaskSubTypeCode)
						OR (ISNULL(@pAppTaskSubTypeCode,'') = ''))
					AND T.StatusCode = Case WHEN @pCreateIfNotExists = 2 THEN T.StatusCode	
						ELSE 'Active' END)	
			BEGIN								
				SELECT @TaskExists AS TaskExists
				RETURN
			END								
		END
		--==============================================


		DECLARE @CostAssDteExists bit = 0
		
		-- Check if CostAssDte exists
		if EXISTS(SELECT * FROM dbo.CaseKeyDates WITH (NOLOCK) WHERE CaseKeyDates_KeyDatesCode = 'CostAssDte' AND CaseKeyDates_Inactive = 0 AND CaseKeyDates_CaseID = @pCASEID)
			SET	@CostAssDteExists = 1
			
			
		--***********GQL TO DEAL WITH COSTS SUPERVISION
		--DO NOT SCHEDULE SUPERVISION TASK IF USER CREATING IS A CTL ON THE CASE
		-- SSCF Added InActive check as well just in case user used to be a CTL on the case but is no longer
		IF  EXISTS(SELECT AppUserID FROM dbo.AppUser WITH (NOLOCK) WHERE UserName = @pUserName  AND AppUserRoleCode = 'CTL' AND InActive = 0) 
			AND @pAppTaskDefinitionCode = 'DocReview' 
			AND @CostAssDteExists = 1 
			RAISERROR (@errCTL, 16,1)

		if(@CostAssDteExists = 1)
		BEGIN
			--IF WE ARE SCHEDULING A DOCUMENT REVIEW AND THE MATTER HAS BEEN ASSIGNED TO COSTS
			IF @pAppTaskDefinitionCode = 'DocReview' 
			BEGIN
				--ALTER THE ASSIGNEE TO THE CTL
				SELECT @pAssignedTo = UserName FROM dbo.AppUser WITH (NOLOCK) WHERE AppInstanceValue = @AppInsVal AND InActive = 0 AND AppUserRoleCode = 'CTL'
			END		
			ELSE IF @pAppTaskDefinitionCode = 'DocAmend' OR @pAppTaskDefinitionCode = 'Part8Res' OR @pAppTaskDefinitionCode = 'Part8Prep'
			OR @pAppTaskDefinitionCode = 'SwitchTab'
			BEGIN
				--ALTER THE ASSIGNEE TO THE CFE
				SELECT @pAssignedTo = UserName FROM dbo.AppUser WITH (NOLOCK) WHERE AppInstanceValue = @AppInsVal AND InActive = 0 AND AppUserRoleCode = 'CFE'
			END		
			ELSE IF (LEFT(@pDescription, 51) = 'Part 8 (Received) Acknowledgement of Service Due by')
			BEGIN
				--ALTER THE ASSIGNEE TO THE CTA
				SELECT @pAssignedTo = UserName FROM dbo.AppUser WITH (NOLOCK) WHERE AppInstanceValue = @AppInsVal AND InActive = 0 AND AppUserRoleCode = 'CTA'
			END

		END
		--***********GQL TO DEAL WITH COSTS SUPERVISION	
					
		BEGIN TRANSACTION CreatePendingLight
				
		IF (@pAppTaskDefinitionCode <> '')
		BEGIN
				
			IF (@AppInsVal = '') AND (@pCaseID=0)
				RAISERROR(@errNoAppInsCaseID, 16,1)
		
			IF (@pUserName = '') 
				RAISERROR(@errNoUserName, 16,1)
			
			IF ISNULL(@pAppTaskSubTypeCode,'') <> ''
			BEGIN
				SELECT @AppTaskTypeCode = @pAppTaskSubTypeCode 
				
				SELECT @StandardDescription = @pDescription
				FROM dbo.AppTaskDefinition WITH (NOLOCK)
				WHERE (AppTaskDefinitionCode = @pAppTaskDefinitionCode)
			END
			ELSE
			BEGIN
				SELECT @StandardDescription = @pDescription,
				@AppTaskTypeCode = AppTaskTypeCode 
				FROM dbo.AppTaskDefinition WITH (NOLOCK)
				WHERE (AppTaskDefinitionCode = @pAppTaskDefinitionCode)
			END
			
			
			IF (@pDescription = '')
				SET @pDescription = @StandardDescription

			IF (@AppTaskTypeCode = '')
				RAISERROR (@errNoAppTaskDefCode, 16,1)			
		
		
			IF (ISNULL(@pAssignedTo, '') = '')
				SET @pAssignedTo = @pUserName
			
			IF (@pDueDate IS NULL)
				SET @pDueDate = GETDATE()			
					
			IF ISNULL(@pRoleCode, '') LIKE 'FE%'
					BEGIN
						SELECT @pRoleCode = 'FES,FEJ'
					END
					
			
			INSERT INTO AppTask
				   (AppTaskDefinitionCode,
					AppInstanceValue,
					[Description],
					CreatedBy,
					CreatedDate,
					AssignedTo,
					DueDate,
					ReminderDate,
					AppTaskTypeCode,
					StatusCode,
					ContactID,
					DocumentID,
					KeyDateID,
					AppTaskSubTypeCode,
					PriorityCode,
					Referencial_Code,
					AppTask_DateModified,
					RoleCode)
			 VALUES
				   (@pAppTaskDefinitionCode,
					@AppInsVal,
					@pDescription,
					@pUserName,
					GETDATE(),
					@pAssignedTo,
					@pDueDate,
					@pReminderDate,				
					@AppTaskTypeCode,
					'Active',
					@pCaseContactID,
					@pDocumentID,
					@pKeyDateID,
					@pAppTaskSubTypeCode,
					@pPriorityCode,
					@pReferencialCode,
					GETDATE(),
					@pRoleCode)
			
			SET @AppTaskID	= SCOPE_IDENTITY()		
			
			
			INSERT INTO AppTaskSchedule
				(ScheduleDefinitionName,
					AppTaskID,
					Ordinal,
					OccurrenceCounter,
					StatusCode,
					ScheduleDate,
					CategoryCode,
					CaseKeyDateCode,
					Value,
					Unit,
					Occurrence,
					OccurrenceValue,
					OccurrenceUnit,
					Urgent,
					TargetUserRoleCode,
					EmailRecipientRoleCode,
					SendEmail,
					Reassign,
					AllowCancel)
				SELECT 
					SD.Name,
					@AppTaskID,
					SD.Ordinal,
					0,
					'Active',
					@pDueDate,
					CategoryCode,
					CaseKeyDateCode,
					Value,
					Unit,
					Occurrence,
					OccurrenceValue,
					OccurrenceUnit,
					Urgent,
					TargetUserRoleCode,
					EmailRecipientRoleCode,
					SendEmail,
					Reassign,
					AllowCancel
				FROM dbo.AppDefinitionSchedule SDInCTD WITH (NOLOCK)
				INNER JOIN dbo.ScheduleDefinition SD WITH (NOLOCK) ON (SD.Name = SDInCTD.ScheduleDefinitionName)
				WHERE (SDInCTD.AppTaskDefinitionCode = @pAppTaskDefinitionCode)
				
				SET @AppTaskScheduleID = SCOPE_IDENTITY()			
										
			
		END

		COMMIT TRANSACTION CreatePendingLight
		
		SELECT @AppTaskID AS AppTaskID, 0 as TaskExists
		
	END TRY
	
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION CreatePendingLight
			
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH	


