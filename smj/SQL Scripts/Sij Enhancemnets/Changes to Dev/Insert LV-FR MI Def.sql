	INSERT INTO ClientMIDefinition
  	SELECT NULL, 'LV-FR', NULL, 'LV-FR', 'LV', 0, 'SMJ', GETDATE(), 0

	INSERT INTO ClientMIPanels
	SELECT 'LV-FR', ClientMIPanels_PanelNo, ClientMIPanels_PageNo, ClientMIPanels_Description, ClientMIPanels_Inactive, GETDATE(), ClientMIPanels_ClientUser
	FROM ClientMIPanels c
	WHERE c.ClientMIPanels_ClientMIDefCode = 'LV-N'
	
	INSERT INTO ClientMIFieldSet
	SELECT 'LV-FR', ClientMIFieldSet_MIFieldDefCode, ClientMIFieldSet_MIFieldPosition, ClientMIFieldSet_MIFieldLabel, ClientMIFieldSet_MIFieldRO, ClientMIFieldSet_MIFieldMAND, ClientMIFieldSet_Inactive, GETDATE(), ClientMIFieldSet_CreateUser, ClientMIFieldSet_OnChangeText, ClientMIFieldSet_MIFieldROWrite
	FROM ClientMIFieldSet c
	WHERE c.ClientMIFieldSet_ClientMIDEFCODE = 'LV-N'