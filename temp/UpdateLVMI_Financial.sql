	DECLARE @CaseID INT
	DECLARE @MaxID INT
	DECLARE @Counter INT
	DECLARE @FROwnCost MONEY
	DECLARE @FRTotDam MONEY
	DECLARE @FRClCosts MONEY
	DECLARE @FinRes TABLE (ID INT IDENTITY(1,1), CaseID INT, FROwnCost MONEY, FRTotDam MONEY, FRClCosts MONEY)
	DECLARE @FinResFin TABLE (CaseID INT, FROwnCost MONEY, FRTotDam MONEY, FRClCosts MONEY)


	BEGIN TRY
			BEGIN TRANSACTION UPDATEFINRES

			INSERT INTO @FinRes
			SELECT 
			FinancialReserve_CaseID,
			FinancialReserve_Cost,
			FinancialReserve_DamagesNET,
			FinancialReserve_ClaimantCosts
			FROM FinancialReserve 
			WHERE FinancialReserve_CaseID IN
			(
			select c.Case_CaseID from [Case] c 
			inner join FinancialReserve fr
			on c.Case_CaseID = fr.FinancialReserve_CaseID
			where c.Case_GroupCode like 'LV%'
			and fr.FinancialReserve_Inactive = 0
			)
			AND FinancialReserve_Inactive = 0

			SET @Counter = 1
			SELECT @MaxID = MAX(ID) FROM @FinRes 
			
			WHILE @Counter <= @MaxID
			BEGIN
				SET @FROwnCost = 0
				SET @FRTotDam = 0
				SET @FRClCosts = 0
				
				SELECT @CaseID = CaseID FROM @FinRes WHERE ID = @Counter 
				
				SELECT @FRClCosts= ISNULL(FinancialReserve_ProfClaimCost, 0.00) 
				+ ISNULL(FinancialReserve_DisbClaimCost, 0.00) 
				+ ISNULL(FinancialReserve_ATEClaimCost, 0.00) 
				+ ISNULL(FinancialReserve_SFClaimCost, 0.00) 
				+ ISNULL(FinancialReserve_VATClaimCost, 0.00) 
				FROM FinancialReserve 
				WHERE FinancialReserve_CaseID = @CaseID AND FinancialReserve_Inactive = 0
				
				SELECT @FROwnCost =  ISNULL(FinancialReserve_BLMProfCosts, 0.00) 
				+ ISNULL(FinancialReserve_OwnDisbCounsExp, 0.00) 
				+ ISNULL(FinancialReserve_OwnDisbOth, 0.00)
				FROM FinancialReserve 
				WHERE FinancialReserve_CaseID = @CaseID AND FinancialReserve_Inactive = 0
				
				SELECT @FRTotDam =   ISNULL(FinancialReserve_CRU, 0.00) 
				+ ISNULL(FinancialReserve_NHS, 0.00) 
				+ ISNULL(FinancialReserve_Ambulance, 0.00) 
				+ ISNULL(FinancialReserve_SpecialDamagesProp, 0.00) 
				+ ISNULL(FinancialReserve_CredHire, 0.00) 
				+ ISNULL(FinancialReserve_StoRec, 0.00) 
				+ ISNULL(FinancialReserve_Care, 0.00) 
				+ ISNULL(FinancialReserve_LossEarnings, 0.00) 
				+ ISNULL(FinancialReserve_Other, 0.00) 
				+ ISNULL(FinancialReserve_GeneralDamages, 0.00) 
				FROM FinancialReserve 
				WHERE FinancialReserve_CaseID = @CaseID AND FinancialReserve_Inactive = 0
				
				INSERT INTO @FinResFin
				SELECT @CaseID, @FROwnCost, @FRTotDam, @FRClCosts			
				
				SET @Counter = @Counter + 1
			END		

				UPDATE	FinancialReserve
				SET		FinancialReserve_Cost = FROwnCost,
						FinancialReserve_DamagesNET = FRTotDam,
						FinancialReserve_ClaimantCosts = FRClCosts
				FROM	[Case] c INNER JOIN
				FinancialReserve a WITH (NOLOCK) ON c.Case_CaseID = a.FinancialReserve_CaseID 
				INNER JOIN @FinResFin b 
				ON a.FinancialReserve_CaseID = b.CaseID
				AND a.FinancialReserve_Inactive = 0
				WHERE c.Case_GroupCode like 'LV%'
				
				UPDATE	FinancialReserveHistory
				SET		FinancialReserveHistory_Cost = FROwnCost,
						FinancialReserveHistory_DamagesNET = FRTotDam,
						FinancialReserveHistory_ClaimantCosts = FRClCosts
				FROM	[Case] c INNER JOIN
				FinancialReserveHistory a WITH (NOLOCK)  ON c.Case_CaseID = a.FinancialReserveHistory_CaseID  
				INNER JOIN @FinResFin b
				ON a.FinancialReserveHistory_CaseID = b.CaseID
				AND a.FinancialReserveHistory_Inactive = 0	
				WHERE c.Case_GroupCode like 'LV%'

				COMMIT TRANSACTION UPDATEFINRES

	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION UPDATEFINRES
		SELECT ERROR_MESSAGE() 
	END CATCH