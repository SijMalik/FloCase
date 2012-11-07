USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[ClientMIFieldSet_ProcessForSave]    Script Date: 09/24/2012 15:52:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[ClientMIFieldSet_ProcessForSave] 
	@pMIData							xml = '',
	@pGetCosts							bit = 0	,
	@pContactID							INT = 0,
	@pIsClaimant						bit = 0
AS
BEGIN
	-- =============================================
	-- Author:		GQL
	-- Create date: 26-02-2010
	-- Modified by Ross Hannah 16/03/2011 to improve performace
	-- Description:	Stored Procedure to process the save data from the Dynamic Client MI form passed as XML
	-- Modified by GQL 27/06/2011 to handle the saving of data back to Aderant Expert PMS 
	-- =============================================
	
	-- =============================================
	-- Author:		SMJ
	-- Modify date: 11/04/2012
	-- Description:	Handle passing in of no XML data - Return ''
	--				Changed error handling as well
	-- =============================================	

	-- =============================================
	-- Author:		SMJ
	-- Modify date: 20-04-2012
	-- Description:	Changed SP to cater for Claimant MI
	-- =============================================	
	
	-- =============================================
	-- Author:		SMJ
	-- Modify date: 23-08-2012
	-- Description:	Changed SP to cater for read/write fields
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
	--DECLARE AND INITIALISE LOCAL VARIABLES
	DECLARE @CaseID INT
	Declare @pUserName VARCHAR(255)
	DECLARE @pMIDEFCODE VARCHAR(255)
	DECLARE @errNoXML VARCHAR(50)

	SET @errNoXML = 'No MI Data passed in.'
	
	BEGIN TRY

		--SMJ 11/04/2012
		--CHECK SOME MI DATA HAS BEEN PASSSED IN:
		IF  convert(nvarchar(max),@pMIData) = ''
		BEGIN
			RAISERROR('No MI Data passed in.', 16, 1)
		END
		--SMJ
		
		--RPM 
		DECLARE @tempVal nvarchar(max)
		SET @tempVal = convert(nvarchar(max),@pMIData) 
		
		SET @tempVal = REPLACE(@tempVal,'%60','<')
		SET @tempVal = REPLACE(@tempVal,'%62','>')
		
		SET @pMIData = convert(xml,@tempVal) 
			--RETRIEVE MATTER LEVEL DATA FROM THE PASSED XML STRUCTURE
			SELECT @CaseID = x.value('CASEID[1]', 'int') 
			FROM @pMIData.nodes('/MISAVE[position()=1]') e(x)
			SELECT @pUserName = x.value('USERNAME[1]', 'nvarchar(255)') 
			FROM @pMIData.nodes('/MISAVE[position()=1]') e(x)
		
		--**UNCOMMENT FOR DEBUG**
		--PRINT @CaseID
		--PRINT @pUserName
		
		--GET MIDEFCODE
		IF @pGetCosts = 1
			BEGIN
				SELECT @pMIDEFCODE = cm.ClientMIDefinition_MIDEFCODE 
				FROM dbo.[Case] c WITH (NOLOCK) INNER JOIN
				dbo.ClientMIDefinition cm WITH (NOLOCK) ON cm.ClientMIDefinition_WORKTYPECODE = 'COSTS' and cm.ClientMIDefinition_Inactive = 0
				WHERE c.Case_CaseID = @CaseID
				AND c.Case_CostsAssgn = 1			
			END
		ELSE
		BEGIN
		IF EXISTS(SELECT ClientMIDefinition_ClientMIDefinitionID FROM dbo.ClientMIDefinition WITH (NOLOCK) WHERE ClientMIDefinition_CLIENTCODE = (SELECT Case_ClientCode FROM dbo.[CASE] WITH (NOLOCK) WHERE Case_CaseID = @CaseID))
		BEGIN
			--DOES THE MATTER HAVE A COMBO CLIENT NUMBER AND WORKTYPE DATASET
			IF EXISTS(SELECT ClientMIDefinition_ClientMIDefinitionID FROM dbo.ClientMIDefinition WITH (NOLOCK) WHERE ClientMIDefinition_WORKTYPECODE = (SELECT Case_WorkTypeCode FROM dbo.[CASE] WITH (NOLOCK) WHERE Case_CaseID = @CaseID) AND ClientMIDefinition_CLIENTCODE = (SELECT Case_ClientCode FROM dbo.[CASE] WITH (NOLOCK) WHERE Case_CaseID = @CaseID))
			BEGIN
				SELECT @pMIDEFCODE = cm.ClientMIDefinition_MIDEFCODE 
				FROM dbo.[Case] c WITH (NOLOCK) INNER JOIN
				dbo.ClientMIDefinition cm WITH (NOLOCK) ON c.Case_ClientCode = cm.ClientMIDefinition_CLIENTCODE and c.Case_WorkTypeCode = cm.ClientMIDefinition_WORKTYPECODE and cm.ClientMIDefinition_Inactive = 0
				WHERE c.Case_CaseID = @CaseID
			END
			ELSE		
			BEGIN
				SELECT @pMIDEFCODE = cm.ClientMIDefinition_MIDEFCODE 
				FROM dbo.[Case] c WITH (NOLOCK) INNER JOIN
				dbo.ClientMIDefinition cm WITH (NOLOCK) ON c.Case_ClientCode = cm.ClientMIDefinition_CLIENTCODE and cm.ClientMIDefinition_Inactive = 0
				WHERE c.Case_CaseID = @CaseID
			END
		END
		ELSE	
		BEGIN
			--DOES THE MATTER HAVE A CLIENT GROUP DATASET
			IF EXISTS(SELECT * FROM dbo.ClientMIDefinition WITH (NOLOCK) WHERE ClientMIDefinition_CLIENTGROUPCODE = (SELECT Case_GroupCode FROM dbo.[CASE] WITH (NOLOCK) WHERE Case_CaseID = @CaseID))
			BEGIN
				--DOES THE MATTER HAVE A COMBO CLIENT GROUP AND WORKTYPE DATASET
				IF EXISTS(SELECT ClientMIDefinition_ClientMIDefinitionID FROM dbo.ClientMIDefinition WITH (NOLOCK) WHERE ClientMIDefinition_WORKTYPECODE = (SELECT Case_WorkTypeCode FROM dbo.[CASE] WITH (NOLOCK) WHERE Case_CaseID = @CaseID) AND ClientMIDefinition_CLIENTGROUPCODE = (SELECT Case_GroupCode FROM dbo.[CASE] WITH (NOLOCK) WHERE Case_CaseID = @CaseID))
				BEGIN
					SELECT @pMIDEFCODE = cm.ClientMIDefinition_MIDEFCODE 
					FROM dbo.[Case] c WITH (NOLOCK) INNER JOIN
					dbo.ClientMIDefinition cm WITH (NOLOCK) ON c.Case_GroupCode = cm.ClientMIDefinition_CLIENTGROUPCODE and c.Case_WorkTypeCode = cm.ClientMIDefinition_WORKTYPECODE and cm.ClientMIDefinition_Inactive = 0
					WHERE c.Case_CaseID = @CaseID
				END
				ELSE		
				BEGIN
					IF @pContactID > 0
					BEGIN
						IF @pIsClaimant = 0 -- LV
						BEGIN
							SELECT @pMIDEFCODE =  cm.ClientMIDefinition_CLIENTGROUPCODE
							FROM dbo.[Case] c WITH (NOLOCK) INNER JOIN
							dbo.ClientMIDefinition cm WITH (NOLOCK) ON c.Case_GroupCode = cm.ClientMIDefinition_CLIENTGROUPCODE and cm.ClientMIDefinition_Inactive = 0
							AND ISNULL(cm.ClientMIDefinition_IsClaimant,0) = 1
							WHERE c.Case_CaseID = @CaseID
						END
						ELSE
						BEGIN
							IF NOT EXISTS (SELECT 1 FROM dbo.MIClaimantDetails WITH (NOLOCK) WHERE MIClaimantDetails_CaseID = @CaseID AND Inactive = 0)
								INSERT INTO MIClaimantDetails (MIClaimantDetails_CaseID, MIClaimantDetails_ContactID, CreateUser,CreateDate,Inactive) SELECT @CaseID, @pContactID, @pUserName, GETDATE(), 0
								
							SELECT @pMIDEFCODE =  cm.ClientMIDefinition_MIDEFCODE
							FROM dbo.[Case] c WITH (NOLOCK) INNER JOIN
							dbo.ClientMIDefinition cm WITH (NOLOCK) ON c.Case_GroupCode = cm.ClientMIDefinition_CLIENTGROUPCODE and cm.ClientMIDefinition_Inactive = 0
							AND ISNULL(cm.ClientMIDefinition_IsClaimant,0) = 1
							WHERE c.Case_CaseID = @CaseID												
						END
					END
					ELSE
					BEGIN
						SELECT @pMIDEFCODE =  cm.ClientMIDefinition_MIDEFCODE 
						FROM dbo.[Case] c WITH (NOLOCK) INNER JOIN
						dbo.ClientMIDefinition cm WITH (NOLOCK) ON c.Case_GroupCode = cm.ClientMIDefinition_CLIENTGROUPCODE and cm.ClientMIDefinition_Inactive = 0 AND ISNULL(ClientMIDefinition_WORKTYPECODE,'') = ''
						AND ISNULL(cm.ClientMIDefinition_IsClaimant,0) = 0
						WHERE c.Case_CaseID = @CaseID					
					END
				END
			END
			ELSE
			BEGIN
				SELECT @pMIDEFCODE = cm.ClientMIDefinition_MIDEFCODE 
					FROM dbo.[Case] c WITH (NOLOCK) INNER JOIN
					dbo.ClientMIDefinition cm WITH (NOLOCK) ON c.Case_WorkTypeCode = cm.ClientMIDefinition_WORKTYPECODE and cm.ClientMIDefinition_Inactive = 0
					WHERE c.Case_CaseID = @CaseID
			END
			END
		END
						
		--DECLARE TEMP TABLE TO HOLD PROCESSING DATA
		DECLARE @XmlTable TABLE
		(
			ControlID [int] NOT NULL,
			FieldCode nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			FieldValue nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			[MIFieldDefinition_DataField] nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			[MIFieldDefinition_DataTable] nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			[MIFieldDefinition_AderantField] bit NULL,
			[ClientMIDefinition_MIDEFCODE] nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			[ClientMIDefinition_RO] bit NULL,
			[MIFieldDefinition_KeyDateType] nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			[DataFieldType] nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			[CaseID_Field]  nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			[Inactive_Field]  nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			[CreateDate_Field]  nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			[CreateUser_Field]  nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			[PrimaryKey_Field]  nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			[Fields]  nvarchar(max) COLLATE DATABASE_DEFAULT NULL
		)
		
		--TRANSFER INPUT XML INTO OPENXML READABLE FORM
		DECLARE @IDOC INT
		EXEC sp_xml_preparedocument @idoc output, @pMIData
		
		--INSERT FIELD DATA FROM PASSED XML INTO TEMP TABLE FOR PROCESSING
		INSERT INTO @XmlTable (ControlID,FieldCode,FieldValue)
		SELECT DISTINCT SHAPE.ID, SHAPE.MIFieldCode, SHAPE.MIFieldValue
			FROM (Select DISTINCT ID as ID, MIFieldCode as MIFieldCode, REPLACE(MIFieldValue,'''','''''') as MIFieldValue
		FROM OPENXML(@idoc, '/MISAVE/CONTROLS/CONTROL',2)
		WITH (ID int '@ID',
		MIFieldCode varchar(255),
		MIFieldValue varchar(255))
		WHERE MIFieldCode <> 'BLANK' AND MIFieldCode <> 'LBLBLNK') AS SHAPE 
				
		--**UNCOMMENT FOR DEBUG**
		--Select * from @XmlTable
		--return

		--REPLACE  WITH XML ILLEGAL "&" CHAR 
		UPDATE @XmlTable SET FieldValue = REPLACE(FieldValue, '~38', '&')
				
		--SET MIDEFCODE
		UPDATE @XmlTable SET ClientMIDefinition_MIDEFCODE = @pMIDEFCODE 

		--RETRIEVE READ ONLY INFO
		UPDATE @XmlTable SET ClientMIDefinition_RO = cm.ClientMIFieldSet_MIFieldRO
		FROM @XmlTable x
		INNER JOIN dbo.ClientMIFieldSet cm WITH (NOLOCK) ON x.FieldCode = cm.ClientMIFieldSet_MIFieldDefCode and x.ClientMIDefinition_MIDEFCODE = cm.ClientMIFieldSet_ClientMIDEFCODE and cm.ClientMIFieldSet_Inactive = 0

				
		--TIDY UP XML DOCUMENT USED IN PROCESSING INPUT
		exec sp_xml_removedocument @idoc

		-- GET FIRLD INFO FROM MI FIELD DEFINITION
		UPDATE 	@XmlTable 
		SET [MIFieldDefinition_DataField] = M.[MIFieldDefinition_DataField],
			MIFieldDefinition_DataTable = M.[MIFieldDefinition_DataTable],
			MIFieldDefinition_AderantField = M.MIFieldDefinition_AderantField,
			MIFieldDefinition_KeyDateType = M.[MIFieldDefinition_KeyDateType]
		FROM @XmlTable AS SHAPE INNER JOIN [dbo].[MIFieldDefinition] M 
			ON M.MIFieldDefinition_MIFieldCode = SHAPE.FieldCode
				
		--UPDATE TEMP TABLE WITH REQUIRED TABLE DATA USING SYSOBJECTS AND SYSCOLUMNS
		UPDATE 	@XmlTable 
		SET DataFieldType = (Case When (col_type.name='nvarchar') Then 'nvarchar(max)' ELSE col_type.name END),
			CaseID_Field = col_caseid.name,
			Inactive_Field = col_inactive.name,
			CreateDate_Field = col_createdate.name,
			CreateUser_Field = col_createuser.name,
			PrimaryKey_Field = col_prikey.name,
			Fields = dbo.blmfuncConcat(SHAPE.MIFieldDefinition_DataTable, col_prikey.name) --GET A COMMAS SEPERATED LIST OF COLUMNS FOR EACH TABLE USING THE USER DEFINED FUNCTION 
		FROM @XmlTable AS SHAPE INNER JOIN 
			sysobjects tab ON tab.name = SHAPE.MIFieldDefinition_DataTable inner join  
			syscolumns col ON tab.id = col.id and col.name = SHAPE.MIFieldDefinition_DataField inner join 
			systypes col_type ON col.xtype = col_type.xtype INNER JOIN 
			sysobjects tab_caseid ON tab_caseid.name = SHAPE.MIFieldDefinition_DataTable INNER JOIN
			syscolumns col_caseid ON tab_caseid.id = col_caseid.id INNER JOIN 
			sysobjects tab_inactive ON tab_inactive.name = SHAPE.MIFieldDefinition_DataTable INNER JOIN
			syscolumns col_inactive ON tab_inactive.id = col_inactive.id  INNER JOIN
			sysobjects tab_createdate ON tab_createdate.name = SHAPE.MIFieldDefinition_DataTable INNER JOIN
			syscolumns col_createdate ON tab_createdate.id = col_createdate.id INNER JOIN
			sysobjects tab_createuser ON tab_createuser.name = SHAPE.MIFieldDefinition_DataTable INNER JOIN
			syscolumns col_createuser ON tab_createuser.id = col_createuser.id INNER JOIN
			sysobjects tab_prikey ON tab_prikey.name = SHAPE.MIFieldDefinition_DataTable INNER JOIN
			syscolumns col_prikey ON tab_prikey.id = col_prikey.id INNER JOIN
			sysindexes as pindex ON tab_prikey.id = pindex.id INNER JOIN
			sysindexkeys as pindexkey ON tab_prikey.id = pindexkey.id AND pindex.indid = pindexkey.indid AND col_prikey.colid = pindexkey.colid
			where  col_caseid.name like '%CaseID' 
					AND col_inactive.name like '%InActive' 
					AND (col_createdate.name like '%CreateDate' OR col_createdate.name like '%ModifiedDate') 
					AND (col_createuser.name like '%CreateUser' OR col_createuser.name like '%ModifiedBy') 
					AND (tab_prikey.[type] = 'U')
					AND ((pindex.[status] = 2066) or (pindex.[status] = 2050)) 

		--REMOVE READONLY FIELDS FROM THE TEMPORY TABLE SO THEY ARE NOT PROCESSED
		DELETE FROM @XmlTable WHERE ClientMIDefinition_RO = 1
		
								
		--**UNCOMMENT FOR DEBUG**
		--delete from @XmlTable where [MIFieldDefinition_DataField] is null
		--or [MIFieldDefinition_DataField] = ''


		--Cursor Field variables
		DECLARE	@KeyDateType nvarchar(256)
		DECLARE	@CaseID_Field nvarchar(256)
		DECLARE	@DataTable nvarchar(256)
		DECLARE	@Inactive_Field nvarchar(256)
		DECLARE	@PMS_Field bit
		DECLARE	@DataField nvarchar(256)
		DECLARE	@CreateUser_Field nvarchar(256)
		DECLARE	@CreateDate_Field nvarchar(256)
		DECLARE	@PMIFieldValue nvarchar(256)
		DECLARE	@DataFieldType nvarchar(256)
		DECLARE	@PrimaryKey_Field nvarchar(256)
		DECLARE	@Fields nvarchar(max)

	
		--Declare cursor with the contants of the temp table for processing
		DECLARE myCursor CURSOR READ_ONLY
		FOR
			SELECT [MIFieldDefinition_KeyDateType],[CaseID_Field],
				[MIFieldDefinition_DataTable], [MIFieldDefinition_AderantField],
				[Inactive_Field],[MIFieldDefinition_DataField],
				[CreateUser_Field],[CreateDate_Field], 
				FieldValue, [DataFieldType],[PrimaryKey_Field] ,[Fields]
			FROM @XmlTable
		--open cursor for processng
		OPEN myCursor
		
		--fetch the first row in the cursor into the field variables
		Fetch Next FROM myCursor INTO
			@KeyDateType, @CaseID_Field, @DataTable, @PMS_Field, @Inactive_Field,
			@DataField,@CreateUser_Field,@CreateDate_Field, @PMIFieldValue,
			@DataFieldType,@PrimaryKey_Field,@Fields
	

		--BEGIN SAVE TRANSACTION
		BEGIN TRANSACTION ClientMIFieldSetSave
		
		--WHILE THERE ARE STILL ROWS
		WHILE @@FETCH_STATUS=0
		BEGIN
			--process current rows client mi updates
			
			--PRINT 'Field - ' + @PMIFieldValue
			--PRINT '@KeyDateType - ' + @KeyDateType 
			--PRINT '@CaseID_Field - ' + @CaseID_Field 
			--PRINT '@DataTable - ' + @DataTable 
			--PRINT '@PMS_Field - ' + CAST(@PMS_Field AS VARCHAR(50))
			--PRINT '@Inactive_Field - ' + @Inactive_Field
			--PRINT '@DataField - ' + @DataField
			--PRINT '@CreateUser_Field - ' + @CreateUser_Field
			--PRINT '@CreateDate_Field - ' + @CreateDate_Field
			--PRINT '@PMIFieldValue - ' + @PMIFieldValue
			--PRINT '@DataFieldType - ' + @DataFieldType
			--PRINT '@PrimaryKey_Field - ' + @PrimaryKey_Field
			--PRINT '@Fields - ' + @Fields
			
			exec blmspClientMIFieldSet_ProcessForSave @KeyDateType, @CaseID_Field, @DataTable, @PMS_Field, 
				@CaseID, @Inactive_Field, @DataField,@CreateUser_Field,@CreateDate_Field,
				@PMIFieldValue,@DataFieldType, @pUserName,@PrimaryKey_Field,@Fields, @pIsClaimant
			--fetch the next row into the field variables
			Fetch Next FROM myCursor INTO
			@KeyDateType, @CaseID_Field, @DataTable, @PMS_Field, @Inactive_Field,
			@DataField,@CreateUser_Field,@CreateDate_Field, @PMIFieldValue,
			@DataFieldType,@PrimaryKey_Field,@Fields
		END	
						
		--Close and Remove cursor definition
		CLOSE myCursor
		DEALLOCATE myCursor
		
		EXEC ClientMIFieldSet_SaveReadWrite @CaseID

		--TIDY UP ANY RESERVE MODIFICATIONS
		EXECUTE [ClientMIFieldSet_SaveResTidy] @CaseID, @pUserName

		COMMIT TRANSACTION ClientMIFieldSetSave
		
		SELECT 1 AS RETURNVALUE
	END TRY
	
	BEGIN CATCH
		IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION ClientMIFieldSetSave
		SELECT ERROR_MESSAGE() + ' SP:' + OBJECT_NAME(@@PROCID)
		SELECT '' AS RETURNVALUE
	END CATCH
	
	
	
	

END
