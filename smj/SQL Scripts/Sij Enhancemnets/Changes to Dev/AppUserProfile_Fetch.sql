ALTER PROC [dbo].[AppUserProfile_Fetch] 
(
	@pUserName				nvarchar(255) = '',		-- Manditory.  Map System.Username for Current User
	@pAppUserName			nvarchar(50) = '',		-- Optional 
	@pFullName				nvarchar(256) = '',		-- Optional 
	@pAppUserRoleCode		nvarchar(10) = '',		-- Optional
	@pDepartmentCode		nvarchar(10) = '',		-- Optional
	@pExternalTableID		int = NULL,				-- Optional
	@pInActive				bit = NULL,				-- Optional.
	@pStartDate				smalldatetime = NULL,	-- Optional.
	@pEndDate				smalldatetime = NULL,	-- Optional.
	@pDirectDial			nvarchar(25) = ''		-- Optional
)
AS

-- Stored proc to fetch a list of all users. This is not linked to an application instance / case.

	--====================================================--
	--Modified By : SMJ
	--Modify Date: 29/03/2012
	--Description - Added user initials to show in drop downs
	--====================================================--

	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 27-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================
	
	SET NOCOUNT ON
	DECLARE @errNoUserName VARCHAR(50)
	
	SET @errNoUserName = '@pUserName not supplied.'

	BEGIN TRY 
		IF (@pUserName = '')
			RAISERROR(@errNoUserName, 16,1)
		
		IF ISNULL(@pInActive,0) = 0
		BEGIN
			SET @pInActive = 0
		END
		
		SELECT aup.UserName,
				aup.FullName + ' (' + aup.UserName + ')' AS FullName,
				aup.AppUserRoleCode,
				aup.DepartmentCode,
				aup.ExternalTableID,
				aup.InActive,
				aup.StartDate,
				aup.EndDate,
				aup.ContactEmail,
				aup.DirectDial,
				aup.JobTitle, 
				aup.FetchAllTasks,
				aup.CreateDate,
				aurt.[Level]
		FROM dbo.AppUserProfile aup WITH (NOLOCK)
		INNER JOIN dbo.AppUserRoleTypes aurt WITH (NOLOCK) ON (aurt.Code = aup.AppUserRoleCode)
		WHERE	((ISNULL(@pAppUserName,'')='')		OR (aup.UserName = @pAppUserName ))
			AND ((ISNULL(@pFullName,'')='')			OR (aup.FullName like '%' + @pFullName + '%'))
			AND ((ISNULL(@pAppUserRoleCode,'')='')	OR (aup.AppUserRoleCode=@pAppUserRoleCode))
			AND ((ISNULL(@pDepartmentCode,'')='')	OR (aup.DepartmentCode like '%' + @pDepartmentCode + '%'))
			AND ((ISNULL(@pExternalTableID,0) = 0)	OR (aup.ExternalTableID=@pExternalTableID))
			AND (aup.InActive=@pInActive)
			AND ((ISNULL(@pStartDate,'') = '')		OR (aup.StartDate=@pStartDate))
			AND ((ISNULL(@pEndDate,'') = '')		OR (aup.EndDate=@pEndDate))
			AND ((ISNULL(@pDirectDial,'') = '')		OR (aup.DirectDial=@pDirectDial))
			--EXLUDE THE FLOSUITE USER GQL Ticket 156628 07-09-2010 
			AND aup.UserName <> 'FLOSUITEID'
		ORDER BY aup.FullName 
		
	END TRY
		
	BEGIN CATCH			
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH