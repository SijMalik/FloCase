
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[MIFieldDefinition]') AND name = N'MIFieldDefinition_DataField')
DROP INDEX MIFieldDefinition_DataField ON [dbo].MIFieldDefinition WITH ( ONLINE = OFF )
GO


/****** Object:  Index [Contact_ContactType]    Script Date: 09/12/2012 14:17:07 ******/
CREATE NONCLUSTERED INDEX MIFieldDefinition_DataField ON [dbo].MIFieldDefinition 
(
	MIFieldDefinition_DataField
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
