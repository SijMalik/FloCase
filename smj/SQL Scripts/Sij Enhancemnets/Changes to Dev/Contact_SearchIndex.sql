
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Contact]') AND name = N'Contact_SearchIndex')
DROP INDEX [Contact_SearchIndex] ON [dbo].[Contact] WITH ( ONLINE = OFF )
GO


/****** Object:  Index [Contact_ContactType]    Script Date: 09/24/2012 10:27:07 ******/
CREATE NONCLUSTERED INDEX [Contact_SearchIndex] ON [dbo].[Contact] 
(
	Contact_Inactive,
	Contact_RegionCode,
	Contact_ContactID,
	Contact_CompanyName,
	Contact_DOB,
	Contact_Blockbook

)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
