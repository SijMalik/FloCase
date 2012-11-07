USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[AppDefinitionSchedule_Save]    Script Date: 09/24/2012 12:45:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[AppDefinitionSchedule_Save]
(
	@AppTaskDefinitionCode						nvarchar(50) = '',		-- Manditory
    @ScheduleDefinitionName						nvarchar(255) = ''		-- Manditory
)
AS

	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 05-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================
	

	SET NOCOUNT ON
	DECLARE @AppDefinitionScheduleID INT
  	DECLARE @errNoAppTaskDefCode VARCHAR(50)
  	DECLARE @errNoSchedDefName VARCHAR(50)
  	DECLARE @errRecExist VARCHAR(50)
  	
  	SET @errNoAppTaskDefCode = 'No @pAppTaskDefinitionCode passed in.'
  	SET @errNoSchedDefName = 'No @pScheduleDefinitionName passed in.'
  	  	
	BEGIN TRY
		--Error-checking
		IF @AppTaskDefinitionCode = ''  
			RAISERROR (@errNoAppTaskDefCode, 16,1) 
		
		IF @ScheduleDefinitionName = ''  
			RAISERROR (@errNoSchedDefName, 16,1) 
		----
	
		IF NOT EXISTS (SELECT AppDefinitionScheduleID
						FROM dbo.AppDefinitionSchedule WITH (NOLOCK)
						WHERE (AppTaskDefinitionCode = @AppTaskDefinitionCode)
							AND (ScheduleDefinitionName = @ScheduleDefinitionName))
		BEGIN 
			INSERT INTO dbo.AppDefinitionSchedule (AppTaskDefinitionCode, ScheduleDefinitionName)
			VALUES (@AppTaskDefinitionCode, @ScheduleDefinitionName)
		END
		                    
		SET @AppDefinitionScheduleID = SCOPE_IDENTITY()
	END TRY
	
	BEGIN CATCH
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH
