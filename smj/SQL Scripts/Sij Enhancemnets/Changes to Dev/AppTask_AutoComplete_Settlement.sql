USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[AppTask_AutoComplete_Settlement]    Script Date: 09/24/2012 12:48:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[AppTask_AutoComplete_Settlement]
(
	@pCaseId INT = 0, --MANDATORY
	@pUsername VARCHAR(255) = '', --MANDATORY
	@pAppTaskTypeCode  VARCHAR(50) = ''
)
	--============================================================
	-- Created By: SMJ
	-- Created Date: 01/05/2012
	-- Description: Marks tasks as Complete. 
	--				Pass in AppTaskTypeCode to mark ALL those types as COMPLETE
	-- Release: 5.15
	--============================================================
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 05-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================	

AS

	SET NOCOUNT ON
	
	DECLARE @errNoCaseID VARCHAR(50)
	DECLARE @errNoUserName VARCHAR(50)
	DECLARE @errNoAppTaskCode VARCHAR(50)
	DECLARE @AppInsVal VARCHAR(50) = ''
	
	SET @errNoCaseID = 'Please enter a Case ID.'
	SET @errNoUserName = 'Please enter a User Name.'
	SET @errNoAppTaskCode = 'AppTaskTypeCode entered was not found.'

	BEGIN TRY
		--Error Checking
		IF @pCaseID = 0
			RAISERROR(@errNoCaseID,16,1)
			
		IF @pUsername = ''
			RAISERROR(@errNoUserName,16,1)	
	
		--GET THE APP INSTANCE VALUE TO SAVE DOING A JOIN LATER
		SELECT @AppInsVal = IdentifierValue
		FROM dbo.ApplicationInstance WITH (NOLOCK)
		WHERE CaseID = @pCaseId					
		
		--CHECK THE APPTASKTYPECODE EXISTS -IF PASSED IN
		IF NOT EXISTS (SELECT 1 FROM dbo.AppTaskType WITH (NOLOCK)
						WHERE  (AppTaskTypeCode = @pAppTaskTypeCode)
						OR (@pAppTaskTypeCode = '')
						)
			RAISERROR (@errNoAppTaskCode,16,1)

		--SET TASK TO COMPLETE - MARKS AS COMPLETE ALL RECORDS WITH THAT APPTASKTYPECODE
		UPDATE dbo.AppTask
		SET 
			CompletedBy		= @pUsername,
			CompletedDate	= GETDATE(),
			StatusCode		= 'Completed',
			[Description]	= 'Completed due to settlement ' + [Description] 
		FROM dbo.AppTask			
		WHERE AppInstanceValue = @AppInsVal
		AND StatusCode = 'Active'
		AND AppTaskTypeCode = @pAppTaskTypeCode

		----OTHERS TO MARK COMPLETE:		
		--Notice of Acting to be Filed?
		UPDATE dbo.AppTask
		SET 
			CompletedBy		= @pUsername,
			CompletedDate	= GETDATE(),
			StatusCode		= 'Completed',
			[Description]	= 'Completed due to settlement ' + [Description] 
		FROM dbo.AppTask			
		WHERE AppInstanceValue = @AppInsVal
		AND StatusCode = 'Active'
		AND [Description] LIKE '%Notice%Acting%' --Not 100% sure about this one]
					
		--Serve LOD's
		UPDATE dbo.AppTask
		SET 
			CompletedBy		= @pUsername,
			CompletedDate	= GETDATE(),
			StatusCode		= 'Completed',
			[Description]	= 'Completed due to settlement ' + [Description] 
		FROM dbo.AppTask			
		WHERE AppInstanceValue = @AppInsVal
		AND StatusCode = 'Active'
		AND [Description] LIKE '%Serve list of documents%' -- None in DEV		]
		--
		
		--Produce LOD's
		UPDATE dbo.AppTask
		SET 
			CompletedBy		= @pUsername,
			CompletedDate	= GETDATE(),
			StatusCode		= 'Completed',
			[Description]	= 'Completed due to settlement ' + [Description] 
		FROM dbo.AppTask			
		WHERE AppInstanceValue = @AppInsVal
		AND StatusCode = 'Active'
		AND [Description] LIKE '%Produce list of documents%'	
				
		--Details of proceedings
		UPDATE dbo.AppTask
		SET 
			CompletedBy		= @pUsername,
			CompletedDate	= GETDATE(),
			StatusCode		= 'Completed',
			[Description]	= 'Completed due to settlement ' + [Description] 
		FROM dbo.AppTask			
		WHERE AppInstanceValue = @AppInsVal
		AND StatusCode = 'Active'
		AND AppTaskTypeCode = 'Defence'	
		AND [Description] LIKE '%Details of proceedings%'
		--

		--Defence Due Dates
		UPDATE dbo.AppTask
		SET 
			CompletedBy		= @pUsername,
			CompletedDate	= GETDATE(),
			StatusCode		= 'Completed',
			[Description]	= 'Completed due to settlement ' + [Description] 
		FROM dbo.AppTask			
		WHERE AppInstanceValue = @AppInsVal
		AND StatusCode = 'Active'
		AND AppTaskTypeCode = 'KeyDate'	
		AND [Description] LIKE '%Defence Due%'
		--

		--Date Judgement Entered
		UPDATE dbo.AppTask
		SET 
			CompletedBy		= @pUsername,
			CompletedDate	= GETDATE(),
			StatusCode		= 'Completed',
			[Description]	= 'Completed due to settlement ' + [Description] 
		FROM dbo.AppTask			
		WHERE AppInstanceValue = @AppInsVal
		AND StatusCode = 'Active'
		AND [Description] LIKE '%Date Judgment Entered%'
		--

		--Send Claimant Allocation
		UPDATE dbo.AppTask
		SET 
			CompletedBy		= @pUsername,
			CompletedDate	= GETDATE(),
			StatusCode		= 'Completed',
			[Description]	= 'Completed due to settlement ' + [Description] 
		FROM dbo.AppTask			
		WHERE AppInstanceValue = @AppInsVal
		AND StatusCode = 'Active'
		AND [Description] LIKE '%Send claimant allocation%'
 
		--Limitation Periods
		UPDATE dbo.AppTask
		SET 
			CompletedBy		= @pUsername,
			CompletedDate	= GETDATE(),
			StatusCode		= 'Completed',
			[Description]	= 'Completed due to settlement ' + [Description] 
		FROM dbo.AppTask			
		WHERE AppInstanceValue = @AppInsVal
		AND StatusCode = 'Active'
		AND AppTaskTypeCode = 'KeyDate'	
		AND [Description] LIKE '%Limitation period%'
		--
		
		--AQ received...
		UPDATE dbo.AppTask
		SET 
			CompletedBy		= @pUsername,
			CompletedDate	= GETDATE(),
			StatusCode		= 'Completed',
			[Description]	= 'Completed due to settlement ' + [Description] 
		FROM dbo.AppTask			
		WHERE AppInstanceValue = @AppInsVal
		AND StatusCode = 'Active'
		AND [Description] LIKE '%AQ received%'
		--		
	END TRY
	
	
	BEGIN CATCH
		SELECT ERROR_MESSAGE() + ' SP:' + OBJECT_NAME(@@PROCID)
	END CATCH
