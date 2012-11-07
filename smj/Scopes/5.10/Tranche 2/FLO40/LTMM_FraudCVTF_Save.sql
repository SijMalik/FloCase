
/****** Object:  StoredProcedure [dbo].[LTMM_FraudCVTF_Save]    Script Date: 09/14/2011 17:00:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[LTMM_FraudCVTF_Save]
(
	@pFraudCVTF_FraudCVTFCode Varchar(255) = '' , -- (INPUT A)
	@pFraudCVTF_CaseID int = 0 , -- (INPUT B)
	@pFraudCVTF_IndmntyCnfmd Bit = 0 , -- (INPUT C)
	@pFraudCVTF_IndmntyRsvrd Bit = 0 , -- (INPUT D)
	@pFraudCVTF_IndmntyRfsd Bit = 0 , -- (INPUT E)
	@pFraudCVTF_CnsntIndmntyFrmSnt Bit = 0 , -- (INPUT F)
	@pFraudCVTF_PolAppIssues Bit = 0 , -- (INPUT G)
	@pFraudCVTF_RsrvtnLtrSnt Bit = 0 , -- (INPUT H)
	@pFraudCVTF_RfslIndmntyLtrSnt Bit = 0 , -- (INPUT I)
	@pFraudCVTF_LwyrNotes Varchar(Max)= '' , -- (INPUT J)
	@pFraudCVTF_AccdntHtSpt Bit = 0 , -- (INPUT K)
	@pFraudCVTF_UnslAccdntCirc Bit = 0 , -- (INPUT L)
	@pFraudCVTF_MutiClaim Bit = 0 , -- (INPUT M)
	@pFraudCVTF_NoAccdntBkEntry Bit = 0 , -- (INPUT N)
	@pFraudCVTF_UnslLOE Bit = 0 , -- (INPUT O)
	@pFraudCVTF_LegalBfrMdcl Bit = 0 , -- (INPUT P)
	@pFraudCVTF_OtherAccdnts Bit = 0 , -- (INPUT Q)
	@pFraudCVTF_UnslNoWtnss Bit = 0 , -- (INPUT R)
	@pFraudCVTF_InconMedRec Bit = 0 , -- (INPUT S)
	@pFraudCVTF_InconOccHlth Bit = 0 , -- (INPUT T)
	@pFraudCVTF_InconFnncl Bit = 0 , -- (INPUT U)
	@pFraudCVTF_InconWitEvid Bit = 0 , -- (INPUT V)
	@pFraudCVTF_ClmntUncprtv Bit = 0 , -- (INPUT W)
	@pFraudCVTF_ClmntEmpStat Bit = 0 , -- (INPUT X)
	@pFraudCVTF_ClmntGrvnce Bit = 0 , -- (INPUT Y)
	@pFraudCVTF_ClmntEmpBust Bit = 0 , -- (INPUT Z)
	@pFraudCVTF_ClmntDshnst Bit = 0 , -- (INPUT AA)
	@pFraudCVTF_ClmntNilCRU Bit = 0 , -- (INPUT AB)
	@pFraudCVTF_ClmntMultiClaim Bit = 0 , -- (INPUT AC)
	@pFraudCVTF_ClmntFnnclDiff Bit = 0 , -- (INPUT AD)
	@pFraudCVTF_ClmntRddnt Bit = 0 , -- (INPUT AE)
	@pFraudCVTF_ClmntDlyNtfctn Bit = 0 , -- (INPUT AF)
	@pFraudCVTF_ClmntTrnsntAddrss Bit = 0 , -- (INPUT AG)
	@pFraudCVTF_ClmntUnslSttlmnt Bit = 0 , -- (INPUT AH)
	@pFraudCVTF_ClmntGrvnc Bit = 0 , -- (INPUT AI)
	@pFraudCVTF_PlcyhldrUncprtv Bit = 0 , -- (INPUT AJ)
	@pFraudCVTF_PlcyhldrPlcyExprs Bit = 0 , -- (INPUT AK)
	@pFraudCVTF_PlcyhldrNonDsclsr Bit = 0 , -- (INPUT AL)
	@pFraudCVTF_PlcyhldrLateNtfctnClm Bit = 0 , -- (INPUT AM)
	@pFraudCVTF_PlcyhldrPlcyStrts Bit = 0 , -- (INPUT AN)
	@pFraudCVTF_PlcyhldrMultiClm Bit = 0 , -- (INPUT AO)
	@pFraudCVTF_PlcyhldrRcntChngsCvr Bit = 0 , -- (INPUT AP)
	@pFraudCVTF_FraudLwyr nVarchar(255) = '', -- (INPUT AQ)
	@pFraudCVTF_LwyrRvwDte Smalldatetime = NULL , -- (INPUT AR)
	@pFraudCVTF_LwyrRfrFile Bit = 0 , -- (INPUT AS)
	@pFraudCVTF_AssgndFraudCrdntr nVarchar(255) = '', -- (INPUT AT)
	@pFraudCVTF_FraudRskRtng nVarchar(255) = '', -- (INPUT AU)
	@pFraudCVTF_CUE Bit = 0 , -- (INPUT AV)
	@pFraudCVTF_InsrncFraudInvGrp Bit = 0 , -- (INPUT AW)
	@pFraudCVTF_CrdtHstry Bit = 0 , -- (INPUT AX)
	@pFraudCVTF_FnceRprt Bit = 0 , -- (INPUT AY)
	@pFraudCVTF_LndRgstryChck Bit = 0 , -- (INPUT AZ)
	@pFraudCVTF_IDChck Bit = 0 , -- (INPUT BA)
	@pFraudCVTF_OpnDataSrcs Bit = 0 , -- (INPUT BB)
	@pFraudCVTF_OthrSrcs Bit = 0 , -- (INPUT BC) 
	@pFraudCVTF_FileNotes nVarchar(max) = '' , -- (INPUT BD)
	@pFraudCVTF_FraudCrdntr nVarchar(255) = '', -- (INPUT BE)
	@pFraudCVTF_FraudCrdntrRvwDte Smalldatetime = NULL , -- (INPUT BF)
	@pFraudCVTF_FraudCrdntrRfrFile Bit = 0 , -- (INPUT BG)
	@pFraudCVTF_FraudTmMmbr nVarchar(255) = '', -- (INPUT BH)
	@pFraudCVTF_IIVRDate Smalldatetime = NULL , -- (INPUT BI)
	@pFraudCVTF_IIVRName nVarchar(255) = '', -- (INPUT BJ)
	@pFraudCVTF_FraudTmCmmnts nVarchar(Max) = '', -- (INPUT BK)
	@pFraudCVTF_DtldIntllgncRprtRqrd Bit = 0 , -- (INPUT BL)
	@pFraudCVTF_DtldIntllgncRprtDte Smalldatetime = NULL , -- (INPUT BM)
	@pFraudCVTF_DtldIntllgncRprtNme nVarchar(255) = '', -- (INPUT BN)
	@pFraudCVTF_FraudClsreTag nVarchar(255) = '', -- (INPUT BO)
	@pFraudCVTF_FraudTmRvwNme nVarchar(255) = '', -- (INPUT BP)
	@pFraudCVTF_FraudTmRvwDte Smalldatetime = NULL, -- (INPUT BQ)
	@pFraudCVTF_InActive Bit = 0 , -- (INPUT BR)
	@pFraudCVTF_CreateUser nVarchar(255) = ''  -- (INPUT BS)
)
AS
	DECLARE @FraudCVTF_FraudCVTFID	INT
	DECLARE @FraudCVTF_Code			VARCHAR(255)
	DECLARE @errInsertFraud			VARCHAR (255)
	DECLARE @errInsertCase			VARCHAR (255)
	DECLARE @errInsertNoName		VARCHAR (255)
	DECLARE @errInsertNoCase		VARCHAR (255)	
	DECLARE @errInvalidCode			VARCHAR (255)
	
	--Set error messages
	SELECT @errInsertFraud = 'Couldn''t insert new record into FraudCVTF table.'
	SELECT @errInsertCase =	 'Couldn''t insert new record into FraudCVTF table as record already exists.'		
	SELECT @errInsertNoName = 'User name must be supplied when creating a new record.'
	SELECT @errInsertNoCase = 'Case ID must be passed in when creating a new record.'
	SELECT @errInvalidCode = 'The FraudCVTF Code supplied does not exist.'
	
	
	BEGIN TRANSACTION SaveAll
	SET NOCOUNT ON

	BEGIN TRY
		
		--Do some checking
		IF @pFraudCVTF_FraudCVTFCode = '' AND @pFraudCVTF_CreateUser = ''
			RAISERROR (@errInsertNoName, 16, 1)
		
		
		--No code supplied so do new insert	
		IF @pFraudCVTF_FraudCVTFCode = ''
		BEGIN
		
			--No case ID suppplied
			IF @pFraudCVTF_CaseID = 0
				RAISERROR (@errInsertNoCase, 16, 1)	
				
			--Check Case doesn't exist, or is inactive
			IF EXISTS (SELECT FraudCVTF_CaseID FROM dbo.FraudCVTF WHERE FraudCVTF_CaseID = @pFraudCVTF_CaseID AND FraudCVTF_InActive = 0)
				RAISERROR(@errInsertCase ,16,1)		
				
			BEGIN
				--Case doesn't exist so save records to DefencDetails table
				INSERT INTO dbo.FraudCVTF
				(
					FraudCVTF_FraudCVTFCode, 
					FraudCVTF_CaseID, 
					FraudCVTF_IndmntyCnfmd, 
					FraudCVTF_IndmntyRsvrd, 
					FraudCVTF_IndmntyRfsd, 
					FraudCVTF_CnsntIndmntyFrmSnt, 
					FraudCVTF_PolAppIssues, 
					FraudCVTF_RsrvtnLtrSnt, 
					FraudCVTF_RfslIndmntyLtrSnt, 
					FraudCVTF_LwyrNotes, 
					FraudCVTF_AccdntHtSpt, 
					FraudCVTF_UnslAccdntCirc, 
					FraudCVTF_MutiClaim, 
					FraudCVTF_NoAccdntBkEntry, 
					FraudCVTF_UnslLOE, 
					FraudCVTF_LegalBfrMdcl, 
					FraudCVTF_OtherAccdnts, 
					FraudCVTF_UnslNoWtnss, 
					FraudCVTF_InconMedRec, 
					FraudCVTF_InconOccHlth,
					FraudCVTF_InconFnncl, 
					FraudCVTF_InconWitEvid, 
					FraudCVTF_ClmntUncprtv, 
					FraudCVTF_ClmntEmpStat, 
					FraudCVTF_ClmntGrvnce, 
					FraudCVTF_ClmntEmpBust, 
					FraudCVTF_ClmntDshnst, 
					FraudCVTF_ClmntNilCRU, 
					FraudCVTF_ClmntMultiClaim, 
					FraudCVTF_ClmntFnnclDiff, 
					FraudCVTF_ClmntRddnt, 
					FraudCVTF_ClmntDlyNtfctn, 
					FraudCVTF_ClmntTrnsntAddrss, 
					FraudCVTF_ClmntUnslSttlmnt, 
					FraudCVTF_ClmntGrvnc, 
					FraudCVTF_PlcyhldrUncprtv, 
					FraudCVTF_PlcyhldrPlcyExprs, 
					FraudCVTF_PlcyhldrNonDsclsr, 
					FraudCVTF_PlcyhldrLateNtfctnClm, 
					FraudCVTF_PlcyhldrPlcyStrts, 
					FraudCVTF_PlcyhldrMultiClm, 
					FraudCVTF_PlcyhldrRcntChngsCvr, 
					FraudCVTF_FraudLwyr, 
					FraudCVTF_LwyrRvwDte, 
					FraudCVTF_LwyrRfrFile, 
					FraudCVTF_AssgndFraudCrdntr, 
					FraudCVTF_FraudRskRtng, 
					FraudCVTF_CUE, 
					FraudCVTF_InsrncFraudInvGrp, 
					FraudCVTF_CrdtHstry, 
					FraudCVTF_FnceRprt, 
					FraudCVTF_LndRgstryChck, 
					FraudCVTF_IDChck, 
					FraudCVTF_OpnDataSrcs, 
					FraudCVTF_OthrSrcs, 
					FraudCVTF_FileNotes, 
					FraudCVTF_FraudCrdntr, 
					FraudCVTF_FraudCrdntrRvwDte, 
					FraudCVTF_FraudCrdntrRfrFile, 
					FraudCVTF_FraudTmMmbr, 
					FraudCVTF_IIVRDate, 
					FraudCVTF_IIVRName, 
					FraudCVTF_FraudTmCmmnts, 
					FraudCVTF_DtldIntllgncRprtRqrd, 
					FraudCVTF_DtldIntllgncRprtDte, 
					FraudCVTF_DtldIntllgncRprtNme, 
					FraudCVTF_FraudClsreTag, 
					FraudCVTF_FraudTmRvwNme, 
					FraudCVTF_FraudTmRvwDte, 
					FraudCVTF_InActive, 
					FraudCVTF_CreateUser, 
					FraudCVTF_CreateDate
				)
				SELECT
					@pFraudCVTF_FraudCVTFCode, 
					@pFraudCVTF_CaseID, 
					@pFraudCVTF_IndmntyCnfmd, 
					@pFraudCVTF_IndmntyRsvrd, 
					@pFraudCVTF_IndmntyRfsd, 
					@pFraudCVTF_CnsntIndmntyFrmSnt, 
					@pFraudCVTF_PolAppIssues, 
					@pFraudCVTF_RsrvtnLtrSnt, 
					@pFraudCVTF_RfslIndmntyLtrSnt, 
					@pFraudCVTF_LwyrNotes, 
					@pFraudCVTF_AccdntHtSpt, 
					@pFraudCVTF_UnslAccdntCirc, 
					@pFraudCVTF_MutiClaim, 
					@pFraudCVTF_NoAccdntBkEntry, 
					@pFraudCVTF_UnslLOE, 
					@pFraudCVTF_LegalBfrMdcl, 
					@pFraudCVTF_OtherAccdnts, 
					@pFraudCVTF_UnslNoWtnss, 
					@pFraudCVTF_InconMedRec, 
					@pFraudCVTF_InconOccHlth,
					@pFraudCVTF_InconFnncl, 
					@pFraudCVTF_InconWitEvid, 
					@pFraudCVTF_ClmntUncprtv, 
					@pFraudCVTF_ClmntEmpStat, 
					@pFraudCVTF_ClmntGrvnce, 
					@pFraudCVTF_ClmntEmpBust, 
					@pFraudCVTF_ClmntDshnst, 
					@pFraudCVTF_ClmntNilCRU, 
					@pFraudCVTF_ClmntMultiClaim, 
					@pFraudCVTF_ClmntFnnclDiff, 
					@pFraudCVTF_ClmntRddnt, 
					@pFraudCVTF_ClmntDlyNtfctn, 
					@pFraudCVTF_ClmntTrnsntAddrss, 
					@pFraudCVTF_ClmntUnslSttlmnt, 
					@pFraudCVTF_ClmntGrvnc, 
					@pFraudCVTF_PlcyhldrUncprtv, 
					@pFraudCVTF_PlcyhldrPlcyExprs, 
					@pFraudCVTF_PlcyhldrNonDsclsr, 
					@pFraudCVTF_PlcyhldrLateNtfctnClm, 
					@pFraudCVTF_PlcyhldrPlcyStrts, 
					@pFraudCVTF_PlcyhldrMultiClm, 
					@pFraudCVTF_PlcyhldrRcntChngsCvr, 
					@pFraudCVTF_FraudLwyr, 
					@pFraudCVTF_LwyrRvwDte, 
					@pFraudCVTF_LwyrRfrFile, 
					@pFraudCVTF_AssgndFraudCrdntr, 
					@pFraudCVTF_FraudRskRtng, 
					@pFraudCVTF_CUE, 
					@pFraudCVTF_InsrncFraudInvGrp, 
					@pFraudCVTF_CrdtHstry, 
					@pFraudCVTF_FnceRprt, 
					@pFraudCVTF_LndRgstryChck, 
					@pFraudCVTF_IDChck, 
					@pFraudCVTF_OpnDataSrcs, 
					@pFraudCVTF_OthrSrcs, 
					@pFraudCVTF_FileNotes, 
					@pFraudCVTF_FraudCrdntr, 
					@pFraudCVTF_FraudCrdntrRvwDte, 
					@pFraudCVTF_FraudCrdntrRfrFile, 
					@pFraudCVTF_FraudTmMmbr, 
					@pFraudCVTF_IIVRDate, 
					@pFraudCVTF_IIVRName, 
					@pFraudCVTF_FraudTmCmmnts, 
					@pFraudCVTF_DtldIntllgncRprtRqrd, 
					@pFraudCVTF_DtldIntllgncRprtDte, 
					@pFraudCVTF_DtldIntllgncRprtNme, 
					@pFraudCVTF_FraudClsreTag, 
					@pFraudCVTF_FraudTmRvwNme, 
					@pFraudCVTF_FraudTmRvwDte, 
					@pFraudCVTF_InActive, 
					@pFraudCVTF_CreateUser, 
					GETDATE()
			
				IF @@ROWCOUNT = 0 
					RAISERROR (@errInsertFraud,16,1)
									
				--SET DefenceDetails_Code	
				SELECT @FraudCVTF_FraudCVTFID = SCOPE_IDENTITY()
				SELECT @FraudCVTF_Code = STUFF('FCVTF' + REPLICATE('0',14),(LEN ('FCVTF' + REPLICATE('0',14)) - LEN(@FraudCVTF_FraudCVTFID)) + 1,LEN(@FraudCVTF_FraudCVTFID),@FraudCVTF_FraudCVTFID )
				
				UPDATE FraudCVTF SET FraudCVTF_FraudCVTFCode = @FraudCVTF_Code
				WHERE FraudCVTF_FraudCVTFID = @FraudCVTF_FraudCVTFID
			END
		END	
		ELSE -- Set current record to inactive 
		BEGIN

			--Check code exists
			IF NOT EXISTS (SELECT FraudCVTF_FraudCVTFCode FROM FraudCVTF WHERE FraudCVTF_FraudCVTFCode = @pFraudCVTF_FraudCVTFCode)
				RAISERROR  (@errInvalidCode ,16,1)
				
			--Get the case ID for later use
			--Get the Fraud ID for later use
			SELECT	@pFraudCVTF_CaseID = FraudCVTF_CaseID,
					@FraudCVTF_FraudCVTFID = FraudCVTF_FraudCVTFID
			FROM	FraudCVTF 
			WHERE	FraudCVTF_FraudCVTFCode = @pFraudCVTF_FraudCVTFCode

			--Set record inactive
			UPDATE	FraudCVTF 
			SET		FraudCVTF_InActive = 1
			WHERE	FraudCVTF_FraudCVTFID = @FraudCVTF_FraudCVTFID
				
			--Check if InActive field set to 1 - in which case insert new record
			IF @pFraudCVTF_InActive = 0
			BEGIN
			
				--No User Name
				IF @pFraudCVTF_CreateUser = ''
					RAISERROR (@errInsertNoName, 16, 1)

				--Check Case doesn't exist, or is inactive
				IF EXISTS (SELECT FraudCVTF_CaseID FROM dbo.FraudCVTF WHERE FraudCVTF_CaseID = @pFraudCVTF_CaseID AND FraudCVTF_InActive = 0)
					RAISERROR(@errInsertCase ,16,1)
					
				INSERT INTO dbo.FraudCVTF
				(
					FraudCVTF_FraudCVTFCode, 
					FraudCVTF_CaseID, 
					FraudCVTF_IndmntyCnfmd, 
					FraudCVTF_IndmntyRsvrd, 
					FraudCVTF_IndmntyRfsd, 
					FraudCVTF_CnsntIndmntyFrmSnt, 
					FraudCVTF_PolAppIssues, 
					FraudCVTF_RsrvtnLtrSnt, 
					FraudCVTF_RfslIndmntyLtrSnt, 
					FraudCVTF_LwyrNotes, 
					FraudCVTF_AccdntHtSpt, 
					FraudCVTF_UnslAccdntCirc, 
					FraudCVTF_MutiClaim, 
					FraudCVTF_NoAccdntBkEntry, 
					FraudCVTF_UnslLOE, 
					FraudCVTF_LegalBfrMdcl, 
					FraudCVTF_OtherAccdnts, 
					FraudCVTF_UnslNoWtnss, 
					FraudCVTF_InconMedRec, 
					FraudCVTF_InconOccHlth,
					FraudCVTF_InconFnncl, 
					FraudCVTF_InconWitEvid, 
					FraudCVTF_ClmntUncprtv, 
					FraudCVTF_ClmntEmpStat, 
					FraudCVTF_ClmntGrvnce, 
					FraudCVTF_ClmntEmpBust, 
					FraudCVTF_ClmntDshnst, 
					FraudCVTF_ClmntNilCRU, 
					FraudCVTF_ClmntMultiClaim, 
					FraudCVTF_ClmntFnnclDiff, 
					FraudCVTF_ClmntRddnt, 
					FraudCVTF_ClmntDlyNtfctn, 
					FraudCVTF_ClmntTrnsntAddrss, 
					FraudCVTF_ClmntUnslSttlmnt, 
					FraudCVTF_ClmntGrvnc, 
					FraudCVTF_PlcyhldrUncprtv, 
					FraudCVTF_PlcyhldrPlcyExprs, 
					FraudCVTF_PlcyhldrNonDsclsr, 
					FraudCVTF_PlcyhldrLateNtfctnClm, 
					FraudCVTF_PlcyhldrPlcyStrts, 
					FraudCVTF_PlcyhldrMultiClm, 
					FraudCVTF_PlcyhldrRcntChngsCvr, 
					FraudCVTF_FraudLwyr, 
					FraudCVTF_LwyrRvwDte, 
					FraudCVTF_LwyrRfrFile, 
					FraudCVTF_AssgndFraudCrdntr, 
					FraudCVTF_FraudRskRtng, 
					FraudCVTF_CUE, 
					FraudCVTF_InsrncFraudInvGrp, 
					FraudCVTF_CrdtHstry, 
					FraudCVTF_FnceRprt, 
					FraudCVTF_LndRgstryChck, 
					FraudCVTF_IDChck, 
					FraudCVTF_OpnDataSrcs, 
					FraudCVTF_OthrSrcs, 
					FraudCVTF_FileNotes, 
					FraudCVTF_FraudCrdntr, 
					FraudCVTF_FraudCrdntrRvwDte, 
					FraudCVTF_FraudCrdntrRfrFile, 
					FraudCVTF_FraudTmMmbr, 
					FraudCVTF_IIVRDate, 
					FraudCVTF_IIVRName, 
					FraudCVTF_FraudTmCmmnts, 
					FraudCVTF_DtldIntllgncRprtRqrd, 
					FraudCVTF_DtldIntllgncRprtDte, 
					FraudCVTF_DtldIntllgncRprtNme, 
					FraudCVTF_FraudClsreTag, 
					FraudCVTF_FraudTmRvwNme, 
					FraudCVTF_FraudTmRvwDte, 
					FraudCVTF_InActive, 
					FraudCVTF_CreateUser, 
					FraudCVTF_CreateDate
				)
				SELECT
					@pFraudCVTF_FraudCVTFCode, 
					FraudCVTF_CaseID, 
					@pFraudCVTF_IndmntyCnfmd, 
					@pFraudCVTF_IndmntyRsvrd, 
					@pFraudCVTF_IndmntyRfsd, 
					@pFraudCVTF_CnsntIndmntyFrmSnt, 
					@pFraudCVTF_PolAppIssues, 
					@pFraudCVTF_RsrvtnLtrSnt, 
					@pFraudCVTF_RfslIndmntyLtrSnt, 
					@pFraudCVTF_LwyrNotes, 
					@pFraudCVTF_AccdntHtSpt, 
					@pFraudCVTF_UnslAccdntCirc, 
					@pFraudCVTF_MutiClaim, 
					@pFraudCVTF_NoAccdntBkEntry, 
					@pFraudCVTF_UnslLOE, 
					@pFraudCVTF_LegalBfrMdcl, 
					@pFraudCVTF_OtherAccdnts, 
					@pFraudCVTF_UnslNoWtnss, 
					@pFraudCVTF_InconMedRec, 
					@pFraudCVTF_InconOccHlth,
					@pFraudCVTF_InconFnncl, 
					@pFraudCVTF_InconWitEvid, 
					@pFraudCVTF_ClmntUncprtv, 
					@pFraudCVTF_ClmntEmpStat, 
					@pFraudCVTF_ClmntGrvnce, 
					@pFraudCVTF_ClmntEmpBust, 
					@pFraudCVTF_ClmntDshnst, 
					@pFraudCVTF_ClmntNilCRU, 
					@pFraudCVTF_ClmntMultiClaim, 
					@pFraudCVTF_ClmntFnnclDiff, 
					@pFraudCVTF_ClmntRddnt, 
					@pFraudCVTF_ClmntDlyNtfctn, 
					@pFraudCVTF_ClmntTrnsntAddrss, 
					@pFraudCVTF_ClmntUnslSttlmnt, 
					@pFraudCVTF_ClmntGrvnc, 
					@pFraudCVTF_PlcyhldrUncprtv, 
					@pFraudCVTF_PlcyhldrPlcyExprs, 
					@pFraudCVTF_PlcyhldrNonDsclsr, 
					@pFraudCVTF_PlcyhldrLateNtfctnClm, 
					@pFraudCVTF_PlcyhldrPlcyStrts, 
					@pFraudCVTF_PlcyhldrMultiClm, 
					@pFraudCVTF_PlcyhldrRcntChngsCvr, 
					@pFraudCVTF_FraudLwyr, 
					@pFraudCVTF_LwyrRvwDte, 
					@pFraudCVTF_LwyrRfrFile, 
					@pFraudCVTF_AssgndFraudCrdntr, 
					@pFraudCVTF_FraudRskRtng, 
					@pFraudCVTF_CUE, 
					@pFraudCVTF_InsrncFraudInvGrp, 
					@pFraudCVTF_CrdtHstry, 
					@pFraudCVTF_FnceRprt, 
					@pFraudCVTF_LndRgstryChck, 
					@pFraudCVTF_IDChck, 
					@pFraudCVTF_OpnDataSrcs, 
					@pFraudCVTF_OthrSrcs, 
					@pFraudCVTF_FileNotes, 
					@pFraudCVTF_FraudCrdntr, 
					@pFraudCVTF_FraudCrdntrRvwDte, 
					@pFraudCVTF_FraudCrdntrRfrFile, 
					@pFraudCVTF_FraudTmMmbr, 
					@pFraudCVTF_IIVRDate, 
					@pFraudCVTF_IIVRName, 
					@pFraudCVTF_FraudTmCmmnts, 
					@pFraudCVTF_DtldIntllgncRprtRqrd, 
					@pFraudCVTF_DtldIntllgncRprtDte, 
					@pFraudCVTF_DtldIntllgncRprtNme, 
					@pFraudCVTF_FraudClsreTag, 
					@pFraudCVTF_FraudTmRvwNme, 
					@pFraudCVTF_FraudTmRvwDte, 
					0, 
					@pFraudCVTF_CreateUser, 
					GETDATE()
				FROM FraudCVTF
				WHERE FraudCVTF_FraudCVTFID = @FraudCVTF_FraudCVTFID
				AND FraudCVTF_InActive = 1
				
				IF @@ROWCOUNT = 0 
					RAISERROR (@errInsertFraud,16,1)						
										
			END
			
		END	

		COMMIT TRANSACTION SaveAll
		
		SELECT @FraudCVTF_FraudCVTFID = SCOPE_IDENTITY() 
		
		IF @FraudCVTF_FraudCVTFID > 0 
			SELECT @FraudCVTF_FraudCVTFID AS FraudCVTFID
			SELECT CASE WHEN @FraudCVTF_Code IS NULL THEN @pFraudCVTF_FraudCVTFCode ELSE @FraudCVTF_Code END  As FraudCVTF_Code
	END TRY
	
	BEGIN CATCH
		SELECT (ERROR_MESSAGE() + ' SP:' + OBJECT_NAME(@@PROCID)) AS Error
		ROLLBACK TRANSACTION SaveAll
	END CATCH
	


GO


