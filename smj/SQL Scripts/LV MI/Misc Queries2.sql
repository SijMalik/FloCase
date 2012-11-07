   
   select * from ClientMIFieldSet cmf
   inner join MIFieldDefinition mi
   on cmf.ClientMIFieldSet_MIFieldDefCode = mi.MIFieldDefinition_MIFieldCode
   where cmf.ClientMIFieldSet_ClientMIDEFCODE = 'LV'
   order by cmf.ClientMIFieldSet_MIFieldPosition


DTEINSTR
DTESETT
select DISTINCT cc.CaseContacts_RoleCode from CaseContacts cc
where cc.
   SELECT * FROM [Case] c
   WHERE c.Case_CaseID = 

select * from MIFieldDefinition mi
where mi.MIFieldDefinition_FieldDescription like '%DTE%'

   select * from ClientMIFieldSetAdvCalc c
   where c.ClientMIFieldSetAdvCalc_ClientMIFieldSetField like 'lv%'

	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',84,'BLANK-84:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
  EXEC [ClientMIFieldSet_Fetch]  @pCase_CaseID = 1963 ,  @pGetCosts = 0 ,  @pUser_Name = 'SMJ'

	INSERT INTO ClientMIFieldSet SELECT 'LV','LBLBLNK',76,'LV - Claimed',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	--Remove semi-colon from panel labels
	UPDATE	ClientMIFieldSet
   	SET	
   	ClientMIFieldSet_MIFieldDefCode = 'TYPEJUDGE',
   	ClientMIFieldSet_MIFieldLabel = 'Type of Judgment?:',
   	ClientMIFieldSet_MIFieldPosition = 6
   	WHERE	ClientMIFieldSet_ClientMIFieldSetID = 23805
   	AND	ClientMIFieldSet_ClientMIDEFCODE = 'LV' 


	--Update table/field details 
  	UPDATE 	MIFieldDefinition
	SET 	MIFieldDefinition_DataField = 'LVFinalBillDP_FinalBillDatePaid',
		MIFieldDefinition_DataTable = 'LVFinalBillDP'
	WHERE 	MIFieldDefinition_MIFieldCode = 'DTELASTACT'  
	
	INSERT INTO KeyDatesType
	SELECT 'Date of Final Judgment or Part 36', 'DTEFNJG36',0,'SMJ',GETDATE(),NULL
	
		INSERT INTO MIFieldDefinition SELECT 'DTEFNJG36', 'MIDTEINP', 'Date of Final Judgment or Part 36', NULL, 'CaseKeyDates_Date', 'CaseKeyDates', 'DTEFNJG36', 0, GETDATE(), 'SMJ', 0
	
		INSERT INTO ClientMIFieldSet SELECT 'LV','DTEFNJG36',75,'Date of Final Judgment or Part 36:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
		
		
		UPDATE ClientMIFieldSet 
		set
		ClientMIFieldSet_MIFieldPosition = ClientMIFieldSet_MIFieldPosition +5
		where ClientMIFieldSet_ClientMIFieldSetID IN
(
23826
23815,
23816,
23817,
23818,
23819,
23820,
23821,
23822,
23823,
23824,
23825
)
AND ClientMIFieldSet_ClientMIDEFCODE = 'LV'

delete from ClientMIFieldSet
where ClientMIFieldSet_ClientMIFieldSetID IN
(
23941
)


	--LV Judgement set aside - JUDSETASD
	INSERT INTO MILookupFieldDefinition
	SELECT 'JUDGENTER', 'Y', 'Yes', 'Yes', 'LV', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'JUDGENTER', 'N', 'No', 'No', 'LV', 0, GETDATE(), 'SMJ'
	
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'TYPEJUDGE', 'Cons', 'Consent', 'Consent', 'LV', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'TYPEJUDGE', 'Def', 'Default', 'Default', 'LV', 0, GETDATE(), 'SMJ'	
	
	INSERT INTO MIFieldDefinition SELECT 'JUDGENTER', 'MILKP', 'Judgment ntered?', 'JUDGENTER', 'LVMIDetails_JudgEnter', 'LVMIDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'TYPEJUDGE', 'MILKP', 'Type of Judgment?', 'TYPEJUDGE', 'LVMIDetails_TypeJudge', 'LVMIDetails', NULL, 0, GETDATE(), 'SMJ', 0
	
	
	--Days to Settle
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'LVDAYSTOSETT', 
	'SELECT ISNULL(DATEDIFF(D, DATE_INSTRUCTED, DATE_OF_SETTLEMENT),0) FROM _HBM_MATTER_USR_DATA hbm INNER JOIN ApplicationInstance ai ON hbm.MATTER_UNO = ai.AExpert_MatterUno WHERE hbm.DATE_INSTRUCTED IS NOT NULL AND hbm.DATE_OF_SETTLEMENT IS NOT NULL AND ai.CaseID = @CaseID',
	0, GETDATE(), 'SMJ'


	