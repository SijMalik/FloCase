USE [FloSuite_Data_Dev]
GO

/****** Object:  StoredProcedure [dbo].[LTMM_Disclosure_Save]    Script Date: 08/25/2011 11:23:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[LTMM_Disclosure_Save] (@pInput NVARCHAR(MAX))
AS	--==============================================================--
	-- Created By:	SMJ
	-- Create Date:	22-08-2011
	-- Description:	This SP is used to update the Disclosure table
	--				An XML string is passed in, whihc contains a list of checboxes
	--				and their respective values 
	--==============================================================--
--[LTMM_Disclosure_Save] ''
DECLARE @XmlConvert XML
DECLARE	@Disclosure_CaseID INT
DECLARE @Disclosure_Code VARCHAR(255)
DECLARE @Disclosure_User VARCHAR(255)
DECLARE @PosStart INT
DECLARE @PosEnd INT

DECLARE @errNoName VARCHAR(255)
DECLARE @errNoCaseID VARCHAR(255)
DECLARE @StrSQL NVARCHAR(MAX)
DECLARE @ValList NVARCHAR(MAX)

DECLARE @MinID INT
DECLARE @MaxID INT
DECLARE @ValVal NVARCHAR(MAX)

DECLARE @Disc_DiscID INT
DECLARE @Disc_Code VARCHAR(255)

	SET NOCOUNT ON
	
	BEGIN TRY
		--SET ERROR MESSAGES
		SET @errNoName = 'Must supply User Name. SP: '
		SET @errNoCaseID = 'Must supply a Case ID. SP: '
		
		--STRIP OUT HEADER
		--(BELOW IS JUST FOR TESTING. WE SHOULD HAVE XML STRING BEING PASSED IN.)
			SELECT @pInput='
			  <CASEID>500</CASEID>
			  <CODE>TEST</CODE>
			  <CONTROLS>
			  <CONTROL> 
				 <CONTROLNAME>Disclosure_DiscDealtWith</CONTROLNAME> 
				 <CONTROLVALUE>True</CONTROLVALUE> 
			  </CONTROL> 
			  <CONTROL> 
				 <CONTROLNAME>Disclosure_FurDocsReq</CONTROLNAME> 
				 <CONTROLVALUE>False</CONTROLVALUE>
			  </CONTROL>  
			  <CONTROL> 
				 <CONTROLNAME>Disclosure_ReqDocsFrom</CONTROLNAME> 
				 <CONTROLVALUE>True</CONTROLVALUE> 
			  </CONTROL>
			  <CONTROL> 
				 <CONTROLNAME>Disclosure_ExtDam</CONTROLNAME> 
				 <CONTROLVALUE>False</CONTROLVALUE> 
			  </CONTROL>
			  <CONTROL> 
				 <CONTROLNAME>Disclosure_MOT</CONTROLNAME> 
				 <CONTROLVALUE>True</CONTROLVALUE> 
			  </CONTROL>            
			</CONTROLS> 
			<CREATEUSER>SMJ</CREATEUSER>'
		    
		--*** REMOVE ANY HEADER VALUES AND STRIP OUT FROM XML

		--GET CASEID
		SET @PosStart =	CHARINDEX ('<CASEID>', @pInput)
		SET @PosStart = @PosStart + LEN ('<CASEID>')
		SET @PosEnd = CHARINDEX ('</CASEID>', @pInput)
		SELECT @Disclosure_CaseID =  SUBSTRING (@pInput, @PosStart, @PosEnd - @PosStart)

		--GET DISCLOSURE_CODE
		SET @PosStart = CHARINDEX ('<CODE>', @pInput)
		SET  @PosStart = @PosStart + LEN ('<CODE>') 
		SET @PosEnd = CHARINDEX ('</CODE>', @pInput)
		SELECT @Disclosure_Code =  SUBSTRING (@pInput, @PosStart, @PosEnd - @PosStart)

		--GET CREATE USER
		SET @PosStart = CHARINDEX ('<CREATEUSER>', @pInput)
		SET  @PosStart = @PosStart + LEN ('<CREATEUSER>') 
		SET @PosEnd = CHARINDEX ('</CREATEUSER>', @pInput)
		SELECT @Disclosure_User =  SUBSTRING (@pInput, @PosStart, @PosEnd - @PosStart)


		--REMOVE CASEID, DISCLOSURE_CODE AND CREATE_USER FROM XML
		SELECT @pInput = REPLACE (@pinput,('<CASEID>' + CONVERT (VARCHAR(10),@Disclosure_CaseID) +  '</CASEID>'),'')
		SELECT @pInput = REPLACE (@pinput,('<CODE>' + @Disclosure_Code + '</CODE>'),'')
		SELECT @pInput = REPLACE (@pinput,('<CREATEUSER>' + @Disclosure_User + '</CREATEUSER>'),'')

		SELECT @XmlConvert = CAST (@pInput AS XML)
		
		--PREPARE XML DOC, TO TURN INTO TABLE FORMAT
		DECLARE @iDoc int
		EXEC sp_xml_preparedocument @iDoc OUTPUT, @XmlConvert
		DECLARE @Disclosure TABLE  (ID INT IDENTITY (1,1), Field VARCHAR(50), Value BIT)
		
		--CREATE XML TABLE
		INSERT INTO @Disclosure
		SELECT *
		FROM OPENXML(@iDoc, '//CONTROL', 3) -- WANT TO GET VALUES FROM 3rd LEVEL
		WITH (
				[CONTROLNAME] varchar(50),
				[CONTROLVALUE] varchar(50)
			)		
		
	
		--GET ALL DISCLOSURE FIELDS INTO ONE TABLE
		DECLARE @DisclosureSave TABLE (ID INT IDENTITY(1,1), ColName VARCHAR(255), Value VARCHAR(255))
		INSERT INTO @DisclosureSave (ColName)
		SELECT [name] AS [ColName]
		FROM syscolumns
		WHERE id = (SELECT id 
		FROM sysobjects
		WHERE type = 'U'
		AND [NAME] = 'Disclosure')
		
		--INSERT NEW RECORD - JUST PUT HEADERS IN FIRST
		UPDATE @DisclosureSave
		SET Value = '''' + @Disclosure_Code + ''''
		WHERE ColName = 'Disclosure_DisclosureCode'
		
		
		UPDATE @DisclosureSave
		SET Value = @Disclosure_CaseID
		WHERE ColName = 'Disclosure_CaseID'
		
		UPDATE @DisclosureSave
		SET Value = '''' + @Disclosure_User + ''''
		WHERE ColName = 'Disclosure_CreateUser'
		
		--UPDATE @DisclosureSave
		--SET Value = GETDATE()
		--WHERE ColName = 'Disclosure_CreateDate'

		UPDATE @DisclosureSave 
		SET Value = d.Value
		FROM @Disclosure d
		INNER JOIN @DisclosureSave ds
		ON d.Field = ds.ColName
		
		
		SELECT @MaxID = MAX (ID) FROM @DisclosureSave 
		
		SELECT @MinID = 4
		SELECT @ValList = ''
		SELECT @ValList = @ValList + ',' + Value FROm @DisclosureSave WHERE [ID] = 2
		SELECT @ValList = @ValList + ',' + Value FROm @DisclosureSave WHERE [ID] = 3
	
		WHILE @MinID < @MaxID
		BEGIN
			--BUILD VALUE LIST
			SELECT  @ValVal = ISNULL(Value,0)FROM @DisclosureSave where ID = @MinID
			SELECT @ValList =@ValList + ',' +  @ValVal

			SELECT @MinID = @MinID + 1
		END
			SELECT @ValList = STUFF(@ValList,1,1,'')
			
			SELECT @StrSQL = ' INSERT INTO Disclosure (Disclosure_DisclosureCode, Disclosure_CaseID, Disclosure_DiscDealtWith, Disclosure_FurDocsReq, Disclosure_ReqDocsFrom, Disclosure_ExtDam, Disclosure_MOT, Disclosure_MaintRep, Disclosure_Tacho, Disclosure_ComMaintRep, Disclosure_LocalAuth, Disclosure_AccidBook, Disclosure_FirstAid, Disclosure_SurgeryRec, Disclosure_SuperAccidRep, Disclosure_SafeRepAccidRep, Disclosure_Riddorrep, Disclosure_OtherComms, Disclosure_MinsHlthSafe, Disclosure_DSSRep, Disclosure_SimilAccidDocs, Disclosure_EarningInfo, Disclosure_PreAccidRisk, Disclosure_PostAccidRisk, Disclosure_AccidInvestRecs, Disclosure_HealthSurvRep, Disclosure_InfoToEmps, Disclosure_HandSTrainDocs, Disclosure_WorkPlaceReg, Disclosure_WorkEquipReg, Disclosure_ProtectEquipReg, Disclosure_ManHandReg, Disclosure_DispScreenReg, Disclosure_COSHHReg, Disclosure_PressGasReg, Disclosure_LiftingReg, Disclosure_NoiseReg, Disclosure_ConstructGenReg, Disclosure_WPRepMaintRecs, Disclosure_WPHouseKeepRecs, Disclosure_WPHazardSign, Disclosure_WEManSpec, Disclosure_WEMaintLog, Disclosure_WEInfoToEmps, Disclosure_WETrainDocs, Disclosure_WENoticeSign, Disclosure_WEInstructDocs, Disclosure_WECopyMark, Disclosure_WECopyWarn, Disclosure_PEAssessDocs, Disclosure_PEMaintRepDocs, Disclosure_PEMaintProcDocs, Disclosure_PETestDocs, Disclosure_PEInfoToEmps, Disclosure_PEInstructDocs, Disclosure_MHPreAccidRisk, Disclosure_MHPostAccidRisk, Disclosure_MHInfoToEmps, Disclosure_MHTrainDocs, Disclosure_DSPreAccidRisk, Disclosure_DSPostAccidRisk, Disclosure_DSTrainDocs, Disclosure_DSInfoToEmps, Disclosure_PGSpecMarking, Disclosure_PGWrittenStatmnt, Disclosure_PGCopyWrittenStatmnt, Disclosure_PGExamRecs, Disclosure_PGInstructUse, Disclosure_PGRecsA, Disclosure_PGRecsB, Disclosure_CHAirMonitorRecs, Disclosure_CHMonitorRecs, Disclosure_CHHlthSurvRecs, Disclosure_CHPreAccidRisk, Disclosure_CHPostAccidRisk, Disclosure_CHCopyLabel, Disclosure_CHWarnSign, Disclosure_CHLabelData, Disclosure_CHMaintExamRecs, Disclosure_CHTrainDocs, Disclosure_CHAssessDocs, Disclosure_CHInstructUse, Disclosure_CHMaintRepDocs, Disclosure_CHMaintProcDocs, Disclosure_CHTestRecs, Disclosure_CHInfoToEmps, Disclosure_NRiskAssess, Disclosure_NManufactLit, Disclosure_NInfoToEmps, Disclosure_CGRepExcavn, Disclosure_CGRepCoffer, Disclosure_DMProjectForm, Disclosure_DMPlan, Disclosure_DMFile, Disclosure_DMTrainDocs, Disclosure_DMAdviceRecs, Disclosure_HPPreAccidRisk, Disclosure_HPPostAccidRisk, Disclosure_InspectionRecs, Disclosure_MaintRecs, Disclosure_PolicyMins, Disclosure_ComplaintRecs, Disclosure_OtherAccidRecs, Disclosure_InActive, Disclosure_CreateUser) '
			SELECT @StrSQL = @StrSQL + ' SELECT ' +  @ValList
			
			EXECUTE sp_executesql @StrSQL
			IF @@ROWCOUNT >   0 
				SELECT @Disc_DiscID = MAX(Disclosure_DisclosureID) FROM Disclosure
				SELECT @Disc_DiscID AS DiscID
				

				SELECT @Disc_Code = Disclosure_DisclosureCode FROM Disclosure WHERE Disclosure_DisclosureID = @Disc_DiscID
				SELECT @Disc_Code = STUFF(@Disc_Code + REPLICATE('0',15),(LEN (@Disc_Code + REPLICATE('0',15)) - LEN(@Disc_DiscID)) + 1,LEN(@Disc_DiscID),@Disc_DiscID )
				UPDATE Disclosure SET Disclosure_DisclosureCode = @Disc_Code WHERE Disclosure_DisclosureID = @Disc_DiscID
	END TRY

	
	BEGIN CATCH
		SELECT ERROR_MESSAGE() + OBJECT_NAME(@@PROCID)
	END CATCH 




GO


