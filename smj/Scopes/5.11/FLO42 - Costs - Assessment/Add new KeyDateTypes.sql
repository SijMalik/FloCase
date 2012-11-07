--SMJ - 01/11/2011: Add new KeyDateTypes
USE FloSuite_Data_Dev

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_KeyDatesType_Save]
		@pDescription = N'Final Date For Notice of Commencement',
		@pCode = N'CostN252By',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_KeyDatesType_Save]
		@pDescription = N'Final Date for Request For Hearing',
		@pCode = N'CostN258By',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_KeyDatesType_Save]
		@pDescription = N'Date of Part 8 Order',
		@pCode = N'Prt8OrdDte',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_KeyDatesType_Save]
		@pDescription = N'N252 Date of Service',
		@pCode = N'N252DteSvd',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_KeyDatesType_Save]
		@pDescription = N'N258 Date of Service',
		@pCode = N'N256DteSvd',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_KeyDatesType_Save]
		@pDescription = N'Summary Assessment Date',
		@pCode = N'SummAssDte',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_KeyDatesType_Save]
		@pDescription = N'Points of Dispute Due Date',
		@pCode = N'PoDDueDate',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_KeyDatesType_Save]
		@pDescription = N'47.19 Offer Due By',
		@pCode = N'4719Offer',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_KeyDatesType_Save]
		@pDescription = N'Replies to POD By',
		@pCode = N'RepsDueBy',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_KeyDatesType_Save]
		@pDescription = N'Points Of Dispute Completed',
		@pCode = N'PoDCompDte',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_KeyDatesType_Save]
		@pDescription = N'Joint statement meeting By',
		@pCode = N'JSMtgBy',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_KeyDatesType_Save]
		@pDescription = N'Joint Statement Filed By',
		@pCode = N'JSFileBy',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_KeyDatesType_Save]
		@pDescription = N'Interim Payment By',
		@pCode = N'IntPytBy',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_KeyDatesType_Save]
		@pDescription = N'Detailed Assessment Hearing Date',
		@pCode = N'DAHDate',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_KeyDatesType_Save]
		@pDescription = N'Appeal By Date',
		@pCode = N'DAHApplDte',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_KeyDatesType_Save]
		@pDescription = N'Costs Settled Date',
		@pCode = N'CstSttlDte',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO