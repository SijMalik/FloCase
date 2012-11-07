ALTER PROC [dbo].[AppTask_Update]
(
	@AppTaskID				int			  = 0,		-- Manditory.
	@UserName				nvarchar(255) = '',		-- Manditory.  Map System.Username for Current User
	@DueDate				smalldatetime = NULL,	-- Optional. If empty, ScheduleDefinition or Now will be used.	
	@pEscdate				smalldatetime = NULL,	-- Optional.
	@pEscUser				nvarchar(255) = '',		-- Optional.
	@pEscAppTaskID			int			  = 0,		-- Optional.	
	@pEscTaskText			nvarchar(255) = '',		-- Optional.
	@pAttPerson				nvarchar(255) = '',
	@pAttTime				nvarchar(255) = '',
	@pAttNature				nvarchar(255) = '',
	@pTaskDesc				nvarchar(255) = '',
	@pComment				nvarchar(max) = '',
	@pAttDate				smalldatetime = NULL
)
AS
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================
	SET NOCOUNT ON

	BEGIN TRY		
		BEGIN TRANSACTION Updater
		
		IF (@UserName = '')
		BEGIN
			SET @UserName = (SELECT AssignedTo FROM dbo.AppTask WITH (NOLOCK) WHERE AppTaskID = @AppTaskID)
		END
		IF (@DueDate IS NULL)
		BEGIN
			SET @DueDate = (SELECT DueDate FROM dbo.AppTask WITH (NOLOCK) WHERE AppTaskID = @AppTaskID)
		END
					
		UPDATE dbo.AppTask
		SET 
			DueDate		= @DueDate,
			AssignedTo	= @UserName,
			Escdate		= @pEscdate,
			EscUser		= @pEscUser,
			EscAppTaskID = @pEscAppTaskID,
			EscTaskText = @pEscTaskText,
			PersonAttending = @pAttPerson,
			AttTime = @pAttTime,
			AttDate = @pAttDate,
			NatureAttendance = @pAttNature,
			[Description] = @pTaskDesc,
			Comment = @pComment
			
		WHERE (AppTaskID = @AppTaskID) 
			
		COMMIT TRANSACTION Updater
		
		SELECT @AppTaskID AS AppTaskID
		
	END TRY
	
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION Updater
			
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH

