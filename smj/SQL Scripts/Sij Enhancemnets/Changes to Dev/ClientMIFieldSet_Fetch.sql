USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[ClientMIFieldSet_Fetch]    Script Date: 09/24/2012 13:17:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ClientMIFieldSet_Fetch] 
	@pCase_CaseID	int = 0,
	@pUser_Name		nvarchar(255) = '',
	@pGetCosts		bit = 0,
	@pCaseContactID INT = 0
AS
BEGIN
	-- =============================================
	-- Author:		GQL
	-- Create date: 23-02-2010
	-- Description:	Stored Procedure to return the set of MI fields required on a matter based on 
	-- the client attached to that matter, this includes any data currently held by those fields
	-- =============================================
	-- =============================================
	-- Author:		SMJ
	-- Modify date: 20-04-2012
	-- Description:	Changed SP to cater for Claimant MI
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
	SET DATEFORMAT DMY

	
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
		FIELDCODE					nvarchar(255),
		COLNAME						nvarchar(255),
		COLTYPE						nvarchar(255),
		REONLY						bit,
		COLVALUE					nvarchar(255),
		CONTACTID					INT
	)
	
	BEGIN TRY
		IF @pGetCosts = 1
		BEGIN
			INSERT INTO @TEMPTABLE1(FIELDCODE, COLNAME, COLTYPE)
			SELECT 
				mf.MIFieldDefinition_MIFieldCode, 
				mf.MIFieldDefinition_DataField, 
				mf.MIFieldDefinition_MIFieldTypeCode 
			FROM dbo.[Case] c WITH (NOLOCK)
			LEFT OUTER JOIN ClientMIDefinition cm WITH (NOLOCK) ON cm.ClientMIDefinition_WORKTYPECODE = 'COSTS' and cm.ClientMIDefinition_Inactive = 0 
			INNER JOIN ClientMIFieldSet cf WITH (NOLOCK) ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 
			INNER JOIN MIFieldDefinition mf WITH (NOLOCK) ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0
			WHERE c.Case_CaseID = @pCase_CaseID and mf.MIFieldDefinition_DataField <> 'n/a' and ISNULL(mf.MIFieldDefinition_DataField,'') <> ''
			AND c.Case_CostsAssgn = 1
		END
		ELSE
		BEGIN
			--DOES THE MATTER HAVE A CLIENT NUMBER DATASET
			IF EXISTS(SELECT ClientMIDefinition_ClientMIDefinitionID FROM dbo.ClientMIDefinition WITH (NOLOCK) WHERE ClientMIDefinition_CLIENTCODE = (SELECT Case_ClientCode FROM dbo.[Case] WITH (NOLOCK) WHERE Case_CaseID = @pCase_CaseID))
			BEGIN
				--DOES THE MATTER HAVE A COMBO CLIENT NUMBER AND WORKTYPE DATASET
				IF EXISTS(SELECT ClientMIDefinition_ClientMIDefinitionID FROM dbo.ClientMIDefinition WITH (NOLOCK) WHERE ClientMIDefinition_WORKTYPECODE = (SELECT Case_WorkTypeCode FROM dbo.[CASE] WITH (NOLOCK) WHERE Case_CaseID = @pCase_CaseID) AND ClientMIDefinition_CLIENTCODE = (SELECT Case_ClientCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID))
				BEGIN
					--PRINT 'Client number and Worktype'
					--Populate the Tempory table with the MI fields FOR THE COMBO CLIENT NUMBER AND WORKTYPE DATASET
					INSERT INTO @TEMPTABLE1(FIELDCODE, COLNAME, COLTYPE)
					SELECT 
						mf.MIFieldDefinition_MIFieldCode, 
						mf.MIFieldDefinition_DataField, 
						mf.MIFieldDefinition_MIFieldTypeCode 
					FROM dbo.[Case] c WITH (NOLOCK) INNER JOIN
					dbo.ClientMIDefinition cm WITH (NOLOCK) ON c.Case_ClientCode = cm.ClientMIDefinition_CLIENTCODE and c.Case_WorkTypeCode = cm.ClientMIDefinition_WORKTYPECODE and cm.ClientMIDefinition_Inactive = 0 
					INNER JOIN dbo.ClientMIFieldSet cf WITH (NOLOCK) ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 
					INNER JOIN dbo.MIFieldDefinition mf WITH (NOLOCK) ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0
					WHERE c.Case_CaseID = @pCase_CaseID and mf.MIFieldDefinition_DataField <> 'n/a' and ISNULL(mf.MIFieldDefinition_DataField,'') <> ''				
				END
				ELSE		
				BEGIN
					------PRINT 'Client number only'
					--Populate the Tempory table with the MI fields FOR THE CLIENT NUMBER DATASET
					INSERT INTO @TEMPTABLE1(FIELDCODE, COLNAME, COLTYPE)
					SELECT 
						mf.MIFieldDefinition_MIFieldCode, 
						mf.MIFieldDefinition_DataField, 
						mf.MIFieldDefinition_MIFieldTypeCode 
					FROM dbo.[Case] c WITH (NOLOCK) 
					INNER JOIN dbo.ClientMIDefinition cm WITH (NOLOCK) ON c.Case_ClientCode = cm.ClientMIDefinition_MIDEFCODE and cm.ClientMIDefinition_Inactive = 0 
					INNER JOIN dbo.ClientMIFieldSet cf WITH (NOLOCK)  ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 
					INNER JOIN dbo.MIFieldDefinition mf WITH (NOLOCK)  ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0
					WHERE c.Case_CaseID = @pCase_CaseID and mf.MIFieldDefinition_DataField <> 'n/a' and ISNULL(mf.MIFieldDefinition_DataField,'') <> ''	
				END
			END
			ELSE	
			BEGIN
				--DOES THE MATTER HAVE A CLIENT GROUP DATASET
				IF EXISTS(SELECT 1 FROM dbo.ClientMIDefinition WITH (NOLOCK) WHERE ClientMIDefinition_CLIENTGROUPCODE = (SELECT Case_GroupCode FROM dbo.[Case] WITH (NOLOCK) WHERE Case_CaseID = @pCase_CaseID))
				BEGIN
					--DOES THE MATTER HAVE A COMBO CLIENT GROUP AND WORKTYPE DATASET
					IF EXISTS(SELECT ClientMIDefinition_ClientMIDefinitionID FROM dbo.ClientMIDefinition WITH (NOLOCK) WHERE ClientMIDefinition_WORKTYPECODE = (SELECT Case_WorkTypeCode FROM dbo.[Case] WITH (NOLOCK) WHERE Case_CaseID = @pCase_CaseID) AND ClientMIDefinition_CLIENTGROUPCODE = (SELECT Case_GroupCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID))
					BEGIN
						------PRINT 'Group code and Worktype'
						--Populate the Tempory table with the MI fields FOR THE COMBO CLIENT GROUP AND WORKTYPE DATASET
						INSERT INTO @TEMPTABLE1(FIELDCODE, COLNAME, COLTYPE)
						SELECT mf.MIFieldDefinition_MIFieldCode, mf.MIFieldDefinition_DataField, mf.MIFieldDefinition_MIFieldTypeCode 
						FROM dbo.[Case] c WITH (NOLOCK) 
						INNER JOIN ClientMIDefinition cm WITH (NOLOCK) ON c.Case_GroupCode = cm.ClientMIDefinition_CLIENTGROUPCODE and c.Case_WorkTypeCode = cm.ClientMIDefinition_WORKTYPECODE and cm.ClientMIDefinition_Inactive = 0 
						INNER JOIN ClientMIFieldSet cf WITH (NOLOCK) ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 
						INNER JOIN MIFieldDefinition mf WITH (NOLOCK) ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0
						WHERE c.Case_CaseID = @pCase_CaseID and mf.MIFieldDefinition_DataField <> 'n/a' and ISNULL(mf.MIFieldDefinition_DataField,'') <> ''					
					END
					ELSE		
					BEGIN
						IF @pCaseContactID > 0
						BEGIN
							--PRINT 'Group Code only Contact'
							--Populate the Tempory table with the MI fields FOR THE CLIENT GROUP DATASET
							INSERT INTO @TEMPTABLE1(FIELDCODE, COLNAME, COLTYPE,CONTACTID)
							SELECT mf.MIFieldDefinition_MIFieldCode, mf.MIFieldDefinition_DataField, mf.MIFieldDefinition_MIFieldTypeCode, @pCaseContactID 
							FROM dbo.[Case] c WITH (NOLOCK) 
							INNER JOIN ClientMIDefinition cm WITH (NOLOCK) ON c.Case_GroupCode = cm.ClientMIDefinition_CLIENTGROUPCODE and cm.ClientMIDefinition_Inactive = 0 
							INNER JOIN ClientMIFieldSet cf WITH (NOLOCK) ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 
							INNER JOIN MIFieldDefinition mf WITH (NOLOCK) ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0
							WHERE c.Case_CaseID = @pCase_CaseID 
							AND cm.ClientMIDefinition_IsClaimant = 1
						END
						ELSE
						BEGIN
							--PRINT 'Group Code only'
							--Populate the Tempory table with the MI fields FOR THE CLIENT GROUP DATASET
							INSERT INTO @TEMPTABLE1(FIELDCODE, COLNAME, COLTYPE)
							SELECT mf.MIFieldDefinition_MIFieldCode, mf.MIFieldDefinition_DataField, mf.MIFieldDefinition_MIFieldTypeCode 
							FROM dbo.[Case] c WITH (NOLOCK) INNER JOIN
							ClientMIDefinition cm WITH (NOLOCK) ON c.Case_GroupCode = cm.ClientMIDefinition_MIDEFCODE and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
							ClientMIFieldSet cf WITH (NOLOCK) ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 INNER JOIN
							MIFieldDefinition mf WITH (NOLOCK) ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0
							WHERE c.Case_CaseID = @pCase_CaseID and mf.MIFieldDefinition_DataField <> 'n/a' and ISNULL(mf.MIFieldDefinition_DataField,'') <> ''																		
						END						
					END
				END
				ELSE
				BEGIN
					--PRINT 'Worktype only'
					--Populate the Tempory table with the MI fields FOR THE WORKTYPE DATASET
					INSERT INTO @TEMPTABLE1(FIELDCODE, COLNAME, COLTYPE)
					SELECT mf.MIFieldDefinition_MIFieldCode, mf.MIFieldDefinition_DataField, mf.MIFieldDefinition_MIFieldTypeCode 
					FROM dbo.[Case] c WITH (NOLOCK)  
					INNER JOIN ClientMIDefinition cm WITH (NOLOCK) ON c.Case_WorkTypeCode = cm.ClientMIDefinition_MIDEFCODE and cm.ClientMIDefinition_Inactive = 0 
					INNER JOIN ClientMIFieldSet cf WITH (NOLOCK) ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 
					INNER JOIN MIFieldDefinition mf WITH (NOLOCK) ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0
					WHERE c.Case_CaseID = @pCase_CaseID and mf.MIFieldDefinition_DataField <> 'n/a' and ISNULL(mf.MIFieldDefinition_DataField,'') <> ''
				END
			END
		END

		--Declare the temporty table that will be used to map the mi fields to there current data values
		DECLARE @TEMPTABLE2 TABLE
		(
			ResultID					INT,
			FSID						INT,
			FIELDCODE					nvarchar(255),
			RDONLY						bit,
			COLVALUE					nvarchar(255),
			PMSField					bit
		)

		INSERT INTO @TEMPTABLE2
			EXEC [dbo].[MIData_Fetch] @pCase_CaseID, @pReturnData OUTPUT, @pUser_Name, @pGetCosts, @pCaseContactID
		
		UPDATE tmp1
		SET tmp1.COLVALUE = tmp2.COLVALUE
		FROM @TEMPTABLE1 tmp1
		INNER JOIN @TEMPTABLE2 tmp2 
		ON tmp1.FIELDCODE  = tmp2.FIELDCODE

		--IF WE ARE RETRIVING A COSTS SET
		IF @pGetCosts = 1
		BEGIN
			--WORKTYPE
			IF ISNULL(@pCaseContactID, 0) > 0
			BEGIN
				SELECT 
					cc.CaseContacts_SearchName AS CLIENT_NAME, 
					cm.ClientMIDefinition_MIDEFCODE, 
					cf.ClientMIFieldSet_ClientMIDEFCODE + '-' + cf.ClientMIFieldSet_MIFieldDefCode AS ClientMIFieldSetCode, 
					ISNULL(cm.ClientMIDefinition_LKPFilter,'') + '$' + ISNULL(mf.MIFieldDefinition_MILKPFieldCode,'') AS LookUpFilter, 
					cf.ClientMIFieldSet_MIFieldPosition, 
					cf.ClientMIFieldSet_MIFieldLabel, 
					cf.ClientMIFieldSet_MIFieldRO, 
					cf.ClientMIFieldSet_MIFieldMAND,
					mf.MIFieldDefinition_FieldDescription, 
					mf.MIFieldDefinition_DataField, 
					MIFieldDefinition_DataTable, 
					mt.MIFieldTypeDefinition_Description, 
					TP.COLVALUE AS PREVIOUSVALUE,
					cf.ClientMIFieldSet_MIFieldDefCode AS saveFilter,
					cf.ClientMIFieldSet_MIFieldMAND as mandField,
					cf.ClientMIFieldSet_MIFieldRO as roField,
					cf.ClientMIFieldSet_OnChangeText 
				FROM dbo.[Case] c WITH (NOLOCK) 
				INNER JOIN dbo.CaseContacts cc WITH (NOLOCK) ON (c.Case_CaseID = cc.CaseContacts_CaseID) AND (ISNULL(cc.CaseContacts_ClientID,0) <> 0) AND (cc.CaseContacts_Inactive = 0)
				INNER JOIN dbo.ClientMIDefinition cm WITH (NOLOCK) ON cm.ClientMIDefinition_WORKTYPECODE = 'COSTS' and cm.ClientMIDefinition_Inactive = 0 
				INNER JOIN dbo.ClientMIFieldSet cf WITH (NOLOCK) ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 
				INNER JOIN dbo.MIFieldDefinition mf WITH (NOLOCK) ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0 
				INNER JOIN dbo.MIFieldTypeDefinition mt WITH (NOLOCK)  ON mf.MIFieldDefinition_MIFieldTypeCode = mt.MIFieldTypeDefinition_MIFieldTypeCode and mt.MIFieldTypeDefinition_Inactive = 0 
				LEFT OUTER JOIN @TEMPTABLE1 TP ON mf.MIFieldDefinition_MIFieldCode = TP.FIELDCODE 
				WHERE c.Case_CaseID = @pCase_CaseID
				AND TP.CONTACTID = @pCaseContactID
				AND c.Case_CostsAssgn = 1
				ORDER BY cf.ClientMIFieldSet_MIFieldPosition
			END
			ELSE
			BEGIN
				SELECT 
					cc.CaseContacts_SearchName AS CLIENT_NAME,
					cm.ClientMIDefinition_MIDEFCODE, 
					cf.ClientMIFieldSet_ClientMIDEFCODE + '-' + cf.ClientMIFieldSet_MIFieldDefCode AS ClientMIFieldSetCode, 
					ISNULL(cm.ClientMIDefinition_LKPFilter,'') + '$' + ISNULL(mf.MIFieldDefinition_MILKPFieldCode,'') AS LookUpFilter, 
					cf.ClientMIFieldSet_MIFieldPosition, 
					cf.ClientMIFieldSet_MIFieldLabel, 
					cf.ClientMIFieldSet_MIFieldRO, 
					cf.ClientMIFieldSet_MIFieldMAND,
					mf.MIFieldDefinition_FieldDescription, 
					mf.MIFieldDefinition_DataField, 
					MIFieldDefinition_DataTable, 
					mt.MIFieldTypeDefinition_Description, 
					TP.COLVALUE AS PREVIOUSVALUE,
					cf.ClientMIFieldSet_MIFieldDefCode AS saveFilter,
					cf.ClientMIFieldSet_MIFieldMAND as mandField,
					cf.ClientMIFieldSet_MIFieldRO as roField,
					cf.ClientMIFieldSet_OnChangeText 
				FROM dbo.[Case] c WITH (NOLOCK) 
				INNER JOIN dbo.CaseContacts cc WITH (NOLOCK) ON (c.Case_CaseID = cc.CaseContacts_CaseID) AND (ISNULL(cc.CaseContacts_ClientID,0) <> 0) AND (cc.CaseContacts_Inactive = 0)
				INNER JOIN dbo.ClientMIDefinition cm WITH (NOLOCK) ON cm.ClientMIDefinition_WORKTYPECODE = 'COSTS' and cm.ClientMIDefinition_Inactive = 0 
				INNER JOIN dbo.ClientMIFieldSet cf WITH (NOLOCK) ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 
				INNER JOIN dbo.MIFieldDefinition mf WITH (NOLOCK) ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0 
				INNER JOIN dbo.MIFieldTypeDefinition mt WITH (NOLOCK)  ON mf.MIFieldDefinition_MIFieldTypeCode = mt.MIFieldTypeDefinition_MIFieldTypeCode and mt.MIFieldTypeDefinition_Inactive = 0 
				LEFT OUTER JOIN @TEMPTABLE1 TP ON mf.MIFieldDefinition_MIFieldCode = TP.FIELDCODE 
				WHERE c.Case_CaseID = @pCase_CaseID
					AND c.Case_CostsAssgn = 1
				ORDER BY cf.ClientMIFieldSet_MIFieldPosition		
			END			
		END
		ELSE
		BEGIN
			--DOES THE MATTER HAVE A CLIENT NUMBER DATASET
			IF EXISTS(SELECT ClientMIDefinition_ClientMIDefinitionID FROM dbo.ClientMIDefinition WITH (NOLOCK) WHERE ClientMIDefinition_CLIENTCODE = (SELECT Case_ClientCode FROM dbo.[Case] WITH (NOLOCK) WHERE Case_CaseID = @pCase_CaseID))
			BEGIN
				--DOES THE MATTER HAVE A COMBO CLIENT NUMBER AND WORKTYPE DATASET
				IF EXISTS(SELECT ClientMIDefinition_ClientMIDefinitionID FROM dbo.ClientMIDefinition WITH (NOLOCK) WHERE ClientMIDefinition_WORKTYPECODE = (SELECT Case_WorkTypeCode FROM dbo.[Case] WITH (NOLOCK) WHERE Case_CaseID = @pCase_CaseID) AND ClientMIDefinition_CLIENTCODE = (SELECT Case_ClientCode FROM dbo.[Case] WITH (NOLOCK) WHERE Case_CaseID = @pCase_CaseID))
				BEGIN
					--PRINT 'Client number and Worktype'
					--return the MI fields with previous data FOR THE COMBO CLIENT NUMBER AND WORKTYPE DATASET
					SELECT 
						cc.CaseContacts_SearchName AS CLIENT_NAME,
						cm.ClientMIDefinition_MIDEFCODE, 
						cf.ClientMIFieldSet_ClientMIDEFCODE + '-' + cf.ClientMIFieldSet_MIFieldDefCode AS ClientMIFieldSetCode, 
						ISNULL(cm.ClientMIDefinition_LKPFilter,'') + '$' + ISNULL(mf.MIFieldDefinition_MILKPFieldCode,'') AS LookUpFilter, 
						cf.ClientMIFieldSet_MIFieldPosition, 
						cf.ClientMIFieldSet_MIFieldLabel, 
						cf.ClientMIFieldSet_MIFieldRO, 
						cf.ClientMIFieldSet_MIFieldMAND,
						mf.MIFieldDefinition_FieldDescription, 
						mf.MIFieldDefinition_DataField, 
						MIFieldDefinition_DataTable, 
						mt.MIFieldTypeDefinition_Description, 
						TP.COLVALUE AS PREVIOUSVALUE,
						cf.ClientMIFieldSet_MIFieldDefCode AS saveFilter,
						cf.ClientMIFieldSet_MIFieldMAND as mandField,
						cf.ClientMIFieldSet_MIFieldRO as roField,
						cf.ClientMIFieldSet_OnChangeText
					FROM dbo.[Case] c WITH (NOLOCK) 
					INNER JOIN dbo.CaseContacts cc WITH (NOLOCK)  ON (c.Case_CaseID = cc.CaseContacts_CaseID) AND (ISNULL(cc.CaseContacts_ClientID,0) <> 0) AND (cc.CaseContacts_Inactive = 0)
					INNER JOIN dbo.ClientMIDefinition cm WITH (NOLOCK)  ON c.Case_ClientCode = cm.ClientMIDefinition_CLIENTCODE and c.Case_WorkTypeCode = cm.ClientMIDefinition_WORKTYPECODE and cm.ClientMIDefinition_Inactive = 0 
					INNER JOIN dbo.ClientMIFieldSet cf WITH (NOLOCK)  ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 
					INNER JOIN dbo.MIFieldDefinition mf WITH (NOLOCK)  ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0 
					INNER JOIN dbo.MIFieldTypeDefinition mt WITH (NOLOCK)  ON mf.MIFieldDefinition_MIFieldTypeCode = mt.MIFieldTypeDefinition_MIFieldTypeCode and mt.MIFieldTypeDefinition_Inactive = 0 
					LEFT OUTER JOIN @TEMPTABLE1 TP ON mf.MIFieldDefinition_MIFieldCode = TP.FIELDCODE 
					WHERE c.Case_CaseID = @pCase_CaseID
					ORDER BY cf.ClientMIFieldSet_MIFieldPosition
				END
				ELSE		
				BEGIN
					--PRINT 'Client number only'
					--return the MI fields with previous data FOR THE CLIENT NUMBER DATASET
					SELECT 
						cc.CaseContacts_SearchName AS CLIENT_NAME, 
						cm.ClientMIDefinition_MIDEFCODE, 
						cf.ClientMIFieldSet_ClientMIDEFCODE + '-' + cf.ClientMIFieldSet_MIFieldDefCode AS ClientMIFieldSetCode, 
						ISNULL(cm.ClientMIDefinition_LKPFilter,'') + '$' + ISNULL(mf.MIFieldDefinition_MILKPFieldCode,'') AS LookUpFilter, 
						cf.ClientMIFieldSet_MIFieldPosition, 
						cf.ClientMIFieldSet_MIFieldLabel, 
						cf.ClientMIFieldSet_MIFieldRO, 
						cf.ClientMIFieldSet_MIFieldMAND,
						mf.MIFieldDefinition_FieldDescription, 
						mf.MIFieldDefinition_DataField, 
						MIFieldDefinition_DataTable, 
						mt.MIFieldTypeDefinition_Description, 
						TP.COLVALUE AS PREVIOUSVALUE,
						cf.ClientMIFieldSet_MIFieldDefCode AS saveFilter,
						cf.ClientMIFieldSet_MIFieldMAND as mandField,
						cf.ClientMIFieldSet_MIFieldRO as roField,
						cf.ClientMIFieldSet_OnChangeText
					FROM dbo.[Case] c WITH (NOLOCK) 
					INNER JOIN dbo.CaseContacts cc WITH (NOLOCK) ON (c.Case_CaseID = cc.CaseContacts_CaseID) AND (ISNULL(cc.CaseContacts_ClientID,0) <> 0) AND (cc.CaseContacts_Inactive = 0)
					INNER JOIN dbo.ClientMIDefinition cm WITH (NOLOCK) ON c.Case_ClientCode = cm.ClientMIDefinition_MIDEFCODE and cm.ClientMIDefinition_Inactive = 0 
					INNER JOIN dbo.ClientMIFieldSet cf WITH (NOLOCK) ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 
					INNER JOIN dbo.MIFieldDefinition mf WITH (NOLOCK) ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0 
					INNER JOIN dbo.MIFieldTypeDefinition mt WITH (NOLOCK) ON mf.MIFieldDefinition_MIFieldTypeCode = mt.MIFieldTypeDefinition_MIFieldTypeCode and mt.MIFieldTypeDefinition_Inactive = 0 
					LEFT OUTER JOIN @TEMPTABLE1 TP ON mf.MIFieldDefinition_MIFieldCode = TP.FIELDCODE 
					WHERE c.Case_CaseID = @pCase_CaseID
					ORDER BY cf.ClientMIFieldSet_MIFieldPosition
				END
			END
			ELSE	
			BEGIN
				--DOES THE MATTER HAVE A CLIENT GROUP DATASET
				IF EXISTS(SELECT * FROM dbo.ClientMIDefinition WITH (NOLOCK) WHERE ClientMIDefinition_CLIENTGROUPCODE = (SELECT Case_GroupCode FROM dbo.[Case] WITH (NOLOCK) WHERE Case_CaseID = @pCase_CaseID))
				BEGIN
					--DOES THE MATTER HAVE A COMBO CLIENT GROUP AND WORKTYPE DATASET
					IF EXISTS(SELECT ClientMIDefinition_ClientMIDefinitionID FROM dbo.ClientMIDefinition WITH (NOLOCK) WHERE ClientMIDefinition_WORKTYPECODE = (SELECT Case_WorkTypeCode FROM dbo.[Case] WITH (NOLOCK) WHERE Case_CaseID = @pCase_CaseID) AND ClientMIDefinition_CLIENTGROUPCODE = (SELECT Case_GroupCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID))
					BEGIN
						--PRINT 'Group code and Worktype'
						SELECT 
							cc.CaseContacts_SearchName AS CLIENT_NAME, 
							cm.ClientMIDefinition_MIDEFCODE, 
							cf.ClientMIFieldSet_ClientMIDEFCODE + '-' + cf.ClientMIFieldSet_MIFieldDefCode AS ClientMIFieldSetCode, 
							ISNULL(cm.ClientMIDefinition_LKPFilter,'') + '$' + ISNULL(mf.MIFieldDefinition_MILKPFieldCode,'') AS LookUpFilter, 
							cf.ClientMIFieldSet_MIFieldPosition, 
							cf.ClientMIFieldSet_MIFieldLabel, 
							cf.ClientMIFieldSet_MIFieldRO, 
							cf.ClientMIFieldSet_MIFieldMAND,
							mf.MIFieldDefinition_FieldDescription,
							mf.MIFieldDefinition_DataField, 
							MIFieldDefinition_DataTable, 
							mt.MIFieldTypeDefinition_Description, 
							TP.COLVALUE AS PREVIOUSVALUE,
							cf.ClientMIFieldSet_MIFieldDefCode AS saveFilter,
							cf.ClientMIFieldSet_MIFieldMAND as mandField,
							cf.ClientMIFieldSet_MIFieldRO as roField,
							cf.ClientMIFieldSet_OnChangeText
						FROM dbo.[Case] c WITH (NOLOCK) 
						INNER JOIN dbo.CaseContacts cc WITH (NOLOCK) ON (c.Case_CaseID = cc.CaseContacts_CaseID) AND (ISNULL(cc.CaseContacts_ClientID,0) <> 0) AND (cc.CaseContacts_Inactive = 0)
						INNER JOIN dbo.ClientMIDefinition cm WITH (NOLOCK) ON c.Case_GroupCode = cm.ClientMIDefinition_CLIENTGROUPCODE and c.Case_WorkTypeCode = cm.ClientMIDefinition_WORKTYPECODE and cm.ClientMIDefinition_Inactive = 0 
						INNER JOIN dbo.ClientMIFieldSet cf WITH (NOLOCK) ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 
						INNER JOIN dbo.MIFieldDefinition mf WITH (NOLOCK) ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0 
						INNER JOIN dbo.MIFieldTypeDefinition mt WITH (NOLOCK) ON mf.MIFieldDefinition_MIFieldTypeCode = mt.MIFieldTypeDefinition_MIFieldTypeCode and mt.MIFieldTypeDefinition_Inactive = 0 
						LEFT OUTER JOIN @TEMPTABLE1 TP ON mf.MIFieldDefinition_MIFieldCode = TP.FIELDCODE 
						WHERE c.Case_CaseID = @pCase_CaseID
						ORDER BY cf.ClientMIFieldSet_MIFieldPosition
					END
					ELSE		
					BEGIN
						IF @pCaseContactID > 0
						BEGIN				
							--return the MI fields with previous data FOR THE CLIENT GROUP DATASET
							SELECT DISTINCT 
								cc.CaseContacts_SearchName AS CLIENT_NAME, 
								cm.ClientMIDefinition_MIDEFCODE, cf.ClientMIFieldSet_ClientMIDEFCODE + '-' + cf.ClientMIFieldSet_MIFieldDefCode AS ClientMIFieldSetCode, 
								ISNULL(cm.ClientMIDefinition_LKPFilter,'') + '$' + ISNULL(mf.MIFieldDefinition_MILKPFieldCode,'') AS LookUpFilter, 
								cf.ClientMIFieldSet_MIFieldPosition, 
								cf.ClientMIFieldSet_MIFieldLabel, 
								cf.ClientMIFieldSet_MIFieldRO, 
								cf.ClientMIFieldSet_MIFieldMAND,
								mf.MIFieldDefinition_FieldDescription, 
								mf.MIFieldDefinition_DataField, 
								MIFieldDefinition_DataTable, 
								mt.MIFieldTypeDefinition_Description, 
								TP.COLVALUE AS PREVIOUSVALUE,
								cf.ClientMIFieldSet_MIFieldDefCode AS saveFilter,
								cf.ClientMIFieldSet_MIFieldMAND as mandField,
								cf.ClientMIFieldSet_MIFieldRO as roField,
								cf.ClientMIFieldSet_OnChangeText
							FROM dbo.[Case] c WITH (NOLOCK) 
							INNER JOIN dbo.CaseContacts cc WITH (NOLOCK) ON (c.Case_CaseID = cc.CaseContacts_CaseID) AND (ISNULL(cc.CaseContacts_ClientID,0) <> 0) AND (cc.CaseContacts_Inactive = 0)
							INNER JOIN dbo.ClientMIDefinition cm WITH (NOLOCK) ON c.Case_GroupCode = cm.ClientMIDefinition_CLIENTGROUPCODE and cm.ClientMIDefinition_Inactive = 0 
							INNER JOIN dbo.ClientMIFieldSet cf WITH (NOLOCK) ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 
							INNER JOIN dbo.MIFieldDefinition mf WITH (NOLOCK) ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0 
							INNER JOIN dbo.MIFieldTypeDefinition mt WITH (NOLOCK) ON mf.MIFieldDefinition_MIFieldTypeCode = mt.MIFieldTypeDefinition_MIFieldTypeCode and mt.MIFieldTypeDefinition_Inactive = 0 
							LEFT OUTER JOIN @TEMPTABLE1 TP ON mf.MIFieldDefinition_MIFieldCode = TP.FIELDCODE
							WHERE c.Case_CaseID = @pCase_CaseID
								AND TP.CONTACTID = @pCaseContactID
								AND cm.ClientMIDefinition_IsClaimant = 1
							ORDER BY cf.ClientMIFieldSet_MIFieldPosition
							
						END
						ELSE
						BEGIN								
							--- Changed by CKJ to avoid the use of HBM_CLIENT table
							SELECT 
								cc.CaseContacts_SearchName AS CLIENT_NAME,
								cm.ClientMIDefinition_MIDEFCODE, 
								cf.ClientMIFieldSet_ClientMIDEFCODE + '-' + cf.ClientMIFieldSet_MIFieldDefCode AS ClientMIFieldSetCode, 
								ISNULL(cm.ClientMIDefinition_LKPFilter,'') + '$' + ISNULL(mf.MIFieldDefinition_MILKPFieldCode,'') AS LookUpFilter, 
								cf.ClientMIFieldSet_MIFieldPosition, 
								cf.ClientMIFieldSet_MIFieldLabel, cf.ClientMIFieldSet_MIFieldRO, 
								cf.ClientMIFieldSet_MIFieldMAND,
								mf.MIFieldDefinition_FieldDescription, 
								mf.MIFieldDefinition_DataField, MIFieldDefinition_DataTable, 
								mt.MIFieldTypeDefinition_Description, 
								TP.COLVALUE AS PREVIOUSVALUE,
								cf.ClientMIFieldSet_MIFieldDefCode AS saveFilter,
								cf.ClientMIFieldSet_MIFieldMAND as mandField,
								cf.ClientMIFieldSet_MIFieldRO as roField,
								cf.ClientMIFieldSet_OnChangeText
							FROM dbo.[Case] c WITH (NOLOCK) 
							INNER JOIN dbo.CaseContacts cc WITH (NOLOCK) ON (c.Case_CaseID = cc.CaseContacts_CaseID) AND (ISNULL(cc.CaseContacts_ClientID,0) <> 0) AND (cc.CaseContacts_Inactive = 0)
							INNER JOIN dbo.ClientMIDefinition cm WITH (NOLOCK) ON c.Case_GroupCode = cm.ClientMIDefinition_MIDEFCODE and cm.ClientMIDefinition_Inactive = 0 
							INNER JOIN dbo.ClientMIFieldSet cf WITH (NOLOCK) ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 
							INNER JOIN dbo.MIFieldDefinition mf WITH (NOLOCK) ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0 
							INNER JOIN dbo.MIFieldTypeDefinition mt WITH (NOLOCK) ON mf.MIFieldDefinition_MIFieldTypeCode = mt.MIFieldTypeDefinition_MIFieldTypeCode and mt.MIFieldTypeDefinition_Inactive = 0 
							LEFT OUTER JOIN @TEMPTABLE1 TP		ON mf.MIFieldDefinition_MIFieldCode = TP.FIELDCODE
							WHERE c.Case_CaseID = @pCase_CaseID
							ORDER BY cf.ClientMIFieldSet_MIFieldPosition					
						END
					END
				END
				ELSE
				BEGIN
					SELECT 
						cc.CaseContacts_SearchName AS CLIENT_NAME, 
						cm.ClientMIDefinition_MIDEFCODE, 
						cf.ClientMIFieldSet_ClientMIDEFCODE + '-' + cf.ClientMIFieldSet_MIFieldDefCode AS ClientMIFieldSetCode, 
						ISNULL(cm.ClientMIDefinition_LKPFilter,'') + '$' + ISNULL(mf.MIFieldDefinition_MILKPFieldCode,'') AS LookUpFilter, 
						cf.ClientMIFieldSet_MIFieldPosition, 
						cf.ClientMIFieldSet_MIFieldLabel, 
						cf.ClientMIFieldSet_MIFieldRO, 
						cf.ClientMIFieldSet_MIFieldMAND,
						mf.MIFieldDefinition_FieldDescription, 
						mf.MIFieldDefinition_DataField, 
						MIFieldDefinition_DataTable, 
						mt.MIFieldTypeDefinition_Description, 
						TP.COLVALUE AS PREVIOUSVALUE,
						cf.ClientMIFieldSet_MIFieldDefCode AS saveFilter,
						cf.ClientMIFieldSet_MIFieldMAND as mandField,
						cf.ClientMIFieldSet_MIFieldRO as roField,
						cf.ClientMIFieldSet_OnChangeText 
					FROM dbo.[Case] c WITH (NOLOCK) 
					INNER JOIN dbo.CaseContacts cc WITH (NOLOCK) ON (c.Case_CaseID = cc.CaseContacts_CaseID) AND (ISNULL(cc.CaseContacts_ClientID,0) <> 0) AND (cc.CaseContacts_Inactive = 0)
					INNER JOIN dbo.ClientMIDefinition cm WITH (NOLOCK) ON c.Case_WorkTypeCode = cm.ClientMIDefinition_MIDEFCODE and cm.ClientMIDefinition_Inactive = 0 
					INNER JOIN dbo.ClientMIFieldSet cf WITH (NOLOCK) ON cm.ClientMIDefinition_MIDEFCODE = cf.ClientMIFieldSet_ClientMIDEFCODE and cf.ClientMIFieldSet_Inactive = 0 
					INNER JOIN dbo.MIFieldDefinition mf WITH (NOLOCK) ON cf.ClientMIFieldSet_MIFieldDefCode = mf.MIFieldDefinition_MIFieldCode and mf.MIFieldDefinition_Inactive = 0 
					INNER JOIN dbo.MIFieldTypeDefinition mt WITH (NOLOCK) ON mf.MIFieldDefinition_MIFieldTypeCode = mt.MIFieldTypeDefinition_MIFieldTypeCode and mt.MIFieldTypeDefinition_Inactive = 0 
					LEFT OUTER JOIN @TEMPTABLE1 TP ON mf.MIFieldDefinition_MIFieldCode = TP.FIELDCODE 
					WHERE c.Case_CaseID = @pCase_CaseID
					ORDER BY cf.ClientMIFieldSet_MIFieldPosition			
				END
			END
		END
	END TRY
	
	BEGIN CATCH		
		SELECT ERROR_MESSAGE() + 'SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH
END

