   
   select mi.MIFieldDefinition_DataTable, * from ClientMIFieldSet cmf
   inner join MIFieldDefinition mi
   on cmf.ClientMIFieldSet_MIFieldDefCode = mi.MIFieldDefinition_MIFieldCode
   where cmf.ClientMIFieldSet_ClientMIDEFCODE = 'AZ'
   order by cmf.ClientMIFieldSet_MIFieldPosition


   SELECT * FROM [Case] c
   WHERE c.Case_BLMREF = '46487-3659'

select * from MIClaimantDetails m
where m.MIClaimantDetails_CaseID = 1969
and m.Inactive = 0

select * from MIFieldDefinition mi
where mi.MIFieldDefinition_MIFieldCode = 'AZCLSDP'
   select * from ClientMIFieldSetAdvCalc c
   where c.ClientMIFieldSetAdvCalc_ClientMIFieldSetField like '%MICFIELD76%'
   
   UPDATE ClientMIFieldSet
   SET ClientMIFieldSet_MIFieldROWrite = 1
   WHERE ClientMIFieldSet_MIFieldDefCode IN
   (
   'AZCLTSPD','AZCLTPD'
   )
UPDATE	MIFieldDefinition 
SET	MIFieldDefinition_DataTable = 'ManagementInformation',
	MIFieldDefinition_DataField = 'ManagementInformation_CoDefSol'
WHERE	MIFieldDefinition_DataField = 'LVMIDetails_CoDefSol'
AND	MIFieldDefinition_DataTable = 'LVMIDetails'

  EXEC [ClientMIFieldSet_Fetch]  @pCase_CaseID = 1969 ,  @pGetCosts = 0 ,  @pUser_Name = 'SMJ', @pIsClaimant = 1



  