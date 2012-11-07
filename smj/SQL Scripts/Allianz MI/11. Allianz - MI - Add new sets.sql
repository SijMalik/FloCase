--1. INSERT NEW SET INTO ClientMIDefinition
--CLIENT CATEGORIES
AZ	Allianz
AZ-CH	Allianz Outsource
--AZ-FR	Allianz Fraud /* NOT GOING IN */
AZ-IN	Allianz International Claims
AZ-ML	Allianz Major Loss


  	/* MATTER MI */
  	INSERT INTO ClientMIDefinition
  	SELECT NULL, 'AZ-CH', NULL, 'AZ-CH', 'ALLIANZ', 0, 'SMJ', GETDATE(), 0

  	INSERT INTO ClientMIDefinition
  	SELECT NULL, 'AZ-IN', NULL, 'AZ-IN', 'ALLIANZ', 0, 'SMJ', GETDATE(), 0

  	INSERT INTO ClientMIDefinition
  	SELECT NULL, 'AZ-ML', NULL, 'AZ-ML', 'ALLIANZ', 0, 'SMJ', GETDATE(), 0


  	/* CLAIMANT MI */
	INSERT INTO ClientMIDefinition
  	SELECT NULL, 'AZ-CHCLAIM', 'CLAIM', 'AZ-CHCLAIM', 'ALLIANZ', 0, 'SMJ', GETDATE(), 1

	INSERT INTO ClientMIDefinition
  	SELECT NULL, 'AZ-INCLAIM', 'CLAIM', 'AZ-INCLAIM', 'ALLIANZ', 0, 'SMJ', GETDATE(), 1

	INSERT INTO ClientMIDefinition
  	SELECT NULL, 'AZ-MLCLAIM', 'CLAIM', 'AZ-MLCLAIM', 'ALLIANZ', 0, 'SMJ', GETDATE(), 1



--2. INSERT CLIENT PANELS

	/* MATTER MI */
	--PAGE 1
	--CH
	INSERT INTO ClientMIPanels
	SELECT 'AZ-CH',1,1,'Allianz Dates (For Info Purposes Only)',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'AZ-CH',2,1,'Allianz - General MI',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'AZ-CH',3,1,'Allianz - Reserve',0,GETDATE(), 'SMJ'

	--IN
	INSERT INTO ClientMIPanels
	SELECT 'AZ-IN',1,1,'Allianz Dates (For Info Purposes Only)',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'AZ-IN',2,1,'Allianz - General MI',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'AZ-IN',3,1,'Allianz - Reserve',0,GETDATE(), 'SMJ'

	--ML
	INSERT INTO ClientMIPanels
	SELECT 'AZ-ML',1,1,'Allianz Dates (For Info Purposes Only)',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'AZ-ML',2,1,'Allianz - General MI',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'AZ-ML',3,1,'Allianz - Reserve',0,GETDATE(), 'SMJ'


	--PAGE 2
	--CH
	INSERT INTO ClientMIPanels
	SELECT 'AZ-CH',1,2,'Allianz - Credit Hire',0,GETDATE(), 'SMJ'
	
	INSERT INTO ClientMIPanels
	SELECT 'AZ-CH',2,2,'Allianz - Credit Hire (Cont)',0,GETDATE(), 'SMJ' 

	--IN
	INSERT INTO ClientMIPanels
	SELECT 'AZ-IN',1,2,'Allianz - Credit Hire',0,GETDATE(), 'SMJ'
	
	INSERT INTO ClientMIPanels
	SELECT 'AZ-IN',2,2,'Allianz - Credit Hire (Cont)',0,GETDATE(), 'SMJ' 

	--ML
	INSERT INTO ClientMIPanels
	SELECT 'AZ-ML',1,2,'Allianz - Credit Hire',0,GETDATE(), 'SMJ'
	
	INSERT INTO ClientMIPanels
	SELECT 'AZ-ML',2,2,'Allianz - Credit Hire (Cont)',0,GETDATE(), 'SMJ' 
 


	/* CLAIMANT MI */
  	--PAGE 1
	--CH
	INSERT INTO ClientMIPanels
	SELECT 'AZ-CHCLAIM',1,1,'Allianz Claimant Specific MI',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'AZ-CHCLAIM',2,1,'  ',0,GETDATE(), 'SMJ'

	--IN
	INSERT INTO ClientMIPanels
	SELECT 'AZ-INCLAIM',1,1,'Allianz Claimant Specific MI',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'AZ-INCLAIM',2,1,'  ',0,GETDATE(), 'SMJ'


	--ML
	INSERT INTO ClientMIPanels
	SELECT 'AZ-MLCLAIM',1,1,'Allianz Claimant Specific MI',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'AZ-MLCLAIM',2,1,'  ',0,GETDATE(), 'SMJ'


--3. ADD NEW CLIENTMIFIELDSET

	/* MATTER MI */
	--CH
	INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
	SELECT 'AZ-CH',[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText]
	FROM ClientMIFieldSet
	WHERE [ClientMIFieldSet_ClientMIDEFCODE] = 'AZ'

	--IN
	INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
	SELECT 'AZ-IN',[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText]
	FROM ClientMIFieldSet
	WHERE [ClientMIFieldSet_ClientMIDEFCODE] = 'AZ'

	--ML
	INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
	SELECT 'AZ-ML',[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText]
	FROM ClientMIFieldSet
	WHERE [ClientMIFieldSet_ClientMIDEFCODE] = 'AZ'


	
	/* CLAIMANT MI */
	--CH
	INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
	SELECT 'AZ-CHCLAIM',[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText]
	FROM ClientMIFieldSet
	WHERE [ClientMIFieldSet_ClientMIDEFCODE] = 'AZCLAIM'

	--IN
	INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
	SELECT 'AZ-INCLAIM',[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText]
	FROM ClientMIFieldSet
	WHERE [ClientMIFieldSet_ClientMIDEFCODE] = 'AZCLAIM'

	--ML
	INSERT INTO [dbo].[ClientMIFieldSet]([ClientMIFieldSet_ClientMIDEFCODE],[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText])
	SELECT 'AZ-MLCLAIM',[ClientMIFieldSet_MIFieldDefCode],[ClientMIFieldSet_MIFieldPosition],[ClientMIFieldSet_MIFieldLabel],[ClientMIFieldSet_MIFieldRO],[ClientMIFieldSet_MIFieldMAND],[ClientMIFieldSet_Inactive],[ClientMIFieldSet_CreateDate],[ClientMIFieldSet_CreateUser],[ClientMIFieldSet_OnChangeText]
	FROM ClientMIFieldSet
	WHERE [ClientMIFieldSet_ClientMIDEFCODE] = 'AZCLAIM'
	