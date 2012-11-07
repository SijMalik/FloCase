USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[LTMM_ClientRuleSet_Check_AckOfInstructions]    Script Date: 09/24/2012 17:39:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[LTMM_ClientRuleSet_Check_AckOfInstructions]
(
	@pCaseID int = 0,	
	@pUserName VARCHAR(255) = ''
)	
AS 

	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================	
	SET NOCOUNT ON
	DECLARE @ruleValue  nvarchar(max)
	DECLARE @taskDescription nvarchar(255)
	DECLARE @clientName nvarchar(255)
	DECLARE @RemDate datetime
	DECLARE @DueDate datetime
	DECLARE @EscDate datetime
	DECLARE @ReSched datetime
	DECLARE @today datetime	
	DECLARE @TACode nvarchar(255)
	DECLARE @FECode nvarchar(255)
	DECLARE @TLCode nvarchar(255)	
	DECLARE @errNoUserName VARCHAR(50)
	DECLARE @errNoCaseID VARCHAR(50)


	SET @errNoUserName = 'YOU MUST PROVIDE A @pUserName.'
	SET @errNoCaseID = 'YOU MUST PROVIDE A @pCaseID.'

	BEGIN TRY
		--ERROR TEST 
		IF (@pCaseID = 0)
			RAISERROR (@errNoCaseID, 16, 1)
			
		IF (@pUserName = '')
			RAISERROR (@pUserName, 16, 1)
		
		SELECT TOP 1 @TACode = ta.UserName
		FROM dbo.[Case] ca WITH (NOLOCK)
		INNER JOIN dbo.AppUser ta WITH (NOLOCK) ON (ta.AppInstanceValue = ca.Case_BLMREF) AND (ta.AppUserRoleCode = 'TA')  AND (ta.InActive=0)
		WHERE ca.Case_CaseID = @pCaseID
		
		SELECT TOP 1 @FECode = AU.UserName
		FROM dbo.[Case] ca WITH (NOLOCK)
		INNER JOIN dbo.AppUser AU WITH (NOLOCK) ON (AU.AppInstanceValue = ca.Case_BLMREF) 
				AND (AU.AppUserRoleCode = 'FES')  
				AND (AU.InActive=0)
		WHERE ca.Case_CaseID = @pCaseID
		
		SELECT TOP 1 @TLCode = AU.UserName
		FROM dbo.[Case] ca WITH (NOLOCK)
		INNER JOIN dbo.AppUser AU WITH (NOLOCK) ON (AU.AppInstanceValue = ca.Case_BLMREF) 
				AND (AU.AppUserRoleCode = 'TL')  
				AND (AU.InActive=0)
		WHERE ca.Case_CaseID = @pCaseID
		
		SELECT @today = GETDATE()
		
		
		-------CHECK Ack of Instructions required Rule
		SELECT TOP 1 @ruleValue = CRS.ClientRuleSet_Value
		FROM dbo.ClientRuleSet CRS WITH (NOLOCK) INNER JOIN
			 dbo.[Case] WITH (NOLOCK) ON CRS.ClientRuleSet_ClientRuleCode = dbo.[Case].Case_ClientRuleCode
		WHERE (CRS.ClientRuleSet_InActive = 0)  
		AND CRS.ClientRuleSet_ClientRuleDefinitionCode = 'AckInstReq'
		AND [Case].Case_CaseID = @pCaseID
		
		IF @ruleValue = 'Yes'
		BEGIN
			SELECT TOP 1 @ruleValue = LC.Description
			FROM	dbo.ClientRuleSet CRS WITH (NOLOCK) INNER JOIN
					dbo.[Case] WITH (NOLOCK) ON CRS.ClientRuleSet_ClientRuleCode = dbo.[Case].Case_ClientRuleCode LEFT OUTER JOIN
					dbo.LookupCode LC WITH (NOLOCK) ON CRS.ClientRuleSet_Value = LC.Code
			WHERE (CRS.ClientRuleSet_InActive = 0)  AND (LC.Inactive = 0)
			AND CRS.ClientRuleSet_ClientRuleDefinitionCode = 'AckInstMeth'
			AND [Case].Case_CaseID = @pCaseID		

			SET @taskDescription = 
				CASE @ruleValue 
				WHEN 'Letter'
				THEN 'Reminder: ' + REPLACE(ISNULL(@ruleValue,''),'Letter','Send letter') + ' to Acknowledge Instructions'
				WHEN 'Email'
				THEN 'Reminder: ' + REPLACE(ISNULL(@ruleValue,''),'Email','Send email') + ' to Acknowledge Instructions'			
				WHEN 'Phone'
				THEN 'Reminder: ' + REPLACE(ISNULL(@ruleValue,''),'Phone','Phone') + ' to Acknowledge Instructions'
				ELSE 'Reminder: ' + REPLACE(ISNULL(@ruleValue,''),'Letter','Send letter') + ' to Acknowledge Instructions'
				END



			SET @taskDescription = 'Reminder: ' + REPLACE(ISNULL(@ruleValue,''),'Letter','Send letter') + ' to Acknowledge Instructions'
				
			SELECT @RemDate = ISNULL(RemDate,@today), @DueDate = ISNULL(DueDate,@today), @EscDate = ISNULL(EscDate,@today), @ReSched = ISNULL(ReSched,@today)
			FROM [dbo].ClientRuleSet_Date_Fetch(@pCaseID,'AckInst',null)
			
		--RPM 31/5/12
			EXEC	[AppTask_CreatePending]
			@UserName = @pUserName,
			@AppTaskDefinitionCode = N'FileOpenDo',		
			@CaseID = @pCaseID,
			@CreatedBy = @pUserName,
			@Description = @taskDescription,
			@AssignedTo = @TACode,
			@DueDate = @DueDate,
			@ReminderDate = @RemDate,
			@pAppTaskSubTypeCode = N'FileOpen',
			@pPriorityCode = N'High',
			@StartScheduleDate = @today,
			@EndScheduleDate = @DueDate,
			@pEscdate = @EscDate,
			@pReferencialCode = @ruleValue,
			@pcheckExists = 1,
			@pcheckExistsAll = 1,
			@pRoleCode = 'TA'
		END

		-------CHECK seperate initial reserve task required Rule
		SELECT TOP 1 @ruleValue = CRS.ClientRuleSet_Value
		FROM dbo.ClientRuleSet AS CRS INNER JOIN
			 dbo.[Case] ON CRS.ClientRuleSet_ClientRuleCode = dbo.[Case].Case_ClientRuleCode
		WHERE (CRS.ClientRuleSet_InActive = 0)  
		AND CRS.ClientRuleSet_ClientRuleDefinitionCode = 'AckInstSepInitialResTaskReq'
		AND [Case].Case_CaseID = @pCaseID
		
		IF @ruleValue = 'Yes'
		BEGIN		
	 
			SET @taskDescription = 'Reminder: Create reserve form'
			
			DECLARE @docCodes nvarchar(max)
			SELECT TOP 1 @docCodes = CRS.ClientRuleSet_Value
			FROM dbo.ClientRuleSet CRS WITH (NOLOCK) INNER JOIN
				 dbo.[Case] WITH (NOLOCK) ON CRS.ClientRuleSet_ClientRuleCode = dbo.[Case].Case_ClientRuleCode
			WHERE (CRS.ClientRuleSet_InActive = 0)  
			AND CRS.ClientRuleSet_ClientRuleDefinitionCode = 'AckInstSepInitialResTaskReqDoc'
			AND [Case].Case_CaseID = @pCaseID
			
			SELECT @RemDate = ISNULL(RemDate,@today), @DueDate = ISNULL(DueDate,@today), @EscDate = ISNULL(EscDate,@today), @ReSched = ISNULL(ReSched,@today)
			FROM [dbo].ClientRuleSet_Date_Fetch(@pCaseID,'AckInstSepInitialResTaskReq',null)
		
		 -- create pending task 'AckInstructions'
			EXEC	[AppTask_CreatePending]
			@UserName = @pUserName,
			@AppTaskDefinitionCode = N'PendDoc',		
			@CaseID = @pCaseID,
			@CreatedBy = @pUserName,
			@Description = @taskDescription,
			@AssignedTo = @FECode,
			@DueDate = @DueDate,
			@ReminderDate = @RemDate,
			@pAppTaskSubTypeCode = N'Reminder',
			@pHistoricalTaskDesc = 'AckInstSepInitialResTaskReqDoc',
			@pPriorityCode = N'High',
			@StartScheduleDate = @today,
			@EndScheduleDate = @DueDate,
			@pEscdate = @EscDate,
			@pReferencialCode = @docCodes,
			@pcheckExists = 1,
			@pcheckExistsAll = 1,
			@pRoleCode = 'FES,FEJ'
		END

	END TRY

	BEGIN CATCH		
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH



