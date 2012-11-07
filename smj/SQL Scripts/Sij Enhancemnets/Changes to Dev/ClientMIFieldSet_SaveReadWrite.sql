USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[ClientMIFieldSet_SaveReadWrite]    Script Date: 09/24/2012 14:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


		  
ALTER PROCEDURE [dbo].[ClientMIFieldSet_SaveReadWrite]	( @pCaseID INT = 0) -- MANDATORY 
	--=================================================--
	--	Author:			SMJ				  
	--	Created:		22/06/2012
	--	Version:		1
	--	Release:		5.16
	--	Description:	Saves MI Read/Write fields
	--=================================================--
AS	

	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================	
DECLARE @errNoCaseID VARCHAR(50)
DECLARE @ClientMIFieldSetID INT
DECLARE @MIDefID INT
DECLARE @OutVal	NVARCHAR (MAX)
DECLARE @Counter INT
DECLARE @MaxID INT
DECLARE @DynSQL NVARCHAR(MAX)
DECLARE @CaseField VARCHAR(50)
DECLARE @InactiveField VARCHAR(50)


	SET NOCOUNT ON 
	
	SET @errNoCaseID = 'No CaseID supplied'
	SET @Counter = 1

	BEGIN TRY
		IF @pCaseID = 0
			RAISERROR (@errNoCaseID, 16,1 )
			
		DECLARE @CMF TABLE (ID INT IDENTITY(1,1), CMFID INT, MICODE VARCHAR(50), MIID INT, CalcCode VARCHAR(255), CalcTable VARCHAR(50), CalcField VARCHAR(50), CalcVal MONEY, CaseCol VARCHAR(50),InactiveCol VARCHAR(50)) 
		
		INSERT INTO @CMF (CMFID, MICODE, MIID)
		SELECT cf.ClientMIFieldSet_ClientMIFieldSetID, mf.MIFieldDefinition_MIFieldCode, mf.MIFieldDefinition_MIFieldDefinitionID
		FROM [Case] c INNER JOIN
		ClientMIDefinition cm ON c.Case_GroupCode = cm.ClientMIDefinition_MIDEFCODE and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
		ClientMIFieldSet cf ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 INNER JOIN
		MIFieldDefinition mf ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0
		WHERE c.Case_CaseID = @pCaseID and mf.MIFieldDefinition_DataField <> 'n/a' and ISNULL(mf.MIFieldDefinition_DataField,'') <> ''
		and cf.ClientMIFieldSet_MIFieldROWrite = 1
				
		SELECT @MaxID = MAX(ID) FROM @CMF

		WHILE @Counter <= @MaxID
		BEGIN
				
			SELECT @ClientMIFieldSetID = CMFID FROM @CMF WHERE ID = @Counter
			SELECT @MIDefID = MIID FROM @CMF WHERE ID = @Counter
			
			EXEC ClientMIFieldSet_ProcessAdvCalculation
				@ClientMIFieldSetID, @pCaseID, @OutVal OUTPUT 

			UPDATE @CMF 
			SET CalcCode = ClientMIFieldSetAdvCalc_ClientMIFieldSetField
			FROM @CMF INNNER JOIN ClientMIFieldSetAdvCalc
			ON (ClientMIFieldSetAdvCalc_ClientMIFieldSetField LIKE '%' + LTRIM(RTRIM(MICODE)) + '%')
			WHERE ID = @Counter			
			
			UPDATE @CMF
			SET CalcTable = MIFieldDefinition_DataTable,
				CalcField = MIFieldDefinition_DataField
			FROM ClientMIFieldSetAdvCalc c
			INNER JOIN MIFieldDefinition mi 
			ON (ClientMIFieldSetAdvCalc_ClientMIFieldSetField LIKE '%' + LTRIM(RTRIM(MIFieldDefinition_MIFieldCode)) + '%')
			WHERE mi.MIFieldDefinition_MIFieldDefinitionID = @MIDefID
			AND ID = @Counter		
			
			UPDATE @CMF
			SET CalcVal = @OutVal
			WHERE ID = @Counter	
			
			SELECT @CaseField = c.name  
			FROM sysobjects o inner join 
			syscolumns c on o.id = c.id 
			INNER JOIN @CMF cmf
			ON o.name = cmf.CalcTable
			WHERE o.name = cmf.CalcTable and c.name like '%CaseID'	
			
			UPDATE @CMF
			SET CaseCol = @CaseField
			WHERE ID = @Counter
		
			SELECT @InactiveField = c.name  
			FROM sysobjects o inner join 
			syscolumns c on o.id = c.id 
			INNER JOIN @CMF cmf
			ON o.name = cmf.CalcTable
			WHERE o.name = cmf.CalcTable and c.name like '%InActive'									
	
			UPDATE @CMF
			SET InactiveCol = @InactiveField
			WHERE ID = @Counter
			
			SELECT @DynSQL = 'UPDATE ' + CalcTable + ' SET ' + CalcField + ' = ' + CONVERT(VARCHAR(10), Calcval) + ' WHERE ' + CaseCol + ' = ' + CONVERT(VARCHAR(10),@pCaseID) + ' AND ' + InactiveCol + ' = 0'
			FROM @CMF 	
			WHERE ID = @Counter			
	
			EXEC sp_executesql @dynsql

			SELECT @Counter = @Counter + 1
						
		END
				
	END TRY
	
	BEGIN CATCH
		SELECT ERROR_MESSAGE() + '. SP: ' + OBJECT_NAME(@@PROCID)
	END CATCH
	

	