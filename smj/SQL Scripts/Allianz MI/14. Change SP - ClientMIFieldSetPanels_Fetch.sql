/****** Object:  StoredProcedure [dbo].[ClientMIFieldSetPanels_Fetch]    Script Date: 05/08/2012 16:23:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




ALTER PROCEDURE [dbo].[ClientMIFieldSetPanels_Fetch] 
	@pCase_CaseID	int = 0,
	@pClientMIPanels_PageNo				int = 0,
	@pUser_Name		nvarchar(255) = '',
	@pGetCosts		BIT = 0,
	@pContactID		BIT = 0
AS
BEGIN
	-- =============================================
	-- Author:		GQL
	-- Create date: 23-02-2010
	-- Description:	Stored Procedure to return the set of MI panel required on a matter based on 
	-- the client attached to that matter, this includes any data currently held by those fields
	-- =============================================
	-- =============================================
	-- Author:		SMJ
	-- Modify date: 20-04-2012
	-- Description:	Changed SP to cater for Claimant MI
	-- =============================================	
	
	--Initialise error trapping
	SET NOCOUNT ON
	SET ARITHABORT ON
	DECLARE @myLastError int 
	SELECT @myLastError = 0
	DECLARE @myLastErrorString nvarchar(255)
	SELECT @myLastErrorString = '' 
	
	IF EXISTS(SELECT ClientMIDefinition_ClientMIDefinitionID FROM ClientMIDefinition WHERE ClientMIDefinition_CLIENTCODE = (SELECT Case_ClientCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID))
	BEGIN
		--DOES THE MATTER HAVE A COMBO CLIENT NUMBER AND WORKTYPE DATASET
		IF EXISTS(SELECT ClientMIDefinition_ClientMIDefinitionID FROM ClientMIDefinition WHERE ClientMIDefinition_WORKTYPECODE = (SELECT Case_WorkTypeCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID) AND ClientMIDefinition_CLIENTCODE = (SELECT Case_ClientCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID))
		BEGIN
			--uncomment for debug
			--print 'Client number and Worktype'
			--Return page panels FOR THE COMBO CLIENT NUMBER AND WORKTYPE DATASET
			SELECT [ClientMIPanels_ClientMIPanelsID]
				  ,[ClientMIPanels_ClientMIDefCode]
				  ,[ClientMIPanels_PanelNo]
				  ,[ClientMIPanels_PageNo]
				  ,[ClientMIPanels_Description]
				  ,[ClientMIPanels_Inactive]
				  ,[ClientMIPanels_CreateDate]
				  ,[ClientMIPanels_ClientUser]
			FROM [Case] c INNER JOIN
			ClientMIDefinition cm ON c.Case_ClientCode = cm.ClientMIDefinition_CLIENTCODE and c.Case_WorkTypeCode = cm.ClientMIDefinition_WORKTYPECODE and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
			[ClientMIPanels] p on cm.ClientMIDefinition_MIDEFCODE = p.ClientMIPanels_ClientMIDefCode and p.ClientMIPanels_Inactive = 0
			WHERE ((c.Case_CaseID = @pCase_CaseID))
			AND ((ISNULL(@pClientMIPanels_PageNo,0) = 0) OR (ClientMIPanels_PageNo = @pClientMIPanels_PageNo))
			ORDER BY ClientMIPanels_PageNo,ClientMIPanels_PanelNo
							
		END
		ELSE		
		BEGIN
			IF @pGetCosts = 1
			BEGIN
				--uncomment for debug
				--print 'costs Worktype only'
				--Return page panels FOR THE WORKTYPE DATASET
				SELECT [ClientMIPanels_ClientMIPanelsID]
					  ,[ClientMIPanels_ClientMIDefCode]
					  ,[ClientMIPanels_PanelNo]
					  ,[ClientMIPanels_PageNo]
					  ,[ClientMIPanels_Description]
					  ,[ClientMIPanels_Inactive]
					  ,[ClientMIPanels_CreateDate]
					  ,[ClientMIPanels_ClientUser]
				FROM [Case] c INNER JOIN
				ClientMIDefinition cm ON cm.ClientMIDefinition_WORKTYPECODE = 'COSTS' and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
				[ClientMIPanels] p on cm.ClientMIDefinition_MIDEFCODE = p.ClientMIPanels_ClientMIDefCode and p.ClientMIPanels_Inactive = 0
				WHERE ((c.Case_CaseID = @pCase_CaseID AND c.Case_CostsAssgn = 1))
				AND ((ISNULL(@pClientMIPanels_PageNo,0) = 0) OR (ClientMIPanels_PageNo = @pClientMIPanels_PageNo))
				ORDER BY ClientMIPanels_PageNo,ClientMIPanels_PanelNo			
			END
			ELSE
			BEGIN
				--uncomment for debug
				--print 'Client number only'
				--Return page panels FOR THE CLIENT NUMBER DATASET
				SELECT [ClientMIPanels_ClientMIPanelsID]
					  ,[ClientMIPanels_ClientMIDefCode]
					  ,[ClientMIPanels_PanelNo]
					  ,[ClientMIPanels_PageNo]
					  ,[ClientMIPanels_Description]
					  ,[ClientMIPanels_Inactive]
					  ,[ClientMIPanels_CreateDate]
					  ,[ClientMIPanels_ClientUser]
				FROM [Case] c INNER JOIN
				ClientMIDefinition cm ON c.Case_ClientCode = cm.ClientMIDefinition_CLIENTCODE and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
				[ClientMIPanels] p on cm.ClientMIDefinition_MIDEFCODE = p.ClientMIPanels_ClientMIDefCode and p.ClientMIPanels_Inactive = 0
				WHERE ((c.Case_CaseID = @pCase_CaseID))
				AND ((ISNULL(@pClientMIPanels_PageNo,0) = 0) OR (ClientMIPanels_PageNo = @pClientMIPanels_PageNo))
				ORDER BY ClientMIPanels_PageNo,ClientMIPanels_PanelNo	
			END
		END
	END
	ELSE	
	BEGIN
		--DOES THE MATTER HAVE A CLIENT GROUP DATASET
		IF EXISTS(SELECT * FROM ClientMIDefinition WHERE ClientMIDefinition_CLIENTGROUPCODE = (SELECT Case_GroupCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID))
		BEGIN
			--DOES THE MATTER HAVE A COMBO CLIENT GROUP AND WORKTYPE DATASET
			IF EXISTS(SELECT ClientMIDefinition_ClientMIDefinitionID FROM ClientMIDefinition WHERE ClientMIDefinition_WORKTYPECODE = (SELECT Case_WorkTypeCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID) AND ClientMIDefinition_CLIENTGROUPCODE = (SELECT Case_GroupCode FROM [CASE] WHERE Case_CaseID = @pCase_CaseID))
			BEGIN
				--uncomment for debug
				--print 'Group code and Worktype'
				--Return page panels FOR THE COMBO CLIENT GROUP AND WORKTYPE DATASET
				SELECT [ClientMIPanels_ClientMIPanelsID]
					  ,[ClientMIPanels_ClientMIDefCode]
					  ,[ClientMIPanels_PanelNo]
					  ,[ClientMIPanels_PageNo]
					  ,[ClientMIPanels_Description]
					  ,[ClientMIPanels_Inactive]
					  ,[ClientMIPanels_CreateDate]
					  ,[ClientMIPanels_ClientUser]
				FROM [Case] c INNER JOIN
				ClientMIDefinition cm ON c.Case_GroupCode = cm.ClientMIDefinition_CLIENTGROUPCODE and c.Case_WorkTypeCode = cm.ClientMIDefinition_WORKTYPECODE and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
				[ClientMIPanels] p on cm.ClientMIDefinition_MIDEFCODE = p.ClientMIPanels_ClientMIDefCode and p.ClientMIPanels_Inactive = 0
				WHERE ((c.Case_CaseID = @pCase_CaseID))
				AND ((ISNULL(@pClientMIPanels_PageNo,0) = 0) OR (ClientMIPanels_PageNo = @pClientMIPanels_PageNo))
				ORDER BY ClientMIPanels_PageNo,ClientMIPanels_PanelNo
			END
			ELSE		
			BEGIN
			IF @pGetCosts = 1
			BEGIN
				--uncomment for debug
				--Return page panels FOR THE WORKTYPE DATASET
				SELECT [ClientMIPanels_ClientMIPanelsID]
					  ,[ClientMIPanels_ClientMIDefCode]
					  ,[ClientMIPanels_PanelNo]
					  ,[ClientMIPanels_PageNo]
					  ,[ClientMIPanels_Description]
					  ,[ClientMIPanels_Inactive]
					  ,[ClientMIPanels_CreateDate]
					  ,[ClientMIPanels_ClientUser]
				FROM [Case] c INNER JOIN
				ClientMIDefinition cm ON cm.ClientMIDefinition_WORKTYPECODE = 'COSTS' and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
				[ClientMIPanels] p on cm.ClientMIDefinition_MIDEFCODE = p.ClientMIPanels_ClientMIDefCode and p.ClientMIPanels_Inactive = 0
				WHERE ((c.Case_CaseID = @pCase_CaseID AND c.Case_CostsAssgn = 1))
				AND ((ISNULL(@pClientMIPanels_PageNo,0) = 0) OR (ClientMIPanels_PageNo = @pClientMIPanels_PageNo))
				ORDER BY ClientMIPanels_PageNo,ClientMIPanels_PanelNo			
			END
			ELSE
			BEGIN
				--SMJ -20/04
				--CHECK FOR CLAIMANT MI
				IF @pContactID > 0
				BEGIN
					SELECT [ClientMIPanels_ClientMIPanelsID]
						  ,[ClientMIPanels_ClientMIDefCode]
						  ,[ClientMIPanels_PanelNo]
						  ,[ClientMIPanels_PageNo]
						  ,[ClientMIPanels_Description]
						  ,[ClientMIPanels_Inactive]
						  ,[ClientMIPanels_CreateDate]
						  ,[ClientMIPanels_ClientUser]
						  ,cm2.ClientMIDefinition_WORKTYPECODE 
					FROM [Case] c inner JOIN
					ClientMIDefinition cm ON c.Case_GroupCode = cm.ClientMIDefinition_MIDEFCODE 
					and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
					ClientMIDefinition cm2 ON cm.ClientMIDefinition_CLIENTGROUPCODE = cm2.ClientMIDefinition_CLIENTGROUPCODE
					AND cm2.ClientMIDefinition_IsClaimant =1 INNER JOIN
					[ClientMIPanels] p on cm2.ClientMIDefinition_MIDEFCODE = p.ClientMIPanels_ClientMIDefCode  and p.ClientMIPanels_Inactive = 0
					WHERE ((c.Case_CaseID = @pCase_CaseID))
					and ((ISNULL(1,0) = 0) OR (ClientMIPanels_PageNo = 1))
					ORDER BY ClientMIPanels_PageNo,ClientMIPanels_PanelNo				
				END
				ELSE
				BEGIN
				--uncomment for debug
				--print 'Group Code only'
				--Return page panels FOR THE CLIENT GROUP DATASET
					SELECT [ClientMIPanels_ClientMIPanelsID]
						  ,[ClientMIPanels_ClientMIDefCode]
						  ,[ClientMIPanels_PanelNo]
						  ,[ClientMIPanels_PageNo]
						  ,[ClientMIPanels_Description]
						  ,[ClientMIPanels_Inactive]
						  ,[ClientMIPanels_CreateDate]
						  ,[ClientMIPanels_ClientUser]
					FROM [Case] c INNER JOIN
					ClientMIDefinition cm ON c.Case_GroupCode = cm.ClientMIDefinition_MIDEFCODE and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
					[ClientMIPanels] p on cm.ClientMIDefinition_MIDEFCODE = p.ClientMIPanels_ClientMIDefCode and p.ClientMIPanels_Inactive = 0
					WHERE ((c.Case_CaseID = @pCase_CaseID))
					AND ((ISNULL(@pClientMIPanels_PageNo,0) = 0) OR (ClientMIPanels_PageNo = @pClientMIPanels_PageNo))
					ORDER BY ClientMIPanels_PageNo,ClientMIPanels_PanelNo				
				END
			END
			END
		END
		ELSE
		BEGIN
			IF @pGetCosts = 1
			BEGIN
				--uncomment for debug
				--print 'costs Worktype only'
				--Return page panels FOR THE WORKTYPE DATASET
				SELECT [ClientMIPanels_ClientMIPanelsID]
					  ,[ClientMIPanels_ClientMIDefCode]
					  ,[ClientMIPanels_PanelNo]
					  ,[ClientMIPanels_PageNo]
					  ,[ClientMIPanels_Description]
					  ,[ClientMIPanels_Inactive]
					  ,[ClientMIPanels_CreateDate]
					  ,[ClientMIPanels_ClientUser]
				FROM [Case] c INNER JOIN
				ClientMIDefinition cm ON cm.ClientMIDefinition_WORKTYPECODE = 'COSTS' and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
				[ClientMIPanels] p on cm.ClientMIDefinition_MIDEFCODE = p.ClientMIPanels_ClientMIDefCode and p.ClientMIPanels_Inactive = 0
				WHERE ((c.Case_CaseID = @pCase_CaseID AND c.Case_CostsAssgn = 1))
				AND ((ISNULL(@pClientMIPanels_PageNo,0) = 0) OR (ClientMIPanels_PageNo = @pClientMIPanels_PageNo))
				ORDER BY ClientMIPanels_PageNo,ClientMIPanels_PanelNo			
			END
			ELSE
			BEGIN
				--SMJ -20/04
				--CHECK FOR CLAIMANT MI
				IF @pContactID > 0
				BEGIN
					SELECT [ClientMIPanels_ClientMIPanelsID]
						  ,[ClientMIPanels_ClientMIDefCode]
						  ,[ClientMIPanels_PanelNo]
						  ,[ClientMIPanels_PageNo]
						  ,[ClientMIPanels_Description]
						  ,[ClientMIPanels_Inactive]
						  ,[ClientMIPanels_CreateDate]
						  ,[ClientMIPanels_ClientUser]
						  ,cm2.ClientMIDefinition_WORKTYPECODE 
					FROM [Case] c inner JOIN
					ClientMIDefinition cm ON c.Case_GroupCode = cm.ClientMIDefinition_MIDEFCODE 
					and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
					ClientMIDefinition cm2 ON cm.ClientMIDefinition_CLIENTGROUPCODE = cm2.ClientMIDefinition_CLIENTGROUPCODE
					AND cm2.ClientMIDefinition_IsClaimant =1 INNER JOIN
					[ClientMIPanels] p on cm2.ClientMIDefinition_MIDEFCODE = p.ClientMIPanels_ClientMIDefCode  and p.ClientMIPanels_Inactive = 0
					WHERE ((c.Case_CaseID = 1987))
					and ((ISNULL(1,0) = 0) OR (ClientMIPanels_PageNo = 1))
					and cm.ClientMIDefinition_IsClaimant is null
					ORDER BY ClientMIPanels_PageNo,ClientMIPanels_PanelNo				
				END
				ELSE
				BEGIN
				--uncomment for debug
				--print 'Group Code only'
				--Return page panels FOR THE CLIENT GROUP DATASET
					SELECT [ClientMIPanels_ClientMIPanelsID]
						  ,[ClientMIPanels_ClientMIDefCode]
						  ,[ClientMIPanels_PanelNo]
						  ,[ClientMIPanels_PageNo]
						  ,[ClientMIPanels_Description]
						  ,[ClientMIPanels_Inactive]
						  ,[ClientMIPanels_CreateDate]
						  ,[ClientMIPanels_ClientUser]
					FROM [Case] c INNER JOIN
					ClientMIDefinition cm ON c.Case_GroupCode = cm.ClientMIDefinition_MIDEFCODE and cm.ClientMIDefinition_Inactive = 0 INNER JOIN
					[ClientMIPanels] p on cm.ClientMIDefinition_MIDEFCODE = p.ClientMIPanels_ClientMIDefCode and p.ClientMIPanels_Inactive = 0
					WHERE ((c.Case_CaseID = @pCase_CaseID))
					AND ((ISNULL(@pClientMIPanels_PageNo,0) = 0) OR (ClientMIPanels_PageNo = @pClientMIPanels_PageNo))
					ORDER BY ClientMIPanels_PageNo,ClientMIPanels_PanelNo				
				END
			END
		END
	END
	
	--Test for errors
	SELECT @myLastError = @@ERROR
	IF @myLastError <> 0 GOTO THROW_ERROR_UPWARDS
		
	THROW_ERROR_UPWARDS:
	IF (@myLastError <> 0 ) OR (@myLastErrorString <> '')
	BEGIN
		SET @myLastErrorString = 'Error Occurred In Stored Procedure ClientMIFieldSetPanels_Fetch - ' + @myLastErrorString
		RAISERROR (@myLastErrorString, 16,1)
	END
END




