ALTER PROCEDURE [dbo].[FloCase_UpdateWIP]
(
	@UserName		nvarchar(255)  = ''
)
AS
		
	-- ==========================================================================================
	-- Author:		GQL
	-- Create date: 05-10-2011
	-- Description:	Update the WIP from Expert to run as Job every 15 minutes
	-- ==========================================================================================

	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 28-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================				
	SET NOCOUNT ON 	
	
	BEGIN TRY 
		--Update WIP amount
		UPDATE dbo.[Case]
		SET Case_Time_WIP_Amount = cast(t.Time_WIP_Amount as money),
		Case_Date_Updated = GETDATE()
		FROM [Case] c WITH (NOLOCK) INNER JOIN 
		vewADRNTEXPMI_Time_WIP t WITH (NOLOCK) on c.Case_CaseID = t.CaseID
		where isnull(c.Case_Time_WIP_Amount, 0) <> isnull(cast(t.Time_WIP_Amount as money), 0)
		
		--Update WIP Hours
		UPDATE [Case]
		SET Case_Time_WIP_Hours = cast(t.Time_WIP_Hours as decimal(18,2)),
		Case_Date_Updated = GETDATE()
		FROM [Case] c WITH (NOLOCK) INNER JOIN 
		vewADRNTEXPMI_Time_WIP t WITH (NOLOCK) on c.Case_CaseID = t.CaseID
		where isnull(c.Case_Time_WIP_Hours, 0) <> isnull(cast(t.Time_WIP_Hours as decimal(18,2)), 0)
	END TRY
	
	BEGIN CATCH		
		SELECT ERROR_MESSAGE() + ' SP: ' + OBJECT_NAME (@@PROCID)
	END CATCH	
