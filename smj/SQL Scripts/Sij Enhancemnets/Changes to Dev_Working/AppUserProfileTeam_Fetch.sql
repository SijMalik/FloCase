ALTER PROC [dbo].[AppUserProfileTeam_Fetch]
(
	@pUserName				nvarchar(255) = '',		-- Manditory.  Map System.Username for Current User
	@pDepartmentCode		nvarchar(10) = ''		-- Manditory	
)
AS

	--- Stored proc to fetch a list of all users. This is not linked to an application instance / case.

	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 27-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================
	
	SET NOCOUNT ON
	DECLARE @errNoUserName VARCHAR(50)
	DECLARE @errNoDept VARCHAR(50)
	
	SET @errNoUserName = '@pUserName not supplied.'
	SET @errNoDept = '@pDepartmentCode not supplied.'
	
	BEGIN TRY
		IF ISNULL(@pUserName,'') = ''
			RAISERROR(@errNoUserName,16,1)
		
		IF ISNULL(@pDepartmentCode,'') = ''
			RAISERROR(@errNoUserName,16,1)

		SELECT AppUserProfileID
		  ,UserName 
		  ,FullName
		  ,AppUserRoleCode
		  ,DepartmentCode
		FROM dbo.AppUserProfile WITH (NOLOCK)
		WHERE InActive = 0 
		AND DepartmentCode = @pDepartmentCode
		ORDER BY UserName, StartDate
	END TRY

	BEGIN CATCH			
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH			

