/****** Object:  StoredProcedure [dbo].[LTMM_CostsDirections_Save]    Script Date: 11/04/2011 15:34:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[LTMM_CostsDirections_Save]
(
	@pCaseId			INT = 0, 
	@pUserName			VARCHAR (255) = '',
	@pCostsDir_CostAssDte		DATETIME = NULL, 
	@pCostsDir_CostAutAss		DATETIME = NULL, 
	@pCostsDir_CostN252By		DATETIME = NULL, 
	@pCostsDir_CostN258By		DATETIME = NULL, 
	@pCostsDir_Prt8OrdDate		DATETIME = NULL, 
	@pCostsDir_N252DteSvd		DATETIME = NULL, 
	@pCostsDir_N258DteSvd		DATETIME = NULL, 
	@pCostsDir_SummAssDate		DATETIME = NULL, 
	@pCostsDir_PodDDueDate		DATETIME = NULL, 
	@pCostsDir_4719Offer		DATETIME = NULL, 
	@pCostsDir_RepsDueBy		DATETIME = NULL, 
	@pCostsDir_PodCompDte		DATETIME = NULL, 
	@pCostsDir_JSMtgBy		DATETIME = NULL, 
	@pCostsDir_JSFileBy		DATETIME = NULL, 
	@pCostsDir_IntPytBy		DATETIME = NULL, 
	@pCostsDir_DAHDate		DATETIME = NULL, 
	@pCostsDir_DAHAppleDte		DATETIME = NULL, 
	@pCostsDir_CstSttlDte		DATETIME = NULL 
)
AS
	--==============================================================--
	-- Created By:	SMJ
	-- Create Date:	04-11-11
	-- Description:	Save Costs Directions key dates
	--==============================================================--
	
	DECLARE @errNoCase		VARCHAR(50) 
	DECLARE @errNoName		VARCHAR(50)
	DECLARE @errNoAppIns		VARCHAR(50)
	DECLARE @AppInstanceValue	NVARCHAR(50)	
	
	SET NOCOUNT ON
	
	SET @errNoCase	 = 'No Case ID passed in.'
	SET @errNoName	 = 'No User Name passed in.'
	SET @errNoAppIns = 'No AppInstanceValue found.'
	
	SET @AppInstanceValue = NULL
	
	BEGIN TRY 
		--DO SOME ERROR-CHECKING
		IF @pCaseId <= 0 
			RAISERROR (@errNoCase, 16, 1)
				
		IF @pUserName = ''
			RAISERROR (@errNoName, 16, 1)	
							
		-- Get AppInstanceValue 
		SELECT @AppInstanceValue = IdentifierValue
		FROM dbo.ApplicationInstance
		WHERE CaseID = @pCaseId
		
		--Check AppInstanceValue has been returned
		IF ISNULL(@AppInstanceValue,'') = ''
			RAISERROR (@errNoAppIns, 16, 1)
			
		-- Save key Dates
		----------------------------------------------------
		IF @pCostsDir_CostAssDte IS NOT NULL OR EXISTS(SELECT * FROM CaseKeyDates WHERE CaseKeyDates_CaseID = @pCaseId AND CaseKeyDates_KeyDatesCode = 'CostAssDte' AND CaseKeyDates_Inactive = 0)
		BEGIN					
			EXEC dbo.LTMM_Directions_KeyDate_Save
				@pCaseId = @pCaseId, 
				@pAppInstanceValue = @AppInstanceValue,
				@pUserName = @pUserName,
				@pDate = @pCostsDir_CostAssDte,
				@pKeyDateCode = 'CostAssDte'			
		END
		
		IF @pCostsDir_CostAutAss IS NOT NULL OR EXISTS(SELECT * FROM CaseKeyDates WHERE CaseKeyDates_CaseID = @pCaseId AND CaseKeyDates_KeyDatesCode = 'CostAutAss' AND CaseKeyDates_Inactive = 0)
		BEGIN					
			EXEC dbo.LTMM_Directions_KeyDate_Save
				@pCaseId = @pCaseId, 
				@pAppInstanceValue = @AppInstanceValue,
				@pUserName = @pUserName,
				@pDate = @pCostsDir_CostAssDte,
				@pKeyDateCode = 'CostAutAss'			
		END
		
		IF @pCostsDir_CostN252By IS NOT NULL OR EXISTS(SELECT * FROM CaseKeyDates WHERE CaseKeyDates_CaseID = @pCaseId AND CaseKeyDates_KeyDatesCode = 'CostN252By' AND CaseKeyDates_Inactive = 0)
		BEGIN					
			EXEC dbo.LTMM_Directions_KeyDate_Save
				@pCaseId = @pCaseId, 
				@pAppInstanceValue = @AppInstanceValue,
				@pUserName = @pUserName,
				@pDate = @pCostsDir_CostAssDte,
				@pKeyDateCode = 'CostN252By'			
		END		
	
		IF @pCostsDir_CostN258By IS NOT NULL OR EXISTS(SELECT * FROM CaseKeyDates WHERE CaseKeyDates_CaseID = @pCaseId AND CaseKeyDates_KeyDatesCode = 'CostN258By' AND CaseKeyDates_Inactive = 0)
		BEGIN					
			EXEC dbo.LTMM_Directions_KeyDate_Save
				@pCaseId = @pCaseId, 
				@pAppInstanceValue = @AppInstanceValue,
				@pUserName = @pUserName,
				@pDate = @pCostsDir_CostAssDte,
				@pKeyDateCode = 'CostN258By'			
		END	
		
		IF @pCostsDir_Prt8OrdDate IS NOT NULL OR EXISTS(SELECT * FROM CaseKeyDates WHERE CaseKeyDates_CaseID = @pCaseId AND CaseKeyDates_KeyDatesCode = 'Prt8OrdDate' AND CaseKeyDates_Inactive = 0)
		BEGIN					
			EXEC dbo.LTMM_Directions_KeyDate_Save
				@pCaseId = @pCaseId, 
				@pAppInstanceValue = @AppInstanceValue,
				@pUserName = @pUserName,
				@pDate = @pCostsDir_CostAssDte,
				@pKeyDateCode = 'Prt8OrdDate'			
		END		
		
		IF @pCostsDir_N252DteSvd IS NOT NULL OR EXISTS(SELECT * FROM CaseKeyDates WHERE CaseKeyDates_CaseID = @pCaseId AND CaseKeyDates_KeyDatesCode = 'N252DteSvd' AND CaseKeyDates_Inactive = 0)
		BEGIN					
			EXEC dbo.LTMM_Directions_KeyDate_Save
				@pCaseId = @pCaseId, 
				@pAppInstanceValue = @AppInstanceValue,
				@pUserName = @pUserName,
				@pDate = @pCostsDir_CostAssDte,
				@pKeyDateCode = 'N252DteSvd'			
		END		
		
		IF @pCostsDir_N258DteSvd IS NOT NULL OR EXISTS(SELECT * FROM CaseKeyDates WHERE CaseKeyDates_CaseID = @pCaseId AND CaseKeyDates_KeyDatesCode = 'N258DteSvd' AND CaseKeyDates_Inactive = 0)
		BEGIN					
			EXEC dbo.LTMM_Directions_KeyDate_Save
				@pCaseId = @pCaseId, 
				@pAppInstanceValue = @AppInstanceValue,
				@pUserName = @pUserName,
				@pDate = @pCostsDir_CostAssDte,
				@pKeyDateCode = 'N258DteSvd'			
		END		

		IF @pCostsDir_SummAssDate IS NOT NULL OR EXISTS(SELECT * FROM CaseKeyDates WHERE CaseKeyDates_CaseID = @pCaseId AND CaseKeyDates_KeyDatesCode = 'SummAssDate' AND CaseKeyDates_Inactive = 0)
		BEGIN					
			EXEC dbo.LTMM_Directions_KeyDate_Save
				@pCaseId = @pCaseId, 
				@pAppInstanceValue = @AppInstanceValue,
				@pUserName = @pUserName,
				@pDate = @pCostsDir_CostAssDte,
				@pKeyDateCode = 'SummAssDate'			
		END	

		IF @pCostsDir_PodDDueDate IS NOT NULL OR EXISTS(SELECT * FROM CaseKeyDates WHERE CaseKeyDates_CaseID = @pCaseId AND CaseKeyDates_KeyDatesCode = 'PodDDueDate' AND CaseKeyDates_Inactive = 0)
		BEGIN					
			EXEC dbo.LTMM_Directions_KeyDate_Save
				@pCaseId = @pCaseId, 
				@pAppInstanceValue = @AppInstanceValue,
				@pUserName = @pUserName,
				@pDate = @pCostsDir_CostAssDte,
				@pKeyDateCode = 'PodDDueDate'			
		END	

		IF @pCostsDir_4719Offer IS NOT NULL OR EXISTS(SELECT * FROM CaseKeyDates WHERE CaseKeyDates_CaseID = @pCaseId AND CaseKeyDates_KeyDatesCode = '4719Offer' AND CaseKeyDates_Inactive = 0)
		BEGIN					
			EXEC dbo.LTMM_Directions_KeyDate_Save
				@pCaseId = @pCaseId, 
				@pAppInstanceValue = @AppInstanceValue,
				@pUserName = @pUserName,
				@pDate = @pCostsDir_CostAssDte,
				@pKeyDateCode = '4719Offer'			
		END		
		
		IF @pCostsDir_RepsDueBy IS NOT NULL OR EXISTS(SELECT * FROM CaseKeyDates WHERE CaseKeyDates_CaseID = @pCaseId AND CaseKeyDates_KeyDatesCode = 'RepsDueBy' AND CaseKeyDates_Inactive = 0)
		BEGIN					
			EXEC dbo.LTMM_Directions_KeyDate_Save
				@pCaseId = @pCaseId, 
				@pAppInstanceValue = @AppInstanceValue,
				@pUserName = @pUserName,
				@pDate = @pCostsDir_CostAssDte,
				@pKeyDateCode = 'RepsDueBy'			
		END	

		IF @pCostsDir_PodCompDte IS NOT NULL OR EXISTS(SELECT * FROM CaseKeyDates WHERE CaseKeyDates_CaseID = @pCaseId AND CaseKeyDates_KeyDatesCode = 'PodCompDte' AND CaseKeyDates_Inactive = 0)
		BEGIN					
			EXEC dbo.LTMM_Directions_KeyDate_Save
				@pCaseId = @pCaseId, 
				@pAppInstanceValue = @AppInstanceValue,
				@pUserName = @pUserName,
				@pDate = @pCostsDir_CostAssDte,
				@pKeyDateCode = 'PodCompDte'			
		END	
		
		IF @pCostsDir_JSMtgBy IS NOT NULL OR EXISTS(SELECT * FROM CaseKeyDates WHERE CaseKeyDates_CaseID = @pCaseId AND CaseKeyDates_KeyDatesCode = 'JSMtgBy' AND CaseKeyDates_Inactive = 0)
		BEGIN					
			EXEC dbo.LTMM_Directions_KeyDate_Save
				@pCaseId = @pCaseId, 
				@pAppInstanceValue = @AppInstanceValue,
				@pUserName = @pUserName,
				@pDate = @pCostsDir_CostAssDte,
				@pKeyDateCode = 'JSMtgBy'			
		END	
		
		IF @pCostsDir_JSFileBy IS NOT NULL OR EXISTS(SELECT * FROM CaseKeyDates WHERE CaseKeyDates_CaseID = @pCaseId AND CaseKeyDates_KeyDatesCode = 'JSFileBy' AND CaseKeyDates_Inactive = 0)
		BEGIN					
			EXEC dbo.LTMM_Directions_KeyDate_Save
				@pCaseId = @pCaseId, 
				@pAppInstanceValue = @AppInstanceValue,
				@pUserName = @pUserName,
				@pDate = @pCostsDir_CostAssDte,
				@pKeyDateCode = 'JSFileBy'			
		END																	

		IF @pCostsDir_IntPytBy IS NOT NULL OR EXISTS(SELECT * FROM CaseKeyDates WHERE CaseKeyDates_CaseID = @pCaseId AND CaseKeyDates_KeyDatesCode = 'IntPytBy' AND CaseKeyDates_Inactive = 0)
		BEGIN					
			EXEC dbo.LTMM_Directions_KeyDate_Save
				@pCaseId = @pCaseId, 
				@pAppInstanceValue = @AppInstanceValue,
				@pUserName = @pUserName,
				@pDate = @pCostsDir_CostAssDte,
				@pKeyDateCode = 'IntPytBy'			
		END	

		IF @pCostsDir_DAHDate IS NOT NULL OR EXISTS(SELECT * FROM CaseKeyDates WHERE CaseKeyDates_CaseID = @pCaseId AND CaseKeyDates_KeyDatesCode = 'DAHDate' AND CaseKeyDates_Inactive = 0)
		BEGIN					
			EXEC dbo.LTMM_Directions_KeyDate_Save
				@pCaseId = @pCaseId, 
				@pAppInstanceValue = @AppInstanceValue,
				@pUserName = @pUserName,
				@pDate = @pCostsDir_CostAssDte,
				@pKeyDateCode = 'DAHDate'			
		END
		
		IF @pCostsDir_DAHAppleDte IS NOT NULL OR EXISTS(SELECT * FROM CaseKeyDates WHERE CaseKeyDates_CaseID = @pCaseId AND CaseKeyDates_KeyDatesCode = 'DAHAppleDte' AND CaseKeyDates_Inactive = 0)
		BEGIN					
			EXEC dbo.LTMM_Directions_KeyDate_Save
				@pCaseId = @pCaseId, 
				@pAppInstanceValue = @AppInstanceValue,
				@pUserName = @pUserName,
				@pDate = @pCostsDir_CostAssDte,
				@pKeyDateCode = 'DAHAppleDte'			
		END		
		
		IF @pCostsDir_CstSttlDte IS NOT NULL OR EXISTS(SELECT * FROM CaseKeyDates WHERE CaseKeyDates_CaseID = @pCaseId AND CaseKeyDates_KeyDatesCode = 'CstSttlDte' AND CaseKeyDates_Inactive = 0)
		BEGIN					
			EXEC dbo.LTMM_Directions_KeyDate_Save
				@pCaseId = @pCaseId, 
				@pAppInstanceValue = @AppInstanceValue,
				@pUserName = @pUserName,
				@pDate = @pCostsDir_CostAssDte,
				@pKeyDateCode = 'CstSttlDte'			
		END	
		----------------------------------------------------												
			
		SELECT '1' AS ReturnValue
			
	END TRY

	BEGIN CATCH
		SELECT ERROR_MESSAGE () + ' SP: ' + OBJECT_NAME(@@PROCID)
	END CATCH

GO


