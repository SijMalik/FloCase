--New physical MI fields

ALTER TABLE ManagementInformation	ADD ManagementInformation_PresentPosition			nVarchar(max) Null
ALTER TABLE ManagementInformation	ADD ManagementInformation_DoesCOAApply				nVarchar(255) Null
ALTER TABLE ManagementInformation	ADD ManagementInformation_TxtNoDamAgreDte			nVarchar(255) Null
ALTER TABLE ManagementInformation	ADD ManagementInformation_TxtNoCstsAgreDte			nVarchar(255) Null
ALTER TABLE ManagementInformation	ADD ManagementInformation_TxtNoFnlOffrDte			nVarchar(255) Null
GO

--SELECT * FROM MIFieldDefinition 

--New KEYDATES

--n/a

--New MI Field Definitions

--delete from MIFieldDefinition where MIFieldDefinition_MIFieldDefinitionID >= 1111 + 33

INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
VALUES('MICFIELD123', 'MIMEMO', 'QBE Leeds over £75k case – Present Position', '', 'ManagementInformation_PresentPosition', 'ManagementInformation', '', 0, GETDATE(), 'GQL', 0)
INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
VALUES('MICFIELD119', 'MILKP', 'Does COAApply?', 'COAVAL', 'ManagementInformation_DoesCOAApply', 'ManagementInformation', '', 0, GETDATE(), 'GQL', 0)
INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
VALUES('MICFIELD120', 'MILKP', 'Text if no Damages Agreed Date', 'NODAM', 'ManagementInformation_TxtNoDamAgreDte', 'ManagementInformation', '', 0, GETDATE(), 'GQL', 0)
INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
VALUES('MICFIELD121', 'MILKP', 'Text if no Costs Agreed Date', 'NOCST', 'ManagementInformation_TxtNoCstsAgreDte', 'ManagementInformation', '', 0, GETDATE(), 'GQL', 0)
INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
VALUES('MICFIELD122', 'MILKP', 'Text if no acceptable final offer date', 'NOOFR', 'ManagementInformation_TxtNoFnlOffrDte', 'ManagementInformation', '', 0, GETDATE(), 'GQL', 0)
GO

--NEW CLIENT MI DEFINITIONS

INSERT INTO [dbo].[ClientMIDefinition] ([ClientMIDefinition_CLIENTCODE],[ClientMIDefinition_CLIENTGROUPCODE],[ClientMIDefinition_WORKTYPECODE],[ClientMIDefinition_MIDEFCODE],[ClientMIDefinition_LKPFilter],[ClientMIDefinition_Inactive],[ClientMIDefinition_CreateUser],[ClientMIDefinition_CreateDate])
VALUES(Null,'QBE','','QBE','QBE',0,'GQL',GETDATE())
INSERT INTO [dbo].[ClientMIDefinition] ([ClientMIDefinition_CLIENTCODE],[ClientMIDefinition_CLIENTGROUPCODE],[ClientMIDefinition_WORKTYPECODE],[ClientMIDefinition_MIDEFCODE],[ClientMIDefinition_LKPFilter],[ClientMIDefinition_Inactive],[ClientMIDefinition_CreateUser],[ClientMIDefinition_CreateDate])
VALUES(Null,'Q-ARG','','Q-ARG','QBE',0,'GQL',GETDATE())
INSERT INTO [dbo].[ClientMIDefinition] ([ClientMIDefinition_CLIENTCODE],[ClientMIDefinition_CLIENTGROUPCODE],[ClientMIDefinition_WORKTYPECODE],[ClientMIDefinition_MIDEFCODE],[ClientMIDefinition_LKPFilter],[ClientMIDefinition_Inactive],[ClientMIDefinition_CreateUser],[ClientMIDefinition_CreateDate])
VALUES(Null,'Q-CLM','','Q-CLM','QBE',0,'GQL',GETDATE())
INSERT INTO [dbo].[ClientMIDefinition] ([ClientMIDefinition_CLIENTCODE],[ClientMIDefinition_CLIENTGROUPCODE],[ClientMIDefinition_WORKTYPECODE],[ClientMIDefinition_MIDEFCODE],[ClientMIDefinition_LKPFilter],[ClientMIDefinition_Inactive],[ClientMIDefinition_CreateUser],[ClientMIDefinition_CreateDate])
VALUES(Null,'Q-CS','','Q-CS','QBE',0,'GQL',GETDATE())
INSERT INTO [dbo].[ClientMIDefinition] ([ClientMIDefinition_CLIENTCODE],[ClientMIDefinition_CLIENTGROUPCODE],[ClientMIDefinition_WORKTYPECODE],[ClientMIDefinition_MIDEFCODE],[ClientMIDefinition_LKPFilter],[ClientMIDefinition_Inactive],[ClientMIDefinition_CreateUser],[ClientMIDefinition_CreateDate])
VALUES(Null,'Q-FR','','Q-FR','QBE',0,'GQL',GETDATE())
INSERT INTO [dbo].[ClientMIDefinition] ([ClientMIDefinition_CLIENTCODE],[ClientMIDefinition_CLIENTGROUPCODE],[ClientMIDefinition_WORKTYPECODE],[ClientMIDefinition_MIDEFCODE],[ClientMIDefinition_LKPFilter],[ClientMIDefinition_Inactive],[ClientMIDefinition_CreateUser],[ClientMIDefinition_CreateDate])
VALUES(Null,'Q-GSL','','Q-GSL','QBE',0,'GQL',GETDATE())
INSERT INTO [dbo].[ClientMIDefinition] ([ClientMIDefinition_CLIENTCODE],[ClientMIDefinition_CLIENTGROUPCODE],[ClientMIDefinition_WORKTYPECODE],[ClientMIDefinition_MIDEFCODE],[ClientMIDefinition_LKPFilter],[ClientMIDefinition_Inactive],[ClientMIDefinition_CreateUser],[ClientMIDefinition_CreateDate])
VALUES(Null,'Q-GWY','','Q-GWY','QBE',0,'GQL',GETDATE())
INSERT INTO [dbo].[ClientMIDefinition] ([ClientMIDefinition_CLIENTCODE],[ClientMIDefinition_CLIENTGROUPCODE],[ClientMIDefinition_WORKTYPECODE],[ClientMIDefinition_MIDEFCODE],[ClientMIDefinition_LKPFilter],[ClientMIDefinition_Inactive],[ClientMIDefinition_CreateUser],[ClientMIDefinition_CreateDate])
VALUES(Null,'Q-MD','','Q-MD','QBE',0,'GQL',GETDATE())
INSERT INTO [dbo].[ClientMIDefinition] ([ClientMIDefinition_CLIENTCODE],[ClientMIDefinition_CLIENTGROUPCODE],[ClientMIDefinition_WORKTYPECODE],[ClientMIDefinition_MIDEFCODE],[ClientMIDefinition_LKPFilter],[ClientMIDefinition_Inactive],[ClientMIDefinition_CreateUser],[ClientMIDefinition_CreateDate])
VALUES(Null,'Q-SLS','','Q-SLS','QBE',0,'GQL',GETDATE())
INSERT INTO [dbo].[ClientMIDefinition] ([ClientMIDefinition_CLIENTCODE],[ClientMIDefinition_CLIENTGROUPCODE],[ClientMIDefinition_WORKTYPECODE],[ClientMIDefinition_MIDEFCODE],[ClientMIDefinition_LKPFilter],[ClientMIDefinition_Inactive],[ClientMIDefinition_CreateUser],[ClientMIDefinition_CreateDate])
VALUES(Null,'OLY-Q','','OLY-Q','QBE',0,'GQL',GETDATE())
GO

--NEW CLIENT MI PANELS

INSERT INTO [dbo].[ClientMIPanels]([ClientMIPanels_ClientMIDefCode],[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser])
VALUES('QBE' ,1 ,1,'Dates',0, GETDATE(), 'GQL')
INSERT INTO [dbo].[ClientMIPanels]([ClientMIPanels_ClientMIDefCode],[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser])
VALUES('QBE' ,2 ,1,'QBE Financial - Continued',0, GETDATE(), 'GQL')
INSERT INTO [dbo].[ClientMIPanels]([ClientMIPanels_ClientMIDefCode],[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser])
VALUES('QBE' ,3 ,1,'QBE Reserve Figures',0, GETDATE(), 'GQL')
INSERT INTO [dbo].[ClientMIPanels]([ClientMIPanels_ClientMIDefCode],[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser])
VALUES('QBE' ,1 ,2,'QBE General MI',0, GETDATE(), 'GQL')
INSERT INTO [dbo].[ClientMIPanels]([ClientMIPanels_ClientMIDefCode],[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser])
VALUES('QBE' ,2 ,2,'QBE General MI - Continued',0, GETDATE(), 'GQL')
INSERT INTO [dbo].[ClientMIPanels]([ClientMIPanels_ClientMIDefCode],[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser])
VALUES('QBE' ,3 ,2,'QBE External Costs Information',0, GETDATE(), 'GQL')

INSERT INTO [dbo].[ClientMIPanels]([ClientMIPanels_ClientMIDefCode],[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser])
SELECT 'Q-ARG',[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser]
FROM ClientMIPanels
WHERE [ClientMIPanels_ClientMIDefCode] = 'QBE'

INSERT INTO [dbo].[ClientMIPanels]([ClientMIPanels_ClientMIDefCode],[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser])
SELECT 'Q-CLM',[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser]
FROM ClientMIPanels
WHERE [ClientMIPanels_ClientMIDefCode] = 'QBE'

INSERT INTO [dbo].[ClientMIPanels]([ClientMIPanels_ClientMIDefCode],[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser])
SELECT 'Q-CLM',[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser]
FROM ClientMIPanels
WHERE [ClientMIPanels_ClientMIDefCode] = 'QBE'

INSERT INTO [dbo].[ClientMIPanels]([ClientMIPanels_ClientMIDefCode],[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser])
SELECT 'Q-CS',[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser]
FROM ClientMIPanels
WHERE [ClientMIPanels_ClientMIDefCode] = 'QBE'

INSERT INTO [dbo].[ClientMIPanels]([ClientMIPanels_ClientMIDefCode],[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser])
SELECT 'Q-FR',[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser]
FROM ClientMIPanels
WHERE [ClientMIPanels_ClientMIDefCode] = 'QBE'

INSERT INTO [dbo].[ClientMIPanels]([ClientMIPanels_ClientMIDefCode],[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser])
SELECT 'Q-GSL',[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser]
FROM ClientMIPanels
WHERE [ClientMIPanels_ClientMIDefCode] = 'QBE'

INSERT INTO [dbo].[ClientMIPanels]([ClientMIPanels_ClientMIDefCode],[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser])
SELECT 'Q-GWY',[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser]
FROM ClientMIPanels
WHERE [ClientMIPanels_ClientMIDefCode] = 'QBE'

INSERT INTO [dbo].[ClientMIPanels]([ClientMIPanels_ClientMIDefCode],[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser])
SELECT 'Q-MD',[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser]
FROM ClientMIPanels
WHERE [ClientMIPanels_ClientMIDefCode] = 'QBE'

INSERT INTO [dbo].[ClientMIPanels]([ClientMIPanels_ClientMIDefCode],[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser])
SELECT 'Q-SLS',[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser]
FROM ClientMIPanels
WHERE [ClientMIPanels_ClientMIDefCode] = 'QBE'

INSERT INTO [dbo].[ClientMIPanels]([ClientMIPanels_ClientMIDefCode],[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser])
SELECT 'OLY-Q',[ClientMIPanels_PanelNo],[ClientMIPanels_PageNo],[ClientMIPanels_Description],[ClientMIPanels_Inactive],[ClientMIPanels_CreateDate],[ClientMIPanels_ClientUser]
FROM ClientMIPanels
WHERE [ClientMIPanels_ClientMIDefCode] = 'QBE'
GO
--ASSIGN FIELD SET TO CLIENT MI DEFINITION

delete FROM ClientMIFieldSet WHERE ClientMIFieldSet_ClientMIFieldSetID >= 15443

INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'Instruct', 1, 'Date Instructed:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'AccDt', 2, 'Date of Loss:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'Trial', 3, 'Trial Commencement Date:', 1, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'TRIWINSTR', 4, 'Trial Window Start Date:', 1, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'TRIWINEND', 5, 'Trial Window End Date:', 1, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'FSTREPDTE', 6, 'Date First Report Issued:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'LSTCLTUPD', 7, 'Date of Last Update/Case Plan:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD79', 8, 'Date of Last Reserve Change:', 1, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'LBLBLNK', 9, 'QBE Financial:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD119', 10, 'Does COA Apply?', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD80', 11, 'COA High Figure:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'BLANK', 12, 'Position12', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD63', 13, 'General Damages Paid:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD65', 14, 'Total Damages Paid (£) GROSS:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD81', 15, 'Total Damages Paid (£) NET:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'FICOSTPAID', 16, 'Third Party Costs Paid (£) GROSS:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD82', 17, 'Third Party Costs Paid (£) NET:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'BLMPrfCstP', 18, 'Own Costs - Fees Paid:', 1, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'BLMDisbPd', 19, 'Own Costs - Disbursements Paid:', 1, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'BLMVATB', 20, 'Own Costs - VAT Paid:', 1, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'LBLBLNK', 21, 'QBE Financial - BLM Recoverables:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'FEESRECOVD', 22, 'BLM Fees Recovered from Other Parties:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'PCOSTSCLMD', 23, 'TP Costs Claimed:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'XCOSTSFEES', 24, 'BLM Fees if dealt with CS costs:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'INTDAMRES', 25, 'Initial Damages (GROSS):', 1, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD74', 26, 'Initial Damages (NET):', 1, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD104', 27, 'Initial TP Costs (GROSS):', 1, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD75', 28, 'Initial TP Costs (NET):', 1, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'FICORESHIS', 29, 'Initial Own Costs Fees:', 1, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD105', 30, 'Initial Own Costs Disbursements:', 1, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'CurrResDam', 31, 'Current Damages (GROSS):', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD77', 32, 'Current Damages (NET):', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'CurrResTPC', 33, 'Current TP Costs (GROSS):', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD78', 34, 'Current TP Costs (NET):', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'FIDEFCOST', 35, 'Current Own Costs Fees:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MDISBEXVAT', 36, 'Current Own Costs Disbursements:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'ClntLocDiv', 37, 'Division:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'Class', 38, 'Class Of Business:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD103', 39, 'Instructing QBE Entity and Office:', 1, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MIFLD00002', 40, 'QBE Reference:', 1, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'CLTCLMHNDR', 41, 'QBE Contact:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'AAAAAAAAAA', 42, 'QBE Policy Holder/Insured:', 1, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD71', 43, 'Specific Nominations:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MIFLD00003', 44, 'Claimant Solicitors Firm:', 1, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MIFLD00022', 45, 'Category of Instruction/Claim Track/Jurisdiction:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'LitiReas1', 46, 'If Litigated - Reason for Litigation:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'BLANK', 47, 'Position47', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'BLANK', 48, 'Position48', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD72', 49, 'Case Taken to Trial:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD73', 50, 'Name of Court:', 1, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'IALOUTCOME', 51, 'Trial Outcome:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD87', 52, 'QBE Liability Position at Instruction:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD88', 53, 'QBE Liability Position at Conclusion:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD89', 54, 'Reason for Change in Liability:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD90', 55, 'Repudiation Maintained:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'ClmStsTxt', 56, 'Current Claim Status:', 1, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD100', 57, 'ARM?', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD123', 58, 'QBE Leeds over £75k case - Present Position:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD101', 59, 'QBE Leeds over £75k case - Reason not Settled:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD102', 60, 'QBE Leeds over £75k case - Action being Taken:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD83', 61, 'Instructing Jaggards/Taylor Rose:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD84', 62, 'Date File sent to Jaggards/Taylor Rose:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD85', 63, 'Date File Received back from Jaggards/Taylor Rose:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'LBLBLNK', 64, 'QBE Final Dates:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD86', 65, 'Date of Acceptable Final Damages Offer:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD122', 66, 'Text if no Acceptable Final Offer Date:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'DamSet', 67, 'Date Damages Agreed:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD120', 68, 'Text if no Damages Agreed Date:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD03', 69, 'Date Costs Agreed:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD121', 70, 'Text if no Costs Agreed Date:', 0, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'MICFIELD106', 71, 'Date Claim Settled (Final Bill Date):', 1, 0, 0, GETDATE(), 'GQL', NULL)
INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
VALUES('QBE', 'BLANK', 72, 'Position72', 0, 0, 0, GETDATE(), 'GQL', NULL)

--SELECT [ClientMIFieldSet_MIFieldDefCode] FROM ClientMIFieldSet GROUP BY [ClientMIFieldSet_MIFieldDefCode]

INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
SELECT 'Q-ARG',[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText]
FROM ClientMIFieldSet
WHERE [ClientMIFieldSet_ClientMIDEFCODE] = 'QBE'

INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
SELECT 'Q-CLM',[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText]
FROM ClientMIFieldSet
WHERE [ClientMIFieldSet_ClientMIDEFCODE] = 'QBE'

INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
SELECT 'Q-CLM',[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText]
FROM ClientMIFieldSet
WHERE [ClientMIFieldSet_ClientMIDEFCODE] = 'QBE'

INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
SELECT 'Q-CS',[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText]
FROM ClientMIFieldSet
WHERE [ClientMIFieldSet_ClientMIDEFCODE] = 'QBE'

INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
SELECT 'Q-FR',[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText]
FROM ClientMIFieldSet
WHERE [ClientMIFieldSet_ClientMIDEFCODE] = 'QBE'

INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
SELECT 'Q-GSL',[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText]
FROM ClientMIFieldSet
WHERE [ClientMIFieldSet_ClientMIDEFCODE] = 'QBE'

INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
SELECT 'Q-GWY',[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText]
FROM ClientMIFieldSet
WHERE [ClientMIFieldSet_ClientMIDEFCODE] = 'QBE'

INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
SELECT 'Q-MD',[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText]
FROM ClientMIFieldSet
WHERE [ClientMIFieldSet_ClientMIDEFCODE] = 'QBE'

INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
SELECT 'Q-SLS',[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText]
FROM ClientMIFieldSet
WHERE [ClientMIFieldSet_ClientMIDEFCODE] = 'QBE'

INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
SELECT 'OLY-Q',[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText]
FROM ClientMIFieldSet
WHERE [ClientMIFieldSet_ClientMIDEFCODE] = 'QBE'
GO

--Lookups

--DIVISION

INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('ClntLocDiv', 'CAS', 'Casualty', 'Casualty', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('ClntLocDiv', 'MOT', 'Motor', 'Motor', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('ClntLocDiv', 'PRO', 'Property', 'Property', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('ClntLocDiv', 'RIS', 'Reinsurance', 'Reinsurance', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('ClntLocDiv', 'SPE', 'Specialty', 'Specialty', 'QBE', 0, GETDATE(), 'GQL')
GO

--CLASS

INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0001', 'Accident & Health', 'Accident & Health', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0002', 'After the Event Insurance', 'After the Event Insurance', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0005', 'Asset Protection', 'Asset Protection', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0008', 'Bloodstock', 'Bloodstock', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0010', 'Comprehensive Crime (BBB/ECCP)', 'Comprehensive Crime (BBB/ECCP)', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0011', 'Contingency', 'Contingency', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0012', 'Contractor All Risks/EAR', 'Contractor All Risks/EAR', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0013', 'D and O Liability (Financial Institution', 'D and O Liability (Financial Institution', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0014', 'Directors and Officers Liability', 'Directors and Officers Liability', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0019', 'Financial Institutions PI/Civil Liabilty', 'Financial Institutions PI/Civil Liabilty', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0020', 'Financial Institutions Insurance', 'Financial Institutions Insurance', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0022', 'Health and Safety Prosecution', 'Health and Safety Prosecution', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0025', 'International Casualty Treaty', 'International Casualty Treaty', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0026', 'International Property', 'International Property', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0027', 'International Property Treaty', 'International Property Treaty', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0029', 'Leisure & Sport', 'Leisure & Sport', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0030', 'London Market Property', 'London Market Property', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0033', 'Medical Malpractice', 'Medical Malpractice', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0034', 'Motor', 'Motor ', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0035', 'Municipalities', 'Municipalities', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0036', 'North American Casualty Treaty', 'North American Casualty Treaty', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0037', 'North American Property Treaty', 'North American Property Treaty', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0038', 'Onshore Construction', 'Onshore Construction', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0039', 'P&I', 'P&I', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0040', 'Packages', 'Packages', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0041', 'Pension Fund Trustees Liability', 'Pension Fund Trustees Liability', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0042', 'Personal Accident Reinsurance ', 'Personal Accident Reinsurance ', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0043', 'Pharmaceutical & Medical Product Liability', 'Pharmaceutical & Medical Product Liability', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0044', 'Political Risk & Terrorism', 'Political Risk & Terrorism', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0046', 'Product Guarantee & Recall', 'Product Guarantee & Recall', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0047', 'Product Protection', 'Product Protection', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0048', 'Products Liability', 'Products Liability', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0049', 'Professional Indemnity (PI) ', 'Professional Indemnity (PI) ', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0050', 'Property - UK & SME', 'Property - UK & SME', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0051', 'Property Europe', 'Property Europe', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0052', 'Property National - Manchester', 'Property National - Manchester', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0053', 'Public Liability', 'Public Liability', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0054', 'Schemes', 'Schemes', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0055', 'Specialist Personal Lines (SPL) ', 'Specialist Personal Lines (SPL) ', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0056', 'Specie', 'Specie', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0057', 'Tour Operators Liability', 'Tour Operators Liability', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0058', 'Trade Credit & Bonds', 'Trade Credit & Bonds', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0059', 'Transport Solutions', 'Transport Solutions', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0060', 'UK Employers Liability', 'UK Employers Liability', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0061', 'Warranty', 'Warranty', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0062', 'Warranty & indemnity', 'Warranty & indemnity', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('Class', '0063', 'Worldwide & Retro', 'Worldwide & Retro', 'QBE', 0, GETDATE(), 'GQL')
GO

--TRACK

INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser]) 
VALUES('CRTTRK', 'M1', 'Motor Category 1 E&W', 'Motor Category 1 E&W', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser]) 
VALUES('CRTTRK', 'M2', 'Motor Category 2 E&W', 'Motor Category 2 E&W', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'M3', 'Motor Category 3 E&W', 'Motor Category 3 E&W', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'M4', 'Motor Category 4 E&W', 'Motor Category 4 E&W', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'M5', 'Motor Category 5 E&W', 'Motor Category 5 E&W', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'M6', 'Motor Category 6 E&W', 'Motor Category 6 E&W', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'M7', 'Motor Category 7 E&W', 'Motor Category 7 E&W', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'M8', 'Motor Category 8 E&W', 'Motor Category 8 E&W', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'M9', 'Motor Category 9 E&W', 'Motor Category 9 E&W', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'M10', 'Motor Category 10 E&W', 'Motor Category 10 E&W', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'M11', 'Motor Category 11 E&W ', 'Motor Category 11 E&W ', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'M12', 'Motor Category 12 E&W ', 'Motor Category 12 E&W ', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'M13', 'Motor Category 13 E&W ', 'Motor Category 13 E&W ', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'M14', 'Motor Category 14 E&W ', 'Motor Category 14 E&W ', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'CA', 'UK Casualty Category A', 'UK Casualty Category A', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'CB', 'UK Casualty Category B', 'UK Casualty Category B', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'CC', 'UK Casualty Category C', 'UK Casualty Category C', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'CD', 'UK Casualty Category D', 'UK Casualty Category D', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'CE', 'UK Casualty Category E', 'UK Casualty Category E', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'CF', 'UK Casualty Category F', 'UK Casualty Category F', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'CG', 'UK Casualty Category G', 'UK Casualty Category G', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'CH', 'UK Casualty Category H', 'UK Casualty Category H', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'CI', 'UK Casualty Category I', 'UK Casualty Category I', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'CJ', 'UK Casualty Category J', 'UK Casualty Category J', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'CK', 'UK Casualty Category K', 'UK Casualty Category K', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'CL', 'UK Casualty Category L', 'UK Casualty Category L', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'CM', 'UK Casualty Category M', 'UK Casualty Category M', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'CN', 'UK Casualty Category N', 'UK Casualty Category N', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'CO', 'UK Casualty Category O', 'UK Casualty Category O', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'CP', 'UK Casualty Category P', 'UK Casualty Category P', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'CQ', 'UK Casualty Category Q', 'UK Casualty Category Q', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'CR', 'UK Casualty Category R', 'UK Casualty Category R', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CRTTRK', 'SPEC', 'Specialty', 'Specialty', 'QBE', 0, GETDATE(), 'GQL')
GO

--TRIAL OUTCOME

INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('IALOUTCOME', 'TRLOUT0001', 'Claim Repudiated - QBE Trial costs awarded', 'Claim Repudiated - QBE Trial costs awarded', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('IALOUTCOME', 'TRLOUT0002', 'Claim Repudiated - QBE trial costs not awarded', 'Claim Repudiated - QBE trial costs not awarded', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('IALOUTCOME', 'TRLOUT0003', 'Claim Settled - QBE P36 / Offer not beaten', 'Claim Settled - QBE P36 / Offer not beaten', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('IALOUTCOME', 'TRLOUT0004', 'Claim Settled - QBE P36 / Offer beaten, TP trial costs not awarded', 'Claim Settled - QBE P36 / Offer beaten, TP trial costs not awarded', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('IALOUTCOME', 'TRLOUT0005', 'Claim Settled - QBE P36 / Offer beaten, TP trial costs awarded', 'Claim Settled - QBE P36 / Offer beaten, TP trial costs awarded', 'QBE', 0, GETDATE(), 'GQL')
GO

--Instr Jagg TR

INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CST', 'CST0000001', 'Jaggards', 'Jaggards', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CST', 'CST0000002', 'Taylor Rose', 'Taylor Rose', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('CST', 'CST0000003', 'N/A', 'N/A', 'QBE', 0, GETDATE(), 'GQL')
GO

--Liab instr

INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LIAPSI', 'LIAPSI0001', 'Admission', 'Admission', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LIAPSI', 'LIAPSI0002', 'Denial', 'Denial', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LIAPSI', 'LIAPSI0003', 'Contrib Neg', 'Contrib Neg', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LIAPSI', 'LIAPSI0004', 'QBE position not stipulated', 'QBE position not stipulated', 'QBE', 0, GETDATE(), 'GQL')
GO

--Liab conc

INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LIAPSC', 'LIAPSC0001', 'Admission', 'Admission', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LIAPSC', 'LIAPSC0002', 'Denial', 'Denial', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LIAPSC', 'LIAPSC0003', 'Contrib Neg', 'Contrib Neg', 'QBE', 0, GETDATE(), 'GQL')
GO

--change in liab

INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LIACNG', 'LIACNG0001', 'Commercial Decision', 'Commercial Decision', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LIACNG', 'LIACNG0002', 'Inappropriate position taken pre litigation by QBE', 'Inappropriate position taken pre litigation by QBE', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LIACNG', 'LIACNG0003', 'Further evidence altered the position on liability', 'Further evidence altered the position on liability', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LIACNG', 'LIACNG0004', 'Further allegations altered the position on liability', 'Further allegations altered the position on liability', 'QBE', 0, GETDATE(), 'GQL')
GO

--rep maint

INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('RPDMNT', 'RPDMNT0001', 'Yes', 'Yes', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('RPDMNT', 'RPDMNT0002', 'No', 'No', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('RPDMNT', 'RPDMNT0003', 'N/A', 'N/A', 'QBE', 0, GETDATE(), 'GQL')
GO

--QBE Yes No

INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('YESNO', 'YESNO2', 'Yes', 'Yes', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('YESNO', 'YESNO1', 'No', 'No', 'QBE', 0, GETDATE(), 'GQL')
GO

--COA High Figure Valid?

INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('COAVAL', 'COAVAL1', 'Yes', 'Yes', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('COAVAL', 'COAVAL2', 'TBC', 'TBC', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('COAVAL', 'COAVAL3', 'N/A', 'N/A', 'QBE', 0, GETDATE(), 'GQL')
GO

--Text if no acceptable final offer date:
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NOOFR', 'NOOFR1', 'Advice Only', 'Advice Only', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NOOFR', 'NOOFR2', 'Costs Only', 'Costs Only', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NOOFR', 'NOOFR3', 'Criminal Defence', 'Criminal Defence', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NOOFR', 'NOOFR4', 'Discontinued', 'Discontinued', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NOOFR', 'NOOFR5', 'HSE', 'HSE', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NOOFR', 'NOOFR6', 'Interim', 'Interim', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NOOFR', 'NOOFR7', 'Not Pursued', 'Not Pursued', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NOOFR', 'NOOFR8', 'PAD', 'PAD', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NOOFR', 'NOOFR9', 'Trial Win', 'Trial Win', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NOOFR', 'NOOFR10', 'UMAL', 'UMAL', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NOOFR', 'NOOFR11', 'Withdrawn', 'Withdrawn', 'QBE', 0, GETDATE(), 'GQL')
GO

DELETE FROM MILookupFieldDefinition WHERE MILookupFieldDefinition_MILookupFieldCode = 'NODAM'

--Text if no Damages Agreed Date:
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NODAM', 'NODAM1', 'Advice Only', 'Advice Only', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NODAM', 'NODAM2', 'Costs Only', 'Costs Only', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NODAM', 'NODAM3', 'Criminal Defence', 'Criminal Defence', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NODAM', 'NODAM4', 'Discontinued', 'Discontinued', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NODAM', 'NODAM5', 'HSE', 'HSE', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NODAM', 'NODAM6', 'Interim', 'Interim', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NODAM', 'NODAM7', 'Not Pursued', 'Not Pursued', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NODAM', 'NODAM8', 'PAD', 'PAD', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NODAM', 'NODAM9', 'Trial Win', 'Trial Win', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NODAM', 'NODAM10', 'UMAL', 'UMAL', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NODAM', 'NODAM11', 'Withdrawn', 'Withdrawn', 'QBE', 0, GETDATE(), 'GQL')
GO

--Text if no Costs Agreed Date:
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NOCST', 'NOCST1', 'Advice Only', 'Advice Only', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NOCST', 'NOCST2', 'HSE', 'HSE', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('NOCST', 'NOCST3', 'Interim', 'Interim', 'QBE', 0, GETDATE(), 'GQL')
GO



--LIT RSN

INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser]) 
VALUES('LitiReas1', 'LitiReas165', 'Both Liability and Quantum Disputed', 'Both Liability and Quantum Disputed', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas166', 'Causation Disputed', 'Causation Disputed', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas167', 'COA assessment not agreed', 'COA assessment not agreed', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas168', 'Costs Disputed', 'Costs Disputed', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas169', 'Disease limitation defence disputed', 'Disease limitation defence disputed', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas170', 'Failure to Mitigate', 'Failure to Mitigate', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas171', 'Fraud', 'Fraud', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas172', 'HSE Prosecution', 'HSE Prosecution', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas173', 'Infant approval', 'Infant approval', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas174', 'Insured instructions not to compromise claim', 'Insured instructions not to compromise claim', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas175', 'Jurisdiction', 'Jurisdiction', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas176', 'Liability / Contributory negligence', 'Liability / Contributory negligence', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas177', 'Liability Attaches to a Third Party/Other Defendant', 'Liability Attaches to a Third Party/Other Defendant', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas178', 'Liability Denied', 'Liability Denied', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas179', 'Limitation', 'Limitation', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas180', 'Limitation Defence', 'Limitation Defence', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas181', 'Litigation first notification of claim', 'Litigation first notification of claim', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas182', 'Mesothelioma', 'Mesothelioma', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas183', 'N/A', 'N/A', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas184', 'No decision / action on part of QBE', 'No decision / action on part of QBE', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas185', 'No decision / action on part of the insured', 'No decision / action on part of the insured', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas186', 'No Decision/Inaction-Adjuster', 'No Decision/Inaction-Adjuster', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas187', 'No Decision/Inaction-Claimant', 'No Decision/Inaction-Claimant', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas188', 'Other', 'Other', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas189', 'Policy Indemnity disputed', 'Policy Indemnity disputed', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas190', 'Pre-action disclosure application', 'Pre-action disclosure application', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas191', 'Provisional Settlement Proceedngs', 'Provisional Settlement Proceedngs', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas192', 'QBE not lead insurer', 'QBE not lead insurer', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas193', 'Quantum - Hire', 'Quantum - Hire', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas194', 'Quantum - Property Damage', 'Quantum - Property Damage', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas195', 'Quantum-Claimant offer rejected', 'Quantum-Claimant offer rejected', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas196', 'Quantum-Incomplete/Disputed Evidence', 'Quantum-Incomplete/Disputed Evidence', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas197', 'Quantum-QBE offer rejected', 'Quantum-QBE offer rejected', 'QBE', 0, GETDATE(), 'GQL')
INSERT INTO [dbo].[MILookupFieldDefinition]([MILookupFieldDefinition_MILookupFieldCode],[MILookupFieldDefinition_MILookupItemCode],[MILookupFieldDefinition_MILookupDescription],[MILookupFieldDefinition_DisplayField],[MILookupFieldDefinition_ClientLKPFilter],[MILookupFieldDefinition_Inactive],[MILookupFieldDefinition_CreateDate],[MILookupFieldDefinition_CreateUser])
VALUES('LitiReas1', 'LitiReas198', 'Recovery/Subrogation', 'Recovery/Subrogation', 'QBE', 0, GETDATE(), 'GQL')


--ADD Advanced Calcs

INSERT INTO [dbo].[ClientMIFieldSetAdvCalc]
           ([ClientMIFieldSetAdvCalc_ClientMIFieldSetField]
           ,[ClientMIFieldSetAdvCalc_CalculationDetails]
           ,[ClientMIFieldSetAdvCalc_Inactive]
           ,[ClientMIFieldSetAdvCalc_CreateDate]
           ,[ClientMIFieldSetAdvCalc_CreateUser])
SELECT ClientMIDefinition_MIDEFCODE + 'MIFLD00002', 'SELECT @OUT = ISNULL(CaseContacts_Reference, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_ClientID, 0) > 0 AND CaseContacts_CaseID = @CaseID', 0, GETDATE(), 'GQL'  from ClientMIDefinition where ClientMIDefinition_MIDEFCODE like 'Q%' AND ClientMIDefinition_MIDEFCODE NOT like '%RCMOT%'
GO

INSERT INTO [dbo].[ClientMIFieldSetAdvCalc]
           ([ClientMIFieldSetAdvCalc_ClientMIFieldSetField]
           ,[ClientMIFieldSetAdvCalc_CalculationDetails]
           ,[ClientMIFieldSetAdvCalc_Inactive]
           ,[ClientMIFieldSetAdvCalc_CreateDate]
           ,[ClientMIFieldSetAdvCalc_CreateUser])
SELECT ClientMIDefinition_MIDEFCODE + 'AAAAAAAAAA', 'SELECT TOP 1 @OUT = ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''Defendant'' AND CaseContacts_CaseID = @CaseID', 0, GETDATE(), 'GQL'  from ClientMIDefinition where ClientMIDefinition_MIDEFCODE like 'Q%' AND ClientMIDefinition_MIDEFCODE NOT like '%RCMOT%'
GO

INSERT INTO [dbo].[ClientMIFieldSetAdvCalc]
           ([ClientMIFieldSetAdvCalc_ClientMIFieldSetField]
           ,[ClientMIFieldSetAdvCalc_CalculationDetails]
           ,[ClientMIFieldSetAdvCalc_Inactive]
           ,[ClientMIFieldSetAdvCalc_CreateDate]
           ,[ClientMIFieldSetAdvCalc_CreateUser])
SELECT ClientMIDefinition_MIDEFCODE + 'MIFLD00003', 'SELECT TOP 1 @OUT = ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''ClaimSol'' AND CaseContacts_CaseID = @CaseID', 0, GETDATE(), 'GQL'  from ClientMIDefinition where ClientMIDefinition_MIDEFCODE like 'Q%' AND ClientMIDefinition_MIDEFCODE NOT like '%RCMOT%'
GO

INSERT INTO [dbo].[ClientMIFieldSetAdvCalc]
           ([ClientMIFieldSetAdvCalc_ClientMIFieldSetField]
           ,[ClientMIFieldSetAdvCalc_CalculationDetails]
           ,[ClientMIFieldSetAdvCalc_Inactive]
           ,[ClientMIFieldSetAdvCalc_CreateDate]
           ,[ClientMIFieldSetAdvCalc_CreateUser])
SELECT ClientMIDefinition_MIDEFCODE + 'MICFIELD73', 'SELECT TOP 1 @OUT = ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''COURT'' AND CaseContacts_CaseID = @CaseID', 0, GETDATE(), 'GQL'  from ClientMIDefinition where ClientMIDefinition_MIDEFCODE like 'Q%' AND ClientMIDefinition_MIDEFCODE NOT like '%RCMOT%'
GO

INSERT INTO [dbo].[ClientMIFieldSetAdvCalc]
           ([ClientMIFieldSetAdvCalc_ClientMIFieldSetField]
           ,[ClientMIFieldSetAdvCalc_CalculationDetails]
           ,[ClientMIFieldSetAdvCalc_Inactive]
           ,[ClientMIFieldSetAdvCalc_CreateDate]
           ,[ClientMIFieldSetAdvCalc_CreateUser])
SELECT ClientMIDefinition_MIDEFCODE + 'MICFIELD79', 'SELECT @OUT = ISNULL(MAX(convert(varchar(10),FinancialReserve_ModifiedDate,103)), '''') FROM FinancialReserve WHERE FinancialReserve_Inactive = 0 and FinancialReserve_CaseID = @CaseID', 0, GETDATE(), 'GQL'  from ClientMIDefinition where ClientMIDefinition_MIDEFCODE like 'Q%' AND ClientMIDefinition_MIDEFCODE NOT like '%RCMOT%'
GO

INSERT INTO [dbo].[ClientMIFieldSetAdvCalc]
           ([ClientMIFieldSetAdvCalc_ClientMIFieldSetField]
           ,[ClientMIFieldSetAdvCalc_CalculationDetails]
           ,[ClientMIFieldSetAdvCalc_Inactive]
           ,[ClientMIFieldSetAdvCalc_CreateDate]
           ,[ClientMIFieldSetAdvCalc_CreateUser])
SELECT ClientMIDefinition_MIDEFCODE + 'INTDAMRES', 'SELECT @OUT = CASE WHEN ISNULL((SELECT FinancialReserveHistory_Damages FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND FinancialReserveHistory_FinancialHistoryID = (SELECT MIN(FinancialReserveHistory_FinancialHistoryID) FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND ISNULL(FinancialReserveHistory_Damages, 0.00) > 0.00)),0) >0  THEN (SELECT CAST(FinancialReserveHistory_Damages AS NVARCHAR(MAX)) FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND FinancialReserveHistory_FinancialHistoryID = (SELECT MIN(FinancialReserveHistory_FinancialHistoryID) FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND ISNULL(FinancialReserveHistory_Damages, 0.00) > 0.00)) WHEN ISNULL((SELECT FinancialReserve_Damages FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND FinancialReserve_FinancialReserveID = (SELECT MIN(FinancialReserve_FinancialReserveID) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND  ISNULL(FinancialReserve_Damages, 0.00) > 0.00)),0) >0 THEN (SELECT CAST(FinancialReserve_Damages AS NVARCHAR(MAX)) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND FinancialReserve_FinancialReserveID = (SELECT MIN(FinancialReserve_FinancialReserveID) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND ISNULL(FinancialReserve_Damages, 0.00) > 0.00)) ELSE ''0'' END', 0, GETDATE(), 'GQL'  from ClientMIDefinition where ClientMIDefinition_MIDEFCODE like 'Q%' AND ClientMIDefinition_MIDEFCODE NOT like '%RCMOT%'
GO

INSERT INTO [dbo].[ClientMIFieldSetAdvCalc]
           ([ClientMIFieldSetAdvCalc_ClientMIFieldSetField]
           ,[ClientMIFieldSetAdvCalc_CalculationDetails]
           ,[ClientMIFieldSetAdvCalc_Inactive]
           ,[ClientMIFieldSetAdvCalc_CreateDate]
           ,[ClientMIFieldSetAdvCalc_CreateUser])
SELECT ClientMIDefinition_MIDEFCODE + 'FICORESHIS', 'SELECT @OUT = CASE WHEN ISNULL((SELECT FinancialReserveHistory_DefenceInitCstsRes FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND FinancialReserveHistory_FinancialHistoryID = (SELECT MIN(FinancialReserveHistory_FinancialHistoryID) FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND ISNULL(FinancialReserveHistory_DefenceInitCstsRes, 0.00) > 0.00)),0) >0  THEN (SELECT CAST(FinancialReserveHistory_DefenceInitCstsRes AS NVARCHAR(MAX)) FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND FinancialReserveHistory_FinancialHistoryID = (SELECT MIN(FinancialReserveHistory_FinancialHistoryID) FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND ISNULL(FinancialReserveHistory_DefenceInitCstsRes, 0.00) > 0.00)) WHEN ISNULL((SELECT FinancialReserve_DefenceInitCstsRes FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND FinancialReserve_FinancialReserveID = (SELECT MIN(FinancialReserve_FinancialReserveID) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND  ISNULL(FinancialReserve_DefenceInitCstsRes, 0.00) > 0.00)),0) >0 THEN (SELECT CAST(FinancialReserve_DefenceInitCstsRes AS NVARCHAR(MAX)) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND FinancialReserve_FinancialReserveID = (SELECT MIN(FinancialReserve_FinancialReserveID) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND ISNULL(FinancialReserve_DefenceInitCstsRes, 0.00) > 0.00)) ELSE ''0'' END', 0, GETDATE(), 'GQL'  from ClientMIDefinition where ClientMIDefinition_MIDEFCODE like 'Q%' AND ClientMIDefinition_MIDEFCODE NOT like '%RCMOT%'
GO

INSERT INTO [dbo].[ClientMIFieldSetAdvCalc]
           ([ClientMIFieldSetAdvCalc_ClientMIFieldSetField]
           ,[ClientMIFieldSetAdvCalc_CalculationDetails]
           ,[ClientMIFieldSetAdvCalc_Inactive]
           ,[ClientMIFieldSetAdvCalc_CreateDate]
           ,[ClientMIFieldSetAdvCalc_CreateUser])
SELECT ClientMIDefinition_MIDEFCODE + 'MICFIELD74', 'SELECT @OUT = CASE WHEN ISNULL((SELECT FinancialReserveHistory_DamagesNET FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND FinancialReserveHistory_FinancialHistoryID = (SELECT MIN(FinancialReserveHistory_FinancialHistoryID) FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND ISNULL(FinancialReserveHistory_DamagesNET, 0.00) > 0.00)),0) >0  THEN (SELECT CAST(FinancialReserveHistory_DamagesNET AS NVARCHAR(MAX)) FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND FinancialReserveHistory_FinancialHistoryID = (SELECT MIN(FinancialReserveHistory_FinancialHistoryID) FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND ISNULL(FinancialReserveHistory_DamagesNET, 0.00) > 0.00)) WHEN ISNULL((SELECT FinancialReserve_DamagesNET FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND FinancialReserve_FinancialReserveID = (SELECT MIN(FinancialReserve_FinancialReserveID) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND  ISNULL(FinancialReserve_DamagesNET, 0.00) > 0.00)),0) >0 THEN (SELECT CAST(FinancialReserve_DamagesNET AS NVARCHAR(MAX)) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND FinancialReserve_FinancialReserveID = (SELECT MIN(FinancialReserve_FinancialReserveID) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND ISNULL(FinancialReserve_DamagesNET, 0.00) > 0.00)) ELSE ''0'' END', 0, GETDATE(), 'GQL'  from ClientMIDefinition where ClientMIDefinition_MIDEFCODE like 'Q%' AND ClientMIDefinition_MIDEFCODE NOT like '%RCMOT%'
GO

INSERT INTO [dbo].[ClientMIFieldSetAdvCalc]
           ([ClientMIFieldSetAdvCalc_ClientMIFieldSetField]
           ,[ClientMIFieldSetAdvCalc_CalculationDetails]
           ,[ClientMIFieldSetAdvCalc_Inactive]
           ,[ClientMIFieldSetAdvCalc_CreateDate]
           ,[ClientMIFieldSetAdvCalc_CreateUser])
SELECT ClientMIDefinition_MIDEFCODE + 'MICFIELD104', 'SELECT @OUT = CASE WHEN ISNULL((SELECT FinancialReserveHistory_TPSCost FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND FinancialReserveHistory_FinancialHistoryID = (SELECT MIN(FinancialReserveHistory_FinancialHistoryID) FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND ISNULL(FinancialReserveHistory_TPSCost, 0.00) > 0.00)),0) >0  THEN (SELECT CAST(FinancialReserveHistory_TPSCost AS NVARCHAR(MAX)) FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND FinancialReserveHistory_FinancialHistoryID = (SELECT MIN(FinancialReserveHistory_FinancialHistoryID) FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND ISNULL(FinancialReserveHistory_TPSCost, 0.00) > 0.00)) WHEN ISNULL((SELECT FinancialReserve_TPSCost FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND FinancialReserve_FinancialReserveID = (SELECT MIN(FinancialReserve_FinancialReserveID) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND  ISNULL(FinancialReserve_TPSCost, 0.00) > 0.00)),0) >0 THEN (SELECT CAST(FinancialReserve_TPSCost AS NVARCHAR(MAX)) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND FinancialReserve_FinancialReserveID = (SELECT MIN(FinancialReserve_FinancialReserveID) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND ISNULL(FinancialReserve_TPSCost, 0.00) > 0.00)) ELSE ''0'' END', 0, GETDATE(), 'GQL'  from ClientMIDefinition where ClientMIDefinition_MIDEFCODE like 'Q%' AND ClientMIDefinition_MIDEFCODE NOT like '%RCMOT%'
GO

INSERT INTO [dbo].[ClientMIFieldSetAdvCalc]
           ([ClientMIFieldSetAdvCalc_ClientMIFieldSetField]
           ,[ClientMIFieldSetAdvCalc_CalculationDetails]
           ,[ClientMIFieldSetAdvCalc_Inactive]
           ,[ClientMIFieldSetAdvCalc_CreateDate]
           ,[ClientMIFieldSetAdvCalc_CreateUser])
SELECT ClientMIDefinition_MIDEFCODE + 'MICFIELD75', 'SELECT @OUT = CASE WHEN ISNULL((SELECT FinancialReserveHistory_TPCostsNET FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND FinancialReserveHistory_FinancialHistoryID = (SELECT MIN(FinancialReserveHistory_FinancialHistoryID) FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND ISNULL(FinancialReserveHistory_TPCostsNET, 0.00) > 0.00)),0) >0  THEN (SELECT CAST(FinancialReserveHistory_TPCostsNET AS NVARCHAR(MAX)) FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND FinancialReserveHistory_FinancialHistoryID = (SELECT MIN(FinancialReserveHistory_FinancialHistoryID) FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND ISNULL(FinancialReserveHistory_TPCostsNET, 0.00) > 0.00)) WHEN ISNULL((SELECT FinancialReserve_TPCostsNET FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND FinancialReserve_FinancialReserveID = (SELECT MIN(FinancialReserve_FinancialReserveID) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND  ISNULL(FinancialReserve_TPCostsNET, 0.00) > 0.00)),0) >0 THEN (SELECT CAST(FinancialReserve_TPCostsNET AS NVARCHAR(MAX)) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND FinancialReserve_FinancialReserveID = (SELECT MIN(FinancialReserve_FinancialReserveID) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND ISNULL(FinancialReserve_TPCostsNET, 0.00) > 0.00)) ELSE ''0'' END', 0, GETDATE(), 'GQL'  from ClientMIDefinition where ClientMIDefinition_MIDEFCODE like 'Q%' AND ClientMIDefinition_MIDEFCODE NOT like '%RCMOT%'
GO

INSERT INTO [dbo].[ClientMIFieldSetAdvCalc]
           ([ClientMIFieldSetAdvCalc_ClientMIFieldSetField]
           ,[ClientMIFieldSetAdvCalc_CalculationDetails]
           ,[ClientMIFieldSetAdvCalc_Inactive]
           ,[ClientMIFieldSetAdvCalc_CreateDate]
           ,[ClientMIFieldSetAdvCalc_CreateUser])
SELECT ClientMIDefinition_MIDEFCODE + 'MICFIELD105', 'SELECT @OUT = CASE WHEN ISNULL((SELECT FinancialReserveHistory_BLMDisbExVAT FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND FinancialReserveHistory_FinancialHistoryID = (SELECT MIN(FinancialReserveHistory_FinancialHistoryID) FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND ISNULL(FinancialReserveHistory_BLMDisbExVAT, 0.00) > 0.00)),0) >0  THEN (SELECT CAST(FinancialReserveHistory_BLMDisbExVAT AS NVARCHAR(MAX)) FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND FinancialReserveHistory_FinancialHistoryID = (SELECT MIN(FinancialReserveHistory_FinancialHistoryID) FROM FinancialReserveHistory WHERE FinancialReserveHistory_CaseID = @CaseID AND ISNULL(FinancialReserveHistory_BLMDisbExVAT, 0.00) > 0.00)) WHEN ISNULL((SELECT FinancialReserve_BLMDisbExVAT FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND FinancialReserve_FinancialReserveID = (SELECT MIN(FinancialReserve_FinancialReserveID) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND  ISNULL(FinancialReserve_BLMDisbExVAT, 0.00) > 0.00)),0) >0 THEN (SELECT CAST(FinancialReserve_BLMDisbExVAT AS NVARCHAR(MAX)) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND FinancialReserve_FinancialReserveID = (SELECT MIN(FinancialReserve_FinancialReserveID) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND ISNULL(FinancialReserve_BLMDisbExVAT, 0.00) > 0.00)) ELSE ''0'' END', 0, GETDATE(), 'GQL'  from ClientMIDefinition where ClientMIDefinition_MIDEFCODE like 'Q%' AND ClientMIDefinition_MIDEFCODE NOT like '%RCMOT%'
GO

INSERT INTO [dbo].[ClientMIFieldSetAdvCalc]
           ([ClientMIFieldSetAdvCalc_ClientMIFieldSetField]
           ,[ClientMIFieldSetAdvCalc_CalculationDetails]
           ,[ClientMIFieldSetAdvCalc_Inactive]
           ,[ClientMIFieldSetAdvCalc_CreateDate]
           ,[ClientMIFieldSetAdvCalc_CreateUser])
SELECT ClientMIDefinition_MIDEFCODE + 'ClmStsTxt', 'SELECT @OUT = CASE WHEN (ISNULL(F.final_bill_date, '''') <> '''') AND ((ISNULL(d.CaseKeyDates_Date, '''') <> '''') OR (ISNULL(c.CaseKeyDates_Date, '''') <> '''')) THEN ''Closed'' ELSE ''Open'' END FROM ApplicationInstance ai LEFT OUTER JOIN CaseKeyDates c on c.CaseKeyDates_CaseID = ai.CaseID AND c.CaseKeyDates_KeyDatesCode = ''ExtCstRec'' AND c.CaseKeyDates_Inactive = 0 LEFT OUTER JOIN CaseKeyDates d on c.CaseKeyDates_CaseID = d.CaseKeyDates_CaseID AND d.CaseKeyDates_Inactive = 0 AND d.CaseKeyDates_KeyDatesCode = ''DteCstAgrd'' LEFT OUTER JOIN dbo.vewADRNTEXPMI_Final_Bill_Date f on f.MATTER_UNO = ai.AExpert_MatterUno where ai.CaseID = @CaseID', 0, GETDATE(), 'GQL'  from ClientMIDefinition where ClientMIDefinition_MIDEFCODE like 'Q%' AND ClientMIDefinition_MIDEFCODE NOT like '%RCMOT%'
GO

INSERT INTO [dbo].[ClientMIFieldSetAdvCalc]
           ([ClientMIFieldSetAdvCalc_ClientMIFieldSetField]
           ,[ClientMIFieldSetAdvCalc_CalculationDetails]
           ,[ClientMIFieldSetAdvCalc_Inactive]
           ,[ClientMIFieldSetAdvCalc_CreateDate]
           ,[ClientMIFieldSetAdvCalc_CreateUser])
SELECT ClientMIDefinition_MIDEFCODE + 'Trial', 'SELECT TOP 1 @OUT = ISNULL(MAX(convert(varchar(10),CaseKeyDates_Date,103)), '''') FROM CaseKeyDates WHERE CaseKeyDates_Inactive = 0 AND CaseKeyDates_KeyDatesCode = ''Trial'' AND CaseKeyDates_CaseID = @CaseID', 0, GETDATE(), 'GQL'  from ClientMIDefinition where ClientMIDefinition_MIDEFCODE like 'Q%' AND ClientMIDefinition_MIDEFCODE NOT like '%RCMOT%'
GO

INSERT INTO [dbo].[ClientMIFieldSetAdvCalc]
           ([ClientMIFieldSetAdvCalc_ClientMIFieldSetField]
           ,[ClientMIFieldSetAdvCalc_CalculationDetails]
           ,[ClientMIFieldSetAdvCalc_Inactive]
           ,[ClientMIFieldSetAdvCalc_CreateDate]
           ,[ClientMIFieldSetAdvCalc_CreateUser])
SELECT ClientMIDefinition_MIDEFCODE + 'TRIWINSTR', 'SELECT TOP 1 @OUT = ISNULL(MAX(convert(varchar(10),CaseKeyDates_Date,103)), '''') FROM CaseKeyDates WHERE CaseKeyDates_Inactive = 0 AND CaseKeyDates_KeyDatesCode = ''TrlWndwSrt'' AND CaseKeyDates_CaseID = @CaseID', 0, GETDATE(), 'GQL'  from ClientMIDefinition where ClientMIDefinition_MIDEFCODE like 'Q%' AND ClientMIDefinition_MIDEFCODE NOT like '%RCMOT%'
GO

INSERT INTO [dbo].[ClientMIFieldSetAdvCalc]
           ([ClientMIFieldSetAdvCalc_ClientMIFieldSetField]
           ,[ClientMIFieldSetAdvCalc_CalculationDetails]
           ,[ClientMIFieldSetAdvCalc_Inactive]
           ,[ClientMIFieldSetAdvCalc_CreateDate]
           ,[ClientMIFieldSetAdvCalc_CreateUser])
SELECT ClientMIDefinition_MIDEFCODE + 'TRIWINEND', 'SELECT TOP 1 @OUT = ISNULL(MAX(convert(varchar(10),CaseKeyDates_Date,103)), '''') FROM CaseKeyDates WHERE CaseKeyDates_Inactive = 0 AND CaseKeyDates_KeyDatesCode = ''TrlWndwEnd'' AND CaseKeyDates_CaseID = @CaseID', 0, GETDATE(), 'GQL'  from ClientMIDefinition where ClientMIDefinition_MIDEFCODE like 'Q%' AND ClientMIDefinition_MIDEFCODE NOT like '%RCMOT%'
GO

delete from ClientMIFieldSetAdvCalc where ClientMIFieldSetAdvCalc_ClientMIFieldSetAdvCalcID >= 528


--create case details MI task trigger 

INSERT INTO [dbo].[ClientMITaskTriggers]
           ([ClientMITaskTriggers_AppTaskDefinitionCode]
           ,[ClientMITaskTriggers_MIDEFCODE]
           ,[ClientMITaskTriggers_InActive]
           ,[ClientMITaskTriggers_CreateDate]
           ,[ClientMITaskTriggers_CreateUser])
SELECT 'LoAdvice'
      ,'QBE'
      ,0
      ,GETDATE()
      ,'GQL'
      
INSERT INTO [dbo].[ClientMITaskTriggers]
           ([ClientMITaskTriggers_AppTaskDefinitionCode]
           ,[ClientMITaskTriggers_MIDEFCODE]
           ,[ClientMITaskTriggers_InActive]
           ,[ClientMITaskTriggers_CreateDate]
           ,[ClientMITaskTriggers_CreateUser])
SELECT 'LoAdvice'
      ,'Q-ARG'
      ,0
      ,GETDATE()
      ,'GQL'

INSERT INTO [dbo].[ClientMITaskTriggers]
           ([ClientMITaskTriggers_AppTaskDefinitionCode]
           ,[ClientMITaskTriggers_MIDEFCODE]
           ,[ClientMITaskTriggers_InActive]
           ,[ClientMITaskTriggers_CreateDate]
           ,[ClientMITaskTriggers_CreateUser])
SELECT 'LoAdvice'
      ,'Q-CLM'
      ,0
      ,GETDATE()
      ,'GQL'

INSERT INTO [dbo].[ClientMITaskTriggers]
           ([ClientMITaskTriggers_AppTaskDefinitionCode]
           ,[ClientMITaskTriggers_MIDEFCODE]
           ,[ClientMITaskTriggers_InActive]
           ,[ClientMITaskTriggers_CreateDate]
           ,[ClientMITaskTriggers_CreateUser])
SELECT 'LoAdvice'
      ,'Q-CS'
      ,0
      ,GETDATE()
      ,'GQL'

INSERT INTO [dbo].[ClientMITaskTriggers]
           ([ClientMITaskTriggers_AppTaskDefinitionCode]
           ,[ClientMITaskTriggers_MIDEFCODE]
           ,[ClientMITaskTriggers_InActive]
           ,[ClientMITaskTriggers_CreateDate]
           ,[ClientMITaskTriggers_CreateUser])
SELECT 'LoAdvice'
      ,'Q-FR'
      ,0
      ,GETDATE()
      ,'GQL'

INSERT INTO [dbo].[ClientMITaskTriggers]
           ([ClientMITaskTriggers_AppTaskDefinitionCode]
           ,[ClientMITaskTriggers_MIDEFCODE]
           ,[ClientMITaskTriggers_InActive]
           ,[ClientMITaskTriggers_CreateDate]
           ,[ClientMITaskTriggers_CreateUser])
SELECT 'LoAdvice'
      ,'Q-GSL'
      ,0
      ,GETDATE()
      ,'GQL'

INSERT INTO [dbo].[ClientMITaskTriggers]
           ([ClientMITaskTriggers_AppTaskDefinitionCode]
           ,[ClientMITaskTriggers_MIDEFCODE]
           ,[ClientMITaskTriggers_InActive]
           ,[ClientMITaskTriggers_CreateDate]
           ,[ClientMITaskTriggers_CreateUser])
SELECT 'LoAdvice'
      ,'Q-GWY'
      ,0
      ,GETDATE()
      ,'GQL'

INSERT INTO [dbo].[ClientMITaskTriggers]
           ([ClientMITaskTriggers_AppTaskDefinitionCode]
           ,[ClientMITaskTriggers_MIDEFCODE]
           ,[ClientMITaskTriggers_InActive]
           ,[ClientMITaskTriggers_CreateDate]
           ,[ClientMITaskTriggers_CreateUser])
SELECT 'LoAdvice'
      ,'Q-MD'
      ,0
      ,GETDATE()
      ,'GQL'

INSERT INTO [dbo].[ClientMITaskTriggers]
           ([ClientMITaskTriggers_AppTaskDefinitionCode]
           ,[ClientMITaskTriggers_MIDEFCODE]
           ,[ClientMITaskTriggers_InActive]
           ,[ClientMITaskTriggers_CreateDate]
           ,[ClientMITaskTriggers_CreateUser])
SELECT 'LoAdvice'
      ,'Q-SLS'
      ,0
      ,GETDATE()
      ,'GQL'      

INSERT INTO [dbo].[ClientMITaskTriggers]
           ([ClientMITaskTriggers_AppTaskDefinitionCode]
           ,[ClientMITaskTriggers_MIDEFCODE]
           ,[ClientMITaskTriggers_InActive]
           ,[ClientMITaskTriggers_CreateDate]
           ,[ClientMITaskTriggers_CreateUser])
SELECT 'RegAdvice'
      ,'QBE'
      ,0
      ,GETDATE()
      ,'GQL'

INSERT INTO [dbo].[ClientMITaskTriggers]
           ([ClientMITaskTriggers_AppTaskDefinitionCode]
           ,[ClientMITaskTriggers_MIDEFCODE]
           ,[ClientMITaskTriggers_InActive]
           ,[ClientMITaskTriggers_CreateDate]
           ,[ClientMITaskTriggers_CreateUser])
SELECT 'RegAdvice'
      ,'Q-ARG'
      ,0
      ,GETDATE()
      ,'GQL'

INSERT INTO [dbo].[ClientMITaskTriggers]
           ([ClientMITaskTriggers_AppTaskDefinitionCode]
           ,[ClientMITaskTriggers_MIDEFCODE]
           ,[ClientMITaskTriggers_InActive]
           ,[ClientMITaskTriggers_CreateDate]
           ,[ClientMITaskTriggers_CreateUser])
SELECT 'RegAdvice'
      ,'Q-CLM'
      ,0
      ,GETDATE()
      ,'GQL'

INSERT INTO [dbo].[ClientMITaskTriggers]
           ([ClientMITaskTriggers_AppTaskDefinitionCode]
           ,[ClientMITaskTriggers_MIDEFCODE]
           ,[ClientMITaskTriggers_InActive]
           ,[ClientMITaskTriggers_CreateDate]
           ,[ClientMITaskTriggers_CreateUser])
SELECT 'RegAdvice'
      ,'Q-CS'
      ,0
      ,GETDATE()
      ,'GQL'

INSERT INTO [dbo].[ClientMITaskTriggers]
           ([ClientMITaskTriggers_AppTaskDefinitionCode]
           ,[ClientMITaskTriggers_MIDEFCODE]
           ,[ClientMITaskTriggers_InActive]
           ,[ClientMITaskTriggers_CreateDate]
           ,[ClientMITaskTriggers_CreateUser])
SELECT 'RegAdvice'
      ,'Q-FR'
      ,0
      ,GETDATE()
      ,'GQL'

INSERT INTO [dbo].[ClientMITaskTriggers]
           ([ClientMITaskTriggers_AppTaskDefinitionCode]
           ,[ClientMITaskTriggers_MIDEFCODE]
           ,[ClientMITaskTriggers_InActive]
           ,[ClientMITaskTriggers_CreateDate]
           ,[ClientMITaskTriggers_CreateUser])
SELECT 'RegAdvice'
      ,'Q-GSL'
      ,0
      ,GETDATE()
      ,'GQL'

INSERT INTO [dbo].[ClientMITaskTriggers]
           ([ClientMITaskTriggers_AppTaskDefinitionCode]
           ,[ClientMITaskTriggers_MIDEFCODE]
           ,[ClientMITaskTriggers_InActive]
           ,[ClientMITaskTriggers_CreateDate]
           ,[ClientMITaskTriggers_CreateUser])
SELECT 'RegAdvice'
      ,'Q-GWY'
      ,0
      ,GETDATE()
      ,'GQL'

INSERT INTO [dbo].[ClientMITaskTriggers]
           ([ClientMITaskTriggers_AppTaskDefinitionCode]
           ,[ClientMITaskTriggers_MIDEFCODE]
           ,[ClientMITaskTriggers_InActive]
           ,[ClientMITaskTriggers_CreateDate]
           ,[ClientMITaskTriggers_CreateUser])
SELECT 'RegAdvice'
      ,'Q-MD'
      ,0
      ,GETDATE()
      ,'GQL'

INSERT INTO [dbo].[ClientMITaskTriggers]
           ([ClientMITaskTriggers_AppTaskDefinitionCode]
           ,[ClientMITaskTriggers_MIDEFCODE]
           ,[ClientMITaskTriggers_InActive]
           ,[ClientMITaskTriggers_CreateDate]
           ,[ClientMITaskTriggers_CreateUser])
SELECT 'RegAdvice'
      ,'Q-SLS'
      ,0
      ,GETDATE()
      ,'GQL'
GO

      