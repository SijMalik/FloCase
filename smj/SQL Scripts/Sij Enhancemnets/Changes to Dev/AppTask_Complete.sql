USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[AppTask_Complete]    Script Date: 09/24/2012 12:50:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[AppTask_Complete]
(
	@AppTaskID				int = 0,					-- Optional. Might have picked up pending task.
	@UserName				nvarchar(255)  = '',		-- Mandatory.  Map System.Username for Current User
	@CompletedBy			nvarchar(255)  = '',		-- Mandatory. Use System.UserName
	@CompletedDate			smalldatetime = NULL,		-- Optional. Will use 'now' if empty.
	@AppTaskDefinitionCode	nvarchar(50)  = '',			-- Mandatory if inserting new task
	@AppInstanceValue		nvarchar(50)  = '',			-- Manditory if inserting new task and no CaseID. 
	@CaseID					int = 0,					-- Optional.
	@Description			nvarchar(255)  = NULL,		-- Optional. If empty, Definition Description will be used.
	@CreatedBy				nvarchar(255)  = '',		-- Optional. If empty, CompletedBy will be used.
	@AssignedTo				nvarchar(255)  = '',		-- Optional. If empty, CompletedBy will be used.
	@DueDate				smalldatetime = NULL,		-- Optional. If empty, ScheduleDefinition or Now will be used.
	@CaseContactID			int = 0,					-- Optional
	@DocumentID				int = 0,					-- Optional
	@CustomID1				int = 0,					-- Optional
	@CustomID2				int = 0,					-- Optional
	@CustomID3				int = 0,					-- Optional
	@CustomID4				int = 0,					-- Optional
	@CustomID5				int = 0,						-- Optional
	@pAppTaskSubTypeCode	nvarchar(50) = '',
	@pComment				nvarchar(max) = '',
	@pPriorityCode			nvarchar(10) = '',
	@pHistoricalTaskDesc	nvarchar(255) = '',
	@pOutlookTaskOption		nvarchar(10) = '',
	@pPersonAttending		nvarchar(255) = '',
	@pAttDate				smalldatetime = NULL,
	@pAttTime				nvarchar(255)  = '',
	@pNatureAttendance		nvarchar(255) = '',
	@pPrintStatus			nvarchar(50)= '',
	@pPrintDate				datetime = NULL
)
AS

	------------------------------------------------------------------------------
	-- Modified by GV on 22/09/2011
	-- SP extended so completed tasks will show original description if none passed in
	------------------------------------------------------------------------------
	
	------------------------------------------------------------------------------
	-- Modified by SMJ on 28/09/2011
	-- Added new columns PrintStatus and DateLastPrinted to AppTask table
	-- Added param @pPrintStatus to populatePrinStatus DateLastPrinted =  GETDATE()
	------------------------------------------------------------------------------	

	------------------------------------------------------------------------------
	-- Modified by GV on 13/10/2011
	-- SP extended to pass in the date printed rather that using GETDATE()
	------------------------------------------------------------------------------	
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 05-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================
  	
	SET NOCOUNT ON
	DECLARE @ESCID INT
  	DECLARE @errNoAppInsCaseID VARCHAR(50)
  	
  	SET @errNoAppInsCaseID = 'No @AppInstanceValue and @CaseID passed in'
  	
	BEGIN TRY
		
		BEGIN TRANSACTION AppTaskComplete
		
		IF (@CompletedDate IS NULL)
			SET @CompletedDate = GETDATE()
			
		IF (@AppTaskDefinitionCode <> '') AND (ISNULL(@AppTaskID, 0) = 0)
		BEGIN
			IF (ISNULL(@AppInstanceValue, '') = '') AND (ISNULL(@CaseID, 0) = 0)
				Raiserror (@errNoAppInsCaseID, 16, 1)
			
			IF 	(ISNULL(@AppInstanceValue,'') = '')
			BEGIN
				SELECT @AppInstanceValue = IdentifierValue
				FROM dbo.ApplicationInstance WITH (NOLOCK)
				WHERE CaseID = @CaseID
			END
			
			IF @CreatedBy = ''
				SET @CreatedBy = @CompletedBy
				
			IF @AssignedTo = ''
				SET @AssignedTo = @CompletedBy
				
			IF @DueDate IS NULL
				SET @DueDate = @CompletedDate
			
			EXEC AppTask_CreatePending				
				@AppTaskDefinitionCode	= @AppTaskDefinitionCode,		
				@AppInstanceValue		= @AppInstanceValue,			
				@CaseID					= @CaseID,
				@Description			= @Description,
				@CreatedBy				= @CreatedBy,
				@AssignedTo				= @AssignedTo,		
				@DueDate				= @DueDate,		
				@CaseContactID			= @CaseContactID,				
				@DocumentID				= @DocumentID,				
				@CustomID1				= @CustomID1,				
				@CustomID2				= @CustomID2,					
				@CustomID3				= @CustomID3,				
				@CustomID4				= @CustomID4,				
				@CustomID5				= @CustomID5,
				@pAppTaskSubTypeCode	= @pAppTaskSubTypeCode,
				@pComment				= @pComment,
				@pPriorityCode			= @pPriorityCode,
				@pHistoricalTaskDesc	= @pHistoricalTaskDesc,
				@pOutlookTaskOption		= @pOutlookTaskOption,
				@pPersonAttending		= @pPersonAttending,
				@pAttDate				= @pAttDate,
				@pAttTime				= @pAttTime,
				@pNatureAttendance		= @pNatureAttendance
			
			SET @AppTaskID = 
				(	
					SELECT	MAX(AppTaskID)
					FROM	dbo.AppTask WITH (NOLOCK)
					WHERE	AppTaskDefinitionCode = @AppTaskDefinitionCode
					AND		AppInstanceValue = @AppInstanceValue
					AND		CreatedBy = @CreatedBy
				)
		END
		
		IF @AppTaskDefinitionCode = 'CCM'
			SET @CompletedDate = DATEADD(MINUTE,1,@CompletedDate)
		
		UPDATE	dbo.AppTask
		SET 	CompletedBy		= @CompletedBy,
				CompletedDate	= @CompletedDate,
				StatusCode		= 'Complete',
				[Description]	= ISNULL(@Description,[Description]),-- Modified by GV on 22/09/2011
				Comment			= @pComment,
				PrintStatus		= @pPrintStatus, --SMJ
				DateLastPrinted = @pPrintDate --GV				
		WHERE	AppTaskID		= @AppTaskID
		
		--REMOVE ANY ESCALATION CONNECTED TO THE COMPLETED TASK		
		SELECT @ESCID = EscAppTaskID 
						FROM dbo.AppTask WITH (NOLOCK) 
						WHERE AppTaskID = @AppTaskID
		
		IF ISNULL(@ESCID,0) <> 0
		BEGIN
			UPDATE	dbo.AppTask
			SET 	CompletedBy		= @CompletedBy,
					CompletedDate	= @CompletedDate,
					StatusCode		= 'Complete',
					[Description]	= @Description,
					Comment			= @pComment			
			WHERE	AppTaskID		= @ESCID 
		END

		COMMIT TRANSACTION AppTaskComplete
	END TRY
		

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION AppTaskComplete
			
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH

