USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[LTMM_NewCaseMatterCode_Fetch]    Script Date: 09/24/2012 16:57:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[LTMM_NewCaseMatterCode_Fetch]
(
	@NewMatterCode		VARCHAR(8) output,
	@UserName			nvarchar(255)  = '',			
	@MatterUno			int  = 0
)
AS

	--Stored Procedure return a lookup list based on a given lookup code 
	--Author(s) GQL
	--05-08-2009
	
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling
	-- ===============================================================		
	DECLARE @PREFIX VARCHAR(8)
	DECLARE @COUNTER INT
	DECLARE @errNoMatterUno VARCHAR(50)
	
	SET @errNoMatterUno = 'Please pass @MatterUno.'
	
	BEGIN TRY	
		IF (ISNULL(@MatterUno, 0) <> 0)
		BEGIN
		
			SET @NewMatterCode = RTRIM(CAST(@MatterUno AS VARCHAR(MAX)))
			
			SET @COUNTER = 0
			SET @PREFIX = ''
			
			while @COUNTER < (8 - LEN(@NewMatterCode))
			begin
			
				SET @PREFIX = @PREFIX + '0'
				SET @COUNTER = @COUNTER +1
			END
					
			SET @NewMatterCode = RTRIM(@PREFIX) + @NewMatterCode
			
		END
		ELSE
		BEGIN
			RAISERROR (@errNoMatterUno, 16, 1)
		END
	END TRY
	
	BEGIN CATCH		
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH


