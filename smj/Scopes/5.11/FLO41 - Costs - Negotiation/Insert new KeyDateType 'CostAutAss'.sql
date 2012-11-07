--SMJ - 28/10/2011: Add new KeyDateType N'CostAutAss'

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_KeyDatesType_Save]
		@pDescription = N'Date of Authority to Assess',
		@pCode = N'CostAutAss',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO