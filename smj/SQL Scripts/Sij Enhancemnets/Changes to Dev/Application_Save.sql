USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[Application_Save]    Script Date: 09/24/2012 12:46:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[Application_Save]
(
	@ApplicationID		int	= 0 ,
	@Name				nvarchar(255)  = '',	
	@Code				nvarchar(50)  = '',	
	@Description		nvarchar(1000)  = '',	
	@CategoryCode		nvarchar(50)  = '',	
	@IsCaseManagement	bit = 1	
)
AS
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 05-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema name
	-- ===============================================================
  	
	SET NOCOUNT ON	
  	
	BEGIN TRY
		--If there is no @CaseTaskDefinition_CaseTaskDefinitionID i.e. we are creating a new case
		IF NOT EXISTS (SELECT ApplicationID
						FROM dbo.[Application] WITH (NOLOCK)
						WHERE Code = @Code)
		BEGIN
			-- Insert a new Application record
			INSERT INTO dbo.[Application] 
				   (Name,
					Code,
					[Description],
					CategoryCode,
					IsCaseManagement)
			 VALUES
				   (@Name,
					@Code,
					@Description,
					@CategoryCode,
					@IsCaseManagement)
					
		END
		ELSE
		BEGIN
			UPDATE	dbo.[Application]
			SET		Name				= @Name,
					[Description]		= @Description,
					CategoryCode		= @CategoryCode,
					IsCaseManagement	= @IsCaseManagement
			WHERE	Code = @Code
		END
	END TRY
		
	BEGIN CATCH
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH