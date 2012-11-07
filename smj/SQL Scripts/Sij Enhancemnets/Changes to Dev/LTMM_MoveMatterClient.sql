USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[LTMM_MoveMatterClient]    Script Date: 09/24/2012 18:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[LTMM_MoveMatterClient] 
	@CurrentClientNumber						nvarchar(10) = '',		-- Manditory
    @CurrentMatterNumber						nvarchar(10) = '',		-- Manditory
    @NewClientNumber							nvarchar(10) = '',		-- Manditory
    @NewMatterNumber							nvarchar(10) = '',		-- Manditory
	@UserName									nvarchar(255)  = ''		-- Manditory
AS
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================
	
	
	SET NOCOUNT ON
	
	--DECLARE VARIABLES	
	DECLARE @pCaseContacts_CaseContactsID			int,
			@pCaseContacts_CaseID					int,
			@pCaseContacts_ClientID					int,
			@pCaseContacts_SearchName				nvarchar(256),
			@pCaseContacts_Reference				nvarchar(50),
			@CurrentClientNumberInt					int,
			@CurrentMatterNumberInt					int,
			@NewClientNumberInt						int,
			@NewMatterNumberInt						int,
			@CurrentBLMRef							nvarchar(21),
			@NewBLMRef								nvarchar(21),
			@CurrentDocPath							nvarchar(21),
			@NewDocPath								nvarchar(21),
			@CaseID									int,
			@pHistoryDescription					nvarchar(256)	
	
	DECLARE @errNoUserName VARCHAR(50)
	DECLARE @errMatterExist VARCHAR(50)
	
	SET @errNoUserName = 'YOU MUST PROVIDE A @UserName.'
	SET @errMatterExist = 'There is already a matter with that client and matter number.'
	
	BEGIN TRY
		BEGIN TRANSACTION MoveMatterClient
		
		----Test to see that a username has been supplied
		IF (ISNULL(@UserName,'') = '')
			RAISERROR (@errNoUserName,16,1)
		
		--GET THE INTERGER VERSIONS OF THE CLIENT AND MATTER NUMBRES PASSED FOR THE CURRENT AND NEW MATTERS
		SELECT @CurrentClientNumberInt = CAST(@CurrentClientNumber as INT),
		@CurrentMatterNumberInt = CAST(@CurrentMatterNumber as INT),
		@NewClientNumberInt = CAST(@NewClientNumber as INT),
		@NewMatterNumberInt = CAST(@NewMatterNumber as INT)
	    
	       
		--GET THE CURRENT AND NEW BLM-REFS and Doc Paths
		SELECT @CurrentBLMRef = CAST(@CurrentClientNumberInt AS nvarchar(10)) + '-' + CAST(@CurrentMatterNumberInt AS nvarchar(10)),
		@CurrentDocPath = CAST(@CurrentClientNumberInt AS nvarchar(10)) + '\' + CAST(@CurrentMatterNumberInt AS nvarchar(10)),
		@NewBLMRef = CAST(@NewClientNumberInt AS nvarchar(10)) + '-' + CAST(@NewMatterNumberInt AS nvarchar(10)),
		@NewDocPath = CAST(@NewClientNumberInt AS nvarchar(10)) + '\' + CAST(@NewMatterNumberInt AS nvarchar(10))
		
		SET @pHistoryDescription = 'BLM Ref Changed From: ' + @CurrentBLMRef + ' to ' + @NewBLMRef
		
		--GET CURRENT CASEID USING CURRENT BLM-REF
		SET @CaseID = (SELECT CaseID FROM ApplicationInstance WHERE IdentifierValue = @CurrentBLMRef)	
		
		--TEST TO SEE IF A MATTER WITH THIS CLIENT AND MATTER NUMBER EXISTS
		IF EXISTS(SELECT 1 FROM dbo.ApplicationInstance WITH (NOLOCK) WHERE IdentifierValue = @NewBLMRef)
		BEGIN
			RAISERROR (@errMatterExist, 16,1)
		END
		ELSE
		BEGIN		
			--UPDATE APPLICATION LINKS WITH NEW BLM-REF
			UPDATE dbo.ApplicationInstance SET IdentifierValue = @NewBLMRef WHERE IdentifierValue = @CurrentBLMRef
			UPDATE dbo.AppUser SET AppInstanceValue = @NewBLMRef WHERE AppInstanceValue = @CurrentBLMRef
			UPDATE dbo.AppTask SET AppInstanceValue = @NewBLMRef  WHERE AppInstanceValue = @CurrentBLMRef
			
			--UPDATE DOCUMENT LINKS WITH NEW DOCPATH 
			--***NOTE THE CURRENT DOCUMENTS WILL NEED TO BE PHYSICALLY MOVED TO THE NEW LOCATION FOR THIS TO WORK***
			UPDATE dbo.AppTaskDocument SET DocPath = @NewDocPath where DocPath = @CurrentDocPath 
			UPDATE dbo.AppTaskDocumentVersion SET DocPath = @NewDocPath where DocPath = @CurrentDocPath 
			
			--UPDATE CASE TABLE WITH NEW DETAILS
			UPDATE dbo.[Case] 
			SET		Case_BLMREF = @NewBLMRef, 
					Case_MatterUno = @NewMatterNumberInt,
					Case_ClientUno = @NewClientNumberInt,
					Case_MatterCode = @NewMatterNumber,
					Case_ClientCode = @NewClientNumber
			WHERE Case_CaseID = @CaseID 		
			
			--SET PREVIOUS CLIENT AS INACTIVE ON THE MATTER		
			UPDATE dbo.CaseContacts SET CaseContacts_Inactive = 1 WHERE CaseContacts_CaseID = @CaseID AND ISNULL(CaseContacts_ClientID,0) > 0
			
			--GET NEW CLIENT ID
			SET @pCaseContacts_ClientID =  (SELECT CLIENT_UNO FROM dbo.HBM_CLIENT WITH (NOLOCK) WHERE CLIENT_NUMBER = @NewClientNumberInt)
			SET @pCaseContacts_CaseID = @CaseID
			
			--ATTACH NEW CLIENT DETAILS TO THE MATTER
			EXECUTE dbo.LTMM_CaseClient_Save
			   @pCaseContacts_CaseContactsID OUTPUT
			  ,@pCaseContacts_CaseID
			  ,@pCaseContacts_ClientID
			  ,@pCaseContacts_SearchName
			  ,@pCaseContacts_Reference
			  ,0
			  ,@UserName
					  
			EXEC [AppTask_Complete]  
				@AppTaskDefinitionCode = 'CaseDetails',  
				@CaseID = @CaseID,
				@CompletedBy = 'ADMIN',
				@Description = @pHistoryDescription,
				@UserName = 'ADMIN'		
			
		END	
		
		COMMIT TRANSACTION MoveMatterClient
	END TRY
	
	BEGIN CATCH	
		IF @@TRANCOUNT > 0 	
			ROLLBACK TRANSACTION MoveMatterClient
			
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH	
	

