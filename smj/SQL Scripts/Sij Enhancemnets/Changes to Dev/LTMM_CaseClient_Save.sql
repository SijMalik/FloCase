USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[LTMM_CaseClient_Save]    Script Date: 09/24/2012 17:06:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


----------------------------------------------------------------------------------------------------------------


ALTER PROC [dbo].[LTMM_CaseClient_Save]
(
	@pCaseContacts_CaseContactsID		int = 0 Output,
	@pCaseContacts_CaseID				int = 0,
	@pCaseContacts_ClientID				int = 0,
	@pCaseContacts_SearchName			nvarchar(256) = '',
	@pCaseContacts_Reference			nvarchar(50) = '',
	@pCaseContacts_Inactive				bit = 0,
	@UserName							nvarchar(255) = ''
)
AS

	--Stored Procedure to either insert a new Client as a Case Contact or update an Existing one
	--On update the previous version is kept and set as inactive with the amendmenst being inserted as a new record
	--Author(s) GQL
	--25-08-2009
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================	
	SET NOCOUNT ON
	DECLARE @errNoUserName VARCHAR(50)
	DECLARE @errNoCaseID VARCHAR(100)
	DECLARE @errNoIDs VARCHAR(100)

	SET @errNoUserName = 'YOU MUST PROVIDE A @UserName.'
	SET @errNoCaseID = 'YOU MUST PROVIDE @pCaseContacts_CaseID to create a new entry.'
	SET @errNoIDs = 'YOU MUST PROVIDE AT LEAST ONE OF @pCaseContacts_CaseContactsID OR @pCaseContacts_ClientID.'

	BEGIN TRY

		BEGIN TRANSACTION UpdateCaseClient

		--Test to see that a username has been supplied
		IF (ISNULL(@UserName,'') = '')
			RAISERROR (@errNoUserName, 16, 1)
			
		--Test to see that the minimum ID set has been supplied
		IF (ISNULL(@pCaseContacts_CaseContactsID,0) = 0) AND (ISNULL(@pCaseContacts_ClientID,0) = 0)
			RAISERROR (@errNoIDs, 16, 1)

		--If no contact or mattercontact id has been passed it must be an edit so get the previous value set for these
		IF (ISNULL(@pCaseContacts_ClientID,0) = 0)
		BEGIN
			SET @pCaseContacts_ClientID = (SELECT CaseContacts_ClientID FROM dbo.CaseContacts WITH (NOLOCK) WHERE CaseContacts_CaseContactsID = @pCaseContacts_CaseContactsID)	
		END

		--If a Client ID has a value generate the search name using the HBM_Client Table
		IF ISNULL(@pCaseContacts_ClientID, 0) > 0
		BEGIN
			SELECT @pCaseContacts_SearchName = CLIENT_NAME FROM dbo.HBM_Client WITH (NOLOCK) WHERE CLIENT_UNO = @pCaseContacts_ClientID
		END

		--If no case contact ID provided	
		IF (ISNULL(@pCaseContacts_CaseContactsID,0) = 0)
		BEGIN
				--Test to see that the CASEID has been supplied
				IF (ISNULL(@pCaseContacts_CaseID,0) = 0)
					RAISERROR (@errNoCaseID, 16, 1)
				
				--INSERT A NEW CLIENT CASE CONTACT
				INSERT INTO dbo.CaseContacts
					   (CaseContacts_CaseID
					   ,CaseContacts_ClientID
					   ,CaseContacts_Reference
					   ,CaseContacts_SearchName
					   ,CaseContacts_Inactive
					   ,CaseContacts_RoleCode 
					   ,CreateUser
					   ,CreateDate)
				 VALUES
					   (@pCaseContacts_CaseID
					   ,@pCaseContacts_ClientID
					   ,@pCaseContacts_Reference
					   ,@pCaseContacts_SearchName
					   ,0
					   ,'Client'
					   ,@UserName
					   ,CAST(GETDATE() AS SMALLDATETIME))
				
				SET @pCaseContacts_CaseContactsID	= SCOPE_IDENTITY()
			END
		-- ELSE THERE IS A CASECONTACT ID PASSED 
		-- AND THEREFORE AN AMENDMENT TO AN EXISTING RECORD IS REQUIRED
		ELSE
		BEGIN	
			
			--Test to see that the CASEID has been supplied
			IF (ISNULL(@pCaseContacts_CaseID,0) = 0)
				RAISERROR (@errNoCaseID, 16, 1)
			
			--UPDATE THE EXISTING RECORD AS INACTIVE			
			UPDATE dbo.CaseContacts 		 
			SET CaseContacts_Inactive = 1			
			WHERE (CaseContacts_CaseContactsID = @pCaseContacts_CaseContactsID)
				
			--INSERT A NEW CASE CONTACT RECORD WITH THE AMENDMENTS MADE
			INSERT INTO dbo.CaseContacts
				   (CaseContacts_CaseID
				   ,CaseContacts_ClientID
				   ,CaseContacts_Reference
				   ,CaseContacts_SearchName
				   ,CaseContacts_Inactive
				   ,CaseContacts_RoleCode 
				   ,CreateUser
				   ,CreateDate)
			 VALUES
				   (@pCaseContacts_CaseID
				   ,@pCaseContacts_ClientID
				   ,@pCaseContacts_Reference
				   ,@pCaseContacts_SearchName
				   ,0
				   ,'Client'
				   ,@UserName
				   ,CAST(GETDATE() AS SMALLDATETIME))
				   
			SET @pCaseContacts_CaseContactsID	= SCOPE_IDENTITY()
					
		END

		COMMIT TRANSACTION UpdateCaseClient
	END TRY
	
	BEGIN CATCH	
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION UpdateCaseClient	
			
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH



