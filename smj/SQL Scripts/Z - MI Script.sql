--1. INSERT NEW SET INTO ClientMIDefinition

  	INSERT INTO ClientMIDefinition
  	SELECT NULL, 'Z-KPL', NULL, 'Z-KPL', 'ZURICH', 0, 'SMJ', GETDATE()

--2. INSERT CLIENT PANELS
	INSERT INTO ClientMIPanels
	SELECT 'Z-KPL',1,1,'Dates',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'Z-KPL',2,1,'Zurich MI Details Cont…',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'Z-KPL',3,1,'Zurich MI Details PAD Only',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'Z-KPL',1,1,'Financials 1',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'Z-KPL',2,1,'Financials 2',0,GETDATE(), 'SMJ'	
	
	INSERT INTO ClientMIPanels
	SELECT 'Z-KPL',3,1,'Financials 3',0,GETDATE(), 'SMJ'

--3. ASSIGN FIELD SET TO CLIENT MI DEFINITION
	INSERT INTO ClientMIFieldSet
	SELECT 'Z-KPL',[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText]
	FROM ClientMIFieldSet
	WHERE [ClientMIFieldSet_ClientMIDEFCODE] = 'ZUR' 

--4. INSERT ADV CALCS
	INSERT INTO ClientMIFieldSetAdvCalc
	SELECT	REPLACE(ClientMIFieldSetAdvCalc_ClientMIFieldSetField, 'ZUR', 'Z-KPL'),
			[ClientMIFieldSetAdvCalc_CalculationDetails],
			0,
			GETDATE(),
			'SMJ'
    	FROM ClientMIFieldSetAdvCalc
  	WHERE ClientMIFieldSetAdvCalc_ClientMIFieldSetField LIKE 'ZUR%'