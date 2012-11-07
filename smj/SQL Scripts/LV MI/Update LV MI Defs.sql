--INFO SAVED TO LVMIDetails TABLE TO BE SAVED TO ManagementInformation TABLE

--ADD NEW FIELDS TO MI TABLE (SOME ALREADY EXIST)
ALTER TABLE ManagementInformation ADD ManagementInformation_CliRef VARCHAR(50) NULL
ALTER TABLE ManagementInformation ADD ManagementInformation_InsPCode VARCHAR(255) NULL
ALTER TABLE ManagementInformation ADD ManagementInformation_CoDefSol VARCHAR(255) NULL
ALTER TABLE ManagementInformation ADD ManagementInformation_CDSCntct VARCHAR(255) NULL
ALTER TABLE ManagementInformation ADD ManagementInformation_CompRec VARCHAR(50) NULL
ALTER TABLE ManagementInformation ADD ManagementInformation_Limitation VARCHAR(255) NULL
ALTER TABLE ManagementInformation ADD ManagementInformation_ClaiSolOff VARCHAR(50) NULL
ALTER TABLE ManagementInformation ADD ManagementInformation_ActResJud VARCHAR(255) NULL
ALTER TABLE ManagementInformation ADD ManagementInformation_JudSetAsd VARCHAR(50) NULL
ALTER TABLE ManagementInformation ADD ManagementInformation_SettPoint VARCHAR(50) NULL
ALTER TABLE ManagementInformation ADD ManagementInformation_NilDam VARCHAR(50) NULL
ALTER TABLE ManagementInformation ADD ManagementInformation_NilTP VARCHAR(50) NULL
ALTER TABLE ManagementInformation ADD ManagementInformation_DaysToSett INT NULL
ALTER TABLE ManagementInformation ADD ManagementInformation_JudgEnter VARCHAR(50) NULL
ALTER TABLE ManagementInformation ADD ManagementInformation_TypeJudge VARCHAR(50) NULL

--UPDATE MI FIELD DEF'S
UPDATE	MIFieldDefinition 
SET	MIFieldDefinition_DataTable = 'ManagementInformation',
	MIFieldDefinition_DataField = 'ManagementInformation_CliRef'
WHERE	MIFieldDefinition_DataField = 'LVMIDetails_CliRef'
AND	MIFieldDefinition_DataTable = 'LVMIDetails'

/*EXISTING ManInf FIELD */
UPDATE	MIFieldDefinition 
SET	MIFieldDefinition_DataTable = 'ManagementInformation',
	MIFieldDefinition_DataField = 'ManagementInformation_ClientClaimsHandler'
WHERE	MIFieldDefinition_DataField = 'LVMIDetails_ClmHndlr'
AND	MIFieldDefinition_DataTable = 'LVMIDetails'

UPDATE	MIFieldDefinition 
SET	MIFieldDefinition_DataTable = 'ManagementInformation',
	MIFieldDefinition_DataField = 'ManagementInformation_InsPCode'
WHERE	MIFieldDefinition_DataField = 'LVMIDetails_Postcode'
AND	MIFieldDefinition_DataTable = 'LVMIDetails'

UPDATE	MIFieldDefinition 
SET	MIFieldDefinition_DataTable = 'ManagementInformation',
	MIFieldDefinition_DataField = 'ManagementInformation_CoDefSol'
WHERE	MIFieldDefinition_DataField = 'LVMIDetails_CoDefSol'
AND	MIFieldDefinition_DataTable = 'LVMIDetails'

UPDATE	MIFieldDefinition 
SET	MIFieldDefinition_DataTable = 'ManagementInformation',
	MIFieldDefinition_DataField = 'ManagementInformation_CDSCntct'
WHERE	MIFieldDefinition_DataField = 'LVMIDetails_CDSCntct'
AND	MIFieldDefinition_DataTable = 'LVMIDetails'

UPDATE	MIFieldDefinition 
SET	MIFieldDefinition_DataTable = 'ManagementInformation',
	MIFieldDefinition_DataField = 'ManagementInformation_CompRec'
WHERE	MIFieldDefinition_DataField = 'LVMIDetails_CompRec'
AND	MIFieldDefinition_DataTable = 'LVMIDetails'

UPDATE	MIFieldDefinition 
SET	MIFieldDefinition_DataTable = 'ManagementInformation',
	MIFieldDefinition_DataField = 'ManagementInformation_Limitation'
WHERE	MIFieldDefinition_DataField = 'LVMIDetails_Limit'
AND	MIFieldDefinition_DataTable = 'LVMIDetails'

/*EXISTING ManInf FIELD */
UPDATE	MIFieldDefinition 
SET	MIFieldDefinition_DataTable = 'ManagementInformation',
	MIFieldDefinition_DataField = 'ManagementInformation_Litigated'
WHERE	MIFieldDefinition_DataField = 'LVMIDetails_Lit'
AND	MIFieldDefinition_DataTable = 'LVMIDetails'

UPDATE	MIFieldDefinition 
SET	MIFieldDefinition_DataTable = 'ManagementInformation',
	MIFieldDefinition_DataField = 'ManagementInformation_ClaiSolOff'
WHERE	MIFieldDefinition_DataField = 'LVMIDetails_CLSO'
AND	MIFieldDefinition_DataTable = 'LVMIDetails'

UPDATE	MIFieldDefinition 
SET	MIFieldDefinition_DataTable = 'ManagementInformation',
	MIFieldDefinition_DataField = 'ManagementInformation_ActResJud'
WHERE	MIFieldDefinition_DataField = 'LVMIDetails_ActResJud'
AND	MIFieldDefinition_DataTable = 'LVMIDetails'

/*EXISTING ManInf FIELD */
UPDATE	MIFieldDefinition 
SET	MIFieldDefinition_DataTable = 'ManagementInformation',
	MIFieldDefinition_DataField = 'ManagementInformation_PresentPosition'
WHERE	MIFieldDefinition_DataField = 'LVMIDetails_PresPos'
AND	MIFieldDefinition_DataTable = 'LVMIDetails'

UPDATE	MIFieldDefinition 
SET	MIFieldDefinition_DataTable = 'ManagementInformation',
	MIFieldDefinition_DataField = 'ManagementInformation_JudSetAsd'
WHERE	MIFieldDefinition_DataField = 'LVMIDetails_JudSetAsd'
AND	MIFieldDefinition_DataTable = 'LVMIDetails'

UPDATE	MIFieldDefinition 
SET	MIFieldDefinition_DataTable = 'ManagementInformation',
	MIFieldDefinition_DataField = 'ManagementInformation_SettPoint'
WHERE	MIFieldDefinition_DataField = 'LVMIDetails_SettPoint'
AND	MIFieldDefinition_DataTable = 'LVMIDetails'

UPDATE	MIFieldDefinition 
SET	MIFieldDefinition_DataTable = 'ManagementInformation',
	MIFieldDefinition_DataField = 'ManagementInformation_NilDam'
WHERE	MIFieldDefinition_DataField = 'LVMIDetails_NilDam'
AND	MIFieldDefinition_DataTable = 'LVMIDetails'

UPDATE	MIFieldDefinition 
SET	MIFieldDefinition_DataTable = 'ManagementInformation',
	MIFieldDefinition_DataField = 'ManagementInformation_NilTP'
WHERE	MIFieldDefinition_DataField = 'LVMIDetails_NilTP'
AND	MIFieldDefinition_DataTable = 'LVMIDetails'

UPDATE	MIFieldDefinition 
SET	MIFieldDefinition_DataTable = 'ManagementInformation',
	MIFieldDefinition_DataField = 'ManagementInformation_DaysToSett'
WHERE	MIFieldDefinition_DataField = 'LVMIDetails_DaysToSett'
AND	MIFieldDefinition_DataTable = 'LVMIDetails'


/*EXISTING ManInf FIELD */
UPDATE	MIFieldDefinition 
SET	MIFieldDefinition_DataTable = 'ManagementInformation',
	MIFieldDefinition_DataField = 'ManagementInformation_ResultMethod'
WHERE	MIFieldDefinition_DataField = 'LVMIDetails_ResMeth'
AND	MIFieldDefinition_DataTable = 'LVMIDetails'

UPDATE	MIFieldDefinition 
SET	MIFieldDefinition_DataTable = 'ManagementInformation',
	MIFieldDefinition_DataField = 'ManagementInformation_JudgEnter'
WHERE	MIFieldDefinition_DataField = 'LVMIDetails_JudgEnter'
AND	MIFieldDefinition_DataTable = 'LVMIDetails'

UPDATE	MIFieldDefinition 
SET	MIFieldDefinition_DataTable = 'ManagementInformation',
	MIFieldDefinition_DataField = 'ManagementInformation_TypeJudge'
WHERE	MIFieldDefinition_DataField = 'LVMIDetails_TypeJudge'
AND	MIFieldDefinition_DataTable = 'LVMIDetails'
-------------

--INSERT EXISTING RECORDS TO MI TABLE
INSERT INTO ManagementInformation
(
ManagementInformation_CaseID,
ManagementInformation_CliRef,
ManagementInformation_ClientClaimsHandler,
ManagementInformation_InsPCode,
ManagementInformation_CoDefSol,
ManagementInformation_CDSCntct,
ManagementInformation_Litigated,
ManagementInformation_CompRec,
ManagementInformation_Limitation,
ManagementInformation_ClaiSolOff,
ManagementInformation_ActResJud,
ManagementInformation_PresentPosition,
ManagementInformation_JudSetAsd,
ManagementInformation_SettPoint,
ManagementInformation_NilDam,
ManagementInformation_NilTP,
ManagementInformation_DaysToSett,
ManagementInformation_ResultMethod,
ManagementInformation_JudgEnter,
ManagementInformation_TypeJudge,
ManagementInformation_Inactive,
ManagementInformation_CreateUser,
ManagementInformation_CreateDate
)
SELECT
LVMIDetails_CaseID, 
LVMIDetails_CliRef, 
LVMIDetails_ClmHndlr, 
LVMIDetails_Postcode, 
LVMIDetails_CoDefSol, 
LVMIDetails_CDSCntct, 
LVMIDetails_Lit, 
LVMIDetails_CompRec, 
LVMIDetails_Limit, 
LVMIDetails_CLSO, 
LVMIDetails_ActResJud, 
LVMIDetails_PresPos, 
LVMIDetails_JudSetAsd, 
LVMIDetails_SettPoint, 
LVMIDetails_NilDam, 
LVMIDetails_NilTP, 
LVMIDetails_DaysToSett, 
LVMIDetails_ResMeth, 
LVMIDetails_JudgEnter, 
LVMIDetails_TypeJudge, 
Inactive,
CreateUser, 
CreateDate
FROM LVMIDetails
WHERE Inactive = 0
-------

--Field should be read-only
UPDATE ClientMIFieldSet 
SET ClientMIFieldSet_MIFieldRO = 1
WHERE ClientMIFieldSet_MIFieldDefCode = 'DTELASTACT'

--Drop table
DROP TABLE LVMIDetails


