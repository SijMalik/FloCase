
ALTER PROC [dbo].[AppTaskDocumentVersion_Fetch]
(
	@UserName			nvarchar(255)  = '',	-- Manditory
	@AppInstanceValue	nvarchar(50) = '',		-- Optional.
	@CaseID				int = 0,				-- Optional.
	@AppTaskDocumentID	int = 0,				-- Optional.
	@AppTaskID			int = 0					-- Optional.
)
AS
	DECLARE @myLastError int 
	SELECT @myLastError = 0 
	DECLARE @myLastErrorString nvarchar(255)
	SELECT @myLastErrorString = '' 
	
	
	IF ((@CaseID<>0) OR (@AppTaskDocumentID<>0) OR (@AppTaskID<>0))
	BEGIN
	
		IF (@UserName = '')
		BEGIN
			SET @myLastErrorString = '@UserName not supplied'
			GOTO THROW_ERROR_UPWARDS
		END
	END
	
	SELECT DISTINCT
		AppTaskDocument.AppTaskDocumentID, 
		AppTaskDocument.AppTaskDocType, 
		AppTaskDocument.CurrentVersion, 
		AppTaskDocument.Author, 
		AppTaskDocument.Created, 
		AppTaskDocument.DocPath, 
		AppTaskDocument.DocName, 
		AppTaskDocument.DocTitle,
		AppTaskDocumentVersion.AppTaskDocumentVersionID,
		AppTaskDocumentVersion.Author AS VersionAuthor,
		AppTaskDocumentVersion.Created AS VersionCreated,
		AppTaskDocumentVersion.DocName AS VersionDocName,
		AppTaskDocumentVersion.DocPath AS VersionDocPath,
		AppTaskDocumentVersion.VersionNo,
		AppTaskDocumentVersion.AppTaskDocumentVersion_Approved AS VersionApproved,
		AppTaskDocumentVersion.AppTaskDocumentVersion_ReviewComments AS ReviewComments,
		SystemSettings.SystemSettings_DocStore + '\'
			+ CASE WHEN (ISNULL(AppTaskDocumentVersion.DocPath,'')='')
					THEN ''
					ELSE AppTaskDocumentVersion.DocPath + '\'
			END
			+ AppTaskDocumentVersion.DocName AS VersionFullDocumentName
	FROM AppTaskDocument
	INNER JOIN AppTaskDocumentVersion on 
	(AppTaskDocumentVersion.AppTaskDocumentID = AppTaskDocument.AppTaskDocumentID
		AND AppTaskDocumentVersion.AppTaskDocumentVersionID IN 
		(
			select  max(av.AppTaskDocumentVersionID)
			from AppTaskDocumentVersion av
			inner join AppTaskDocument at
			on av.AppTaskDocumentID = at.AppTaskDocumentID
			where av.AppTaskDocumentID = @AppTaskDocumentID
			group by av.VersionNo
			)
	)
	INNER JOIN AppTask ON (AppTask.DocumentID = AppTaskDocument.AppTaskDocumentID)
	INNER JOIN ApplicationInstance ON (ApplicationInstance.IdentifierValue = AppTask.AppInstanceValue)
	INNER JOIN SystemSettings ON (SystemSettings.SystemSettings_Inactive = 0)
	WHERE ((@CaseID = 0) OR (ApplicationInstance.CaseID = @CaseID)) 
			AND ((@AppInstanceValue = '') OR (ApplicationInstance.IdentifierValue = @AppInstanceValue))
			AND ((@AppTaskDocumentID = 0) OR (AppTaskDocument.AppTaskDocumentID = @AppTaskDocumentID) )
			AND ((@AppTaskID = 0) OR (AppTask.AppTaskID = @AppTaskID))		
	ORDER BY AppTaskDocumentVersion.Created DESC

	
	THROW_ERROR_UPWARDS:
	IF (@myLastError <> 0 ) OR (@myLastErrorString <> '')
	BEGIN
		SET @myLastErrorString = 'Error Occurred In Stored Procedure AppTaskDocument_Fetch - ' + @myLastErrorString
		RAISERROR (@myLastErrorString, 16,1)
	END

