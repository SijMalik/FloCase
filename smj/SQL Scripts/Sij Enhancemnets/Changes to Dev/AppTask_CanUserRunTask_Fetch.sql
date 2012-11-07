USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[AppTask_CanUserRunTask_Fetch]    Script Date: 09/24/2012 12:49:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[AppTask_CanUserRunTask_Fetch] (
@pAppTaskID int = NULL,				-- Mandatory
@pUserName	nvarchar(255) = NULL	-- Mandatory
)
--==============================================================--
-- Created By:	GV
-- Create Date:	22-09-2011
-- Description:	This SP checks if a user can perform a task
--==============================================================--  

--==============================================================--
-- Amended By:	GQL
-- Create Date:	15-03-2012
-- Description:	Plug loop hole whereby the Fee Earner on a matter can 
-- run a supervisor task if they are a TL in AppUserProfile
-- And also commented the SP
--==============================================================--  

AS
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 05-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================
	SET NOCOUNT ON
	DECLARE @AssignedTo	nvarchar(155) 
	DECLARE @AppInstanceValue nvarchar(50)
	DECLARE @AssignedToLevel int
	DECLARE @UserNameLevel int
	DECLARE @errNoAppTaskID VARCHAR(50)
	
	SET @errNoAppTaskID = 'No @pAppTaskID pass in.'
	
	BEGIN TRY

		--CHECK TO ENSURE THAT AN APPTASKID HAS BEEN PASSED
		IF @pAppTaskID IS NULL
			RAISERROR (@errNoAppTaskID, 16, 1)
					
		--RETRIEVE VARIABLE VALUES FROM TASKID SUPPLIED
		SELECT	@AssignedTo = AssignedTo,
				@AppInstanceValue = AppInstanceValue
		FROM	dbo.AppTask WITH (NOLOCK)
		WHERE	AppTaskID = @pAppTaskID
		AND		StatusCode = 'Active'
			

		--IF THE USER TRYING TO RUN THE TASK IS ATTACHED TO THE MATTER
		IF EXISTS(SELECT UserName FROM dbo.AppUser WITH (NOLOCK) WHERE InActive = 0 AND AppInstanceValue = @AppInstanceValue AND UserName = @pUserName)
		BEGIN
			--RETRIEVE THIER HIGHEST ACCESS LEVEL BASED ON THIER CASE ROLE TYPE
			SELECT @UserNameLevel = MIN(L.[Level])
			FROM
			(SELECT		u.UserName, u.AppUserRoleCode, t.[Description], t.[Level]
				FROM	dbo.AppUser u WITH (NOLOCK) INNER JOIN
						dbo.AppUserRoleTypes t WITH (NOLOCK) ON u.AppUserRoleCode = t.Code
				WHERE   t.Inactive = 0 
				AND		u.InActive = 0
				AND		u.UserName = @pUserName 
				AND		u.AppInstanceValue = @AppInstanceValue
			) L
		END
		--ELSE THEY ARE NOT ATTACHED TO THE CASE
		ELSE
		BEGIN
			--RETRIEVE THIER HIGHEST ACCESS LEVEL BASED ON THIER APPUSERPROFILE ROLE TYPE
			SELECT  @UserNameLevel = t.[Level]
			FROM	dbo.AppUserRoleTypes t WITH (NOLOCK) INNER JOIN
					dbo.AppUserProfile u WITH (NOLOCK) ON t.Code = u.AppUserRoleCode
			WHERE   t.Inactive = 0
			AND		u.InActive = 0
			AND		u.UserName = @pUserName
		END

		--IF THE USER THE TASK IS ASSIGNED TO IS STILL ATTACHED TO THE MATTER
		IF EXISTS(SELECT UserName FROM dbo.AppUser WITH (NOLOCK) WHERE InActive = 0 AND AppInstanceValue = @AppInstanceValue AND UserName = @AssignedTo)
		BEGIN
			--RETRIEVE THIER HIGHEST ACCESS LEVEL BASED ON THIER CASE ROLE TYPE
			SELECT  @AssignedToLevel = MIN(t.[Level])
			FROM	dbo.AppUserRoleTypes t WITH (NOLOCK) INNER JOIN
					dbo.AppUser u WITH (NOLOCK) ON t.Code = u.AppUserRoleCode
			WHERE	t.Inactive = 0 
			AND		u.InActive = 0
			AND		u.AppInstanceValue = @AppInstanceValue
			AND		u.UserName = @AssignedTo
		END
		--ELSE THEY ARE NOT ATTACHED TO THE CASE
		ELSE
		BEGIN
			--RETRIEVE THIER HIGHEST ACCESS LEVEL BASED ON THIER APPUSERPROFILE ROLE TYPE
			SELECT	@AssignedToLevel = MIN(t.[Level])
			FROM	dbo.AppUserRoleTypes t WITH (NOLOCK) INNER JOIN
					dbo.AppUserProfile a WITH (NOLOCK) ON t.Code = a.AppUserRoleCode 
			WHERE	t.Inactive = 0
			AND		a.InActive = 0
			AND		a.UserName = @AssignedTo
		END
		
		--RETURN ACCESS LEVEL INFORMATION
		SELECT	@AssignedToLevel AS AssignedToLevel, 
				@UserNameLevel AS UserNameLevel, 
				Case WHEN @UserNameLevel <= ISNULL(@AssignedToLevel,0) THEN 'Yes' 
				ELSE 'No' 
				END AS CanPerformTask
	END TRY
	
	BEGIN CATCH
		SELECT ERROR_MESSAGE()  + ' SP:' + OBJECT_NAME(@@PROCID)
	END CATCH
			