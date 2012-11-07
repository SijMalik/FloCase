IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ClientMIDefinition]') AND name = N'ClientMIDefinition_MIDEFCODE')
	DROP INDEX ClientMIDefinition_MIDEFCODE ON [dbo].ClientMIDefinition
GO
CREATE NONCLUSTERED INDEX ClientMIDefinition_MIDEFCODE ON [dbo].ClientMIDefinition (ClientMIDefinition_MIDEFCODE ASC)
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ClientMIFieldSet]') AND name = N'ClientMIFieldSet_ClientMIDEFCODE')
	DROP INDEX ClientMIFieldSet_ClientMIDEFCODE ON [dbo].ClientMIFieldSet
GO
CREATE NONCLUSTERED INDEX ClientMIFieldSet_ClientMIDEFCODE ON [dbo].ClientMIFieldSet (ClientMIFieldSet_ClientMIDEFCODE ASC)
GO
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ClientMIFieldSet]') AND name = N'ClientMIFieldSet_MIFieldPosition')
	DROP INDEX ClientMIFieldSet_MIFieldPosition ON [dbo].ClientMIFieldSet
GO
CREATE NONCLUSTERED INDEX ClientMIFieldSet_MIFieldPosition ON [dbo].ClientMIFieldSet (ClientMIFieldSet_ClientMIDEFCODE ASC)
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[MIFieldDefinition]') AND name = N'MIFieldDefinition_MIFieldCode')
	DROP INDEX MIFieldDefinition_MIFieldCode ON [dbo].MIFieldDefinition
GO
CREATE NONCLUSTERED INDEX MIFieldDefinition_MIFieldCode ON [dbo].MIFieldDefinition (MIFieldDefinition_MIFieldCode ASC)
GO




IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[MIFieldTypeDefinition]') AND name = N'MIFieldTypeDefinition_MIFieldTypeCode')
	DROP INDEX MIFieldTypeDefinition_MIFieldTypeCode ON [dbo].MIFieldTypeDefinition
GO
CREATE NONCLUSTERED INDEX MIFieldTypeDefinition_MIFieldTypeCode ON [dbo].MIFieldTypeDefinition (MIFieldTypeDefinition_MIFieldTypeCode ASC)
GO


