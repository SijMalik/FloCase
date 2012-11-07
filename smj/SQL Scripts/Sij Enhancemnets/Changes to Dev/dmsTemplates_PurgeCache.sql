
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dmsTemplates_PurgeCache]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].dmsTemplates_PurgeCache
GO
CREATE PROC [dbo].[dmsTemplates_PurgeCache]
(
	@pUserName							nvarchar(255) = ''		-- Manditory. Map System.Username for Current User	
)
AS

	-- ===============================================================
	-- Author:		SMJ
	-- Version:		1
	-- Modify date: 21-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================

	SET NOCOUNT ON
  	DECLARE @errNoUserID VARCHAR(50)
  	
  	SET @errNoUserID = 'No @pUserName passed in.'

	BEGIN TRY
		IF (@pUserName = '')
			RAISERROR (@errNoUserID, 16,1)
		
		TRUNCATE TABLE dbo.dmsCaseTemplates
	END TRY
	
		
	BEGIN CATCH		
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH



