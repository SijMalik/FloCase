   EXEC [ClientMIFieldSet_Fetch]  @pCase_CaseID = 1663 ,  @pGetCosts = 0 ,  @pUser_Name = 'SMJ'    
   
   select * from ClientMIFieldSet cmf --where cmf.ClientMIFieldSet_MIFieldDefCode = 'MICFIELD76'
   inner join MIFieldDefinition mi
   on cmf.ClientMIFieldSet_MIFieldDefCode = mi.MIFieldDefinition_MIFieldCode
   where cmf.ClientMIFieldSet_ClientMIDEFCODE = 'Aviva'
   AND cmf.ClientMIFieldSet_Inactive = 0
   AND mi.MIFieldDefinition_Inactive = 0
   order by cmf.ClientMIFieldSet_MIFieldPosition
   
   EXEC [ClientMIFieldSet_Fetch]  @pCase_CaseID = 1982 ,  @pGetCosts = 0 ,  @pUser_Name = 'SMJ'      
   
EXEC [ClaimantMIFieldSet_ProcessForSave]  @pMIData = '%60MISAVE%62%60CASEID%621663%60/CASEID%62%60USERNAME%62SMJ%60/USERNAME%62%60CONTACTID%622343%60/CONTACTID%62%60CONTROLS%62%60CONTROL ID="1"%62%60MIFieldCode%62ClmDOB%60/MIFieldCode%62%60MIFieldValue%62NaN/NaN/NaN%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="2"%62%60MIFieldCode%62CLAIINF%60/MIFieldCode%62%60MIFieldValue%62N%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="3"%62%60MIFieldCode%62AZCLCSF%60/MIFieldCode%62%60MIFieldValue%620%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="4"%62%60MIFieldCode%62MICFIELD05%60/MIFieldCode%62%60MIFieldValue%620%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="6"%62%60MIFieldCode%62CurrResDam%60/MIFieldCode%62%60MIFieldValue%620%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="7"%62%60MIFieldCode%62MICFIELD76%60/MIFieldCode%62%60MIFieldValue%621.00%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="8"%62%60MIFieldCode%62CurrResTot%60/MIFieldCode%62%60MIFieldValue%620%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="9"%62%60MIFieldCode%62CurrResTPC%60/MIFieldCode%62%60MIFieldValue%621.00%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="10"%62%60MIFieldCode%62RALDAMAGES%60/MIFieldCode%62%60MIFieldValue%621.00%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="11"%62%60MIFieldCode%62IALDAMAGES%60/MIFieldCode%62%60MIFieldValue%621.00%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="12"%62%60MIFieldCode%62BLANK%60/MIFieldCode%62%60MIFieldValue%62%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="13"%62%60MIFieldCode%62FROWNCRES%60/MIFieldCode%62%60MIFieldValue%621.00%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="14"%62%60MIFieldCode%62FRTPCRGRS%60/MIFieldCode%62%60MIFieldValue%621.00%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="15"%62%60MIFieldCode%62FRTPBIRES%60/MIFieldCode%62%60MIFieldValue%621.00%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="16"%62%60MIFieldCode%62FRTPPDRES%60/MIFieldCode%62%60MIFieldValue%621.00%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="18"%62%60MIFieldCode%62MICFIELD15%60/MIFieldCode%62%60MIFieldValue%622.00%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="19"%62%60MIFieldCode%62MICFIELD14%60/MIFieldCode%62%60MIFieldValue%622.00%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="20"%62%60MIFieldCode%62TPCCINT%60/MIFieldCode%62%60MIFieldValue%622.00%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="21"%62%60MIFieldCode%62CSTPRFCSTS%60/MIFieldCode%62%60MIFieldValue%622.00%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="22"%62%60MIFieldCode%62TPCCPT47%60/MIFieldCode%62%60MIFieldValue%622.00%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="23"%62%60MIFieldCode%62MICFIELD16%60/MIFieldCode%62%60MIFieldValue%622.00%60/MIFieldValue%62%60/CONTROL%62%60CONTROL ID="24"%62%60MIFieldCode%62AZCLTTPCC%60/MIFieldCode%62%60MIFieldValue%620%60/MIFieldValue%62%60/CONTROL%62%60/CONTROLS%62%60/MISAVE%62'    
   --BLM REF
   --78287-24
   select * from KeyDatesType k where k.Inactive = 0
select * from MIFieldDefinition
where MIFieldDefinition_MILKPFieldCode = 'NULL'

UPDATE MIFieldDefinition
set MIFieldDefinition_MILKPFieldCode = NULL
where MIFieldDefinition_MILKPFieldCode = 'NULL'
   --Aviva Claim
   EXEC [ClientMIFieldSet_Fetch]  @pCase_CaseID = 1669 ,  @pGetCosts = 0 ,  @pUser_Name = 'SMJ', @pCaseContactID = 1

  select * from MIFieldDefinition mi
  where mi.MIFieldDefinition_DataField = 'TRIOUTCOME'
  
  select * from MIFieldDefinition mi
  where mi.MIFieldDefinition_MIFieldCode like '%MICFIELD15%'
  
  select * from MIFieldDefinition mi
  where mi.MIFieldDefinition_FieldDescription like '%sol%'
  

  select * from MILookupFieldDefinition ml
  where ml.MILookupFieldDefinition_MILookupFieldCode like '%MICFIELD15%'
  
  select * from ClientMIFieldSetAdvCalc c
  where c.ClientMIFieldSetAdvCalc_ClientMIFieldSetField like '%tptot%'
  

  select * from ClientMIFieldSet cmf where cmf.ClientMIFieldSet_MIFieldLabel like '%moj%'
  
  --update MIFieldDefinition
  --set MIFieldDefinition_KeyDateType = 'DTELITPOST'
  --where MIFieldDefinition_MIFieldDefinitionID = 1420

select * from [Case] c where c.Case_BLMREF = '136179-1521'

EXEC [ClientMIFieldSet_Fetch]  @pCase_CaseID = 1662 ,  @pGetCosts = 0 ,  @pUser_Name = 'SMJ'


select * from ClientMIFieldSetAdvCalc c
inner join dbo.Split ('ClmDOB,MICFIELD05,CurrResDam,CurrResTot,AZCLTTPCC,AZCLTPD,AZCLTPD,AZCLTTPCP', ',') s
on c.ClientMIFieldSetAdvCalc_ClientMIFieldSetField like '%' + s.items + '%'

--Agreed Total Special Damages
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'AVIVACLAIMAZCLTSPD', 
	'SELECT @OUT = ISNULL(MIClaimantDetails_SpecialDamagesPaidExcluding, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCRU, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidNHS, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidAmb, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidPropertyDamage, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCreditHire, 0.00) FROM MIClaimantDetails WHERE MIClaimantDetails_CaseID = @CaseID AND MIClaimantDetails_ContactID = $CONTACTID AND INACTIVE = 0',
	0, GETDATE(), 'SMJ'


SELECT SUBSTRING( 'ManagementInformation_CaseContactID',1,CHARINDEX('_','ManagementInformation_CaseContactID')-1)






 
 
 