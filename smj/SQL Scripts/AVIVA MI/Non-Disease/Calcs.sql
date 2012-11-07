-----------MATTER--------------

--Name of Insured
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'AVIVAAAAAAAAAAA', 
	'SELECT TOP 1 @OUT = ISNULL(CaseContacts_SearchName, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_RoleCode, '''') = ''Defendant'' AND CaseContacts_CaseID = @CaseID AND CaseContacts_Inactive = 0',
	0, GETDATE(), 'SMJ'


--Claim Number
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'AVIVAMIFLD00002', 
	'SELECT @OUT = ISNULL(CaseContacts_Reference, '''') FROM CaseContacts WHERE ISNULL(CaseContacts_Inactive, 0) = 0 AND ISNULL(CaseContacts_ClientID, 0) > 0 AND CaseContacts_CaseID = @CaseID',
	0, GETDATE(), 'SMJ'


-----------CLAIMANT--------------
--Claimant DOB
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'AVIVACLAIMClmDOB', 
	'SELECT @OUT = ISNULL(CAST(MatterContact_DOB as varchar(20)), '''') FROM MatterContact mc INNER JOIN CaseContacts cc ON mc.MatterContact_MatterContactID = cc.CaseContacts_MatterContactID WHERE cc.CaseContacts_RoleCode = ''Defendant'' AND cc.CaseContacts_CaseID = @CaseID AND cc.CaseContacts_Inactive = 0 AND mc.MatterContact_Inactive = 0',
	0, GETDATE(), 'SMJ'

--CurrResDam
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'AVIVACLAIMCurrResDam', 
	'SELECT @OUT = ISNULL(FinancialReserve_GeneralDamages, 0.00) + ISNULL(FinancialReserve_SpecialDamages, 0.00) + ISNULL(FinancialReserve_Ambulance, 0.00) + ISNULL(FinancialReserve_CredHire, 0.00) + ISNULL(FinancialReserve_CRU, 0.00) + ISNULL(FinancialReserve_NHS, 0.00) + ISNULL(FinancialReserve_SpecialDamagesProp, 0.00) FROM FinancialReserve WHERE FinancialReserve_CaseID = @CaseID AND FinancialReserve_Inactive = 0',
	0, GETDATE(), 'SMJ'

--Cost Drafts Person
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'AVIVACLAIMMICFIELD05', 
	'SELECT @OUT =  MAX(AU.UserName) FROM AppUser AU INNER JOIN ApplicationInstance AI ON AU.AppInstanceValue = AI.IdentifierValue WHERE AU.AppUserRoleCode = ''CFE'' AND AU.InActive = 0 AND AI.CaseID = @CaseID',
	0, GETDATE(), 'SMJ'

--Agreed Total Special Damages
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'AVIVACLAIMAZCLTSPD', 
	'SELECT @OUT = ISNULL(MIClaimantDetails_SpecialDamagesPaidExcluding, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCRU, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidNHS, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidAmb, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidPropertyDamage, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCreditHire, 0.00) FROM MIClaimantDetails WHERE MIClaimantDetails_CaseID = @CaseID AND MIClaimantDetails_ContactID = $CONTACTID AND INACTIVE = 0',
	0, GETDATE(), 'SMJ'

--Agreed Total Damages
	INSERT INTO [ClientMIFieldSetAdvCalc]
	SELECT 'AVIVACLAIMAZCLTPD', 
	'SELECT @OUT = ISNULL(MIClaimantDetails_SpecialDamagesPaidExcluding, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCRU, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidNHS, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidAmb, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidPropertyDamage, 0.00) + ISNULL(MIClaimantDetails_SpecialDamagesPaidCreditHire, 0.00) + ISNULL(MIClaimantDetails_GeneralDamagesPaid, 0.00) FROM MIClaimantDetails WHERE MIClaimantDetails_CaseID = @CaseID AND MIClaimantDetails_ContactID = $CONTACTID AND Inactive = 0',
	0, GETDATE(), 'SMJ'

