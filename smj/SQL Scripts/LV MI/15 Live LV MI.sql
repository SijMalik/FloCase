   select * from ClientMIFieldSet cmf
   inner join MIFieldDefinition mi
   on cmf.ClientMIFieldSet_MIFieldDefCode = mi.MIFieldDefinition_MIFieldCode
   where cmf.ClientMIFieldSet_ClientMIDEFCODE like 'LV%'
   order by cmf.ClientMIFieldSet_MIFieldPosition
   
   select f.Financial_CaseID, f.Financial_DamagesPaid, f.Financial_DamagesClmd from Financial f
   where f.Financial_CaseID in
   ( select c.Case_CaseID from [Case] c
	where c.Case_GroupCode like 'LV%'
	)
	and f.Financial_InActive = 0
	and f.Financial_DamagesClmd > 0
	
	select * from ClientMIFieldSetAdvCalc c
	where c.ClientMIFieldSetAdvCalc_ClientMIFieldSetField like '%LVDAMCLMD%'
	
	SELECT ISNULL(Financial_SDCRUClmd, 0.00) + ISNULL(Financial_SDNHSClmd, 0.00) + ISNULL(Financial_SDAmbulanceClmd, 0.00) + ISNULL(Financial_SDPropDamClmd, 0.00) + ISNULL(CreditHire_AmountClaimed, 0.00) + ISNULL(Financial_SDStoRecClmd, 0.00) + ISNULL(Financial_SDCareClmd, 0.00) + ISNULL(Financial_SDLOEClmd, 0.00) + ISNULL(Financial_SDOthClmd, 0.00) + ISNULL(Financial_GeneralDamagesClmd, 0.00) FROM Financial f INNER JOIN CreditHire c ON f.Financial_CaseID = c.CreditHire_CaseID WHERE f.Financial_CaseID = 7641 AND f.Financial_InActive = 0 AND c.CreditHire_Inactive = 0
	
	
	SELECT ISNULL(Financial_CRUValue, 0.00) + ISNULL(Financial_NHSVal, 0.00) + ISNULL(Financial_AmbulanceVal, 0.00) + ISNULL(Financial_PropertyDamagesPaid, 0.00) + ISNULL(CreditHire_AmountPaid, 0.00) + ISNULL(Financial_StoRecVal, 0.00) + ISNULL(Financial_CareVal, 0.00) + ISNULL(Financial_LOEVal, 0.00) + ISNULL(Financial_OthVal, 0.00) + ISNULL(Financial_GeneralDamagesPaid, 0.00) FROM Financial f INNER JOIN CreditHire c ON f.Financial_CaseID = c.CreditHire_CaseID WHERE f.Financial_CaseID = 7641 AND f.Financial_InActive = 0 AND c.CreditHire_Inactive = 0
	
	
	select * from [Case] c
	where c.Case_CaseID = 11905