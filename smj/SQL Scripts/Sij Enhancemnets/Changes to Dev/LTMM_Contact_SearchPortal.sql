USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[LTMM_Contact_SearchPortal]    Script Date: 09/24/2012 17:55:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[LTMM_Contact_SearchPortal]
(
	@pContactTypeCode nvarchar(10) = '',
	@pCompanyName nvarchar(250) = '',
	@pPosition nvarchar(250) = '',
	@pForename nvarchar(250) = '',
	@pSurname nvarchar(250) = '',
	@pDateofBirth smalldatetime = Null,
	@pAddress1 nvarchar(50) = '',
	@pPostCode nvarchar(50) = '',
	@pDXNumber nvarchar(50) = '',
	@pDXExchange nvarchar(50) = '',
	@pRegion			nvarchar(250) = '',
	@pBlockbook		nvarchar(3) = '',
	@pExpertise		nvarchar(255) = '',
	@pUserName		nvarchar(255)  = ''			
)
AS
	--Stored Procedure to Either fetch a particular Client or all Clients Associated with a Case or All Clients
	--Author(s) GQL
	--29-07-2009

	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================	
	SET DATEFORMAT DMY
	DECLARE @pLOCATION AS nvarchar(10)
	DECLARE @pContactType AS nvarchar(250)

	BEGIN TRY
		SET @pLOCATION = (SELECT ContactLocation_Location 
		FROM dbo.ContactLocation WITH (NOLOCK) 
		WHERE ContactLocation_LookupCode = @pContactTypeCode)
		
		SET @pContactType = (SELECT [Description] FROM dbo.LookupCode WITH (NOLOCK) WHERE Code = @pContactTypeCode and LookupTypeCode = 'Contact')
			--print @pLOCATION
		IF (@pLOCATION = 'ADERANT')
		BEGIN 
			--PRINT  @pContactType
			IF @pContactType = 'Co-Defendant Solicitor'
			BEGIN
				SET @pContactType = 'Claimant Solicitor'
			END 
			ELSE IF @pContactType = 'Cost Assessor'
			BEGIN
				SET @pContactType = 'Court'
			END 
			
			PRINT @pContactType
			EXEC [dbo].[LTMM_ContactSearch_Fetch] 
			  @pContactType,
			  @pCompanyName,
			  @pPosition,
			  @pForename,
			  @pSurname,
			  @pDateofBirth,
			  @pAddress1,
			  @pPostCode,
			  @pDXNumber,
			  @pDXExchange,
			  @pRegion,
			  @pBlockbook,
			  @pExpertise
		END
		ELSE
		BEGIN
			IF (@pLOCATION = 'FLOSUITE')
			BEGIN 
				EXEC [dbo].[LTMM_MatterContactSearch_Fetch] 
				  @pCompanyName,
				  @pPosition,
				  @pForename,
				  @pSurname,
				  @pDateofBirth,
				  @pAddress1,
				  @pPostCode,
				  @pDXNumber,
				  @pDXExchange,
				  @pRegion,
				  @pBlockbook,
				  @pExpertise
			 END
			 ELSE
			 BEGIN
					SELECT 0 AS ContactID, 
					'' AS STARCRITERIA, 
					--MAX(ContactType) AS ContactType, 
					'' AS CompanyName, 
					'' AS Position, 
					'' AS Forename, 
					'' AS Surname, 
					'' AS DateofBirth, 
					'' AS Address1, 
					'' AS PostCode, 
					'' AS DXNumber, 
					'' AS DXExchange,
					'' AS Region, 
					'' AS Blockbook, 
					'' AS Expertise,
					'' as [Source],
					'' AS ContactTypeCode, 
					'' as Corperate
			 END
		END
	END TRY

	BEGIN CATCH		
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH