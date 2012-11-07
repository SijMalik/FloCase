/****** Object:  StoredProcedure [dbo].[LTMM_CostsDirections_Fetch]    Script Date: 11/04/2011 15:51:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[LTMM_CostsDirections_Fetch] 
(
	@pCaseId				INT = 0, 
	@pUserName				VARCHAR (255) = ''
)
	--==============================================================--
	-- Created By:	SMJ
	-- Create Date:	04-11-2011
	-- Description:	This SP is used to fetch Costs Case Key Dates
	--==============================================================--
	
AS

	SET NOCOUNT ON
	
	DECLARE @errNoCase VARCHAR (50) 
		
	SET @errNoCase = 'No Case ID passed in.'


	BEGIN TRY 
		--DO SOME ERROR-CHECKING
		IF @pCaseId <= 0 
			RAISERROR (@errNoCase, 16, 1)						
	
		--Declare Costs Dates
		DECLARE		@CostsDir_CostAssDte		DATETIME 
		DECLARE		@CostsDir_CostAutAss		DATETIME 
		DECLARE		@CostsDir_CostN252By		DATETIME 
		DECLARE		@CostsDir_CostN258By		DATETIME 
		DECLARE		@CostsDir_Prt8OrdDate		DATETIME 
		DECLARE		@CostsDir_N252DteSvd		DATETIME 
		DECLARE		@CostsDir_N258DteSvd		DATETIME 
		DECLARE		@CostsDir_SummAssDate		DATETIME 
		DECLARE		@CostsDir_PoDDueDate		DATETIME 
		DECLARE		@CostsDir_4719Offer			DATETIME 
		DECLARE		@CostsDir_RepsDueBy			DATETIME 
		DECLARE		@CostsDir_PoDCompDte		DATETIME 
		DECLARE		@CostsDir_JSMtgBy			DATETIME 
		DECLARE		@CostsDir_JSFileBy			DATETIME 
		DECLARE		@CostsDir_IntPytBy			DATETIME 
		DECLARE		@CostsDir_DAHDate			DATETIME 
		DECLARE		@CostsDir_DAHApplDte		DATETIME 
		DECLARE		@CostsDir_CstSttlDte		DATETIME 
		

		--Get Costs KeyDates
		-------------------------------------------------------
		SELECT @CostsDir_CostAssDte = [CaseKeyDates_Date]
		FROM [CaseKeyDates]
		WHERE [CaseKeyDates_CaseID] = @pCaseId
		AND CaseKeyDates_KeyDatesCode = 'CostAssDte' 
		AND CaseKeyDates_Inactive = 0	
		--AND CaseKeyDates_CaseContactsID = @pCourtCase_ContactID	
		--AND CaseKeyDates_CreateUser = CASE WHEN @pUserName = '' THEN CaseKeyDates_CreateUser ELSE @pUserName END
		-------------------------------------------------------
		SELECT @CostsDir_CostAutAss = [CaseKeyDates_Date]
		FROM [CaseKeyDates]
		WHERE [CaseKeyDates_CaseID] = @pCaseId
		AND CaseKeyDates_KeyDatesCode = 'CostAutAss' 
		AND CaseKeyDates_Inactive = 0
		-------------------------------------------------------
		SELECT @CostsDir_CostN252By = [CaseKeyDates_Date]
		FROM [CaseKeyDates]
		WHERE [CaseKeyDates_CaseID] = @pCaseId
		AND CaseKeyDates_KeyDatesCode = 'CostN252By' 
		AND CaseKeyDates_Inactive= 0
		-------------------------------------------------------	
		SELECT @CostsDir_CostN258By = [CaseKeyDates_Date]
		FROM [CaseKeyDates]
		WHERE [CaseKeyDates_CaseID] = @pCaseId
		AND CaseKeyDates_KeyDatesCode = 'CostN258By' 
		AND CaseKeyDates_Inactive= 0			
		-------------------------------------------------------						
		SELECT @CostsDir_Prt8OrdDate = [CaseKeyDates_Date]
		FROM [CaseKeyDates]
		WHERE [CaseKeyDates_CaseID] = @pCaseId
		AND CaseKeyDates_KeyDatesCode = 'Prt8OrdDate' 
		AND CaseKeyDates_Inactive= 0
		-------------------------------------------------------						
		SELECT @CostsDir_N252DteSvd = [CaseKeyDates_Date]
		FROM [CaseKeyDates]
		WHERE [CaseKeyDates_CaseID] = @pCaseId
		AND CaseKeyDates_KeyDatesCode = 'N252DteSvd' 
		AND CaseKeyDates_Inactive = 0
		-------------------------------------------------------
		SELECT @CostsDir_N258DteSvd = [CaseKeyDates_Date]
		FROM [CaseKeyDates]
		WHERE [CaseKeyDates_CaseID] = @pCaseId
		AND CaseKeyDates_KeyDatesCode = 'N258DteSvd' 
		AND CaseKeyDates_Inactive = 0		
		-------------------------------------------------------				
		SELECT @CostsDir_SummAssDate = [CaseKeyDates_Date]
		FROM [CaseKeyDates]
		WHERE [CaseKeyDates_CaseID] = @pCaseId
		AND CaseKeyDates_KeyDatesCode = 'SummAssDate' 
		AND CaseKeyDates_Inactive = 0
		-------------------------------------------------------
		SELECT @CostsDir_PoDDueDate = [CaseKeyDates_Date]
		FROM [CaseKeyDates]
		WHERE [CaseKeyDates_CaseID] = @pCaseId
		AND CaseKeyDates_KeyDatesCode = 'PoDDueDate' 
		AND CaseKeyDates_Inactive = 0
		-------------------------------------------------------				
		SELECT @CostsDir_4719Offer = [CaseKeyDates_Date]
		FROM [CaseKeyDates]
		WHERE [CaseKeyDates_CaseID] = @pCaseId
		AND CaseKeyDates_KeyDatesCode = '4719Offer' 
		AND CaseKeyDates_Inactive = 0
		-------------------------------------------------------
		SELECT @CostsDir_RepsDueBy = [CaseKeyDates_Date]
		FROM [CaseKeyDates]
		WHERE [CaseKeyDates_CaseID] = @pCaseId
		AND CaseKeyDates_KeyDatesCode = 'RepsDueBy' AND CaseKeyDates_CreateUser = CASE WHEN @pUserName = '' THEN CaseKeyDates_CreateUser ELSE @pUserName END
		AND CaseKeyDates_Inactive = 0
		-------------------------------------------------------
		SELECT @CostsDir_PoDCompDte = [CaseKeyDates_Date]
		FROM [CaseKeyDates]
		WHERE [CaseKeyDates_CaseID] = @pCaseId
		AND CaseKeyDates_KeyDatesCode = 'PoDCompDte' 
		AND CaseKeyDates_Inactive = 0 
		-------------------------------------------------------
		SELECT @CostsDir_JSMtgBy = [CaseKeyDates_Date]
		FROM [CaseKeyDates]
		WHERE [CaseKeyDates_CaseID] = @pCaseId
		AND CaseKeyDates_KeyDatesCode = 'JSMtgBy' 
		AND CaseKeyDates_Inactive = 0
		-------------------------------------------------------
		SELECT @CostsDir_JSFileBy = [CaseKeyDates_Date]
		FROM [CaseKeyDates]
		WHERE [CaseKeyDates_CaseID] = @pCaseId
		AND CaseKeyDates_KeyDatesCode = 'JSFileBy' 
		AND CaseKeyDates_Inactive = 0
		-------------------------------------------------------
		SELECT @CostsDir_IntPytBy = [CaseKeyDates_Date]
		FROM [CaseKeyDates]
		WHERE [CaseKeyDates_CaseID] = @pCaseId
		AND CaseKeyDates_KeyDatesCode = 'IntPytBy' 
		AND CaseKeyDates_Inactive = 0
		-------------------------------------------------------
		SELECT @CostsDir_DAHDate = [CaseKeyDates_Date]
		FROM [CaseKeyDates]
		WHERE [CaseKeyDates_CaseID] = @pCaseId
		AND CaseKeyDates_KeyDatesCode = 'DAHDate' 
		AND CaseKeyDates_Inactive = 0
		-------------------------------------------------------
		SELECT @CostsDir_DAHApplDte = [CaseKeyDates_Date]
		FROM [CaseKeyDates]
		WHERE [CaseKeyDates_CaseID] = @pCaseId
		AND CaseKeyDates_KeyDatesCode = 'DAHApplDte' 
		AND CaseKeyDates_Inactive = 0
		-------------------------------------------------------				
		SELECT @CostsDir_CstSttlDte = [CaseKeyDates_Date]
		FROM [CaseKeyDates]
		WHERE [CaseKeyDates_CaseID] = @pCaseId
		AND CaseKeyDates_KeyDatesCode = 'CstSttlDte' 
		AND CaseKeyDates_Inactive = 0
		
		SELECT DISTINCT 
			CaseKeyDates_CaseID, 
			@CostsDir_CostAssDte AS CostsDir_CostAssDte,
			@CostsDir_CostAutAss AS CostsDir_CostAutAss,
			@CostsDir_CostN252By AS CostsDir_CostN252By,
			@CostsDir_CostN258By AS CostsDir_CostN258By,
			@CostsDir_Prt8OrdDate AS CostsDir_Prt8OrdDate,
			@CostsDir_N252DteSvd AS CostsDir_N252DteSvd,
			@CostsDir_N258DteSvd AS CostsDir_N258DteSvd,
			@CostsDir_SummAssDate AS CostsDir_SummAssDate,
			@CostsDir_PoDDueDate AS CostsDir_PoDDueDate,
			@CostsDir_4719Offer AS CostsDir_4719Offer,
			@CostsDir_RepsDueBy AS CostsDir_RepsDueBy,
			@CostsDir_PoDCompDte AS CostsDir_PoDCompDte,
			@CostsDir_JSMtgBy AS CostsDir_JSMtgBy,
			@CostsDir_JSFileBy AS CostsDir_JSFileBy,
			@CostsDir_IntPytBy AS CostsDir_IntPytBy,
			@CostsDir_DAHDate AS CostsDir_DAHDate,
			@CostsDir_DAHApplDte AS CostsDir_DAHApplDte,
			@CostsDir_CstSttlDte AS CostsDir_CstSttlDte					
		FROM CaseKeyDates ck
		WHERE CaseKeyDates_CaseID = @pCaseID
		AND CaseKeyDates_CreateUser = CASE WHEN @pUserName = '' THEN CaseKeyDates_CreateUser ELSE @pUserName END	
	END TRY

	BEGIN CATCH
		SELECT ERROR_MESSAGE () + ' SP: ' + OBJECT_NAME(@@PROCID)
	END CATCH




GO


