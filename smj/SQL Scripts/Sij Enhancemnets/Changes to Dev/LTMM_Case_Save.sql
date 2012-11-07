USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[LTMM_Case_Save]    Script Date: 09/24/2012 16:45:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[LTMM_Case_Save]
(
	@Case_CaseID				int = 0,
	@Case_GroupCode				nvarchar(10) = '',
   	@Case_MatterUno				int = 0,
   	@Case_ClientUno				int = 0,
   	@Case_MatterCode			nvarchar(10) = '',
   	@Case_ClientCode			nvarchar(10) = '',
   	@Case_StateCode				nvarchar(10)  = 'Active',
   	@Case_KeyDatesID			int = 0,
   	@Case_MatterDescription		nvarchar(250)  = '',
   	@Case_ARISTADetailsID		int  = 0,
   	@Case_WorkTypeCode			nvarchar(10) = '',
	@Case_DeptCode				nvarchar(10) = '',
	@Case_BranchCode			nvarchar(10) = '',
	@Case_WorkValueCode			nvarchar(10) = '',
	@Case_StageCode				nvarchar(10) = '',
	@Case_FundingMethod			nvarchar(250)  = '',
	@Case_MITypeCode			nvarchar(10)  = '',
	@Case_OtlkTmCalCode			nvarchar(10)  = '',
	@Case_PriCaseType			nvarchar(10) = '',
	@Case_SecCaseTypeInj		nvarchar(10) = '',
	@Case_SecCaseTypeNInj		nvarchar(10) = '',
	@Case_TerCaseType			nvarchar(10) = '',
	@Case_CreditHire			bit = '',
	@Case_PAD					bit = 0,
	@Case_MatterValue			nvarchar(10) = '',
	@Case_CourtTrack			nvarchar(10) = '',
	@Case_MatterType			nvarchar(10) = '',
	@ClientRules_ClientRuleCode nvarchar(255)  = '',
	@AdExp_MATTERUNO			int = 0,
	@UserName					nvarchar(255)  = '',
	@Case_FraudStatus			varchar(4) = '',	--GV 20/9/11: added
	@Case_FraudType				varchar(4) = '',	--GV 20/9/11: added
	@Case_AccidentLocation		varchar(80) = '',	--GV 20/9/11: added
	@Case_AccidentCirc			varchar(100) = '',	--GV 20/9/11: added
	@Case_Prt8App				bit = '',			--RPM 03/10/11 added
	@Case_LOCAck				bit = '',
	@Case_Disease				bit = 0, --SMJ - Added 13/04/2012
	@Case_LOCAckCode			nvarchar(255) = '' -- SSCF 20/09/12: added
)
AS

	--Stored Procedure to either create a new case record or update an existing one 
	--Author(s) Craig Jones and GQL
	--17-07-2009
	-- Amend date: 22-06-2011
	-- GQL Amended to add addition file opening items and attchament of client rules (see release 5.9)
	
	--============================================================
	-- Moduified by GV on 2/9/11
	-- attach PUBSECANCY contact to case on case creation
	--============================================================
	--============================================================
	-- Moduified by GV on 20/9/11
	-- Extend save to take Fraud fields
	--============================================================
	

	--===========================================================
	-- Modified by RPM on 03/10/2011
	-- Save extra Prt8App field
	--============================================================
	
	--===========================================================
	-- Modified by SMJ on 02/12/2011
	-- Removed hard-coded reference to update Aderent DB
	-- Release 5.11a
	--============================================================	
	
	--===========================================================
	-- Modified by GV on 2003/2012
	-- Add rule SP calls
	-- Release 5.14
	--============================================================	
	
	--===========================================================
	-- Modified by: SMJ
	-- Modify date: 13/04/2012
	-- Details: Added new paramter @Diseases, which is a check box on the form rule SP calls
	-- Release: 5.15
	--============================================================	
	
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================		
	
	
	SET NOCOUNT ON
	
	DECLARE @pCaseContacts_CaseContactsID int
	DECLARE @pCaseContacts_CaseID int
	DECLARE @pCaseContacts_ClientID int
	DECLARE @pCaseContacts_SearchName nvarchar(256)
	DECLARE @pCaseContacts_Reference nvarchar(50)
	DECLARE @Current_Case_StateCode nvarchar(10)
	DECLARE @DynSQL nvarchar(MAX)
	DECLARE @ContactID int
	DECLARE @ContactName nvarchar(255)
	DECLARE @errNoUserName VARCHAR(50)
	
	SET @errNoUserName = 'YOU MUST PROVIDE A @UserName.'
	
	BEGIN TRY		
		----Test to see that a username has been supplied
		IF (ISNULL(@UserName,'') = '')
			RAISERROR(@errNoUserName,16,1)
		
		
		--IF NO MATTER NUMBER HAS BEEN PROVIDED CREATE A NEW ONE BY INCREMENTING 
		--THE HIGHEST MATTER NUMBER STORED AGAINST THE CLIENT NUMBER SUPPLIED	
		IF (ISNULL(@Case_MatterUno,0) = 0) AND (ISNULL(@Case_ClientUno,0)>0)
		BEGIN		
			EXECUTE LTMM_NewCaseMatterNo_Fetch @NewMatterNo = @Case_MatterUno output, @UserName = @UserName, @ClientUno = @Case_ClientUno
			EXECUTE LTMM_NewCaseMatterCode_Fetch @NewMatterCode = @Case_MatterCode output, @UserName = @UserName, @MatterUno = @Case_MatterUno		
		END
		
		
		--IF AN EXISTING CASE ID HAS NOT BEEN PASSED AND A CASE WITH THE CLINET AND MATTER NUMBER BEING PASSED DOES NOT ALREADY EXIST
		IF (ISNULL(@Case_CaseID,0)=0) AND (NOT EXISTS(SELECT Case_CaseID FROM [Case] WHERE (Case_ClientUno = @Case_ClientUno) AND (Case_MatterUno = @Case_MatterUno)))
		BEGIN
				
			--GENERATE THE BLM REFERENCE BASED ON THE CLIENT AND MATTER NUMBER
			DECLARE		@Case_BLMREF	nvarchar(50)
			--PRINT 'HERE X1'
			SET @Case_BLMREF = CAST(CAST(@Case_ClientCode as int) as varchar) + '-' + CAST(CAST(@Case_MatterCode as int) as varchar)
			--PRINT 'HERE X2'
			--CREATE A NEW CASE BASED ON THE DETAILS ENTERED
			INSERT INTO [Case]
				   (Case_GroupCode
				   ,Case_MatterUno
				   ,Case_ClientUno
				   ,Case_MatterCode
				   ,Case_ClientCode
				   ,Case_StateCode
				   ,Case_KeyDatesID
				   ,Case_BLMREF
				   ,Case_MatterDescription
				   ,Case_ARISTADetailsID
				   ,Case_WorkTypeCode
				   ,Case_DeptCode
				   ,Case_BranchCode
				   ,Case_WorkValueCode
				   ,Case_StageCode
				   ,Case_FundingMethod
				   ,Case_MITypeCode
				   ,Case_OtlkTmCalCode
				   ,Case_LASTCOSTREVIEWDATE 
				   ,Case_CaseReviewDate
				   ,Case_ClntRepDte
				   ,Case_PriCaseType
				   ,Case_SecCaseTypeInj
				   ,Case_SecCaseTypeNInj
				   ,Case_TerCaseType
				   ,Case_CreditHire
				   ,Case_PAD
				   ,Case_MatterValue
				   ,Case_CourtTrack
				   ,Case_MatterType
				   ,Case_Prt8App
				   ,Case_LOCAck
				   ,Case_ClientRuleCode
				   ,Case_Disease
				   ,Case_Date_Updated
				   ,Case_LOCAckCode) --SMJ 06/08
			 VALUES
				   (@Case_GroupCode
				   ,@Case_MatterUno
				   ,@Case_ClientUno
				   ,@Case_MatterCode
				   ,@Case_ClientCode
				   ,@Case_StateCode
				   ,@Case_KeyDatesID
				   ,@Case_BLMREF
				   ,@Case_MatterDescription
				   ,@Case_ARISTADetailsID
				   ,@Case_WorkTypeCode
				   ,@Case_DeptCode
				   ,@Case_BranchCode
				   ,@Case_WorkValueCode
				   ,@Case_StageCode
				   ,@Case_FundingMethod
				   ,@Case_MITypeCode
				   ,@Case_OtlkTmCalCode
				   ,DATEADD(MONTH,6,GETDATE())
				   ,DATEADD(MONTH,3,GETDATE())
				   ,DATEADD(DAY,15,GETDATE())
				   ,@Case_PriCaseType
				   ,@Case_SecCaseTypeInj
				   ,@Case_SecCaseTypeNInj
				   ,@Case_TerCaseType
				   ,@Case_CreditHire
				   ,@Case_PAD
				   ,@Case_MatterValue
				   ,@Case_CourtTrack
				   ,@Case_MatterType
				   ,@Case_Prt8App
				   ,@Case_LOCAck
				   ,@ClientRules_ClientRuleCode
				   ,@Case_Disease
				   ,GETDATE()
				   ,@Case_LOCAckCode)
			
			--PRINT 'HERE X3'					
			
			SET @Case_CaseID	= SCOPE_IDENTITY()	
			SELECT @Case_CaseID AS Case_CaseID	
			
			--PRINT 'SELECT MatterClientRules_MatterClientRulesID FROM MatterClientRules WHERE MatterClientRules_CaseID = ' + CAST(@Case_CaseID AS NVARCHAR(255)) + ' AND MatterClientRules_ClientRuleCode = ''' + @ClientRules_ClientRuleCode + ''' AND MatterClientRules_InActive = 0'

			
			--CREATE A NEW RECORD IN THE APPLICATION TABLE FOR TEH NEW CASE		
			EXEC ApplicationInstance_Save
					@ApplicationCode		= 'LTMM',
					@IdentifierValue		= @Case_BLMREF,
					@CaseID					= @Case_CaseID,
					@pAExpert_MatterUno		= @AdExp_MATTERUNO
							
			--PRINT 'HERE X4'
			
			--IF A CLIENT NUMBER HAS BEEN PASSED THROUGH
			IF ISNULL(@Case_ClientUno, 0) <> 0
			BEGIN
				

				SET @pCaseContacts_CaseID = @Case_CaseID
				SET @pCaseContacts_ClientID =  (SELECT CLIENT_UNO FROM dbo.HBM_Client WITH (NOLOCK) WHERE CLIENT_CODE = cast(@Case_ClientUno as nvarchar(max)))
				
				--ATTACH CLIENT DETAILS TO THE MATTER
				EXECUTE dbo.LTMM_CaseClient_Save
				   @pCaseContacts_CaseContactsID OUTPUT
				  ,@pCaseContacts_CaseID
				  ,@pCaseContacts_ClientID
				  ,@pCaseContacts_SearchName
				  ,@pCaseContacts_Reference
				  ,0
				  ,@UserName		
				  
				  --PRINT 'HERE X5'
				
			END		
			
			-- GV 2/9/11: add PUBSECANCY contact to case
			SELECT TOP 1 @ContactID = Contact_ContactID, 
					@ContactName = Contact_CompanyName
			FROM dbo.Contact WITH (NOLOCK) 
			WHERE Contact_ContactType = 'PUBSECANCY'
			AND Contact_CompanyName LIKE '%Compensation Recovery Unit%'
			AND Contact_Inactive = 0
			
			--GQL ADDED VALIDADTION TO PREVENT ERROR IF A CONTACT ID IS NOT FOUND FOR WHAREVER REASON
			--GQL ADDED VALIDADTION TO PREVENT THE CONTACT BEING ADDED MULTIPLE TIMES
			IF (ISNULL(@ContactID, 0) <> 0) AND ((SELECT ISNULL(COUNT(CaseContacts_ContactID), 0) FROM dbo.CaseContacts WITH (NOLOCK) WHERE CaseContacts_CaseID = @Case_CaseID AND CaseContacts_Inactive = 0 AND CaseContacts_RoleCode = 'PUBSECANCY') = 0)
			BEGIN
				EXEC LTMM_CaseContacts_Save
					@pCaseContacts_CaseID = @Case_CaseID,
					@pCaseContacts_ContactID = @ContactID,
					@pCaseContacts_SearchName = @ContactName,
					@pCaseContacts_RoleCode = N'PUBSECANCY ',
					@UserName = @UserName
			END
			
		END
		-- ELSE there is a CASEID i.e. we are updating an existing case
		IF (ISNULL(@Case_CaseID,0)>0)
		BEGIN
			
			
			--IF A CLIENT NUMBER HAS BEEN PASSED THROUGH
			IF (ISNULL(@Case_ClientUno, 0) <> 0) AND (@Case_ClientUno <> (SELECT Case_ClientUno FROM dbo.[Case] WITH (NOLOCK) WHERE Case_CaseID = @Case_CaseID))
			BEGIN
				
				SET @pCaseContacts_CaseID = @Case_CaseID
				SET @pCaseContacts_ClientID = (SELECT CLIENT_UNO FROM dbo.HBM_Client WITH (NOLOCK) WHERE CLIENT_CODE = CAST(@Case_ClientUno AS nvarchar(max)))
				SET @pCaseContacts_CaseContactsID = (SELECT CaseContacts_CaseContactsID FROM dbo.CaseContacts WITH (NOLOCK) WHERE ISNULL(CaseContacts_ClientID,0)>0 AND CaseContacts_CaseID = @Case_CaseID AND CaseContacts_Inactive = 0)				
				
				--ATTACH CLIENT DETAILS TO THE MATTER
				EXECUTE dbo.LTMM_CaseClient_Save
				   @pCaseContacts_CaseContactsID
				  ,@pCaseContacts_CaseID
				  ,@pCaseContacts_ClientID
				  ,@pCaseContacts_SearchName
				  ,@pCaseContacts_Reference
				  ,0
				  ,@UserName			
				  
				  --PRINT 'HERE X6'
			
			END		
			
			--GET THE CURRENT STATE CODE OF THE MATTER
			SELECT @Current_Case_StateCode = Case_StateCode 
			FROM dbo.[Case] WITH (NOLOCK) 
			WHERE Case_CaseID = @Case_CaseID 
			
			--IF THE CASE IS BEING CLOSED
			IF @Case_StateCode = 'Closed' AND @Current_Case_StateCode <> 'Closed'
			BEGIN
				--GET THE ADERANT MATTER UNO
				SELECT @AdExp_MATTERUNO = AExpert_MatterUno 
				FROM dbo.ApplicationInstance WITH (NOLOCK) 
				WHERE CaseID =  @Case_CaseID 
				
				--UPDATE CLOSE DATE ON ADERANT EXPERT			
				select @DynSQL = 'UPDATE ' + SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].[HBM_MATTER] SET [_CASE_CLOSE] = GETDATE(), LAST_MODIFIED = GETDATE() WHERE MATTER_UNO = ' + CAST(@AdExp_MATTERUNO AS NVARCHAR(255))
				from dbo.SystemSettings WITH (NOLOCK) 
				
				EXEC sp_executesql @DynSQL
				
			END
			
					
			
			-- GV 2/9/11: add PUBSECANCY contact to case
			SELECT TOP 1 @ContactID = Contact_ContactID, 
					@ContactName = Contact_CompanyName
			FROM dbo.Contact WITH (NOLOCK) 
			WHERE Contact_ContactType = 'PUBSECANCY'
			AND Contact_CompanyName LIKE '%Compensation Recovery Unit%'
			AND Contact_Inactive = 0
			
			--GQL ADDED VALIDADTION TO PREVENT ERROR IF A CONTACT ID IS NOT FOUND FOR WHAREVER REASON
			--GQL ADDED VALIDADTION TO PREVENT THE CONTACT BEING ADDED MULTIPLE TIMES
			IF (ISNULL(@ContactID, 0) <> 0) AND ((SELECT ISNULL(COUNT(CaseContacts_ContactID), 0) FROM dbo.CaseContacts WITH (NOLOCK)  WHERE CaseContacts_CaseID = @Case_CaseID AND CaseContacts_Inactive = 0 AND CaseContacts_RoleCode = 'PUBSECANCY') = 0)
			BEGIN
				EXEC LTMM_CaseContacts_Save
					@pCaseContacts_CaseID = @Case_CaseID,
					@pCaseContacts_ContactID = @ContactID,
					@pCaseContacts_SearchName = @ContactName,
					@pCaseContacts_RoleCode = N'PUBSECANCY ',
					@UserName = @UserName
			END
				
			--UPDATE THE SELECTED CASE DETAILS
			UPDATE dbo.[Case]
			SET 
				Case_ClientUno			= @Case_ClientUno,
				Case_ClientCode			= @Case_ClientCode,
				Case_GroupCode			= @Case_GroupCode,
				Case_StateCode			= @Case_StateCode,
				Case_MatterDescription	= @Case_MatterDescription,
				Case_WorkTypeCode		= @Case_WorkTypeCode,
				Case_DeptCode			= @Case_DeptCode,
				Case_BranchCode			= @Case_BranchCode,
				Case_WorkValueCode		= @Case_WorkValueCode,
				Case_FundingMethod		= @Case_FundingMethod,
				Case_MITypeCode 		= @Case_MITypeCode,
				Case_OtlkTmCalCode		= @Case_OtlkTmCalCode,
				Case_PriCaseType		= @Case_PriCaseType,
				Case_SecCaseTypeInj		= @Case_SecCaseTypeInj,
				Case_SecCaseTypeNInj	= @Case_SecCaseTypeNInj,
				Case_TerCaseType		= @Case_TerCaseType,
				Case_CreditHire			= @Case_CreditHire,
				Case_PAD				= @Case_PAD,
				Case_MatterValue		= @Case_MatterValue,
				Case_CourtTrack			= @Case_CourtTrack,
				Case_MatterType			= @Case_MatterType,
				Case_Prt8App			= @Case_Prt8App,
				Case_LOCAck				= @Case_LOCAck,
				Case_ClientRuleCode		= @ClientRules_ClientRuleCode,
				Case_Disease			= @Case_Disease	,
				Case_Date_Updated		= GETDATE(), -- SMJ 06/08
				Case_LOCAckCode			= @Case_LOCAckCode
			WHERE Case_CaseID = @Case_CaseID
			
			DECLARE @MatterUNO INT		
			
			--GET THE MATTER_UNO
			--SELECT @MatterUNO = AExpert_MatterUno
			--FROM  ApplicationInstance 
			--WHERE CaseID = @Case_CaseID
			
			SELECT @MatterUNO = Case_MatterUno
			FROM dbo.[Case] WITH (NOLOCK) 
			WHERE Case_CaseID = @Case_CaseID 
			
			--UPDATE EXTRA FRAUD DETAILS
			SELECT @DynSQL = 'UPDATE ' + SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].[_HBM_MATTER_USR_DATA]'
					+   '   SET	FRAUD = ''' +  @Case_FraudStatus + ''''
					+	' , FRAUD_TYPE = ''' + @Case_FraudType + ''''
					+	' , ACCIDENT_LOCATION = ''' + @Case_AccidentLocation + ''''
					+	' , ACCIDENT_DETAILS = ''' + @Case_AccidentCirc + ''''
					+	' , LAST_MODIFIED = GETDATE() '
					+   ' WHERE	MATTER_UNO = ' + CAST(@MATTERUNO AS NVARCHAR(255))		
			FROM	dbo.SystemSettings WITH (NOLOCK)  
			
			EXEC sp_executesql @DynSQL
		END
		
		-- GV 20/03/2012
		EXEC LTMM_ClientRuleSet_Check_AckOfInstructions @pCaseID = @Case_CaseID, @pUserName = @UserName
		
		-- GV 22/3/2012 -- call SP to deal with Action Plan rule
		-- AKR asked for this to be moved here but I think it should be in [LTMM_ARISTADetails_Process]
		EXEC LTMM_ClientRuleSet_Check_ActionPlan @pCaseID = @Case_CaseID
					,@pUserName = 'Admin'
					

		SELECT @Case_CaseID AS Case_CaseID
	END TRY
	
	BEGIN CATCH		
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH	






