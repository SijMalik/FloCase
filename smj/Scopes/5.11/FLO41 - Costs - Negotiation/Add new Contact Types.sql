--SMJ - 01/11/2011: Add new Contact types
------------------------------------------------------------

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_LookupCode_Save]
		@pDescription =N'Co-Defendant Solicitor',
		@pCode = N'CODEFSOL',
		@pLookupTypeCode = N'AllContact',
		@pInactive = 0,
		@pCreateUser = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_LookupCode_Save]
		@pDescription =N'Co-Defendant Solicitor',
		@pCode = N'CODEFSOL',
		@pLookupTypeCode = N'Contact',
		@pInactive = 0,
		@pCreateUser = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_LookupCode_Save]
		@pDescription =N'Co-Defendant Solicitor',
		@pCode = N'CODEFSOL',
		@pLookupTypeCode = N'RefContact',
		@pInactive = 0,
		@pCreateUser = N'SMJ'

SELECT	'Return Value' = @return_value

GO

---------------------------------------

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_LookupCode_Save]
		@pDescription =N'External Costs Draftsperson/Company',
		@pCode = N'ExtCstDrft',
		@pLookupTypeCode = N'AllContact',
		@pInactive = 0,
		@pCreateUser = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_LookupCode_Save]
		@pDescription =N'External Costs Draftsperson/Company',
		@pCode = N'ExtCstDrft',
		@pLookupTypeCode = N'EdtCntct',
		@pInactive = 0,
		@pCreateUser = N'SMJ'

SELECT	'Return Value' = @return_value

GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_LookupCode_Save]
		@pDescription =N'External Costs Draftsperson/Company',
		@pCode = N'ExtCstDrft',
		@pLookupTypeCode = N'RefContact',
		@pInactive = 0,
		@pCreateUser = N'SMJ'

SELECT	'Return Value' = @return_value

GO

EXEC [LTMM_LookupCode_Save]
		@pDescription = N'47.19',
		@pCode = N'4719',
		@pLookupTypeCode = N'OFFERRLTN',
		@pInactive = 0,
		@pCreateUser = N'SMJ'
  
EXEC [LTMM_LookupCode_Save]
		@pDescription = N'Regular',
		@pCode = N'Regular',
		@pLookupTypeCode = N'OFFERRLTN',
		@pInactive = 0,
		@pCreateUser = N'SMJ'