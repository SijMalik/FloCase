USE [FloSuite_Data_Dev]
GO

/****** Object:  StoredProcedure [dbo].[ClientMIFieldSet_Fetch]    Script Date: 11/17/2011 14:00:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[ClientMIFieldSet_Fetch] 
	@pCase_CaseID	int = 0,
	@pUser_Name		nvarchar(255) = '',
	@pGetCosts		bit = 0
AS
BEGIN
	-- =============================================
	-- Author:		GQL
	-- Create date: 23-02-2010
	-- Description:	Stored Procedure to return the set of MI fields required on a matter based on 
	-- the client attached to that matter, this includes any data currently held by those fields
	-- =============================================
	
	--Initialise error trapping
	SET NOCOUNT ON
	SET ARITHABORT ON
	SET DATEFORMAT DMY
	DECLARE @myLastError int 
	SELECT @myLastError = 0
	DECLARE @myLastErrorString nvarchar(255)
	SELECT @myLastErrorString = '' 
	
	--Variable required to retreive the data currently held by this clients MI data field set
	DECLARE @pReturnData AS XML
	DECLARE @MaxID AS INT
	DECLARE @MINID AS INT = 1
	DECLARE @COLVAL AS NVARCHAR(255)
	DECLARE @LKPDESC AS NVARCHAR(255)
	DECLARE @SQLSTRING AS NVARCHAR(255)
	DECLARE @Count AS INT = 1
	DECLARE @NoField AS INT = 1
	DECLARE @FieldValue as nvarchar(255) 
	DECLARE @FieldCode as nvarchar(255) 
	
	--Declare the temporty table that will be used to map the mi fields to there current data values
	DECLARE @TEMPTABLE1 TABLE
	(
		ResultID					INT IDENTITY,
		FIELDCODE					nvarchar(10),
		COLNAME						nvarchar(255),
		COLTYPE						nvarchar(255),
		REONLY						bit,
		COLVALUE					nvarchar(255)
	)
	
	--DOES THE MATTER HAVE A CLIENT NUMBER DATASET
	IF EXISTS(SELECT ClientMIDefinition_ClientMIDefinitionID FROM ClientMIDefinition WHERE ClientMIDefinition_CLIENTCODE = (SELECT Case_ClientCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID))
	BEGIN
		--DOES THE MATTER HAVE A COMBO CLIENT NUMBER AND WORKTYPE DATASET
		IF EXISTS(SELECT ClientMIDefinition_ClientMIDefinitionID FROM ClientMIDefinition WHERE ClientMIDefinition_WORKTYPECODE = (SELECT Case_WorkTypeCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID) AND ClientMIDefinition_CLIENTCODE = (SELECT Case_ClientCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID))
		BEGIN
			--uncomment for debug
			----PRINT 'Client number and Worktype'
			--Populate the Tempory table with the MI fields FOR THE COMBO CLIENT NUMBER AND WORKTYPE DATASET
			INSERT INTO @TEMPTABLE1(FIELDCODE, COLNAME, COLTYPE)
			SELECT mf.MIFieldDefinition_MIFieldCode, mf.MIFieldDefinition_DataField, mf.MIFieldDefinition_MIFieldTypeCode 
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
			INSERT INTO @TEMPTABLE1(FIELDCODE, COLNAME, COLTYPE)
			SELECT mf.MIFieldDefinition_MIFieldCode, mf.MIFieldDefinition_DataField, mf.MIFieldDefinition_MIFieldTypeCode 
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
				INSERT INTO @TEMPTABLE1(FIELDCODE, COLNAME, COLTYPE)
				SELECT mf.MIFieldDefinition_MIFieldCode, mf.MIFieldDefinition_DataField, mf.MIFieldDefinition_MIFieldTypeCode 
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
				--Populate the Tempory table with the MI fields FOR THE CLIENT GROUP DATASET
				INSERT INTO @TEMPTABLE1(FIELDCODE, COLNAME, COLTYPE)
				SELECT mf.MIFieldDefinition_MIFieldCode, mf.MIFieldDefinition_DataField, mf.MIFieldDefinition_MIFieldTypeCode 
				FROM [Case] c INNER JOIN
				ClientMIDefinition cm ON c.Case_GroupCode = cm.ClientMIDefinition_CLIENTGROUPCODE and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
				ClientMIFieldSet cf ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 INNER JOIN
				MIFieldDefinition mf ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0
				WHERE c.Case_CaseID = @pCase_CaseID and mf.MIFieldDefinition_DataField <> 'n/a' and ISNULL(mf.MIFieldDefinition_DataField,'') <> ''
				
			END
		END
		ELSE
		BEGIN
			--WORKTYPE
			IF @pGetCosts = 1
			BEGIN
				INSERT INTO @TEMPTABLE1(FIELDCODE, COLNAME, COLTYPE)
				SELECT mf.MIFieldDefinition_MIFieldCode, mf.MIFieldDefinition_DataField, mf.MIFieldDefinition_MIFieldTypeCode 
				FROM [Case] c LEFT OUTER JOIN
				ClientMIDefinition cm ON cm.ClientMIDefinition_WORKTYPECODE = 'COSTS' and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
				ClientMIFieldSet cf ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 INNER JOIN
				MIFieldDefinition mf ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0
				WHERE c.Case_CaseID = @pCase_CaseID and mf.MIFieldDefinition_DataField <> 'n/a' and ISNULL(mf.MIFieldDefinition_DataField,'') <> ''
				AND c.Case_CostsAssgn = 1			
			END
			ELSE
			BEGIN
				--uncomment for debug
				----PRINT 'Worktype only'
				--Populate the Tempory table with the MI fields FOR THE WORKTYPE DATASET
				INSERT INTO @TEMPTABLE1(FIELDCODE, COLNAME, COLTYPE)
				SELECT mf.MIFieldDefinition_MIFieldCode, mf.MIFieldDefinition_DataField, mf.MIFieldDefinition_MIFieldTypeCode 
				FROM [Case] c INNER JOIN
				ClientMIDefinition cm ON c.Case_WorkTypeCode = cm.ClientMIDefinition_WORKTYPECODE and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
				ClientMIFieldSet cf ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 INNER JOIN
				MIFieldDefinition mf ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0
				WHERE c.Case_CaseID = @pCase_CaseID and mf.MIFieldDefinition_DataField <> 'n/a' and ISNULL(mf.MIFieldDefinition_DataField,'') <> ''
				
			END
		END
	END
		
	--get the maximum id value in the tempory table (for use in the while loop below)
	SELECT @MaxID = MAX(ResultID) FROM @TEMPTABLE1 
	
	--Get the current values of the MI datafields in XML format
	EXEC [dbo].[MIData_Fetch] @pCase_CaseID, @pReturnData OUTPUT, @pUser_Name
	
	SELECT @NoField = @pReturnData.query('<e> { count(/MIDATA/_x0040_TEMPTABLE1) } </e>').value('e[1]', 'int')
		
	--LOOP ROUND ALL THE MI FIELDS TO BE PROCESSED 
	WHILE @Count <= @NoField 
	BEGIN
		--GET THE FIELD CODE AND FIELD VALUE OF THE CURRENT MI FIELD TO BE PROCESSED 		
		SELECT @FieldCode = x.value('FIELDCODE[1]', 'VARCHAR(255)') 
		FROM @pReturnData.nodes('/MIDATA/_x0040_TEMPTABLE1[position()=sql:variable("@Count")]') e(x)
		SELECT @FieldValue = x.value('COLVALUE[1]', 'VARCHAR(255)') 
		FROM @pReturnData.nodes('/MIDATA/_x0040_TEMPTABLE1[position()=sql:variable("@Count")]') e(x)
		--**UNCOMMENT FOR DEBUG**
		----PRINT @FieldCode
		----PRINT @FieldValue
		
		UPDATE @TEMPTABLE1 SET COLVALUE = @FieldValue WHERE FIELDCODE = @FieldCode 
		
		--MOVE TO THE NEXT MI FIELD TO BE PROCESSED 
		SET @Count = @Count + 1
	END

	--DOES THE MATTER HAVE A CLIENT NUMBER DATASET
	IF EXISTS(SELECT ClientMIDefinition_ClientMIDefinitionID FROM ClientMIDefinition WHERE ClientMIDefinition_CLIENTCODE = (SELECT Case_ClientCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID))
	BEGIN
		--DOES THE MATTER HAVE A COMBO CLIENT NUMBER AND WORKTYPE DATASET
		IF EXISTS(SELECT ClientMIDefinition_ClientMIDefinitionID FROM ClientMIDefinition WHERE ClientMIDefinition_WORKTYPECODE = (SELECT Case_WorkTypeCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID) AND ClientMIDefinition_CLIENTCODE = (SELECT Case_ClientCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID))
		BEGIN
			--uncomment for debug
			--PRINT 'Client number and Worktype'
			--return the MI fields with previous data FOR THE COMBO CLIENT NUMBER AND WORKTYPE DATASET
			SELECT cl.CLIENT_NAME, cm.ClientMIDefinition_MIDEFCODE, cf.ClientMIFieldSet_ClientMIDEFCODE + '-' + cf.ClientMIFieldSet_MIFieldDefCode AS ClientMIFieldSetCode, 
			ISNULL(cm.ClientMIDefinition_LKPFilter,'') + '$' + ISNULL(mf.MIFieldDefinition_MILKPFieldCode,'') AS LookUpFilter, 
			cf.ClientMIFieldSet_MIFieldPosition, cf.ClientMIFieldSet_MIFieldLabel, cf.ClientMIFieldSet_MIFieldRO, cf.ClientMIFieldSet_MIFieldMAND,
			mf.MIFieldDefinition_FieldDescription, mf.MIFieldDefinition_DataField, MIFieldDefinition_DataTable, 
			mt.MIFieldTypeDefinition_Description, TP.COLVALUE AS PREVIOUSVALUE,
			cf.ClientMIFieldSet_MIFieldDefCode AS saveFilter,
			cf.ClientMIFieldSet_MIFieldMAND as mandField,
			cf.ClientMIFieldSet_MIFieldRO as roField,
			cf.ClientMIFieldSet_OnChangeText
			FROM [Case] c INNER JOIN
			[CaseContacts] cc ON c.Case_CaseID = cc.CaseContacts_CaseID INNER JOIN
			HBM_Client cl ON cc.CaseContacts_ClientID = cl.CLIENT_UNO AND cc.CaseContacts_Inactive = 0 INNER JOIN
			ClientMIDefinition cm ON c.Case_ClientCode = cm.ClientMIDefinition_CLIENTCODE and c.Case_WorkTypeCode = cm.ClientMIDefinition_WORKTYPECODE and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
			ClientMIFieldSet cf ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 INNER JOIN
			MIFieldDefinition mf ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0 INNER JOIN 
			MIFieldTypeDefinition mt ON mf.MIFieldDefinition_MIFieldTypeCode = mt.MIFieldTypeDefinition_MIFieldTypeCode and mt.MIFieldTypeDefinition_Inactive = 0 LEFT OUTER JOIN
			@TEMPTABLE1 TP ON mf.MIFieldDefinition_MIFieldCode = TP.FIELDCODE 
			WHERE c.Case_CaseID = @pCase_CaseID
			ORDER BY cf.ClientMIFieldSet_MIFieldPosition
		END
		ELSE		
		BEGIN
			--uncomment for debug
			--PRINT 'Client number only'
			--return the MI fields with previous data FOR THE CLIENT NUMBER DATASET
			SELECT cl.CLIENT_NAME, cm.ClientMIDefinition_MIDEFCODE, cf.ClientMIFieldSet_ClientMIDEFCODE + '-' + cf.ClientMIFieldSet_MIFieldDefCode AS ClientMIFieldSetCode, 
			ISNULL(cm.ClientMIDefinition_LKPFilter,'') + '$' + ISNULL(mf.MIFieldDefinition_MILKPFieldCode,'') AS LookUpFilter, 
			cf.ClientMIFieldSet_MIFieldPosition, cf.ClientMIFieldSet_MIFieldLabel, cf.ClientMIFieldSet_MIFieldRO, cf.ClientMIFieldSet_MIFieldMAND,
			mf.MIFieldDefinition_FieldDescription, mf.MIFieldDefinition_DataField, MIFieldDefinition_DataTable, 
			mt.MIFieldTypeDefinition_Description, TP.COLVALUE AS PREVIOUSVALUE,
			cf.ClientMIFieldSet_MIFieldDefCode AS saveFilter,
			cf.ClientMIFieldSet_MIFieldMAND as mandField,
			cf.ClientMIFieldSet_MIFieldRO as roField,
			cf.ClientMIFieldSet_OnChangeText
			FROM [Case] c INNER JOIN
			[CaseContacts] cc ON c.Case_CaseID = cc.CaseContacts_CaseID INNER JOIN
			HBM_Client cl ON cc.CaseContacts_ClientID = cl.CLIENT_UNO AND cc.CaseContacts_Inactive = 0 INNER JOIN
			ClientMIDefinition cm ON c.Case_ClientCode = cm.ClientMIDefinition_CLIENTCODE and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
			ClientMIFieldSet cf ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 INNER JOIN
			MIFieldDefinition mf ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0 INNER JOIN 
			MIFieldTypeDefinition mt ON mf.MIFieldDefinition_MIFieldTypeCode = mt.MIFieldTypeDefinition_MIFieldTypeCode and mt.MIFieldTypeDefinition_Inactive = 0 LEFT OUTER JOIN
			@TEMPTABLE1 TP ON mf.MIFieldDefinition_MIFieldCode = TP.FIELDCODE 
			WHERE c.Case_CaseID = @pCase_CaseID
			ORDER BY cf.ClientMIFieldSet_MIFieldPosition
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
				--PRINT 'Group code and Worktype'
				--return the MI fields with previous data FOR THE COMBO CLIENT GROUP AND WORKTYPE DATASET
				SELECT cl.CLIENT_NAME, cm.ClientMIDefinition_MIDEFCODE, cf.ClientMIFieldSet_ClientMIDEFCODE + '-' + cf.ClientMIFieldSet_MIFieldDefCode AS ClientMIFieldSetCode, 
				ISNULL(cm.ClientMIDefinition_LKPFilter,'') + '$' + ISNULL(mf.MIFieldDefinition_MILKPFieldCode,'') AS LookUpFilter, 
				cf.ClientMIFieldSet_MIFieldPosition, cf.ClientMIFieldSet_MIFieldLabel, cf.ClientMIFieldSet_MIFieldRO, cf.ClientMIFieldSet_MIFieldMAND,
				mf.MIFieldDefinition_FieldDescription, mf.MIFieldDefinition_DataField, MIFieldDefinition_DataTable, 
				mt.MIFieldTypeDefinition_Description, TP.COLVALUE AS PREVIOUSVALUE,
				cf.ClientMIFieldSet_MIFieldDefCode AS saveFilter,
				cf.ClientMIFieldSet_MIFieldMAND as mandField,
				cf.ClientMIFieldSet_MIFieldRO as roField,
				cf.ClientMIFieldSet_OnChangeText
				FROM [Case] c INNER JOIN
				[CaseContacts] cc ON c.Case_CaseID = cc.CaseContacts_CaseID INNER JOIN
				HBM_Client cl ON cc.CaseContacts_ClientID = cl.CLIENT_UNO AND cc.CaseContacts_Inactive = 0 INNER JOIN
				ClientMIDefinition cm ON c.Case_GroupCode = cm.ClientMIDefinition_CLIENTGROUPCODE and c.Case_WorkTypeCode = cm.ClientMIDefinition_WORKTYPECODE and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
				ClientMIFieldSet cf ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 INNER JOIN
				MIFieldDefinition mf ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0 INNER JOIN 
				MIFieldTypeDefinition mt ON mf.MIFieldDefinition_MIFieldTypeCode = mt.MIFieldTypeDefinition_MIFieldTypeCode and mt.MIFieldTypeDefinition_Inactive = 0 LEFT OUTER JOIN
				@TEMPTABLE1 TP ON mf.MIFieldDefinition_MIFieldCode = TP.FIELDCODE 
				WHERE c.Case_CaseID = @pCase_CaseID
				ORDER BY cf.ClientMIFieldSet_MIFieldPosition
			END
			ELSE		
			BEGIN
				--uncomment for debug
				--PRINT 'Group Code only'
				--return the MI fields with previous data FOR THE CLIENT GROUP DATASET
				SELECT cl.CLIENT_NAME, cm.ClientMIDefinition_MIDEFCODE, cf.ClientMIFieldSet_ClientMIDEFCODE + '-' + cf.ClientMIFieldSet_MIFieldDefCode AS ClientMIFieldSetCode, 
				ISNULL(cm.ClientMIDefinition_LKPFilter,'') + '$' + ISNULL(mf.MIFieldDefinition_MILKPFieldCode,'') AS LookUpFilter, 
				cf.ClientMIFieldSet_MIFieldPosition, cf.ClientMIFieldSet_MIFieldLabel, cf.ClientMIFieldSet_MIFieldRO, cf.ClientMIFieldSet_MIFieldMAND,
				mf.MIFieldDefinition_FieldDescription, mf.MIFieldDefinition_DataField, MIFieldDefinition_DataTable, 
				mt.MIFieldTypeDefinition_Description, TP.COLVALUE AS PREVIOUSVALUE,
				cf.ClientMIFieldSet_MIFieldDefCode AS saveFilter,
				cf.ClientMIFieldSet_MIFieldMAND as mandField,
				cf.ClientMIFieldSet_MIFieldRO as roField,
				cf.ClientMIFieldSet_OnChangeText
				FROM [Case] c INNER JOIN
				[CaseContacts] cc ON c.Case_CaseID = cc.CaseContacts_CaseID INNER JOIN
				HBM_Client cl ON cc.CaseContacts_ClientID = cl.CLIENT_UNO AND cc.CaseContacts_Inactive = 0 INNER JOIN
				ClientMIDefinition cm ON c.Case_GroupCode = cm.ClientMIDefinition_CLIENTGROUPCODE and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
				ClientMIFieldSet cf ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 INNER JOIN
				MIFieldDefinition mf ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0 INNER JOIN 
				MIFieldTypeDefinition mt ON mf.MIFieldDefinition_MIFieldTypeCode = mt.MIFieldTypeDefinition_MIFieldTypeCode and mt.MIFieldTypeDefinition_Inactive = 0 LEFT OUTER JOIN
				@TEMPTABLE1 TP ON mf.MIFieldDefinition_MIFieldCode = TP.FIELDCODE
				WHERE c.Case_CaseID = @pCase_CaseID
				ORDER BY cf.ClientMIFieldSet_MIFieldPosition
			END
		END
		ELSE
		BEGIN
			IF @pGetCosts = 1
			BEGIN
				--WORKTYPE
				--PRINT 'Costs'
				SELECT cl.CLIENT_NAME, cm.ClientMIDefinition_MIDEFCODE, cf.ClientMIFieldSet_ClientMIDEFCODE + '-' + cf.ClientMIFieldSet_MIFieldDefCode AS ClientMIFieldSetCode, 
				ISNULL(cm.ClientMIDefinition_LKPFilter,'') + '$' + ISNULL(mf.MIFieldDefinition_MILKPFieldCode,'') AS LookUpFilter, 
				cf.ClientMIFieldSet_MIFieldPosition, cf.ClientMIFieldSet_MIFieldLabel, cf.ClientMIFieldSet_MIFieldRO, cf.ClientMIFieldSet_MIFieldMAND,
				mf.MIFieldDefinition_FieldDescription, mf.MIFieldDefinition_DataField, MIFieldDefinition_DataTable, 
				mt.MIFieldTypeDefinition_Description, TP.COLVALUE AS PREVIOUSVALUE,
				cf.ClientMIFieldSet_MIFieldDefCode AS saveFilter,
				cf.ClientMIFieldSet_MIFieldMAND as mandField,
				cf.ClientMIFieldSet_MIFieldRO as roField,
				cf.ClientMIFieldSet_OnChangeText 
				FROM [Case] c INNER JOIN
				[CaseContacts] cc ON c.Case_CaseID = cc.CaseContacts_CaseID INNER JOIN
				HBM_Client cl ON cc.CaseContacts_ClientID = cl.CLIENT_UNO AND cc.CaseContacts_Inactive = 0 INNER JOIN
				ClientMIDefinition cm ON cm.ClientMIDefinition_WORKTYPECODE = 'COSTS' and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
				ClientMIFieldSet cf ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 INNER JOIN
				MIFieldDefinition mf ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0 INNER JOIN
				MIFieldTypeDefinition mt ON mf.MIFieldDefinition_MIFieldTypeCode = mt.MIFieldTypeDefinition_MIFieldTypeCode and mt.MIFieldTypeDefinition_Inactive = 0 LEFT OUTER JOIN
				@TEMPTABLE1 TP ON mf.MIFieldDefinition_MIFieldCode = TP.FIELDCODE 
				WHERE c.Case_CaseID = @pCase_CaseID
				AND c.Case_CostsAssgn = 1
				ORDER BY cf.ClientMIFieldSet_MIFieldPosition			
			END
			ELSE
			BEGIN
				--uncomment for debug
				--PRINT 'Worktype only'
				--return the MI fields with previous data FOR THE WORKTYPE DATASET
				SELECT cl.CLIENT_NAME, cm.ClientMIDefinition_MIDEFCODE, cf.ClientMIFieldSet_ClientMIDEFCODE + '-' + cf.ClientMIFieldSet_MIFieldDefCode AS ClientMIFieldSetCode, 
				ISNULL(cm.ClientMIDefinition_LKPFilter,'') + '$' + ISNULL(mf.MIFieldDefinition_MILKPFieldCode,'') AS LookUpFilter, 
				cf.ClientMIFieldSet_MIFieldPosition, cf.ClientMIFieldSet_MIFieldLabel, cf.ClientMIFieldSet_MIFieldRO, cf.ClientMIFieldSet_MIFieldMAND,
				mf.MIFieldDefinition_FieldDescription, mf.MIFieldDefinition_DataField, MIFieldDefinition_DataTable, 
				mt.MIFieldTypeDefinition_Description, TP.COLVALUE AS PREVIOUSVALUE,
				cf.ClientMIFieldSet_MIFieldDefCode AS saveFilter,
				cf.ClientMIFieldSet_MIFieldMAND as mandField,
				cf.ClientMIFieldSet_MIFieldRO as roField,
				cf.ClientMIFieldSet_OnChangeText 
				FROM [Case] c INNER JOIN
				[CaseContacts] cc ON c.Case_CaseID = cc.CaseContacts_CaseID INNER JOIN
				HBM_Client cl ON cc.CaseContacts_ClientID = cl.CLIENT_UNO AND cc.CaseContacts_Inactive = 0 INNER JOIN
				ClientMIDefinition cm ON c.Case_WorkTypeCode = cm.ClientMIDefinition_WORKTYPECODE and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
				ClientMIFieldSet cf ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 INNER JOIN
				MIFieldDefinition mf ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0 INNER JOIN 
				MIFieldTypeDefinition mt ON mf.MIFieldDefinition_MIFieldTypeCode = mt.MIFieldTypeDefinition_MIFieldTypeCode and mt.MIFieldTypeDefinition_Inactive = 0 LEFT OUTER JOIN
				@TEMPTABLE1 TP ON mf.MIFieldDefinition_MIFieldCode = TP.FIELDCODE 
				WHERE c.Case_CaseID = @pCase_CaseID
				ORDER BY cf.ClientMIFieldSet_MIFieldPosition
			END
		END
	END
	
	--Test for errors
	SELECT @myLastError = @@ERROR
	IF @myLastError <> 0 GOTO THROW_ERROR_UPWARDS
		
	THROW_ERROR_UPWARDS:
	IF (@myLastError <> 0 ) OR (@myLastErrorString <> '')
	BEGIN
		ROLLBACK TRANSACTION ClientReport
		SET @myLastErrorString = 'Error Occurred In Stored Procedure ClientMIFieldSet_Fetch - ' + @myLastErrorString
		RAISERROR (@myLastErrorString, 16,1)
	END
	
END


GO


