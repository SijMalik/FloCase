USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[LTMM_ReferenceContactAddress_Save_SZS]    Script Date: 09/24/2012 18:45:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[LTMM_ReferenceContactAddress_Save_SZS]
(
	@pContactAddress_ContactAddressID			int = 0 OUTPUT,
	@pContactAddress_ContactID					int = 0,
	@pContactAddress_AddressType				nvarchar(10) = '',	
	@pContactAddress_Address1					nvarchar(50) = '',
	@pContactAddress_Address2					nvarchar(50) = '',
	@pContactAddress_Address3					nvarchar(50) = '',
	@pContactAddress_Address4					nvarchar(50) = '',
	@pContactAddress_Town						nvarchar(50) = '',
	@pContactAddress_County						nvarchar(50) = '',
	@pContactAddress_Postcode					nvarchar(50) = '',
	@pContactAddress_Country					nvarchar(50) = '',
	@pContactAddress_DXNumber					nvarchar(50) = '',
	@pContactAddress_DXExchange					nvarchar(50) = '',
	@pContactAddress_AddressOrder				int = 0,
	@pContactAddress_Inactive					bit = 0,
	@pCreateUser								nvarchar(50) = ''
)	
AS

--Stored Procedure to either insert a new Contact Address or update an Existing one
--On update the previous version is kept and set as inactive with the amendments being inserted as a new record
--Author(s) GQL
--14-08-2009
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
		IF ISNULL(@pContactAddress_DXNumber,'') <> ''
		BEGIN

			  SET @pContactAddress_DXNumber = REPLACE(@pContactAddress_DXNumber,'DX','')
		      
			  SET @pContactAddress_DXNumber = REPLACE(@pContactAddress_DXNumber,':','')

			  SET @pContactAddress_DXNumber = 'DX: ' + REPLACE(@pContactAddress_DXNumber,' ','')
		END

		BEGIN TRANSACTION LTMMContactAddressSave

		--Test to see that a username has been supplied
		IF (ISNULL(@pCreateUser,'') = '')
			RAISERROR (@errNoUserName,16,1)
			
		--If no existing address id passed
		IF (ISNULL(@pContactAddress_ContactAddressID,0)=0)
		BEGIN

			IF ISNULL(@pContactAddress_Inactive,0) = 0
			BEGIN
				SET @pContactAddress_Inactive = 0
			END
			
			--insert new address record
			INSERT INTO dbo.ContactAddress(
			ContactAddress_ContactID,
			ContactAddress_AddressType,
			ContactAddress_Address1,
			ContactAddress_Address2,
			ContactAddress_Address3,
			ContactAddress_Address4,
			ContactAddress_Town,
			ContactAddress_County,
			ContactAddress_Postcode,
			ContactAddress_Country,
			ContactAddress_DXNumber,
			ContactAddress_DXExchange,
			ContactAddress_AddressOrder,
			ContactAddress_Inactive,
			CreateUser,
			CreateDate)
			VALUES(
			@pContactAddress_ContactID,
			@pContactAddress_AddressType,
			@pContactAddress_Address1,
			@pContactAddress_Address2,
			@pContactAddress_Address3,
			@pContactAddress_Address4,
			@pContactAddress_Town,
			@pContactAddress_County,
			@pContactAddress_Postcode,
			@pContactAddress_Country,
			@pContactAddress_DXNumber,
			@pContactAddress_DXExchange,
			@pContactAddress_AddressOrder,
			@pContactAddress_Inactive,
			@pCreateUser,
			@PCREATEDATE)
			
			--capture the id of teh new address record
			SET @pContactAddress_ContactAddressID = SCOPE_IDENTITY()
				
		END
		ELSE
		BEGIN
			--If we are trying to set an existing address as inactive
			IF @pContactAddress_Inactive = 1
			BEGIN
				--update the address as inactive
				UPDATE dbo.ContactAddress 
				SET ContactAddress_Inactive = 1 
				WHERE ContactAddress_ContactAddressID = @pContactAddress_ContactAddressID 
			END
			ELSE
			BEGIN	
				--update the old record as inactive for the purpose of archiving
				UPDATE dbo.ContactAddress 
				SET ContactAddress_Inactive = 1 
				WHERE ContactAddress_ContactAddressID = @pContactAddress_ContactAddressID 
				
				--insert the new details as a new record
				INSERT INTO dbo.ContactAddress(
				ContactAddress_ContactID,
				ContactAddress_AddressType,
				ContactAddress_Address1,
				ContactAddress_Address2,
				ContactAddress_Address3,
				ContactAddress_Address4,
				ContactAddress_Town,
				ContactAddress_County,
				ContactAddress_Postcode,
				ContactAddress_Country,
				ContactAddress_DXNumber,
				ContactAddress_DXExchange,
				ContactAddress_AddressOrder,
				ContactAddress_Inactive,
				CreateUser,
				CreateDate)
				VALUES(
				@pContactAddress_ContactID,
				@pContactAddress_AddressType,
				@pContactAddress_Address1,
				@pContactAddress_Address2,
				@pContactAddress_Address3,
				@pContactAddress_Address4,
				@pContactAddress_Town,
				@pContactAddress_County,
				@pContactAddress_Postcode,
				@pContactAddress_Country,
				@pContactAddress_DXNumber,
				@pContactAddress_DXExchange,
				@pContactAddress_AddressOrder,
				@pContactAddress_Inactive,
				@pCreateUser,
				@PCREATEDATE)
				
				--capture the id for the new record
				SET @pContactAddress_ContactAddressID = SCOPE_IDENTITY()
				
			END		
		END

		COMMIT TRANSACTION LTMMContactAddressSave

		--return the address id
		SELECT @pContactAddress_ContactAddressID as Contact_ContactID
	END TRY

	BEGIN CATCH		
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION LTMMContactAddressSave
			
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH	


