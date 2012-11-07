USE [FloSuite_Data_Dev]
GO

/****** Object:  StoredProcedure [dbo].[LTMM_Disclosure_Fetch]    Script Date: 08/25/2011 11:21:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



--[LTMM_Disclosure_Fetch] 'DISCD',0
CREATE PROCEDURE [dbo].[LTMM_Disclosure_Fetch] (	@pDisclosure_DisclosureCode  VARCHAR(255),
											@pDisclosure_CaseID INT = 0
										)


	--==============================================================--
	-- Created By:	SMJ
	-- Create Date:	22-08-2011
	-- Description:	This SP is used to fetch the Disclosure table
	--				An XML string is passed in + ','whihc contains a list of checboxes
	--				and their respective values 
	--==============================================================--
								

AS										
	DECLARE @errNothingPassed VARCHAR(255)
	DECLARE @MaxID INT
	DECLARE @MinID INT
	DECLARE @StrSQL NVARCHAR(MAX)
	DECLARE @ColName VARCHAR(255)
	DECLARE @StrOut NVARCHAR(MAX)
	DECLARE @Parameter_Definition NVARCHAR(max)
	Declare @currout nvarchar(255)
	Declare @currval nvarchar(255)
	DECLARE @retval int    
	DECLARE @sSQL nvarchar(500)
	DECLARE @ParmDefinition nvarchar(500) 


	
	SET NOCOUNT ON 	
	
	SET @errNothingPassed = 'No Case ID or Diclose Code have been passsed in. No Disclosure records will be returned. SP: '
	
	BEGIN TRY
	
		IF @pDisclosure_CaseID = 0 AND @pDisclosure_DisclosureCode = ''
			RAISERROR (@errNothingPassed,16,1)
			
		--Populate Temp Table
		SELECT  Disclosure_DisclosureID, Disclosure_DisclosureCode, Disclosure_CaseID, Disclosure_DiscDealtWith, Disclosure_FurDocsReq, Disclosure_ReqDocsFrom, Disclosure_ExtDam, Disclosure_MOT, Disclosure_MaintRep, Disclosure_Tacho, Disclosure_ComMaintRep, Disclosure_LocalAuth, Disclosure_AccidBook, Disclosure_FirstAid, Disclosure_SurgeryRec, Disclosure_SuperAccidRep, Disclosure_SafeRepAccidRep, Disclosure_Riddorrep, Disclosure_OtherComms, Disclosure_MinsHlthSafe, Disclosure_DSSRep, Disclosure_SimilAccidDocs, Disclosure_EarningInfo, Disclosure_PreAccidRisk, Disclosure_PostAccidRisk, Disclosure_AccidInvestRecs, Disclosure_HealthSurvRep, Disclosure_InfoToEmps, Disclosure_HandSTrainDocs, Disclosure_WorkPlaceReg, Disclosure_WorkEquipReg, Disclosure_ProtectEquipReg, Disclosure_ManHandReg, Disclosure_DispScreenReg, Disclosure_COSHHReg, Disclosure_PressGasReg, Disclosure_LiftingReg, Disclosure_NoiseReg, Disclosure_ConstructGenReg, Disclosure_WPRepMaintRecs, Disclosure_WPHouseKeepRecs, Disclosure_WPHazardSign, Disclosure_WEManSpec, Disclosure_WEMaintLog, Disclosure_WEInfoToEmps, Disclosure_WETrainDocs, Disclosure_WENoticeSign, Disclosure_WEInstructDocs, Disclosure_WECopyMark, Disclosure_WECopyWarn, Disclosure_PEAssessDocs, Disclosure_PEMaintRepDocs, Disclosure_PEMaintProcDocs, Disclosure_PETestDocs, Disclosure_PEInfoToEmps, Disclosure_PEInstructDocs, Disclosure_MHPreAccidRisk, Disclosure_MHPostAccidRisk, Disclosure_MHInfoToEmps, Disclosure_MHTrainDocs, Disclosure_DSPreAccidRisk, Disclosure_DSPostAccidRisk, Disclosure_DSTrainDocs, Disclosure_DSInfoToEmps, Disclosure_PGSpecMarking, Disclosure_PGWrittenStatmnt, Disclosure_PGCopyWrittenStatmnt, Disclosure_PGExamRecs, Disclosure_PGInstructUse, Disclosure_PGRecsA, Disclosure_PGRecsB, Disclosure_CHAirMonitorRecs, Disclosure_CHMonitorRecs, Disclosure_CHHlthSurvRecs, Disclosure_CHPreAccidRisk, Disclosure_CHPostAccidRisk, Disclosure_CHCopyLabel, Disclosure_CHWarnSign, Disclosure_CHLabelData, Disclosure_CHMaintExamRecs, Disclosure_CHTrainDocs, Disclosure_CHAssessDocs, Disclosure_CHInstructUse, Disclosure_CHMaintRepDocs, Disclosure_CHMaintProcDocs, Disclosure_CHTestRecs, Disclosure_CHInfoToEmps, Disclosure_NRiskAssess, Disclosure_NManufactLit, Disclosure_NInfoToEmps, Disclosure_CGRepExcavn, Disclosure_CGRepCoffer, Disclosure_DMProjectForm, Disclosure_DMPlan, Disclosure_DMFile, Disclosure_DMTrainDocs, Disclosure_DMAdviceRecs, Disclosure_HPPreAccidRisk, Disclosure_HPPostAccidRisk, Disclosure_InspectionRecs, Disclosure_MaintRecs, Disclosure_PolicyMins, Disclosure_ComplaintRecs, Disclosure_OtherAccidRecs, Disclosure_InActive, Disclosure_CreateUser, Disclosure_CreateDate
		INTO #TEMP1
		FROM	Disclosure 
		WHERE  Disclosure_DisclosureCode  = CASE WHEN @pDisclosure_DisclosureCode = '' THEN Disclosure_DisclosureCode ELSE @pDisclosure_DisclosureCode END

		SELECT @MinID = 1

		--GET MAX NO. COLUMNS
		SELECT @MaxID = COUNT(*) FROM  syscolumns
		WHERE id = (SELECT id 
		FROM sysobjects
		WHERE type = 'U'
		AND [NAME] = 'Disclosure')
		SELECT @currval = ''
	
	WHILE @MinID <= (@MaxID)
	BEGIN
		SELECT @ColName = [name]  FROM syscolumns
		WHERE id = (SELECT id 
		FROM sysobjects
		WHERE type = 'U'
		AND [NAME] = 'Disclosure'
		AND colid = @MinID) 
		
		SET  @StrSQL =N'SELECT ' +   @ColName + ' from #TEMP1'
		
		DECLARE @MyTable TABLE (ID int identity (1,1 ), Myval varchar(255))
		INSERT INTO @MyTable
		EXECUTE sp_executesql @StrSQL
		
		SELECT @currval = @currval + ',' + Myval from @MyTable Where [ID] = @MinID
		
		
		SELECT @MinID = @MinID + 1
	END
		SELECT @currval = STUFF(@currval,1,1,'')
		SELECT @currval as DisclosureFetch
	END TRY
	
	BEGIN CATCH
		SELECT ERROR_MESSAGE() + OBJECT_NAME (@@PROCID)
	END CATCH


GO


