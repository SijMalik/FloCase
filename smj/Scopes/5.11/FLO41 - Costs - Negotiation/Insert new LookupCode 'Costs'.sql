--SM - 28/10/2011: Add new OfferType 'Costs'

DECLARE	@return_value int

EXEC	@return_value = [dbo].[LTMM_LookupCode_Save]
		@pDescription = N'Costs',
		@pCode = N'OFRTYPCOST',
		@pLookupTypeCode = N'OFFERTYPE',
		@pInactive = 0,
		@pCreateUser = N'SMJ'

SELECT	'Return Value' = @return_value

GO
