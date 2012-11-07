--SMJ: Was incorrect before - adding Financial_DamagesPaid + Financial_SpecialDamagesPaid 

UPDATE ClientMIFieldSetAdvCalc
  SET ClientMIFieldSetAdvCalc_CalculationDetails = 'SELECT @OUT =  ISNULL(Financial_GeneralDamagesPaid,0) + ISNULL(Financial_SpecialDamagesPaid, 0) FROM Financial WHERE Financial_CaseID = @CaseID AND Financial_InActive = 0'
  WHERE ClientMIFieldSetAdvCalc_ClientMIFieldSetField = 'CostsMICFIELD65'