   select cmf.ClientMIFieldSet_MIFieldLabel,  mi.MIFieldDefinition_MIFieldCode, mi.MIFieldDefinition_DataField, mi.MIFieldDefinition_DataTable from ClientMIFieldSet cmf
   inner join MIFieldDefinition mi
   on cmf.ClientMIFieldSet_MIFieldDefCode = mi.MIFieldDefinition_MIFieldCode
   where cmf.ClientMIFieldSet_ClientMIDEFCODE = 'LV'
   and cmf.ClientMIFieldSet_MIFieldRO = 1
   order by cmf.ClientMIFieldSet_MIFieldPosition
   
select * from ClientMIFieldSetAdvCalc c
where c.ClientMIFieldSetAdvCalc_ClientMIFieldSetField like '%CoDefSol%'


select * from [Case]   c
where c.Case_BLMREF = '148904-116'

select * from CaseContacts cc
where cc.CaseContacts_RoleCode = 'CLAIMNAME'
   
   
CLIREF - 
LVOFFICE - 
AAAAAAAAAA - 
CLCTPCODE - 
CODEFSOL - 
CDFSCNTCT
LVTPINS - 
CLAIMNAME - 
LVCLSO - 
DTEINSTR - 
DTEACC - 

