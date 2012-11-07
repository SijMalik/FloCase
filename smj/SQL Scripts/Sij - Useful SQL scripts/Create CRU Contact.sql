--REPLCAE VALUES AS APPROPRIATE
declare @contid as int = 0

INSERT INTO [dbo].[Contact]
           ([Contact_ContactType]
           ,[Contact_Corporate]
           ,[Contact_CompanyName]
           ,[Contact_Inactive]
           ,[CreateUser]
           ,[CreateDate]
           ,[RefContactType_RefContactTypeID]
           ,[ReferenceDB_SourceID])
     VALUES
           ('EXPERT'
           ,'Y'
           ,'The Compensation Recovery Unit'
           ,0
           ,'GQL'
           ,GETDATE()
           ,0
           ,0)

select @contid = max(Contact_ContactID) from Contact 

INSERT INTO [dbo].[ContactAddress]
           ([ContactAddress_ContactID]
           ,[ContactAddress_AddressType]
           ,[ContactAddress_Address1]
           ,[ContactAddress_Town]
           ,[ContactAddress_County]
           ,[ContactAddress_Postcode]
           ,[ContactAddress_Country]
           ,[ContactAddress_DXNumber]
           ,[ContactAddress_DXExchange]
           ,[ContactAddress_AddressOrder]
           ,[ContactAddress_Inactive]
           ,[CreateUser]
           ,[CreateDate])
     VALUES
           (@contid
           ,'Business'
           ,'Durham House'
           ,'Washington'
           ,'Tyne and Wear'
           ,'NE38 7SF'
           ,'United Kingdom'
           ,'DX: 68560'
           ,'Washington 4'
           ,0
           ,0
           ,'SMJ'
           ,GETDATE())
GO