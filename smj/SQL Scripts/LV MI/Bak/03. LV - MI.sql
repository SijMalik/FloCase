--Insert group
  	INSERT INTO [ClientGroup]
  	SELECT 'LV'

--Insert ClientRules
	INSERT INTO [ClientRuleDefinitionInClientGroup]
	SELECT	DISTINCT 17, 
		[ClientRuleDefinitionInClientGroup_ClientRuleDefinitionCode],
		0,
		GETDATE(),
		'SMJ'
	FROM	[ClientRuleDefinitionInClientGroup]

--1. INSERT NEW SET INTO ClientMIDefinition


  	INSERT INTO ClientMIDefinition
  	SELECT NULL, 'LV', NULL, 'LV', 'LV', 0, 'SMJ', GETDATE(), NULL


--2. INSERT CLIENT PANELS


	--PAGE 1
	INSERT INTO ClientMIPanels
	SELECT 'LV',1,1,'LV - Case Information',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'LV',2,1,'LV - Case Information (Cont)',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'LV',3,1,'LV - Claimant Information',0,GETDATE(), 'SMJ'

	--PAGE 2
	INSERT INTO ClientMIPanels
	SELECT 'LV',1,2,'LV - Reserve',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'LV',2,2,'LV - Reserve (Cont)',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'LV',3,2,'LV - Judgement',0,GETDATE(), 'SMJ'

	--PAGE 3
	INSERT INTO ClientMIPanels
	SELECT 'LV',1,3,'LV - Claimed',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'LV',2,3,'LV - Claimed (Cont)',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'LV',3,3,'LV - Settlement',0,GETDATE(), 'SMJ'

	--PAGE 4
	INSERT INTO ClientMIPanels
	SELECT 'LV',1,4,'LV - Financial Settlement',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'LV',2,4,'LV - Financial Settlement (Cont)',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'LV',3,4,'',0,GETDATE(), 'SMJ'



--3. INSERT NEW KEYDATETYPES

	INSERT INTO KeyDatesType
	SELECT 'Date of Proceedings', 'DTEPROC',0,'SMJ',GETDATE(),NULL

	INSERT INTO KeyDatesType
	SELECT 'Date Acknowledgement Due', 'DTEACKDUE',0,'SMJ',GETDATE(),NULL

	INSERT INTO KeyDatesType
	SELECT 'Date of Instruction', 'DTEINSTR',0,'SMJ',GETDATE(),NULL


	INSERT INTO KeyDatesType
	SELECT 'Date A&S sent to Court', 'DTEASSENT',0,'SMJ',GETDATE(),NULL


	INSERT INTO KeyDatesType
	SELECT 'Date Defence sent to Court', 'DTEDFSENT',0,'SMJ',GETDATE(),NULL


	INSERT INTO KeyDatesType
	SELECT 'Date of Instruction', 'DTEINSTR',0,'SMJ',GETDATE(),NULL


	INSERT INTO KeyDatesType
	SELECT 'Date of Instruction', 'DTEINSTR',0,'SMJ',GETDATE(),NULL


--4. ADD NEW LOOKUPS

	--LV Clamaint or Defendant - LVCLAIDEF
	INSERT INTO MILookupFieldDefinition
	SELECT 'LVCLAIDEF', 'C', 'Claimant', 'Claimant', 'LV', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'LVCLAIDEF', 'D', 'Defendant', 'Defendant', 'LV', 0, GETDATE(), 'SMJ'	


	--LV Avoid Litigation - LVAVOIDLIT
	INSERT INTO MILookupFieldDefinition
	SELECT 'LVAVOIDLIT', 'P', 'Pre Issue', 'Pre Issue', 'LV', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'LVAVOIDLIT', 'Y', 'Yes', 'Yes', 'LV', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'LVAVOIDLIT', 'N', 'No', 'No', 'LV', 0, GETDATE(), 'SMJ'	

	
	--LV Category at Instruction - CATINSTR
	INSERT INTO MILookupFieldDefinition
	SELECT 'CATINSTR', 'M1', 'Multi Track band1 (up to £50k)', 'Multi Track band1 (up to £50k)', 'LV', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'CATINSTR', 'M2', 'Multi Track band2 (£50k-£500k)', 'Multi Track band2 (£50k-£500k)', 'LV', 0, GETDATE(), 'SMJ'
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'CATINSTR', 'M3', 'Multi Track band3 (£500k+)', 'Multi Track band3 (£500k+)', 'LV', 0, GETDATE(), 'SMJ'	
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'CATINSTR', 'F', 'Fast Track', 'Fast Track', 'LV', 0, GETDATE(), 'SMJ'	
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'CATINSTR', 'S', 'Small Claim', 'Small Claim', 'LV', 0, GETDATE(), 'SMJ'	
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'CATINSTR', 'C', 'Costs', 'Costs', 'LV', 0, GETDATE(), 'SMJ'	
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'CATINSTR', 'I', 'Infant Approval', 'Infant Approval', 'LV', 0, GETDATE(), 'SMJ'	
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'CATINSTR', 'MOJ', 'MoJ Stage 3', 'MoJ Stage 3', 'LV', 0, GETDATE(), 'SMJ'	
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'CATINSTR', 'R', 'Recovery', 'Recovery)', 'LV', 0, GETDATE(), 'SMJ'	
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'CATINSTR', 'FR', 'Fraud', 'Fraud', 'LV', 0, GETDATE(), 'SMJ'	
	
	INSERT INTO MILookupFieldDefinition
	SELECT 'CATINSTR', 'CHF', 'Credit Hire Fast Track', 'Credit Hire Fast Track', 'LV', 0, GETDATE(), 'SMJ'									

	INSERT INTO MILookupFieldDefinition
	SELECT 'CATINSTR', 'CHS', 'Credit Hire Small Track', 'Credit Hire Small Track', 'LV', 0, GETDATE(), 'SMJ'									

	INSERT INTO MILookupFieldDefinition
	SELECT 'CATINSTR', 'CHM', 'Credit Hire Multi Track', 'Credit Hire Multi Track', 'LV', 0, GETDATE(), 'SMJ'									

	INSERT INTO MILookupFieldDefinition
	SELECT 'CATINSTR', 'FPCH', 'Fast Track PI Credit Hire', 'Fast Track PI Credit Hire', 'LV', 0, GETDATE(), 'SMJ'									


	--LV Complaint Received - COMPREC
	INSERT INTO MILookupFieldDefinition
	SELECT 'COMPREC', 'Y', 'Yes', 'Yes', 'LV', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'COMPREC', 'N', 'No', 'No', 'LV', 0, GETDATE(), 'SMJ'

	
	--LV Judgement set aside - JUDSETASD
	INSERT INTO MILookupFieldDefinition
	SELECT 'JUDSETASD', 'Y', 'Yes', 'Yes', 'LV', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'JUDSETASD', 'N', 'No', 'No', 'LV', 0, GETDATE(), 'SMJ'


	--LV Limitation - LVLIMIT
	INSERT INTO MILookupFieldDefinition
	SELECT 'LVLIMIT', 'Y', 'Yes', 'Yes', 'LV', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'LVLIMIT', 'N', 'No', 'No', 'LV', 0, GETDATE(), 'SMJ'


	--LV Litigated - LVLIT
	INSERT INTO MILookupFieldDefinition
	SELECT 'LVLIT', 'Y', 'Yes', 'Yes', 'LV', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'LVLIT', 'N', 'No', 'No', 'LV', 0, GETDATE(), 'SMJ'


	--LV Nil Damages - LVNILDAM
	INSERT INTO MILookupFieldDefinition
	SELECT 'LVNILDAM', 'Y', 'Yes', 'Yes', 'LV', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'LVNILDAM', 'N', 'No', 'No', 'LV', 0, GETDATE(), 'SMJ'


	--LV Nil TP Costs - LVNILTP
	INSERT INTO MILookupFieldDefinition
	SELECT 'LVNILTP', 'Y', 'Yes', 'Yes', 'LV', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'LVNILTP', 'N', 'No', 'No', 'LV', 0, GETDATE(), 'SMJ'


	--LV PI Involved - LVPIINV
	INSERT INTO MILookupFieldDefinition
	SELECT 'LVPIINV', 'Y', 'Yes', 'Yes', 'LV', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'LVPIINV', 'N', 'No', 'No', 'LV', 0, GETDATE(), 'SMJ'


	--LV Predicable Costs Claimed - CTABLECSTS
	INSERT INTO MILookupFieldDefinition
	SELECT 'CTABLECSTS', 'Y', 'Yes', 'Yes', 'LV', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'CTABLECSTS', 'N', 'No', 'No', 'LV', 0, GETDATE(), 'SMJ'


	--LV Product - LVPROD
	INSERT INTO MILookupFieldDefinition
	SELECT 'LVPROD', 'MOT', 'Motor', 'Motor', 'LV', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'LVPROD', 'HOM', 'Home', 'Home', 'LV', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'LVPROD', 'COM', 'Commercial', 'Commercial', 'LV', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'LVPROD', 'TRV', 'Travel', 'Travel', 'LV', 0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition
	SELECT 'LVPROD', 'PET', 'Pet', 'Pet', 'LV', 0, GETDATE(), 'SMJ'


	--LVTYPE
	INSERT INTO MILookupFieldDefinition SELECT 'LVType', 'FR ', 'Fraud', 'Fraud', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVType', 'LS', 'LSI', 'LSI', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVType', 'RC', 'Recovery', 'Recovery', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVType', 'CO', 'Costs', 'Costs', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVType', 'MP', 'Motor - PI only', 'Motor - PI only', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVType', 'MC', 'Motor - Credit Hire only', 'Motor - Credit Hire only', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVType', 'MB', 'Motor - PI & Credit Hire', 'Motor - PI & Credit Hire', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVType', 'SU', 'Subsidence', 'Subsidence', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVType', 'PL', 'PL', 'PL', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVType', 'EL', 'EL', 'EL', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVType', 'OT', 'Other', 'Other', 'LV', 0, GETDATE(), 'SMJ'

	--LVSETTPOINT
	INSERT INTO MILookupFieldDefinition SELECT 'LVSETPOINT', 'PL', 'Prelit', 'Prelit', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVSETPOINT', 'D', 'Defence Served', 'Defence Served', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVSETPOINT', 'A', 'Allocation Questionnaire complete', 'Allocation Questionnaire complete', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVSETPOINT', 'P36', 'Pt36 offer', 'Pt36 offer', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVSETPOINT', 'R', 'Request for further information', 'Request for further information', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVSETPOINT', 'T', '21 days before trial', '21 days before trial', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVSETPOINT', 'S', 'Settlement at trial', 'Settlement at trial', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVSETPOINT', 'J', 'Judgement at trial', 'Judgement at trial', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVSETPOINT', 'P47', 'Pt47.19 offer', 'Pt47.19 offer', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVSETPOINT', 'S8', 'Part 8 proceedings settled', 'Part 8 proceedings settled', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVSETPOINT', 'J8', 'Part 8 proceedings resolved at Detailed Assessment', 'Part 8 proceedings resolved at Detailed Assessment', 'LV', 0, GETDATE(), 'SMJ'

	--LVRESMETH
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'DISC', 'Claim discontinued', 'Claim discontinued', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'DROP', 'Drop hands offer agreed', 'Drop hands offer agreed', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'CINC', 'Costs Inclusive offer agreed', 'Costs Inclusive offer agreed', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'PT36', 'Part 36 offer accepted', 'Part 36 offer accepted', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'PT47', 'Part 47.19 offer accepted', 'Part 47.19 offer accepted', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'TWLM', 'Trial / Hearing: Won - limitation', 'Trial / Hearing: Won - limitation', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'TWLI', 'Trial / Hearing: Won - liability', 'Trial / Hearing: Won - liability', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'TWCA', 'Trial / Hearing: Won - causation', 'Trial / Hearing: Won - causation', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'TWQU', 'Trial / Hearing: Won - quantum', 'Trial / Hearing: Won - quantum', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'TLLM', 'Trial / Hearing: Lost - limitation', 'Trial / Hearing: Lost - limitation', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'TLLI', 'Trial / Hearing: Lost - liability', 'Trial / Hearing: Lost - liability', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'TLCA', 'Trial / Hearing: Lost - causation', 'Trial / Hearing: Lost - causation', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'TLQU', 'Trial / Hearing: Lost - quantum', 'Trial / Hearing: Lost - quantum', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'AWLM', 'Appeal: Won - limitation', 'Appeal: Won - limitation', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'AWLI', 'Appeal: Won - liability', 'Appeal: Won - liability', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'AWCA', 'Appeal: Won - causation', 'Appeal: Won - causation', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'AWQU', 'Appeal: Won - quantum', 'Appeal: Won - quantum', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'ALLM', 'Appeal: Lost - limitation', 'Appeal: Lost - limitation', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'ALLI', 'Appeal: Lost - liability', 'Appeal: Lost - liability', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'ALCA', 'Appeal: Lost - causation', 'Appeal: Lost - causation', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVRESMETH', 'ALQU', 'Appeal: Lost – quantum', 'Appeal: Lost – quantum', 'LV', 0, GETDATE(), 'SMJ'

	--LVTRACK
	INSERT INTO MILookupFieldDefinition SELECT 'LVTRACK', '280', 'Small Claims', 'Small Claims', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVTRACK', '220', 'Fast Track', 'Fast Track', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVTRACK', '210A', 'Multi Track (up to £50k)', 'Multi Track (up to £50k)', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVTRACK', '210B', 'Multi Track (£50k-£500k)', 'Multi Track (£50k-£500k)', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVTRACK', '210C', 'Multi Track (£500k+)', 'Multi Track (£500k+)', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVTRACK', '230', 'CPR Part 8', 'CPR Part 8', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVTRACK', '250', 'Recovery - Small Claims', 'Recovery - Small Claims', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVTRACK', '260', 'Recovery - Fast Track', 'Recovery - Fast Track', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVTRACK', '270', 'Recovery - Multi Track', 'Recovery - Multi Track', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVTRACK', '200', 'Other (inc. Inquest / Prosecution)', 'Other (inc. Inquest / Prosecution)', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVTRACK', '290', 'MoJ Stage 3', 'MoJ Stage 3', 'LV', 0, GETDATE(), 'SMJ'

	--LVWRKTYPE
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '0A', 'Advice', 'Advice', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '1A', 'Admin', 'Admin', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '244', 'Costs - Advice', 'Costs - Advice', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '241', 'Costs - Part 7', 'Costs - Part 7', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '242', 'Costs - Part 8', 'Costs - Part 8', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '240', 'Costs - Pre-lit', 'Costs - Pre-lit', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '243', 'Costs - transfer', 'Costs - transfer', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '2A', 'EL/PL', 'EL/PL', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '1B', 'Household', 'Household', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '260', 'Inquest', 'Inquest', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '4A', 'Pet', 'Pet', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '8A', 'Product Liability', 'Product Liability', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '7A', 'Motor - Bent Metal only', 'Motor - Bent Metal only', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '6A', 'Motor - Credit Hire only', 'Motor - Credit Hire only', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '3A', 'Motor - PI + Credit Hire', 'Motor - PI + Credit Hire', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '0C', 'Motor - PI (no credit Hire)', 'Motor - PI (no credit Hire)', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '261', 'Motor - Prosecution', 'Motor - Prosecution', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '5A', 'Travel', 'Travel', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '299', 'Other - None of the other options fit', 'Other - None of the other options fit', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '290', 'Infant Approval', 'Infant Approval', 'LV', 0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'LVWRKTYPE', '262', 'Fraud', 'Fraud', 'LV', 0, GETDATE(), 'SMJ'


	
--5. ADD NEW MIFIELDDEFINITIONS

	INSERT INTO MIFieldDefinition SELECT 'CLIREF', 'MITEXT', 'LV Claim Reference', NULL, 'LVMIDetails_CliRef', 'LVMIDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'CLMHNDLR', 'MITEXT', 'LV Handler', NULL, 'LVMIDetails_ClmHndlr', 'LVMIDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVOFFICE', 'MITEXT', 'LV Office', NULL, 'LVMIDetails_Office', 'LVMIDetails', NULL, 0, GETDATE(), 'SMJ', 1
	INSERT INTO MIFieldDefinition SELECT 'CLCTPCODE', 'MITEXT', 'Insured Postcode', NULL, 'ContactAddress_Postcode', 'ContactAddress', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'CODEFSOL', 'MITEXT', 'Co-Defendant Solicitor', NULL, 'LVMIDetails_CoDefSol', 'LVMIDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'CDFSCNTCT', 'MITEXT', 'Co-Defendant Solicitor Contact', NULL, 'LVMIDetails_CDSCntct', 'LVMIDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVLIT', 'MILKP', 'Litigated?', 'LVLIT', 'LVMIDetails_Lit', 'LVMIDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVAVOIDLIT', 'MILKP', 'Avoidable Litigation?', 'LVAVOIDLIT', 'LV_AVOID_LIT', '_HBM_MATTER_USR_DATA', NULL, 0, GETDATE(), 'SMJ', 1
	INSERT INTO MIFieldDefinition SELECT 'LVREASLIT', 'MILKP', 'Reason for Litigation', 'LVREASLIT', 'LV_REASON_FOR_LIT', '_HBM_MATTER_USR_DATA', NULL, 0, GETDATE(), 'SMJ', 1
	INSERT INTO MIFieldDefinition SELECT 'LVPIINV', 'MILKP', 'PI Involved', 'LVPIINV', 'LV_PI_INVOLVED', '_HBM_MATTER_USR_DATA', NULL, 0, GETDATE(), 'SMJ', 1
	INSERT INTO MIFieldDefinition SELECT 'LVCLAIDEF', 'MILKP', 'Acting as Claimant or Defendant', 'LVCLAIDEF', 'LV_CLAIM_OR_DEF', '_HBM_MATTER_USR_DATA', NULL, 0, GETDATE(), 'SMJ', 1
	INSERT INTO MIFieldDefinition SELECT 'COMPREC', 'MILKP', 'Has a complaint been received?', 'COMPREC', 'LVMIDetails_CompRec', 'LVMIDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVLIMIT', 'MILKP', 'Limitation', 'LVLIMIT', 'LVMIDetails_Limit', 'LVMIDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'BLMLnk', 'MITEXT', 'Other BLM Matter Linked', NULL, 'LINKED_BLM_CASE', '_HBM_MATTER_USR_DATA', NULL, 0, GETDATE(), 'SMJ', 1
	INSERT INTO MIFieldDefinition SELECT 'LVTPINS', 'MITEXT', 'TP Insurer', NULL, 'CaseContacts_SearchName', 'CaseContacts', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'CATINSTR', 'MILKP', 'Category at Instruction', 'CATINSTR', 'LV_CAT_AT_INST', '_HBM_MATTER_USR_DATA', NULL, 0, GETDATE(), 'SMJ', 1
	INSERT INTO MIFieldDefinition SELECT 'MOTCAT', 'MILKP', 'Category at Conclusion', 'MOTCAT', 'ManagementInformation_MtrCtgryInstrctn', 'ManagementInformation', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVPROD', 'MILKP', 'Product', 'LVPROD', 'LV_PRODUCT', '_HBM_MATTER_USR_DATA', NULL, 0, GETDATE(), 'SMJ', 1
	INSERT INTO MIFieldDefinition SELECT 'LVTRACK', 'MILKP', 'Track', 'LVTRACK', 'LV_TRACK', '_HBM_MATTER_USR_DATA', NULL, 0, GETDATE(), 'SMJ', 1
	INSERT INTO MIFieldDefinition SELECT 'LVWRKTYPE', 'MILKP', 'Work Type', 'LVWRKTYPE', 'LV_WORK_TYPE', '_HBM_MATTER_USR_DATA', NULL, 0, GETDATE(), 'SMJ', 1
	INSERT INTO MIFieldDefinition SELECT 'LVTYPE', 'MILKP', 'Type', 'LVTYPE', 'LV_TYPE', '_HBM_MATTER_USR_DATA', NULL, 0, GETDATE(), 'SMJ', 1
	INSERT INTO MIFieldDefinition SELECT 'CLAIMNAME', 'MITEXT', 'Claimant Name', NULL, 'CaseContacts_SearchName', 'CaseContacts', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'NUMCLMNT', 'MITEXT', 'No of Claimant', NULL, 'NUMBER_OF_CLAIMANT', '_HBM_MATTER_USR_DATA', NULL, 0, GETDATE(), 'SMJ', 1
	INSERT INTO MIFieldDefinition SELECT 'NUMCLMNTS', 'MIINT', 'No of Claimants', NULL, 'LV_NO_OF_CLAIMANTS', '_HBM_MATTER_USR_DATA', NULL, 0, GETDATE(), 'SMJ', 1
	INSERT INTO MIFieldDefinition SELECT 'LVCLSO', 'MITEXT', 'Claimant Solicitor', NULL, 'LVMIDetails_CLSO', 'LVMIDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'DTEINSTR', 'MIDTEINP', 'Date of Instruction', NULL, 'DATE_INSTRUCTED', '_HBM_MATTER_USR_DATA', NULL, 0, GETDATE(), 'SMJ', 1
	INSERT INTO MIFieldDefinition SELECT 'DTEACC', 'MIDTEINP', 'Date of Accident', NULL, 'DATE_ACCIDENT_INCIDENT', '_HBM_MATTER_USR_DATA', NULL, 0, GETDATE(), 'SMJ', 1
	INSERT INTO MIFieldDefinition SELECT 'OWNDSBCNS', 'MIMONEY', 'Own Disbursements - Counsel/Experts', NULL, 'FinancialReserve_OwnDisbCounsExp', 'FinancialReserve', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'OWNDSBOTH', 'MIMONEY', 'Own Disbursements - Other', NULL, 'FinancialReserve_OwnDisbOth', 'FinancialReserve', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'RESPRFCSTS', 'MIMONEY', 'Claimants Costs - Profit Costs', NULL, 'FinancialReserve_ProfClaimCost', 'FinancialReserve', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVRESDISB', 'MIMONEY', 'Claimants Costs - Disbursements', NULL, 'FinancialReserve_DisbClaimCost', 'FinancialReserve', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVRESATE', 'MIMONEY', 'Claimants Costs - ATE Premium', NULL, 'FinancialReserve_ATEClaimCost', 'FinancialReserve', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVRESSUCC', 'MIMONEY', 'Claimants Costs - Success Fee', NULL, 'FinancialReserve_SFClaimCost', 'FinancialReserve', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVRESVAT', 'MIMONEY', 'Claimants Costs - VAT', NULL, 'FinancialReserve_VATClaimCost', 'FinancialReserve', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVSDRPRDAM', 'MIMONEY', 'Special Damages - Property Damage', NULL, 'FinancialReserve_SpecialDamagesProp', 'FinancialReserve', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVSDRCH', 'MIMONEY', 'Special Damages - Credit Hire', NULL, 'FinancialReserve_CredHire', 'FinancialReserve', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVSDRSTREC', 'MIMONEY', 'Special Damages - Storage/Recovery', NULL, 'FinancialReserve_StoRec', 'FinancialReserve', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVSDRCARE', 'MIMONEY', 'Special Damages - Care', NULL, 'FinancialReserve_Care', 'FinancialReserve', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVSDRLOE', 'MIMONEY', 'Special Damages - Loss of Earnings', NULL, 'FinancialReserve_LossEarnings', 'FinancialReserve', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVSDROTH', 'MIMONEY', 'Special Damages - Other', NULL, 'FinancialReserve_Other', 'FinancialReserve', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'DTEPROC', 'MIDTEINP', 'Date of Proceedings', NULL, 'CaseKeyDates_Date', 'CaseKeyDates', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'DTEACKDUE', 'MIDTEINP', 'Date Acknowledgement Due', NULL, 'CaseKeyDates_Date', 'CaseKeyDates', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'DTEASSENT', 'MIDTEINP', 'Date A&S sent to Court', NULL, 'CaseKeyDates_Date', 'CaseKeyDates', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'DefDueDate', 'MIDTEINP', 'Date Defence Due', NULL, 'CaseKeyDates_Date', 'CaseKeyDates', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'DTEDFSENT', 'MIDTEINP', 'Date Defence sent to Court', NULL, 'CaseKeyDates_Date', 'CaseKeyDates', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'DateJdgEnt', 'MIDTEINP', 'Date of Judgment', NULL, 'CaseKeyDates_Date', 'CaseKeyDates', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'ACTRESJUD', 'MITEXT', 'Action in response to Judgment', NULL, 'LVMIDetails_ActResJud', 'LVMIDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'PRESPOS', 'MITEXT', 'Present Position (Judgement)', NULL, 'LVMIDetails_PresPos', 'LVMIDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'JUDSETASD', 'MILKP', 'Judgment Set Aside', 'JUDSETASD', 'LVMIDetails_JudSetAsd', 'LVMIDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'GENDAMCLAI', 'MIMONEY', 'General Damages', NULL, 'Financial_GeneralDamagesClmd', 'Financial', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVSDCCRU', 'MIMONEY', 'Special Damages - CRU', NULL, 'Financial_SDCRUClmd', 'Financial', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVSDCNHS', 'MIMONEY', 'Special Damages - NHS', NULL, 'Financial_SDNHSClmd', 'Financial', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVSDCAMB', 'MIMONEY', 'Special Damages - Ambulance', NULL, 'Financial_SDAmbulanceClmd', 'Financial', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVSDCPD', 'MIMONEY', 'Special Damages - Property Damage', NULL, 'Financial_SDPropDamClmd', 'Financial', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVSDCSTREC', 'MIMONEY', 'Special Damages - Storage/Recovery', NULL, 'Financial_SDStoRecClmd', 'Financial', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVSDCCARE', 'MIMONEY', 'Special Damages - Care', NULL, 'Financial_SDCareClmd', 'Financial', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVSDCLOE', 'MIMONEY', 'Special Damages - Loss of Earnings', NULL, 'Financial_SDLOEClmd', 'Financial', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVSDCOTH', 'MIMONEY', 'Special Damages - Other', NULL, 'Financial_SDOthClmd', 'Financial', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVTOTSDCLM', 'MIMONEY', 'Total Special Damages Claimed', NULL, 'Financial_SDTotDamClmd', 'Financial', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVDAMCLMD', 'MIMONEY', 'Total Damages Claimed', NULL, 'Financial_DamagesClmd', 'Financial', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'CSTPRFCSTS', 'MIMONEY', 'Claimants Costs - Profit Costs', NULL, 'Costs_PCSCostsClaimed', 'Costs', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'CLAICOSVAT', 'MIMONEY', 'Claimants Costs - VAT', NULL, 'Costs_VATClaimCost', 'Costs', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'DTESETT', 'MIDTEINP', 'Damages Settlement Date', NULL, 'DATE_OF_SETTLEMENT', '_HBM_MATTER_USR_DATA', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'DTELASTACT', 'MIDTEINP', 'Date of Last Action', NULL, 'DATE_LAST_ACTION', '_HBM_MATTER_USR_DATA', NULL, 0, GETDATE(), 'SMJ', 1
	INSERT INTO MIFieldDefinition SELECT 'LVSETPOINT', 'MILKP', 'Settlement Point', 'LVSETPOINT', 'LVMIDetails_SettPoint', 'LVMIDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVNILDAM', 'MILKP', 'Nil Damages', 'LVNILDAM', 'LVMIDetails_NilDam', 'LVMIDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVNILTP', 'MILKP', 'Nil TP Costs', 'LVNILTP', 'LVMIDetails_NilTP', 'LVMIDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'DAYSTOSETT', 'MIINT', 'Days to Settle', NULL, 'LVMIDetails_DaysToSett', 'LVMIDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'LVRESMETH', 'MILKP', 'Result Method', 'LVRESMETH', 'LVMIDetails_ResMeth', 'LVMIDetails', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'CCVAT', 'MIMONEY', 'Claimants Costs - VAT', NULL, 'Costs_VATSett', 'Costs', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'SDPSTREC', 'MIMONEY', 'Special Damages Paid - Storage/Recovery', NULL, 'Financial_StoRecVal', 'Financial', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'SPDPCARE', 'MIMONEY', 'Special Damages Paid - Care', NULL, 'Financial_CareVal', 'Financial', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'SDPLOE', 'MIMONEY', 'Special Damages Paid - Loss of Earnings', NULL, 'Financial_LOEVal', 'Financial', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'SDPOTH', 'MIMONEY', 'Special Damages Paid - Other', NULL, 'Financial_OthVal', 'Financial', NULL, 0, GETDATE(), 'SMJ', 0


--6. ADD NEW CLIENTMIFIELDSET

	INSERT INTO ClientMIFieldSet SELECT 'LV','CLIREF',1,'LV Claim Reference:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','CLMHNDLR',2,'LV Handler:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVOFFICE',3,'LV Office:',1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','AAAAAAAAAA',4,'Name of Insured:',1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','CLCTPCODE',5,'Insured Postcode:',1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','CODEFSOL',6,'Co-Defendant Solicitor:',1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','CDFSCNTCT',7,'Co-Defendant Solicitor Contact:',1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVLIT',8,'Litigated?:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVAVOIDLIT',9,'Avoidable Litigation?:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVREASLIT',10,'Reason for Litigation:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVPIINV',11,'PI Involved:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVCLAIDEF',12,'Acting as Claimant or Defendant:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','COMPREC',13,'Has a complaint been received?:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVLIMIT',14,'Limitation:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLMLnk',15,'Other BLM Matter Linked:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVTPINS',16,'TP Insurer:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','MICFIELD91',17,'Credit Hire Organisation:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LBLBLNK',18,'LV - Categorisation:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','CATINSTR',19,'Category at Instruction:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','MOTCAT',20,'Category at Conclusion:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVPROD',21,'Product:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVTRACK',22,'Track:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVWRKTYPE',23,'Work Type:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVTYPE',24,'Type:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','CLAIMNAME',25,'Claimant Name:',1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','NUMCLMNT',26,'No of Claimant:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','NUMCLMNTS',27,'No of Claimants:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVCLSO',28,'Claimant Solicitor:',1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LBLBLNK',29,'LV - Dates:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','DTEINSTR',30,'Date of Instruction:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','DTEACC',31,'Date of Accident:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',32,'BLANK-32:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',33,'BLANK-33:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',34,'BLANK-34:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',35,'BLANK-35:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',36,'BLANK-36:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','MPROFCOSTS',37,'Own Fees:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','OWNDSBCNS',38,'Own Disbursements - Counsel/Experts:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','OWNDSBOTH',39,'Own Disbursements - Other:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLMCstRes',40,'Own Costs - Total:',1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','RESPRFCSTS',41,'Claimants Costs - Profit Costs:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVRESDISB',42,'Claimants Costs - Disbursements:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVRESATE',43,'Claimants Costs - ATE Premium:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVRESSUCC',44,'Claimants Costs - Success Fee:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVRESVAT',45,'Claimants Costs - VAT:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','FICURRESCO',46,'Claimants Costs - Total:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','RALDAMAGES',47,'General Damages :',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',48,'BLANK-48:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','ResCRU',49,'Special Damages - CRU:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','ResNHS',50,'Special Damages - NHS:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','ResAmb',51,'Special Damages - Ambulance:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVSDRPRDAM',52,'Special Damages - Property Damage:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVSDRCH',53,'Special Damages - Credit Hire:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVSDRSTREC',54,'Special Damages - Storage/Recovery:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVSDRCARE',55,'Special Damages - Care:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVSDRLOE',56,'Special Damages - Loss of Earnings:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVSDROTH',57,'Special Damages - Other:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','IALDAMAGES',58,'Total Special Damages Reserve:',1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','MICFIELD77',59,'Total Damages Reserve:',1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',60,'BLANK-60:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','DTEPROC',61,'Date of Proceedings:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','DTEACKDUE',62,'Date Acknowledgement Due:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','DTEASSENT',63,'Date A&S sent to Court:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','DefDueDate',64,'Date Defence Due:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','DTEDFSENT',65,'Date Defence sent to Court:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','DateJdgEnt',66,'Date of Judgment:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','ACTRESJUD',67,'Action in response to Judgment:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','PRESPOS',68,'Present Position (Judgement):',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','JUDSETASD',69,'Judgment Set Aside:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',70,'BLANK-70:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',71,'BLANK-71:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',72,'BLANK-72:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','GENDAMCLAI',73,'General Damages:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVSDCCRU',74,'Special Damages - CRU:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVSDCNHS',75,'Special Damages - NHS:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVSDCAMB',76,'Special Damages - Ambulance:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVSDCPD',77,'Special Damages - Property Damage:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','UNTCLAIMED',78,'Special Damages - Credit Hire:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVSDCSTREC',79,'Special Damages - Storage/Recovery:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVSDCCARE',80,'Special Damages - Care:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVSDCLOE',81,'Special Damages - Loss of Earnings:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVSDCOTH',82,'Special Damages - Other:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVTOTSDCLM',83,'Total Special Damages Claimed:',1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVDAMCLMD',84,'Total Damages Claimed:',1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','CTABLECSTS',85,'Predicable Costs Claimed:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','CSTPRFCSTS',86,'Claimants Costs - Profit Costs:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','MICFIELD14',87,'Claimants Costs - Disbursements:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','MICFIELD15',88,'Claimants Costs - ATE Premium:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','MICFIELD16',89,'Claimants Costs - Success Fee:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','CLAICOSVAT',90,'Claimants Costs - VAT:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','MICFIELD13',91,'Claimants Costs - Total:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',92,'BLANK-92:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',93,'BLANK-93:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',94,'BLANK-94:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',95,'BLANK-95:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',96,'BLANK-96:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','DTESETT',97,'Damages Settlement Date:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','MICFIELD04',98,'TP Costs Settlement Date:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','ClmStsTxt',99,'Status:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','DTELASTACT',100,'Date of Last Action:',1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVSETPOINT',101,'Settlement Point:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVNILDAM',102,'Nil Damages:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVNILTP',103,'Nil TP Costs:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','DAYSTOSETT',104,'Days to Settle:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LVRESMETH',105,'Result Method:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',106,'BLANK-106:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',107,'BLANK-107:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',108,'BLANK-108:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','YRECOVERED',109,'Total Damages Recovered:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLMCstFB',110,'Own Fees:',1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLMCFB',111,'Own Disbursements - Counsel/Experts:',1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLMDB',112,'Own Disbursements - Other:',1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLMTotB',113,'Own Costs - Total:',1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','TPPrCstSet',114,'Claimants Costs - Profit Costs:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','MICFIELD26',115,'Claimants Costs - Disbursements:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','MICFIELD27',116,'Claimants Costs - ATE Premium:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','MICFIELD28',117,'Claimants Costs - Success Fee:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','CCVAT',118,'Claimants Costs - VAT:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','MICFIELD30',119,'Claimants Costs - Total:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',120,'BLANK-120:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','MICFIELD63',121,'General Damages Paid:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','LXCRUVALUE',122,'Special Damages Paid - CRU:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','IALXNHSVAL',123,'Special Damages Paid - NHS:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','PdAmb',124,'Special Damages Paid - Ambulance:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','PRPDAMPAID',125,'Special Damages Paid - Property Damage:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','AMOUNTPAID',126,'Special Damages Paid - Credit Hire:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','SDPSTREC',127,'Special Damages Paid - Storage/Recovery:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','SPDPCARE',128,'Special Damages Paid - Care:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','SDPLOE',129,'Special Damages Paid - Loss of Earnings:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','SDPOTH',130,'Special Damages Paid - Other:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','SpDmStVl',131,'Total Special Damages Paid:',1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','MICFIELD65',132,'Total Damages Paid:',1, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',133,'BLANK-133:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',134,'BLANK-134:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',135,'BLANK-135:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',136,'BLANK-136:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',137,'BLANK-137:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',138,'BLANK-138:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',139,'BLANK-139:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',140,'BLANK-140:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',141,'BLANK-141:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',142,'BLANK-142:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',143,'BLANK-143:',0, 0, 0, GETDATE(), 'SMJ', NULL
	INSERT INTO ClientMIFieldSet SELECT 'LV','BLANK',144,'BLANK-144:',0, 0, 0, GETDATE(), 'SMJ', NULL














