USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[ClientMIFieldSet_ProcessAdvCalculation]    Script Date: 09/24/2012 16:27:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ClientMIFieldSet_ProcessAdvCalculation] 
	@pMIFieldSetID							int = 0,
	@pCaseID								int = 0,
	@PCalcVal								NVARCHAR(MAX) = '' OUTPUT,
	@pContactID								INT = 0
AS

	-- =============================================
	-- Author:		GQL
	-- Create date: 19-03-2010
	-- Description:	Stored Procedure to process 
	-- ANY advanced CALCULATIONS ATTACHED TO A CLIENT MI FIELD
	-- GQL AMENDED 05/07/2011 TO ALTER OUTPUT DATATPE ON ADVANCED CALCULATIOSN FROM MONEY TO NVARCHAR(MAX)
	-- =============================================
	
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================		
		
	--Initialise error trapping
	SET NOCOUNT ON
	SET ARITHABORT ON
	DECLARE @myLastError int 
	SELECT @myLastError = 0
	DECLARE @myLastErrorString nvarchar(255)
	SELECT @myLastErrorString = '' 
	
	--DECLARE AND INITIALISE LOCAL VARIABLES
	DECLARE @NoCalcitms int = 0
	DECLARE @Count int = 1
	DECLARE @ITEM as nvarchar(255) 
	Declare @pSTRCALC as  nvarchar(MAX) = ''
	Declare @pSTRSQL as  nvarchar(MAX) 
	DECLARE @pSTRVAL as nvarchar(max)
	DECLARE @CaseID_Field as nvarchar(max)
	DECLARE @pAdvCalc as nvarchar(max)
	DECLARE @DELIMPOS int
	DECLARE @STRLEN AS INT
	DECLARE @TAB AS NVARCHAR(MAX)
	DECLARE @COL AS NVARCHAR(MAX)

	BEGIN TRY
		IF EXISTS (SELECT ClientMIFieldSetAdvCalc_ClientMIFieldSetAdvCalcID FROM dbo.ClientMIFieldSetAdvCalc WITH (NOLOCK) WHERE ClientMIFieldSetAdvCalc_ClientMIFieldSetField = (SELECT ClientMIFieldSet_ClientMIDEFCODE + ClientMIFieldSet_MIFieldDefCode FROM dbo.ClientMIFieldSet WITH (NOLOCK) WHERE ClientMIFieldSet_ClientMIFieldSetID = @pMIFieldSetID))
		BEGIN
			
			SELECT @pAdvCalc = ClientMIFieldSetAdvCalc_CalculationDetails FROM dbo.ClientMIFieldSetAdvCalc WITH (NOLOCK) WHERE ClientMIFieldSetAdvCalc_ClientMIFieldSetField = (SELECT ClientMIFieldSet_ClientMIDEFCODE + ClientMIFieldSet_MIFieldDefCode FROM dbo.ClientMIFieldSet WITH (NOLOCK) WHERE ClientMIFieldSet_ClientMIFieldSetID = @pMIFieldSetID)
			--print @pAdvCalc
					
			IF ISNULL(@pAdvCalc, '') <> ''
			BEGIN
				IF ISNULL(@pContactID, 0) > 0
				BEGIN
					SELECT  @pAdvCalc = REPLACE(@padvcalc,'$CONTACTID',CAST(@pcontactID AS NVARCHAR(25)))
				END
				ELSE
				BEGIN
					SELECT  @pAdvCalc = REPLACE(@padvcalc,'$CONTACTID','0')
				END
				--PRINT @padvcalc
				EXEC sp_executesql @pAdvCalc,
				N'@CaseID int, @OUT NVARCHAR(MAX) out',
				@CaseID = @pCaseID, @OUT = @PCalcVal OUTPUT	
			END
		END

	END TRY
		
	BEGIN CATCH		
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH
	


