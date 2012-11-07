USE [Flosuite_Core_Live]
GO
/****** Object:  StoredProcedure [dbo].[flospiPropertyInEntity]    Script Date: 10/22/2012 14:06:42 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Last modified date: <11/Jul/2012 14:53:02>
-- Last modified file: <7.2.960.002.core.flospipropertyinentity>
-- Last modified file run by: <rpm>
-- Description: insert a property into an entity
-- =============================================
ALTER PROCEDURE [dbo].[flospiPropertyInEntity]	
(
	@PropertyID			int=NULL OUTPUT,
	@EntityID			int,
	@PropertyTypeName	nvarchar(256)=NULL,
	@PropertyTypeID		int=NULL,
	@Value				ntext='',
	@Ordinal			int=0,
	@IsVisible			bit=0,
	@Flags				int=0,
	@Label				nvarchar(256)='',
	@Tag				nvarchar(256)=''
)
																	
AS
	SET NOCOUNT ON
	
	SET @PropertyID = NULL

	DECLARE @myLastError int 
	SET @myLastError = 0 
	
	EXEC flospmGetPropertyTypeInfo @PropertyTypeName=@PropertyTypeName OUTPUT, @PropertyTypeID=@PropertyTypeID OUTPUT
	SELECT @myLastError = @@ERROR
	IF @myLastError <> 0 GOTO THROW_ERROR_UPWARDS

	/* Validate whether or not the record exists */
	IF NOT EXISTS(
		SELECT 1
		FROM Entity	INNER JOIN [PropertyInEntity]  
			ON [PropertyInEntity].[EntityID] = [Entity].[EntityID] INNER JOIN [Property]
			ON [Property].[PropertyID] = [PropertyInEntity].[PropertyID] INNER JOIN [PropertyType]
			ON [Property].[PropertyTypeID] = [PropertyType].[PropertyTypeID]
		WHERE [PropertyInEntity].[EntityID] = @EntityID
		  AND [PropertyType].[Name] = @PropertyTypeName)
	BEGIN
		EXEC flospiProperty @PropertyID=@PropertyID OUTPUT, @PropertyTypeName=@PropertyTypeName, @PropertyTypeID=@PropertyTypeID OUTPUT, @Value=@Value, @Ordinal=@Ordinal, @IsVisible=@IsVisible, @Flags=@Flags, @Label=@Label, @Tag=@Tag

		INSERT INTO PropertyInEntity	(PropertyID,  EntityID)
		VALUES (@PropertyID,  @EntityID)
		SELECT @myLastError = @@ERROR
	END


THROW_ERROR_UPWARDS:
IF @myLastError <> 0    
      BEGIN
        	DECLARE @myLastErrorMessage NVARCHAR(MAX)
			SET @myLastErrorMessage = (SELECT @EntityID as EntityID,
					 @PropertyTypeName as PropertyTypeName,
					 @PropertyTypeID as PropertyTypeID,
					 @IsVisible as IsVisible,
					 @Ordinal as Ordinal,
					 @Flags as Flags,
					 @Label as Label,
					 @Tag as Tag
        	FOR XML PATH ('Error'))       

        	RAISERROR (@myLastErrorMessage, 16,1)
      END

