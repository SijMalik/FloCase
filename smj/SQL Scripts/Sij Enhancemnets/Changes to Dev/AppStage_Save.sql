USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[AppStage_Save]    Script Date: 09/24/2012 12:48:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[AppStage_Save]
(
	@AppStageCode			nvarchar(50)  = '',	
	@ApplicationCode		nvarchar(50)  = '',
	@Description			nvarchar(250)  = ''
)
AS
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 05-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================
  	
	SET NOCOUNT ON	
  	
	BEGIN TRY
		
		IF NOT EXISTS (SELECT AppStageID
						FROM dbo.AppStage WITH (NOLOCK)
						WHERE ApplicationCode = @ApplicationCode 
						AND AppStageCode = @AppStageCode)
		BEGIN
			INSERT INTO dbo.AppStage (ApplicationCode, AppStageCode, [Description])
			VALUES (@ApplicationCode, @AppStageCode, @Description)
		END	
		ELSE
		BEGIN
			UPDATE dbo.AppStage
			SET  [Description]= @Description
			WHERE ApplicationCode = @ApplicationCode
			AND AppStageCode = @AppStageCode			
		END
	END TRY

	BEGIN CATCH
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH	
