USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[LTMM_ReferenceContactComs_Save_SZS]    Script Date: 09/24/2012 18:40:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[LTMM_ReferenceContactComs_Save_SZS]
(
	@pContactComs_ContactComsID		int = 0,
	@pContactComs_ContactID			int = 0,
	@pContactComs_ComType			nvarchar(10) = '',
	@pContactComs_ComDetails		nvarchar(256) = '',
	@pContactComs_InActive			bit = 0,
	@pCreateUser					nvarchar(50) = ''
)	
AS

	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ==============================================================
	
--Intialise Error trapping
SET NOCOUNT ON


--Intialise create date
DECLARE @PCREATEDATE SMALLDATETIME
DECLARE @errNoUserName VARCHAR(50)


	--Intialise Create date to today
	SET @PCREATEDATE = CAST(GETDATE() AS SMALLDATETIME)
	
	SET @errNoUserName = 'YOU MUST PROVIDE A @pCreateUser.'


	BEGIN TRY
		BEGIN TRANSACTION LTMMContactComsSave

		--Test to see that a username has been supplied
		IF (ISNULL(@pCreateUser,'') = '')
			RAISERROR (@errNoUserName,16,1)

		--If no existing address id passed
		IF (ISNULL(@pContactComs_ContactComsID,0)=0)
		BEGIN
			--insert new comms record

			INSERT INTO dbo.ContactComs(
			ContactComs_ContactID,
			ContactComs_ComType,
			ContactComs_ComDetails,
			ContactComs_InActive,
			CreateUser,
			CreateDate)
			VALUES(
			@pContactComs_ContactID,
			@pContactComs_ComType,
			@pContactComs_ComDetails,
			@pContactComs_InActive,
			@pCreateUser,
			@PCREATEDATE)
			
			--capture the id of the new comms record
			SET @pContactComs_ContactComsID = SCOPE_IDENTITY()
			
					
		END
		ELSE
		BEGIN
			--If we are trying to set an existing comm as inactive
			IF @pContactComs_InActive = 1
			BEGIN
				--update the comm as inactive
				UPDATE dbo.ContactComs 
				SET ContactComs_InActive = 1 
				WHERE ContactComs_ContactComsID = @pContactComs_ContactComsID 
			END
			ELSE
			BEGIN	
				--update the comm as inactive
				
				UPDATE dbo.ContactComs 
				SET ContactComs_InActive = 1 
				WHERE ContactComs_ContactComsID = @pContactComs_ContactComsID 
				
				--insert new comms record
				INSERT INTO dbo.ContactComs(
				ContactComs_ContactID,
				ContactComs_ComType,
				ContactComs_ComDetails,
				ContactComs_InActive,
				CreateUser,
				CreateDate)
				VALUES(
				@pContactComs_ContactID,
				@pContactComs_ComType,
				@pContactComs_ComDetails,
				@pContactComs_InActive,
				@pCreateUser,
				@PCREATEDATE)
				
				--capture the id for the new record
				SET @pContactComs_ContactComsID = SCOPE_IDENTITY()
				
			END		
		END


		COMMIT TRANSACTION LTMMContactComsSave

		SELECT @pContactComs_ContactComsID as Contact_ContactID
	END TRY
	
	BEGIN CATCH		
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION LTMMContactComsSave
			
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH	



