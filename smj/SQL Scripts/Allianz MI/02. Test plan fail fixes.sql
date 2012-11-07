--CLAIMANT MI CHANGES:

-- LABEL CHANGE
  UPDATE [ClientMIFieldSet]
  SET [ClientMIFieldSet_MIFieldLabel] = 'Special Damages Paid - Other'
  WHERE [ClientMIFieldSet_MIFieldDefCode]=  'AZCLSDP'
  

-- TOTAL SPECIAL DAMAGES PAID CALCULATION
  UPDATE [ClientMIFieldSetAdvCalc]
  SET [ClientMIFieldSetAdvCalc_CalculationDetails] =
  'SELECT @OUT = ISNULL(MIClaimantDetails_SpecialDamagesPaidExcluding, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCRU, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidNHS, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidAmb, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidPropertyDamage, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCreditHire, 0.00) FROM MIClaimantDetails WHERE MIClaimantDetails_CaseID = @CaseID AND MIClaimantDetails_ContactID = $CONTACTID AND INACTIVE = 0'
  WHERE [ClientMIFieldSetAdvCalc_ClientMIFieldSetField] LIKE '%AZCLTSPD%'
  

-- TOTAL DAMAGES PAID CALCULATION
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZCLAIMAZCLTPD', 
  'SELECT @OUT = ISNULL(MIClaimantDetails_SpecialDamagesPaidExcluding, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCRU, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidNHS, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidAmb, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidPropertyDamage, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCreditHire, 0.00) + ISNULL(MIClaimantDetails_GeneralDamagesPaid, 0.00) FROM MIClaimantDetails WHERE MIClaimantDetails_CaseID = @CaseID AND MIClaimantDetails_ContactID = $CONTACTID AND Inactive = 0',
  0, GETDATE(), 'SMJ'

  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-CHCLAIMAZCLTPD', 
  'SELECT @OUT = ISNULL(MIClaimantDetails_SpecialDamagesPaidExcluding, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCRU, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidNHS, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidAmb, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidPropertyDamage, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCreditHire, 0.00) + ISNULL(MIClaimantDetails_GeneralDamagesPaid, 0.00) FROM MIClaimantDetails WHERE MIClaimantDetails_CaseID = @CaseID AND MIClaimantDetails_ContactID = $CONTACTID AND Inactive = 0',
  0, GETDATE(), 'SMJ'
    
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-INCLAIMAZCLTPD', 
  'SELECT @OUT = ISNULL(MIClaimantDetails_SpecialDamagesPaidExcluding, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCRU, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidNHS, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidAmb, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidPropertyDamage, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCreditHire, 0.00) + ISNULL(MIClaimantDetails_GeneralDamagesPaid, 0.00) FROM MIClaimantDetails WHERE MIClaimantDetails_CaseID = @CaseID AND MIClaimantDetails_ContactID = $CONTACTID AND Inactive = 0',
  0, GETDATE(), 'SMJ'  
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-MLCLAIMAZCLTPD', 
  'SELECT @OUT = ISNULL(MIClaimantDetails_SpecialDamagesPaidExcluding, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCRU, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidNHS, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidAmb, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidPropertyDamage, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCreditHire, 0.00) + ISNULL(MIClaimantDetails_GeneralDamagesPaid, 0.00) FROM MIClaimantDetails WHERE MIClaimantDetails_CaseID = @CaseID AND MIClaimantDetails_ContactID = $CONTACTID AND Inactive = 0',
  0, GETDATE(), 'SMJ'  


-- SET CALC FIELDS READ-ONLY
  UPDATE ClientMIFieldSet
  SET ClientMIFieldSet_MIFieldRO = 1
  WHERE ClientMIFieldSet_MIFieldDefCode
  IN ('AZCLTSPD','AZCLTPD')

--UPDATE FIELDS

  UPDATE MIFieldDefinition
  SET MIFieldDefinition_MIFieldTypeCode = 'MIMONEY'
  WHERE [MIFieldDefinition_MIFieldCode] = 'AZCLDR'

  --NEED TO CHANGE COLUMN TYPES AS COLUMNS BELOW NEED TO BE PERCENTAGE
  ALTER TABLE MIClaimantDetails ALTER COLUMN [MIClaimantDetails_AllianzLiabilityDefendant] [float] NULL
  ALTER TABLE MIClaimantDetails ALTER COLUMN [MIClaimantDetails_AllianzLiabilityContribNeg] [float] NULL

  --CHANGE TO PERCENT 
  UPDATE MIFieldDefinition
  SET MIFieldDefinition_MIFieldTypeCode = 'MIINT'
	WHERE [MIFieldDefinition_MIFieldCode] IN
  ('AZCLPLRD', 'AZCLPLRCN')
-------------------------------------------------------------

--MAIN MI CHANGES:

  --SQL FOR ALLIANZ REFERENCE	
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZMIFLD00002', 
  'SELECT @OUT = ISNULL(CaseContacts_Reference, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_ClientID, 0) > 0 AND CaseContacts_CaseID = @CaseID',
  0, GETDATE(), 'SMJ'
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-CHMIFLD00002', 
  'SELECT @OUT = ISNULL(CaseContacts_Reference, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_ClientID, 0) > 0 AND CaseContacts_CaseID = @CaseID',
  0, GETDATE(), 'SMJ'  
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-INMIFLD00002', 
  'SELECT @OUT = ISNULL(CaseContacts_Reference, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_ClientID, 0) > 0 AND CaseContacts_CaseID = @CaseID',
  0, GETDATE(), 'SMJ'   
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-MLMIFLD00002', 
  'SELECT @OUT = ISNULL(CaseContacts_Reference, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_ClientID, 0) > 0 AND CaseContacts_CaseID = @CaseID',
  0, GETDATE(), 'SMJ'    
  ----	
 
  --SQL FOR ALLIANZ INSURED
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZAAAAAAAAAA', 
  'SELECT @OUT = CASE WHEN EXISTS (SELECT TOP 1 ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''INS'' AND CaseContacts_CaseID = @CaseID) THEN (SELECT TOP 1 ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''INS'' AND CaseContacts_CaseID = @CaseID) ELSE (SELECT TOP 1 ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''Defendant'' AND CaseContacts_CaseID = @CaseID) END',
  0, GETDATE(), 'SMJ'
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-CHAAAAAAAAAA', 
  'SELECT @OUT = CASE WHEN EXISTS (SELECT TOP 1 ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''INS'' AND CaseContacts_CaseID = @CaseID) THEN (SELECT TOP 1 ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''INS'' AND CaseContacts_CaseID = @CaseID) ELSE (SELECT TOP 1 ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''Defendant'' AND CaseContacts_CaseID = @CaseID) END',
  0, GETDATE(), 'SMJ'  
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-INAAAAAAAAAA', 
  'SELECT @OUT = CASE WHEN EXISTS (SELECT TOP 1 ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''INS'' AND CaseContacts_CaseID = @CaseID) THEN (SELECT TOP 1 ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''INS'' AND CaseContacts_CaseID = @CaseID) ELSE (SELECT TOP 1 ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''Defendant'' AND CaseContacts_CaseID = @CaseID) END',
  0, GETDATE(), 'SMJ'  
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-MLAAAAAAAAAA', 
  'SELECT @OUT = CASE WHEN EXISTS (SELECT TOP 1 ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''INS'' AND CaseContacts_CaseID = @CaseID) THEN (SELECT TOP 1 ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''INS'' AND CaseContacts_CaseID = @CaseID) ELSE (SELECT TOP 1 ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''Defendant'' AND CaseContacts_CaseID = @CaseID) END',
  0, GETDATE(), 'SMJ' 
  ----


  --NEED TO CHANGE COLUMNS FOR TOTAL DAMAGES RESERVE CALCULATION
  ALTER TABLE FinancialReserve ADD FinancialReserve_TotSpecDamRes MONEY NULL
  ALTER TABLE FinancialReserveHistory ADD FinancialReserveHistory_TotSpecDamRes MONEY NULL
  ALTER TABLE ManagementInformation DROP COLUMN ManagementInformation_TotSpecDamRes

  --CHANGE FIELD DEFINITIONS	
  UPDATE MIFieldDefinition 
  SET MIFieldDefinition_DataField = 'FinancialReserve_TotSpecDamRes',
  MIFieldDefinition_DataTable = 'FinancialReserve'
  WHERE MIFieldDefinition_MIFieldCode = 'TotSDR'

  UPDATE MIFieldDefinition 
  SET MIFieldDefinition_DataField = 'FinancialReserve_BLMCostRes',
  MIFieldDefinition_DataTable = 'FinancialReserve'
  WHERE MIFieldDefinition_MIFieldCode = 'MICFIELD76'
  ----


  --INSERT CALC FOR TOTAL DAMAGES RESERVE
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZCurrResDam', 
  'SELECT @OUT = ISNULL(FinancialReserve_GeneralDamages, 0.00) + ISNULL(FinancialReserve_SpecialDamages, 0.00) + ISNULL(FinancialReserve_Ambulance, 0.00) + ISNULL(FinancialReserve_CredHire, 0.00) + ISNULL(FinancialReserve_CRU, 0.00) + ISNULL(FinancialReserve_NHS, 0.00) + ISNULL(FinancialReserve_SpecialDamagesProp, 0.00) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID',
  0, GETDATE(), 'SMJ'
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-CHCurrResDam', 
  'SELECT @OUT = ISNULL(FinancialReserve_GeneralDamages, 0.00) + ISNULL(FinancialReserve_SpecialDamages, 0.00) + ISNULL(FinancialReserve_Ambulance, 0.00) + ISNULL(FinancialReserve_CredHire, 0.00) + ISNULL(FinancialReserve_CRU, 0.00) + ISNULL(FinancialReserve_NHS, 0.00) + ISNULL(FinancialReserve_SpecialDamagesProp, 0.00) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID',
  0, GETDATE(), 'SMJ'  
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-INCurrResDam', 
  'SELECT @OUT = ISNULL(FinancialReserve_GeneralDamages, 0.00) + ISNULL(FinancialReserve_SpecialDamages, 0.00) + ISNULL(FinancialReserve_Ambulance, 0.00) + ISNULL(FinancialReserve_CredHire, 0.00) + ISNULL(FinancialReserve_CRU, 0.00) + ISNULL(FinancialReserve_NHS, 0.00) + ISNULL(FinancialReserve_SpecialDamagesProp, 0.00) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID',
  0, GETDATE(), 'SMJ'   
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-MLCurrResDam', 
  'SELECT @OUT = ISNULL(FinancialReserve_GeneralDamages, 0.00) + ISNULL(FinancialReserve_SpecialDamages, 0.00) + ISNULL(FinancialReserve_Ambulance, 0.00) + ISNULL(FinancialReserve_CredHire, 0.00) + ISNULL(FinancialReserve_CRU, 0.00) + ISNULL(FinancialReserve_NHS, 0.00) + ISNULL(FinancialReserve_SpecialDamagesProp, 0.00) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID',
  0, GETDATE(), 'SMJ'  
  ----	

  --MAKE INACTIVE FOR TIME BEING
  update ClientMIFieldSet
  set ClientMIFieldSet_MIFieldDefCode = 'BLANK',
  ClientMIFieldSet_MIFieldLabel = 'BLANK-6'
  where ClientMIFieldSet_MIFieldDefCode = 'TotCstsPd'


  --UPDATE FIELD LABELS
  update ClientMIFieldSet
  set ClientMIFieldSet_MIFieldLabel = 'Special Damages Reserve - Other'
  where ClientMIFieldSet_MIFieldDefCode = 'IALDAMAGES'

  --ADD SEMI COLON
  UPDATE ClientMIFieldSet 
  SET ClientMIFieldSet_MIFieldLabel = ClientMIFieldSet_MIFieldLabel + ':'
  where  ClientMIFieldSet_ClientMIDEFCODE LIKE 'AZ%'


  --REMOVE SEMI COLONS
  UPDATE ClientMIFieldSet
  SET ClientMIFieldSet_MIFieldLabel = 'Allianz Financial (For Info Purposes Only)'
  WHERE ClientMIFieldSet_MIFieldLabel = 'Allianz Financial (For Info Purposes Only):'

  UPDATE ClientMIFieldSet
  SET ClientMIFieldSet_MIFieldLabel = 'Allianz MOJ MI'
  WHERE ClientMIFieldSet_MIFieldLabel = 'Allianz MOJ MI:'

  UPDATE ClientMIFieldSet
  SET ClientMIFieldSet_MIFieldLabel = ''
  WHERE ClientMIFieldSet_MIFieldLabel = ' :'
  ----


  --DATE FINAL BILL
  UPDATE ClientMIFieldSet
  SET ClientMIFieldSet_MIFieldDefCode = 'DteFinBill',
  ClientMIFieldSet_MIFieldLabel = 'Date of Final Bill:'
  WHERE ClientMIFieldSet_ClientMIDEFCODE LIKE 'AZ%'
  AND ClientMIFieldSet_MIFieldLabel = 'BLANK-1:'

  --DATE FINAL BILL PAID
  UPDATE ClientMIFieldSet
  SET ClientMIFieldSet_MIFieldDefCode = 'DteFinBillPd',
  ClientMIFieldSet_MIFieldLabel = 'Date Final Bill Paid:'
  WHERE ClientMIFieldSet_ClientMIDEFCODE LIKE 'AZ%'
  AND ClientMIFieldSet_MIFieldLabel = 'BLANK-2:'

  --DATE FIRST POSTING
  UPDATE ClientMIFieldSet
  SET ClientMIFieldSet_MIFieldDefCode = 'DteFstTmePst',
  ClientMIFieldSet_MIFieldLabel = 'Date of First Time Posting:'
  WHERE ClientMIFieldSet_ClientMIDEFCODE LIKE 'AZ%'
  AND ClientMIFieldSet_MIFieldLabel = 'BLANK-3:'

  --BLM Costs Billed
  UPDATE ClientMIFieldSet
  SET ClientMIFieldSet_MIFieldDefCode = 'BLMCstsBill',
  ClientMIFieldSet_MIFieldLabel = 'BLM Costs Billed:'
  WHERE ClientMIFieldSet_ClientMIDEFCODE LIKE 'AZ%'
  AND ClientMIFieldSet_MIFieldLabel = 'BLANK-5:'

  --Total Costs Paid
  UPDATE ClientMIFieldSet
  SET ClientMIFieldSet_MIFieldDefCode = 'TotCstsPd',
  ClientMIFieldSet_MIFieldLabel = 'Total Costs Paid:'
  WHERE ClientMIFieldSet_ClientMIDEFCODE LIKE 'AZ%'
  AND ClientMIFieldSet_MIFieldLabel = 'BLANK-6:'

  --BLM Profit Costs Billed
  UPDATE ClientMIFieldSet
  SET ClientMIFieldSet_MIFieldDefCode = 'BLMPrfCstBlld',
  ClientMIFieldSet_MIFieldLabel = 'BLM Profit Costs Billed:'
  WHERE ClientMIFieldSet_ClientMIDEFCODE LIKE 'AZ%'
  AND ClientMIFieldSet_MIFieldLabel = 'BLANK-7:'

  --CCFA Billed
  UPDATE ClientMIFieldSet
  SET ClientMIFieldSet_MIFieldDefCode = 'CCFABlld',
  ClientMIFieldSet_MIFieldLabel = 'CCFA Billed:'
  WHERE ClientMIFieldSet_ClientMIDEFCODE LIKE 'AZ%'
  AND ClientMIFieldSet_MIFieldLabel = 'BLANK-8:'


--CHANGE MIDEFINITIONS

  --FINAL BILL DATE
  UPDATE MIFieldDefinition
  SET MIFieldDefinition_DataTable = 'AllianzBillDates',
  MIFieldDefinition_DataField = 'AllianzBillDates_FinalBillDate'
  WHERE MIFieldDefinition_MIFieldCode = 'DteFinBill'

  --FINAL BILL DATE PAID 
  UPDATE MIFieldDefinition
  SET MIFieldDefinition_DataTable = 'AllianzBillDates',
  MIFieldDefinition_DataField = 'AllianzBillDates_FinalBillDatePaid'
  WHERE MIFieldDefinition_MIFieldCode = 'DteFinBillPd'

  --DATE FIRST POSTING
  UPDATE MIFieldDefinition
  SET MIFieldDefinition_DataTable = 'AllianzPostingDates',
  MIFieldDefinition_DataField = 'AllianzPostingDates_FirstTimePosting'
  WHERE MIFieldDefinition_MIFieldCode = 'DteFstTmePst'

  --BILLING DATA
  UPDATE MIFieldDefinition
  SET MIFieldDefinition_DataTable = 'AllianzBills',
  MIFieldDefinition_DataField = 'AllianzBills_BLMProf'
  WHERE MIFieldDefinition_MIFieldCode = 'BLMPrfCstBlld'

  UPDATE MIFieldDefinition
  SET MIFieldDefinition_DataTable = 'AllianzBills',
  MIFieldDefinition_DataField = 'AllianzBills_BLMCosts'
  WHERE MIFieldDefinition_MIFieldCode = 'BLMCstsBill'

  UPDATE MIFieldDefinition
  SET MIFieldDefinition_DataTable = 'AllianzBills',
  MIFieldDefinition_DataField = 'AllianzBills_CCFA'
  WHERE MIFieldDefinition_MIFieldCode = 'CCFABlld'

  UPDATE MIFieldDefinition
  SET MIFieldDefinition_DataTable = 'AllianzOffice',
  MIFieldDefinition_DataField = 'AllianzOffice_Office',
  MIFieldDefinition_AderantField = 0
  WHERE MIFieldDefinition_MIFieldCode = 'AZOffice'
  ----

  --SET FIELDS READ-ONLY
  UPDATE ClientMIFieldSet
  SET ClientMIFieldSet_MIFieldRO = 1
  WHERE ClientMIFieldSet_MIFieldDefCode
  IN
  (
  'DteFinBill',
  'DteFinBillPd',
  'DteFstTmePst',
  'BLMCstsBill',
  'TotCstsPd',
  'BLMPrfCstBlld',
  'CCFABlld'
  )

  --DON'T WRITE BACK TO ADERANT
  UPDATE MIFieldDefinition
  SET MIFieldDefinition_AderantField = 0
  WHERE MIFieldDefinition_MIFieldCode
  IN
  (
  'DteFinBill',
  'DteFinBillPd',
  'DteFstTmePst',
  'BLMCstsBill',
  'TotCstsPd',
  'BLMPrfCstBlld',
  'CCFABlld'
  )  


  --ADD INACTIVE FIELD FOR MI TO WORK PROPERLY
  ALTER TABLE AllianzBillDates ADD AllianzBillDates_Inactive BIT DEFAULT(0) NOT NULL
  ALTER TABLE AllianzBills ADD AllianzBills_Inactive BIT DEFAULT(0) NOT NULL
  ALTER TABLE AllianzOffice ADD AllianzOffice_Inactive BIT DEFAULT(0) NOT NULL
  ALTER TABLE AllianzPostingDates ADD AllianzPostingDates_Inactive BIT DEFAULT(0) NOT NULL 

  --INSERT CYCTIME CALC
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZCycTmeFBPd', 
  'SELECT @OUT = DATEDIFF(d, AllianzBillDates_FinalBillDate, AllianzBillDates_FinalBillDatePaid)   FROM AllianzBillDates WHERE AllianzBillDates_CaseID = @CaseID AND AllianzBillDates_FinalBillDate IS NOT NULL AND AllianzBillDates_FinalBillDatePaid IS NOT NULL AND AllianzBillDates_Inactive = 0',
  0, GETDATE(), 'SMJ'

  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-CHCycTmeFBPd', 
  'SELECT @OUT = DATEDIFF(d, AllianzBillDates_FinalBillDate, AllianzBillDates_FinalBillDatePaid)   FROM AllianzBillDates WHERE AllianzBillDates_CaseID = @CaseID AND AllianzBillDates_FinalBillDate IS NOT NULL AND AllianzBillDates_FinalBillDatePaid IS NOT NULL AND AllianzBillDates_Inactive = 0',
  0, GETDATE(), 'SMJ'
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-INCycTmeFBPd', 
  'SELECT @OUT = DATEDIFF(d, AllianzBillDates_FinalBillDate, AllianzBillDates_FinalBillDatePaid)   FROM AllianzBillDates WHERE AllianzBillDates_CaseID = @CaseID AND AllianzBillDates_FinalBillDate IS NOT NULL AND AllianzBillDates_FinalBillDatePaid IS NOT NULL AND AllianzBillDates_Inactive = 0',
  0, GETDATE(), 'SMJ'
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-MLCycTmeFBPd', 
  'SELECT @OUT = DATEDIFF(d, AllianzBillDates_FinalBillDate, AllianzBillDates_FinalBillDatePaid)   FROM AllianzBillDates WHERE AllianzBillDates_CaseID = @CaseID AND AllianzBillDates_FinalBillDate IS NOT NULL AND AllianzBillDates_FinalBillDatePaid IS NOT NULL AND AllianzBillDates_Inactive = 0',
  0, GETDATE(), 'SMJ' 


--TOTAL COSTS PAID
  --DELETE EXISTING CALCULATION
  DELETE FROM ClientMIFieldSetAdvCalc
  WHERE ClientMIFieldSetAdvCalc_ClientMIFieldSetField LIKE '%TotCstsPd'

  --NEW TOTAL COSTS PAID CALCULATION
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZTotCstsPd', 
  'SELECT @OUT = (SUM(ISNULL(MIClaimantDetails_TotalDamagesPaid, 0.00)) + SUM(ISNULL(MIClaimantDetails_TotalTPCostsPaid, 0.00)) - SUM(ISNULL(MIClaimantDetails_DamagesRecovered,0.00)) - SUM(ISNULL(MIClaimantDetails_CostsRecovered, 0.00))) -(ISNULL(AllianzBills_BLMCosts,0.00) / COUNT(MIClaimantDetails_ContactID)) FROM MIClaimantDetails  INNER JOIN AllianzBills ON MIClaimantDetails_CaseID = AllianzBills_CaseID WHERE MIClaimantDetails_CaseID = @CaseID AND Inactive = 0 AND AllianzBills_Inactive = 0 GROUP BY AllianzBills_BLMCosts',
  0, GETDATE(), 'SMJ'
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-CHTotCstsPd', 
  'SELECT @OUT = (SUM(ISNULL(MIClaimantDetails_TotalDamagesPaid, 0.00)) + SUM(ISNULL(MIClaimantDetails_TotalTPCostsPaid, 0.00)) - SUM(ISNULL(MIClaimantDetails_DamagesRecovered,0.00)) - SUM(ISNULL(MIClaimantDetails_CostsRecovered, 0.00))) -(ISNULL(AllianzBills_BLMCosts,0.00) / COUNT(MIClaimantDetails_ContactID)) FROM MIClaimantDetails  INNER JOIN AllianzBills ON MIClaimantDetails_CaseID = AllianzBills_CaseID WHERE MIClaimantDetails_CaseID = @CaseID AND Inactive = 0 AND AllianzBills_Inactive = 0 GROUP BY AllianzBills_BLMCosts',
  0, GETDATE(), 'SMJ'  
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-INTotCstsPd', 
  'SELECT @OUT = (SUM(ISNULL(MIClaimantDetails_TotalDamagesPaid, 0.00)) + SUM(ISNULL(MIClaimantDetails_TotalTPCostsPaid, 0.00)) - SUM(ISNULL(MIClaimantDetails_DamagesRecovered,0.00)) - SUM(ISNULL(MIClaimantDetails_CostsRecovered, 0.00))) -(ISNULL(AllianzBills_BLMCosts,0.00) / COUNT(MIClaimantDetails_ContactID)) FROM MIClaimantDetails  INNER JOIN AllianzBills ON MIClaimantDetails_CaseID = AllianzBills_CaseID WHERE MIClaimantDetails_CaseID = @CaseID AND Inactive = 0 AND AllianzBills_Inactive = 0 GROUP BY AllianzBills_BLMCosts',
  0, GETDATE(), 'SMJ'  
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-MLTotCstsPd', 
  'SELECT @OUT = (SUM(ISNULL(MIClaimantDetails_TotalDamagesPaid, 0.00)) + SUM(ISNULL(MIClaimantDetails_TotalTPCostsPaid, 0.00)) - SUM(ISNULL(MIClaimantDetails_DamagesRecovered,0.00)) - SUM(ISNULL(MIClaimantDetails_CostsRecovered, 0.00))) -(ISNULL(AllianzBills_BLMCosts,0.00) / COUNT(MIClaimantDetails_ContactID)) FROM MIClaimantDetails  INNER JOIN AllianzBills ON MIClaimantDetails_CaseID = AllianzBills_CaseID WHERE MIClaimantDetails_CaseID = @CaseID AND Inactive = 0 AND AllianzBills_Inactive = 0 GROUP BY AllianzBills_BLMCosts',
  0, GETDATE(), 'SMJ'  
----   

  --CLAIMANT SOLICITOR  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZCLAIMMIFLD00003', 
  'SELECT TOP 1 @OUT = ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''ClaimSol'' AND CaseContacts_CaseID = @CaseID',
  0, GETDATE(), 'SMJ'
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-CHCLAIMMIFLD00003', 
  'SELECT TOP 1 @OUT = ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''ClaimSol'' AND CaseContacts_CaseID = @CaseID',
  0, GETDATE(), 'SMJ'  
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-INCLAIMMIFLD00003', 
  'SELECT TOP 1 @OUT = ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''ClaimSol'' AND CaseContacts_CaseID = @CaseID',
  0, GETDATE(), 'SMJ'  
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-MLCLAIMMIFLD00003', 
  'SELECT TOP 1 @OUT = ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''ClaimSol'' AND CaseContacts_CaseID = @CaseID',
  0, GETDATE(), 'SMJ'  
  ----

  --CLAIMANT SOLICITOR OFFICE
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZCLAIMAZCLCSO', 
  'SELECT @OUT = ISNULL(ContactAddress_Address1, '''') + '', '' + ISNULL(ContactAddress_Town, '''') + '', '' + ISNULL(ContactAddress_Postcode , '''') FROM ContactAddress WHERE ContactAddress_ContactID = (SELECT TOP 1 CaseContacts_ContactID FROM CaseContacts WHERE CaseContacts_RoleCode = ''ClaimSol'' AND CaseContacts_CaseID = @CaseID AND CaseContacts_Inactive = 0) AND ContactAddress_Inactive = 0',
  0, GETDATE(), 'SMJ'
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-CHCLAIMAZCLCSO', 
  'SELECT @OUT = ISNULL(ContactAddress_Address1, '''') + '', '' + ISNULL(ContactAddress_Town, '''') + '', '' + ISNULL(ContactAddress_Postcode , '''') FROM ContactAddress WHERE ContactAddress_ContactID = (SELECT TOP 1 CaseContacts_ContactID FROM CaseContacts WHERE CaseContacts_RoleCode = ''ClaimSol'' AND CaseContacts_CaseID = @CaseID AND CaseContacts_Inactive = 0) AND ContactAddress_Inactive = 0',
  0, GETDATE(), 'SMJ'  

  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-INCLAIMAZCLCSO', 
  'SELECT @OUT = ISNULL(ContactAddress_Address1, '''') + '', '' + ISNULL(ContactAddress_Town, '''') + '', '' + ISNULL(ContactAddress_Postcode , '''') FROM ContactAddress WHERE ContactAddress_ContactID = (SELECT TOP 1 CaseContacts_ContactID FROM CaseContacts WHERE CaseContacts_RoleCode = ''ClaimSol'' AND CaseContacts_CaseID = @CaseID AND CaseContacts_Inactive = 0) AND ContactAddress_Inactive = 0',
  0, GETDATE(), 'SMJ'  
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-MLCLAIMAZCLCSO', 
  'SELECT @OUT = ISNULL(ContactAddress_Address1, '''') + '', '' + ISNULL(ContactAddress_Town, '''') + '', '' + ISNULL(ContactAddress_Postcode , '''') FROM ContactAddress WHERE ContactAddress_ContactID = (SELECT TOP 1 CaseContacts_ContactID FROM CaseContacts WHERE CaseContacts_RoleCode = ''ClaimSol'' AND CaseContacts_CaseID = @CaseID AND CaseContacts_Inactive = 0) AND ContactAddress_Inactive = 0',
  0, GETDATE(), 'SMJ'  
  ----