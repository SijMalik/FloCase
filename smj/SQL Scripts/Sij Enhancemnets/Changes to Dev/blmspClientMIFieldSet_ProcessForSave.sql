USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[blmspClientMIFieldSet_ProcessForSave]    Script Date: 09/24/2012 16:05:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[blmspClientMIFieldSet_ProcessForSave]
(
	@KeyDateType nvarchar(256) = NULL,
	@CaseID_Field nvarchar(256),
	@DataTable nvarchar(256),
	@PMS_Field bit,
	@pCase_CaseID int = 0,
	@Inactive_Field nvarchar(256),
	@DataField  nvarchar(256),
	@CreateUser_Field  nvarchar(256),
	@CreateDate_Field  nvarchar(256),
	@PMIFieldValue  nvarchar(256),
	@DataFieldType  nvarchar(256),
	@pUser_Name nvarchar(255) = '',
	@PrimaryKey_Field  nvarchar(256),
	@TABLECOLS nvarchar(max),
	@pContactID INT = 0,
	@pIsClaimant bit = 0
)
AS
	-- =============================================
	-- Author:		GQL
	-- Create date: 26-02-2010
	-- Modified by Ross Hannah 16/03/2011 to improve performace
	-- Modified by GQL 27/06/2011  to handle the saving of data back to Aderant Expert PMS
	-- Description:	Stored Procedure to perform the individual saves for the Dynamic Client MI form
	-- =============================================

	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================	
		
	SET NOCOUNT ON
	SET XACT_ABORT ON 
	DECLARE @RECORDTEST int 
	DECLARE @SQLSTRING1 AS NVARCHAR(MAX) = ''
	DECLARE @SQLSTRING2 AS NVARCHAR(MAX) = ''
	DECLARE @SQLSTRING3 AS NVARCHAR(MAX) = ''
	DECLARE @SQLSTRING4 AS NVARCHAR(MAX) = ''
	DECLARE @SQLSTRING5 AS NVARCHAR(MAX) = ''
	DECLARE @MATTER_UNO AS INT = 0
	DECLARE @ADERANTSERVER AS NVARCHAR(MAX) = ''
	DECLARE @ADERANTDB AS NVARCHAR(MAX) = ''
	DECLARE @fieldname AS NVARCHAR(MAX) = ''

	SET @RECORDTEST = 0
	
	BEGIN TRY
		--GET THE MATTER UNO
		SELECT @MATTER_UNO = AExpert_MatterUno 
		FROM dbo.ApplicationInstance WITH (NOLOCK) 
		WHERE CaseID = @pCase_CaseID
		

		SELECT @ADERANTDB = SystemSettings_ADERANTEXPERTDB, 
		@ADERANTSERVER = SystemSettings_ADERANTEXPERTSERVER 
		FROM dbo.SystemSettings WITH (NOLOCK)
			
		--IF WE ARE NOT UPDATING THE PRACTICE MANAGEMENT SYSTEM
		IF ISNULL(@PMS_Field, 0) = 0
		BEGIN
			--print 'Non PMS'
			
			--CHECK FOR CLAIMANT MI
			IF @pIsClaimant = 0 --MATTER CENTRIC
			BEGIN
				--biuld record test sql string (@SQLSTRING1) to test to see if a record exists for this matter in the destination mi table
				SET @SQLSTRING1 = 'SELECT @CASEID = ISNULL(' + @CaseID_Field + ',0) FROM ' + @DataTable + ' WHERE ' + @CaseID_Field + ' = ' + CAST(@pCase_CaseID AS NVARCHAR(25)) + ' AND ' + @Inactive_Field + ' = 0'
				--print '@SQLSTRING1: ' + isnull(@SQLSTRING1, '')
				--biuld insert sql string (@SQLSTRING2) for if a record does not already exist in teh source table
				SET @SQLSTRING2 = N'INSERT INTO '  + @DataTable + '(' + @DataField + ', ' + @CaseID_Field + ', ' + @Inactive_Field + ', ' + @CreateUser_Field + ', ' + @CreateDate_Field + ') VALUES(CAST(''' + @PMIFieldValue + ''' AS ' + @DataFieldType + '), ' + cast(@pCase_CaseID as nvarchar(25)) + ', 0, ''' + @pUser_Name + ''', GETDATE())'
				----print '@SQLSTRING1 = ' + @SQLSTRING1
			END
			ELSE -- CLAIMANT CENTRIC
			BEGIN
				SET @SQLSTRING1 = 'SELECT @CASEID = ' + CAST(@pCase_CaseID AS NVARCHAR(25)) 
				--print '@SQLSTRING1: ' + isnull(@SQLSTRING1, '')
				--biuld insert sql string (@SQLSTRING2) for if a record does not already exist in teh source table
				SET @SQLSTRING2 = N'INSERT INTO '  + @DataTable + '(' + @DataField + ', ' + @CaseID_Field + ', ' + @Inactive_Field + ', ' + @CreateUser_Field + ', ' + @CreateDate_Field + ') VALUES(CAST(''' + @PMIFieldValue + ''' AS ' + @DataFieldType + '), ' + cast(@pCase_CaseID as nvarchar(25)) + ', 0, ''' + @pUser_Name + ''', GETDATE())'
			END
			------
			
			--if the destonation mi table being processed is not the case table
			IF (ISNULL(@DataTable,'') <> 'Case')
			BEGIN
				--biuld insert sql string (@SQLSTRING3) to create a new record for the update to the destination mi table
				SET @SQLSTRING3 = 'INSERT INTO ' + @DataTable + '(' + @TABLECOLS + ') SELECT ' + @TABLECOLS + ' FROM ' + @DataTable + ' WHERE ' + @CaseID_Field + ' = ' + CAST(@pCase_CaseID AS NVARCHAR(25)) + ' AND ' + @Inactive_Field + ' = 0'
				--biuld update sql string (@SQLSTRING4) to archive the previous record in the destination mi table
				SET @SQLSTRING4 = N'UPDATE '  + @DataTable + ' SET ' + @Inactive_Field + ' = 1 WHERE ' + @PrimaryKey_Field + ' = (SELECT MIN(' + @PrimaryKey_Field + ') FROM ' + @DataTable + ' WHERE ' + @CaseID_Field + ' = ' + CAST(@pCase_CaseID AS NVARCHAR(25)) + ' AND ' + @Inactive_Field + ' = 0)'
			END

			--biuld sql to update the newly record with the required amendment plus archiving information (create user and date)
			SET @SQLSTRING5 = N'UPDATE ['  + @DataTable + '] SET ' + @DataField + ' = CAST(''' + @PMIFieldValue + ''' AS ' + @DataFieldType + ') WHERE ' + @PrimaryKey_Field + ' = (SELECT MAX(' + @PrimaryKey_Field + ') FROM [' + @DataTable + '] WHERE ' + @CaseID_Field + ' = ' + CAST(@pCase_CaseID AS NVARCHAR(25)) + ')'								
			
			--if the destonation mi table being processed is in casekeydates table
			IF ISNULL(@KeyDateType,'') <> ''
			BEGIN		
				----print '@KeyDateType: ' + isnull(@KeyDateType, '')
				----print '@SQLSTRING1: ' + isnull(@SQLSTRING1, '')
				--extend @SQLSTRING1 to filter on keydate type
				SET @SQLSTRING1 = @SQLSTRING1 + ' AND CaseKeyDates_KeyDatesCode = ''' + @KeyDateType + ''''
				--biuld insert sql string (@SQLSTRING2) for if a record does not already exist in the source table with additional info for Key Date Type
				SET @SQLSTRING2 = N'INSERT INTO '  + @DataTable + '(CaseKeyDates_KeyDatesCode, ' + @DataField + ', ' + @CaseID_Field + ', ' + @Inactive_Field + ', ' + @CreateUser_Field + ', ' + @CreateDate_Field + ') VALUES(''' + @KeyDateType + ''', CAST(''' + @PMIFieldValue + ''' AS ' + @DataFieldType + '), ' + cast(@pCase_CaseID as nvarchar(25)) + ', 0, ''' + @pUser_Name + ''', GETDATE())'				
				--if the destonation mi table being processed is not the case table
				IF (ISNULL(@DataTable,'') <> 'Case')
				BEGIN
					--biuld insert sql string (@SQLSTRING3) to create a new record for the update to the destination mi table (extended with key date type filter on select section)
					SET @SQLSTRING3 = 'INSERT INTO ' + @DataTable + '(' + @TABLECOLS + ') SELECT ' + @TABLECOLS + ' FROM ' + @DataTable + ' WHERE ' + @CaseID_Field + ' = ' + CAST(@pCase_CaseID AS NVARCHAR(25)) + ' AND ' + @Inactive_Field + ' = 0 AND CaseKeyDates_KeyDatesCode = ''' + @KeyDateType + ''''
					--biuld update sql string (@SQLSTRING4) to archive the previous record in the destination mi table (extended with key date type filter on select section)
					SET @SQLSTRING4 = N'UPDATE '  + @DataTable + ' SET ' + @Inactive_Field + ' = 1 WHERE ' + @PrimaryKey_Field + ' = (SELECT MIN(' + @PrimaryKey_Field + ') FROM ' + @DataTable + ' WHERE ' + @CaseID_Field + ' = ' + CAST(@pCase_CaseID AS NVARCHAR(25)) + ' AND ' + @Inactive_Field + ' = 0 AND CaseKeyDates_KeyDatesCode = ''' + @KeyDateType + ''')'
				END
				--biuld sql to update the newly record with the required amendment plus archiving information (create user and date) (extended with key date type)
				SET @SQLSTRING5 = N'UPDATE '  + @DataTable + ' SET ' + @DataField + ' = CAST(''' + @PMIFieldValue + ''' AS ' + @DataFieldType + '), ' + @CreateUser_Field + ' = ''' + @pUser_Name + ''', ' + @CreateDate_Field + ' = GETDATE() WHERE ' + @PrimaryKey_Field + ' = (SELECT ' + @PrimaryKey_Field + ' FROM ' + @DataTable + ' WHERE ' + @CaseID_Field + ' = ' + CAST(@pCase_CaseID AS NVARCHAR(25)) + ' AND ' + @Inactive_Field + ' = 0 AND CaseKeyDates_KeyDatesCode = ''' + @KeyDateType + ''')'
			END
			--else if the destonation mi table being processed is the case table
			ELSE IF (ISNULL(@DataTable,'') <> 'Case')
			BEGIN
				--biuld sql to update the case table with the required amendment (there is no archiving in the case table due to CASE_CASEID being a key field)
				SET @SQLSTRING5 = N'UPDATE '  + @DataTable + ' SET ' + @DataField + ' = CAST(''' + @PMIFieldValue + ''' AS ' + @DataFieldType + '), ' + @CreateUser_Field + ' = ''' + @pUser_Name + ''', ' + @CreateDate_Field + ' = GETDATE() WHERE ' + @PrimaryKey_Field + ' = (SELECT ' + @PrimaryKey_Field + ' FROM ' + @DataTable + ' WHERE ' + @CaseID_Field + ' = ' + CAST(@pCase_CaseID AS NVARCHAR(25)) + ' AND ' + @Inactive_Field + ' = 0)'			
			END
			--execute the record test stored proc outputing to thetest variable
			----print '@SQLSTRING1 = ' + @SQLSTRING1
					
			EXEC sp_executesql @SQLSTRING1, N'@CASEID int out', @RECORDTEST OUT

			--IF NO RECORD EXISTS
			IF @RECORDTEST = 0
			BEGIN
				--EXECUTE SQL STRING TO INSERT UPDATE AS A NEW RECORD IN THE destination mi table 
				--return
				
				-- GV 17/02/2012: added >>>IF @PMIFieldValue <> ''<<< so SQL is not executed if date is empty
				IF (ISNULL(@PMIFieldValue,'') <> '')
				BEGIN
					----print '@SQLSTRING2 = ' + isnull(@SQLSTRING2, '')
					EXEC sp_executesql @SQLSTRING2
				END
			END
			ELSE
			BEGIN
					--IF WE ARE NOT PROCESSING AN UPDATE ON THE CASE TABLE
					IF  (ISNULL(@DataTable,'') <> 'Case')
					BEGIN
						--**UNCOMMENT FOR DEBUG**
						----------print '@SQLSTRING3: ' + @SQLSTRING3

						--INSERT A NEW ROW FOR THE UPDATE AS A CLONE OF THE CURRENT ACTIVE RECORD
						----print '@SQLSTRING3 = ' + @SQLSTRING3
						EXEC sp_executesql @SQLSTRING3
							
						--**UNCOMMENT FOR DEBUG**
						----------print '@SQLSTRING4: ' + @SQLSTRING4

						--SET THE OLDER RECORD AS INACTIVE
						----print '@SQLSTRING4 = ' + @SQLSTRING4
						EXEC sp_executesql @SQLSTRING4

					END
				
					--**UNCOMMENT FOR DEBUG**
					----print '@SQLSTRING5: ' + @SQLSTRING5

					--EITHER UPDATE THE NEWER ACTIVE RECORD WITH ITS NEW VALUE FOR THE DATAFIELD AND ALSO ITS CREATE USER AND CREATE DATE
					--OR UPDATE THE EXISTING RECORD IN THE CASE TABLE 
					EXEC sp_executesql @SQLSTRING5
					------print '@SQLSTRING5 = ' + @SQLSTRING5

			END
		END
		--ELSE WE ARE UPDATING THE PRACTICE MANAGEMENT SYSTEM
		ELSE
		BEGIN
			----------print 'PMS' + isnull(@DataField, '')
			--BIULD SQL STRINGS
			SET @SQLSTRING1 = 'SELECT @Matter_UNO = ISNULL(Matter_UNO, 0) FROM ' + @ADERANTSERVER + '.' + @ADERANTDB + '.DBO.' + @DataTable + ' WHERE Matter_UNO = ' + CAST(@MATTER_UNO AS NVARCHAR(MAX))
			SET @SQLSTRING2 = 'INSERT INTO ' + @ADERANTSERVER + '.' + @ADERANTDB + '.DBO.' + @DataTable + '(MATTER_UNO, ' + @DataField + ', LAST_MODIFIED) VALUES (' + CAST(@MATTER_UNO AS NVARCHAR(MAX)) + ', ''' + @PMIFieldValue + ''', ''' + CAST(GETDATE() AS NVARCHAR(MAX)) + ''')'
			SET @SQLSTRING3 = 'UPDATE ' + @ADERANTSERVER + '.' + @ADERANTDB + '.DBO.' + @DataTable + ' SET ' + @DataField + ' = ''' + @PMIFieldValue + ''', LAST_MODIFIED = ''' + CAST(GETDATE() as nvarchar(max)) + ''' WHERE Matter_UNO = ' + CAST(@MATTER_UNO AS NVARCHAR(MAX))
			
			--execute the record test stored proc outputing to thetest variable
			------print 'PMS @SQLSTRING1 = ' + @SQLSTRING1
			EXEC sp_executesql @SQLSTRING1, N'@Matter_UNO int out', @RECORDTEST OUT
			
			--IF NO RECORD EXISTS
			IF (@RECORDTEST = 0)		
			BEGIN
				--CREATE A NEW ONE WITH VALUE PASSED + MATTER_UNO AND MODIFIED DATE
				----print '@SQLSTRING2: ' + @SQLSTRING2
				EXEC sp_executesql @SQLSTRING2

			END
			--ELSE RECORD EXISTS
			ELSE
			BEGIN
				--UPDATE EXISTING RECORD WITH VALUE PASSED + MODIFIED DATE
				----print '@SQLSTRING3: ' + @SQLSTRING3
				EXEC sp_executesql @SQLSTRING3

			END		
		END
	END TRY

	BEGIN CATCH		
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH
