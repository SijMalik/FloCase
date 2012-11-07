	ALTER TABLE LitigationLiability ADD LitigationLiability_LitigatedAtAV NVARCHAR(10) NULL

	ALTER TABLE ManagementInformation ADD ManagementInformation_TCS NVARCHAR(10) NULL
	ALTER TABLE ManagementInformation ADD ManagementInformation_ReasonOverturnAV NVARCHAR(10) NULL

	ALTER TABLE MIClaimantDetails ADD MIClaimantDetails_IsInfant VARCHAR(10) NULL	
	ALTER TABLE MIClaimantDetails ADD MIClaimantDetails_PerPayOrd VARCHAR(10) NULL
	ALTER TABLE MIClaimantDetails ADD MIClaimantDetails_ReasStatOth VARCHAR(255) NULL
	ALTER TABLE MIClaimantDetails ADD MIClaimantDetails_CRUApp VARCHAR(255) NULL
	ALTER TABLE MIClaimantDetails ADD MIClaimantDetails_IntCstPdBLM MONEY NULL


	ALTER TABLE Financial ADD Financial_AgrdCare  MONEY NULL
	ALTER TABLE Financial ADD Financial_AgrdOthNonInj  MONEY NULL

	ALTER TABLE FinancialReserve ADD FinancialReserve_BLMCostResGross MONEY NULL
	ALTER TABLE FinancialReserve ADD FinancialReserve_TPSCostGross MONEY NULL	
	ALTER TABLE FinancialReserve ADD FinancialReserve_GeneralDamagesGross MONEY NULL	
	ALTER TABLE FinancialReserve ADD FinancialReserve_SpecialDamagesGross  MONEY NULL	
		
	ALTER TABLE FinancialReserveHistory ADD FinancialReserveHistory_BLMCostResGross MONEY NULL
	ALTER TABLE FinancialReserveHistory ADD FinancialReserveHistory_TPSCostGross MONEY NULL	
	ALTER TABLE FinancialReserveHistory ADD FinancialReserveHistory_GeneralDamagesGross MONEY NULL	
	ALTER TABLE FinancialReserveHistory ADD FinancialReserveHistory_SpecialDamagesGross  MONEY NULL	
		
	ALTER TABLE Costs ADD Costs_PInterestClmd MONEY NULL
	ALTER TABLE Costs ADD Costs_PPt47AssClmd MONEY NULL
	ALTER TABLE Costs ADD Costs_TPCstAgrdPt47 MONEY NULL
	ALTER TABLE Costs ADD Costs_TPCstAgrdInt MONEY NULL