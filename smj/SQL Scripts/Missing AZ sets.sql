--SHOULDN'T HAVE THE WORD 'CLAIM' IN THE CLIENTGROUPCODE
SELECT * FROM ClientMIDefinition cmd
WHERE cmd.ClientMIDefinition_CLIENTGROUPCODE LIKE 'AZ%'
ORDER BY cmd.ClientMIDefinition_CLIENTGROUPCODE

/*** UPDATE ClientMIDefinition TO REMOVE 'CLAIM' FROM THE CLIENTGROUPCODE ***/
UPDATE ClientMIDefinition
SET ClientMIDefinition_CLIENTGROUPCODE = REPLACE(ClientMIDefinition_CLIENTGROUPCODE, 'CLAIM', '')
FROM ClientMIDefinition
WHERE ClientMIDefinition_CLIENTGROUPCODE LIKE 'AZ%'
/*** UPDATE ClientMIDefinition TO REMOVE 'CLAIM' FROM THE CLIENTGROUPCODE ***/	

--INSERT THE NEW SETS	
/*** AZ-FR ***/
--INSERT MATTER CENTRIC MI DEFINITONS
INSERT INTO ClientMIDefinition
SELECT NULL, 'AZ-FR', 
ClientMIDefinition_WORKTYPECODE, 'AZ-FR', ClientMIDefinition_LKPFilter, ClientMIDefinition_Inactive, 'SMJ', GETDATE(), ClientMIDefinition_IsClaimant
FROM ClientMIDefinition cmd
WHERE cmd.ClientMIDefinition_CLIENTGROUPCODE = 'AZ-CH'

--INSERT CLAIMANT CENTRIC DEFINITONS
INSERT INTO ClientMIDefinition
SELECT NULL, 'AZ-FR', 
ClientMIDefinition_WORKTYPECODE, 'AZ-FRCLAIM', ClientMIDefinition_LKPFilter, ClientMIDefinition_Inactive, 'SMJ', GETDATE(), ClientMIDefinition_IsClaimant
FROM ClientMIDefinition cmd
WHERE cmd.ClientMIDefinition_CLIENTGROUPCODE = 'AZ-CHCLAIM'  	

--INSERT MATTER CENTRIC MI PANELS
INSERT INTO ClientMIPanels
SELECT 'AZ-FR', ClientMIPanels_PanelNo, ClientMIPanels_PageNo, ClientMIPanels_Description, ClientMIPanels_Inactive, GETDATE(), ClientMIPanels_ClientUser
FROM ClientMIPanels c
WHERE c.ClientMIPanels_ClientMIDefCode = 'AZ-CH'

--INSERT CLAIMANT CENTRIC MI PANELS
INSERT INTO ClientMIPanels
SELECT 'AZ-FRCLAIM', ClientMIPanels_PanelNo, ClientMIPanels_PageNo, ClientMIPanels_Description, ClientMIPanels_Inactive, GETDATE(), ClientMIPanels_ClientUser
FROM ClientMIPanels c
WHERE c.ClientMIPanels_ClientMIDefCode = 'AZ-CHCLAIM'	

--INSERT MATTER CENTRIC MI FIELDSET
INSERT INTO ClientMIFieldSet
SELECT 'AZ-FR', ClientMIFieldSet_MIFieldDefCode, ClientMIFieldSet_MIFieldPosition, ClientMIFieldSet_MIFieldLabel, ClientMIFieldSet_MIFieldRO, ClientMIFieldSet_MIFieldMAND, ClientMIFieldSet_Inactive, GETDATE(), ClientMIFieldSet_CreateUser, ClientMIFieldSet_OnChangeText, ClientMIFieldSet_MIFieldROWrite
FROM ClientMIFieldSet c
WHERE c.ClientMIFieldSet_ClientMIDEFCODE = 'AZ-CH'

--INSERT CLAIMANT CENTRIC MI FIELDSET
INSERT INTO ClientMIFieldSet
SELECT 'AZ-FRCLAIM', ClientMIFieldSet_MIFieldDefCode, ClientMIFieldSet_MIFieldPosition, ClientMIFieldSet_MIFieldLabel, ClientMIFieldSet_MIFieldRO, ClientMIFieldSet_MIFieldMAND, ClientMIFieldSet_Inactive, GETDATE(), ClientMIFieldSet_CreateUser, ClientMIFieldSet_OnChangeText, ClientMIFieldSet_MIFieldROWrite
FROM ClientMIFieldSet c
WHERE c.ClientMIFieldSet_ClientMIDEFCODE = 'AZ-CHCLAIM'	
/*** AZ-FR ***/	

/*** AZ-GR ***/
--INSERT MATTER CENTRIC MI DEFINITONS
INSERT INTO ClientMIDefinition
SELECT NULL, 'AZ-GR', 
ClientMIDefinition_WORKTYPECODE, 'AZ-GR', ClientMIDefinition_LKPFilter, ClientMIDefinition_Inactive, 'SMJ', GETDATE(), ClientMIDefinition_IsClaimant
FROM ClientMIDefinition cmd
WHERE cmd.ClientMIDefinition_CLIENTGROUPCODE = 'AZ-CH'

--INSERT CLAIMANT CENTRIC DEFINITONS
INSERT INTO ClientMIDefinition
SELECT NULL, 'AZ-GR', 
ClientMIDefinition_WORKTYPECODE, 'AZ-GRCLAIM', ClientMIDefinition_LKPFilter, ClientMIDefinition_Inactive, 'SMJ', GETDATE(), ClientMIDefinition_IsClaimant
FROM ClientMIDefinition cmd
WHERE cmd.ClientMIDefinition_CLIENTGROUPCODE = 'AZ-CHCLAIM'  	

--INSERT MATTER CENTRIC MI PANELS
INSERT INTO ClientMIPanels
SELECT 'AZ-GR', ClientMIPanels_PanelNo, ClientMIPanels_PageNo, ClientMIPanels_Description, ClientMIPanels_Inactive, GETDATE(), ClientMIPanels_ClientUser
FROM ClientMIPanels c
WHERE c.ClientMIPanels_ClientMIDefCode = 'AZ-CH'

--INSERT CLAIMANT CENTRIC MI PANELS
INSERT INTO ClientMIPanels
SELECT 'AZ-GRCLAIM', ClientMIPanels_PanelNo, ClientMIPanels_PageNo, ClientMIPanels_Description, ClientMIPanels_Inactive, GETDATE(), ClientMIPanels_ClientUser
FROM ClientMIPanels c
WHERE c.ClientMIPanels_ClientMIDefCode = 'AZ-CHCLAIM'	

--INSERT MATTER CENTRIC MI FIELDSET
INSERT INTO ClientMIFieldSet
SELECT 'AZ-GR', ClientMIFieldSet_MIFieldDefCode, ClientMIFieldSet_MIFieldPosition, ClientMIFieldSet_MIFieldLabel, ClientMIFieldSet_MIFieldRO, ClientMIFieldSet_MIFieldMAND, ClientMIFieldSet_Inactive, GETDATE(), ClientMIFieldSet_CreateUser, ClientMIFieldSet_OnChangeText, ClientMIFieldSet_MIFieldROWrite
FROM ClientMIFieldSet c
WHERE c.ClientMIFieldSet_ClientMIDEFCODE = 'AZ-CH'

--INSERT CLAIMANT CENTRIC MI FIELDSET
INSERT INTO ClientMIFieldSet
SELECT 'AZ-GRCLAIM', ClientMIFieldSet_MIFieldDefCode, ClientMIFieldSet_MIFieldPosition, ClientMIFieldSet_MIFieldLabel, ClientMIFieldSet_MIFieldRO, ClientMIFieldSet_MIFieldMAND, ClientMIFieldSet_Inactive, GETDATE(), ClientMIFieldSet_CreateUser, ClientMIFieldSet_OnChangeText, ClientMIFieldSet_MIFieldROWrite
FROM ClientMIFieldSet c
WHERE c.ClientMIFieldSet_ClientMIDEFCODE = 'AZ-CHCLAIM'	
/*** AZ-GR ***/		


/*** AZ-CS ***/
--INSERT MATTER CENTRIC MI DEFINITONS
INSERT INTO ClientMIDefinition
SELECT NULL, 'AZ-CS', 
ClientMIDefinition_WORKTYPECODE, 'AZ-CS', ClientMIDefinition_LKPFilter, ClientMIDefinition_Inactive, 'SMJ', GETDATE(), ClientMIDefinition_IsClaimant
FROM ClientMIDefinition cmd
WHERE cmd.ClientMIDefinition_CLIENTGROUPCODE = 'AZ-CH'

--INSERT CLAIMANT CENTRIC DEFINITONS
INSERT INTO ClientMIDefinition
SELECT NULL, 'AZ-CSCLAIM', 
ClientMIDefinition_WORKTYPECODE, 'AZ-CSCLAIM', ClientMIDefinition_LKPFilter, ClientMIDefinition_Inactive, 'SMJ', GETDATE(), ClientMIDefinition_IsClaimant
FROM ClientMIDefinition cmd
WHERE cmd.ClientMIDefinition_CLIENTGROUPCODE = 'AZ-CHCLAIM'  	

--INSERT MATTER CENTRIC MI PANELS
INSERT INTO ClientMIPanels
SELECT 'AZ-CS', ClientMIPanels_PanelNo, ClientMIPanels_PageNo, ClientMIPanels_Description, ClientMIPanels_Inactive, GETDATE(), ClientMIPanels_ClientUser
FROM ClientMIPanels c
WHERE c.ClientMIPanels_ClientMIDefCode = 'AZ-CH'

--INSERT CLAIMANT CENTRIC MI PANELS
INSERT INTO ClientMIPanels
SELECT 'AZ-CSCLAIM', ClientMIPanels_PanelNo, ClientMIPanels_PageNo, ClientMIPanels_Description, ClientMIPanels_Inactive, GETDATE(), ClientMIPanels_ClientUser
FROM ClientMIPanels c
WHERE c.ClientMIPanels_ClientMIDefCode = 'AZ-CHCLAIM'	

--INSERT MATTER CENTRIC MI FIELDSET
INSERT INTO ClientMIFieldSet
SELECT 'AZ-CS', ClientMIFieldSet_MIFieldDefCode, ClientMIFieldSet_MIFieldPosition, ClientMIFieldSet_MIFieldLabel, ClientMIFieldSet_MIFieldRO, ClientMIFieldSet_MIFieldMAND, ClientMIFieldSet_Inactive, GETDATE(), ClientMIFieldSet_CreateUser, ClientMIFieldSet_OnChangeText, ClientMIFieldSet_MIFieldROWrite
FROM ClientMIFieldSet c
WHERE c.ClientMIFieldSet_ClientMIDEFCODE = 'AZ-CH'

--INSERT CLAIMANT CENTRIC MI FIELDSET
INSERT INTO ClientMIFieldSet
SELECT 'AZ-CSCLAIM', ClientMIFieldSet_MIFieldDefCode, ClientMIFieldSet_MIFieldPosition, ClientMIFieldSet_MIFieldLabel, ClientMIFieldSet_MIFieldRO, ClientMIFieldSet_MIFieldMAND, ClientMIFieldSet_Inactive, GETDATE(), ClientMIFieldSet_CreateUser, ClientMIFieldSet_OnChangeText, ClientMIFieldSet_MIFieldROWrite
FROM ClientMIFieldSet c
WHERE c.ClientMIFieldSet_ClientMIDEFCODE = 'AZ-CHCLAIM'	
/*** AZ-CS ***/		

/*** CHECK SETS ***/  
SELECT * FROM ClientMIDefinition cmd
WHERE cmd.ClientMIDefinition_CLIENTGROUPCODE LIKE 'AZ%'
ORDER BY cmd.ClientMIDefinition_CLIENTGROUPCODE

SELECT * FROM ClientMIPanels cmp
WHERE cmp.ClientMIPanels_ClientMIDefCode LIKE 'AZ%'
ORDER BY cmp.ClientMIPanels_ClientMIDefCode

SELECT * FROM ClientMIFieldSet cmf
WHERE cmf.ClientMIFieldSet_ClientMIDEFCODE LIKE 'AZ%'
ORDER BY cmf.ClientMIFieldSet_ClientMIDEFCODE, ClientMIFieldSet_MIFieldPosition
/*** CHECK SETS ***/  




