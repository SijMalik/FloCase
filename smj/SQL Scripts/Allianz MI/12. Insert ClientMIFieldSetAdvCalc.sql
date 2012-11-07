-- AZ 

 INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZTotSDR', 
  'SELECT @OUT = ISNULL(FinancialReserve_SpecialDamages, 0.00) + ISNULL(FinancialReserve_Ambulance, 0.00) + ISNULL(FinancialReserve_CredHire, 0.00) + ISNULL(FinancialReserve_CRU, 0.00) + ISNULL(FinancialReserve_NHS, 0.00) + ISNULL(FinancialReserve_SpecialDamagesProp, 0.00) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID',
  0, GETDATE(), 'SMJ'
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZTotCstsPd', 
  'SELECT @OUT = (ISNULL(MIClaimantDetails_TotalDamagesPaid, 0.00) + ISNULL(MIClaimantDetails_TotalTPCostsPaid, 0.00)) - (ISNULL(MIClaimantDetails_DamagesRecovered,0.00) - ISNULL(MIClaimantDetails_CostsRecovered, 0.00)) FROM MIClaimantDetails WHERE MIClaimantDetails_CaseID = @CaseID AND MIClaimantDetails_ContactID = $CONTACTID AND Inactive = 0',
  0, GETDATE(), 'SMJ'
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZCLAIMAZCLTSPD', 
  'SELECT @OUT = ISNULL(MIClaimantDetails_TotalTPCostsPaid, 0.00) + ISNULL(MIClaimantDetails_GeneralDamagesPaid, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidExcluding, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCRU, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidNHS, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidAmb, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidPropertyDamage, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCreditHire, 0.00) FROM MIClaimantDetails WHERE MIClaimantDetails_CaseID = @CaseID AND MIClaimantDetails_ContactID = $CONTACTID',
  0, GETDATE(), 'SMJ' 


-- CH

  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-CHTotSDR', 
  'SELECT @OUT = ISNULL(FinancialReserve_SpecialDamages, 0.00) + ISNULL(FinancialReserve_Ambulance, 0.00) + ISNULL(FinancialReserve_CredHire, 0.00) + ISNULL(FinancialReserve_CRU, 0.00) + ISNULL(FinancialReserve_NHS, 0.00) + ISNULL(FinancialReserve_SpecialDamagesProp, 0.00) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID',
  0, GETDATE(), 'SMJ'
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-CHTotCstsPd', 
  'SELECT @OUT = (ISNULL(MIClaimantDetails_TotalDamagesPaid, 0.00) + ISNULL(MIClaimantDetails_TotalTPCostsPaid, 0.00)) - (ISNULL(MIClaimantDetails_DamagesRecovered,0.00) - ISNULL(MIClaimantDetails_CostsRecovered, 0.00)) FROM MIClaimantDetails WHERE MIClaimantDetails_CaseID = @CaseID AND MIClaimantDetails_ContactID = $CONTACTID AND Inactive = 0',
  0, GETDATE(), 'SMJ'
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-CHCLAIMAZCLTSPD', 
  'SELECT @OUT = ISNULL(MIClaimantDetails_TotalTPCostsPaid, 0.00) + ISNULL(MIClaimantDetails_GeneralDamagesPaid, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidExcluding, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCRU, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidNHS, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidAmb, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidPropertyDamage, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCreditHire, 0.00) FROM MIClaimantDetails WHERE MIClaimantDetails_CaseID = @CaseID AND MIClaimantDetails_ContactID = $CONTACTID',
  0, GETDATE(), 'SMJ' 


-- IN

  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-INTotSDR', 
  'SELECT @OUT = ISNULL(FinancialReserve_SpecialDamages, 0.00) + ISNULL(FinancialReserve_Ambulance, 0.00) + ISNULL(FinancialReserve_CredHire, 0.00) + ISNULL(FinancialReserve_CRU, 0.00) + ISNULL(FinancialReserve_NHS, 0.00) + ISNULL(FinancialReserve_SpecialDamagesProp, 0.00) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID',
  0, GETDATE(), 'SMJ'
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-INTotCstsPd', 
  'SELECT @OUT = (ISNULL(MIClaimantDetails_TotalDamagesPaid, 0.00) + ISNULL(MIClaimantDetails_TotalTPCostsPaid, 0.00)) - (ISNULL(MIClaimantDetails_DamagesRecovered,0.00) - ISNULL(MIClaimantDetails_CostsRecovered, 0.00)) FROM MIClaimantDetails WHERE MIClaimantDetails_CaseID = @CaseID AND MIClaimantDetails_ContactID = $CONTACTID AND Inactive = 0',
  0, GETDATE(), 'SMJ'
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-INCLAIMAZCLTSPD', 
  'SELECT @OUT = ISNULL(MIClaimantDetails_TotalTPCostsPaid, 0.00) + ISNULL(MIClaimantDetails_GeneralDamagesPaid, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidExcluding, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCRU, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidNHS, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidAmb, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidPropertyDamage, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCreditHire, 0.00) FROM MIClaimantDetails WHERE MIClaimantDetails_CaseID = @CaseID AND MIClaimantDetails_ContactID = $CONTACTID',
  0, GETDATE(), 'SMJ' 


-- ML

  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-MLTotSDR', 
  'SELECT @OUT = ISNULL(FinancialReserve_SpecialDamages, 0.00) + ISNULL(FinancialReserve_Ambulance, 0.00) + ISNULL(FinancialReserve_CredHire, 0.00) + ISNULL(FinancialReserve_CRU, 0.00) + ISNULL(FinancialReserve_NHS, 0.00) + ISNULL(FinancialReserve_SpecialDamagesProp, 0.00) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID',
  0, GETDATE(), 'SMJ'
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-MLTotCstsPd', 
  'SELECT @OUT = (ISNULL(MIClaimantDetails_TotalDamagesPaid, 0.00) + ISNULL(MIClaimantDetails_TotalTPCostsPaid, 0.00)) - (ISNULL(MIClaimantDetails_DamagesRecovered,0.00) - ISNULL(MIClaimantDetails_CostsRecovered, 0.00)) FROM MIClaimantDetails WHERE MIClaimantDetails_CaseID = @CaseID AND MIClaimantDetails_ContactID = $CONTACTID AND Inactive = 0',
  0, GETDATE(), 'SMJ'
  
  INSERT INTO [ClientMIFieldSetAdvCalc]
  SELECT 'AZ-MLCLAIMAZCLTSPD', 
  'SELECT @OUT = ISNULL(MIClaimantDetails_TotalTPCostsPaid, 0.00) + ISNULL(MIClaimantDetails_GeneralDamagesPaid, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidExcluding, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCRU, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidNHS, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidAmb, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidPropertyDamage, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCreditHire, 0.00) FROM MIClaimantDetails WHERE MIClaimantDetails_CaseID = @CaseID AND MIClaimantDetails_ContactID = $CONTACTID',
  0, GETDATE(), 'SMJ' 