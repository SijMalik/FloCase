/****** Object:  StoredProcedure [dbo].[MIData_Fetch]    Script Date: 05/08/2012 16:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[MIData_Fetch] 
	@pCase_CaseID						int = 0,
	@pReturn_XML						xml = '' OUTPUT,
	@pUser_Name							nvarchar(255) = '',
	@pGetCosts							Bit = 0,
	@pContactID							INT = 0
AS
BEGIN
	-- =============================================
	-- Author:		GQL
	-- Create date: 18-03-2010
	-- Description:	Stored Procedure to save the data back from the Dynamic Client MI form
	-- GQL AMENDED 05/07/2011 TO ALTER OUTPUT DATATPE ON ADVANCED CALCULATIOSN FROM MONEY TO NVARCHAR(MAX)
	-- =============================================
	
	-- =============================================
	-- Author:		SMJ
	-- Modify date: 03-05-2012
	-- Description:	Changed SP to cater for Claimant MI
	-- =============================================		
	
	--BEGIN SAVE TRANSACTION
	BEGIN TRANSACTION MIDataFetch
	
	--Initialise error trapping
	SET NOCOUNT ON
	SET ARITHABORT ON
	SET DATEFORMAT DMY
	DECLARE @myLastError int 
	SELECT @myLastError = 0
	DECLARE @myLastErrorString nvarchar(255)
	SELECT @myLastErrorString = '' 
	
	--DECLARE VARIABLES
	DECLARE @MaxID AS INT
	DECLARE @MINID AS INT = 1
	DECLARE @KeyDateType AS NVARCHAR(10)
	DECLARE @LKPType AS NVARCHAR(10)
	DECLARE @READONLY AS BIT
	DECLARE @PMSField AS BIT
	DECLARE @DataField AS NVARCHAR(255)
	DECLARE @KDATE AS SMALLDATETIME
	DECLARE @KEYDATEDAY AS INT
	DECLARE @STRKEYDATEDAY AS NVARCHAR(2)
	DECLARE @KEYDATEMONTH AS INT
	DECLARE @STRKEYDATEMONTH AS NVARCHAR(2)
	DECLARE @KEYDATEYEAR AS INT
	DECLARE @MATTER_UNO AS INT
	DECLARE @DataTable AS NVARCHAR(255)
	DECLARE @cOLvAL	 AS NVARCHAR(max)
	DECLARE @pMIFieldDefinition_MIFieldCode AS NVARCHAR(255)
	DECLARE @pClientMIFieldSet_ClientMIFieldSetID AS INT
	DECLARE @DataFieldType AS NVARCHAR(255)
	DECLARE @CaseID_Field AS NVARCHAR(255)
	DECLARE @Inactive_Field AS NVARCHAR(255)
	DECLARE @CreateDate_Field AS NVARCHAR(255)
	DECLARE @CreateUser_Field AS NVARCHAR(255)
	DECLARE @PrimaryKey_Field AS NVARCHAR(255)
	DECLARE @SQLSTRING1 AS NVARCHAR(MAX)
	DECLARE @pMIFieldSetID int
	DECLARE @pCaseID int
	DECLARE @PCalcVal MONEY
	DECLARE @ContactID_Field AS NVARCHAR(255)

	--Declare the temporty table that will be used to map the mi fields to there current data values
	DECLARE @TEMPTABLE1 TABLE
	(
		ResultID					INT IDENTITY,
		FSID						INT,
		FIELDCODE					nvarchar(255),
		RDONLY						bit,
		COLVALUE					nvarchar(255),
		PMSField					bit
	)
	IF @pGetCosts = 1
	BEGIN
		INSERT INTO @TEMPTABLE1(FSID, FIELDCODE, RDONLY, PMSField)
		SELECT cf.ClientMIFieldSet_ClientMIFieldSetID, mf.MIFieldDefinition_MIFieldCode, cf.ClientMIFieldSet_MIFieldRO, mf.MIFieldDefinition_AderantField
		FROM [Case] c LEFT OUTER JOIN
		ClientMIDefinition cm ON cm.ClientMIDefinition_WORKTYPECODE = 'COSTS' and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
		ClientMIFieldSet cf ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 INNER JOIN
		MIFieldDefinition mf ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0
		WHERE c.Case_CaseID = @pCase_CaseID and mf.MIFieldDefinition_DataField <> 'n/a' and ISNULL(mf.MIFieldDefinition_DataField,'') <> ''
		AND c.Case_CostsAssgn = 1
	END
	ELSE
	BEGIN
		--DOES THE MATTER HAVE A CLIENT NUMBER DATASET
		IF EXISTS(SELECT ClientMIDefinition_ClientMIDefinitionID FROM ClientMIDefinition WHERE ClientMIDefinition_CLIENTCODE = (SELECT Case_ClientCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID))
		BEGIN
			--DOES THE MATTER HAVE A COMBO CLIENT NUMBER AND WORKTYPE DATASET
			IF EXISTS(SELECT ClientMIDefinition_ClientMIDefinitionID FROM ClientMIDefinition WHERE ClientMIDefinition_WORKTYPECODE = (SELECT Case_WorkTypeCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID) AND ClientMIDefinition_CLIENTCODE = (SELECT Case_ClientCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID))
			BEGIN
				--uncomment for debug
				----PRINT 'Client number and Worktype'
				--Populate the Tempory table with the MI fields FOR THE COMBO CLIENT NUMBER AND WORKTYPE DATASET
				INSERT INTO @TEMPTABLE1(FSID, FIELDCODE, RDONLY, PMSField)
				SELECT cf.ClientMIFieldSet_ClientMIFieldSetID, mf.MIFieldDefinition_MIFieldCode, cf.ClientMIFieldSet_MIFieldRO, mf.MIFieldDefinition_AderantField
				FROM [Case] c INNER JOIN
				ClientMIDefinition cm ON c.Case_ClientCode = cm.ClientMIDefinition_CLIENTCODE and c.Case_WorkTypeCode = cm.ClientMIDefinition_WORKTYPECODE and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
				ClientMIFieldSet cf ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 INNER JOIN
				MIFieldDefinition mf ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0
				WHERE c.Case_CaseID = @pCase_CaseID and mf.MIFieldDefinition_DataField <> 'n/a' and ISNULL(mf.MIFieldDefinition_DataField,'') <> ''	
			END
			ELSE		
			BEGIN
				--uncomment for debug
				----PRINT 'Client number only'
				--Populate the Tempory table with the MI fields FOR THE CLIENT NUMBER DATASET
				INSERT INTO @TEMPTABLE1(FSID, FIELDCODE, RDONLY, PMSField)
				SELECT cf.ClientMIFieldSet_ClientMIFieldSetID, mf.MIFieldDefinition_MIFieldCode, cf.ClientMIFieldSet_MIFieldRO, mf.MIFieldDefinition_AderantField
				FROM [Case] c INNER JOIN
				ClientMIDefinition cm ON c.Case_ClientCode = cm.ClientMIDefinition_CLIENTCODE and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
				ClientMIFieldSet cf ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 INNER JOIN
				MIFieldDefinition mf ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0
				WHERE c.Case_CaseID = @pCase_CaseID and mf.MIFieldDefinition_DataField <> 'n/a' and ISNULL(mf.MIFieldDefinition_DataField,'') <> ''	
			END
		END
		ELSE	
		BEGIN
			--DOES THE MATTER HAVE A CLIENT GROUP DATASET
			IF EXISTS(SELECT * FROM ClientMIDefinition WHERE ClientMIDefinition_CLIENTGROUPCODE = (SELECT Case_GroupCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID))
			BEGIN
				--DOES THE MATTER HAVE A COMBO CLIENT GROUP AND WORKTYPE DATASET
				IF EXISTS(SELECT ClientMIDefinition_ClientMIDefinitionID FROM ClientMIDefinition WHERE ClientMIDefinition_WORKTYPECODE = (SELECT Case_WorkTypeCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID) AND ClientMIDefinition_CLIENTGROUPCODE = (SELECT Case_GroupCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID))
				BEGIN
					--uncomment for debug
					----PRINT 'Group code and Worktype'
					--Populate the Tempory table with the MI fields FOR THE COMBO CLIENT GROUP AND WORKTYPE DATASET
					INSERT INTO @TEMPTABLE1(FSID, FIELDCODE, RDONLY, PMSField)
					SELECT cf.ClientMIFieldSet_ClientMIFieldSetID, mf.MIFieldDefinition_MIFieldCode, cf.ClientMIFieldSet_MIFieldRO, mf.MIFieldDefinition_AderantField
					FROM [Case] c INNER JOIN
					ClientMIDefinition cm ON c.Case_GroupCode = cm.ClientMIDefinition_CLIENTGROUPCODE and c.Case_WorkTypeCode = cm.ClientMIDefinition_WORKTYPECODE and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
					ClientMIFieldSet cf ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 INNER JOIN
					MIFieldDefinition mf ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0
					WHERE c.Case_CaseID = @pCase_CaseID and mf.MIFieldDefinition_DataField <> 'n/a' and ISNULL(mf.MIFieldDefinition_DataField,'') <> ''	
				END
				ELSE		
				BEGIN
					--uncomment for debug
					----PRINT 'Group Code only'
					--return
					--Populate the Tempory table with the MI fields FOR THE CLIENT GROUP DATASET
						IF @pContactID > 0
						BEGIN
							--uncomment for debug
							----PRINT 'Group Code only'
							--Populate the Tempory table with the MI fields FOR THE CLIENT GROUP DATASET
							INSERT INTO @TEMPTABLE1(FSID, FIELDCODE, RDONLY, PMSField)
							SELECT cf.ClientMIFieldSet_ClientMIFieldSetID, mf.MIFieldDefinition_MIFieldCode, cf.ClientMIFieldSet_MIFieldRO, mf.MIFieldDefinition_AderantField
							FROM [Case] c INNER JOIN
							ClientMIDefinition cm ON c.Case_GroupCode = cm.ClientMIDefinition_CLIENTGROUPCODE and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
							ClientMIFieldSet cf ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 INNER JOIN
							MIFieldDefinition mf ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0
							WHERE c.Case_CaseID = @pCase_CaseID 
							and mf.MIFieldDefinition_DataField <> 'n/a' and ISNULL(mf.MIFieldDefinition_DataField,'') <> ''				
							AND cm.ClientMIDefinition_IsClaimant = 1
						END
						ELSE
						BEGIN
							INSERT INTO @TEMPTABLE1(FSID, FIELDCODE, RDONLY, PMSField)
							SELECT cf.ClientMIFieldSet_ClientMIFieldSetID, mf.MIFieldDefinition_MIFieldCode, cf.ClientMIFieldSet_MIFieldRO, mf.MIFieldDefinition_AderantField
							FROM [Case] c INNER JOIN
							ClientMIDefinition cm ON c.Case_GroupCode = cm.ClientMIDefinition_MIDEFCODE and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
							ClientMIFieldSet cf ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 INNER JOIN
							MIFieldDefinition mf ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0
							WHERE c.Case_CaseID = @pCase_CaseID and mf.MIFieldDefinition_DataField <> 'n/a' and ISNULL(mf.MIFieldDefinition_DataField,'') <> ''
						END
				END
			END
			ELSE
			BEGIN
				--uncomment for debug
				----PRINT 'Worktype only'
				--Populate the Tempory table with the MI fields FOR THE WORKTYPE DATASET
				INSERT INTO @TEMPTABLE1(FSID, FIELDCODE, RDONLY, PMSField)
				SELECT cf.ClientMIFieldSet_ClientMIFieldSetID, mf.MIFieldDefinition_MIFieldCode, cf.ClientMIFieldSet_MIFieldRO, mf.MIFieldDefinition_AderantField
				FROM [Case] c INNER JOIN
				ClientMIDefinition cm ON c.Case_WorkTypeCode = cm.ClientMIDefinition_WORKTYPECODE and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
				ClientMIFieldSet cf ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 INNER JOIN
				MIFieldDefinition mf ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0
				WHERE c.Case_CaseID = @pCase_CaseID and mf.MIFieldDefinition_DataField <> 'n/a' and ISNULL(mf.MIFieldDefinition_DataField,'') <> ''
			END
		END
	END
		
	--Get the maximum id value in the tempory table (for use in the while loop below)
	SELECT @MaxID = MAX(ResultID) FROM @TEMPTABLE1 
	

	--loop through the all the required mi fields
	WHILE @MINID <= @MaxID 
	BEGIN

		DECLARE @FIELDTYPE AS NVARCHAR(255)
				
		SELECT @pMIFieldDefinition_MIFieldCode = FIELDCODE, 
		@READONLY = RDONLY,
		@PMSField = PMSField,
		@pClientMIFieldSet_ClientMIFieldSetID = FSID 
		FROM @TEMPTABLE1
		 
		WHERE ResultID = @MINID

		SELECT @FIELDTYPE = MIFieldDefinition_MIFieldTypeCode 
		FROM MIFieldDefinition 
		WHERE MIFieldDefinition_MIFieldCode = @pMIFieldDefinition_MIFieldCode 

		----------PRINT '@pMIFieldDefinition_MIFieldCode = ' + @pMIFieldDefinition_MIFieldCode
		
		--GET THE DATASOURCE TABLE AND COLUMN OF THE FIELDCODE PASSED TO THE STORED PROCEDURE		
		SELECT @DataField = [MIFieldDefinition_DataField],
				@DataTable = [MIFieldDefinition_DataTable],
				@KeyDateType = [MIFieldDefinition_KeyDateType],
				@LKPType = MIFieldDefinition_MILKPFieldCode 
		FROM [MIFieldDefinition] M
		WHERE M.MIFieldDefinition_MIFieldCode = @pMIFieldDefinition_MIFieldCode
		--**UNCOMMENT FOR DEBUG**
		----PRINT '@pMIFieldDefinition_MIFieldCode = ' + @pMIFieldDefinition_MIFieldCode
		----PRINT '@DataField = ' + @DataField
		----PRINT '@DataTable = ' + @DataTable
		----PRINT '@KeyDateType = ' + @KeyDateType
	
		IF ISNULL(@PMSField, 0) = 0
		BEGIN	
			--GET THE PHYSICAL FIELD TYPE OF THE MI FIELD USING THE DERIVED DATASOURCE TABLE AND COLUMN
						
			SELECT @DataFieldType = x.name   
			FROM sysobjects o inner join 
			syscolumns c on o.id = c.id inner join 
			systypes x on c.xtype = x.xtype 
			WHERE o.name = @DataTable and c.name = @DataField and x.name <> 'sysname'
			--**UNCOMMENT FOR DEBUG**
			----------PRINT '@DataFieldType = ' + @DataFieldType

			--GET THE CASEID COLUMN OF THE MI FIELDS DATASOURCE TABLE
			SELECT @CaseID_Field =  c.name  
			FROM sysobjects o inner join 
			syscolumns c on o.id = c.id 
			WHERE o.name = @DataTable and c.name like '%CaseID'
			
			IF ISNULL(@pContactID,0) > 0
			BEGIN
				SELECT @ContactID_Field =  c.name  
				FROM sysobjects o inner join 
				syscolumns c on o.id = c.id 
				WHERE o.name = @DataTable and c.name like '%ContactID'
			END
			--**UNCOMMENT FOR DEBUG**
			
			----PRINT '@CaseID_Field = ' + @CaseID_Field + ' '  + @DataTable
			
			--GET THE INACTIVE COLUMN OF THE MI FIELDS DATASOURCE TABLE
			SELECT @Inactive_Field = c.name  
			FROM sysobjects o inner join 
			syscolumns c on o.id = c.id 
			WHERE o.name = @DataTable and c.name like '%InActive'
			--**UNCOMMENT FOR DEBUG**
			----------PRINT '@Inactive_Field = ' + @Inactive_Field
			
			--GET THE CREATEDATE COLUMN OF THE MI FIELDS DATASOURCE TABLE
			SELECT @CreateDate_Field = c.name  
			FROM sysobjects o inner join 
			syscolumns c on o.id = c.id 
			WHERE o.name = @DataTable and (c.name like '%CreateDate' OR c.name like '%ModifiedDate')
			--**UNCOMMENT FOR DEBUG**
			----------PRINT '@CreateDate_Field = ' + @CreateDate_Field
			
			--GET THE CREATEUSER COLUMN OF THE MI FIELDS DATASOURCE TABLE
			SELECT @CreateUser_Field = c.name  
			FROM sysobjects o inner join 
			syscolumns c on o.id = c.id 
			WHERE o.name = @DataTable and (c.name like '%CreateUser' OR c.name like '%ModifiedBy')
			--**UNCOMMENT FOR DEBUG**
			----------PRINT '@CreateUser_Field = ' + @CreateUser_Field
			
			--GET THE PRIMARY KEY OF THE MI FIELDS DATASOURCE TABLE
			SELECT @PrimaryKey_Field = c.name
			FROM sysobjects o inner join 
			syscolumns c on o.id = c.id 
			WHERE o.name = @DataTable
			and c.name in (
				SELECT COLUMN_NAME = c.name
				FROM sysobjects o, sysindexes x, syscolumns c, sysindexkeys xk
				WHERE o.type = 'U'
				and x.id = o.id
				and o.id = c.id
				and o.id = xk.id
				and x.indid = xk.indid
				and c.colid = xk.colid
				and x.status = 2066)
			--**UNCOMMENT FOR DEBUG**
			----------PRINT '@PrimaryKey_Field = ' + @PrimaryKey_Field
			----------PRINT '*******************************************'
			
			--TEST FOR ERRORS
			IF (ISNULL(@DataField,'') = '')
			BEGIN
				SET @myLastErrorString = 'Unable to find a valid Data Field for given MI field with code ' + @pMIFieldDefinition_MIFieldCode
				GOTO THROW_ERROR_UPWARDS	
			END
			IF (ISNULL(@DataTable,'') = '')
			BEGIN
				SET @myLastErrorString = 'Unable to find a valid Data Table for given MI field with code ' + @pMIFieldDefinition_MIFieldCode
				GOTO THROW_ERROR_UPWARDS	
			END
			IF (ISNULL(@KeyDateType, '') = '') AND @DataTable = 'CaseKeyDates'
			BEGIN
				SET @myLastErrorString = 'YOU MUST PROVIDE A KEY DATES TYPE WHEN USING THE CASEKEYDATES TABLE'
				GOTO THROW_ERROR_UPWARDS	
			END
			IF (ISNULL(@DataFieldType,'') = '')
			BEGIN
				SET @myLastErrorString = 'Unable to find a valid Data Field Type for given MI field ' + @DataField + ' in table ' + @DataTable 
				GOTO THROW_ERROR_UPWARDS	
			END
			IF (ISNULL(@CaseID_Field,'') = '')
			BEGIN
				SET @myLastErrorString = 'Unable to find a valid CaseID Field in table ' + @DataTable
				GOTO THROW_ERROR_UPWARDS	
			END
			IF (ISNULL(@Inactive_Field,'') = '') AND (ISNULL(@DataTable,'') <> 'Case')
			BEGIN
				SET @myLastErrorString = 'Unable to find a valid Inactive Field in table ' + @DataTable
				GOTO THROW_ERROR_UPWARDS	
			END
			IF (ISNULL(@CreateDate_Field,'') = '') AND (ISNULL(@DataTable,'') <> 'Case')
			BEGIN
				SET @myLastErrorString = 'Unable to find a valid Create Date Field in table ' + @DataTable
				GOTO THROW_ERROR_UPWARDS	
			END
			IF (ISNULL(@CreateUser_Field,'') = '') AND (ISNULL(@DataTable,'') <> 'Case')
			BEGIN
				SET @myLastErrorString = 'Unable to find a valid Create User Field in table ' + @DataTable
				GOTO THROW_ERROR_UPWARDS	
			END
			IF (ISNULL(@PrimaryKey_Field,'') = '')
			BEGIN
				SET @myLastErrorString = 'Unable to find a valid Primary Key in table ' + @DataTable
				GOTO THROW_ERROR_UPWARDS	
			END
			
			--reset column value
			SET @cOLvAL = ''
			
			--IF THE FIELD BEING PASSED IS NOT A BLANK SPACER OR A LABEL
			IF @pMIFieldDefinition_MIFieldCode <> 'BLANK' OR @pMIFieldDefinition_MIFieldCode <> 'LBLBLNK'
			BEGIN
				--IF THE CURRENT MI FIELD HAS A CALCULATION ATTACHED TO IT
				IF EXISTS(SELECT * FROM ClientMIFieldSetCalc WHERE ClientMIFieldSetCalc_ClientMIFieldSetField = (SELECT ClientMIFieldSet_ClientMIDEFCODE + ClientMIFieldSet_MIFieldDefCode FROM ClientMIFieldSet WHERE ClientMIFieldSet_ClientMIFieldSetID = @pClientMIFieldSet_ClientMIFieldSetID))
				BEGIN
				
					-- EXECUTE A STORED PROCEDURE TO RETRIEVE THE VALUE OF THE RESULT OF THE ATTACHED CALCULATION.
					EXEC [ClientMIFieldSet_ProcessCalculation] 
					   @pClientMIFieldSet_ClientMIFieldSetID
					  ,@pCase_CaseID
					  ,@cOLvAL OUTPUT
				END
				ELSE
				BEGIN
					--IF THE CURRENT MI FIELD HAS An Advanced CALCULATION ATTACHED TO IT
					IF EXISTS(SELECT * FROM ClientMIFieldSetAdvCalc WHERE ClientMIFieldSetAdvCalc_ClientMIFieldSetField = (SELECT ClientMIFieldSet_ClientMIDEFCODE + ClientMIFieldSet_MIFieldDefCode FROM ClientMIFieldSet WHERE ClientMIFieldSet_ClientMIFieldSetID = @pClientMIFieldSet_ClientMIFieldSetID))
					BEGIN
						EXECUTE .[dbo].[ClientMIFieldSet_ProcessAdvCalculation] 
						   @pClientMIFieldSet_ClientMIFieldSetID
						  ,@pCase_CaseID
						  ,@cOLvAL OUTPUT,
						   @pContactID
					END
					ELSE
					BEGIN
						IF ISNULL(@ContactID_Field, '') = ''
						BEGIN
							--if the field isnt a key date
							IF ISNULL(@KeyDateType,'') = '' AND @DataFieldType <> 'smalldatetime'
							BEGIN
								--if the field isnt a readonly lookup
								IF ISNULL(@LKPType,'') = '' OR @READONLY = 0
								BEGIN
									IF  (ISNULL(@DataTable,'') <> 'Case')
									BEGIN
										SET @SQLSTRING1 = 'SELECT @VAL = ISNULL(CAST(' + @DataField + ' AS NVARCHAR(MAX)),'''') FROM [' + @DataTable + '] WHERE ' + @CaseID_Field + ' = ' + CAST(@pCase_CaseID AS NVARCHAR(25)) + ' AND ' + @Inactive_Field + ' = 0'
									END
									ELSE
									BEGIN
										SET @SQLSTRING1 = 'SELECT @VAL = ISNULL(CAST(' + @DataField + ' AS NVARCHAR(MAX)),'''') FROM [' + @DataTable + '] WHERE ' + @CaseID_Field + ' = ' + CAST(@pCase_CaseID AS NVARCHAR(25))
									END
									----------PRINT @SQLSTRING1
									EXEC sp_executesql @SQLSTRING1,
														N'@VAL NVARCHAR(MAX) out',
														@cOLvAL OUT
														
									----------PRINT @cOLvAL					
								END
								ELSE
								BEGIN
									IF  (ISNULL(@DataTable,'') <> 'Case')
									BEGIN
										SET @SQLSTRING1 = 'SELECT @VAL = ISNULL(CAST(MILookupFieldDefinition_DisplayField AS NVARCHAR(MAX)),'''') FROM MILookupFieldDefinition INNER JOIN [' + @DataTable + '] ON MILookupFieldDefinition.MILookupFieldDefinition_MILookupItemCode = [' + @DataTable + '].' + @DataField + ' WHERE [' + @DataTable + '].' + @CaseID_Field + ' = ' + CAST(@pCase_CaseID AS NVARCHAR(25)) + ' AND [' + @DataTable + '].' + @Inactive_Field + ' = 0'
									END
									ELSE
									BEGIN
										SET @SQLSTRING1 = 'SELECT @VAL = ISNULL(CAST(MILookupFieldDefinition_DisplayField AS NVARCHAR(MAX)),'''') FROM MILookupFieldDefinition INNER JOIN [' + @DataTable + '] ON MILookupFieldDefinition.MILookupFieldDefinition_MILookupItemCode = [' + @DataTable + '].' + @DataField + ' WHERE [' + @DataTable + '].' + @CaseID_Field + ' = ' + CAST(@pCase_CaseID AS NVARCHAR(25))
									END						
									----------PRINT @SQLSTRING1
									EXEC sp_executesql @SQLSTRING1,
														N'@VAL NVARCHAR(MAX) out',
														@cOLvAL OUT
								END											
							END
							ELSE
							BEGIN
								SET @KDATE = ''
								IF ISNULL(@KeyDateType,'') <> ''
								BEGIN
									SET @SQLSTRING1 = 'SELECT @VAL = ISNULL(' + @DataField + ','''') FROM [' + @DataTable + '] WHERE ' + @CaseID_Field + ' = ' + CAST(@pCase_CaseID AS NVARCHAR(25)) + ' AND ' + @Inactive_Field + ' = 0 AND CaseKeyDates_KeyDatesCode = ''' + @KeyDateType + ''''
								END
								ELSE
								BEGIN
									IF  (ISNULL(@DataTable,'') <> 'Case')
									BEGIN
										SET @SQLSTRING1 = 'SELECT @VAL = ISNULL(' + @DataField + ','''') FROM [' + @DataTable + '] WHERE ' + @CaseID_Field + ' = ' + CAST(@pCase_CaseID AS NVARCHAR(25)) + ' AND ' + @Inactive_Field + ' = 0'
									END
									ELSE
									BEGIN
										SET @SQLSTRING1 = 'SELECT @VAL = ISNULL(' + @DataField + ','''') FROM [' + @DataTable + '] WHERE ' + @CaseID_Field + ' = ' + CAST(@pCase_CaseID AS NVARCHAR(25))
									END					
									----------PRINT @SQLSTRING1
								END
								--TEST TO SEE IF A RECORD EXISTS FOR THIS MATTER IN THE EFFECTED MI DATA TABLE
								----------PRINT @SQLSTRING1
								EXEC sp_executesql @SQLSTRING1,
													N'@VAL SMALLDATETIME out',
													@KDATE OUT
								
								----------PRINT @KDATE					
								IF ISNULL(@KDATE,'') <> ''
								BEGIN
									
									SET @KEYDATEDAY = DATEPART(DAY,@KDATE)
									SET @KEYDATEMONTH  = DATEPART(MONTH,@KDATE)
									SET @KEYDATEYEAR = DATEPART(YEAR,@KDATE)
									
									IF @KEYDATEDAY < 10
									BEGIN
										SET @STRKEYDATEDAY = '0' + CAST(@KEYDATEDAY AS NVARCHAR(2))
									END
									ELSE
									BEGIN
										SET @STRKEYDATEDAY = CAST(@KEYDATEDAY AS NVARCHAR(2))
									END
									IF @KEYDATEMONTH < 10
									BEGIN
										SET @STRKEYDATEMONTH = '0' + CAST(@KEYDATEMONTH AS NVARCHAR(2))
									END
									ELSE
									BEGIN
										SET @STRKEYDATEMONTH = CAST(@KEYDATEMONTH AS NVARCHAR(2))
									END
									SET @cOLvAL = @STRKEYDATEDAY + '/' + @STRKEYDATEMONTH + '/' + CAST(@KEYDATEYEAR AS NVARCHAR(4))	
								END
								ELSE
								BEGIN	
									SET @cOLvAL = ''
								END																							
							END
						END
						ELSE
						BEGIN
							SET @SQLSTRING1 = 'SELECT @VAL = ISNULL(CAST(' + @DataField + ' AS NVARCHAR(MAX)),'''') FROM [' + @DataTable + '] WHERE ' + @CaseID_Field + ' = ' + CAST(@pCase_CaseID AS NVARCHAR(25)) + ' AND ' + @Inactive_Field + ' = 0 AND ' + @ContactID_Field + ' = ' + CAST(@pContactID AS NVARCHAR(25))
							
							IF @DataFieldType <> 'smalldatetime'
							BEGIN
								EXEC sp_executesql @SQLSTRING1,
									N'@VAL NVARCHAR(MAX) out',
									@cOLvAL OUT
							END
							ELSE
							BEGIN
								EXEC sp_executesql @SQLSTRING1,
									N'@VAL SMALLDATETIME out',
									@KDATE OUT
							END
							IF ISNULL(@KDATE,'') <> ''
							BEGIN
								
								SET @KEYDATEDAY = DATEPART(DAY,@KDATE)
								SET @KEYDATEMONTH  = DATEPART(MONTH,@KDATE)
								SET @KEYDATEYEAR = DATEPART(YEAR,@KDATE)
								
								IF @KEYDATEDAY < 10
								BEGIN
									SET @STRKEYDATEDAY = '0' + CAST(@KEYDATEDAY AS NVARCHAR(2))
								END
								ELSE
								BEGIN
									SET @STRKEYDATEDAY = CAST(@KEYDATEDAY AS NVARCHAR(2))
								END
								IF @KEYDATEMONTH < 10
								BEGIN
									SET @STRKEYDATEMONTH = '0' + CAST(@KEYDATEMONTH AS NVARCHAR(2))
								END
								ELSE
								BEGIN
									SET @STRKEYDATEMONTH = CAST(@KEYDATEMONTH AS NVARCHAR(2))
								END
								SET @cOLvAL = @STRKEYDATEDAY + '/' + @STRKEYDATEMONTH + '/' + CAST(@KEYDATEYEAR AS NVARCHAR(4))	
							END
						END
					END
				END
					
				----PRINT @SQLSTRING1											
				UPDATE @TEMPTABLE1 SET COLVALUE = ISNULL(@cOLvAL,'') WHERE ResultID = @MINID 
				
				SELECT @KDATE = NULL, @cOLvAL = NULL
				
			END
		END
		--ELSE PMS FIELD
		ELSE
		BEGIN
			select @cOLvAL = Null
			
			SELECT @MATTER_UNO = ISNULL(AExpert_MatterUno, 0)
			FROM ApplicationInstance 
			WHERE CaseID = @pCase_CaseID
			
			SELECT @SQLSTRING1 = 'SELECT @VAL = ISNULL(CAST(' + @DataField + ' AS NVARCHAR(MAX)), '''') FROM ' + @DataTable + ' WHERE MATTER_UNO = ' + CAST(@MATTER_UNO AS NVARCHAR(MAX))
			----PRINT @SQLSTRING1
			EXEC sp_executesql @SQLSTRING1,
				N'@VAL NVARCHAR(MAX) out',
				@cOLvAL OUT
			
			IF @FIELDTYPE = 'MIDTEINP' and ISNULL(@cOLvAL, '') <> ''
			BEGIN
				SET @KEYDATEDAY = ISNULL(DATEPART(DAY,CAST(@cOLvAL AS SMALLDATETIME)), 1)
				SET @KEYDATEMONTH  = ISNULL(DATEPART(MONTH,CAST(@cOLvAL AS SMALLDATETIME)), 1)
				SET @KEYDATEYEAR = ISNULL(DATEPART(YEAR,CAST(@cOLvAL AS SMALLDATETIME)), 1900)
				
				IF @KEYDATEDAY < 10
				BEGIN 
					SET @cOLvAL = '0' + CAST(@KEYDATEDAY AS NVARCHAR(2)) + '/'
				END
				ELSE
				BEGIN 
					SET @cOLvAL = CAST(@KEYDATEDAY AS NVARCHAR(2)) + '/' 
				END
				
				IF @KEYDATEMONTH < 10
				BEGIN 
					SET @cOLvAL = @cOLvAL + '0' + CAST(@KEYDATEMONTH AS NVARCHAR(2)) + '/' 
				END
				ELSE
				BEGIN 
					SET @cOLvAL = @cOLvAL + CAST(@KEYDATEMONTH AS NVARCHAR(2)) + '/' 
				END
				
				SET @cOLvAL = @cOLvAL + CAST(@KEYDATEYEAR AS NVARCHAR(4))
			END
			----PRINT @SQLSTRING1	
			UPDATE @TEMPTABLE1 SET COLVALUE = ISNULL(@cOLvAL,'') WHERE ResultID = @MINID
		END
		SET @MINID = @MINID + 1
	END
	
	SET @pReturn_XML = (SELECT *
						FROM @TEMPTABLE1 
						FOR XML AUTO, ELEMENTS, ROOT('MIDATA'))
	
	--uncoment for debug					
	----------PRINT cast(@pReturn_XML as nvarchar(max))
						
	--Test for errors
	SELECT @myLastError = @@ERROR
	IF @myLastError <> 0 GOTO THROW_ERROR_UPWARDS
	
	COMMIT TRANSACTION MIDataFetch
		
	THROW_ERROR_UPWARDS:
	IF (@myLastError <> 0 ) OR (@myLastErrorString <> '')
	BEGIN
		ROLLBACK TRANSACTION MIDataFetch
		SET @myLastErrorString = 'Error Occurred In Stored Procedure MIData_Fetch - ' + @myLastErrorString
		RAISERROR (@myLastErrorString, 16,1)
	END
	
END







