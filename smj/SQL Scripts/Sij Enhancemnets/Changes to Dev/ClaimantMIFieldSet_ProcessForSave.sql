USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[ClaimantMIFieldSet_ProcessForSave]    Script Date: 09/24/2012 16:16:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[ClaimantMIFieldSet_ProcessForSave] 
	@pMIData							xml = ''
AS
	-- =============================================
	-- Author: SMJ
	-- Modify date: 03-05-2012
	-- Description:	New SP to save Allianz Claiman MI FieldSet
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
	DECLARE @errNoXML VARCHAR(50)
	
	SET @errNoXML = 'No MI Data passed in.'
	

	--DECLARE AND INITIALISE LOCAL VARIABLES
	DECLARE @CaseID as int
	Declare @UserName as  nvarchar(255)
	DECLARE @MIDEFCODE as  nvarchar(255)
	DECLARE @fieldtype as  nvarchar(255)
	DECLARE @ContactID INT = 0
	DECLARE @RecExists BIT =0
	DECLARE @DataFields NVARCHAR(MAX)= ''
	DECLARE @sUpdateSQL NVARCHAR(MAX)= ''
	
	BEGIN TRY
		--SMJ 11/04/2012
		--CHECK SOME MI DATA HAS BEEN PASSSED IN:
		IF  convert(nvarchar(max),@pMIData) = ''
			RAISERROR(@errNoXML, 16, 1)	
	
		--RPM 
		DECLARE @tempVal nvarchar(max)
		SET @tempVal = convert(nvarchar(max),@pMIData) 
		
		SET @tempVal = REPLACE(@tempVal,'%60','<')
		SET @tempVal = REPLACE(@tempVal,'%62','>')
		---
		
		SET @pMIData = convert(xml,@tempVal) 
			--RETRIEVE MATTER LEVEL DATA FROM THE PASSED XML STRUCTURE
			SELECT @CaseID = x.value('CASEID[1]', 'int') 
			FROM @pMIData.nodes('/MISAVE[position()=1]') e(x)
			SELECT @UserName = x.value('USERNAME[1]', 'nvarchar(255)') 
			FROM @pMIData.nodes('/MISAVE[position()=1]') e(x)
			SELECT @ContactID = x.value('CONTACTID[1]', 'nvarchar(255)') 
			FROM @pMIData.nodes('/MISAVE[position()=1]') e(x)	

		IF EXISTS (SELECT 1 FROM dbo.MIClaimantDetails WITH (NOLOCK) where MIClaimantDetails_CaseID = @CaseID and MIClaimantDetails_ContactID = @ContactID)
		BEGIN
			SELECT @RecExists = 1
		END
					
		--DOES THE MATTER HAVE A CLIENT GROUP DATASET
		IF EXISTS(SELECT  1 FROM dbo.ClientMIDefinition WITH (NOLOCK) WHERE ClientMIDefinition_CLIENTGROUPCODE = (SELECT Case_GroupCode FROM [CASE] WHERE Case_CaseID = 1987))
		BEGIN
			SELECT @MIDEFCODE =  cm.ClientMIDefinition_MIDEFCODE 
			FROM dbo.[Case] c WITH (NOLOCK) INNER JOIN
			dbo.ClientMIDefinition cm WITH (NOLOCK) ON c.Case_GroupCode = cm.ClientMIDefinition_CLIENTGROUPCODE and cm.ClientMIDefinition_Inactive = 0
			AND cm.ClientMIDefinition_IsClaimant = 1
			WHERE c.Case_CaseID = @CaseID					
		END	
		

		--DECLARE TEMP TABLE TO HOLD PROCESSING DATA
		DECLARE @XmlTable TABLE
		(
			[ControlID] int NOT NULL,
			[FieldCode] nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			[FieldValue] nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			[MIFieldDefinition_DataField] nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			[MIFieldDefinition_DataTable] nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			[MIFieldDefinition_AderantField] bit NULL,
			[ClientMIDefinition_MIDEFCODE] nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			[ClientMIDefinition_RO] bit NULL
		)

		----TRANSFER INPUT XML INTO OPENXML READABLE FORM
		DECLARE @IDOC INT
		EXEC sp_xml_preparedocument @idoc output, @pMIData
		
		----INSERT FIELD DATA FROM PASSED XML INTO TEMP TABLE FOR PROCESSING
		INSERT INTO @XmlTable (ControlID,FieldCode,FieldValue)
		SELECT DISTINCT SHAPE.ID, SHAPE.MIFieldCode, SHAPE.MIFieldValue
			FROM (Select DISTINCT ID as ID, MIFieldCode as MIFieldCode, REPLACE(MIFieldValue,'''','''''') as MIFieldValue
		FROM OPENXML(@idoc, '/MISAVE/CONTROLS/CONTROL',2)
		WITH (ID int '@ID',
		MIFieldCode varchar(255),
		MIFieldValue varchar(255))
		WHERE MIFieldCode <> 'BLANK' AND MIFieldCode <> 'LBLBLNK') AS SHAPE 

		----REPLACE  WITH XML ILLEGAL "&" CHAR 
		UPDATE @XmlTable SET FieldValue = REPLACE(FieldValue, '~38', '&')
		
		--SET MIDEFCODE
		UPDATE @XmlTable SET ClientMIDefinition_MIDEFCODE = @MIDEFCODE 

		--RETRIEVE READ ONLY INFO
		UPDATE @XmlTable SET ClientMIDefinition_RO = cm.ClientMIFieldSet_MIFieldRO,
		[MIFieldDefinition_DataField] = MI.MIFieldDefinition_DataField
		FROM @XmlTable x
		INNER JOIN dbo.ClientMIFieldSet cm WITH (NOLOCK) ON x.FieldCode = cm.ClientMIFieldSet_MIFieldDefCode and x.ClientMIDefinition_MIDEFCODE = cm.ClientMIFieldSet_ClientMIDEFCODE and cm.ClientMIFieldSet_Inactive = 0
		INNER JOIN dbo.MIFieldDefinition MI WITH (NOLOCK)on cm.ClientMIFieldSet_MIFieldDefCode = MI.MIFieldDefinition_MIFieldCode
		--TIDY UP XML DOCUMENT USED IN PROCESSING INPUT

		exec sp_xml_removedocument @idoc


		DELETE FROM @XmlTable WHERE ClientMIDefinition_RO = 1
		DELETE FROM @XmlTable WHERE ClientMIDefinition_RO IS NULL
		
		--Cursor Field variables
		DECLARE	@KeyDateType nvarchar(256)
		DECLARE	@CaseID_Field nvarchar(256)
		DECLARE	@DataTable nvarchar(256)

		DECLARE	@DataField nvarchar(256)
		DECLARE	@PMIFieldValue nvarchar(256)
		DECLARE @sSQL  NVARCHAR(MAX) = ''
		DECLARE @sSQL2  NVARCHAR(MAX) =''
		DECLARE @CDATE AS NVARCHAR(50)

		SET @CDATE = CAST(GETDATE() AS VARCHAR)				

		--Declare cursor with the contants of the temp table for processing
		DECLARE myCursor CURSOR READ_ONLY
		FOR
			SELECT [MIFieldDefinition_DataField],
					[FieldValue] 
			FROM @XmlTable
		--open cursor for processng
		OPEN myCursor
		
		--fetch the first row in the cursor into the field variables
		Fetch Next FROM myCursor INTO			
			@DataField, @PMIFieldValue
			
	
		--WHILE THERE ARE STILL ROWS 
		WHILE @@FETCH_STATUS=0
		BEGIN
			
		select @fieldtype = isnull(MIFieldDefinition_MIFieldTypeCode,'')
		from MIFieldDefinition where MIFieldDefinition_DataField = @DataField 
		
			SELECT @DataFields = @DataField + ',' + @DataFields
			IF @fieldtype = 'MIINT' OR @fieldtype = 'MIMONEY'
			BEGIN
				SELECT @sSQL= @PMIFieldValue + ','
			END
			ELSE
			BEGIN
				SELECT @sSQL= '''' + @PMIFieldValue + ''','
			END
		--END
		
		SELECT @ssql2 = @ssql + @ssql2
		
		Fetch Next FROM myCursor INTO			
			@DataField, @PMIFieldValue
		END					
		
		--Close and Remove cursor definition
		CLOSE myCursor
		DEALLOCATE myCursor

		SELECT @sSQL2 = SUBSTRING(@ssql2,1,len(@ssql2)-1)
		SELECT @DataFields = SUBSTRING(@DataFields,1,len(@DataFields)-1)
	
		SELECT @sSQL = 'INSERT INTO MIClaimantDetails (MIClaimantDetails_CaseID,MIClaimantDetails_ContactID, ' + @DataFields + ' , CreateUser, CreateDate, Inactive) VALUES (' + CAST(@CaseID AS VARCHAR) + ', ' + CAST(@ContactID AS VARCHAR)  + ', ' + @sSQl2 + ', ''' + @UserName  + ''',''' + @CDATE + '''' + ', 0)'
		
		
		IF @RecExists = 1
		BEGIN
			SELECT @sUpdateSQL = 'UPDATE MIClaimantDetails SET INACTIVE = 1 WHERE MIClaimantDetails_CaseID = ' + CAST(@CaseID AS VARCHAR)+ ' AND MIClaimantDetails_ContactID = ' + CAST(@ContactID AS VARCHAR)
			EXECUTE sp_executesql @sUpdateSQL
		END

		EXECUTE sp_executesql @sSQL
		
		SELECT 1 AS RETURNVALUE

	END TRY
	
	BEGIN CATCH
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH


