USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[LTMM_CaseContacts_Save]    Script Date: 09/24/2012 17:16:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[LTMM_CaseContacts_Save]
(
	@pCaseContacts_CaseContactsID		int = 0,
	@pCaseContacts_CaseID				int = 0,
	@pCaseContacts_ContactID			int = 0,
	@pCaseContacts_MatterContactID		int = 0,
	@pCaseContacts_ClientID				int = 0,
	@pCaseContacts_SearchName			nvarchar(256) = '',
	@pCaseContacts_Reference			nvarchar(50) = '',
	@pCaseContacts_RoleCode				nvarchar(10) = '',
	@pCaseContacts_Inactive				bit = 0,
	@UserName							nvarchar(255) = '',
	@pCaseContacts_ContactRefHeading	nvarchar(MAX) = '',
	@pSecondaryContactType				nvarchar(250) = ''
)
AS

	--Stored Procedure to either insert a new Case Contact or update an Existing one
	--On update the previous version is kept and set as inactive with the amendmenst being inserted as a new record
	--Author(s) GQL
	--11-08-2009

	--Modified 14-09-2011 by SMJ
	--New variable @CaseContacts_CaseContactsID to pass out the new CaseContacts_CaseContactsID
	--Also changed input parameter @pCaseContacts_CaseContactsID to just be an input (was previously declared as an OUTPUT parameter as well)

	------------------------------------------------
	-- Modified by GV on 29-09-2011 
	-- Extended SP to be able to save secondary contact type
	------------------------------------------------
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================		

SET NOCOUNT ON
DECLARE @CaseContacts_CaseContactsID INT --SMJ
DECLARE @OldCaseContacts_CaseContactsID INT --GQL
DECLARE @CRUCODE nvarchar(255)
DECLARE @errNoUserName VARCHAR(50)
DECLARE @errNoCaseID VARCHAR(100)
DECLARE @errNoIDs VARCHAR(100)

	SET @errNoUserName = 'YOU MUST PROVIDE A @UserName.'
	SET @errNoCaseID = 'YOU MUST PROVIDE @pCaseContacts_CaseID to create a new entry.'
	SET @errNoIDs = 'YOU MUST PROVIDE AT LEAST ONE OF @pCaseContacts_CaseContactsID OR @pCaseContacts_ClientID.'

	BEGIN TRY
		BEGIN TRANSACTION UpdateCaseContact

		--Test to see that a username has been supplied
		IF (ISNULL(@UserName,'') = '')
			RAISERROR (@errNoUserName,16,1)

		--Test to see that the minimum ID set has been supplied
		IF (ISNULL(@pCaseContacts_CaseContactsID,0) = 0) AND (ISNULL(@pCaseContacts_ContactID,0) = 0) AND (ISNULL(@pCaseContacts_MatterContactID,0) = 0)
			RAISERROR (@errNoIDs,16,1)

		--If no contact or mattercontact id has been passed it must be an edit so get the previous value set for these
		IF ((ISNULL(@pCaseContacts_ContactID,0) = 0) 
			AND (ISNULL(@pCaseContacts_MatterContactID,0) = 0) 
			AND (ISNULL(@pCaseContacts_ClientID,0) = 0))
			OR (ISNULL(@pCaseContacts_CaseContactsID,0) <> 0)
		BEGIN
			SELECT @pCaseContacts_ContactID = ISNULL(CaseContacts_ContactID ,0),
			@pCaseContacts_MatterContactID = ISNULL(CaseContacts_MatterContactID,0),
			@pCaseContacts_ClientID = ISNULL(CaseContacts_ClientID ,0)
			FROM dbo.CaseContacts WITH (NOLOCK)
			WHERE CaseContacts_CaseContactsID = @pCaseContacts_CaseContactsID	
		END

		--If a MatterContact ID has a value generate the search name using the MatterContact Table
		IF (ISNULL(@pCaseContacts_MatterContactID,0) <> 0)
		BEGIN
			--If matter contact is a company set search name = company name
			IF (SELECT MatterContact_Corporate 
				FROM dbo.MatterContact WITH (NOLOCK)
				WHERE MatterContact_MatterContactID = @pCaseContacts_MatterContactID) = 'Y'
			BEGIN 
				SELECT @pCaseContacts_SearchName = [MatterContact_CompanyName] 
				FROM dbo.MatterContact W WITH (NOLOCK)
				WHERE MatterContact_MatterContactID = @pCaseContacts_MatterContactID
			END
			--If matter contact is an individual set search name = Forname + Surname
			ELSE
			BEGIN 
				SELECT @pCaseContacts_SearchName = MatterContact_Forename + ' ' + MatterContact_Surname 
				FROM dbo.MatterContact WITH (NOLOCK)
				WHERE MatterContact_MatterContactID = @pCaseContacts_MatterContactID
			END
		END

		--If a Contact ID has a value generate the search name using the Contact Table
		IF (ISNULL(@pCaseContacts_ContactID,0) <> 0)
		BEGIN
			--If matter contact is a company set search name = company name
			IF (SELECT Contact_Corporate 
				FROM dbo.Contact WITH (NOLOCK)
				WHERE Contact_ContactID = @pCaseContacts_ContactID) = 'Y'
			BEGIN 
				SELECT @pCaseContacts_SearchName = [Contact_CompanyName] 
				FROM dbo.Contact WITH (NOLOCK)
				WHERE Contact_ContactID = @pCaseContacts_ContactID
			END
			ELSE
			--If matter contact is an individual set search name = Forname + Surname
			BEGIN 
				SELECT @pCaseContacts_SearchName = Contact_Forename + ' ' + Contact_Surname 
				FROM dbo.Contact WITH (NOLOCK)
				WHERE Contact_ContactID = @pCaseContacts_ContactID
			END	
		END

		IF (ISNULL(@pCaseContacts_ClientID,0) <> 0)
		BEGIN
			SELECT @pCaseContacts_SearchName = CLIENT_NAME
			FROM dbo.HBM_CLIENT WITH (NOLOCK) 
			WHERE HBM_Client.CLIENT_UNO = @pCaseContacts_ClientID
		END

		--If no case contact ID provided	
		IF (ISNULL(@pCaseContacts_CaseContactsID,0) = 0)
		BEGIN
			--Test to see that the CASEID has been supplied
			IF (ISNULL(@pCaseContacts_CaseID,0) = 0)
				RAISERROR (@errNoCaseID,16,1)
			
			IF @pCaseContacts_ClientID = 0 AND @pCaseContacts_RoleCode<>'Client'  SET @pCaseContacts_ClientID = null  
			
			--INSERT A NEW CASE CONTACT
			INSERT INTO dbo.CaseContacts
				   (CaseContacts_CaseID
				   ,CaseContacts_ContactID
				   ,CaseContacts_MatterContactID
				   ,CaseContacts_ClientID
				   ,CaseContacts_Reference
				   ,CaseContacts_SearchName 
				   ,CaseContacts_RoleCode
				   ,CaseContacts_Inactive
				   ,CreateUser
				   ,CreateDate
				   ,CaseContacts_ContactRefHeading
				   ,SecondaryContactType)
			 VALUES
				   (@pCaseContacts_CaseID
				   ,@pCaseContacts_ContactID
				   ,@pCaseContacts_MatterContactID
				   ,@pCaseContacts_ClientID
				   ,@pCaseContacts_Reference
				   ,@pCaseContacts_SearchName 
				   ,@pCaseContacts_RoleCode
				   ,0
				   ,@UserName
				   ,CAST(GETDATE() AS SMALLDATETIME)
				   ,@pCaseContacts_ContactRefHeading
				   ,@pSecondaryContactType)
			
			SET @CaseContacts_CaseContactsID	= SCOPE_IDENTITY()
		END
		-- ELSE THERE IS A CASECONTACT ID PASSED 
		-- AND THEREFORE AN AMENDMENT TO AN EXISTING RECORD IS REQUIRED
		ELSE
		BEGIN	
			
			--Test to see that the CASEID has been supplied
			IF (ISNULL(@pCaseContacts_CaseID,0) = 0)
				RAISERROR (@errNoCaseID,16,1)
			
			--PRESERVE CRU CODE
			SELECT @CRUCODE = ClaimantCRU_Code 
			FROM dbo.CaseContacts WITH (NOLOCK) 
			WHERE CaseContacts_CaseContactsID = @pCaseContacts_CaseContactsID 
			
			--UPDATE THE EXISTING RECORD AS INACTIVE			
			UPDATE dbo.CaseContacts 		 
			SET CaseContacts_Inactive = 1			
			WHERE (CaseContacts_CaseContactsID = @pCaseContacts_CaseContactsID)
			
			IF @pCaseContacts_ClientID = 0 AND @pCaseContacts_RoleCode<>'Client'  SET @pCaseContacts_ClientID = null  
				
			--INSERT A NEW CASE CONTACT RECORD WITH THE AMENDMENTS MADE
			INSERT INTO dbo.CaseContacts
					   (CaseContacts_CaseID
					   ,CaseContacts_ContactID
					   ,CaseContacts_MatterContactID
					   ,CaseContacts_ClientID
					   ,CaseContacts_Reference
					   ,CaseContacts_SearchName 
					   ,CaseContacts_RoleCode
					   ,CaseContacts_Inactive
					   ,CreateUser
					   ,CreateDate
					   ,CaseContacts_ContactRefHeading
					   ,SecondaryContactType
					   ,ClaimantCRU_Code)
				 VALUES
					   (@pCaseContacts_CaseID
					   ,@pCaseContacts_ContactID
					   ,@pCaseContacts_MatterContactID
					   ,@pCaseContacts_ClientID
					   ,@pCaseContacts_Reference
					   ,@pCaseContacts_SearchName 
					   ,@pCaseContacts_RoleCode
					   ,0
					   ,@UserName
					   ,CAST(GETDATE() AS SMALLDATETIME)
					   ,@pCaseContacts_ContactRefHeading
					   ,@pSecondaryContactType
					   ,@CRUCODE)
			
			SET @OldCaseContacts_CaseContactsID = @pCaseContacts_CaseContactsID
			SET @CaseContacts_CaseContactsID = SCOPE_IDENTITY()
			
			
			--GQL PRESERVE THE LINK TO PART 8 RECIPIENTS AFTER UPDATE
			UPDATE dbo.PartEightRecipient 
			SET PartEightRecipient_CaseContactID = @CaseContacts_CaseContactsID 
			WHERE PartEightRecipient_CaseContactID = @OldCaseContacts_CaseContactsID
			
			--GQL PRESERVE THE LINK TO OFFERS AFTER UPDATE
			UPDATE dbo.Offers 
			SET Offers_CaseContactID = @CaseContacts_CaseContactsID 
			WHERE Offers_CaseContactID = @OldCaseContacts_CaseContactsID
			
			--GQL PRESERVE THE LINK TO PRETRIALCONTACTS AFTER UPDATE
			UPDATE dbo.PreTrialPrepContacts 
			SET PreTrialPrepContacts_CaseContactID = @CaseContacts_CaseContactsID 
			WHERE PreTrialPrepContacts_CaseContactID = @OldCaseContacts_CaseContactsID
				
			--GQL PRESERVE THE LINK TO CRU TASK AFTER UPDATE
			UPDATE dbo.AppTask 
			SET Referencial_Code = cast(@CaseContacts_CaseContactsID as nvarchar(255))
			WHERE Referencial_Code = cast(@OldCaseContacts_CaseContactsID as nvarchar(255)) AND AppTaskDefinitionCode = 'ClaimantCRU'
			
			UPDATE dbo.AppTask 
			SET ContactID = cast(@CaseContacts_CaseContactsID as nvarchar(255))
			WHERE ContactID = cast(@OldCaseContacts_CaseContactsID as nvarchar(255)) AND AppTaskDefinitionCode = 'ClaimantCRU'
	
		END

		COMMIT TRANSACTION UpdateCaseContact

		SELECT @CaseContacts_CaseContactsID AS CaseContacts_CaseContactsID, @pCaseContacts_MatterContactID as CaseContacts_MatterContactID
	END TRY

	BEGIN CATCH	
		IF @@TRANCOUNT > 0 
			ROLLBACK TRANSACTION UpdateCaseContact	
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH
