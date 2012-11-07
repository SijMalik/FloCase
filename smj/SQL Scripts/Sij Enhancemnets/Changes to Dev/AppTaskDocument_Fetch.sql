ALTER PROC [dbo].[AppTaskDocument_Fetch]
(
	@pUserName			nvarchar(255)  = '',
	@pCaseID			int = 0,
	@pAppTaskDocumentID	int = 0,
	@pAppTaskID			int = 0
)
AS
		
	-- ==========================================================================================
	-- Author:		GQL
	-- Create date: 16-03-2011
	-- Description:	STORED PRCEDURE TO RETURN DOCUMENT INFORMATION BASED ON GIVEN CRITERIA
	-- ==========================================================================================

	-- ==========================================================================================
	-- Author:		SMJ
	-- Amended date: 29-09-2011
	-- Description:	Returns new columns PrintStatus and DateLastPrinted
	-- ==========================================================================================	
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ==============================================================	
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 11-10-2012
	-- Description:	Get 1 record for each version of the document - was returning duplicates
	-- ==============================================================		

	BEGIN TRY				
		--CREATE TEMPORY TABLE TO HOLD RESULT SET 
		DECLARE @DocumentHistoryTable TABLE
		(
			AppTaskDocumentID [int] NOT NULL,
			AppTaskDocType nvarchar(256),
			CurrentVersion nvarchar(256),
			Author nvarchar(256) ,
			Created smalldatetime,
			TextCreated nvarchar(256) ,
			DocPath nvarchar(256) ,
			DocName nvarchar(256) ,
			DocTitle nvarchar(256) ,
			Created_Formated nvarchar(256) ,
			Time_Formated nvarchar(256) ,
			FullDocumentName nvarchar(256) ,
			WebDocStore nvarchar(256) ,
			WebDocumentName nvarchar(256) ,
			AppTaskID [int] NOT NULL,
			CaseContactsID [int] NULL,
			CaseContactFullName nvarchar(256) ,
			[Description] nvarchar(256) ,
			OnBehalfOf nvarchar(256) ,
			DocTypeDesc nvarchar(256) ,
			DocTypeBriefDesc nvarchar(256) ,
			AppTaskDefinitionCode nvarchar(256) ,
			Approved nvarchar(155)  ,
			ReviewComments nvarchar(max)  ,
			PrintStatus nvarchar(50) ,
			DateLastPrinted smalldatetime NULL
		)
		
		--UPDATE TEMP TABLE WITH THOSE ITEMS THAT CAN BE REACHED USING INNER JOINS FOR TEH WHOLE SET
		INSERT INTO @DocumentHistoryTable(
			AppTaskDocumentID,
			AppTaskDocType,
			CurrentVersion,
			Author,
			Created,
			TextCreated,
			DocPath,
			DocName,
			DocTitle,
			Created_Formated,
			Time_Formated,
			FullDocumentName,
			WebDocStore,
			WebDocumentName,
			AppTaskID,
			CaseContactsID,
			[Description],
			OnBehalfOf,
			DocTypeDesc,
			DocTypeBriefDesc,
			AppTaskDefinitionCode,
			PrintStatus,
			DateLastPrinted)
		SELECT	
			AppTaskDocumentID, 
			AppTaskDocType, 
			CurrentVersion, 
			Author, 
			AppTask.CreatedDate,
			left(datename(WEEKDAY , AppTask.CreatedDate),3) + ' ' + cast(datepart(d,AppTask.CreatedDate) as nvarchar(2)) +  ' ' + left(datename(M , AppTask.CreatedDate),3) + ' ' + cast(datepart(YYYY, AppTask.CreatedDate) as nvarchar(4)) as TextCreated,
			DocPath,
			DocName, 
			DocTitle,
			CONVERT(nvarchar(20), AppTask.CreatedDate, 106) AS Created_Formated,
			CASE WHEN (datepart(mi, AppTask.CreatedDate) > 9) 
					THEN cast(datepart(hh, AppTask.CreatedDate) as nvarchar(4)) + ':' + cast(datepart(mi, AppTask.CreatedDate)as nvarchar(4))
					ELSE cast(datepart(hh, AppTask.CreatedDate) as nvarchar(4)) + ':' + '0' + cast(datepart(mi, AppTask.CreatedDate)as nvarchar(4))
			END  as Time_Formated,
			SystemSettings.SystemSettings_DocStore + '\'
				+ CASE WHEN (DocPath='')
						THEN ''
						ELSE DocPath + '\'
				END
			+ DocName AS FullDocumentName,
			SystemSettings.SystemSettings_WebDocStore + '\\' as WebDocStore,
			CASE WHEN (DocPath='')
						THEN ''
						ELSE replace(DocPath,'\','\\') + '\\'
				END
			+ DocName AS WebDocumentName,
			AppTask.AppTaskID,
			AppTask.ContactID AS CaseContactsID,
			AppTask.[Description],
			AppTaskDocument.OnBehalfOf,
			dt.dmsTemplates_TemplateDesc  AS DocTypeDesc,
			dt.dmsTemplates_TemplateName AS DocTypeBriefDesc,
			AppTaskDefinitionCode,
			AppTask.PrintStatus,
			AppTask.DateLastPrinted
		FROM dbo.AppTaskDocument with (nolock)
			INNER JOIN dbo.dmsTemplates dt with (nolock) ON AppTaskDocument.AppTaskDocType = dt.dmsTemplates_TemplateCode and dt.dmsTemplates_InActive = 0
			INNER JOIN dbo.AppTask with (nolock) ON (AppTask.DocumentID = AppTaskDocument.AppTaskDocumentID)
			INNER JOIN dbo.ApplicationInstance with (nolock) ON (ApplicationInstance.IdentifierValue = AppTask.AppInstanceValue)
			INNER JOIN dbo.SystemSettings with (nolock) ON (SystemSettings.SystemSettings_Inactive = 0)
		WHERE ((@pCaseID=0) OR (ApplicationInstance.CaseID = @pCaseID))
			AND ((@pAppTaskDocumentID=0) OR (AppTaskDocument.AppTaskDocumentID = @pAppTaskDocumentID))
			AND ((@pAppTaskID=0) OR (AppTask.AppTaskID=@pAppTaskID))
		
		--UPDATE RESULT SET WITH CONTACT INFO (PREVIOUSLY LEFT OUTER JOIN)
		UPDATE @DocumentHistoryTable
		SET CaseContactFullName =	CASE WHEN (ISNULL(c.[Contact_CompanyName],'') = '')
										THEN ISNULL(c.[Contact_Title],'') + ' ' + ISNULL(c.[Contact_Forename],'') + ' ' + ISNULL(c.[Contact_Surname],'')
										ELSE ISNULL(c.[Contact_CompanyName],'')
									END
		FROM @DocumentHistoryTable d
		INNER JOIN dbo.CaseContacts cc with (nolock) ON (cc.CaseContacts_CaseContactsID = d.CaseContactsID)
		INNER JOIN dbo.Contact c with (nolock) ON (c.Contact_ContactID = cc.CaseContacts_ContactID)

		--UPDATE RESULT SET WITH MATTER CONTACT INFO (PREVIOUSLY LEFT OUTER JOIN)
		UPDATE @DocumentHistoryTable
		SET CaseContactFullName =	CASE WHEN (ISNULL(m.MatterContact_CompanyName,'') = '')
										THEN ISNULL(m.[MatterContact_Title],'') + ' ' + ISNULL(m.[MatterContact_Forename],'') + ' ' + ISNULL(m.[MatterContact_Surname],'')
										ELSE ISNULL(m.[MatterContact_CompanyName],'')
									END
		FROM @DocumentHistoryTable d
		INNER JOIN dbo.CaseContacts cc with (nolock)ON (cc.CaseContacts_CaseContactsID = d.CaseContactsID)
		INNER JOIN dbo.MatterContact m with (nolock)ON (m.MatterContact_MatterContactID = cc.CaseContacts_MatterContactID)
			
		--UPDATE RESULT SET WITH CLIENT INFO (PREVIOUSLY LEFT OUTER JOIN)
		UPDATE @DocumentHistoryTable
		SET CaseContactFullName =	cl.CLIENT_NAME
		FROM @DocumentHistoryTable d
		INNER JOIN dbo.CaseContacts cc with (nolock)ON (cc.CaseContacts_CaseContactsID = d.CaseContactsID)
		INNER JOIN dbo.HBM_Client cl with (nolock)ON (cl.CLIENT_UNO = cc.CaseContacts_ClientID)
		
		 --UPDATE RESULT SET WITH VERSION INFO (PREVIOUSLY LEFT OUTER JOIN)
		UPDATE @DocumentHistoryTable
		SET Approved = v.AppTaskDocumentVersion_Approved ,
			ReviewComments = v.AppTaskDocumentVersion_ReviewComments
		FROM @DocumentHistoryTable d
		INNER JOIN dbo.AppTaskDocumentVersion v with (nolock) ON (v.AppTaskDocumentID = d.AppTaskDocumentID AND v.VersionNo = d.CurrentVersion)
		and v.AppTaskDocumentVersionID IN --SMJ 11/10/2012 - Get 1 record for each version
			(	SELECT MAX(av.AppTaskDocumentVersionID) 
				FROM AppTaskDocumentVersion av
				WHERE av.AppTaskDocumentID = d.AppTaskDocumentID
				AND av.VersionNo = d.CurrentVersion
			)
		--RETURN RESULT SET
		SELECT AppTaskDocumentID, AppTaskDocType, CurrentVersion, Author, Created,
			TextCreated, DocPath,DocName, DocTitle, Created_Formated, Time_Formated, 
			FullDocumentName, WebDocStore, WebDocumentName,
			AppTaskID, CaseContactsID, CaseContactFullName, [Description], 
			OnBehalfOf, DocTypeDesc, DocTypeBriefDesc,
			AppTaskDefinitionCode , Approved, ReviewComments, PrintStatus, DateLastPrinted
		FROM @DocumentHistoryTable
		ORDER BY Created DESC
	
	END TRY

	BEGIN CATCH				
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH