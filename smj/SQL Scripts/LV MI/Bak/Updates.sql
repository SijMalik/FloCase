--Was set to wrong table
UPDATE MIFieldDefinition 
SET MIFieldDefinition_DataTable = 'Financial'
WHERE MIFieldDefinition_MIFieldCode = 'CTABLECSTS'