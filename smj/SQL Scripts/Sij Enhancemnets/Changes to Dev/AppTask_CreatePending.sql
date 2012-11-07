USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[AppTask_CreatePending]    Script Date: 09/24/2012 12:52:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







ALTER  PROC [dbo].[AppTask_CreatePending] 
(
	@AppTaskID				int = 0,
	@UserName				nvarchar(255)  = '',		-- Manditory
	@AppTaskDefinitionCode	nvarchar(50)  = '',			-- Manditory.  Map System.Username for Current User
	@AppInstanceValue		nvarchar(50)  = '',			-- Manditory unless @CaseID used. 
	@CaseID					int = 0,					-- Manditory unless @AppInstanceValue used.
	@CreatedBy				nvarchar(255)  = '',		-- Manditory. Use System.UserName
	@Description			nvarchar(255)  = '',		-- Optional. If empty, Definition Description will be used.
	@Location				nvarchar(255)  = '',		-- Optional. If empty, Definition Description will be used.
	@AssignedTo				nvarchar(255)  = '',		-- Optional. If empty, CreatedBy will be used.	
	@DueDate				smalldatetime = NULL,		-- Optional. If empty, ScheduleDefinition or Now will be used.
	@ReminderDate			smalldatetime = NULL,		-- Optional. If empty, ScheduleDefinition or Now will be used.
	@CaseContactID			int = 0,					-- Optional
	@DocumentID				int = 0,					-- Optional
	@CustomID1				int = 0,					-- Optional
	@CustomID2				int = 0,					-- Optional
	@CustomID3				int = 0,					-- Optional
	@CustomID4				int = 0,					-- Optional
	@CustomID5				int = 0,					-- Optional
	@pAppTaskSubTypeCode	nvarchar(50) = '',
	@pComment				nvarchar(max) = '',
	@pPriorityCode			nvarchar(10)  = '',
	@KeyDateID				int = 0,
	@StartScheduleDate		datetime  = NULL,			-- Optional.
	@EndScheduleDate		datetime  = NULL,			-- Optional.
	@Outlook_GUID			nVARCHAR(256)   = '',		-- Optional.
	@pEscdate				smalldatetime = NULL,		-- Optional.
	@pEscUser				nvarchar(255) = '',			-- Optional.
	@pEscAppTaskID			int = 0,					-- Optional.
	@pEscTaskText			nvarchar(255) = '',
	@pHistoricalTaskDesc	nvarchar(255) = '',
	@pOutlookTaskOption     nvarchar(10) = '',
	@pPersonAttending		nvarchar(255) = '',
	@pAttDate				smalldatetime = NULL,
	@pAttTime				nvarchar(255)  = '',
	@pNatureAttendance		nvarchar(255) = '',
	@pMatterPaymentsCode	nvarchar(255) = '',
	@pReferencialCode		nvarchar(255) = '',		-- GV 11/08/2011: to deal with link to other tables (GENERIC compared to @pMatterPaymentsCode)
	@pAppTaskDateModified	SMALLDATETIME = NULL,	-- SMJ - 21/09/2011: SET TO TODAY (GETDATE())
	@pcheckExists			BIT = 0,				-- RPM
	@pcheckExistsAll		bit = 0,				-- GV 
	@pReturnID				bit = 1,				-- GV 18/04/2012: added to return the AppTaskID or not
	@pRoleCode				nvarchar(10) = ''
) 

	-- ==========================================================================================
	-- SMJ - Amended - 14-07-2011
	-- New column MatterPayments_Code added to AppTask table
	-- Changed SP to take in this parameter and use it in insert
	-- ==========================================================================================
	
	-- ==========================================================================================
	-- SMJ - Amended - 21-09-2011
	-- New column AppTask_DateModified to AppTask table
	-- Changed SP to take in this parameter and use it in insert
	-- ==========================================================================================
	

	-- ==========================================================================================
	-- SMJ - Amended - 08-11-2011
	-- Check whether task already exists before creating new pending task
	-- ==========================================================================================	

	-- ==========================================================================================
	-- SMJ - Amended - 22-03-2012
	-- Check if no EscUser - In which case get TeamLeader
	-- ==========================================================================================				
		
AS

	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 05-09-2012
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
  	
  	SET @errNoAppInsCaseID = 'No @AppInstanceValue and @CaseID passed in.'  	  	
  	SET @errCTL = 'User is the Team Leader on the case.'
  	SET @errNoCreatedBy = 'No @CreatedBy passed in.'
  	SET @errNoAppTaskDefCode = 'No @AppTaskDefinitionCode passed in.'
  	
	BEGIN TRY

		--Check if task already exists
		--=========================================
		IF (@pcheckExists = 1)
		BEGIN
			
			
			EXEC	LTMM_AppTask_Exists_Internal
					@pCaseID = @CaseID ,
					@pAppTaskDefinitionCode = @AppTaskDefinitionCode ,
					@pCheckAll = @pcheckExistsAll,
					@TaskExists = @TaskExists OUTPUT									
										
			--If the task exists then leave SP
			IF @TaskExists = 1
			BEGIN
				SELECT @TaskExists AS TaskExists
				RETURN				
			END
									
		END
		--==============================================

		SET @CreatedDate = GETDATE()
		
		SELECT @pAppTaskDateModified = ISNULL(@pAppTaskDateModified,GETDATE())
			
		--***********GQL TO DEAL WITH COSTS SUPERVISION
		--DO NOT SCHEDULE SUPERVISION TASK IF USER CREATING IS A CTL ON THE CASE
		IF  EXISTS(SELECT 1 FROM dbo.AppUser WITH (NOLOCK) WHERE UserName = @CreatedBy  AND AppUserRoleCode = 'CTL') AND @AppTaskDefinitionCode = 'DocReview' AND EXISTS(SELECT * FROM CaseKeyDates WHERE CaseKeyDates_KeyDatesCode = 'CostAssDte' AND CaseKeyDates_Inactive = 0 AND CaseKeyDates_CaseID = @CASEID) 
			RAISERROR(@errCTL, 16, 1)
		
		IF ISNULL(@AppInstanceValue, '') = ''
			SELECT @AppInstanceValue = IdentifierValue FROM dbo.ApplicationInstance WITH (NOLOCK) WHERE CaseID = @CaseID 

		--IF WE ARE SCHEDULING A DOCUMENT REVIEW AND THE MATTER HAS BEEN ASSIGNED TO COSTS
		IF @AppTaskDefinitionCode = 'DocReview' AND EXISTS(SELECT 1 FROM dbo.CaseKeyDates WITH (NOLOCK) WHERE CaseKeyDates_KeyDatesCode = 'CostAssDte' AND CaseKeyDates_Inactive = 0 AND CaseKeyDates_CaseID = @CASEID) 
			SELECT @AssignedTo = UserName FROM dbo.AppUser WITH (NOLOCK) WHERE AppInstanceValue = @AppInstanceValue AND InActive = 0 AND AppUserRoleCode = 'CTL'
		
		IF @AppTaskDefinitionCode = 'DocAmend' AND EXISTS(SELECT 1 FROM dbo.CaseKeyDates WITH (NOLOCK) WHERE CaseKeyDates_KeyDatesCode = 'CostAssDte' AND CaseKeyDates_Inactive = 0 AND CaseKeyDates_CaseID = @CASEID)
			SELECT @AssignedTo = UserName FROM dbo.AppUser WITH (NOLOCK) WHERE AppInstanceValue = @AppInstanceValue AND InActive = 0 AND AppUserRoleCode = 'CFE'	

		IF (LEFT(@Description, 51) = 'Part 8 (Received) Acknowledgement of Service Due by') AND EXISTS(SELECT 1 FROM dbo.CaseKeyDates WITH (NOLOCK) WHERE CaseKeyDates_KeyDatesCode = 'CostAssDte' AND CaseKeyDates_Inactive = 0 AND CaseKeyDates_CaseID = @CASEID)
			SELECT @AssignedTo = UserName FROM dbo.AppUser WITH (NOLOCK) WHERE AppInstanceValue = @AppInstanceValue AND InActive = 0 AND AppUserRoleCode = 'CTA'
		
		IF @AppTaskDefinitionCode = 'Part8Res' AND EXISTS(SELECT 1 FROM dbo.CaseKeyDates WITH (NOLOCK) WHERE CaseKeyDates_KeyDatesCode = 'CostAssDte' AND CaseKeyDates_Inactive = 0 AND CaseKeyDates_CaseID = @CASEID)
			SELECT @AssignedTo = UserName FROM dbo.AppUser WITH (NOLOCK) WHERE AppInstanceValue = @AppInstanceValue AND InActive = 0 AND AppUserRoleCode = 'CFE'
		
		IF @AppTaskDefinitionCode = 'Part8Prep' AND EXISTS(SELECT 1 FROM dbo.CaseKeyDates WITH (NOLOCK) WHERE CaseKeyDates_KeyDatesCode = 'CostAssDte' AND CaseKeyDates_Inactive = 0 AND CaseKeyDates_CaseID = @CASEID)
			SELECT @AssignedTo = UserName FROM dbo.AppUser WITH (NOLOCK) WHERE AppInstanceValue = @AppInstanceValue AND InActive = 0 AND AppUserRoleCode = 'CFE'
		
		IF @AppTaskDefinitionCode = 'SwitchTab' AND EXISTS(SELECT 1 FROM dbo.CaseKeyDates WITH (NOLOCK) WHERE CaseKeyDates_KeyDatesCode = 'CostAssDte' AND CaseKeyDates_Inactive = 0 AND CaseKeyDates_CaseID = @CASEID)
			SELECT @AssignedTo = UserName FROM dbo.AppUser WITH (NOLOCK) WHERE AppInstanceValue = @AppInstanceValue AND InActive = 0 AND AppUserRoleCode = 'CFE'

		
		--***********GQL TO DEAL WITH COSTS SUPERVISION	
					
		BEGIN TRANSACTION CreatePending
				
		IF (@AppTaskDefinitionCode <> '')
		BEGIN
				
			IF (@AppInstanceValue = '') AND (@CaseID=0)
				RAISERROR(@errNoAppInsCaseID, 16, 1)
		
			IF (@CreatedBy = '') 
				RAISERROR(@errNoCreatedBy, 16, 1)

			IF ISNULL(@pAppTaskSubTypeCode,'') <> ''
			BEGIN
				SET @AppTaskTypeCode = @pAppTaskSubTypeCode 
								
				SELECT	@StandardDescription = @Description
				FROM	dbo.AppTaskDefinition WITH (NOLOCK)
				WHERE	AppTaskDefinitionCode = @AppTaskDefinitionCode
			END
			ELSE
			BEGIN
				SELECT	@StandardDescription = @Description,
						@AppTaskTypeCode = AppTaskTypeCode 
				FROM	dbo.AppTaskDefinition WITH (NOLOCK)
				WHERE	AppTaskDefinitionCode = @AppTaskDefinitionCode
			END
			
			
			IF @Description = ''
				SET @Description = @StandardDescription

			IF @AppTaskTypeCode = ''
				RAISERROR (@errNoAppTaskDefCode, 16, 1)
			
			IF ISNULL(@AssignedTo, '') = ''
				SET @AssignedTo = @CreatedBy
			
			IF @DueDate IS NULL
				SET @DueDate = GETDATE()			
			
			IF 	(ISNULL(@AppInstanceValue,'') = '')
			BEGIN
				SELECT	@AppInstanceValue = IdentifierValue
				FROM	dbo.ApplicationInstance WITH (NOLOCK)
				WHERE   CaseID = @CaseID
			END
			
			--*******SMJ - 22/03/2012*******
			--Check if no EscUser - In which case get TeamLeader
			IF (@pEscdate IS NOT NULL) AND @pEscUser = ''
			BEGIN
				SELECT DISTINCT @pEscUser = tl.UserName
				FROM dbo.ApplicationInstance  ai WITH (NOLOCK)
				INNER JOIN	AppTask at WITH (NOLOCK)
				ON ai.IdentifierValue = at.AppInstanceValue 
				INNER JOIN	AppUser tl WITH (NOLOCK)
				ON tl.AppInstanceValue = ai.IdentifierValue 
				AND tl.AppUserRoleCode = 'TL' 
				AND tl.InActive=0	
				AND ai.IdentifierValue = @AppInstanceValue
			END
			
			IF ISNULL(@pRoleCode, '') LIKE 'FE%'
				SELECT @pRoleCode = 'FES,FEJ'
	
			INSERT INTO dbo.AppTask
				   (AppTaskDefinitionCode,
					AppInstanceValue,
					[Description],
					Location,
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
					CustomID1,
					CustomID2,
					CustomID3,
					CustomID4,
					CustomID5,
					AppTaskSubTypeCode,
					Comment,
					PriorityCode,
					EscDate,
					EscUser,
					EscAppTaskID,
					EscTaskText,
					HistoricalTaskDesc,
					OutlookTaskOption,
					PersonAttending,
					AttDate,
					AttTime,
					NatureAttendance,
					MatterPayments_Code,
					Referencial_Code,
					AppTask_DateModified,
					RoleCode)
			 VALUES
				   (@AppTaskDefinitionCode,
					@AppInstanceValue,
					@Description,
					@Location,
					@CreatedBy,
					@CreatedDate,
					@AssignedTo,
					@DueDate,
					@ReminderDate,				
					@AppTaskTypeCode,
					'Active',
					@CaseContactID,
					@DocumentID,
					@KeyDateID,
					@CustomID1,
					@CustomID2,
					@CustomID3,
					@CustomID4,
					@CustomID5,
					@pAppTaskSubTypeCode,
					@pComment,
					@pPriorityCode,
					@pEscDate,
					@pEscUser,
					@pEscAppTaskID,
					@pEscTaskText,
					@pHistoricalTaskDesc,
					@pOutlookTaskOption,
					@pPersonAttending,
					@pAttDate,
					@pAttTime,
					@pNatureAttendance,
					@pMatterPaymentsCode,
					@pReferencialCode,
					@pAppTaskDateModified,
					@pRoleCode)
			
			SET @AppTaskID	= SCOPE_IDENTITY()		
						
			INSERT INTO dbo.AppTaskSchedule
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
					@DueDate,
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
				FROM AppDefinitionSchedule SDInCTD WITH (NOLOCK)
				INNER JOIN ScheduleDefinition SD WITH (NOLOCK)
				ON SD.Name = SDInCTD.ScheduleDefinitionName
				WHERE SDInCTD.AppTaskDefinitionCode = @AppTaskDefinitionCode
				
				SET @AppTaskScheduleID = SCOPE_IDENTITY()
							
				UPDATE	dbo.AppTaskSchedule
				SET		Outlook_GUID = @Outlook_GUID,
						EndScheduleDate = @EndScheduleDate,
						StartScheduleDate = @StartScheduleDate
				WHERE	AppTaskScheduleID = @AppTaskScheduleID						
					
		END

		COMMIT TRANSACTION CreatePending
	
		IF @pReturnID = 1
			SELECT @AppTaskID AS AppTaskID
	END TRY			

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION CreatePending
			
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH
		





