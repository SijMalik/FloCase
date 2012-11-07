USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[MITriggerActivity_Fetch]    Script Date: 09/24/2012 18:22:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[MITriggerActivity_Fetch] 
	(	
		@CaseID INT = 0, 
		@WorkFlowName NVARCHAR(255)= '',
		@ProcessName NVARCHAR(255)='',
		@UserName NVARCHAR(255)='',
		@AppTaskID int = 0
	)
AS


	-- ==========================================================================================
	-- Author:		SMJ
	-- Create date: 13-07-2011
	-- Description:	Stored Procedure to determine if the activity that is being run is classed as a trigger activity in the MI 
	--				Returns 1 if activity is trigger activity else 0
	-- ==========================================================================================
		
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================		
DECLARE @RecCount INT
DECLARE @Return BIT
DECLARE @DefCode VARCHAR(255)
DECLARE @AppTaskStatus NVARCHAR(255)=''


	SET NOCOUNT ON
	
	BEGIN TRY
		--GET THE TRIGGER NAME FROM AppTaskDefinitionCode TABLE	
		SELECT @DefCode = AppTaskDefinitionCode FROM dbo.AppTaskDefinition WITH (NOLOCK) where ProcessName= @ProcessName  and WorkflowName= @WorkFlowName 
		
		SELECT @AppTaskStatus = statuscode FROM dbo.AppTask WITH (NOLOCK) where AppTaskID = @AppTaskID 
		
		--CHECK IF ANY RECORDS ARE RETURNED FOR CASE/USER/TRIGGER PASSED IN	
		SELECT @RecCount = COUNT(*)
		FROM 
			dbo.[Case] c WITH (NOLOCK)
			INNER JOIN dbo.AppUser au WITH (NOLOCK) ON c.Case_BLMREF = au.AppInstanceValue		
		WHERE (((ISNULL(@CaseID,'')='') OR (c.Case_CaseID = @CaseID))
			AND ((ISNULL (@UserName,'')='')  OR (au.UserName= @UserName)))
			AND EXISTS( SELECT atd.AppTaskDefinitionCode 
						FROM dbo.AppTaskDefinition atd WITH (NOLOCK)
						INNER JOIN dbo.ClientMITaskTriggers cmt WITH (NOLOCK) ON atd.AppTaskDefinitionCode = cmt.ClientMITaskTriggers_AppTaskDefinitionCode
						WHERE AppTaskDefinitionCode = @DefCode )
					
		--CHECK IF ANY RECORDS RETURNED 
		IF @RecCount > 0 and @AppTaskStatus = 'Complete'
			SELECT @Return = 1
		ELSE
			SELECT @Return = 0
			
		SELECT @Return AS TriggerActivity
	END TRY

	BEGIN CATCH		
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH


