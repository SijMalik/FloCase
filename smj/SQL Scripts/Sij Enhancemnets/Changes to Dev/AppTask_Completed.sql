USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[AppTask_Completed]    Script Date: 09/24/2012 12:51:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[AppTask_Completed]
(
	@pCaseId INT = 0, --MANDATORY
	@pUsername VARCHAR(255) = '', --MANDATORY
	@pAppTaskDefinitionCode VARCHAR(50) = '',--MANDATORY
	@pAppTaskSubTypeCode  VARCHAR(50) = '',
	@pCompletedBy  VARCHAR(255) = '', --MANDATORY
	@pCompletedDate SMALLDATETIME = NULL, --MANDATORY
	@pDescription  VARCHAR(255) = '',
	@pCreatedBy  VARCHAR(50) = '',
	@pAssignedTo  VARCHAR(50) = '',
	@pPriorityCode  VARCHAR(10) = ''
)
	--============================================================
	-- Created By: SMJ
	-- Created Date: 05/12/2011
	-- Description: Marks all tasks that match Case ID/AppTaskDef Code as Complete
	-- Release: 5.11a
	--============================================================

AS
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 05-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================
	SET NOCOUNT ON
	
	DECLARE @errNoCaseID VARCHAR(50)
	DECLARE @errNoUserName VARCHAR(50)
	DECLARE @errNoAppTaskDef VARCHAR(50)
	DECLARE @errNoCompletedBy VARCHAR(50)
	DECLARE @errNoCompletedDate VARCHAR(50)
	DECLARE @AppInsVal VARCHAR(50)
	
	SET @errNoCaseID = 'Please enter a Case ID.'
	SET @errNoUserName = 'Please enter a User Name.'
	SET @errNoAppTaskDef = 'Please enter AppTaskDefinition Code.'
	SET @errNoCompletedBy = 'Please enter Completed By.'
	SET @errNoCompletedDate = 'Please enter the Completed Date.'
	
	--GET THE APP INSTANCE VALUE TO SAVE DOING A JOIN LATER
	SELECT	@AppInsVal = IdentifierValue
	FROM	dbo.ApplicationInstance WITH (NOLOCK)
	WHERE	CaseID = @pCaseId
	
	BEGIN TRY
		--Error Checking
		IF @pCaseID = 0
			RAISERROR(@errNoCaseID, 16, 1)

		IF @pUsername = ''
			RAISERROR(@errNoUserName, 16, 1)			

		IF @pAppTaskDefinitionCode = ''
			RAISERROR(@errNoAppTaskDef, 16, 1)			
			
		IF @pCompletedBy = ''
			RAISERROR(@errNoCompletedBy, 16, 1)			

		IF @pCompletedDate = NULL
			RAISERROR(@errNoCompletedDate, 16, 1)			
		----
		
		--SET TASK TO COMPLETE
		UPDATE	dbo.AppTask
		SET		CompletedBy		= @pCompletedBy,
				CompletedDate	= @pCompletedDate,
				StatusCode		= 'Complete',
				[Description]	= CASE WHEN @pDescription = '' THEN [Description] ELSE @pDescription END,
				CreatedBy		= CASE WHEN @pCreatedBy = '' THEN @pCompletedBy ELSE @pCreatedBy END,
				AssignedTo      = CASE WHEN @pAssignedTo = '' THEN @pCompletedBy ELSE @pAssignedTo END,
				AppTask_DateModified = GETDATE()
		WHERE AppInstanceValue = @AppInsVal
		AND AppTaskDefinitionCode = @pAppTaskDefinitionCode
		AND AppTaskSubTypeCode = CASE WHEN @pAppTaskSubTypeCode = '' THEN AppTaskSubTypeCode ELSE @pAppTaskSubTypeCode END
		AND CreatedBy = CASE WHEN @pCreatedBy = '' THEN CreatedBy ELSE @pCreatedBy END
		AND AssignedTo = CASE WHEN @pAssignedTo = '' THEN AssignedTo ELSE @pAssignedTo END 
		AND PriorityCode = CASE WHEN @pPriorityCode = '' THEN PriorityCode ELSE @pPriorityCode END
		----
		
		--REMOVE ALL ESCALATIONS CONNECTED TO THE COMPLETED TASK
		IF EXISTS (SELECT EscAppTaskID FROM dbo.AppTask WITH (NOLOCK) WHERE AppInstanceValue = @AppInsVal)
		BEGIN
			UPDATE	dbo.AppTask
			SET		CompletedBy		= @pCompletedBy,
					CompletedDate	= @pCompletedDate,
					StatusCode		= 'Complete',
					[Description]	= CASE WHEN @pDescription = '' THEN [Description] ELSE @pDescription END,
					CreatedBy		= CASE WHEN @pCreatedBy = '' THEN @pCompletedBy ELSE @pCreatedBy END,
					AssignedTo      = CASE WHEN @pAssignedTo = '' THEN @pCompletedBy ELSE @pAssignedTo END,
					AppTask_DateModified = GETDATE()
			WHERE	AppTaskID IN (
									SELECT	EscAppTaskID 
									FROM	dbo.AppTask WITH (NOLOCK)
									WHERE AppInstanceValue = @AppInsVal
									AND EscAppTaskID <> 0
								  )
		END	
		----								
	END TRY	
	
	BEGIN CATCH
		SELECT ERROR_MESSAGE() + ' SP:' + OBJECT_NAME(@@PROCID)
	END CATCH
