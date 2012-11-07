  
  --FINANCIAL
  ALTER TABLE Financial ADD Financial_CareVal MONEY NULL
  ALTER TABLE Financial ADD Financial_LOEVal MONEY NULL
  ALTER TABLE Financial ADD Financial_OthVal MONEY NULL
  ALTER TABLE Financial ADD Financial_StoRecVal MONEY NULL
  ALTER TABLE Financial ADD Financial_GeneralDamagesClmd MONEY NULL
  ALTER TABLE Financial ADD Financial_SDAmbulanceClmd MONEY NULL
  ALTER TABLE Financial ADD Financial_SDCareClmd MONEY NULL
  ALTER TABLE Financial ADD Financial_SDCRUClmd MONEY NULL
  ALTER TABLE Financial ADD Financial_SDLOEClmd MONEY NULL
  ALTER TABLE Financial ADD Financial_SDNHSClmd MONEY NULL
  ALTER TABLE Financial ADD Financial_SDOthClmd MONEY NULL
  ALTER TABLE Financial ADD Financial_SDPropDamClmd MONEY NULL
  ALTER TABLE Financial ADD Financial_SDStoRecClmd MONEY NULL
  ALTER TABLE Financial ADD Financial_SDTotDamClmd MONEY NULL


  --Financial Reserve
  ALTER TABLE FinancialReserve ADD FinancialReserve_StoRec MONEY NULL
  ALTER TABLE FinancialReserve ADD FinancialReserve_Care MONEY NULL
  ALTER TABLE FinancialReserve ADD FinancialReserve_LossEarnings MONEY NULL
  ALTER TABLE FinancialReserve ADD FinancialReserve_Other MONEY NULL  
  ALTER TABLE FinancialReserve ADD FinancialReserve_ATEClaimCost MONEY NULL
  ALTER TABLE FinancialReserve ADD FinancialReserve_DisbClaimCost MONEY NULL
  ALTER TABLE FinancialReserve ADD FinancialReserve_ProfClaimCost MONEY NULL
  ALTER TABLE FinancialReserve ADD FinancialReserve_SFClaimCost MONEY NULL
  ALTER TABLE FinancialReserve ADD FinancialReserve_VATClaimCost MONEY NULL  
  ALTER TABLE FinancialReserve ADD FinancialReserve_OwnDisbCounsExp MONEY NULL
  ALTER TABLE FinancialReserve ADD FinancialReserve_OwnDisbOth MONEY NULL
  
  --Financial Reserve History
  ALTER TABLE FinancialReserveHistory ADD FinancialReserveHistory_StoRec MONEY NULL
  ALTER TABLE FinancialReserveHistory ADD FinancialReserveHistory_Care MONEY NULL
  ALTER TABLE FinancialReserveHistory ADD FinancialReserveHistory_LossEarnings MONEY NULL
  ALTER TABLE FinancialReserveHistory ADD FinancialReserveHistory_Other MONEY NULL
  ALTER TABLE FinancialReserveHistory ADD FinancialReserveHistory_ATEClaimCost MONEY NULL
  ALTER TABLE FinancialReserveHistory ADD FinancialReserveHistory_DisbClaimCost MONEY NULL
  ALTER TABLE FinancialReserveHistory ADD FinancialReserveHistory_ProfClaimCost MONEY NULL
  ALTER TABLE FinancialReserveHistory ADD FinancialReserveHistory_SFClaimCost MONEY NULL
  ALTER TABLE FinancialReserveHistory ADD FinancialReserveHistory_VATClaimCost MONEY NULL  
  ALTER TABLE FinancialReserveHistory ADD FinancialReserveHistory_OwnDisbCounsExp MONEY NULL
  ALTER TABLE FinancialReserveHistory ADD FinancialReserveHistory_OwnDisbOth MONEY NULL  
    
  --Costs
  ALTER TABLE Costs ADD Costs_ProfClaimCost MONEY NULL 
  ALTER TABLE Costs ADD Costs_VATClaimCost MONEY NULL 
  ALTER TABLE Costs ADD Costs_VATSett MONEY NULL      
  
