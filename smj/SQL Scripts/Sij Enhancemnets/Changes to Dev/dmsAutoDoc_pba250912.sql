USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[dmsBookmark_AutoDoc]    Script Date: 09/25/2012 16:01:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[dmsBookmark_AutoDoc]
(
	-- Mandatory Fields
	@pdmsTemplates_TemplateCode			nvarchar(255) = '',
	@pCASEID							INT = 0,
	@pUserName							nvarchar(255), -- Mandatory. Map System.Username for Current User	
	-- Additional fields (Optional)
		-- Case Fee earner
	@pFeeEarner							nvarchar(255) = null, 
	-- Whether the "Private and Confidential" is displayed
	@pPrivConf							nvarchar(255)= null, 
	-- Used for 'Referencial Code'
	@pRefCode							nvarchar(255)= null, 
	-- Used for 'Matter Payment Description'
	@pMatterDesc						nvarchar(255)= null, 
	-- The contact on the case the letter is for 
	@pContactID							nvarchar(255)= null, 
	-- The 2nd contact on the case the letter is for
	@pContact2ID						nvarchar(255)= null,
	-- File Description 
	@pAppTaskDescription				nvarchar(255)= null,
	-- Salutation
	@pSalutation						nvarchar(255)= null, 
	-- Valediction 
	@pValediction						nvarchar(255)= null
)
AS
	-- ==========================================================================================
	-- Updated:		PBA
	-- Version:		2.4
	-- Updated date: 240812
	-- Based on 'Template input screen' and 'bookmark data fetch'
	-- ==========================================================================================
	
	-- Testing 
	--set @pContactID		= 2885
	
	--Initialise Error trapping	
	SET NOCOUNT ON
	SET ARITHABORT ON

	DECLARE @myLastError int 
	SELECT @myLastError = 0
	DECLARE @myLastErrorString nvarchar(255)
	SELECT @myLastErrorString = ''
	
	--Declare local variables
	DECLARE @COUNTER AS INT = 1
	DECLARE @COUNTER2 AS INT = 1
	DECLARE @MAXID AS INT = 0
	DECLARE @IDVAL AS NVARCHAR(MAX)
	DECLARE @INACTIVE AS NVARCHAR(MAX)
	
	-- Template Variables
	DECLARE @dmsTemplateDescription			AS nvarchar(MAX) = ''
	DECLARE @dmsTemplatePath				AS nvarchar(MAX) = ''
	DECLARE @TemplateSupReq					AS nvarchar(MAX) = ''
	declare @dmsDocumentName				as nvarchar(max) = ''
	declare @dmsTemplateTitle				as nvarchar(max) = ''
	declare @dmsDocumentLocation			as nvarchar(max) = ''
	
	-- 2nd Part variables
	declare @pTemplateCode 					as nvarchar(max)
	DECLARE @NoField						AS int = 0
	DECLARE @Count							AS int = 1
	DECLARE @BOOKMARKADVSQL					AS nvarchar(MAX) = ''
	DECLARE @IVAL							AS nvarchar(MAX) = ''
	DECLARE @BOOKMARKTABLE					AS nvarchar(MAX) = ''
	DECLARE @BOOKMARKFIELD					AS nvarchar(MAX) = ''
	DECLARE @BOOKMARKCODE					AS nvarchar(MAX) = ''
	DECLARE @InputTest						AS nvarchar(MAX) = ''
	declare @tmpPipeValue					as nvarchar(max) = ''
	declare @tmpBookmarkData				as nvarchar(max) = ''
	declare @bookmarkData					as nvarchar(max) = ''
	declare @tmpBookmarkAlias				as nvarchar(max) = ''
	declare @bookmarkAlias					as nvarchar(max) = ''
	DECLARE @INPUTTABLE						AS nvarchar(MAX) = ''
	DECLARE @INPUTFIELD						AS nvarchar(MAX) = ''
	DECLARE @INPUTTYPE						AS nvarchar(MAX) = ''
	DECLARE @INPCODE						AS nvarchar(MAX) = ''
	DECLARE @STRSQL							AS nvarchar(MAX) = ''
	DECLARE @clientUNO						AS nvarchar(MAX) = ''
	DECLARE @matterUNO						AS nvarchar(MAX) = ''
	DECLARE @filePath						AS nvarchar(MAX) = ''
	--SMJ
	DECLARE @Server							AS VARCHAR(50) = ''
	DECLARE @TemplatesPath					AS VARCHAR(100)
	DECLARE @errNoUsername					AS VARCHAR(50)
	DECLARE @errNoTemplate					AS VARCHAR(50)
	DECLARE @errNoCaseID					AS VARCHAR(50)
	DECLARE @errNoServer					AS VARCHAR(50)
	DECLARE @errNoTemplatePath				AS VARCHAR(50)
	declare @now as datetime

	--SMJ - Set error messages
	SET @errNoUsername = '@pUserName not supplied'
	SET @errNoTemplate = '@pdmsTemplates_TemplateCode not supplied'
	SET @errNoCaseID = '@pCASEID not supplied'
	SET @errNoServer = 'Could not find server'
	SET @errNoTemplatePath = 'Could not find Templates Path'
	set @now = GETDATE()
	--
	
	BEGIN TRY
		-- // Check Inputs \\ --
		
		--SMJ - Error-checking
		-- Username
		IF (@pUserName = '')
			RAISERROR (@errNoUsername, 16, 1)
		
		-- Template
		IF (@pdmsTemplates_TemplateCode	 = '')
			RAISERROR (@errNoTemplate, 16, 1)
		
		-- Case ID
		IF (@pCASEID = '')
			RAISERROR (@errNoCaseID, 16, 1)
		
		--GET SERVER
		SELECT @Server = SystemSettings_ServerName FROM SystemSettings 
		IF (@Server = '')
			RAISERROR (@errNoTemplatePath, 16, 1)		
			
		--GET TEMPLATES	PATH
		SELECT @TemplatesPath = SystemSettings_TemplatesLocation FROM SystemSettings 
		IF (@TemplatesPath = '')
			RAISERROR (@errNoServer, 16, 1)					
		----
		
		-- Get Client and matter Uno
		SELECT @clientUno = [Case_MatterUno] 
			, @matterUNO = [Case_ClientUno] 
		 FROM [Flosuite_Data_Dev].[dbo].[Case]
		where Case_CaseID = @pCASEID
		
		set @filePath = @matterUNO + '\' + @clientUNO + '\'
		
		-- // Set up data for bookmarks \\ -- '
		
		-- CREATE TEMPORY TABLE TO HOLD - TemplateDetails
		
		DECLARE @DocumentTemplateDetails TABLE
		(
			dmsTemplateDesc nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			dmsDocumentName nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			dmsTemplatePath nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			dmsTemplateSupervisionRequired nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			dmsDocumentLocation nvarchar(256) COLLATE DATABASE_DEFAULT NULL
		)
			
		-- Insert the results into the table
		INSERT INTO @DocumentTemplateDetails(
				-- Where the template is held
				dmsTemplatePath,
				-- Template name (.dot)
				dmsTemplateDesc,
				-- Where the final file should be saved
				dmsDocumentLocation,
				-- Final name of the file (.doc)
				dmsDocumentName, 
				-- Whether or not supervision is required
				dmsTemplateSupervisionRequired
				)
				
		--SMJ - Remove hard-coded references to server, templates location and DB				
		SELECT 
		-- Template path with the \folder\ added
			'\\' + @Server + '\c$'+ @TemplatesPath + left([dmsTemplates_TemplatePath], (CHARINDEX('\', right([dmsTemplates_TemplatePath],LEN([dmsTemplates_TemplatePath])-1 )))+1) 
		   -- template name with \folder\ removed '
			,right([dmsTemplates_TemplatePath], LEN([dmsTemplates_TemplatePath])- (CHARINDEX('\', right([dmsTemplates_TemplatePath],LEN([dmsTemplates_TemplatePath])-1 )))-1)
		   -- Manual path PBA '
		  , '\\' + @Server + '\c$' +  LEFT (@TemplatesPath, LEN(@TemplatesPath) -10) + '\DocStore\' + @filePath 
		  ,[dmsTemplates_TemplateDesc] --+ '.doc'
		  ,[dmsTemplates_ReqSup]     
	  FROM [dmsTemplates] 
	  -- Find only the active template '
	  where dmsTemplates_TemplateCode = @pdmsTemplates_TemplateCode	and dmsTemplates_InActive = 0
	  ----
	  
	  -- Update file name and remove &
	 --update @DocumentTemplateDetails set dmsDocumentName = replace(dmsDocumentName,'&','and') 
			
	  -- Update variables with information
	  select @dmsDocumentName = dmsDocumentName, @dmsTemplateDescription = dmsTemplateDesc, @dmsTemplatePath = dmsTemplatePath, @TemplateSupReq = dmsTemplateSupervisionRequired, @dmsDocumentLocation = dmsDocumentLocation from @DocumentTemplateDetails 
		
		 -- Check if there is a file name passed in  
	  IF (@pAppTaskDescription <> '')
		begin
			set @dmsDocumentName = @pAppTaskDescription --+ '.doc' 
		end 	
		
		-- set @dmsDocumentName = replace(@dmsDocumentName,'&','and')
		set @dmsTemplateTitle = @dmsDocumentName 
		set @dmsDocumentName = @dmsDocumentName + ' ' + CONVERT(VARCHAR(12), GETDATE(), 100) + CONVERT(VARCHAR(8), GETDATE(), 114) + ' 01'
		set @dmsDocumentName = replace(@dmsDocumentName,':',' ') 
		
		--CREATE TEMPORY TABLE TO HOLD - Document Inputs
		
		DECLARE @DocumentInputsTable TABLE
		(
			dmsTemplates_TemplateCode nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			dmsTemplatesInputs_InputLabel nvarchar(MAX) COLLATE DATABASE_DEFAULT NULL,
			dmsInputs_InputGroup nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			dmsInputs_InputCode nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			dmsInputs_InputCode2 nvarchar(256) COLLATE DATABASE_DEFAULT NULL,
			dmsTemplatesInputs_Mandatory bit Null,
			dmsTemplatesDescription_DescriptionString nvarchar(MAX) COLLATE DATABASE_DEFAULT NULL
		)
			
		-- Update table with the inputs
		declare @contacts table
		( role nvarchar(255), contactID int, inputCode nvarchar(50))
		
		insert into @contacts
		SELECT dmsinputcontactlookup_rolecode, CaseContacts_CaseContactsID, dmsinputcontactlookup_inputcode
		FROM dmsInputContactLookup
		inner join casecontacts on CaseContacts_RoleCode = dmsinputcontactlookup_rolecode
		where casecontacts_caseid = @pCaseID and casecontacts_inactive = 0
		
		-- Update inputcodes for table
		update @contacts
		set inputCode = dmsInputContactLookup_InputCode 
		from @contacts
		inner join dmsInputContactLookup on dmsInputContactLookup_RoleCode = role 
		
		INSERT INTO @DocumentInputsTable(
				dmsTemplates_TemplateCode,
				dmsTemplatesInputs_InputLabel,
				dmsInputs_InputCode,
				dmsInputs_InputCode2,
				dmsTemplatesInputs_Mandatory,
				dmsTemplatesDescription_DescriptionString)
		SELECT	t.dmsTemplates_TemplateCode,
				it.dmsTemplatesInputs_InputLabel,
				dmsTemplatesInputs_InputCode,
				-- Go through each input and replace with correct field being passed in 
				Case 
				-- Fee earner
				when dmsTemplatesInputs_InputCode = 'INPUT00000004' then isnull(@pFeeEarner,@pUserName)
				-- Private and confidential
				when dmsTemplatesInputs_InputCode = 'INPUT00000005' then isnull(@pPrivConf,'')
				-- Contact
				when dmsTemplatesInputs_InputCode in ('INPUT00000001','INPUT00000025', 'INPUT00000031', 'INPUT00000008', 'INPUT00000009','INPUT00000019','INPUT00000020','INPUT00000026') then ISNull(@pContactID,0)
				-- Referencial Code
				when dmsTemplatesInputs_InputCode in ('INPUT00000023','INPUT00000024', 'INPUT00000028') then isnull(@pRefCode, 0)
				-- Salutation
				when dmsTemplatesInputs_InputCode = 'INPUT00000002' then isnull(@pSalutation, 'Dear Sir/Madam')
				-- Valediction
				when dmsTemplatesInputs_InputCode = 'INPUT00000003' then isnull(@pValediction,'Yours faithfully')
				-- If there is no value matched then return what was passed in	
				else dmsTemplatesInputs_InputCode
				-- display as
			end as dmsTemplatesInputs_InputCode, 
				it.dmsTemplatesInputs_Mandatory,
				td.dmsTemplatesDescription_DescriptionString 
		FROM 
		dmsTemplates t
		INNER JOIN dmsTemplatesDescription td on t.dmsTemplates_TemplateCode = td.dmsTemplatesDescription_TemplateCode and td.dmsTemplatesDescription_InActive = 0
		LEFT OUTER JOIN dmsTemplatesInputs it on t.dmsTemplates_TemplateCode = it.dmsTemplatesInputs_TemplateCode and it.dmsTemplatesInputs_InActive = 0
		WHERE t.dmsTemplates_InActive = 0 and t.dmsTemplates_TemplateCode = @pdmsTemplates_TemplateCode
		order by it.dmsTemplatesInputs_ScreenOrder
		
		-- Update inputs on table
		update @DocumentInputsTable
		set dmsInputs_InputCode2 = contactID 
		from @DocumentInputsTable
		inner join @contacts on inputCode = dmsInputs_InputCode 
			
		-- Set up Temp table to hold details of the bookmarks.
		
		--DECALRE TEMP TABLE TO HOLD THE BOOKMARK DETAILS AND VALUES
		DECLARE @BOOKMARKDETAILS TABLE
		(
			BOOKMARKID						INT IDENTITY,
			TEMPLATECODE					nvarchar(255),
			BOOKMARKCODE					nvarchar(max),
			BOOKMARKALIAS					nvarchar(max),
			BOOKMARKTABLE					nvarchar(MAX),
			BOOKMARKFIELD					nvarchar(MAX),
			BOOKMARKIVALUE					nvarchar(MAX),
			BOOKMARKADVSQL					nText,
			BOOKMARKWORD					bit, 
			BookmarkData					nvarchar(max),
			BookmarkValue					nvarchar(max),
			TemplatePath					nvarchar(max),
			TemplateName					nvarchar(max),
			DocumentLocation				nvarchar(max),
			DocumentName					nvarchar(max)

		)
		
		--INSERT BOOKMARK DETAILS WITH ANY INPUT VALUES ASSOCIATED WITH THEM
		INSERT INTO @BOOKMARKDETAILS(TEMPLATECODE, BOOKMARKCODE, BOOKMARKALIAS, BOOKMARKTABLE, BOOKMARKFIELD, BOOKMARKADVSQL, BOOKMARKWORD)	
		SELECT t.dmsTemplates_TemplateCode AS TEMPLATECODE,
		b.dmsBookmarks_BookmarkCode AS BOOKMARKCODE, 
		bt.dmsTemplatesBookmarks_BookmarkAlias AS BOOKMARKALIAS, 
		b.dmsBookmarks_BookmarkTableName AS BOOKMARKTABLE, 
		b.dmsBookmarks_BookmarkField AS BOOKMARKFIELD,
		B.dmsBookmarks_BookmarkSQL as BOOKMARKADVSQL,
		B.dmsBookmarks_WordFunctnlty AS BOOKMARKWORD
		FROM dmsTemplates t
		INNER JOIN dmsTemplatesBookmarks bt ON t.dmsTemplates_TemplateCode = bt.dmsTemplatesBookmarks_TemplateCode AND bt.dmsTemplatesBookmarks_InActive = 0
		INNER JOIN dmsBookmarks b ON bt.dmsTemplatesBookmarks_BookmarkCode = b.dmsBookmarks_BookmarkCode AND b.dmsBookmarks_InActive = 0
		WHERE t.dmsTemplates_TemplateCode = @pdmsTemplates_TemplateCode AND t.dmsTemplates_InActive = 0 AND t.dmsTemplates_TemplateGroup <> 'TMPG0005'

		UPDATE @BOOKMARKDETAILS
		--SET BOOKMARKIVALUE = iv.dmsInputs_InputCode2, TemplatePath = iv.dmsTemplates_TemplatePath, DocumentName = iv.dmsTemplatesDescription_DescriptionString
		SET BOOKMARKIVALUE = iv.dmsInputs_InputCode2, DocumentName = iv.dmsTemplatesDescription_DescriptionString
		FROM @BOOKMARKDETAILS b
		INNER JOIN dmsTemplatesBookmarks t ON b.BOOKMARKCODE = t.dmsTemplatesBookmarks_BookmarkCode AND B.TEMPLATECODE = t.dmsTemplatesBookmarks_TemplateCode AND t.dmsTemplatesBookmarks_InActive = 0
		INNER JOIN @DocumentInputsTable iv ON t.dmsTemplatesBookmarks_InputCode = iv.dmsInputs_InputCode
		
		-- // Update and run SQL within fields \\ --

		--RESET COUNTER AND GET THE NUMBER OF BOOKMARKS BEING PROCESS FOR THE LOOP
		SET @Count = 1
		SELECT @NoField = MAX(BOOKMARKID) FROM @BOOKMARKDETAILS 
		--SELECT * FROM @BOOKMARKDETAILS
			--WHILE THERE ARE STILL BOOKMARKS TO BE PROCESSED
		WHILE @Count <= @NoField 
		BEGIN
			SELECT @BOOKMARKADVSQL = '', 
			@IVAL = '', 
			@BOOKMARKTABLE = '', 
			@BOOKMARKFIELD = '',
			@BOOKMARKCODE = '' 
			
			--GET DEATILS OF CURRENT BOOKMARK BEING PROCESSED
			SELECT @BOOKMARKADVSQL = BOOKMARKADVSQL, @IVAL = BOOKMARKIVALUE, 
			@BOOKMARKTABLE = BOOKMARKTABLE, @BOOKMARKFIELD = BOOKMARKFIELD,
			@BOOKMARKCODE = BOOKMARKCODE, @InputTest = BOOKMARKIVALUE
			FROM @BOOKMARKDETAILS
			WHERE BOOKMARKID = @Count
					
			--GET THE DETAILS OF THE ANY INPUT ATTACHED TO THE BOOKMARK BEING PROCESSED
			SELECT @INPUTTABLE = I.dmsInputs_InputTableName, @INPUTFIELD = I.dmsInputs_InputDataField, 
			@INPUTTYPE = I.dmsInputs_InputType, @INPCODE = I.dmsInputs_InputCode  
			FROM dmsTemplatesBookmarks bt INNER JOIN
			dmsInputs I ON bt.dmsTemplatesBookmarks_InputCode = I.dmsInputs_InputCode AND I.dmsInputs_InActive = 0
			WHERE bt.dmsTemplatesBookmarks_InActive = 0 AND bt.dmsTemplatesBookmarks_TemplateCode = @pTemplateCode 
			AND bt.dmsTemplatesBookmarks_BookmarkCode = @BOOKMARKCODE 
			
			--INITIALISE SQL STRING TO EMPTY
			SELECT @STRSQL = ''
					
			--IF THE BOOKMARK DEFINTION HAS DEFINED TABLES AND FIELDS
			IF ISNULL(@BOOKMARKADVSQL, '') = '' AND ISNULL(@BOOKMARKTABLE, '') <> ''
			BEGIN
				--GET THE NAME OF THE INACTIVE COLUMN FROM DATASOURCE TABLE
				SELECT @INACTIVE = c.NAME FROM SYSOBJECTS o INNER JOIN 
				SYSCOLUMNS c ON o.ID = c.ID
				WHERE o.name = @BOOKMARKTABLE AND C.name LIKE '%INACTIVE'
				
				--IF DATASOURCE TABLE HAS AN INACTIVE COULUMN
				IF ISNULL(@INACTIVE,'') <> ''
				BEGIN	
					--BUILD CONDITION FOR ONLY SELECTING ACTIVE RECORDS
					SELECT @INACTIVE = ' AND ' + @INACTIVE + ' = 0 '
				END
				--IF THE TABLE HAS A CASIED
				IF EXISTS (SELECT c.NAME FROM SYSOBJECTS o INNER JOIN 
							SYSCOLUMNS c ON o.ID = c.ID
							WHERE o.name = @BOOKMARKTABLE AND C.name = @BOOKMARKTABLE + '_CASEID')
				BEGIN
					--BIULD SQL BASED ON CASEID AND INACTIVE COLUMN (IF THERE IS ONE)
					SELECT @STRSQL = 'SELECT @VAL = ' + @BOOKMARKFIELD + ' FROM [' + @BOOKMARKTABLE + '] WHERE ' + @BOOKMARKTABLE + '_CASEID = ' + CAST(@pCASEID AS NVARCHAR(MAX)) + ISNULL(@INACTIVE,'')
				END
				ELSE
				BEGIN
					--IF THE TABLE HAS AN APPINSTANCEVALUE
					IF EXISTS (SELECT c.NAME FROM SYSOBJECTS o INNER JOIN 
								SYSCOLUMNS c ON o.ID = c.ID
								WHERE o.name = @BOOKMARKFIELD AND C.name = 'AppInstanceValue')
					BEGIN
						--GET APPINSTANCEVALUE FOR MATTER USING PASSED CASEID
						SELECT @IDVAL = IdentifierValue FROM ApplicationInstance  WHERE CaseID = @pCASEID 
						--BIULD SQL BASED ON APPINSTANCEVALUE AND INACTIVE COLUMN (IF THERE IS ONE)
						SELECT @STRSQL = 'SELECT @VAL = ' + @BOOKMARKFIELD + ' FROM [' + @BOOKMARKTABLE + '] WHERE AppInstanceValue = ''' + @IDVAL + '''' + ISNULL(@INACTIVE,'')
					END
					--ELSE TABLE SELECTED HAS NEITHER A CASEID OR A APPINSTANCEVALUE
					ELSE
					BEGIN
						IF ISNULL(@INACTIVE, '') <> ''
						BEGIN
							SET @INACTIVE = REPLACE(@INACTIVE, ' AND ', ' WHERE ')
						END
						--BIULD SQL WITH A CONDITION ON THE INACTIVE COLUMN (IF THERE IS ONE)
						SELECT @STRSQL = 'SELECT @VAL = ' + @BOOKMARKFIELD + ' FROM [' + @BOOKMARKTABLE + ']' + ISNULL(@INACTIVE,'')
						--PRINT @STRSQL
					END
				END
			END
			--ELSE 
			ELSE
			BEGIN
				--IF THE BOOKMARK DEFINTION HAS DEFINED SQL
				IF ISNULL(@BOOKMARKADVSQL, '') <> ''
				BEGIN
					--WRAP THE WHERE CLAUSE USER INPUT CRITERIA IN SINGLE QUOTES AS A MULTI FIELD TYPE CATCHALL
				
					SELECT @IVAL = '''' + @IVAL + ''''
							
					--BIULD SQL STRING TO BE PROCESSED
					SELECT @BOOKMARKADVSQL = REPLACE(@BOOKMARKADVSQL, '$INPUT', ISNULL(@IVAL,''''''))
					SELECT @BOOKMARKADVSQL = REPLACE(@BOOKMARKADVSQL, '$CASEID', CAST(@pCASEID AS NVARCHAR(MAX)))
					IF ISNULL(CHARINDEX('FROM', @BOOKMARKADVSQL),0) > 0
					BEGIN
						SELECT @BOOKMARKADVSQL = REPLACE(@BOOKMARKADVSQL, '(SELECT ', '******')
						SELECT @BOOKMARKADVSQL = REPLACE(@BOOKMARKADVSQL, 'SELECT ', 'SELECT @VAL = ISNULL(')
						SELECT @BOOKMARKADVSQL = REPLACE(@BOOKMARKADVSQL, '******', '(SELECT ISNULL(')
						SELECT @BOOKMARKADVSQL = REPLACE(@BOOKMARKADVSQL, 'FROM', ','''') FROM')
					END
					ELSE
					BEGIN
						SELECT @BOOKMARKADVSQL = REPLACE(@BOOKMARKADVSQL, 'SELECT ', 'SELECT @VAL = ')
					END
					--SELECT @STRSQL = @BOOKMARKADVSQL
					SELECT @STRSQL = REPLACE(@BOOKMARKADVSQL, 'XXXX', 'from')

				END
			END
			
			--IF THERE IS A SQL STRING TO BE PROCESSED
			IF ISNULL(@STRSQL, '') <> ''
			BEGIN		
				--EXECUTE SQL STRING TO RERTIRVE ANY VALUES TO BE INSERTED INTO THE BOOKMARK
				SET @IVAL = Null
				print '@BOOKMARKCODE - ' + @BOOKMARKCODE
				print '@STRSQL - ' + @STRSQL			
				EXEC sp_executesql @STRSQL,
						N'@VAL nvarchar(max) out',
						@IVAL OUT
				--ADD RETRIVED VALUE TO BOOKMARK IN TEMPORY TABLE
				IF ISNULL('''' + @InputTest + '''','') = ISNULL(@IVAL, '')
				BEGIN
					UPDATE @BOOKMARKDETAILS SET BOOKMARKIVALUE = '' WHERE BOOKMARKID = @Count 
				END
				ELSE
				BEGIN
					UPDATE @BOOKMARKDETAILS SET BOOKMARKIVALUE = isnull(@IVAL, '') WHERE BOOKMARKID = @Count
				END
				SET @IVAL = Null
			END
			--ELSE NO SQL GENERATED
			ELSE
			BEGIN
				
				--INSERT STATIC INPUT INTO BOOKMARK
				UPDATE @BOOKMARKDETAILS SET BOOKMARKIVALUE = @IVAL WHERE BOOKMARKID = @Count 
				SET @IVAL = Null
			END
			
			-- // End of checks and updates \\ --
			
			-- Update bookmarkdata and values into 'piped' format
			-- Get the values from the temp table
			select @tmpBookmarkData = BOOKMARKIVALUE , @tmpBookmarkAlias = BOOKMARKALIAS from @BOOKMARKDETAILS WHERE BOOKMARKID = @Count 
						
			-- Add the pipe |
			if @bookmarkData <> ''
			begin
				set @tmpPipeValue = '|'
			end
			
			set @tmpBookmarkData = ISNULL(@tmpBookmarkData, '')
				
			-- Add the bookmark data and values to the list		
			set @bookmarkData =    @bookmarkData + @tmpPipeValue + @tmpBookmarkData
			set @bookmarkAlias = @bookmarkAlias + @tmpPipeValue + @tmpBookmarkAlias
				
			--MOVE TO NEXT BOOKMARK TO PROCESS
			SET @Count = @Count + 1
			
		END
		-- removed + cast(NEWID() as nvarchar(50))

		-- // Return Final Values \\ --
		select @bookmarkAlias as 'dmsBookmarkName', @bookmarkData as 'dmsBookmarkValue', @dmsTemplateDescription as 'dmsTemplateDescription', @dmsTemplatePath as 'dmsTemplatePath', @dmsDocumentName  as 'dmsDocumentName', @TemplateSupReq as 'SupReq', @dmsDocumentLocation as 'dmsDocumentLocation', @dmsTemplateTitle as 'dmsDocumentTitle'
		
		-- Return as XML
		-- Run select to show final values
		--select 1 as Tag,NULL AS Parent, @bookmarkAlias as 'data!1!dmsBookmarkName', @bookmarkData as 'data!1!dmsBookmarkValue', @dmsTemplateDescription as 'data!1!dmsTemplateDescription', @dmsTemplatePath as 'data!1!dmsTemplatePath', @dmsDocumentName + cast(NEWID() as nvarchar(50)) as 'data!1!dmsDocumentName', @TemplateSupReq as 'data!1!SupReq', @dmsDocumentLocation as 'data!1!dmsDocumentLocation'
		--for xml explicit
		
		
		END TRY
	-- // Error Handling \\ --
	
	BEGIN CATCH	
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME(@@PROCID)	
	END CATCH
	

		
	

		
	