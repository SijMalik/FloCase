USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[LTMM_ContactSearch_Fetch]    Script Date: 09/24/2012 18:07:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[LTMM_ContactSearch_Fetch]
(
	@ContactType	nvarchar(250) = '',
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
	@Expertise		nvarchar(255) = ''			
)
AS
	--Stored Procedure to fetch a set of Matter Contacts based on the criteria entered
	--Author(s) GQL
	--30-07-2009
	--GQL AMENDED 06-04-11 :TO REMOVE DEPENDANCE ON LEFT OUTER JOINS 
	--						AND IMPROVE PERFORMANCE OF CONDITIONAL FILTERS
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================		
	
	SET DATEFORMAT DMY
	
	BEGIN TRY
	
		--REMOVE ' FROM SEARCH
		SELECT @ContactType = REPLACE(@ContactType, '''', ''), 
		@CompanyName = REPLACE(@CompanyName, '''', ''), 
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
		'Global Contact' AS [Source]
		FROM (	
			SELECT
			c.Contact_ContactID AS ContactID,
			'***' AS STARCRITERIA,
			c.Contact_CompanyName AS CompanyName, 
			c.Contact_Position AS Position, 
			c.Contact_Forename AS Forename, 
			c.Contact_Surname AS Surname, 
			c.Contact_DOB AS DateofBirth,
			a.ContactAddress_Address1 AS Address1, 
			a.ContactAddress_Postcode as Postcode, 
			a.ContactAddress_DXNumber AS DXNumber, 	
			a.ContactAddress_DXExchange AS DXExchange,
			r.[Description] AS Region,
			c.Contact_Blockbook as Blockbook,
			c.Contact_FieldOfExpertise as Expertise,
			c.Contact_ContactType AS ContactTypeCode,
			c.Contact_Corporate AS Corperate,
			ct.[Description]  AS ContactType
			FROM  dbo.Contact c  WITH (NOLOCK)
			LEFT OUTER JOIN dbo.LookupCode r WITH (NOLOCK) on r.Code = c.Contact_RegionCode and r.LookupTypeCode = 'Region'
			LEFT OUTER JOIN dbo.ContactAddress a WITH (NOLOCK) on c.Contact_ContactID = a.ContactAddress_ContactID AND ISNULL(a.ContactAddress_Inactive, 0) = 0
			LEFT OUTER JOIN dbo.LookupCode ct WITH (NOLOCK) on ct.Code = c.Contact_ContactType 
			WHERE (ISNULL(c.Contact_Inactive,0) = 0) AND (ct.[Description] = @ContactType)
			AND (((ISNULL(@CompanyName,'') = '') OR (c.Contact_CompanyName = @CompanyName))
			AND ((ISNULL(@Position,'') = '') OR (c.Contact_Position = @Position))
			AND ((ISNULL(@Forename,'') = '') OR (c.Contact_Forename = @Forename))
			AND ((ISNULL(@Surname,'') = '') OR (c.Contact_Surname = @Surname))
			AND ((ISNULL(@DateofBirth,'') = '') OR (c.Contact_DOB = @DateofBirth))
			AND ((ISNULL(@Blockbook,'') = '') OR (c.Contact_Blockbook = @Blockbook))
			AND ((ISNULL(@Expertise, '') = '') OR (c.Contact_FieldOfExpertise = @Expertise))
			AND ((ISNULL(@Address1, '') = '') OR (a.ContactAddress_Address1 = @Address1))
			AND ((ISNULL(@PostCode, '') = '') OR (a.ContactAddress_Postcode = @PostCode))
			AND ((ISNULL(@DXNumber, '') = '') OR (a.ContactAddress_DXNumber = @DXNumber))
			AND ((ISNULL(@DXExchange, '') = '') OR (a.ContactAddress_DXExchange = @DXExchange))
			AND ((ISNULL(@Region, '') = '') OR (r.[Description] = @Region)))
			UNION
			SELECT
			c.Contact_ContactID AS ContactID,
			'**' AS STARCRITERIA,
			c.Contact_CompanyName AS CompanyName, 
			c.Contact_Position AS Position, 
			c.Contact_Forename AS Forename, 
			c.Contact_Surname AS Surname, 
			c.Contact_DOB AS DateofBirth,
			a.ContactAddress_Address1 AS Address1, 
			a.ContactAddress_Postcode as Postcode, 
			a.ContactAddress_DXNumber AS DXNumber, 	
			a.ContactAddress_DXExchange AS DXExchange,
			r.[Description] AS Region,
			c.Contact_Blockbook as Blockbook,
			c.Contact_FieldOfExpertise as Expertise,
			c.Contact_ContactType AS ContactTypeCode,
			c.Contact_Corporate AS Corperate,
			ct.[Description]  AS ContactType
			FROM  dbo.Contact c  WITH (NOLOCK)
			LEFT OUTER JOIN dbo.LookupCode r WITH (NOLOCK) on r.Code = c.Contact_RegionCode and r.LookupTypeCode = 'Region'
			LEFT OUTER JOIN dbo.ContactAddress a WITH (NOLOCK) on c.Contact_ContactID = a.ContactAddress_ContactID AND ISNULL(a.ContactAddress_Inactive, 0) = 0
			LEFT OUTER JOIN dbo.LookupCode ct WITH (NOLOCK) on ct.Code = c.Contact_ContactType 
			WHERE (ISNULL(c.Contact_Inactive,0) = 0) AND (ct.[Description] = @ContactType)
			AND (((ISNULL(@CompanyName,'') = '') OR (c.Contact_CompanyName like @CompanyName + '%'))
			AND ((ISNULL(@Position,'') = '') OR (c.Contact_Position like @Position + '%'))
			AND ((ISNULL(@Forename,'') = '') OR (c.Contact_Forename like @Forename + '%'))
			AND ((ISNULL(@Surname,'') = '') OR (c.Contact_Surname like @Surname + '%'))
			AND ((ISNULL(@DateofBirth,'') = '') OR (c.Contact_DOB = @DateofBirth))
			AND ((ISNULL(@Blockbook,'') = '') OR (c.Contact_Blockbook like @Blockbook + '%'))
			AND ((ISNULL(@Expertise, '') = '') OR (c.Contact_FieldOfExpertise like @Expertise + '%'))
			AND ((ISNULL(@Address1, '') = '') OR (a.ContactAddress_Address1 like @Address1 + '%'))
			AND ((ISNULL(@PostCode, '') = '') OR (a.ContactAddress_Postcode like @PostCode + '%'))
			AND ((ISNULL(@DXNumber, '') = '') OR (a.ContactAddress_DXNumber like @DXNumber + '%'))
			AND ((ISNULL(@DXExchange, '') = '') OR (a.ContactAddress_DXExchange like @DXExchange + '%'))
			AND ((ISNULL(@Region, '') = '') OR (r.[Description] like @Region + '%')))
			UNION
			SELECT
			c.Contact_ContactID AS ContactID,
			'*' AS STARCRITERIA,
			c.Contact_CompanyName AS CompanyName, 
			c.Contact_Position AS Position, 
			c.Contact_Forename AS Forename, 
			c.Contact_Surname AS Surname, 
			c.Contact_DOB AS DateofBirth,
			a.ContactAddress_Address1 AS Address1, 
			a.ContactAddress_Postcode as Postcode, 
			a.ContactAddress_DXNumber AS DXNumber, 	
			a.ContactAddress_DXExchange AS DXExchange,
			r.[Description] AS Region,
			c.Contact_Blockbook as Blockbook,
			c.Contact_FieldOfExpertise as Expertise,
			c.Contact_ContactType AS ContactTypeCode,
			c.Contact_Corporate AS Corperate,
			ct.[Description]  AS ContactType
			FROM  dbo.Contact c  WITH (NOLOCK)
			LEFT OUTER JOIN dbo.LookupCode r WITH (NOLOCK) on r.Code = c.Contact_RegionCode and r.LookupTypeCode = 'Region'
			LEFT OUTER JOIN dbo.ContactAddress a WITH (NOLOCK) on c.Contact_ContactID = a.ContactAddress_ContactID AND ISNULL(a.ContactAddress_Inactive, 0) = 0
			LEFT OUTER JOIN dbo.LookupCode ct WITH (NOLOCK) on ct.Code = c.Contact_ContactType 
			WHERE (ISNULL(c.Contact_Inactive,0) = 0) AND (ct.[Description] = @ContactType)
			AND (((ISNULL(@CompanyName,'') = '') OR (c.Contact_CompanyName like '%' + @CompanyName + '%'))
			AND ((ISNULL(@Position,'') = '') OR (c.Contact_Position like '%' + @Position + '%'))
			AND ((ISNULL(@Forename,'') = '') OR (c.Contact_Forename like '%' + @Forename + '%'))
			AND ((ISNULL(@Surname,'') = '') OR (c.Contact_Surname like '%' + @Surname + '%'))
			AND ((ISNULL(@DateofBirth,'') = '') OR (c.Contact_DOB = @DateofBirth))
			AND ((ISNULL(@Blockbook,'') = '') OR (c.Contact_Blockbook like '%' + @Blockbook + '%'))
			AND ((ISNULL(@Expertise, '') = '') OR (c.Contact_FieldOfExpertise like '%' + @Expertise + '%'))
			AND ((ISNULL(@Address1, '') = '') OR (a.ContactAddress_Address1 like '%' + @Address1 + '%'))
			AND ((ISNULL(@PostCode, '') = '') OR (a.ContactAddress_Postcode like '%' + @PostCode + '%'))
			AND ((ISNULL(@DXNumber, '') = '') OR (a.ContactAddress_DXNumber like '%' + @DXNumber + '%'))
			AND ((ISNULL(@DXExchange, '') = '') OR (a.ContactAddress_DXExchange like '%' + @DXExchange + '%'))
			AND ((ISNULL(@Region, '') = '') OR (r.[Description] like '%' + @Region + '%')))
		) AS SHAPE 
		GROUP BY SHAPE.ContactID
		ORDER BY STARCRITERIA DESC
	END TRY
	
	BEGIN CATCH		
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH	
