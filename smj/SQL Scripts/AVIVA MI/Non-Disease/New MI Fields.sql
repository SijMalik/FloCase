INSERT INTO MIFieldDefinition SELECT 'AVBLMDIB', 'MIMONEY', 'BLM Disbursements', NULL, 'FinancialReserve_BLMDisb', 'Financial_Reserve', NULL, 0, GETDATE(), 'SMJ', 1
INSERT INTO MIFieldDefinition SELECT 'AVBLMPC', 'MIMONEY', 'BLM Profit Costs', NULL, 'FinancialReserve_BLMProfCosts', 'Financial_Reserve', NULL, 0, GETDATE(), 'SMJ', 1
INSERT INTO MIFieldDefinition SELECT 'AVBLMVAT', 'MIMONEY', 'BLM VAT', NULL, 'FinancialReserve_BLMDisbExVAT', 'Financial_Reserve', NULL, 0, GETDATE(), 'SMJ', 1
INSERT INTO MIFieldDefinition SELECT 'AVCATEGORY', 'MILKP', 'Category', 'AVCATEGORY', 'ManagementInformation_WorkType1', 'ManagementInformation', NULL, 0, GETDATE(), 'SMJ', 0
INSERT INTO MIFieldDefinition SELECT 'CAUSELIT1', 'MILKP', 'Cause of Litigation 1', 'CAUSELIT1', 'LitigationLiability_LitReason1', 'LitigationLiability', NULL, 0, GETDATE(), 'SMJ', 0
INSERT INTO MIFieldDefinition SELECT 'CAUSELIT2', 'MILKP', 'Cause of Litigation 2', 'CAUSELIT2', 'LitigationLiability_LitReason2', 'LitigationLiability', NULL, 0, GETDATE(), 'SMJ', 0
INSERT INTO MIFieldDefinition SELECT 'AVCLAILOC', 'MILKP', 'Claims Location', 'AVCLAILOC', 'ManagementInformation_ClntOffLoc', 'ManagementInformation', NULL, 0, GETDATE(), 'SMJ', 0
INSERT INTO MIFieldDefinition SELECT 'AVCOMMOD', 'MILKP', 'Commodity', 'AVCOMMOD', 'CaseDetails_CourtTrack', 'CaseDetails', NULL, 0, GETDATE(), 'SMJ', 0
INSERT INTO MIFieldDefinition SELECT 'DTELIAAGR', 'MIDTEINP', 'Date Liability Agreed', NULL, 'CaseKeyDates_Date', 'CaseKeyDates', 'DTELIAAGR', 0, GETDATE(), 'SMJ', 0
INSERT INTO MIFieldDefinition SELECT 'DTELECLAI', 'MIDTEINP', 'Date of Letter of Claim', NULL, 'CaseKeyDates_Date', 'CaseKeyDates', 'DTELECLAI', 0, GETDATE(), 'SMJ', 0
INSERT INTO MIFieldDefinition SELECT 'AVDEFJUD', 'MILKP', 'Default Judgement','YesNo','CaseDetails_DefaultJudgmnt', 'CaseDetails', NULL, 0, GETDATE(), 'SMJ', 0
INSERT INTO MIFieldDefinition SELECT 'AVINJTYPE', 'MILKP', 'Injury Type', 'AVINJTYPE', 'ManagementInformation_InjuryType', 'ManagementInformation', NULL, 0, GETDATE(), 'SMJ', 0
INSERT INTO MIFieldDefinition SELECT 'INSTRUNIT', 'MILKP', 'Instructing Unit', 'INSTRUNIT', 'ManagementInformation_ClntTeam', 'ManagementInformation', NULL, 0, GETDATE(), 'SMJ', 0
INSERT INTO MIFieldDefinition SELECT 'LitAtAV', 'MILKP', 'Litigated at Aviva (before our instruction)','YesNo','LitigationLiability_LitigatedAtAV', 'LitigationLiability', NULL, 0, GETDATE(), 'SMJ', 0
INSERT INTO MIFieldDefinition SELECT 'AVLITSTAT', 'MILKP', 'Litigation Status', 'AVLITSTAT', 'LitigationLiability_LitigatedPostInstrtn', 'LitigationLiability', NULL, 0, GETDATE(), 'SMJ', 0
INSERT INTO MIFieldDefinition SELECT 'MOJINS', 'MILKP', 'MoJ at Instruction','YesNo','MOJ_STAGE_CASE', '_HBM_Matter_Usr_Data', NULL, 0, GETDATE(), 'SMJ', 0
INSERT INTO MIFieldDefinition SELECT 'MOJSTTLD', 'MILKP', 'MoJ at Settlement','YesNo','ManagementInformation_MOJSttldStts', 'ManagementInformation', NULL, 0, GETDATE(), 'SMJ', 0
INSERT INTO MIFieldDefinition SELECT 'LICYNUMBER', 'MITEXT', 'Policy Number', NULL, 'ManagementInformation_PolicyNumber', 'ManagementInformation', NULL, 0, GETDATE(), 'SMJ', 0
INSERT INTO MIFieldDefinition SELECT 'REAOTURN', 'MILKP', 'Reason for overturning the Aviva claims handler decision','YesNo','ManagementInformation_ReasonOverturnAV', 'ManagementInformation', NULL, 0, GETDATE(), 'SMJ', 0
INSERT INTO MIFieldDefinition SELECT 'AVVALBAND', 'MILKP', 'Service Instructed', 'AVVALBAND', 'ManagementInformation_ServiceInstructed', 'ManagementInformation', NULL, 0, GETDATE(), 'SMJ', 0
INSERT INTO MIFieldDefinition SELECT 'MIFTCS', 'MILKP', 'TCS','YesNo','ManagementInformation_TCS', 'ManagementInformation', NULL, 0, GETDATE(), 'SMJ', 0
INSERT INTO MIFieldDefinition SELECT 'SERVINSTR', 'MILKP', 'Value Band', 'SERVINSTR', 'CaseDetails_WorkValueCode', 'CaseDetails', NULL, 0, GETDATE(), 'SMJ', 0
