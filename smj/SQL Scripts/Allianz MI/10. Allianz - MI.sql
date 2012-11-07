--Insert group
  	INSERT INTO [ClientGroup]
  	SELECT 'Allianz'

--Insert ClientRules
	INSERT INTO [ClientRuleDefinitionInClientGroup]
	SELECT	DISTINCT 16, 
		[ClientRuleDefinitionInClientGroup_ClientRuleDefinitionCode],
		0,
		GETDATE(),
		'SMJ'
	FROM	[ClientRuleDefinitionInClientGroup]

--1. INSERT NEW SET INTO ClientMIDefinition

  	/* MATTER MI */
  	INSERT INTO ClientMIDefinition
  	SELECT NULL, 'AZ', NULL, 'AZ', 'ALLIANZ', 0, 'SMJ', GETDATE(), NULL, 0


  	/* Claimant MI */
	INSERT INTO ClientMIDefinition
  	SELECT NULL, 'AZ', 'CLAIM', 'AZ-CLAIM', 'ALLIANZ', 0, 'SMJ', GETDATE(), NULL, 0


--2. INSERT CLIENT PANELS

  	/* MATTER MI */
	--PAGE 1
	INSERT INTO ClientMIPanels
	SELECT 'AZ',1,1,'Allianz Dates (For Info Purposes Only)',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'AZ',2,1,'Allianz - General MI',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'AZ-FR',3,1,'Allianz - Reserve',0,GETDATE(), 'SMJ'

	--PAGE 2
	INSERT INTO ClientMIPanels
	SELECT 'AZ-FR',1,2,'Allianz - Credit Hire',0,GETDATE(), 'SMJ'
	
	INSERT INTO ClientMIPanels
	SELECT 'AZ-FR',2,2,'Allianz - Credit Hire (Cont)',0,GETDATE(), 'SMJ'  



  	/* Claimant MI */
  	--PAGE 1
	INSERT INTO ClientMIPanels
	SELECT 'AZ-FRCLAIM',1,1,'Allianz Claimant Specific MI',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'AZ-FRCLAIM',2,1,'  ',0,GETDATE(), 'SMJ'

/* IGNORE THIS SECTION
--3. INSERT NEW KEYDATETYPES

	INSERT INTO KeyDatesType
	SELECT 'Date of Final Bill', 'DTEFINBILL',0,'SMJ',GETDATE(),NULL

	INSERT INTO KeyDatesType
	SELECT 'Date Final Bill Paid', 'DTEFBPAID',0,'SMJ',GETDATE(),NULL

	INSERT INTO KeyDatesType
	SELECT 'Date of First Time Posting', 'DTEFSTPST',0,'SMJ',GETDATE(),NULL
*/

--4. ADD NEW LOOKUPS

	--ALLIANZ CATEGORY - AZCat
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZCat', 'CH', 'Credit Hire', 'Credit Hire', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZCat', 'DIS', 'Disease', 'Disease', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZCat', 'EPFR', 'EL/PL Fraud', 'EL/PL Fraud', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZCat', 'EPPI', 'EL/PL Personal Injury (Excl. Disease)', 'EL/PL Personal Injury (Excl. Disease)', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZCat', 'MFR', 'Motor Fraud', 'Motor Fraud', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZCat', 'MNPI', 'Motor Non PI (Excl. Credit Hire)', 'Motor Non PI (Excl. Credit Hire)', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZCat', 'MPI', 'Motor PI (Excl. Credit Hire)', 'Motor PI (Excl. Credit Hire)', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZCat', 'OTH', 'Other', 'Other', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZCat', 'PDPL', 'PL Property Damage & Product Liability', 'PL Property Damage & Product Liability', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZCat', 'PROP', 'Property', 'Property', 'ALLIANZ', 0, GETDATE(), 'SMJ'	


	--ALLIANZ TYPE - AZType
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZType', 'FAS', 'Fast Track', 'Fast Track', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZType', 'MOJ3', 'MoJ Stage 3 Oral Hearing', 'MoJ Stage 3 Oral Hearing', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZType', 'MUL', 'Multi Track', 'Multi Track', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZType', 'OTH', 'Other', 'Other', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZType', 'OUT', 'Outsource', 'Outsource', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZType', 'PRE', 'Pre litigation', 'Pre litigation', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZType', 'SML', 'Small Track', 'Small Track', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	
	--ALLIANZ VALUE BAND - AZValBnd
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZValBnd', 'A2', 'Less than £1000', 'Less than £1000', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZValBnd', 'B2', '£1,000 to £25,000', '£1,000 to £25,000', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZValBnd', 'C2', '£25,001 to £100,000', '£25,001 to £100,000', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZValBnd', 'D2', '£100,001 to £500,000', '£100,001 to £500,000', 'ALLIANZ', 0, GETDATE(), 'SMJ'
		
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZValBnd', 'E2', 'More than £500,000', 'More than £500,000', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	
	--ROOT CAUSE ANALYSIS - AZRtCsAn
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZRtCsAn', '0001', 'Allianz Breached Protocol', 'Allianz Breached Protocol', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZRtCsAn', '0002', 'Liability Dispute - Allianz Position Realistic', 'Liability Dispute - Allianz Position Realistic', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZRtCsAn', '0003', 'Liability Dispute - Allianz Position Unrealistic', 'Liability Dispute - Allianz Position Unrealistic', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZRtCsAn', '0004', 'Allianz Failure To Make Any Offer', 'Allianz Failure To Make Any Offer', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZRtCsAn', '0005', 'Quantum Dispute - Allianz Position Realistic', 'Quantum Dispute - Allianz Position Realistic', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZRtCsAn', '0006', 'Quantum Dispute - Allianz Position Unrealistic', 'Quantum Dispute - Allianz Position Unrealistic', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZRtCsAn', '0007', 'Limitation', 'Limitation', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZRtCsAn', '0008', 'Costs Only', 'Costs Only', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZRtCsAn', '0009', 'Approval Hearing', 'Approval Hearing', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZRtCsAn', '0010', 'Prosecution', 'Prosecution', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZRtCsAn', '0011', 'Other', 'Other', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZRtCsAn', '0012', 'Fraud', 'Fraud', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZRtCsAn', '0013', 'Unreasonable Claimant Conduct / Premature Issue', 'Unreasonable Claimant Conduct / Premature Issue', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	
	--MoJ Status - AZMoJSta
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZMoJSta', 'ESC', 'Claim Commenced under MoJ and escaped', 'Claim Commenced under MoJ and escaped', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZMoJSta', 'NEV', 'Never MoJ', 'Never MoJ', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZMoJSta', 'PRO', 'Claim Currently in MoJ Process', 'Claim Currently in MoJ Process', 'ALLIANZ', 0, GETDATE(), 'SMJ'	


	--MoJ Escape Reason - AZMoJEsc		
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZMoJEsc', '0001', 'Not Applicable', 'Not Applicable', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZMoJEsc', '0002', 'Denial of Liability', 'Denial of Liability', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZMoJEsc', '0003', 'Allegation of Contributory negligence', 'Allegation of Contributory negligence', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZMoJEsc', '0004', 'Failure to respond with 15 days on Liability', 'Failure to respond with 15 days on Liability', 'ALLIANZ', 0, GETDATE(), 'SMJ'			

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZMoJEsc', '0005', 'Failure to pay stg1 fixed costs w/i 10dy', 'Failure to pay stg1 fixed costs w/i 10dy', 'ALLIANZ', 0, GETDATE(), 'SMJ'	

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZMoJEsc', '0006', 'Failure to respond-claimants offer - 15d', 'Failure to respond-claimants offer - 15d', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZMoJEsc', '0007', 'Failure to make an interim payment', 'Failure to make an interim payment', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZMoJEsc', '0008', 'Failure to pay Stg2 fixed costs w/i 10dy', 'Failure to pay Stg2 fixed costs w/i 10dy', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZMoJEsc', '0009', 'Allegation of Fraud', 'Allegation of Fraud', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZMoJEsc', '0010', 'Unsuitable for the process', 'Unsuitable for the process', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZMoJEsc', '0011', 'Quantum found to exceed MoJ limit', 'Quantum found to exceed MoJ limit', 'ALLIANZ', 0, GETDATE(), 'SMJ'					
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZMoJEsc', '0012', 'Minor - Interim Payment', 'Minor - Interim Payment', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZMoJEsc', '0013', 'Premature issue', 'Premature issue', 'ALLIANZ', 0, GETDATE(), 'SMJ'


	--MODE OF SETTLEMENT - AZModSet			
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZModSet', 'MSET0001', 'Claim discontinued ', 'Claim discontinued ', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZModSet', 'MSET0002', 'Drop hands offer agreed', 'Drop hands offer agreed', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZModSet', 'MSET0003', 'Costs inclusive offer agreed', 'Costs inclusive offer agreed', 'ALLIANZ', 0, GETDATE(), 'SMJ'		

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZModSet', 'MSET0004', 'Part 36 offer accepted', 'Part 36 offer accepted', 'ALLIANZ', 0, GETDATE(), 'SMJ'	
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZModSet', 'MSET0005', 'Trial / Hearing: Won - limitation', 'Trial / Hearing: Won - limitation', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZModSet', 'MSET0006', 'Trial / Hearing: Won - causation', 'Trial / Hearing: Won - causation', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZModSet', 'MSET0007', 'Trial / Hearing: Won - quantum', 'Trial / Hearing: Won - quantum', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZModSet', 'MSET0008', 'Trial / Hearing: Lost - limitation', 'Trial / Hearing: Lost - limitation', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZModSet', 'MSET0009', 'Trial / Hearing: Lost - causation', 'Trial / Hearing: Lost - causation', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZModSet', 'MSET0010', 'Trial / Hearing: Lost - quantum', 'Trial / Hearing: Lost - quantum', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZModSet', 'MSET0011', 'Appeal: Won - limitation', 'Appeal: Won - limitation', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZModSet', 'MSET0012', 'Appeal: Won - causation', 'Appeal: Won - causation', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZModSet', 'MSET0013', 'Appeal: Won - quantum', 'Appeal: Won - quantum', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZModSet', 'MSET0014', 'Appeal: Lost - limitation', 'Appeal: Lost - limitation', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZModSet', 'MSET0015', 'Appeal: Lost - causation', 'Appeal: Lost - causation', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZModSet', 'MSET0016', 'Appeal: Lost - quantum', 'Appeal: Lost - quantum', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	
	--SPOT HIRE ARGUMENT SUCCESSFUL - AZSpHrSc
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZSpHrSc', 'SPHIRE0001', 'Yes', 'Yes', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZSpHrSc', 'SPHIRE0002', 'No', 'No', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZSpHrSc', 'SPHIRE0003', 'N/A', 'N/A', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	
	--NON-STANDARD DRIVER - AZNonStd
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZNonStd', 'NSDYES', 'Yes', 'Yes', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZNonStd', 'NSDNO', 'No', 'Yes', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZNonStd', 'NSDNK', 'Not Known', 'Not Known', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	--TRIAL REQUIRED - AZTrlReq
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZTrlReq', 'TRLREQYES', 'Yes', 'Yes', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZTrlReq', 'TRLREQNO', 'No', 'No', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	
	--SETTLEMENT REASON - AZSettRs
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZSettRs', 'SRDISC', 'Discontinued', 'Discontinued', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZSettRs', 'SRNEG', 'Negotiation', 'Negotiation', 'ALLIANZ', 0, GETDATE(), 'SMJ'	

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZSettRs', 'SRTRWON', 'Trial Won', 'Trial Won', 'ALLIANZ', 0, GETDATE(), 'SMJ'	

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZSettRs', 'SRTRLOST', 'Trial Lost', 'Trial Lost', 'ALLIANZ', 0, GETDATE(), 'SMJ'	

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZSettRs', 'SRJUDSUMPD', 'Judgment Sum Paid', 'Judgment Sum Paid', 'ALLIANZ', 0, GETDATE(), 'SMJ'	

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZSettRs', 'SRRETCLI', 'Returned to Client', 'Returned to Client', 'ALLIANZ', 0, GETDATE(), 'SMJ'


	
	--CLAIMANT IMPERCUNIOUS
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZClaImp', 'CLAIMPYES', 'Yes', 'Yes', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZClaImp', 'CLAIMPNO', 'No', 'No', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZClaImp', 'CLAIMPNA', 'Not Known', 'Not Known', 'ALLIANZ', 0, GETDATE(), 'SMJ' 
	

	--RATE EVIDENCE OBTAINED - AZRtEvOb
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZRtEvOb', 'REOOWNEV', 'Own Evidence', 'Own Evidence', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZRtEvOb', 'REONEGSETT', 'Negotiated settlement', 'Negotiated settlement', 'ALLIANZ', 0, GETDATE(), 'SMJ'	

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZRtEvOb', 'REOEXEV', 'External Evidence', 'External Evidence', 'ALLIANZ', 0, GETDATE(), 'SMJ'	

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZRtEvOb', 'REOAUTOFOC', 'Autofocus', 'Autofocus', 'ALLIANZ', 0, GETDATE(), 'SMJ'


	--PRIMARY REASON FOR REDUCTION - AZPrRsRd
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZPrRsRd', 'PRRPERIOD', 'Period', 'Period', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZPrRsRd', 'PRRRATE', 'Rate', 'Rate', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZPrRsRd', 'PRRNEED', 'Need', 'Need', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZPrRsRd', 'PRRGENFAIL', 'General Failure to Mitigate', 'General Failure to Mitigate', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZPrRsRd', 'PRRCLAIVAT', 'Claimant was VAT registered', 'Claimant was VAT registered', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZPrRsRd', 'PRRENFORCE', 'Enforceability', 'Enforceability', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZPrRsRd', 'PRRLIAB', 'Liability', 'Liability', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZPrRsRd', 'PRREXNTALL', 'Additional extras not allowed in full', 'Additional extras not allowed in full', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZPrRsRd', 'PRRIMPCALC', 'Invoice improperly calculated', 'Invoice improperly calculated', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZPrRsRd', 'PRROTHER', 'Other', 'Other', 'ALLIANZ', 0, GETDATE(), 'SMJ'	


	--SECONDARY REASON FOR REDUCTION - AZSrRsRd	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZSrRsRd', 'SRRPERIOD', 'Period', 'Period', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZSrRsRd', 'SRRRATE', 'Rate', 'Rate', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZSrRsRd', 'SRRNEED', 'Need', 'Need', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZSrRsRd', 'SRRGENFAIL', 'General Failure to Mitigate', 'General Failure to Mitigate', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZSrRsRd', 'SRRCLAIVAT', 'Claimant was VAT registered', 'Claimant was VAT registered', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZSrRsRd', 'SRRENFORCE', 'Enforceability', 'Enforceability', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZSrRsRd', 'SRRLIAB', 'Liability', 'Liability', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZSrRsRd', 'SRREXNTALL', 'Additional extras not allowed in full', 'Additional extras not allowed in full', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZSrRsRd', 'SRRIMPCALC', 'Invoice improperly calculated', 'Invoice improperly calculated', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZSrRsRd', 'SRROTHER', 'Other', 'Other', 'ALLIANZ', 0, GETDATE(), 'SMJ'	

	--SPLIT LIABILITY
	INSERT INTO MILookupFielYdDefinition
	SELECT 'AZCLSLRD', 'SLRDES', 'Yes', 'Yes', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZCLSLRD', 'SLRDNO', 'No', 'No', 'ALLIANZ', 0, GETDATE(), 'SMJ'	

	--CONTRIB NEG
	INSERT INTO MILookupFieldDefinition
	SELECT 'AZCLCN', 'CNYES', 'Yes', 'Yes', 'ALLIANZ', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'AZCLCN', 'CNNO', 'No', 'No', 'ALLIANZ', 0, GETDATE(), 'SMJ'
	
	
--5. ADD NEW MIFIELDDEFINITIONS
--DELETE FROM MIFieldDefinition WHERE MIFieldDefinition_MIFieldDefinitionID > 1377

	/* MATTER MI */
/*IGNORE FOR TIME BEING
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('DteFinBill', 'MIDTEINP', 'Date of Final Bill', '', 'CaseKeyDates_Date', 'CaseKeydates', 'DTEFINBILL', 0, GETDATE(), 'SMJ', 0)

	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('DteFinBillPd', 'MIDTEINP', 'Date Final Bill Paid', '', 'CaseKeyDates_Date', 'CaseKeydates', 'DTEFBPAID', 0, GETDATE(), 'SMJ', 0)

	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('DteFstTmePst', 'MIDTEINP', 'Date of First Time Posting', '', 'CaseKeyDates_Date', 'CaseKeydates', 'DTEFSTPST', 0, GETDATE(), 'SMJ', 0)

	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('BLMCstsBill', 'MIMONEY', 'BLM Costs Billed', '', '', '', NULL, 0, GETDATE(), 'SMJ', 0)

	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('BLMPrfCstBlld', 'MIMONEY', 'BLM Profit Costs Billed', '', '', '', NULL, 0, GETDATE(), 'SMJ', 0)

	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('CCFABlld', 'MIMONEY', 'CCFA Billed', '', '', '', NULL, 0, GETDATE(), 'SMJ', 0)

	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('CycTmeFBPd', 'MIINT', 'Cycle Time (FB Paid)', '', '', '', NULL, 0, GETDATE(), 'SMJ', 0)

*/

	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('TotCstsPd',	'MIMONEY',	'Total Costs Paid', '',	'ManagementInformation_TotCostsPd',	'ManagementInformation',NULL,0, GETDATE(), 'SMJ', 0)

	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('MOJSTAT',	'MILKP',	'MoJ Status',	'AZMoJSta',	'AZ_MOJ_STATUS','_HBM_MATTER_USR_DATA',NULL, 0, GETDATE(), 'SMJ', 0)

	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZMoJEsc',	'MILKP',	'Reason for MoJ Escape','AZMoJEsc',	'AZ_MOJ_ESCAPE_REASON',	'_HBM_MATTER_USR_DATA',	NULL,0, GETDATE(), 'SMJ', 0)

	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('CycTmeFBPd',	'MIINT',	'Cycle Time (FB Paid)','', 'ManagementInformation_CycleTime',	'ManagementInformation',NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZOffice',	'MITEXT',	'Allianz Office','', 'Instr_AZ_Office','vewAderantEXPMI_AZOffice',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCat',	'MILKP',	'Allianz Category (Work Type)',	'AZCat',	'ALLIANZ_CATEGORY',	'_HBM_MATTER_USR_DATA',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZType',	'MILKP',	'Allianz Type (Track)	AZType', 'ALLIANZ_C_TYPE',	'_HBM_MATTER_USR_DATA',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZValBnd',	'MILKP',	'Allianz Value Band',	'AZValBnd', 'ALLIANZ_C_VAL_BAND_2',	'_HBM_MATTER_USR_DATA',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZRtCsAn',	'MILKP',	'Root Cause (Referral Reason)',	'AZRtCsAn',	'ALLIANCE_C_ROOT_CAUSE', '_HBM_MATTER_USR_DATA',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('OthBLMMatLnk', 'MITEXT',	'Other BLM Matter Linked','','LINKED_BLM_CASE',	'_HBM_MATTER_USR_DATA',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('CliOriRes', 'MIMONEY',	'Client''s Original Reserve','','CLIENT_NOT_RESERVE', '_HBM_MATTER_USR_DATA',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('SDRPropDam', 'MIMONEY',	'Special Damages Reserve - Property Damage','', 'FinancialReserve_SpecialDamagesProp',	'FinancialReserve',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('SDRCredHire', 'MIMONEY',	'Special Damages Reserve - Credit Hire','', 'FinancialReserve_CredHire',	'FinancialReserve',NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('TotSDR', 'MIMONEY',	'Total Special Damages Reserve','', 'ManagementInformation_TotSpecDamRes',	'ManagementInformation',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZGrpCar', 'MITEXT',	'Group of Car Hired','', 'ManagementInformation_CarHireGroup',	'ManagementInformation',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZClaImp', 'MILKP',	'Claimant Impercunious', 'AZClaImp',	'ManagementInformation_ClaiImp',	'ManagementInformation',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZSpHrSc', 'MILKP',	'Spot Hire Argument Successful',	'AZSpHrSc',	'ManagementInformation_SpHrSc',	'ManagementInformation',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZNonStd',	'MILKP',	'Non-standard Driver', 'AZNonStd',	'ManagementInformation_NonStdDrv',	'ManagementInformation',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZTrlReq',	'MILKP',	'Trial Required', 'AZTrlReq',	'ManagementInformation_CsTknTrl',	'ManagementInformation',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZSettRs',	'MILKP',	'Settlement Reason', 'AZSettRs',	'ManagementInformation_SettlemntReasn',	'ManagementInformation',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZRtEvOb',	'MILKP',	'Rate Evidence Obtained', 'AZRtEvOb',	'ManagementInformation_RateEvidObtnd',	'ManagementInformation',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZPrRsRd',	'MILKP',	'Primary Reason for Reduction', 'AZPrRsRd',	'ManagementInformation_ReductionReason',	'ManagementInformation'	,NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZSrRsRd', 'MILKP',	'Secondary Reason for Reduction', 'AZSrRsRd',	'ManagementInformation_ReductionReason2',	'ManagementInformation',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	
	/* CLAIMANT MI */
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLCSO', 'MITEXT',	'Claimant Solicitor Office','', 'MIClaimantDetails_ClaimantSolicitorOffice',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLDDS', 'MIDTEINP',	'Date Damages Settled','',		'MIClaimantDetails_DamagesSettledDate',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLDCS', 'MIDTEINP',	'Date Costs Settled','',		'MIClaimantDetails_CostsSettledDate',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLMOS', 'MILKP',	'Mode of Settlement (Result Method)',	'AZModSet',	'MIClaimantDetails_ModeOfSettlement',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLGDP', 'MIMONEY',	'General Damages Paid','',		'MIClaimantDetails_GeneralDamagesPaid',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLSDP', 'MIMONEY',	'Special Damages Paid (excluding CRU/NHS,Credit Hire and Property Damage)','',		'MIClaimantDetails_SpecialDamagesPaidExcluding',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLSDPCRU','MIMONEY',	'Special Damages Paid - CRU','',		'MIClaimantDetails_SpecialDamagesPaidCRU',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLSDPNH', 'MIMONEY',	'Special Damages Paid - NHS','',		'MIClaimantDetails_SpecialDamagesPaidNHS',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLSDPAMB', 'MIMONEY',	'Special Damages Paid - Ambulance','',		'MIClaimantDetails_SpecialDamagesPaidAmb',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLSDPPD', 'MIMONEY',	'Special Damages Paid - Property Damage','',		'MIClaimantDetails_SpecialDamagesPaidPropertyDamage',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLSDPCH', 'MIMONEY',	'Special Damages Paid - Credit Hire','',		'MIClaimantDetails_SpecialDamagesPaidCreditHire',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLTSPD', 'MIMONEY',	'Total Special Damages Paid','',		'MIClaimantDetails_TotalSpecialDamagesPaid',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLTPD', 'MIMONEY',	'Total Damages Paid','',		'MIClaimantDetails_TotalDamagesPaid',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLTTPCC', 'MIMONEY',	'Total TP Costs Claimed','',		'MIClaimantDetails_TotalTPCostsClaimed',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLTTPCP', 'MIMONEY',	'Total TP Costs Paid',	'',	'MIClaimantDetails_TotalTPCostsPaid',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLDR', 'MITEXT',	'Damages Recovered','',		'MIClaimantDetails_DamagesRecovered',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLCR', 'MIMONEY',	'Costs Recovered','',		'MIClaimantDetails_CostsRecovered',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLSLRD', 'MILKP',	'Split Liability (with respect to other defendants)',	'AZCLSLRD',	'MIClaimantDetails_SplitLiability',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLPLRD', 'MIMONEY',	'Allianz % Liability (with respect to other defendants)','','MIClaimantDetails_AllianzLiabilityDefendant',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLCN', 'MILKP',	'Contributory Negligence',	'AZCLCN',	'MIClaimantDetails_ContributoryNegligence',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)
	
	INSERT INTO [dbo].[MIFieldDefinition]([MIFieldDefinition_MIFieldCode],[MIFieldDefinition_MIFieldTypeCode],[MIFieldDefinition_FieldDescription],[MIFieldDefinition_MILKPFieldCode],[MIFieldDefinition_DataField],[MIFieldDefinition_DataTable], [MIFieldDefinition_KeyDateType],[MIFieldDefinition_Inactive],[MIFieldDefinition_CreateDate],[MIFieldDefinition_CreateUser],[MIFieldDefinition_AderantField]) 
	VALUES('AZCLPLRCN', 'MIMONEY',	'Allianz % Liability (with respect to contrib neg)','',	'MIClaimantDetails_AllianzLiabilityContribNeg',	'MIClaimantDetails',	NULL,	0, GETDATE(), 'SMJ', 0)--6. ADD NEW CLIENTMIFIELDSET
	----------

--65. ADD NEW CLIENTMIFIELDSET

	/* MATTER MI */
	--P1, PANEL1
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',1,'BLANK-1', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',2,'BLANK-2', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',3,'BLANK-3', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'LBLBLNK',4,'Allianz Financial (For Info Purposes Only)', 1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',5,'BLANK-5', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'TotCstsPd',6,'Total Costs Paid', 1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',7,'BLANK-7', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',8,'BLANK-8', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'LBLBLNK',9,'Allianz MOJ MI', 1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'MOJSTAT',10,'MoJ Status', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'AZMoJEsc',11,'Reason for MoJ Escape', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',12,'BLANK-12', 0, 0, 0, GETDATE(), 'SMJ', NULL

	--P1, PANEL2
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'CycTmeFBPd',13,'Cycle Time (FB Paid)', 1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'AZOffice',14,'Allianz Office', 1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'MIFLD00002',15,'Allianz Reference', 1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'AAAAAAAAAA',16,'Name of Allianz Insured', 1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'AZCat',17,'Allianz Category (Work Type)', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'AZType',18,'Allianz Type (Track)', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'AZValBnd',19,'Allianz Value Band', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'AZRtCsAn',20,'Root Cause (Referral Reason)', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'OthBLMMatLnk',21,'Other BLM Matter Linked', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',22,'BLANK-22', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',23,'BLANK-23', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',24,'BLANK-24', 0, 0, 0, GETDATE(), 'SMJ', NULL

	--P1, PANEL3
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'CliOriRes',25,'Client''s Original Reserve', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'IALDAMAGES',26,'Special Damages Reserve', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'ResCRU',27,'Special Damages Reserve - CRU', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'ResNHS',28,'Special Damages Reserve - NHS', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'ResAmb',29,'Special Damages Reserve - Ambulance', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'SDRPropDam',30,'Special Damages Reserve - Property Damage', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'SDRCredHire',31,'Special Damages Reserve - Credit Hire', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'TotSDR',32,'Total Special Damages Reserve', 1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'RALDAMAGES',33,'General Damages Reserve', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'CurrResDam',34,'Total Damages Reserve', 1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'CurrResTPC',35,'TP Costs Reserve', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'MICFIELD76',36,'BLM Costs Reserve', 0, 0, 0, GETDATE(), 'SMJ', NULL

	--P2, PANEL1
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'MICFIELD10',37,'Cycle Time', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'MICFIELD91',38,'Credit Hire Organisation', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'MICFIELD92',39,'Hire Claimed (£)', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'MICFIELD93',40,'Hire Paid (£)', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'DamSet',41,'Date Settlement Concluded', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'HIREPERIOD',42,'Hire Period (days)', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'ESTCLAIMED',43,'Contractual Interest Claimed', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'AZGrpCar',44,'Group of Car Hired', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'AZClaImp',45,'Claimant Impercunious', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'AZSpHrSc',46,'Spot Hire Argument Successful', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'AZNonStd',47,'Non-standard Driver', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'AZTrlReq',48,'Trial Required', 0, 0, 0, GETDATE(), 'SMJ', NULL

	--P2, PANEL2
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'AZSettRs',49,'Settlement Reason', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'AZRtEvOb',50,'Rate Evidence Obtained', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'AZPrRsRd',51,'Primary Reason for Reduction', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'AZSrRsRd',52,'Secondary Reason from Reduction', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',53,'BLANK-53', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',54,'BLANK-54', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',55,'BLANK-55', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',56,'BLANK-56', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',57,'BLANK-57', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',58,'BLANK-58', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',59,'BLANK-59', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',60,'BLANK-60', 0, 0, 0, GETDATE(), 'SMJ', NULL

	--BLANK SPACERS
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',61,'BLANK-61', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',62,'BLANK-62', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',63,'BLANK-63', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',64,'BLANK-64', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',65,'BLANK-65', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',66,'BLANK-66', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',67,'BLANK-67', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',68,'BLANK-68', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',69,'BLANK-69', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',70,'BLANK-70', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',71,'BLANK-71', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZ', 'BLANK',72,'BLANK-72', 0, 0, 0, GETDATE(), 'SMJ', NULL
	------------

	/* CLAIMANT MI */
	--P1, PANEL1
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'MIFLD00003',1,'Claimant Solicitor Firm', 1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLCSO',2,'Claimant Solicitor Office', 1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLDDS',3,'Date Damages Settled', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLDCS',4,'Date Costs Settled', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLMOS',5,'Mode of Settlement (Result Method)', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLGDP',6,'General Damages Paid', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLSDP',7,'Special Damages Paid', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLSDPCRU',8,'Special Damages Paid - CRU', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLSDPNH',9,'Special Damages Paid - NHS', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLSDPAMB',10,'Special Damages Paid - Ambulance', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLSDPPD',11,'Special Damages Paid - Property Damage', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLSDPCH',12,'Special Damages Paid - Credit Hire', 0, 0, 0, GETDATE(), 'SMJ', NULL

	--P1, PANEL2
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'LBLBLNK',13,' ', 1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLTSPD',14,'Total Special Damages Paid', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLTPD',15,'Total Damages Paid', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLTTPCC',16,'Total TP Costs Claimed', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLTTPCP',17,'Total TP Costs Paid', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLDR',18,'Damages Recovered', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLCR',19,'Costs Recovered', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLSLRD',20,'Split Liability (with respect to other defendants)', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLPLRD',21,'Allianz % Liability (with respect to other defendants)', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLCN',22,'Contributory Negligence', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'AZCLPLRCN',23,'Allianz % Liability (with respect to contrib neg)', 0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'AZCLAIM', 'BLANK',24,'BLANK-24', 1, 0, 0, GETDATE(), 'SMJ', NULL	















