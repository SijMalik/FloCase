	
	--Was set to wrong table
	UPDATE 	MIFieldDefinition 
	SET 	MIFieldDefinition_DataTable = 'Financial'
	WHERE 	MIFieldDefinition_MIFieldCode = 'CTABLECSTS'


	--Existing MI field required, but was set inactive
	UPDATE 	MIFieldDefinition
	SET 	MIFieldDefinition_Inactive = 1
	WHERE 	MIFieldDefinition_MIFieldCode = 'BLMTotB'   


	--Incorrectly set as Aderant Field
	UPDATE 	MIFieldDefinition
	SET 	MIFieldDefinition_AderantField = 0
	WHERE 	MIFieldDefinition_MIFieldCode = 'LVOFFICE' 


	--Was set to get postcode from ContactAddress but no CaseID on that table so changed to LVMIDetails
	UPDATE	MIFieldDefinition
	SET	MIFieldDefinition_DataField = 'LVMIDetails_Postcode',
		MIFieldDefinition_DataTable = 'LVMIDetails'
	WHERE	MIFieldDefinition_MIFieldCode = 'CLCTPCODE' 


	--Didn't populate MI KeyDateType Column - Delete and repopulate	
	DELETE FROM MIFieldDefinition 
	WHERE MIFieldDefinition_MIFieldCode IN
	(
		'DTEINSTR',
		'DTEACC',
		'DTEPROC',
		'DTEACKDUE',
		'DTEASSENT',
		'DefDueDate',
		'DTEDFSENT',
		'DateJdgEnt',
		'DTESETT',
		'DTELASTACT'
	)
	
	INSERT INTO MIFieldDefinition SELECT 'DTEINSTR', 'MIDTEINP', 'Date of Instruction', NULL, 'DATE_INSTRUCTED', '_HBM_MATTER_USR_DATA', 'DTEINSTR', 0, GETDATE(), 'SMJ', 1
	INSERT INTO MIFieldDefinition SELECT 'DTEACC', 'MIDTEINP', 'Date of Accident', NULL, 'DATE_ACCIDENT_INCIDENT', '_HBM_MATTER_USR_DATA', 'DTEACC', 0, GETDATE(), 'SMJ', 1
	INSERT INTO MIFieldDefinition SELECT 'DTEPROC', 'MIDTEINP', 'Date of Proceedings', NULL, 'CaseKeyDates_Date', 'CaseKeyDates', 'DTEPROC', 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'DTEACKDUE', 'MIDTEINP', 'Date Acknowledgement Due', NULL, 'CaseKeyDates_Date', 'CaseKeyDates', 'DTEACKDUE', 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'DTEASSENT', 'MIDTEINP', 'Date A&S sent to Court', NULL, 'CaseKeyDates_Date', 'CaseKeyDates', 'DTEASSENT', 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'DefDueDate', 'MIDTEINP', 'Date Defence Due', NULL, 'CaseKeyDates_Date', 'CaseKeyDates', 'DefDueDate', 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'DTEDFSENT', 'MIDTEINP', 'Date Defence sent to Court', NULL, 'CaseKeyDates_Date', 'CaseKeyDates', 'DTEDFSENT', 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'DateJdgEnt', 'MIDTEINP', 'Date of Judgment', NULL, 'CaseKeyDates_Date', 'CaseKeyDates', 'DateJdgEnt', 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'DTESETT', 'MIDTEINP', 'Damages Settlement Date', NULL, 'DATE_OF_SETTLEMENT', '_HBM_MATTER_USR_DATA', 'DTESETT', 0, GETDATE(), 'SMJ', 1
	INSERT INTO MIFieldDefinition SELECT 'DTELASTACT', 'MIDTEINP', 'Date of Last Action', NULL, 'DATE_LAST_ACTION', '_HBM_MATTER_USR_DATA', 'DTELASTACT', 0, GETDATE(), 'SMJ', 1
	---- 


	--Was set to wrong table and field, and not an Aderant field
	UPDATE 	MIFieldDefinition 
	SET 	MIFieldDefinition_DataTable = 'CaseKeydates',
		MIFieldDefinition_DataField = 'CaseKeyDates_Date',
		MIFieldDefinition_AderantField = 0
	WHERE 	MIFieldDefinition_MIFieldCode = 'DTELASTACT'


	--Wrong lookup code
	UPDATE 	MIFieldDefinition
	SET 	MIFieldDefinition_MILKPFieldCode = 'CATINSTR'
	WHERE 	MIFieldDefinition_MIFieldCode = 'MOTCAT'


	--Remove semi-colon from panel labels
	UPDATE	ClientMIFieldSet
   	SET	ClientMIFieldSet_MIFieldLabel = SUBSTRING(ClientMIFieldSet_MIFieldLabel,1,LEN(ClientMIFieldSet_MIFieldLabel) -1 )
   	WHERE	ClientMIFieldSet_MIFieldDefCode = 'LBLBLNK'
   	AND	ClientMIFieldSet_ClientMIDEFCODE = 'LV' 


	--Update table/field details 
  	UPDATE 	MIFieldDefinition
	SET 	MIFieldDefinition_DataField = 'LVOffice_Office',
		MIFieldDefinition_DataTable = 'LVOffice'
	WHERE 	MIFieldDefinition_MIFieldCode = 'LVOffice'

  	UPDATE 	MIFieldDefinition
	SET   	MIFieldDefinition_DataTable = 'Financial'
  	WHERE 	MIFieldDefinition_MIFieldCode = 'CTABLECSTS'


	--Update table/field details 	
  	UPDATE 	MIFieldDefinition
	SET 	MIFieldDefinition_DataField = 'LVFeesBilled_OwnFees',
			MIFieldDefinition_DataTable = 'LVFeesBilled'
	WHERE 	MIFieldDefinition_MIFieldCode = 'BLMCstFB'	
		
  	UPDATE 	MIFieldDefinition
	SET 	MIFieldDefinition_DataField = 'LVFeesBilled_DisbCouns',
			MIFieldDefinition_DataTable = 'LVFeesBilled'
	WHERE 	MIFieldDefinition_MIFieldCode = 'BLMCFB'
	
  	UPDATE 	MIFieldDefinition
	SET 	MIFieldDefinition_DataField = 'LVFeesBilled_DisbOther',
		MIFieldDefinition_DataTable = 'LVFeesBilled'
	WHERE 	MIFieldDefinition_MIFieldCode = 'BLMDB'	
	
  	UPDATE 	MIFieldDefinition
	SET 	MIFieldDefinition_DataField = 'LVFeesBilled_CostsTotal',
		MIFieldDefinition_DataTable = 'LVFeesBilled'
	WHERE 	MIFieldDefinition_MIFieldCode = 'BLMTotB'	


	UPDATE	MIFieldDefinition
  	SET	MIFieldDefinition_Inactive = 0
  	WHERE	MIFieldDefinition_MIFieldCode = 'BLMTotB'


  	UPDATE 	MIFieldDefinition
	SET 	MIFieldDefinition_DataField = 'LVFinalBillDP_FinalBillDatePaid',
		MIFieldDefinition_DataTable = 'LVFinalBillDP',
		MIFieldDefinition_KeyDateType = NULL
	WHERE 	MIFieldDefinition_MIFieldCode = 'DTELASTACT'



