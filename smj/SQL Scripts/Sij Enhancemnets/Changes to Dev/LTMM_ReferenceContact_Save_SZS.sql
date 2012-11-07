USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[LTMM_ReferenceContact_Save_SZS]    Script Date: 09/24/2012 18:28:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[LTMM_ReferenceContact_Save_SZS]
(
	@pContact_ContactID							int = 0 OUTPUT,
	@pContact_ContactType						nvarchar(250) = '',
	@pContact_Title								nvarchar(50) = '',
	@pContact_Forename							nvarchar(250) = '',
	@pContact_Surname							nvarchar(250) = '',
	@pContact_Corporate							nvarchar(1) = '',
	@pContact_CompanyName						nvarchar(250) = '',
	@pContact_Position							nvarchar(250) = '',
	@pContact_GenderCode						nvarchar(10) = '',
	@pContact_DOB								smalldatetime = NULL,
	@pContact_RegionCode						nvarchar(10) = '',
	@pContact_Blockbook							nvarchar(3) = '',						
	@pContact_FieldOfExpertise					nvarchar(max) = '',
	@pContact_Inactive							bit = 0,
	@UserName									nvarchar(50) = '',
	@pContactAddress_ContactAddressID			int = 0,
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
	@PriFax										nvarchar(50) = '',
	@PriTel										nvarchar(50) = '',
	@PriEma										nvarchar(50) = '',
	@RefContactType_RefContactTypeID			int=0,  --Newly added to cater for contact table name
	@ReferenceDB_SourceID						int=0,  --Id from contact table type e.g VEC_Counsel, Medical etc
	@SecTel										nvarchar(50) = '' --GQL 02/08/2011 added for inclusion of alternative tel for med experts
)	
AS
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================	
--Intialise Error trapping
SET NOCOUNT ON


DECLARE @pContactComs_ContactComsID int
DECLARE @pContactComs_ContactID int
DECLARE @pContactComs_ComType nvarchar(10)
DECLARE @pContactComs_ComDetails nvarchar(256)
DECLARE @pContactComs_InActive bit
DECLARE @pCreateUser nvarchar(10)
DECLARE @PCREATEDATE SMALLDATETIME
DECLARE @errNoUserName VARCHAR(50)
DECLARE @errCantsetInactive VARCHAR(100)

	--Intialise Create date to today
	SET @PCREATEDATE = CAST(GETDATE() AS SMALLDATETIME)
	
	SET @errNoUserName = 'YOU MUST PROVIDE A @UserName.'
	SET @errCantsetInactive = 'Unable to set as inactive as this Contact is atached to active cases.'

	
	BEGIN TRY
	
	
		--Test to see that a username has been supplied
		IF (ISNULL(@UserName,'') = '')
			RAISERROR (@errNoUserName,16,1)

		----IF no existing contact ID has been passed from Reference.dbo.AAAA --where AAAA one of the contact tables e.g Medical
		--IF (ISNULL(@pContact_ContactID,0))=0
		IF NOT EXISTS (SELECT cont.*
			  ,ContA.ContactAddress_PostCode
		  FROM [dbo].[Contact]  cont with (nolock)
		  Inner join dbo.ContactAddress  contA with (nolock)
		  on Cont.Contact_ContactID=contA.ContactAddress_ContactID
		  Where cont.ReferenceDB_SourceID=@ReferenceDB_SourceID and cont.RefContactType_RefContactTypeID=@RefContactType_RefContactTypeID)
		BEGIN
			--insert new contact record
			INSERT INTO dbo.Contact (
			Contact_ContactType,
			Contact_Title,
			Contact_Forename,
			Contact_Surname,
			Contact_Corporate,
			Contact_CompanyName,
			Contact_Position,
			Contact_GenderCode,
			Contact_DOB,
			Contact_RegionCode,
			Contact_Blockbook,						
			Contact_FieldOfExpertise,
			Contact_Inactive,
			CreateUser,
			CreateDate,
			RefContactType_RefContactTypeID,
			ReferenceDB_SourceID)
			VALUES(
			@pContact_ContactType,
			@pContact_Title,
			@pContact_Forename,
			@pContact_Surname,
			@pContact_Corporate,
			@pContact_CompanyName,
			@pContact_Position,
			@pContact_GenderCode,
			@pContact_DOB,
			@pContact_RegionCode,
			@pContact_Blockbook,
			@pContact_FieldOfExpertise,
			@pContact_Inactive,
			@UserName,
			@PCREATEDATE,
			@RefContactType_RefContactTypeID,
			@ReferenceDB_SourceID)
			
			--get the id of teh new conatct record added to teh table
			SET @pContact_ContactID = SCOPE_IDENTITY()		
			
			EXECUTE LTMM_ReferenceContactAddress_Save_SZS
			   @pContactAddress_ContactAddressID OUTPUT
			  ,@pContact_ContactID
			  ,@pContactAddress_AddressType
			  ,@pContactAddress_Address1
			  ,@pContactAddress_Address2
			  ,@pContactAddress_Address3
			  ,@pContactAddress_Address4
			  ,@pContactAddress_Town
			  ,@pContactAddress_County
			  ,@pContactAddress_Postcode
			  ,@pContactAddress_Country
			  ,@pContactAddress_DXNumber
			  ,@pContactAddress_DXExchange
			  ,@pContactAddress_AddressOrder
			  ,0
			  ,@UserName
			
			IF ISNULL(@PriFax,'')<>''
			BEGIN
				EXECUTE LTMM_ReferenceContactComs_Save_SZS
				   @pContactComs_ContactComsID = 0
				  ,@pContactComs_ContactID = @pContact_ContactID
				  ,@pContactComs_ComType = 'PriFax'
				  ,@pContactComs_ComDetails = @PriFax 
				  ,@pContactComs_InActive = 0
				  ,@pCreateUser = @UserName
				  --,@pCreateUser = 'ADMIN'
				  
			END	

			IF ISNULL(@PriTel,'')<>''
			BEGIN
				EXECUTE LTMM_ReferenceContactComs_Save_SZS
				   @pContactComs_ContactComsID = 0
				  ,@pContactComs_ContactID = @pContact_ContactID
				  ,@pContactComs_ComType = 'PriTel'
				  ,@pContactComs_ComDetails = @PriTel 
				  ,@pContactComs_InActive = 0
				  ,@pCreateUser = @UserName
				  --,@pCreateUser = 'ADMIN'
			END
			
			IF ISNULL(@SecTel,'')<>''
			BEGIN
				EXECUTE LTMM_ReferenceContactComs_Save_SZS
				   @pContactComs_ContactComsID = 0
				  ,@pContactComs_ContactID = @pContact_ContactID
				  ,@pContactComs_ComType = 'Tel'
				  ,@pContactComs_ComDetails = @SecTel  
				  ,@pContactComs_InActive = 0
				  ,@pCreateUser = @UserName
				  --,@pCreateUser = 'ADMIN'
			END
				
			IF ISNULL(@PriEma,'')<>''
			BEGIN
				EXECUTE LTMM_ReferenceContactComs_Save_SZS
				   @pContactComs_ContactComsID = 0
				  ,@pContactComs_ContactID = @pContact_ContactID
				  ,@pContactComs_ComType = 'PriEma'
				  ,@pContactComs_ComDetails = @PriEma 
				  ,@pContactComs_InActive = 0
				  ,@pCreateUser = @UserName
				  --,@pCreateUser = 'ADMIN'
				  
			END	
		END
		--Else an existing contact ID has been passed
		ELSE
		BEGIN
			--set a variable to keep the contact id passed in
			DECLARE @OLDCONTACTID INT
			--SET @OLDCONTACTID = @pContact_ContactID
			Select @OLDCONTACTID =  MAX(Contact_ContactID) from dbo.Contact WITH (NOLOCK) where ReferenceDB_SourceID=@ReferenceDB_SourceID and
			RefContactType_RefContactTypeID=@RefContactType_RefContactTypeID  ---and  table name ??
			 and Contact_Inactive=0

			--if the contact is being set to inactive
			IF @pContact_Inactive = 1
			BEGIN
				--check to see if the contact is attached to any active matters  ??
				--IF EXISTS (SELECT CaseContacts_CaseContactsID FROM CaseContacts WHERE CaseContacts_ContactID = @pContact_ContactID AND CaseContacts_Inactive = 0)
				IF EXISTS (SELECT CaseContacts_CaseContactsID FROM dbo.CaseContacts WITH (NOLOCK) WHERE CaseContacts_ContactID = @OLDCONTACTID AND CaseContacts_Inactive = 0)
				BEGIN
					RAISERROR(@errCantsetInactive,16,1)
				END
				ELSE
				BEGIN
					-- Print 'Updating'
					--update contact to inactive whilst recording the username of the person carrying out this action along with the date
					--UPDATE Contact SET Contact_Inactive = 1, CreateUser = @UserName, CreateDate = @PCREATEDATE WHERE Contact_ContactID = @pContact_ContactID
					UPDATE dbo.Contact SET Contact_Inactive = 1, CreateUser = @UserName, CreateDate = @PCREATEDATE WHERE ReferenceDB_SourceID=@ReferenceDB_SourceID
							and RefContactType_RefContactTypeID=@RefContactType_RefContactTypeID 
				END
			END
			ELSE
			BEGIN
			--Compare and find changes
						 --DECLARE @Contact_ContactID int 
						 DECLARE @OldContact_ContactType nvarchar(250) 
						 DECLARE @OldContact_Title nvarchar(50) 
						 DECLARE @OldContact_Forename nvarchar(250)
						 DECLARE @OldContact_Surname nvarchar(250) 
						 DECLARE @OldContact_Corporate nvarchar(1)
						 DECLARE @OldContact_CompanyName nvarchar(250) 
						 DECLARE @OldContact_Position nvarchar(250) 
						 DECLARE @OldContact_GENDerCode nvarchar(10) 
						 DECLARE @OldContact_DOB smalldatetime 
						 DECLARE @OldContactAddress_AddressType nvarchar(10) 
						 DECLARE @OldContactAddress_Address1 nvarchar(50) 
						 DECLARE @OldContactAddress_Address2 nvarchar(50)
						 DECLARE @OldContactAddress_Address3 nvarchar(50) 
						 DECLARE @OldContactAddress_Address4 nvarchar(50) 
						 DECLARE @OldContactAddress_Town nvarchar(50) 
						 DECLARE @OldContactAddress_County nvarchar(50) 
						 DECLARE @OldContactAddress_Postcode nvarchar(50) 
						 DECLARE @OldContactAddress_Country nvarchar(50) 
						 DECLARE @OldContactAddress_DXNumber nvarchar(50) 
						 DECLARE @OldContactAddress_DXExchange nvarchar(50) 
						 DECLARE @OldContactAddress_RegionCode nvarchar(10) 
						 DECLARE @OldContactAddress_BlockBook nvarchar(3) 
						 DECLARE @OldContactAddress_Expertis nvarchar(max) 
						 DECLARE @Oldregion as nvarchar(max) 
						 DECLARE @OldPriFax1 nvarchar(50) 
						 DECLARE @OldPriTel1 nvarchar(50)
						 DECLARE @OldSecTel1 nvarchar(50)
						 DECLARE @OldPriEma1 nvarchar(50) 
						 Declare @OldRefContactType_RefContactTypeID int
						 
						 IF ISNULL(@pContactAddress_DXNumber,'') <> ''

						BEGIN

							 SET @pContactAddress_DXNumber = REPLACE(@pContactAddress_DXNumber,'DX','')
				
							-- SET @pContactAddress_DXNumber = REPLACE(@pContactAddress_DXNumber,'X','')
							 
							 SET @pContactAddress_DXNumber = REPLACE(@pContactAddress_DXNumber,':','')

							 SET @pContactAddress_DXNumber = 'DX: ' + REPLACE(@pContactAddress_DXNumber,' ','')

						END

						 
						 SELECT 
							@OldContact_ContactType=ISNULL([Contact_ContactType], '')
							,@OldContact_Title=ISNULL([Contact_Title], '')
							,@OldContact_Forename=ISNULL([Contact_Forename], '')
							,@OldContact_Surname=ISNULL([Contact_Surname], '')
							,@OldContact_Corporate=ISNULL([Contact_Corporate], '')
							,@OldContact_CompanyName=ISNULL([Contact_CompanyName], '')
							,@OldContact_Position=ISNULL([Contact_Position], '')
							,@OldContact_GENDerCode=ISNULL([Contact_GenderCode], '')
							,@OldContact_DOB=ISNULL([Contact_DOB], '')
							,@OldContactAddress_RegionCode=ISNULL([Contact_RegionCode], '')
							,@OldContactAddress_BlockBook=ISNULL([Contact_Blockbook], '')
							,@OldContactAddress_Expertis=ISNULL([Contact_FieldOfExpertise], '')
							,@OldRefContactType_RefContactTypeID=ISNULL([RefContactType_RefContactTypeID], '')
						FROM [dbo].[Contact] WITH (NOLOCK)
						where Contact_ContactID=@OldContactID

		--Added to establish old values from the ContactAddress	
		--SZS 2009-Dec-09			
						SELECT @OldContactAddress_AddressType=ISNULL([ContactAddress_AddressType], '')
						,@OldContactAddress_Address1=ISNULL([ContactAddress_Address1], '')
						  ,@OldContactAddress_Address2=ISNULL([ContactAddress_Address2], '')
						  ,@OldContactAddress_Address3=ISNULL([ContactAddress_Address3], '')
						  ,@OldContactAddress_Address4=ISNULL([ContactAddress_Address4], '')
						  ,@OldContactAddress_Town=ISNULL([ContactAddress_Town], '')
						  ,@OldContactAddress_County=ISNULL([ContactAddress_County], '')
						  ,@OldContactAddress_Postcode=ISNULL([ContactAddress_Postcode], '')
						  ,@OldContactAddress_Country=ISNULL([ContactAddress_Country], '')
						  ,@OldContactAddress_DXNumber=ISNULL([ContactAddress_DXNumber], '')
						  ,@OldContactAddress_DXExchange=ISNULL([ContactAddress_DXExchange], '')						  
						from dbo.ContactAddress WITH (NOLOCK)
						where ContactAddress_ContactID=@OldContactID
						IF ISNULL(@OldContactAddress_DXNumber,'') <> ''

						BEGIN

							 SET @OldContactAddress_DXNumber = REPLACE(@OldContactAddress_DXNumber,'DX','')			
							 
							 SET @OldContactAddress_DXNumber = REPLACE(@OldContactAddress_DXNumber,':','')

							 SET @OldContactAddress_DXNumber = 'DX: ' + REPLACE(@OldContactAddress_DXNumber,' ','')

						END
		--End of Changes SZS 2009-Dec-09	
						
						SELECT @OldPriFax1=ISNULL([ContactComs_ComDetails], '')
						FROM [dbo].[ContactComs] WITH (NOLOCK)
						Where [ContactComs_ContactID]=@OldContactID and 
						 [ContactComs_ComType]='PriFax' 
						 
						SELECT @OldPriTel1=ISNULL([ContactComs_ComDetails], '')
						 FROM [dbo].[ContactComs] WITH (NOLOCK)
						Where [ContactComs_ContactID]=@OldContactID and 
						[ContactComs_ComType]='PriTel' 
						
						SELECT @OldSecTel1=ISNULL([ContactComs_ComDetails], '')
						 FROM [dbo].[ContactComs] WITH (NOLOCK)
						Where [ContactComs_ContactID]=@OldContactID and 
						[ContactComs_ComType]='Tel'
						
						SELECT @OldPriEma1=ISNULL([ContactComs_ComDetails], '')
						FROM [dbo].[ContactComs] WITH (NOLOCK)
						Where [ContactComs_ContactID]=@OldContactID and 
						[ContactComs_ComType]='PriEma' 

		Declare @UpdateContact int
		Declare @UpdateContactAddress int
		Declare @UpdateContactComs int


		SET @UpdateContact =0
		SET @UpdateContactAddress=0
		set @UpdateContactComs=0

					IF ISNULL(@OldContact_ContactType, '') <> ISNULL(@pContact_ContactType, '') 
					begin
						set @UpdateContact =1
						-- Print '@OldContact_ContactType is changed from ' + ISNULL(@OldContact_ContactType, '') + ' to ' + ISNULL(@pContact_ContactType, '')
					end
					IF ISNULL(@OldContact_Title, '') <> ISNULL(@pContact_Title, '') 
					begin
						set @UpdateContact =1
						-- Print '@OldContact_Title is changed from ' + ISNULL(@OldContact_Title, '') + ' to ' + ISNULL(@pContact_Title,'')
					end
					IF ISNULL(@OldContact_Forename, '') <> ISNULL( @pContact_Forename, '') 
					begin
						set @UpdateContact =1
						-- Print '@OldContact_Forename is changed from ' + ISNULL(@OldContact_Forename, '') + ' to ' + ISNULL(@pContact_Forename,'')
					end
					IF ISNULL(@OldContact_Surname , '') <> ISNULL( @pContact_Surname, '') 
					begin
						set @UpdateContact =1
						-- Print '@OldContact_Surname is changed from ' + ISNULL(@OldContact_Surname, '') + ' to ' + ISNULL(@pContact_Surname,'')
					end
					IF ISNULL(@OldContact_Corporate , '') <> ISNULL( @pContact_Corporate, '') 
					begin
						set @UpdateContact =1
						-- Print '@OldContact_Corporate is changed from ' + ISNULL(@OldContact_Corporate, '') + ' to ' + ISNULL(@pContact_Corporate,'')
					end
					IF ISNULL(@OldContact_CompanyName , '') <> ISNULL( @pContact_CompanyName, '') 
					begin
						set @UpdateContact =1
						-- Print '@OldContact_CompanyName is changed from ' + ISNULL(@OldContact_CompanyName, '') + ' to ' + ISNULL(@pContact_CompanyName,'')
					end
					IF ISNULL(@OldContact_Position , '') <> ISNULL( @pContact_Position, '') 
					begin
						set @UpdateContact =1
						-- Print '@OldContact_Position is changed from ' + ISNULL(@OldContact_Position, '') + ' to ' + ISNULL(@pContact_Position,'')
					end
					IF ISNULL(@OldContact_GENDerCode , '') <> ISNULL( @pContact_GenderCode, '') 
					begin
						set @UpdateContact =1
						-- Print '@OldContact_GENDerCode is changed from ' + ISNULL(@OldContact_GENDerCode, '') + ' to ' + ISNULL(@pContact_GenderCode,'')
					end
					IF ISNULL(@OldContact_DOB , '') <> ISNULL( @pContact_DOB, '')
					begin
						set @UpdateContact =1
						-- Print '@OldContact_DOB is changed from ' + ISNULL(@OldContact_DOB, '') + ' to ' + ISNULL(@pContact_DOB,'')
					end
					IF ISNULL(@OldContactAddress_RegionCode , '') <> ISNULL( @pContact_RegionCode, '')
					begin
						set @UpdateContact =1
						-- Print '@OldContactAddress_RegionCode is changed from ' + ISNULL(@OldContactAddress_RegionCode, '') + ' to ' + ISNULL(@pContact_RegionCode,'')
					end
					IF ISNULL(@OldContactAddress_BlockBook , '') <> ISNULL( @pContact_Blockbook, '') 
					begin
						set @UpdateContact =1
						-- Print '@OldContactAddress_BlockBook is changed from ' + ISNULL(@OldContactAddress_BlockBook, '') + ' to ' + ISNULL(@pContact_Blockbook,'')
					end
					IF ISNULL(@OldContactAddress_Expertis , '') <> ISNULL( @pContact_FieldOfExpertise, '') 
					begin
						set @UpdateContact =1
						-- Print '@OldContactAddress_Expertis is changed from ' + ISNULL(@OldContactAddress_Expertis, '') + ' to ' + ISNULL(@pContact_FieldOfExpertise,'')
					end
					IF ISNULL(  @OldContactAddress_AddressType, '') <> ISNULL(@pContactAddress_AddressType, '') 
					begin
						set @UpdateContactAddress =1
						-- Print '@OldContactAddress_AddressType is changed from ' + ISNULL(@OldContactAddress_AddressType, '') + ' to ' + ISNULL(@pContactAddress_AddressType,'')
					end
					IF ISNULL(  @OldContactAddress_Address1, '') <> ISNULL(@pContactAddress_Address1, '')
					begin
						set @UpdateContactAddress =1
						-- Print '@OldContactAddress_Address1 is changed from ' + ISNULL(@OldContactAddress_Address1, '') + ' to ' + ISNULL(@pContactAddress_Address1,'')
					end 
					IF ISNULL(  @OldContactAddress_Address2 , '') <> ISNULL(@pContactAddress_Address2, '') 
					begin
						set @UpdateContactAddress =1
						-- Print '@OldContactAddress_Address2 is changed from ' + ISNULL(@OldContactAddress_Address2, '') + ' to ' + ISNULL(@pContactAddress_Address2,'')
					end 
					IF ISNULL(  @OldContactAddress_Address3 , '') <> ISNULL(@pContactAddress_Address3, '') 
					begin
						set @UpdateContactAddress =1
						-- Print '@OldContactAddress_Address3 is changed from ' + ISNULL(@OldContactAddress_Address3, '') + ' to ' + ISNULL(@pContactAddress_Address3,'')
					end 
					IF ISNULL(  @OldContactAddress_Address4 , '') <> ISNULL(@pContactAddress_Address4, '') 
					begin
						set @UpdateContactAddress =1
						-- Print '@OldContactAddress_Address4 is changed from ' + ISNULL(@OldContactAddress_Address4, '') + ' to ' + ISNULL(@pContactAddress_Address4,'')
					end  
					IF ISNULL(  @OldContactAddress_Town, '') <> ISNULL(@pContactAddress_Town, '') 
					begin
						set @UpdateContactAddress =1
						-- Print '@OldContactAddress_Town is changed from ' + ISNULL(@OldContactAddress_Town, '') + ' to ' + ISNULL(@pContactAddress_Town,'')
					end 
					IF ISNULL(  @OldContactAddress_County, '') <> ISNULL(@pContactAddress_County, '') 
					begin
						set @UpdateContactAddress =1
						-- Print '@OldContactAddress_County is changed from ' + ISNULL(@OldContactAddress_County, '') + ' to ' + ISNULL(@pContactAddress_County,'')
					end 
					IF ISNULL(  @OldContactAddress_Postcode, '') <> ISNULL(@pContactAddress_Postcode, '') 
					begin
						set @UpdateContactAddress =1
						-- Print '@OldContactAddress_Postcode is changed from ' + ISNULL(@OldContactAddress_Postcode, '') + ' to ' + ISNULL(@pContactAddress_Postcode,'')
					end  
					IF ISNULL(  @OldContactAddress_Country , '') <> ISNULL(@pContactAddress_Country, '') 
					begin
						set @UpdateContactAddress =1
						-- Print '@OldContactAddress_Country is changed from ' + ISNULL(@OldContactAddress_Country, '') + ' to ' + ISNULL(@pContactAddress_Country,'')
					end   
					IF ISNULL(  @OldContactAddress_DXNumber , '') <> ISNULL(@pContactAddress_DXNumber, '') 
					begin
						set @UpdateContactAddress =1
						-- Print '@OldContactAddress_DXNumber is changed from ' + ISNULL(@OldContactAddress_DXNumber, '') + ' to ' + ISNULL(@pContactAddress_DXNumber,'')
					end   
					IF ISNULL(  @OldContactAddress_DXExchange, '') <> ISNULL(@pContactAddress_DXExchange, '')
					begin
						set @UpdateContactAddress =1
						-- Print '@OldContactAddress_DXExchange is changed from ' + ISNULL(@OldContactAddress_DXExchange, '') + ' to ' + ISNULL(@pContactAddress_DXExchange,'')
					end
		--
					IF ISNULL( @OldPriFax1, '') <> ISNULL(@PriFax, '') 
					begin
						set @UpdateContactComs =1
						-- Print '@OldPriFax1 is changed from ' + ISNULL(@OldPriFax1, '') + ' to ' + ISNULL(@PriFax,'')
					end
					IF ISNULL( @OldPriTel1, '') <> ISNULL(@PriTel, '')
					begin
						set @UpdateContactComs =1
						-- Print '@OldPriTel1 is changed from ' + ISNULL(@OldPriTel1, '') + ' to ' + ISNULL(@PriTel,'')
					end
					IF ISNULL( @OldSecTel1, '') <> ISNULL(@SecTel, '')
					begin
						set @UpdateContactComs =1
						-- Print '@OldSecTel1 is changed from ' + ISNULL(@OldSecTel1, '') + ' to ' + ISNULL(@SecTel,'')
					end
					IF ISNULL( @OldPriEma1 , '') <> ISNULL(@PriEma, '')
					begin
						set @UpdateContactComs =1
						-- Print '@OldPriEma1 is changed from ' + ISNULL(@OldPriEma1, '') + ' to ' + ISNULL(@PriEma,'')
					end
					
				--update old record as inactive to archive it	
				IF (@UpdateContact=1) or (@UpdateContactAddress=1) or  (@UpdateContactComs=1)
				Begin
				-- Print 'UPDATING RECORDS GQL'	 
				UPDATE dbo.Contact SET Contact_Inactive = 1 WHERE Contact_ContactID = @OLDCONTACTID
				
				--insert new details as a new record
				INSERT INTO dbo.Contact(
					Contact_ContactType,
					Contact_Title,
					Contact_Forename,
					Contact_Surname,
					Contact_Corporate,
					Contact_CompanyName,
					Contact_Position,
					Contact_GenderCode,
					Contact_DOB,
					Contact_RegionCode,
					Contact_Blockbook,						
					Contact_FieldOfExpertise,
					Contact_Inactive,
					CreateUser,
					CreateDate,
					RefContactType_RefContactTypeID,
					ReferenceDB_SourceID)
				VALUES(
					@pContact_ContactType,
					@pContact_Title,
					@pContact_Forename,
					@pContact_Surname,
					@pContact_Corporate,
					@pContact_CompanyName,
					@pContact_Position,
					@pContact_GenderCode,
					@pContact_DOB,
					@pContact_RegionCode,
					@pContact_Blockbook,
					@pContact_FieldOfExpertise,
					@pContact_Inactive,
					@UserName,
					@PCREATEDATE,
					@RefContactType_RefContactTypeID,
					@ReferenceDB_SourceID)
				
				--Get the new ID of the contact record added
				SET @pContact_ContactID = SCOPE_IDENTITY()
				--
				--*************************************************************

					
				--*******************************************************************
				--3 variables added to identify the old records that needs 
				Declare @OldContactAddress_ContactAddressID int 
				Declare @OldCaseContacts_CaseContactsID int
				
				--Declare @OldContactComs_ContactComsIDPriFax int 
				Declare @OldIDPriFax int 
				Declare @OldContactComs_ContactComsIDPriTel int 
				Declare @OldContactComs_ContactComsIDSecTel int 
				Declare @OldContactComs_ContactComsIDPriEma int 
				set @OldIDPriFax=0
				set @OldContactComs_ContactComsIDPriTel=0
				set @OldContactComs_ContactComsIDPriEma=0
					
				
				--if there are contact addresses attached to the old contact record
				IF EXISTS (SELECT ContactAddress_ContactAddressID FROM dbo.ContactAddress WITH (NOLOCK) WHERE ContactAddress_ContactID = @OLDCONTACTID)
				BEGIN
					--point them at the new contact record
					-- Print 'UPDATE ContactAddress SET ContactAddress_ContactID'
					UPDATE ContactAddress SET ContactAddress_ContactID = @pContact_ContactID WHERE ContactAddress_ContactID = @OLDCONTACTID 
					
					if(@UpdateContactAddress=1) 
					Begin
					--SELECT @OldContactAddress_ContactAddressID=ContactAddress_ContactAddressID FROM ContactAddress WHERE ContactAddress_ContactID = @OLDCONTACTID
					--2009-Dec-24 SZS 
					--Get the updated record
					SELECT @OldContactAddress_ContactAddressID=ContactAddress_ContactAddressID FROM dbo.ContactAddress WITH (NOLOCK) WHERE ContactAddress_ContactID = @pContact_ContactID
					and contactAddress_inactive=0
								
					-- Print 'ContactAddress id to update is '+convert (varchar(7),@OldContactAddress_ContactAddressID)
					
					EXECUTE LTMM_ReferenceContactAddress_Save_SZS
					@OldContactAddress_ContactAddressID 
					 --@pContactAddress_ContactAddressID OUTPUT
					,@pContact_ContactID
					,@pContactAddress_AddressType
					,@pContactAddress_Address1
					,@pContactAddress_Address2
					,@pContactAddress_Address3
					,@pContactAddress_Address4
					,@pContactAddress_Town
					,@pContactAddress_County
					,@pContactAddress_Postcode
					,@pContactAddress_Country
					,@pContactAddress_DXNumber
					,@pContactAddress_DXExchange
					,@pContactAddress_AddressOrder
					 ,0
					,@UserName
					end --if(@UpdateContact=1) or (@UpdateContactAddress=1)
					--Need to either issue update statement with the new values for ContactAddress to keep same record or 
					--make a call to LTMM_ReferenceContactAddress_Save_SZS  passing the of ContactAddress_contactAddressID to create new record
				END
				--if there are matters attached to the old contact record
				IF EXISTS (SELECT CaseContacts_CaseContactsID FROM dbo.CaseContacts WITH (NOLOCK) WHERE CaseContacts_ContactID = @OLDCONTACTID)
				BEGIN
					--point them at the new record
					-- Print 'UPDATE CaseContacts SET CaseContacts_ContactID '
					UPDATE dbo.CaseContacts SET CaseContacts_ContactID = @pContact_ContactID WHERE CaseContacts_ContactID = @OLDCONTACTID 

				END
				--if there are comms attached to the old contact record
				IF EXISTS (SELECT ContactComs_ContactComsID FROM dbo.ContactComs WITH (NOLOCK) WHERE ContactComs_ContactID = @OLDCONTACTID)
				BEGIN
					--point coms records at the new contact record
					UPDATE dbo.ContactComs SET ContactComs_ContactID = @pContact_ContactID WHERE ContactComs_ContactID = @OLDCONTACTID 
				END
					
				IF @UpdateContactComs=1 
				--if either of  contact or Conatctcoms or both amended create new create new record
				Begin
					
					SELECT @OldIDPriFax=ContactComs_ContactComsID FROM dbo.ContactComs WITH (NOLOCK) WHERE ContactComs_ContactID = @pContact_ContactID
							and ContactComs_ComType='PriFax' and ContactComs_InActive=0
					-- Print 'Why not '+convert(varchar(7), @OldIDPriFax)
					-- Print '@OldContactComs_ContactComsIDPriFax updated is '+convert(varchar(7),@OldContactComs_ContactComsIDPriFax)
					IF ISNULL(@PriFax,'')<>''
					BEGIN
						EXECUTE LTMM_ReferenceContactComs_Save_SZS
						@pContactComs_ContactComsID =@OldIDPriFax
						,@pContactComs_ContactID = @pContact_ContactID
						,@pContactComs_ComType = 'PriFax'
						,@pContactComs_ComDetails = @PriFax 
						,@pContactComs_InActive = 0
						,@pCreateUser = @UserName
						--,@pCreateUser = 'ADMIN'
				  
					END	

					-------------------
					SELECT @OldContactComs_ContactComsIDPriTel=ContactComs_ContactComsID FROM dbo.ContactComs WITH (NOLOCK) WHERE ContactComs_ContactID = @pContact_ContactID
							and ContactComs_ComType='PriTel' and ContactComs_InActive=0
					-- Print '@OldContactComs_ContactComsIDPriTel updated is '+convert(varchar(7),@OldContactComs_ContactComsIDPriTel)
					
					IF ISNULL(@PriTel,'')<>''
					BEGIN
						EXECUTE LTMM_ReferenceContactComs_Save_SZS
						@pContactComs_ContactComsID =@OldContactComs_ContactComsIDPriTel
						,@pContactComs_ContactID = @pContact_ContactID
						,@pContactComs_ComType = 'PriTel'
						,@pContactComs_ComDetails = @PriTel 
						,@pContactComs_InActive = 0
						,@pCreateUser = @UserName
						--,@pCreateUser = 'ADMIN'
				 
					END	

					-------------------
					SELECT @OldContactComs_ContactComsIDSecTel =ContactComs_ContactComsID FROM dbo.ContactComs WITH (NOLOCK) WHERE ContactComs_ContactID = @pContact_ContactID
							and ContactComs_ComType='Tel' and ContactComs_InActive=0
					-- Print '@OldContactComs_ContactComsIDPriTel updated is '+convert(varchar(7),@OldContactComs_ContactComsIDPriTel)
					
					IF ISNULL(@SecTel,'')<>''
					BEGIN
						EXECUTE LTMM_ReferenceContactComs_Save_SZS
						@pContactComs_ContactComsID =@OldContactComs_ContactComsIDSecTel --SMJ - 20/08/2012
						,@pContactComs_ContactID = @pContact_ContactID
						,@pContactComs_ComType = 'Tel'
						,@pContactComs_ComDetails = @SecTel
						,@pContactComs_InActive = 0
						,@pCreateUser = @UserName
						--,@pCreateUser = 'ADMIN'	
						
						 
					END
			
					---------------
					SELECT @OldContactComs_ContactComsIDPriEma=ContactComs_ContactComsID FROM dbo.ContactComs WITH (NOLOCK) WHERE ContactComs_ContactID = @pContact_ContactID
							and ContactComs_ComType='PriEma' and ContactComs_InActive=0
					-- Print '@OldContactComs_ContactComsIDPriEma updated is '+convert(varchar(7),@OldContactComs_ContactComsIDPriEma)

					IF ISNULL(@PriEma,'')<>''
					BEGIN
						EXECUTE LTMM_ReferenceContactComs_Save_SZS
						 @pContactComs_ContactComsID = @OldContactComs_ContactComsIDPriEma
						 ,@pContactComs_ContactID = @pContact_ContactID
						,@pContactComs_ComType = 'PriEma'
						,@pContactComs_ComDetails = @PriEma 
						,@pContactComs_InActive = 0
						,@pCreateUser = @UserName
				  
					END	
				END
				End -- for the comparison code @old and @p 
			END
			
		END

		SELECT @pContact_ContactID as Contact_ContactID
	END TRY
	

	BEGIN CATCH		
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH
	


