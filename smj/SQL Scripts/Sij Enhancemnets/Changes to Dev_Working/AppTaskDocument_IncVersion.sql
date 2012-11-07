
ALTER PROC [dbo].[AppTaskDocument_IncVersion]
(
	@pAppTaskDocumentID	int	= 0,
	@pAuthor			nvarchar(255)  = '',
	@pUserName			nvarchar(255)  = '',
	@pNewDocName		nvarchar(255)  = '',
	@pSupervisionReq	BIT  = 0, -- SMJ - Pass in 1 if Supervision is required
	@pApproved			NVARCHAR(255)= '', 
	@pReviewComments	NVARCHAR(MAX) = '',
	@pPrintStatus		NVARCHAR(50) = '',
	@pDateLastPrinted	SMALLDATETIME = NULL,
	@pChangeVersion		bit = 0		-- GV: default is true
)

	------------------------------------------------------------------------------
	-- Modified by SMJ on 28/09/2011
	-- Added new columns PrintStatus and DateLastPrinted to AppTaskDocumentVersion table
	-- Added param @pPrintStatus to populatePrinStatus DateLastPrinted =  GETDATE()
	------------------------------------------------------------------------------

	------------------------------------------------------------------------------
	-- Modified by GV on 3/10/2011
	-- Allow to save document with same version number
	------------------------------------------------------------------------------
	
	------------------------------------------------------------------------------
	-- Modified by GV on 3/10/2011
	-- . added changes to update entry rather than adding new one when no creating a new version
	-- . added incoming parameter to set last printed date (was using today's date before by default (even when no printing was done!!!)
	------------------------------------------------------------------------------
	
	------------------------------------------------------------------------------
	-- Modified by SMJ on 11/05/2012
	-- IF @pVersion = 0, bypass the code where it adds a timestamp to the file
	------------------------------------------------------------------------------	
	
AS
	SET NOCOUNT ON
	DECLARE @myLastError int 
	SELECT @myLastError = 0 
	DECLARE @myLastErrorString nvarchar(255)
	SELECT @myLastErrorString = '' 

	

	if(ISNULL(@pReviewComments,'') <> '') 
		set @pReviewComments = @pUserName + ' : '+ @pReviewComments

	DECLARE @DocumentVersionID int,
			@Created datetime,
			@VersionNo int,
			@DocPath nvarchar(256),
			@DocName nvarchar(256),
			@DocTitle nvarchar(256),
			@ArchiveDocName nvarchar(256),
			@DateString nvarchar(20),
			@FullPathPrefix nvarchar(256),
			@TextVersion nvarchar(256),
			@DocTitleExt nvarchar(256),
			@SPLITVAR NVARCHAR(2),
			@Approved varchar(10) -- SMJ

			SET @Approved = ''
			
			SET @SPLITVAR = '.'--NVT - 18 Oct 10 - 5.5f document version character to split on

	SELECT 	@DocumentVersionID = 0,
			@Created = getdate(),
			@ArchiveDocName = @DocName
	
	BEGIN TRANSACTION AppTaskDocumentIncVersion

	IF (@pAppTaskDocumentID <> 0)
	BEGIN
		IF (@pUserName = '')
		BEGIN
			SET @myLastErrorString = '@UserName not supplied'
			GOTO THROW_ERROR_UPWARDS
		END
		
		IF (@pAuthor = '')
		BEGIN
			SET @myLastErrorString = '@Author not supplied'
			GOTO THROW_ERROR_UPWARDS
		END

		SELECT	@DocTitle = DocTitle,
			@DocPath = DocPath,
			@DocName = DocName,
			@ArchiveDocName = DocName,
			@FullPathPrefix = SystemSettings.SystemSettings_DocStore + '\'
			+ CASE WHEN (DocPath='')
					THEN ''
					ELSE DocPath + '\'
			END
		FROM AppTaskDocument
		INNER JOIN SystemSettings ON (SystemSettings.SystemSettings_Inactive = 0)
		WHERE (AppTaskDocumentID = @pAppTaskDocumentID)
	
		IF (ISNULL(@DocTitle,'') = '')
			SET @DocTitle = @DocName
	
		-- Get the current version number
		SELECT @VersionNo = ISNULL(MAX(VersionNo),0)
		FROM AppTaskDocumentVersion
		WHERE (AppTaskDocumentID = @pAppTaskDocumentID)
		
		
					
		-- Archive the document in version history
		IF @pChangeVersion = 1 --SMJ - 11/05/2012
		BEGIN
			SET @VersionNo = @VersionNo + 1
			
			IF (@pNewDocName = '')
			BEGIN
				--NVT - 18 Oct 10 - 5.5f - gets the file extension off the file
				SET @DocTitleExt = REVERSE(SUBSTRING(REVERSE(@DocName),1,CHARINDEX(@SPLITVAR,reverse(@DocName))))
					
				SET @DocTitle = REPLACE(REPLACE(@DocTitle,@DocTitleExt,''),UPPER(@DocTitleExt),'')
				--SET @DocTitle = REPLACE(REPLACE(@DocTitle,'.doc',''),'.DOC','')
				--SET @DateString = CONVERT(VARCHAR(30), @Created, 126)
				SET @DateString = CONVERT(VARCHAR(30), @Created, 113)
				--SET @DateString = REPLACE(@DateString,'.','')
				SET @DateString = REPLACE(@DateString,':','.')
				--SET @DateString = REPLACE(@DateString,'-','')
				
				--SET THE VERSION FOR THE DOC NAME STRING
				IF @VersionNo < 10
				BEGIN
					SET @TextVersion = '0' + CAST((@VersionNo)AS NVARCHAR(254))
				END
				ELSE
				BEGIN
					SET @TextVersion = CAST((@VersionNo)AS NVARCHAR(254))
				END
								
				SET @DocName = @DocTitle + ' ' + @DateString + ' ' + @TextVersion + @DocTitleExt
			END
		END

		SELECT @myLastError = @@ERROR
		IF @myLastError <> 0 GOTO THROW_ERROR_UPWARDS
		
			
		IF @pSupervisionReq = 1 AND (@pApproved = '' OR @pApproved = 'No')
			SELECT @Approved = 'No'		
		ELSE		
			SELECT @Approved = 'Yes'
		
			-- SSCF: Supervision is not valid for FE	
			if @pSupervisionReq = 0	set @Approved = ''

		-- SMJ  -10/08/2012 - Just update new version comments
					print 'here'	
			-- Create an item for the document history
			INSERT INTO AppTaskDocumentVersion
				(AppTaskDocumentID, VersionNo, Author, Created, DocPath, DocName,
				AppTaskDocumentVersion_Approved, AppTaskDocumentVersion_ReviewComments, 
				PrintStatus, DateLastPrinted) --SMJ
			--SELECT
			values(
				@pAppTaskDocumentID, @VersionNo, @pAuthor, @Created, @DocPath, 
				ISNULL(@DocName,@pNewDocName), @Approved, @pReviewComments, 
				@pPrintStatus, GETDATE())
			--FROM AppTaskDocumentVersion	
			--WHERE versionNo = @VersionNo
			
			-- Update the document with the new version number and docName
			UPDATE AppTaskDocument
			SET CurrentVersion = @VersionNo,
				DocName = ISNULL(@DocName,@pNewDocName),
				Created = @Created
			WHERE (AppTaskDocumentID = @pAppTaskDocumentID)			
		
		
		SELECT @myLastError = @@ERROR
		IF @myLastError <> 0 GOTO THROW_ERROR_UPWARDS


		SELECT @myLastError = @@ERROR
		IF @myLastError <> 0 GOTO THROW_ERROR_UPWARDS
		
		SELECT @DocumentVersionID = SCOPE_IDENTITY()
	END
	
	COMMIT TRANSACTION AppTaskDocumentIncVersion

	SELECT 
		@pAppTaskDocumentID AS AppTaskDocumentID, 
		@VersionNo AS DocumentVersionNo, 
		@ArchiveDocName AS DocName, 
		@DocPath AS DocPath, 
		@DocName AS ArchiveDocName,
		@FullPathPrefix + @DocName AS FullArchiveDocumentName


	THROW_ERROR_UPWARDS:
	IF (@myLastError <> 0 ) OR (@myLastErrorString <> '')
	BEGIN
		ROLLBACK TRANSACTION AppTaskDocumentIncVersion
		SET @myLastErrorString = 'Error Occurred In Stored Procedure AppTaskDocument_IncVersion - ' + @myLastErrorString
		RAISERROR (@myLastErrorString, 16,1)
	END



