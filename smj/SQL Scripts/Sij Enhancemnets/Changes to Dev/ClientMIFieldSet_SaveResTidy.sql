USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[ClientMIFieldSet_SaveResTidy]    Script Date: 09/24/2012 16:31:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ClientMIFieldSet_SaveResTidy] 
	@pCase_CaseID						int = 0,
	@pUser_Name							nvarchar(255) = ''
AS

	-- =============================================
	-- Author:		GQL
	-- Create date: 29-03-2010
	-- Description:	Stored Procedure to CLEAN UP ANY 
	-- RESERVE UPDATES INTO THE RESERVE HISTORY TABLE
	-- =============================================
	
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================		
	
	BEGIN TRY
		--BEGIN SAVE TRANSACTION
		BEGIN TRANSACTION ClientMIFieldSetSaveResTidy
		
		--Initialise error trapping
		SET NOCOUNT ON
		SET ARITHABORT ON
	 
		
		--DECLARE AND INITIALISE LOCAL VARIABLES
		DECLARE @SQLSTRING1 AS NVARCHAR(MAX) = ''
		DECLARE @TABLECOLS1 AS NVARCHAR(MAX) = ''
		DECLARE @TABLECOLS2 AS NVARCHAR(MAX) = ''
		DECLARE @MAXID AS INT = 0
		DECLARE @MINID AS INT = 0
		
		
			
		--IF DURING THE MI UPDATE PROCESS WE HAVE CREATED NEW RESERVE DATA
		--WE NEED TO REFLECT THIS IN THE FINANCIAL RESERVE HISTORY TABLE
		IF NOT EXISTS(SELECT FinancialReserveHistory_FinancialHistoryID FROM dbo.FinancialReserveHistory WITH (NOLOCK) WHERE FinancialReserveHistory_FinancialReserveID in (SELECT FinancialReserve_FinancialReserveID FROM dbo.FinancialReserve WITH (NOLOCK) WHERE FinancialReserve_Inactive = 0 AND FinancialReserve_CaseID = @pCase_CaseID)) AND EXISTS(SELECT FinancialReserve_FinancialReserveID FROM dbo.FinancialReserve WITH (NOLOCK) WHERE FinancialReserve_Inactive = 0 AND FinancialReserve_CaseID = @pCase_CaseID)
		BEGIN
			--SET THE EXISTING MOST RECENT RECORD AS INACTIVE	
			UPDATE FinancialReserveHistory SET FinancialReserveHistory_Inactive = 1 WHERE FinancialReserveHistory_CaseID = @pCase_CaseID
			
			--DECLARE TEMP TABLE TO HOLD ALL THE FIELDS IN THE FinancialReserve TABLE
			DECLARE @TEMPTABLE1 TABLE
			(
				ID					INT IDENTITY,
				COLNAME				NVARCHAR(255)
			)
			
			--POPULATE THE TEMP TABLE WITH ALL THE FIELDS IN THE FinancialReserve TABLE
			INSERT INTO @TEMPTABLE1(COLNAME)
			SELECT c.name AS COLNAME
			FROM sysobjects o inner join 
			syscolumns c on o.id = c.id 
			WHERE o.name = 'FinancialReserve'
			ORDER BY c.colorder
			
			--get the maximum id value in the tempory table (for use in the while loop below)
			SELECT @MaxID = MAX(ID) FROM @TEMPTABLE1
			SET @MINID = 1
			
			--LOOP AROUND EACH RECORD IN THE TEMPORY TABLE	
			WHILE @MINID <= @MaxID 
			BEGIN
				--IF THIS IS THE FIRST PASS
				IF @MINID = 1
				BEGIN
					--BEGIN THE MI DATA TABLE FIELD SET VARIABLE WITHOUT A COMMA
					--USING THE FIELD NAMES IN THE FinancialReserve TABLE FOR CORRESPONDING FIELD NAMES
					--IN THE FinancialReserveHistory table by replacing FinancialReserve_ with FinancialReserveHistory_
					SET @TABLECOLS1 = (SELECT COLNAME FROM @TEMPTABLE1 WHERE ID = @MINID)
					SET @TABLECOLS2 = REPLACE((SELECT COLNAME FROM @TEMPTABLE1 WHERE ID = @MINID), 'FinancialReserve_', 'FinancialReserveHistory_')
				END
				ELSE
				BEGIN
					--ADD THE NEXT FIELD TO MI DATA TABLE FIELD SET VARIABLE WITH A COMMA DELIMITOR
					--USING THE FIELD NAMES IN THE FinancialReserve TABLE FOR CORRESPONDING FIELD NAMES
					--IN THE FinancialReserveHistory table by replacing FinancialReserve_ with FinancialReserveHistory_
					SET @TABLECOLS1 = @TABLECOLS1 + ', ' + (SELECT COLNAME FROM @TEMPTABLE1 WHERE ID = @MINID)
					SET @TABLECOLS2 = @TABLECOLS2 + ', ' + REPLACE((SELECT COLNAME FROM @TEMPTABLE1 WHERE ID = @MINID), 'FinancialReserve_', 'FinancialReserveHistory_')
				END
				
				--MOVE TO THE NEXT FinancialReserve TABLE FIELD
				SET @MINID = @MINID + 1
			END
					
			SET @SQLSTRING1 = 'INSERT INTO dbo.FinancialReserveHistory(' + @TABLECOLS2 + ') SELECT ' + @TABLECOLS1 + ' FROM dbo.FinancialReserve WITH (NOLOCK) WHERE FinancialReserve_Inactive = 0 AND FinancialReserve_CaseID = ' + CAST(@pCase_CaseID AS NVARCHAR(20))
			--**UNCOMMENT FOR DEBUG**
			PRINT @SQLSTRING1
			--PRINT @TABLECOLS1
			--PRINT @TABLECOLS2
			EXEC sp_executesql @SQLSTRING1
					
			--MAKE SURE ONLY THE MOST RECENT FINANCIAL RESERVE UPDATE IS ACTIVE
			UPDATE FinancialReserve 
			SET FinancialReserve_Inactive = 1
			WHERE FinancialReserve_CaseID = @pCase_CaseID AND 
			FinancialReserve_FinancialReserveID NOT IN
			(SELECT MAX(FinancialReserve_FinancialReserveID)
			FROM dbo.FinancialReserve WITH (NOLOCK) 
			WHERE FinancialReserve_Inactive = 0 AND FinancialReserve_CaseID = @pCase_CaseID)
			
			DELETE 
			FROM FinancialReserve 
			WHERE FinancialReserve_Inactive = 1 AND FinancialReserve_CaseID = @pCase_CaseID 
			
		END	
		
		COMMIT TRANSACTION ClientMIFieldSetSaveResTidy
	END TRY	
		
	BEGIN CATCH	
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION ClientMIFieldSetSaveResTidy	
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH
