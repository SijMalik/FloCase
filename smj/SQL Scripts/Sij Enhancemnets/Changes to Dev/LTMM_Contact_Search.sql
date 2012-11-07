
ALTER PROC [dbo].[LTMM_Contact_Search]
(
	@pContactTypeCode nvarchar(10) = null,
	@pCompanyName nvarchar(250) = null,
	@pPosition nvarchar(250) = null,
	@pForename nvarchar(250) = null,
	@pSurname nvarchar(250) = null,
	@pDateofBirth smalldatetime = Null,
	@pAddress1 nvarchar(50) = null,
	@pPostCode nvarchar(50) = null,
	@pDXNumber nvarchar(50) = null,
	@pDXExchange nvarchar(50) = null,
	@pRegion			nvarchar(250) = null,
	@pBlockbook		nvarchar(3) = null,
	@pExpertise		nvarchar(255) = null,
	@pUserName		nvarchar(255)  = nul			
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
	
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		3
	-- Modify date: 25-09-2012
	-- Description:	Removed call to concatenate functions as too many round trip calls
	-- ===============================================================			

	SET DATEFORMAT DMY
	DECLARE @pLOCATION nvarchar(10)
	DECLARE @ContactType nvarchar(250)
	
	DECLARE @MAXSELECTION int
	
	SET @MAXSELECTION = 100

	BEGIN TRY
		
		SELECT @pLOCATION = ContactLocation_Location 
		FROM dbo.ContactLocation WITH (NOLOCK) 
		WHERE ContactLocation_LookupCode = @pContactTypeCode
		
		SELECT @ContactType = [Description] 
		FROM dbo.LookupCode WITH (NOLOCK) 
		WHERE Code = @pContactTypeCode and LookupTypeCode = 'Contact'
		
		declare @resultsHigh table
		(
			id int identity(1,1),
			ContactID int,
			STARCRITERIA varchar(5),
			Name nvarchar(255), 
			[Address] nvarchar(255), 
			Expertise nvarchar(255),
			ContactTypeCode nvarchar(10),
			Corporate nvarchar(255),
			ContactType nvarchar(255)
		)
		
		declare @resultsMed table
		(
			id int identity(1,1),
			ContactID int,
			STARCRITERIA varchar(5),
			Name nvarchar(255), 
			[Address] nvarchar(255), 
			Expertise nvarchar(255),
			ContactTypeCode nvarchar(10),
			Corporate nvarchar(255),
			ContactType nvarchar(255)
		)
		declare @resultsLow table
		(
			id int identity(1,1),
			ContactID int,
			STARCRITERIA varchar(5),
			Name nvarchar(255), 
			[Address] nvarchar(255), 
			Expertise nvarchar(255),
			ContactTypeCode nvarchar(10),
			Corporate nvarchar(255),
			ContactType nvarchar(255)
		)

		declare @tParams nvarchar(255)
		declare @countHigh int
		declare @countMed int
		declare @countLow int
		
		IF (@pLOCATION = 'ADERANT')
		BEGIN 
			--PRINT  @pContactType
			IF @ContactType = 'Co-Defendant Solicitor'
			BEGIN
				SET @ContactType = 'Claimant Solicitor'
			END 
			ELSE IF @ContactType = 'Cost Assessor'
			BEGIN
				SET @ContactType = 'Court'
			END 
			insert into @resultsHigh
				SELECT distinct
					m.Contact_ContactID AS ContactID,
					'***' AS STARCRITERIA,
					
					CASE WHEN m.Contact_Corporate = 'N'
					THEN ISNULL(Contact_Title,'')  + ' ' + ISNULL(Contact_Forename,'') + ' ' + ISNULL(Contact_Surname, '')
					WHEN
					(ISNULL(Contact_Title,'') + ISNULL(Contact_Forename,'') + ISNULL(Contact_Surname, '')
					<> '' ) THEN	
					ISNULL(Contact_Title,'')  + ' ' + ISNULL(Contact_Forename,'') + ' ' + ISNULL(Contact_Surname, '') + ' ('+
					ISNULL(Contact_CompanyName, '') + ')'
					ELSE
					ISNULL(Contact_CompanyName, '') END	AS Name,						  
				--	[dbo].[ConcatenateContactName](m.Contact_ContactID,1) AS Name, 				
					ISNULL(ContactAddress_Address1, '') +
					case when (ContactAddress_Address2 <> '') then ', '+ContactAddress_Address2 else '' end +
					case when (ContactAddress_Address3 <> '') then ', '+ContactAddress_Address3 else '' end + 
					case when (ContactAddress_Address4 <> '') then ', '+ContactAddress_Address4 else '' end + 
					case when (ContactAddress_Town <> '') then ', '+ContactAddress_Town else '' end +
					case when (ContactAddress_Postcode <> '') then ', '+ContactAddress_Postcode else '' end +
					case when (ContactAddress_DXNumber <> '') then ', '+ContactAddress_DXNumber else '' end +
					case when (ContactAddress_DXExchange <> '') then ', '+ContactAddress_DXExchange else '' end [Address],
				--	[dbo].[ConcatenateContactAddress](m.Contact_ContactID) AS [Address],				 										
					m.Contact_FieldOfExpertise as Expertise,
					m.Contact_ContactType AS ContactTypeCode,
					m.Contact_Corporate AS Corporate,
					ct.[Description]  AS ContactType
				FROM  dbo.Contact m  WITH (NOLOCK)
				INNER JOIN dbo.LookupCode ct WITH (NOLOCK) on ct.Code = m.Contact_ContactType 
				LEFT OUTER JOIN dbo.LookupCode r WITH (NOLOCK) on r.Code = m.Contact_RegionCode and r.LookupTypeCode = 'Region'
				LEFT OUTER JOIN dbo.ContactAddress a WITH (NOLOCK) on m.Contact_ContactID = a.ContactAddress_ContactID AND ISNULL(a.ContactAddress_Inactive, 0) = 0
				WHERE (ISNULL(m.Contact_Inactive,0) = 0) 
					AND (ct.[Description] = @ContactType)
					AND (((ISNULL(@pCompanyName,'') = '') OR (m.Contact_CompanyName = @pCompanyName))
					AND ((ISNULL(@pPosition,'') = '') OR (m.Contact_Position = @pPosition))
					AND ((ISNULL(@pForename,'') = '') OR (m.Contact_Forename = @pForename))
					AND ((ISNULL(@pSurname,'') = '') OR (m.Contact_Surname = @pSurname))
					AND ((ISNULL(@pDateofBirth,'') = '') OR (m.Contact_DOB = @pDateofBirth))
					AND ((ISNULL(@pBlockbook,'') = '') OR (m.Contact_Blockbook = @pBlockbook))
					AND ((ISNULL(@pExpertise, '') = '') OR (m.Contact_FieldOfExpertise = @pExpertise))
					AND ((ISNULL(@pAddress1, '') = '') OR (a.ContactAddress_Address1 = @pAddress1))
					AND ((ISNULL(@pPostCode, '') = '') OR (a.ContactAddress_Postcode = @pPostCode))
					AND ((ISNULL(@pDXNumber, '') = '') OR (a.ContactAddress_DXNumber = @pDXNumber))
					AND ((ISNULL(@pDXExchange, '') = '') OR (a.ContactAddress_DXExchange = @pDXExchange))
					AND ((ISNULL(@pRegion, '') = '') OR (r.[Description] = @pRegion)))

			select @countHigh = COUNT(ContactID) from @resultsHigh
			if(@countHigh < @MAXSELECTION)
			BEGIN	
			insert into @resultsMed
				SELECT distinct
				m.Contact_ContactID AS ContactID,
				'**' AS STARCRITERIA,
				
				CASE WHEN m.Contact_Corporate = 'N'
				THEN ISNULL(Contact_Title,'')  + ' ' + ISNULL(Contact_Forename,'') + ' ' + ISNULL(Contact_Surname, '')
				WHEN
				(ISNULL(Contact_Title,'') + ISNULL(Contact_Forename,'') + ISNULL(Contact_Surname, '')
				<> '' ) THEN	
				ISNULL(Contact_Title,'')  + ' ' + ISNULL(Contact_Forename,'') + ' ' + ISNULL(Contact_Surname, '') + ' ('+
				ISNULL(Contact_CompanyName, '') + ')'
				ELSE
				ISNULL(Contact_CompanyName, '') END	AS Name,								
				--[dbo].[ConcatenateContactName](m.Contact_ContactID,1) AS Name,
				ISNULL(ContactAddress_Address1, '') +
				case when (ContactAddress_Address2 <> '') then ', '+ContactAddress_Address2 else '' end +
				case when (ContactAddress_Address3 <> '') then ', '+ContactAddress_Address3 else '' end + 
				case when (ContactAddress_Address4 <> '') then ', '+ContactAddress_Address4 else '' end + 
				case when (ContactAddress_Town <> '') then ', '+ContactAddress_Town else '' end +
				case when (ContactAddress_Postcode <> '') then ', '+ContactAddress_Postcode else '' end +
				case when (ContactAddress_DXNumber <> '') then ', '+ContactAddress_DXNumber else '' end +
				case when (ContactAddress_DXExchange <> '') then ', '+ContactAddress_DXExchange else '' end [Address],			 
				--[dbo].[ConcatenateContactAddress](m.Contact_ContactID) AS [Address], 
				m.Contact_FieldOfExpertise as Expertise,
				m.Contact_ContactType AS ContactTypeCode,
				m.Contact_Corporate AS Corporate,
				ct.[Description]  AS ContactType
				FROM  dbo.Contact m  WITH (NOLOCK)
				LEFT OUTER JOIN dbo.LookupCode r WITH (NOLOCK) on r.Code = m.Contact_RegionCode and r.LookupTypeCode = 'Region'
				LEFT OUTER JOIN dbo.ContactAddress a WITH (NOLOCK) on m.Contact_ContactID = a.ContactAddress_ContactID AND ISNULL(a.ContactAddress_Inactive, 0) = 0
				LEFT OUTER JOIN dbo.LookupCode ct WITH (NOLOCK) on ct.Code = m.Contact_ContactType 
				WHERE (ISNULL(m.Contact_Inactive,0) = 0) AND (ct.[Description] = @ContactType)
				AND (((ISNULL(@pCompanyName,'') = '') OR (m.Contact_CompanyName like @pCompanyName+'%'))
				AND ((ISNULL(@pPosition,'') = '') OR (m.Contact_Position like @pPosition+'%'))
				AND ((ISNULL(@pForename,'') = '') OR (m.Contact_Forename like @pForename+'%'))
				AND ((ISNULL(@pSurname,'') = '') OR (m.Contact_Surname like @pSurname+'%'))
				AND ((ISNULL(@pDateofBirth,'') = '') OR (m.Contact_DOB = @pDateofBirth))
				AND ((ISNULL(@pBlockbook,'') = '') OR (m.Contact_Blockbook like @pBlockbook+'%'))
				AND ((ISNULL(@pExpertise, '') = '') OR (m.Contact_FieldOfExpertise like @pExpertise+'%'))
				AND ((ISNULL(@pAddress1, '') = '') OR (a.ContactAddress_Address1 like @pAddress1+'%'))
				AND ((ISNULL(@pPostCode, '') = '') OR (a.ContactAddress_Postcode like @pPostCode+'%'))
				AND ((ISNULL(@pDXNumber, '') = '') OR (a.ContactAddress_DXNumber like @pDXNumber+'%'))
				AND ((ISNULL(@pDXExchange, '') = '') OR (a.ContactAddress_DXExchange like @pDXExchange+'%'))
				AND ((ISNULL(@pRegion, '') = '') OR (r.[Description] like @pRegion+'%')))
				END
				
				select @countHigh = COUNT(ContactID) from @resultsHigh
				select @countMed = COUNT(ContactID) from @resultsMed
				
				
			if(@countHigh+@countMed < @MAXSELECTION)
			BEGIN
				insert into @resultsLow
				SELECT distinct
					m.Contact_ContactID AS ContactID,
					'*' AS STARCRITERIA,
					
					CASE WHEN m.Contact_Corporate = 'N'
					THEN ISNULL(Contact_Title,'')  + ' ' + ISNULL(Contact_Forename,'') + ' ' + ISNULL(Contact_Surname, '')
					WHEN
					(ISNULL(Contact_Title,'') + ISNULL(Contact_Forename,'') + ISNULL(Contact_Surname, '')
					<> '' ) THEN	
					ISNULL(Contact_Title,'')  + ' ' + ISNULL(Contact_Forename,'') + ' ' + ISNULL(Contact_Surname, '') + ' ('+
					ISNULL(Contact_CompanyName, '') + ')'
					ELSE
					ISNULL(Contact_CompanyName, '') END	AS Name,										
					--[dbo].[ConcatenateContactName](m.Contact_ContactID,1) AS Name, 
					ISNULL(ContactAddress_Address1, '') +
					case when (ContactAddress_Address2 <> '') then ', '+ContactAddress_Address2 else '' end +
					case when (ContactAddress_Address3 <> '') then ', '+ContactAddress_Address3 else '' end + 
					case when (ContactAddress_Address4 <> '') then ', '+ContactAddress_Address4 else '' end + 
					case when (ContactAddress_Town <> '') then ', '+ContactAddress_Town else '' end +
					case when (ContactAddress_Postcode <> '') then ', '+ContactAddress_Postcode else '' end +
					case when (ContactAddress_DXNumber <> '') then ', '+ContactAddress_DXNumber else '' end +
					case when (ContactAddress_DXExchange <> '') then ', '+ContactAddress_DXExchange else '' end [Address],					
					--[dbo].[ConcatenateContactAddress](m.Contact_ContactID) AS [Address], 
					m.Contact_FieldOfExpertise as Expertise,
					m.Contact_ContactType AS ContactTypeCode,
					m.Contact_Corporate AS Corporate,
					ct.[Description]  AS ContactType
				FROM  dbo.Contact m  WITH (NOLOCK)
				LEFT OUTER JOIN dbo.LookupCode r WITH (NOLOCK) on r.Code = m.Contact_RegionCode and r.LookupTypeCode = 'Region'
				LEFT OUTER JOIN dbo.ContactAddress a WITH (NOLOCK) on m.Contact_ContactID = a.ContactAddress_ContactID AND ISNULL(a.ContactAddress_Inactive, 0) = 0
				LEFT OUTER JOIN dbo.LookupCode ct WITH (NOLOCK) on ct.Code = m.Contact_ContactType 
				WHERE (ISNULL(m.Contact_Inactive,0) = 0)  AND (ct.[Description] = @ContactType)
				AND (((ISNULL(@pCompanyName,'') = '') OR (m.Contact_CompanyName like '%'+@pCompanyName+'%'))
				AND ((ISNULL(@pPosition,'') = '') OR (m.Contact_Position like '%'+@pPosition+'%'))
				AND ((ISNULL(@pForename,'') = '') OR (m.Contact_Forename like '%'+@pForename+'%'))
				AND ((ISNULL(@pSurname,'') = '') OR (m.Contact_Surname like '%'+@pSurname+'%'))
				AND ((ISNULL(@pDateofBirth,'') = '') OR (m.Contact_DOB = @pDateofBirth))
				AND ((ISNULL(@pBlockbook,'') = '') OR (m.Contact_Blockbook like '%'+@pBlockbook+'%'))
				AND ((ISNULL(@pExpertise, '') = '') OR (m.Contact_FieldOfExpertise like '%'+@pExpertise+'%'))
				AND ((ISNULL(@pAddress1, '') = '') OR (a.ContactAddress_Address1 like '%'+@pAddress1+'%'))
				AND ((ISNULL(@pPostCode, '') = '') OR (a.ContactAddress_Postcode like '%'+@pPostCode+'%'))
				AND ((ISNULL(@pDXNumber, '') = '') OR (a.ContactAddress_DXNumber like '%'+@pDXNumber+'%'))
				AND ((ISNULL(@pDXExchange, '') = '') OR (a.ContactAddress_DXExchange like '%'+@pDXExchange+'%'))
				AND ((ISNULL(@pRegion, '') = '') OR (r.[Description] like '%'+@pRegion+'%')))
			END
			
			
		END
		ELSE
		BEGIN
			IF (@pLOCATION = 'FLOSUITE')
			BEGIN 
				insert into @resultsHigh
				SELECT distinct
				m.MatterContact_MatterContactID AS ContactID,
				'***' AS STARCRITERIA,

				CASE WHEN m.MatterContact_Corporate = 'N'
				THEN ISNULL(MatterContact_Title,'')  + ' ' + ISNULL(MatterContact_Forename,'') + ' ' + ISNULL(MatterContact_Surname, '')
				ELSE ISNULL(MatterContact_CompanyName, '') END AS Name,					
				--[dbo].[ConcatenateMatterContactName](m.MatterContact_MatterContactID) Name, 
				ISNULL(MatterContactAddress_Address1, '') +
				case when (MatterContactAddress_Address2 <> '') then ', '+MatterContactAddress_Address2 else '' end +
				case when (MatterContactAddress_Address3 <> '') then ', '+MatterContactAddress_Address3 else '' end + 
				case when (MatterContactAddress_Address4 <> '') then ', '+MatterContactAddress_Address4 else '' end + 
				case when (MatterContactAddress_Town <> '') then ', '+MatterContactAddress_Town else '' end +
				case when (MatterContactAddress_Postcode <> '') then ', '+MatterContactAddress_Postcode else '' end +
				case when (MatterContactAddress_DXNumber <> '') then ', '+MatterContactAddress_DXNumber else '' end +
				case when (MatterContactAddress_DXExchange <> '') then ', '+MatterContactAddress_DXExchange else '' end	AS [Address],							
				--[dbo].[ConcatenateMatterContactAddress](m.MatterContact_MatterContactID) AS [Address], 				
				m.MatterContact_FieldOfExpertise as Expertise,
				m.MatterContact_ContactType AS ContactTypeCode,
				m.MatterContact_Corporate AS Corporate,
				ct.[Description]  AS ContactType
				FROM  dbo.MatterContact m  WITH (NOLOCK)
				LEFT OUTER JOIN dbo.LookupCode r WITH (NOLOCK) on r.Code = m.MatterContact_RegionCode and r.LookupTypeCode = 'Region'
				LEFT OUTER JOIN dbo.MatterContactAddress a WITH (NOLOCK) on m.MatterContact_MatterContactID = a.MatterContactAddress_MatterContactID AND ISNULL(a.MatterContactAddress_Inactive, 0) = 0 AND ISNULL(a.MatterContactAddress_IsPrimary, 0) = 1
				LEFT OUTER JOIN dbo.LookupCode ct WITH (NOLOCK) on ct.Code = m.MatterContact_ContactType 
				WHERE (ISNULL(m.MatterContact_Inactive,0) = 0)
				AND (((ISNULL(@pCompanyName,'') = '') OR (m.MatterContact_CompanyName = @pCompanyName))
				AND ((ISNULL(@pPosition,'') = '') OR (m.MatterContact_Position = @pPosition))
				AND ((ISNULL(@pForename,'') = '') OR (m.MatterContact_Forename = @pForename))
				AND ((ISNULL(@pSurname,'') = '') OR (m.MatterContact_Surname = @pSurname))
				AND ((ISNULL(@pDateofBirth,'') = '') OR (m.MatterContact_DOB = @pDateofBirth))
				AND ((ISNULL(@pBlockbook,'') = '') OR (m.MatterContact_Blockbook = @pBlockbook))
				AND ((ISNULL(@pExpertise, '') = '') OR (m.MatterContact_FieldOfExpertise = @pExpertise))
				AND ((ISNULL(@pAddress1, '') = '') OR (a.MatterContactAddress_Address1 = @pAddress1))
				AND ((ISNULL(@pPostCode, '') = '') OR (a.MatterContactAddress_Postcode = @pPostCode))
				AND ((ISNULL(@pDXNumber, '') = '') OR (a.MatterContactAddress_DXNumber = @pDXNumber))
				AND ((ISNULL(@pDXExchange, '') = '') OR (a.MatterContactAddress_DXExchange = @pDXExchange))
				AND ((ISNULL(@pRegion, '') = '') OR (r.[Description] = @pRegion)))
				AND a.MatterContactAddress_IsPrimary = 1
			
				select @countHigh = COUNT(ContactID) from @resultsHigh
			if(@countHigh < @MAXSELECTION)
			BEGIN
			insert into @resultsMed
				SELECT distinct
				m.MatterContact_MatterContactID AS ContactID,
				'**' AS STARCRITERIA,
				CASE WHEN m.MatterContact_Corporate = 'N'
				THEN ISNULL(MatterContact_Title,'')  + ' ' + ISNULL(MatterContact_Forename,'') + ' ' + ISNULL(MatterContact_Surname, '')
				ELSE ISNULL(MatterContact_CompanyName, '') END AS Name,								
				--[dbo].[ConcatenateMatterContactName](m.MatterContact_MatterContactID) Name, 
				ISNULL(MatterContactAddress_Address1, '') +
				case when (MatterContactAddress_Address2 <> '') then ', '+MatterContactAddress_Address2 else '' end +
				case when (MatterContactAddress_Address3 <> '') then ', '+MatterContactAddress_Address3 else '' end + 
				case when (MatterContactAddress_Address4 <> '') then ', '+MatterContactAddress_Address4 else '' end + 
				case when (MatterContactAddress_Town <> '') then ', '+MatterContactAddress_Town else '' end +
				case when (MatterContactAddress_Postcode <> '') then ', '+MatterContactAddress_Postcode else '' end +
				case when (MatterContactAddress_DXNumber <> '') then ', '+MatterContactAddress_DXNumber else '' end +
				case when (MatterContactAddress_DXExchange <> '') then ', '+MatterContactAddress_DXExchange else '' end	AS [Address],											
				--[dbo].[ConcatenateMatterContactAddress](m.MatterContact_MatterContactID) AS [Address], 
				m.MatterContact_FieldOfExpertise as Expertise,
				m.MatterContact_ContactType AS ContactTypeCode,
				m.MatterContact_Corporate AS Corporate,
				ct.[Description]  AS ContactType
				FROM  dbo.MatterContact m  WITH (NOLOCK)
				LEFT OUTER JOIN dbo.LookupCode r WITH (NOLOCK) on r.Code = m.MatterContact_RegionCode and r.LookupTypeCode = 'Region'
				LEFT OUTER JOIN dbo.MatterContactAddress a WITH (NOLOCK) on m.MatterContact_MatterContactID = a.MatterContactAddress_MatterContactID AND ISNULL(a.MatterContactAddress_Inactive, 0) = 0 AND ISNULL(a.MatterContactAddress_IsPrimary, 0) = 1
				LEFT OUTER JOIN dbo.LookupCode ct WITH (NOLOCK) on ct.Code = m.MatterContact_ContactType 
				WHERE (ISNULL(m.MatterContact_Inactive,0) = 0)
				AND (((ISNULL(@pCompanyName,'') = '') OR (m.MatterContact_CompanyName like @pCompanyName+'%'))
				AND ((ISNULL(@pPosition,'') = '') OR (m.MatterContact_Position like @pPosition+'%'))
				AND ((ISNULL(@pForename,'') = '') OR (m.MatterContact_Forename like @pForename+'%'))
				AND ((ISNULL(@pSurname,'') = '') OR (m.MatterContact_Surname like @pSurname+'%'))
				AND ((ISNULL(@pDateofBirth,'') = '') OR (m.MatterContact_DOB = @pDateofBirth))
				AND ((ISNULL(@pBlockbook,'') = '') OR (m.MatterContact_Blockbook like @pBlockbook+'%'))
				AND ((ISNULL(@pExpertise, '') = '') OR (m.MatterContact_FieldOfExpertise like @pExpertise+'%'))
				AND ((ISNULL(@pAddress1, '') = '') OR (a.MatterContactAddress_Address1 like @pAddress1+'%'))
				AND ((ISNULL(@pPostCode, '') = '') OR (a.MatterContactAddress_Postcode like @pPostCode+'%'))
				AND ((ISNULL(@pDXNumber, '') = '') OR (a.MatterContactAddress_DXNumber like @pDXNumber+'%'))
				AND ((ISNULL(@pDXExchange, '') = '') OR (a.MatterContactAddress_DXExchange like @pDXExchange+'%'))
				AND ((ISNULL(@pRegion, '') = '') OR (r.[Description] like @pRegion+'%')))
			
				END
				select @countHigh = COUNT(ContactID) from @resultsHigh
				select @countMed = COUNT(ContactID) from @resultsMed
			if(@countHigh + @countMed < @MAXSELECTION)
			BEGIN
				insert into @resultsLow
				SELECT distinct
				m.MatterContact_MatterContactID AS ContactID,
				'*' AS STARCRITERIA,
				CASE WHEN m.MatterContact_Corporate = 'N'
				THEN ISNULL(MatterContact_Title,'')  + ' ' + ISNULL(MatterContact_Forename,'') + ' ' + ISNULL(MatterContact_Surname, '')
				ELSE ISNULL(MatterContact_CompanyName, '') END AS Name,								
				--[dbo].[ConcatenateMatterContactName](m.MatterContact_MatterContactID) Name, 
				ISNULL(MatterContactAddress_Address1, '') +
				case when (MatterContactAddress_Address2 <> '') then ', '+MatterContactAddress_Address2 else '' end +
				case when (MatterContactAddress_Address3 <> '') then ', '+MatterContactAddress_Address3 else '' end + 
				case when (MatterContactAddress_Address4 <> '') then ', '+MatterContactAddress_Address4 else '' end + 
				case when (MatterContactAddress_Town <> '') then ', '+MatterContactAddress_Town else '' end +
				case when (MatterContactAddress_Postcode <> '') then ', '+MatterContactAddress_Postcode else '' end +
				case when (MatterContactAddress_DXNumber <> '') then ', '+MatterContactAddress_DXNumber else '' end +
				case when (MatterContactAddress_DXExchange <> '') then ', '+MatterContactAddress_DXExchange else '' end	AS [Address],											
				--[dbo].[ConcatenateMatterContactAddress](m.MatterContact_MatterContactID) AS [Address], 
				m.MatterContact_FieldOfExpertise as Expertise,
				m.MatterContact_ContactType AS ContactTypeCode,
				m.MatterContact_Corporate AS Corporate,
				ct.[Description]  AS ContactType
				FROM  dbo.MatterContact m  WITH (NOLOCK)
				LEFT OUTER JOIN dbo.LookupCode r WITH (NOLOCK) on r.Code = m.MatterContact_RegionCode and r.LookupTypeCode = 'Region'
				LEFT OUTER JOIN dbo.MatterContactAddress a WITH (NOLOCK) on m.MatterContact_MatterContactID = a.MatterContactAddress_MatterContactID AND ISNULL(a.MatterContactAddress_Inactive, 0) = 0 AND ISNULL(a.MatterContactAddress_IsPrimary, 0) = 1
				LEFT OUTER JOIN dbo.LookupCode ct WITH (NOLOCK) on ct.Code = m.MatterContact_ContactType 
				WHERE (ISNULL(m.MatterContact_Inactive,0) = 0)
				AND (((ISNULL(@pCompanyName,'') = '') OR (m.MatterContact_CompanyName like '%'+@pCompanyName+'%'))
				AND ((ISNULL(@pPosition,'') = '') OR (m.MatterContact_Position like '%'+@pPosition+'%'))
				AND ((ISNULL(@pForename,'') = '') OR (m.MatterContact_Forename like '%'+@pForename+'%'))
				AND ((ISNULL(@pSurname,'') = '') OR (m.MatterContact_Surname like '%'+@pSurname+'%'))
				AND ((ISNULL(@pDateofBirth,'') = '') OR (m.MatterContact_DOB = @pDateofBirth))
				AND ((ISNULL(@pBlockbook,'') = '') OR (m.MatterContact_Blockbook like '%'+@pBlockbook+'%'))
				AND ((ISNULL(@pExpertise, '') = '') OR (m.MatterContact_FieldOfExpertise like '%'+@pExpertise+'%'))
				AND ((ISNULL(@pAddress1, '') = '') OR (a.MatterContactAddress_Address1 like '%'+@pAddress1+'%'))
				AND ((ISNULL(@pPostCode, '') = '') OR (a.MatterContactAddress_Postcode like '%'+@pPostCode+'%'))
				AND ((ISNULL(@pDXNumber, '') = '') OR (a.MatterContactAddress_DXNumber like '%'+@pDXNumber+'%'))
				AND ((ISNULL(@pDXExchange, '') = '') OR (a.MatterContactAddress_DXExchange like '%'+@pDXExchange+'%'))
				AND ((ISNULL(@pRegion, '') = '') OR (r.[Description] like '%'+@pRegion+'%')))

				END
			END
			 
		END


		select distinct top 100
		max(ContactID) as ContactID,
				max(starcriteria) as STARCRITERIA,
				max(Name) as Name, 
				max([Address]) as [Address], 
				max(Expertise) as Expertise,
				max (ContactTypeCode) as ContactTypeCode,
				max (Corporate) as Corporate,
				max (ContactType) as ContactType
		from
		(
		select  
				ContactID,
				STARCRITERIA as STARCRITERIA,
				Name, 
				[Address], 
				Expertise,
				ContactTypeCode,
				Corporate,
				ContactType
		from @resultsHigh
		union
		select 
				ContactID,
				STARCRITERIA as STARCRITERIA,
				Name, 
				[Address], 
				Expertise,
				ContactTypeCode,
				Corporate,
				ContactType
		from @resultsMed r
		union
		select 
				ContactID,
				STARCRITERIA as STARCRITERIA,
				Name, 
				[Address], 
				Expertise,
				ContactTypeCode,
				Corporate,
				ContactType
		from @resultsLow

		) as shape
		GROUP BY SHAPE.ContactID
			ORDER BY STARCRITERIA DESC

	END TRY
	
	BEGIN CATCH		
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH