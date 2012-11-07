


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dmsTemplates_AdminFetch]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[dmsTemplates_AdminFetch]
GO
CREATE PROC [dbo].[dmsTemplates_AdminFetch]
(
	@pUserName							nvarchar(255) = ''
)
AS
	-- ==========================================================================================
	-- Author:		CKJ
	-- Create date: 11-09-2012
	-- This stored proc is used to extract document templates by the dms for just the admin screen.
	-- ==========================================================================================
	
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		1
	-- Modify date: 21-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================

	
	
	--Initialise Error trapping	
	SET NOCOUNT ON
  	DECLARE @errNoUserID VARCHAR(50)
  	
  	SET @errNoUserID = 'No @pUserName passed in.'

	BEGIN TRY
		IF (@pUserName = '')
			RAISERROR (@errNoUserID, 16,1)
	
	
		--insert returned recordset into temp table
		
		SELECT dmsTemplates_dmsTemplatesID,
			dmsTemplates_TemplateCode,
			dmsTemplates_TemplateName,
			dmsTemplates_TemplateDesc,
			dmsTemplates_TemplateGroup,
			l.[Description] as 'Template_Group',
			dmsTemplates_TemplatePath,
			dmsTemplates_FormCode as [Documment_Code],
			dmsTemplates_AvailAdhoc,
			dmsTemplates_Createuser, 
			dmsTemplates_CreateDate,
			dmsTemplates_ReqSup
		FROM dbo.dmsTemplates t WITH (NOLOCK)
		INNER JOIN  dbo.LookupCode l WITH (NOLOCK) ON t.dmsTemplates_TemplateGroup  = l.Code
		WHERE (ISNULL(dmsTemplates_InActive, 0) = 0) AND (dmsTemplates_TemplateGroup <> 'TMPG0005')
		order by dmsTemplates_TemplateGroup, dmsTemplates_TemplateDesc
	
	END TRY

		
	BEGIN CATCH		
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH





