USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[LTMM_ClientRuleSet_Check_ActionPlan]    Script Date: 09/24/2012 17:48:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[LTMM_ClientRuleSet_Check_ActionPlan]
(
	@pCaseID int = 0,	
	@pUserName VARCHAR(255) = ''
)	
AS 
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
			
		SELECT @TACode = ta.UserName
		FROM dbo.[Case] ca WITH (NOLOCK) 
		INNER JOIN dbo.AppUser ta WITH (NOLOCK) ON (ta.AppInstanceValue = ca.Case_BLMREF) AND (ta.AppUserRoleCode = 'TA')  AND (ta.InActive=0)
		WHERE ca.Case_CaseID = @pCaseID
		
		SELECT @FECode = AU.UserName
		FROM dbo.[Case] ca WITH (NOLOCK) 
		INNER JOIN dbo.AppUser AU WITH (NOLOCK) ON (AU.AppInstanceValue = ca.Case_BLMREF) 
				AND (AU.AppUserRoleCode = 'FES')  
				AND (AU.InActive=0)
		WHERE ca.Case_CaseID = @pCaseID
		
		SELECT @today = GETDATE()
		
		-------CHECK Action plan required rule
		SELECT TOP 1 @ruleValue = CRS.ClientRuleSet_Value
		FROM dbo.ClientRuleSet CRS WITH (NOLOCK) INNER JOIN
			 dbo.[Case] WITH (NOLOCK) ON CRS.ClientRuleSet_ClientRuleCode = dbo.[Case].Case_ClientRuleCode
		WHERE (CRS.ClientRuleSet_InActive = 0)  
		AND CRS.ClientRuleSet_ClientRuleDefinitionCode = 'ActPlanReq'
		AND [Case].Case_CaseID = @pCaseID
			
		IF @ruleValue = 'Yes'
		BEGIN		
			SET @taskDescription = 'Reminder: Complete Action Plan'
			
			DECLARE @docCodes nvarchar(max)
			SELECT TOP 1 @docCodes = CRS.ClientRuleSet_Value
			FROM dbo.ClientRuleSet CRS WITH (NOLOCK) INNER JOIN
				 dbo.[Case] WITH (NOLOCK) ON CRS.ClientRuleSet_ClientRuleCode = dbo.[Case].Case_ClientRuleCode
			WHERE (CRS.ClientRuleSet_InActive = 0)  
			AND CRS.ClientRuleSet_ClientRuleDefinitionCode = 'ActPlanDoc'
			AND [Case].Case_CaseID = @pCaseID
			
			SELECT @RemDate = ISNULL(RemDate,@today), @DueDate = ISNULL(DueDate,@today), @EscDate = ISNULL(EscDate,@today), @ReSched = ISNULL(ReSched,@today)
			FROM [dbo].ClientRuleSet_Date_Fetch(@pCaseID,'ActPlanReq',null)

		 -- create pending task 'AckInstructions'
			EXEC	[AppTask_CreatePending]
			@UserName = @pUserName,
			@AppTaskDefinitionCode = N'ActPlan',		
			@CaseID = @pCaseID,
			@CreatedBy = @pUserName,
			@Description = @taskDescription,
			@AssignedTo = @FECode,
			@DueDate = @DueDate,
			@ReminderDate = @RemDate,
			@pAppTaskSubTypeCode = N'Reminder',		
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
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME(@@PROCID)
	END CATCH

	




