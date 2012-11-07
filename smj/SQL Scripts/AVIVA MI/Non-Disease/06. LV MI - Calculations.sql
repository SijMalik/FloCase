	--Claim Ref
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'LVCLIREF', 
	'SELECT @OUT = ISNULL(CaseContacts_Reference, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_ClientID, 0) > 0 AND CaseContacts_CaseID = @CaseID',
	0, GETDATE(), 'SMJ'

	--Claim Handler
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'LVCLMHNDLR', 
	'SELECT TOP 1 @OUT = ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''CLTCNTCT'' AND CaseContacts_CaseID = @CaseID',
	0, GETDATE(), 'SMJ'

	--Name of Insured
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'LVAAAAAAAAAA', 
	'SELECT TOP 1 @OUT = ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''Defendant'' AND CaseContacts_CaseID = @CaseID',
	0, GETDATE(), 'SMJ'

	--Claim Sol
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'LVLVCLSO', 
	'SELECT TOP 1 @OUT = ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''ClaimSol'' AND CaseContacts_CaseID = @CaseID',
	0, GETDATE(), 'SMJ'


	--Own Costs Reserve
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'LVBLMCstRes', 
	'SELECT @OUT = ISNULL(FinancialReserve_BLMProfCosts, 0.00) + ISNULL(FinancialReserve_OwnDisbCounsExp, 0.00) + ISNULL(FinancialReserve_OwnDisbOth, 0.00)FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND FinancialReserve_Inactive = 0',
	0, GETDATE(), 'SMJ'

	--Total Claimant Costs Reserve
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'LVFICURRESCO', 
	'SELECT @OUT = ISNULL(FinancialReserve_ProfClaimCost, 0.00) + ISNULL(FinancialReserve_DisbClaimCost, 0.00) + ISNULL(FinancialReserve_ATEClaimCost, 0.00) + ISNULL(FinancialReserve_SFClaimCost, 0.00) + ISNULL(FinancialReserve_VATClaimCost, 0.00) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND FinancialReserve_Inactive = 0',
	0, GETDATE(), 'SMJ'


	--Total Claimant Costs Claimed
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'LVMICFIELD13', 
	'SELECT @OUT = ISNULL(Costs_PCSCostsClaimed, 0.00) + ISNULL(Costs_PCSDisbClaimed, 0.00) + ISNULL(Costs_PTPATEClmd, 0.00) + ISNULL(Costs_PSuccessFeeClmd, 0.00) + ISNULL(Costs_VATClaimCost, 0.00) FROM Costs WHERE Costs_CaseID = @CaseID AND Costs_Inactive = 0',
	0, GETDATE(), 'SMJ'


	--Total Special Damages Reserve
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'LVIALDAMAGES', 
	'SELECT @OUT = ISNULL(FinancialReserve_CRU, 0.00) + ISNULL(FinancialReserve_NHS, 0.00) + ISNULL(FinancialReserve_Ambulance, 0.00) + ISNULL(FinancialReserve_SpecialDamagesProp, 0.00) + ISNULL(FinancialReserve_CredHire, 0.00) + ISNULL(FinancialReserve_StoRec, 0.00) + ISNULL(FinancialReserve_Care, 0.00) + ISNULL(FinancialReserve_LossEarnings, 0.00) + ISNULL(FinancialReserve_Other, 0.00) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND FinancialReserve_Inactive = 0',
	0, GETDATE(), 'SMJ'

	--Total Damages Reserve
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'LVMICFIELD77', 
	'SELECT @OUT = ISNULL(FinancialReserve_CRU, 0.00) + ISNULL(FinancialReserve_NHS, 0.00) + ISNULL(FinancialReserve_Ambulance, 0.00) + ISNULL(FinancialReserve_SpecialDamagesProp, 0.00) + ISNULL(FinancialReserve_CredHire, 0.00) + ISNULL(FinancialReserve_StoRec, 0.00) + ISNULL(FinancialReserve_Care, 0.00) + ISNULL(FinancialReserve_LossEarnings, 0.00) + ISNULL(FinancialReserve_Other, 0.00) + ISNULL(FinancialReserve_GeneralDamages, 0.00) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND FinancialReserve_Inactive = 0',
	0, GETDATE(), 'SMJ'

	--Total Claimant Costs Settlement
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'LVMICFIELD30', 
	'SELECT @OUT = ISNULL(Financial_TPProfCostsSett, 0.00) + ISNULL(Costs_PCSDisbPaid, 0.00) + ISNULL(Costs_PATEPremiumPaid, 0.00) + ISNULL(Costs_PSuccessFeePaid, 0.00) + ISNULL(Costs_VATSett, 0.00) FROM Financial f INNER JOIN Costs c ON f.Financial_CaseID = c.Costs_CaseID WHERE f.Financial_CaseID = @CaseID AND f.Financial_InActive = 0 AND c.Costs_Inactive = 0',
	0, GETDATE(), 'SMJ'


	--Total Special Damages Claimed
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'LVLVTOTSDCLM', 
	'SELECT @OUT = ISNULL(Financial_SDCRUClmd, 0.00) + ISNULL(Financial_SDNHSClmd, 0.00) + ISNULL(Financial_SDAmbulanceClmd, 0.00) + ISNULL(Financial_SDPropDamClmd, 0.00) + ISNULL(CreditHire_AmountClaimed, 0.00) + ISNULL(Financial_SDStoRecClmd, 0.00) + ISNULL(Financial_SDCareClmd, 0.00) + ISNULL(Financial_SDLOEClmd, 0.00) + ISNULL(Financial_SDOthClmd, 0.00)FROM Financial f INNER JOIN CreditHire c ON f.Financial_CaseID = c.CreditHire_CaseID WHERE f.Financial_CaseID = @CaseID AND f.Financial_InActive = 0 AND c.CreditHire_Inactive = 0',
	0, GETDATE(), 'SMJ'


	--Total Damages Claimed
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'LVLVDAMCLMD', 
	'SELECT @OUT = ISNULL(Financial_SDCRUClmd, 0.00) + ISNULL(Financial_SDNHSClmd, 0.00) + ISNULL(Financial_SDAmbulanceClmd, 0.00) + ISNULL(Financial_SDPropDamClmd, 0.00) + ISNULL(CreditHire_AmountClaimed, 0.00) + ISNULL(Financial_SDStoRecClmd, 0.00) + ISNULL(Financial_SDCareClmd, 0.00) + ISNULL(Financial_SDLOEClmd, 0.00) + ISNULL(Financial_SDOthClmd, 0.00) + ISNULL(Financial_GeneralDamagesClmd, 0.00) FROM Financial f INNER JOIN CreditHire c ON f.Financial_CaseID = c.CreditHire_CaseID WHERE f.Financial_CaseID = @CaseID AND f.Financial_InActive = 0 AND c.CreditHire_Inactive = 0',
	0, GETDATE(), 'SMJ'

	--Total Special Damages Paid
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'LVSpDmStVl', 
	'SELECT @OUT = ISNULL(Financial_CRUValue, 0.00) + ISNULL(Financial_NHSVal, 0.00) + ISNULL(Financial_AmbulanceVal, 0.00) + ISNULL(Financial_PropertyDamagesPaid, 0.00) + ISNULL(CreditHire_AmountPaid, 0.00) + ISNULL(Financial_StoRecVal, 0.00) + ISNULL(Financial_CareVal, 0.00) + ISNULL(Financial_LOEVal, 0.00) + ISNULL(Financial_OthVal, 0.00) + ISNULL(Financial_GeneralDamagesPaid, 0.00) FROM Financial f INNER JOIN CreditHire c ON f.Financial_CaseID = c.CreditHire_CaseID WHERE f.Financial_CaseID = @CaseID AND f.Financial_InActive = 0 AND c.CreditHire_Inactive = 0',
	0, GETDATE(), 'SMJ'


	--Total Damages Paid
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'LVMICFIELD65', 
	'SELECT @OUT = ISNULL(Financial_CRUValue, 0.00) + ISNULL(Financial_NHSVal, 0.00) + ISNULL(Financial_AmbulanceVal, 0.00) + ISNULL(Financial_PropertyDamagesPaid, 0.00) + ISNULL(CreditHire_AmountPaid, 0.00) + ISNULL(Financial_StoRecVal, 0.00) + ISNULL(Financial_CareVal, 0.00) + ISNULL(Financial_LOEVal, 0.00) + ISNULL(Financial_OthVal, 0.00) FROM Financial f INNER JOIN CreditHire c ON f.Financial_CaseID = c.CreditHire_CaseID WHERE f.Financial_CaseID = @CaseID AND f.Financial_InActive = 0 AND c.CreditHire_Inactive = 0',
	0, GETDATE(), 'SMJ'

	--Claimant Name
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'LVCLAIMNAME', 
	'SELECT TOP 1 @OUT = ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '') = ''Claimant'' AND CaseContacts_CaseID = @CaseID',
	0, GETDATE(), 'SMJ'

	--Defendant Postcode
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'LVCLCTPCODE', 
	'SELECT @OUT = ISNULL(MatterContactAddress_Postcode, '''') FROM MatterContactAddress ma INNER JOIN CaseContacts cc ON ma.MatterContactAddress_MatterContactID = cc.CaseContacts_MatterContactID WHERE cc.CaseContacts_RoleCode = ''Defendant'' AND cc.CaseContacts_CaseID = @CaseID AND cc.CaseContacts_Inactive = 0 AND ma.MatterContactAddress_Inactive = 0 AND ma.MatterContactAddress_IsPrimary = 1',
	0, GETDATE(), 'SMJ'

	--Claim Status
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'LVClmStsTxt', 
	'SELECT @OUT = IF (SELECT ISNULL(LVFinalBillDP_FinalBillDatePaid,CAST(''1900-01-01'' AS SMALLDATETIME)) FROM LVFinalBillDP WHERE LVFinalBillDP_CaseID = @CaseID AND LVFinalBillDP_Inactive =0) IS NULL BEGIN	SELECT ''Open'' END ELSE BEGIN SELECT ''Closed'' END',
	0, GETDATE(), 'SMJ'

	--Days to Settle
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'LVDAYSTOSETT', 
	'SELECT ISNULL(DATEDIFF(D, DATE_INSTRUCTED, DATE_OF_SETTLEMENT),0) FROM _HBM_MATTER_USR_DATA hbm INNER JOIN ApplicationInstance ai ON hbm.MATTER_UNO = ai.AExpert_MatterUno WHERE hbm.DATE_INSTRUCTED IS NOT NULL AND hbm.DATE_OF_SETTLEMENT IS NOT NULL AND ai.CaseID = @CaseID',
	0, GETDATE(), 'SMJ'





