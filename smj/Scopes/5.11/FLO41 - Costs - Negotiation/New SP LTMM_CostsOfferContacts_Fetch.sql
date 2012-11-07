USE [FloSuite_Data_Dev]
GO

/****** Object:  StoredProcedure [dbo].[LTMM_CostsOfferContacts_Fetch]    Script Date: 11/17/2011 14:53:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[LTMM_CostsOfferContacts_Fetch]
	(
		@pCaseID INT = 0		
		
	)

	-- ==========================================================================================
	-- SMJ - CREATED - 01-11-2011
	-- SP fetches contact details for Costs Offer Type
	-- =========================================================================================	
	
	
AS

	DECLARE @errNoCaseID VARCHAR(50)
	
	SELECT @errNoCaseID = 'No Case ID passed in.'

	BEGIN TRY
		  	  	
		--Do some error checking
		IF @pCaseID <= 0
			RAISERROR(@errNoCaseID,16,1)

		--Need to create temp table cotaining all fields returned by LTMM_CaseContacts_Fetch SP		
		CREATE TABLE #MatterContacts
		( 
			ContactID [int] NOT NULL,
			RoleCode nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			Title nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			Forename nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			Surname nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			Corporate nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			CompanyName nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			Position nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			GENDerCode nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			DOB SMALLDATETIME NULL,
			FullName nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			Blockbook nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			FieldOfExpertise nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			RegionCode nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			AddressType nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			Address1 nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			Address2 nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			Address3 nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			Address4 nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			Town nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			County nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			Postcode nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			Country nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			DXNumber nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			DXExchange nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			AddressOrder int NULL,
			IsPrimary BIT NULL,
			Reference nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			CaseContactsID INT NULL,
			[Source] nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			PrimaryEmail nvarchar(MAX) COLLATE DATABASE_DEFAULT NULL,
			PrimaryTelephone nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			PrimaryFax nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			ContactRoleDesc nvarchar(MAX) COLLATE DATABASE_DEFAULT NULL,
			ContactRefHeading nvarchar(MAX) COLLATE DATABASE_DEFAULT NULL,
			DOD SMALLDATETIME NULL,
			NINumber NVARCHAR(255)NULL,
			VehicleReg NVARCHAR(255) NULL,
			Passenger BIT NULL,
			SecondaryContactType nvarchar(250) COLLATE DATABASE_DEFAULT NULL
		)
		
		--Insert details for Claimants Solicitors, Co-Defendant’s Solicitors and External Costs Draftspersons
		INSERT INTO #MatterContacts
		EXEC LTMM_CaseContacts_Fetch @pCaseID,0,'ClaimSol'
		
		INSERT INTO #MatterContacts
		EXEC LTMM_CaseContacts_Fetch @pCaseID,0,'CODEFSOL'
		
		INSERT INTO #MatterContacts
		EXEC LTMM_CaseContacts_Fetch @pCaseID,0,'ExtCstDrft'	

		--Set RoleCode to title case
		UPDATE #MatterContacts
		SET RoleCode = dbo.ProperCase (RoleCode)			
	
		SELECT	DISTINCT CaseContactsID,  
		FullName, ContactRoleDesc AS 'Contact Type',
				ISNULL(Address1,'') + ' ' + ISNULL(Address2,'') + ' ' + ISNULL(Address3,'') 
				+ ' '  + ISNULL(Address4, '') + ' ' + ISNULL(Town,'') + ' ' + ISNULL(County,'') 
				+ ' ' +  ISNULL(Postcode,'') AS 'Primary Address'
		FROM	#MatterContacts
		WHERE RoleCode IN ('ClaimSol', 'CODEFSOL', 'ExtCstDrft')
		
	END TRY
	
	BEGIN CATCH
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME(@@PROCID)
	END CATCH
	

GO


