--1. INSERT NEW SET INTO ClientMIDefinition

 	INSERT INTO ClientMIDefinition
  	SELECT NULL, 'AVIVA', 'CLAIM', 'AVIVA', 'AVIVACLAIM', 0, 'SMJ', GETDATE(), 1


--2. INSERT CLIENT PANELS


	--PAGE 1
	INSERT INTO ClientMIPanels
	SELECT 'AVIVACLAIM',1,1,'Aviva Claimant Specific MI',0,GETDATE(), 'SMJ'


	--PAGE 2
	INSERT INTO ClientMIPanels
	SELECT 'AVIVACLAIM',1,2,'Aviva Claimant Specific MI',0,GETDATE(), 'SMJ'

	--PAGE 2
	INSERT INTO ClientMIPanels
	SELECT 'AVIVACLAIM',1,3,'Aviva Claimant Specific MI',0,GETDATE(), 'SMJ'


--3. INSERT NEW KEYDATES

	INSERT INTO KeyDatesType
	SELECT 'Date of Litigation (Litigated post outsource cases only)', 'DTELITPOST',0,'SMJ',GETDATE(),NULL

--4. INSERT NEW MI Lookups


	INSERT INTO MILookupFieldDefinition SELECT 'CLAIINF','Y','Yes','Yes','AVIVACLAIM',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'CLAIINF','N','No','No','AVIVACLAIM',0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition SELECT 'PERPAYORD','Y','Yes','Yes','AVIVACLAIM',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'PERPAYORD','N','No','No','AVIVACLAIM',0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition SELECT 'INCSTPBLM','Y','Yes','Yes','AVIVACLAIM',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'INCSTPBLM','N','No','No','AVIVACLAIM',0, GETDATE(), 'SMJ'


--5. INSERT NEW MI FIELD DEFS

	INSERT INTO MIFieldDefinition SELECT 'DTELITPOST', 'MIDTEINP', 'Date of Litigation (Litigated post outsource cases only)', NULL, 'CaseKeyDates_Date', 'CaseKeyDates', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'CLAIINF', 'MILKP', 'Is Claimant an Infant?',  'CLAIINF', 'MIClaimantDetails_IsInfant', 'MIClaimantDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'TPCCPT47', 'MIMONEY', 'TP Costs Claimed - Pt 47 assessment', NULL, 'Costs_PPt47AssClmd', 'Costs', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'PERPAYORD', 'MILKP', 'Periodic Payment Order',  'PERPAYORD', 'MIClaimantDetails_PerPayOrd', 'MIClaimantDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'TPCCINT', 'MIMONEY', 'TP Costs Claimed - Interest', NULL, 'Costs_PInterestClmd', 'Costs', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'TPCAGRPT47', 'MIMONEY', 'TP Costs Agreed - Pt 47 assessment', NULL, 'Costs_TPCstAgrdPt47', 'Costs', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'INCSTPBLM', 'MILKP', 'Interim costs Paid out by BLM',  'INCSTPBLM', 'MIClaimantDetails_IntCstPdBLM', 'MIClaimantDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'TPCAGRINT', 'MIMONEY', 'TP Costs Agreed - Interest', NULL, 'Costs_TPCstAgrdInt', 'Costs', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'FINAGRCARE', 'MIMONEY', 'Agreed Care', NULL, 'Financial_AgrdCare', 'Financial', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'AGROTHNINJ', 'MIMONEY', 'Agreed Other Non Injury', NULL, 'Financial_AgrdOthNonInj', 'Financial', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'FRTPBIRES', 'MIMONEY', 'TPBI Reserve (Gross of Payments)', NULL, 'FinancialReserve_GeneralDamagesGross', 'FinancialReserve', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'FRTPPDRES', 'MIMONEY', 'TPPD Reserve (Gross of Payments)', NULL, 'FinancialReserve_SpecialDamagesGross', 'FinancialReserve', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'FRTPCRGRS', 'MIMONEY', 'TP Costs Reserve (Gross of Payments)', NULL, 'FinancialReserve_TPSCostGross', 'FinancialReserve', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'FROWNCRES', 'MIMONEY', 'Own Costs Reserve (Gross of Payments)', NULL, 'FinancialReserve_BLMCostResGross', 'FinancialReserve', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'CLRESTAOTH', 'MITEXT', 'Reason for Status ''Other''', NULL, 'MIClaimantDetails_ReasStatOth', 'MIClaimantDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'CRUAPPEAL', 'MILKP', 'CRU Appeal',  'CRUAPPEAL', 'MIClaimantDetails_CRUApp', 'MIClaimantDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'REAEXCOL', 'MILKP', 'Reason for exceeding Colossus',  'REAEXCOL', 'ManagementInformation_ColossusExReason', 'ManagementInformation', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'TRIOUTCOME', 'MILKP', 'Trial Outcome',  'TRIOUTCOME', 'ManagementInformation_TrialOutcome', 'ManagementInformation', NULL, 0, GETDATE(), 'SMJ', 0

	


--6. CREATE THE SET

	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','ClmDOB',1,'Claimant DoB:',1, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','CLAIINF',2,'Is Claimant an Infant?:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','AZCLCSF',3,'Claimant Solicitor Firm Name:',1, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','MICFIELD05',4,'Costs Draftperson Ref:',1, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','LBLBLNK',5,'Aviva - Claimant Reserve',1, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','CurrResDam',6,'Current Damages Reserve:',1, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','MICFIELD76',7,'Current Own Costs Reserve:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','CurrResTot',8,'Current Total Reserve:',1, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','CurrResTPC',9,'Current TP Costs Reserve:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','RALDAMAGES',10,'Current TPBI Reserve:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','IALDAMAGES',11,'Current TPPD Reserve:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','BLANK',12,'BLANK:12',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','FROWNCRES',13,'Own Costs Reserve (Gross of Payments):',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','FRTPCRGRS',14,'TP Costs Reserve (Gross of Payments):',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','FRTPBIRES',15,'TPBI Reserve (Gross of Payments):',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','FRTPPDRES',16,'TPPD Reserve (Gross of Payments):',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','LBLBLNK',17,'Aviva - Claimant Costs Claimed:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','MICFIELD15',18,'TP Costs Claimed - ATE Insurance:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','MICFIELD14',19,'TP Costs Claimed - Disbursements:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','TPCCINT',20,'TP Costs Claimed - Interest:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','CSTPRFCSTS',21,'TP Costs Claimed - Profit Costs:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','TPCCPT47',22,'TP Costs Claimed - Pt 47 assessment:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','MICFIELD16',23,'TP Costs Claimed - Success Fee (Value):',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','AZCLTTPCC',24,'TP Costs Claimed Total:',1, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','LBLBLNK',25,'Aviva - Agreed Damages',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','AZCLDDS',26,'Date Damages Agreed (or went away if Repudiation or similar):',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','AZCLGDP',27,'Agreed General Damages:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','AZCLSDPCH',28,'Agreed Credit Hire:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','FINAGRCARE',29,'Agreed Care:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','AZCLSDPPD',30,'Agreed Loss of Earnings:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','AZCLSDPCRU',31,'Agreed CRU (ignoring any appeal):',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','AZCLSDPNH',32,'Agreed NHS:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','AZCLSDPPD',33,'Agreed TP Property Damage:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','AGROTHNINJ',34,'Agreed Other Non Injury:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','AZCLSDP',35,'Agreed Special Damages (ex Itemised):',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','AZCLTPD',36,'Agreed Total Special Damages:',1, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','AZCLTPD',37,'Agreed Total Damages:',1, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','LBLBLNK',38,'Aviva - Claimant Costs Agreed',1, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','AZCLDCS',39,'Date Costs Agreed (or went away if Repudiation or similar):',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','TPCAGRPT47',40,'TP Costs Agreed - Pt 47 assessment:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','MICFIELD25',41,'TP Costs Agreed - Profit Costs:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','MICFIELD26',42,'TP Costs Agreed - Disbursements:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','MICFIELD27',43,'TP Costs Agreed - ATE Insurance:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','MICFIELD28',44,'TP Costs Agreed - Success Fee (Value):',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','TPCAGRINT',45,'TP Costs Agreed - Interest:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','AZCLTTPCP',46,'TP Costs Agreed Total:',1, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','BLANK',47,'BLANK:47',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','BLANK',48,'BLANK:48',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','LBLBLNK',49,'Aviva - Other Finacial',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','AZCLDR',50,'Damages Recovered:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','AZCLCR',51,'Costs Recovered:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','OSSUSVALUE',52,'Colossus High:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','RAUDSAVING',53,'Fraud Saving:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','LBLBLNK',54,'Aviva - Claimant General MI',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','PERPAYORD',55,'Periodic Payment Order:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','REAEXCOL',56,'Reason for exceeding Colossus:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','CCESSREASN',57,'Reason for Successes:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','AZCLMOS',58,'Settlement Status:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','CLRESTAOTH',59,'Reason for Status ''Other'':',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','BLANK',60,'BLANK:60',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','CRUAPPEAL',61,'CRU Appeal:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','INCSTPBLM',62,'Interim costs Paid out by BLM:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','TSRESOURCE',63,'Costs dealt with by other party (not BLM):',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','TRIOUTCOME',64,'Trial Outcome:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','DTELITPOST',65,'Date of Litigation (Litigated post outsource cases only):',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','BLANK',66,'BLANK:66',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','BLANK',67,'BLANK:67',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','BLANK',68,'BLANK:68',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','BLANK',69,'BLANK:69',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','BLANK',70,'BLANK:70',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','BLANK',71,'BLANK:71',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVACLAIM','BLANK',72,'BLANK:72',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
