DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_KeyDatesType_Save]
		@pDescription = N'Date Costs Agreed',
		@pCode = N'DteCstAgrd',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO

---------------------------------------------
DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_LookupType_Save]
		@pDescription = N'Costs WorkType',
		@pCode = N'CstWrkType',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_LookupCode_Save]
		@pDescription = N'BILL',
		@pCode = N'BILL',
		@pLookupTypeCode = N'CstWrkType',
		@pInactive = 0,
		@pCreateUser = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_LookupCode_Save]
		@pDescription = N'POD',
		@pCode = N'POD',
		@pLookupTypeCode = N'CstWrkType',
		@pInactive = 0,
		@pCreateUser = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_LookupCode_Save]
		@pDescription = N'ADVICE',
		@pCode = N'ADVICE',
		@pLookupTypeCode = N'CstWrkType',
		@pInactive = 0,
		@pCreateUser = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_LookupCode_Save]
		@pDescription = N'JOINT STATEMENT',
		@pCode = N'JntState',
		@pLookupTypeCode = N'CstWrkType',
		@pInactive = 0,
		@pCreateUser = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_LookupCode_Save]
		@pDescription = N'NEGOTIATION',
		@pCode = N'NEGOTIATE',
		@pLookupTypeCode = N'CstWrkType',
		@pInactive = 0,
		@pCreateUser = N'SMJ'

SELECT	'Return Value' = @return_value

GO
---------------------------------------------
DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_LookupType_Save]
		@pDescription = N'Party',
		@pCode = N'CostsParty',
		@pInactive = 0,
		@pUsername = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_LookupCode_Save]
		@pDescription = N'PAYING',
		@pCode = N'PAYING',
		@pLookupTypeCode = N'CostsParty',
		@pInactive = 0,
		@pCreateUser = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_LookupCode_Save]
		@pDescription = N'RECEIVING',
		@pCode = N'RECEIVING',
		@pLookupTypeCode = N'CostsParty',
		@pInactive = 0,
		@pCreateUser = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_LookupCode_Save]
		@pDescription = N'BOTH',
		@pCode = N'BOTH',
		@pLookupTypeCode = N'CostsParty',
		@pInactive = 0,
		@pCreateUser = N'SMJ'

SELECT	'Return Value' = @return_value

GO
---------------------------------------------

INSERT INTO KeyDatesType
  VALUES( 'Date File Returned', 'DteFlRtn',0,'SMJ', GETDATE(), NULL)
