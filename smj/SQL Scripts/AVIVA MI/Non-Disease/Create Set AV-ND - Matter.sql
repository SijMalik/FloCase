--1. INSERT NEW SET INTO ClientMIDefinition

 	INSERT INTO ClientMIDefinition
  	SELECT NULL, 'AVIVA', NULL, 'AVIVA', 'AVIVA', 0, 'SMJ', GETDATE(), NULL


--2. INSERT CLIENT PANELS


	--PAGE 1
	INSERT INTO ClientMIPanels
	SELECT 'AVIVA',1,1,'Aviva Dates',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'AVIVA',2,1,'Aviva - General MI Continued',0,GETDATE(), 'SMJ'

	INSERT INTO ClientMIPanels
	SELECT 'AVIVA',3,1,'Aviva - General MI Continued',0,GETDATE(), 'SMJ'


--3. INSERT NEW KEYDATES

	INSERT INTO KeyDatesType
	SELECT 'Date Liability Agreed', 'DTELIAAGR',0,'SMJ',GETDATE(),NULL

	INSERT INTO KeyDatesType
	SELECT 'Date of Letter of Claim', 'DTELECLAI',0,'SMJ',GETDATE(),NULL

--4. INSERT NEW MI Lookups
	--CLAIMANT
	INSERT INTO MILookupFieldDefinition SELECT 'TRIOUTCOME','DNGTT','Did not go to Trial','Did not go to Trial','AVIVACLAIM',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'TRIOUTCOME','WAT','Won at Trial','Won at Trial','AVIVACLAIM',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'TRIOUTCOME','LAT','Lost at Trial','Lost at Trial','AVIVACLAIM',0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition SELECT 'REAEXCOL','CRTAWA','Court Award','Court Award','AVIVACLAIM',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'REAEXCOL','CASELAW','Case Law','Case Law','AVIVACLAIM',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'REAEXCOL','FURTHMED','Further Medical','Further Medical','AVIVACLAIM',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'REAEXCOL','JSBGDLN','JSB Guidelines','JSB Guidelines','AVIVACLAIM',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'REAEXCOL','NOTEXC','Not Exceeded','Not Exceeded','AVIVACLAIM',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'REAEXCOL','OTHFAC','Other Factors','Other Factors','AVIVACLAIM',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'REAEXCOL','NOCOL','No Colossus valuation supplied','No Colossus valuation supplied','AVIVACLAIM',0, GETDATE(), 'SMJ'


	INSERT INTO MILookupFieldDefinition SELECT 'CRUAPPEAL','NA','N/A','N/A','AVIVACLAIM',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'CRUAPPEAL','ONG','Ongoing','Ongoing','AVIVACLAIM',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'CRUAPPEAL','SUCC','Successful','Successful','AVIVACLAIM',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'CRUAPPEAL','UNSUCC','Unsuccesful','Unsuccesful','AVIVACLAIM',0, GETDATE(), 'SMJ'
	-------------------

	--MATTER
	INSERT INTO MILookupFieldDefinition SELECT 'AVVALBAND','V25K','£0 - £25k','£0 - £25k','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVVALBAND','V50K','£25k - £50k','£25k - £50k','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVVALBAND','V125K','£50k - £125k','£50k - £125k','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVVALBAND','V1M','£125k - £1million','£125k - £1million','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVVALBAND','V1MPLUS','£1million +','£1million +','AVIVA',0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition SELECT 'CSTDLTNBLM','Y','Yes','Yes','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'CSTDLTNBLM','N','No','No','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'CSTDLTNBLM','NC','No Costs','No Costs','AVIVA',0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition SELECT 'SETTSTATUS','PSDCSTDR','Passed to Cost Draughtsman','Passed to Cost Draughtsman','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'SETTSTATUS','HTNF','Handed to new firm','Handed to new firm','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'SETTSTATUS','SETTP36','Settled - Part 36 offer awarded','Settled - Part 36 offer awarded','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'SETTSTATUS','CWON','Case Won','Case Won','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'SETTSTATUS','CWTHD','Case withdrawn','Case withdrawn','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'SETTSTATUS','SETTCNA','Settled - costs not awarded','Settled - costs not awarded','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'SETTSTATUS','COMPCA','Completed - Costs Agreed','Completed - Costs Agreed','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'SETTSTATUS','NEWHAND','New handler','New handler','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'SETTSTATUS','LITIG','Litigated','Litigated','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'SETTSTATUS','SETTBEFTR','Settled before Trial','Settled before Trial','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'SETTSTATUS','LAT','Lost at Trial','Lost at Trial','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'SETTSTATUS','OTHREAS','Other - please give reason','Other - please give reason','AVIVA',0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition SELECT 'REASUCC','LIASUCC','Liability Success','Liability Success','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'REASUCC','WAT','Win at Trial','Win at Trial','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'REASUCC','OFFNOTBT','Offer not beaten','Offer not beaten','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'REASUCC','OWNCSTREC','Own Costs Recovered','Own Costs Recovered','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'REASUCC','SUCCRUAPP','Successful CRU appeal','Successful CRU appeal','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'REASUCC','PCALITMAT','Predictive costs agreed on a litigated matter','Predictive costs agreed on a litigated matter','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'REASUCC','P36NTBT','Part 36 not Beaten','Part 36 not Beaten','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'REASUCC','FRAUD','Fraud','Fraud','AVIVA',0, GETDATE(), 'SMJ'


	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','BAS','Basildon','Basildon','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','BEL','Belfast','Belfast','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','BIR','Birmingham','Birmingham','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','BIS','Bishopbriggs','Bishopbriggs','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','BRA','Bradford','Bradford','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','BRI','Bristol','Bristol','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','CHE','Chelmsford','Chelmsford','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','CRO','Croydon','Croydon','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','DUN','Dundee','Dundee','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','EDI','Edinburgh','Edinburgh','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','EXE','Exeter','Exeter','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','GLA','Glasgow','Glasgow','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','INBAN','India - Bangalore','India - Bangalore','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','INNOI','India - Noida','India - Noida','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','INPUN','India - Pune','India - Pune','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','LEE','Leeds','Leeds','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','LIV','Liverpool','Liverpool','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','MAN','Manchester','Manchester','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','NEW','Newcastle','Newcastle','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','NOR','Norwich Commercial Centre','Norwich Commercial Centre','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','OTH','Other','Other','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','SIU','SIU','SIU','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','SOU','Southampton','Southampton','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','SEND','Southend','Southend','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','TCSLEG','TCS - Legal','TCS - Legal','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','TCSLIA','TCS - Liability','TCS - Liability','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','TCSMOT','TCS - Motor','TCS - Motor','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCLAILOC','WOR','Worthing','Worthing','AVIVA',0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition SELECT 'INSTRUNIT','BANG','Bangalore','Bangalore','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'INSTRUNIT','BEACH','Beachcroft','Beachcroft','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'INSTRUNIT','BLM','Berrymans Lace Mawer','Berrymans Lace Mawer','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'INSTRUNIT','BIRM','Birmingham','Birmingham','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'INSTRUNIT','CAP','Capita','Capita','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'INSTRUNIT','CRAW','Crawfords','Crawfords','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'INSTRUNIT','CIP','CIP','CIP','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'INSTRUNIT','CUN','Cunningham Lindsey','Cunningham Lindsey','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'INSTRUNIT','VLA','DLA','DLA','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'INSTRUNIT','DWF','DWF','DWF','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'INSTRUNIT','EXE','Exeter','Exeter','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'INSTRUNIT','GLA','Glasgow','Glasgow','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'INSTRUNIT','GRE','Greenwoods','Greenwoods','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'INSTRUNIT','HF','Horwich Farrelly','Horwich Farrelly','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'INSTRUNIT','HJ','Hugh James','Hugh James','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'INSTRUNIT','KEO','Keoghs','Keoghs','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'INSTRUNIT','MAN','Manchester','Manchester','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'INSTRUNIT','NOI','Noida','Noida','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'INSTRUNIT','NOR','Norwich','Norwich','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'INSTRUNIT','OTH','Other','Other','AVIVA',0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition SELECT 'SERVINSTR','LIT','Litigated','Litigated','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'SERVINSTR','LITPO','Litigated post outsource','Litigated post outsource','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'SERVINSTR','OUTNC','Outsourced new claim','Outsourced new claim','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'SERVINSTR','OUTCL','Outsourced caseload','Outsourced caseload','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'SERVINSTR','OTH','Other','Other','AVIVA',0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition SELECT 'AVCOMMOD','CP','Criminal Prosecutions','Criminal Prosecutions','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCOMMOD','FRAUD','Fraud','Fraud','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCOMMOD','FTDA','FT DA','FT DA','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCOMMOD','FTNDA','FT non DA','FT non DA','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCOMMOD','HSH','Household','Household','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCOMMOD','HSE','HSE','HSE','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCOMMOD','MTDA','MT DA','MT DA','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCOMMOD','MTNDA','MT non DA','MT non DA','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCOMMOD','PAD','PAD','PAD','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCOMMOD','INFAPP','Infant Approval','Infant Approval','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCOMMOD','CONSORD','Consent Order','Consent Order','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCOMMOD','OTH','Other','Other','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCOMMOD','INFONLY','Info only','Info only','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCOMMOD','ADVONLY','Advice Only','Advice Only','AVIVA',0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition SELECT 'AVCATEGORY','MOTPROP','Motor-Property Only','Motor-Property Only','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCATEGORY','MOTINJ','Motor-Injury','Motor-Injury','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCATEGORY','ELINJ','EL-injury','EL-injury','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCATEGORY','PLINJ','PL-injury','PL-injury','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCATEGORY','ELENV','EL-Environmental','EL-Environmental','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCATEGORY','PLENV','PL-Environmental','PL-Environmental','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCATEGORY','PI','Professional Indemnity','Professional Indemnity','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCATEGORY','PLPROP','PL-Property','PL-Property','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCATEGORY','OTH','Other','Other','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVCATEGORY','CH','Credit Hire','Credit Hire','AVIVA',0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition SELECT 'AVINJTYPE','AMP','Amputation','Amputation','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVINJTYPE','ARM','Arm Injury (not broken)','Arm Injury (not broken)','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVINJTYPE','BACK','Back Injury','Back Injury','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVINJTYPE','BLIND','Blindness/Injury to eyes','Blindness/Injury to eyes','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVINJTYPE','BRINJCAT','Brain Injury-Catastrophic','Brain Injury-Catastrophic','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVINJTYPE','BRINJOTH','Brain Injury-Other','Brain Injury-Other','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVINJTYPE','BRK','Breaks/Fractures','Breaks/Fractures','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVINJTYPE','BURN','Burns/Scarring','Burns/Scarring','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVINJTYPE','DEAFD','Deafness/injury to ears','Deafness/injury to ears','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVINJTYPE','CUTS','Cuts and Bruises','Cuts and Bruises','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVINJTYPE','FATAL','Fatality','Fatality','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVINJTYPE','INTINJ','Internal injuries','Internal injuries','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVINJTYPE','LEGINJNB','Leg injury (not broken)','Leg injury (not broken)','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVINJTYPE','NECKINJ','Neck Injury','Neck Injury','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVINJTYPE','NONE','None','None','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVINJTYPE','PSY','Psychological/Psychiatric','Psychological/Psychiatric','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVINJTYPE','PARA','Paralysis','Paralysis','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVINJTYPE','SHOU','Shoulder Injury','Shoulder Injury','AVIVA',0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition SELECT 'AVLITSTAT','NOTLIT','Not litigated','Not litigated','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVLITSTAT','LITIG','Litigated','Litigated','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVLITSTAT','P8ONLY','Part 8 only','Part 8 only','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVLITSTAT','LITPO','Litigated post outsource','Litigated post outsource','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVLITSTAT','PAD','PAD','PAD','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVLITSTAT','INFAPP','Infant Approval','Infant Approval','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'AVLITSTAT','CHONLY','Credit Hire only','Credit Hire only','AVIVA',0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition SELECT 'CAUSELIT1','LIAB','Liability','Liability','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'CAUSELIT1','QUANT','Quantum','Quantum','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'CAUSELIT1','LIABQUANT','Liability & Quantum','Liability & Quantum','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'CAUSELIT1','LIMIT','Limitation','Limitation','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'CAUSELIT1','NORESPAV','No response from Aviva','No response from Aviva','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'CAUSELIT1','OTH','Other','Other','AVIVA',0, GETDATE(), 'SMJ'

	INSERT INTO MILookupFieldDefinition SELECT 'CAUSELIT2','NOFFAV','No offer made by Aviva','No offer made by Aviva','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'CAUSELIT2','OFFREJCLAI','Aviva offer rejected by claimant','Aviva offer rejected by claimant','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'CAUSELIT2','OFFREJAV','Claimant offer rejected by Aviva','Claimant offer rejected by Aviva','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'CAUSELIT2','NRCLAIOFF','No response to Claimant offer','No response to Claimant offer','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'CAUSELIT2','NORESPAV','No response from Aviva','No response from Aviva','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'CAUSELIT2','DISPFULL','Disputed in Full','Disputed in Full','AVIVA',0, GETDATE(), 'SMJ'
	INSERT INTO MILookupFieldDefinition SELECT 'CAUSELIT2','OTH','Other','Other','AVIVA',0, GETDATE(), 'SMJ'
	-------------------


--5. INSERT NEW MI FIELD DEFS

	INSERT INTO MIFieldDefinition SELECT 'AVBLMDIB', 'MIMONEY', 'BLM Disbursements', NULL, 'FinancialReserve_BLMDisb', 'FinancialReserve', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'AVBLMPC', 'MIMONEY', 'BLM Profit Costs', NULL, 'FinancialReserve_BLMProfCosts', 'FinancialReserve', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'AVBLMVAT', 'MIMONEY', 'BLM VAT', NULL, 'FinancialReserve_BLMDisbExVAT', 'FinancialReserve', NULL, 0, GETDATE(), 'SMJ',0
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
	INSERT INTO MIFieldDefinition SELECT 'MOJINS', 'MILKP', 'MoJ at Instruction','YesNo','MOJ_STAGE_CASE', '_HBM_MATTER_USR_DATA', NULL, 0, GETDATE(), 'SMJ', 1
	INSERT INTO MIFieldDefinition SELECT 'MOJSTTLD', 'MILKP', 'MoJ at Settlement','YesNo','ManagementInformation_MOJSttldStts', 'ManagementInformation', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'REAOTURN', 'MITEXT', 'Reason for overturning the Aviva claims handler decision', NULL, 'ManagementInformation_ReasonOverturnAV', 'ManagementInformation', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'SERVINSTR', 'MILKP', 'Service Instructed', 'SERVINSTR', 'ManagementInformation_ServiceInstructed', 'ManagementInformation', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'MIFTCS', 'MILKP', 'TCS','YesNo','ManagementInformation_TCS', 'ManagementInformation', NULL, 0, GETDATE(), 'SMJ', 0
	INSERT INTO MIFieldDefinition SELECT 'AVVALBAND', 'MILKP', 'Value Band', 'AVVALBAND', 'CaseDetails_WorkValueCode', 'CaseDetails', NULL, 0, GETDATE(), 'SMJ', 0

--6. CREATE THE SET
	
    	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','AccDt',1,'Incident Date:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','DTEINSTR',2,'Instruction Date:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','RECEIPT',3,'Date Received:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','DTELECLAI',4,'Date of Letter of Claim:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','DTELIAAGR',5,'Date Liability Agreed:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','LBLBLNK',6,'Aviva - General MI:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','AAAAAAAAAA',7,'Insured:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','CLTCLMHNDR',8,'Aviva Claims Handler:',1, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','MIFLD00002',9,'Claim Number:',1, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','LICYNUMBER',10,'Policy Number:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','AVCLAILOC',11,'Claims Location:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','INSTRUNIT',12,'Instructing Unit:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','MIFTCS',13,'TCS:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','AVDEFJUD',14,'Default Judgement:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','SERVINSTR',15,'Service Instructed:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','AVCOMMOD',16,'Commodity:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','AVCATEGORY',17,'Category:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','AVINJTYPE',18,'Injury Type:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','AVLITSTAT',19,'Litigation Status:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','CAUSELIT1',20,'Cause of Litigation 1:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','CAUSELIT2',21,'Cause of Litigation 2:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','LitAtAV',22,'Litigated at Aviva (before our instruction):',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','LitCseTxt',23,'What could Aviva have done differently to prevent litigation:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','REAOTURN',24,'Reason for overturning the Aviva claims handler decision:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','AVVALBAND',25,'Value Band:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','MOJINS',26,'MoJ at Instruction:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','MOJSTTLD',27,'MoJ at Settlement:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','LBLBLNK',28,'Aviva - General Financials:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','AVBLMPC',29,'BLM Profit Costs:',1, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','AVBLMDIB',30,'BLM Disbursements:',1, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','AVBLMVAT',31,'BLM VAT:',1, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','BLANK',32,'BLANK-32:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','BLANK',33,'BLANK-33:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','BLANK',34,'BLANK-34:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','BLANK',35,'BLANK-34:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL
	INSERT INTO ClientMIFieldSet SELECT 'AVIVA','BLANK',36,'BLANK-34:',0, 0, 0, GETDATE(), 'SMJ', NULL, NULL

