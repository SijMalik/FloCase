--Incorrect Workflownames

  UPDATE AppTaskDefinition
  SET ProcessName = 'LTMM Case Users'
  WHERE ProcessName = 'LTMMCaseUsers'
  
  UPDATE AppTaskDefinition
  SET ProcessName = 'LTMM Financials'
  WHERE ProcessName = 'LTMMFinancials'  
  
  UPDATE AppTaskDefinition
  SET WorkflowName = 'Contact Details'
  WHERE ProcessName = 'LTMMMatterContacts'   
    
  UPDATE AppTaskDefinition
  SET ProcessName = 'LTMM Matter Contacts'
  WHERE ProcessName = 'LTMMMatterContacts' 
  
  UPDATE AppTaskDefinition
  SET ProcessName = 'LTMM AdHoc Documents Screen'
  WHERE ProcessName = 'LTMMAdHocDocumentsScreen'    
  
  UPDATE AppTaskDefinition
  SET ProcessName = 'LTMM SRF 10 Week'
  WHERE ProcessName = 'LTMMSRF10Week'    
  
  UPDATE AppTaskDefinition
  SET WorkflowName = 'Pre Trial'
  WHERE AppTaskDefinitionID = 103