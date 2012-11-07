--FOR A CASE THAT HASN'T TRANSFERRED ACROSS PROPERLY:
--UNCOMMENT BELOW (DOWN TO ----END---):

----CHECK IT'S GONE IN THE CASE TABLE AND CHECK IT ISN'T SHOWING IN FLOCASE
--select * from [Case] c where c.Case_BLMREF = '' --e.g. '46487-4142'

----DELETE FROM FOLLOWING TABLES USING SMAE CLIENT/MATTER NUMBER IN EACH ONE
----E.G. '46487-4142'
--delete from [Case] where Case_BLMREF = ''
--delete from ApplicationInstance where IdentifierValue = ''
--delete from AppTask where AppInstanceValue = ''

----GET THE ARISTADETAILSID
--select ARISTADetails_ARISTADetailsID from ARISTADetails a 
--where a.ARISTADetails_ClientNo like '%' --e.g. '%46487'
--and a.ARISTADetails_MatterNo like '%' --e.g. '%4142'

----set processed date = null
--update ARISTADetails
--set ARISTADetails_ProcessedDate = NULL
--where ARISTADetails_ARISTADetailsID = --ID FROM ABOVE, E.G. 12597

----And then run (select the text and execute):

--LTMM_ARISTADetails_Process
-------END-----


--IGNORE BELOW AS A NEW PROCESS HAS BEEN PUT IN PLACE
--IF YOU DO NEED TO RUN IT, UNCOMMENT THE SELECT STATEMENT FIRST
--BEFORE DOING THE INSERT:

----INSERT INTO [dbo].[ARISTADetails]
----           ([ARISTADetails_ClientNo]
----           ,[ARISTADetails_MatterNo]
----           ,[ARISTADetails_MatterBranchCode]
----           ,[ARISTADetails_MatterSDesc]
----           ,[ARISTADetails_MatterGroup]
----           ,[ARISTADetails_FECode]
----           ,[ARISTADetails_TLCode]
----           ,[ARISTADetails_DeptCode]
----           ,[ARISTADetails_WorkCode]
----           ,[ARISTADetails_MatterAccidentDate]
----           ,[ARISTADetails_InsurerRef]
----           ,[ARISTADetails_MatterExtField1]
----           ,[ARISTADetails_MatterExtField10]
----           ,[ARISTADetails_CreatedDate])
--SELECT  top 10 RIGHT('0000000'+ CONVERT(VARCHAR,c.CLIENT_NUMBER),8) as CLIENT_CODE, 
--RIGHT('0000000'+ CONVERT(VARCHAR,m.MATTER_NUMBER),8) AS MATTER_NUMBER, 
--m.OFFC AS BRANCH, 
--m.MATTER_NAME,  
--c.CLNT_CAT_CODE AS MATTERGROUP,
--RTRIM(FES.EMPLOYEE_CODE) AS FES, 
--RTRIM(TL.EMPLOYEE_CODE) AS TL, 
--m.DEPT AS DEPARTMENT, 
--m.MATT_CAT_CODE AS WORKTYPE,
--u.DATE_ACCIDENT_INCIDENT AS Date_Of_Accident,
--m.CLAIM_NUMBER AS insurance_ref, 
--m.MATTER_UNO,
--m.MATTER_UNO,
--GETDATE() AS CREATEDATE
--FROM       [MANZ01C03\MANZ01C03].[AderantLiveBLM].dbo.HBM_MATTER m INNER JOIN
--dbo.HBM_CLIENT c ON m.CLIENT_UNO = c.CLIENT_UNO INNER JOIN
--dbo._HBM_MATTER_USR_DATA u ON m.MATTER_UNO = u.MATTER_UNO LEFT OUTER JOIN
--[MANZ01C03\MANZ01C03].[AderantLiveBLM].dbo.HBM_PERSNL FES ON m.BILL_EMPL_UNO = FES.EMPL_UNO INNER JOIN
--[MANZ01C03\MANZ01C03].[AderantLiveBLM].dbo.HBM_PERSNL TL ON m.RESP_EMPL_UNO = TL.EMPL_UNO
--where m.STATUS_CODE = 'OPEN'
--and m._transfer_to_case = 'F'
----FIND THE MATTER YOU NEED:
--and m.MATTER_UNO = '' --e.g.'633749'
--order by m.MATTER_UNO desc

----THEN RUN:
--LTMM_ARISTADetails_Process