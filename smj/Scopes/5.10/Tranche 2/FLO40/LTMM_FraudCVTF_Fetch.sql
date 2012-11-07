
/****** Object:  StoredProcedure [dbo].[LTMM_FraudCVTF_Fetch]    Script Date: 09/14/2011 16:48:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[LTMM_FraudCVTF_Fetch]
(
	@pFraudCVTF_CaseID INT = 0,
	@pUserName VARCHAR(255)= ''

)
	-- ==========================================================================================
	-- SMJ - CREATED - 14-09-2011
	-- SP Fetches the FraudCVTF record for the Case ID and User Name passed in
	-- =========================================================================================
	
AS

	SET NOCOUNT ON
	
	DECLARE @errFraudCVTFID VARCHAR(255)
	DECLARE @errFraudCVTF VARCHAR (255)
	DECLARE @errInsertNoName VARCHAR (255)
	
	SELECT @errFraudCVTFID = 'Invalid CaseID ' + CONVERT(VARCHAR(5),@pFraudCVTF_CaseID) + ' entered.'
	SELECT @errFraudCVTF = 'Couldn''t find any DefenceDetails for CaseID ' + CONVERT(VARCHAR(5),@pFraudCVTF_CaseID) + '.'
	SELECT @errInsertNoName = 'User name must be supplied.'
	
	BEGIN TRY
	
		--Raise error if ID is invalid
		IF (@pFraudCVTF_CaseID < 1) 
			RAISERROR (@errFraudCVTFID,16,1)
		
		IF NOT EXISTS (SELECT 1 FROM FraudCVTF WHERE FraudCVTF_CaseID = @pFraudCVTF_CaseID AND FraudCVTF_CreateUser = @pUserName)
			SELECT 
				FraudCVTF_FraudCVTFID,
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
				FraudCVTF_LwyrRfrFile
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
			FROM dbo.FraudCVTF
			WHERE FraudCVTF_CaseID = @pFraudCVTF_CaseID
			AND FraudCVTF_InActive = 0	
		ELSE			
			SELECT 
				FraudCVTF_FraudCVTFID,
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
				FraudCVTF_LwyrRfrFile
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
			FROM dbo.FraudCVTF
			WHERE FraudCVTF_CaseID = @pFraudCVTF_CaseID
			AND FraudCVTF_InActive = 0
			AND FraudCVTF_CreateUser = CASE WHEN @pUserName='' THEN FraudCVTF_CreateUser ELSE @pUserName END
			
		--Raise error if no details found
		IF @@ROWCOUNT = 0 
			RAISERROR (@errFraudCVTF,16,1)
		
	END TRY

	BEGIN CATCH
		SELECT (ERROR_MESSAGE() + ' SP:' + OBJECT_NAME(@@PROCID)) AS Error
	END CATCH
	

GO


