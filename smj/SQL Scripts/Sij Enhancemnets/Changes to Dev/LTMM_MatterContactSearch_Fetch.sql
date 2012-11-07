USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[LTMM_MatterContactSearch_Fetch]    Script Date: 09/24/2012 18:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




ALTER PROCEDURE [dbo].[LTMM_MatterContactSearch_Fetch]
(
	@CompanyName	nvarchar(250) = '',
	@Position		nvarchar(250) = '',
	@Forename		nvarchar(250) = '',
	@Surname		nvarchar(250) = '',
	@DateofBirth	smalldatetime = NULL,
	@Address1		nvarchar(50) = '',
	@PostCode		nvarchar(50) = '',
	@DXNumber		nvarchar(50) = '',
	@DXExchange		nvarchar(50) = '',
	@Region			nvarchar(250) = '',
	@Blockbook		nvarchar(3) = '',
	@Expertise		nvarchar(max) = ''
				
)
AS
	--Stored Procedure to fetch a set of Matter Contacts based on the criteria entered
	--Author(s) GQL
	--30-07-2009
	--GQL AMENDED 06-04-2011 TO REMOVE RELIANCE ON LEFT OUTER JOINS AND IMPROVE DYNAMIC FILTERING 
	
	-- SMJ - Amended - 13-07-2011
	-- Remove 'SHAPE.' qualifier fro order by list
	-- Use sp_executesql to run dynamic sql
	
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================		
	--Declare Search Criteria 
	
	SET DATEFORMAT DMY
	
	BEGIN TRY
		
		--REMOVE ' FROM SEARCH
		SELECT @CompanyName = REPLACE(@CompanyName, '''', ''), 
		@Position = REPLACE(@Position, '''', ''), 
		@Forename = REPLACE(@Forename, '''', ''), 
		@Surname = REPLACE(@Surname, '''', ''), 
		@Address1 = REPLACE(@Address1, '''', ''),
		@PostCode = REPLACE(@PostCode, '''', ''), 
		@DXNumber = REPLACE(@DXNumber, '''', ''), 
		@DXExchange = REPLACE(@DXExchange, '''', ''), 
		@Region = REPLACE(@Region, '''', ''), 
		@Blockbook = REPLACE(@Blockbook, '''', ''), 
		@Expertise = REPLACE(@Expertise, '''', '')
		
		SELECT TOP 100
		SHAPE.ContactID AS ContactID,
		MAX(SHAPE.STARCRITERIA) AS STARCRITERIA,
		MAX(SHAPE.CompanyName) AS CompanyName,
		MAX(SHAPE.Position) AS Position,
		MAX(SHAPE.Forename) AS Forename,
		MAX(SHAPE.Surname) AS Surname,
		MAX(SHAPE.DateofBirth) AS DateofBirth,
		MAX(SHAPE.Address1) AS Address1,
		MAX(SHAPE.PostCode) AS PostCode,
		MAX(SHAPE.DXNumber) AS DXNumber,	
		MAX(SHAPE.DXExchange) AS DXExchange,
		MAX(SHAPE.Region) AS Region,
		MAX(SHAPE.Blockbook) AS Blockbook,
		MAX(SHAPE.Expertise) AS Expertise,
		MAX(SHAPE.ContactTypeCode) AS ContactTypeCode,
		MAX(SHAPE.Corperate) AS Corperate,
		'Matter Contact' AS [Source]
		FROM (	
			SELECT
			m.MatterContact_MatterContactID AS ContactID,
			'***' AS STARCRITERIA,
			m.MatterContact_CompanyName AS CompanyName, 
			m.MatterContact_Position AS Position, 
			m.MatterContact_Forename AS Forename, 
			m.MatterContact_Surname AS Surname, 
			m.MatterContact_DOB AS DateofBirth,
			a.MatterContactAddress_Address1 AS Address1, 
			a.MatterContactAddress_Postcode as Postcode, 
			a.MatterContactAddress_DXNumber AS DXNumber, 	
			a.MatterContactAddress_DXExchange AS DXExchange,
			r.[Description] AS Region,
			m.MatterContact_Blockbook as Blockbook,
			m.MatterContact_FieldOfExpertise as Expertise,
			m.MatterContact_ContactType AS ContactTypeCode,
			m.MatterContact_Corporate AS Corperate,
			ct.[Description]  AS ContactType
			FROM  dbo.MatterContact m  WITH (NOLOCK)
			LEFT OUTER JOIN dbo.LookupCode r WITH (NOLOCK) on r.Code = m.MatterContact_RegionCode and r.LookupTypeCode = 'Region'
			LEFT OUTER JOIN dbo.MatterContactAddress a WITH (NOLOCK) on m.MatterContact_MatterContactID = a.MatterContactAddress_MatterContactID AND ISNULL(a.MatterContactAddress_Inactive, 0) = 0 AND ISNULL(a.MatterContactAddress_IsPrimary, 0) = 1
			LEFT OUTER JOIN dbo.LookupCode ct WITH (NOLOCK) on ct.Code = m.MatterContact_ContactType 
			WHERE (ISNULL(m.MatterContact_Inactive,0) = 0)
			AND (((ISNULL(@CompanyName,'') = '') OR (m.MatterContact_CompanyName = @CompanyName))
			AND ((ISNULL(@Position,'') = '') OR (m.MatterContact_Position = @Position))
			AND ((ISNULL(@Forename,'') = '') OR (m.MatterContact_Forename = @Forename))
			AND ((ISNULL(@Surname,'') = '') OR (m.MatterContact_Surname = @Surname))
			AND ((ISNULL(@DateofBirth,'') = '') OR (m.MatterContact_DOB = @DateofBirth))
			AND ((ISNULL(@Blockbook,'') = '') OR (m.MatterContact_Blockbook = @Blockbook))
			AND ((ISNULL(@Expertise, '') = '') OR (m.MatterContact_FieldOfExpertise = @Expertise))
			AND ((ISNULL(@Address1, '') = '') OR (a.MatterContactAddress_Address1 = @Address1))
			AND ((ISNULL(@PostCode, '') = '') OR (a.MatterContactAddress_Postcode = @PostCode))
			AND ((ISNULL(@DXNumber, '') = '') OR (a.MatterContactAddress_DXNumber = @DXNumber))
			AND ((ISNULL(@DXExchange, '') = '') OR (a.MatterContactAddress_DXExchange = @DXExchange))
			AND ((ISNULL(@Region, '') = '') OR (r.[Description] = @Region)))
			UNION
			SELECT
			m.MatterContact_MatterContactID AS ContactID,
			'**' AS STARCRITERIA,
			m.MatterContact_CompanyName AS CompanyName, 
			m.MatterContact_Position AS Position, 
			m.MatterContact_Forename AS Forename, 
			m.MatterContact_Surname AS Surname, 
			m.MatterContact_DOB AS DateofBirth,
			a.MatterContactAddress_Address1 AS Address1, 
			a.MatterContactAddress_Postcode as Postcode, 
			a.MatterContactAddress_DXNumber AS DXNumber, 	
			a.MatterContactAddress_DXExchange AS DXExchange,
			r.[Description] AS Region,
			m.MatterContact_Blockbook as Blockbook,
			m.MatterContact_FieldOfExpertise as Expertise,
			m.MatterContact_ContactType AS ContactTypeCode,
			m.MatterContact_Corporate AS Corperate,
			ct.[Description]  AS ContactType
			FROM  dbo.MatterContact m  WITH (NOLOCK)
			LEFT OUTER JOIN dbo.LookupCode r WITH (NOLOCK) on r.Code = m.MatterContact_RegionCode and r.LookupTypeCode = 'Region'
			LEFT OUTER JOIN dbo.MatterContactAddress a WITH (NOLOCK) on m.MatterContact_MatterContactID = a.MatterContactAddress_MatterContactID AND ISNULL(a.MatterContactAddress_Inactive, 0) = 0 AND ISNULL(a.MatterContactAddress_IsPrimary, 0) = 1
			LEFT OUTER JOIN dbo.LookupCode ct WITH (NOLOCK) on ct.Code = m.MatterContact_ContactType 
			WHERE (ISNULL(m.MatterContact_Inactive,0) = 0)
			AND (((ISNULL(@CompanyName,'') = '') OR (m.MatterContact_CompanyName LIKE @CompanyName + '%'))
			AND ((ISNULL(@Position,'') = '') OR (m.MatterContact_Position LIKE @Position + '%'))
			AND ((ISNULL(@Forename,'') = '') OR (m.MatterContact_Forename LIKE @Forename + '%'))
			AND ((ISNULL(@Surname,'') = '') OR (m.MatterContact_Surname LIKE @Surname + '%'))
			AND ((ISNULL(@DateofBirth,'') = '') OR (m.MatterContact_DOB LIKE @DateofBirth))
			AND ((ISNULL(@Blockbook,'') = '') OR (m.MatterContact_Blockbook LIKE @Blockbook + '%'))
			AND ((ISNULL(@Expertise, '') = '') OR (m.MatterContact_FieldOfExpertise LIKE @Expertise + '%'))
			AND ((ISNULL(@Address1, '') = '') OR (a.MatterContactAddress_Address1 LIKE @Address1 + '%'))
			AND ((ISNULL(@PostCode, '') = '') OR (a.MatterContactAddress_Postcode LIKE @PostCode + '%'))
			AND ((ISNULL(@DXNumber, '') = '') OR (a.MatterContactAddress_DXNumber LIKE @DXNumber + '%'))
			AND ((ISNULL(@DXExchange, '') = '') OR (a.MatterContactAddress_DXExchange LIKE @DXExchange + '%'))
			AND ((ISNULL(@Region, '') = '') OR (r.[Description] LIKE @Region + '%')))
			UNION
			SELECT
			m.MatterContact_MatterContactID AS ContactID,
			'*' AS STARCRITERIA,
			m.MatterContact_CompanyName AS CompanyName, 
			m.MatterContact_Position AS Position, 
			m.MatterContact_Forename AS Forename, 
			m.MatterContact_Surname AS Surname, 
			m.MatterContact_DOB AS DateofBirth,
			a.MatterContactAddress_Address1 AS Address1, 
			a.MatterContactAddress_Postcode as Postcode, 
			a.MatterContactAddress_DXNumber AS DXNumber, 	
			a.MatterContactAddress_DXExchange AS DXExchange,
			r.[Description] AS Region,
			m.MatterContact_Blockbook as Blockbook,
			m.MatterContact_FieldOfExpertise as Expertise,
			m.MatterContact_ContactType AS ContactTypeCode,
			m.MatterContact_Corporate AS Corperate,
			ct.[Description]  AS ContactType
			FROM  dbo.MatterContact m  WITH (NOLOCK)
			LEFT OUTER JOIN dbo.LookupCode r WITH (NOLOCK) on r.Code = m.MatterContact_RegionCode and r.LookupTypeCode = 'Region'
			LEFT OUTER JOIN dbo.MatterContactAddress a WITH (NOLOCK) on m.MatterContact_MatterContactID = a.MatterContactAddress_MatterContactID AND ISNULL(a.MatterContactAddress_Inactive, 0) = 0 AND ISNULL(a.MatterContactAddress_IsPrimary, 0) = 1
			LEFT OUTER JOIN dbo.LookupCode ct WITH (NOLOCK) on ct.Code = m.MatterContact_ContactType 
			WHERE (ISNULL(m.MatterContact_Inactive,0) = 0)
			AND (((ISNULL(@CompanyName,'') = '') OR (m.MatterContact_CompanyName LIKE '%' + @CompanyName + '%'))
			AND ((ISNULL(@Position,'') = '') OR (m.MatterContact_Position LIKE '%' + @Position + '%'))
			AND ((ISNULL(@Forename,'') = '') OR (m.MatterContact_Forename LIKE '%' + @Forename + '%'))
			AND ((ISNULL(@Surname,'') = '') OR (m.MatterContact_Surname LIKE '%' + @Surname + '%'))
			AND ((ISNULL(@DateofBirth,'') = '') OR (m.MatterContact_DOB = @DateofBirth))
			AND ((ISNULL(@Blockbook,'') = '') OR (m.MatterContact_Blockbook LIKE '%' + @Blockbook + '%'))
			AND ((ISNULL(@Expertise, '') = '') OR (m.MatterContact_FieldOfExpertise LIKE '%' + @Expertise + '%'))
			AND ((ISNULL(@Address1, '') = '') OR (a.MatterContactAddress_Address1 LIKE '%' + @Address1 + '%'))
			AND ((ISNULL(@PostCode, '') = '') OR (a.MatterContactAddress_Postcode LIKE '%' + @PostCode + '%'))
			AND ((ISNULL(@DXNumber, '') = '') OR (a.MatterContactAddress_DXNumber LIKE '%' + @DXNumber + '%'))
			AND ((ISNULL(@DXExchange, '') = '') OR (a.MatterContactAddress_DXExchange LIKE '%' + @DXExchange + '%'))
			AND ((ISNULL(@Region, '') = '') OR (r.[Description] LIKE '%' + @Region + '%')))
		) AS SHAPE 
		GROUP BY SHAPE.ContactID
		ORDER BY STARCRITERIA DESC
	END TRY
	
	BEGIN CATCH		
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH