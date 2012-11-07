USE [Flosuite_Data_Dev]
GO
/****** Object:  StoredProcedure [dbo].[LTMM_NewCaseMatterNo_Fetch]    Script Date: 09/24/2012 17:01:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[LTMM_NewCaseMatterNo_Fetch]
(
	@NewMatterNo		int output,
	@UserName			nvarchar(255)  = '',			
	@ClientUno			int  = 0
)
AS

	--Stored Procedure return a lookup list based on a given lookup code 
	--Author(s) GQL
	--05-08-2009
	
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 24-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================	
	
	DECLARE @errNoMatterUno VARCHAR(50)
	
	SET @errNoMatterUno = 'Please pass @ClientUno.'
	
	BEGIN TRY			
		IF (ISNULL(@ClientUno, 0) <> 0)
		BEGIN
			SET @NewMatterNo = (SELECT max(Case_MatterUno) from dbo.[Case] WITH (NOLOCK) where Case_ClientUno = @ClientUno)		
			IF ISNULL(@NewMatterNo, 0) = 0
			BEGIN
				SET @NewMatterNo = 1
			END
			ELSE
			BEGIN
				SET @NewMatterNo = @NewMatterNo + 1	
			END
		END
		ELSE
		BEGIN
			RAISERROR (@errNoMatterUno,16,1)
		END
	END TRY
	
	BEGIN CATCH		
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH		
