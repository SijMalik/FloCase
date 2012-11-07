--SMJ - 28/10/2011: Add new KeyDateType N'CostAssDte'

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_KeyDatesType_Save]
		@pDescription = N'Date Assigned To Costs',
		@pCode = N'CostAssDte',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO