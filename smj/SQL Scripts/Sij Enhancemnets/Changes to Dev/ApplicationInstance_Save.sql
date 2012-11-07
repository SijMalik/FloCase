USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[ApplicationInstance_Save]    Script Date: 09/24/2012 12:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[ApplicationInstance_Save]
(
	@ApplicationInstanceID	int	= 0,
	@ApplicationCode		nvarchar(50)  = '',	
	@IdentifierValue		nvarchar(50)  = '',
	@CaseID					int = 0,
	@pAExpert_MatterUno		int = 0,
	@UserName				nvarchar(255)  = 'Admin'
)
AS
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 05-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================
  	
	SET NOCOUNT ON
  	DECLARE @errNoAppCode VARCHAR(50)
  	DECLARE @errIDVal VARCHAR(50)
  	DECLARE @errRecExist VARCHAR(50)
  	
  	SET @errNoAppCode = 'No @ApplicationCode passed in.'
  	SET @errIDVal = 'No @IdentifierValue passed in.'
  	
  	
	BEGIN TRY
		--Error-checking
		IF @ApplicationCode = ''  
			RAISERROR (@errNoAppCode, 16,1) 
		
		IF @IdentifierValue = ''  
			RAISERROR (@errIDVal, 16,1) 
		----	
	
		BEGIN TRANSACTION ApplicationInstance_Save
		
		IF NOT EXISTS (SELECT ApplicationInstanceID
						FROM dbo.ApplicationInstance WITH (NOLOCK)
						WHERE ApplicationCode = @ApplicationCode 
						AND IdentifierValue  = @IdentifierValue)
		BEGIN

			INSERT INTO dbo.ApplicationInstance (ApplicationCode, IdentifierValue, CaseID, AExpert_MatterUno)
			VALUES (@ApplicationCode, @IdentifierValue, @CaseID, @pAExpert_MatterUno)

			EXEC AppTask_Complete
				@AppTaskID				= 0,
				@UserName				= @UserName,		
				@CompletedBy			= @UserName,				
				@AppTaskDefinitionCode	= 'OpenCase',		
				@AppInstanceValue		= @IdentifierValue
				   
		END	
		
		COMMIT TRANSACTION ApplicationInstance_Save
	END TRY
	

	BEGIN CATCH
		IF @@TRANCOUNT > 0 
			ROLLBACK TRANSACTION ApplicationInstance_Save

		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH

