--For a case with missing values:
--delete from [Case] where Case_BLMREF = ''
--delete from ApplicationInstance where IdentifierValue = ''
--delete from AppTask where AppInstanceValue = ''


--select * from ARISTADetails where ARISTADetails_ClientNo like '%%'


------set processed date = null
--update ARISTADetails
--set ARISTADetails_ProcessedDate = NULL
--where ARISTADetails_ARISTADetailsID = 

---And then run 

--LTMM_ARISTADetails_Process

----For case that doesn't exist, run (do selects first) :

--CHECK CASE ISN'T ALREADY IN THERE
--SELECT * FROM  [Case] where Case_BLMREF = ''


INSERT INTO [dbo].[ARISTADetails]
           ([ARISTADetails_ClientNo]
           ,[ARISTADetails_MatterNo]
           ,[ARISTADetails_MatterBranchCode]
           ,[ARISTADetails_MatterSDesc]
           ,[ARISTADetails_MatterGroup]
           ,[ARISTADetails_FECode]
           ,[ARISTADetails_TLCode]
           ,[ARISTADetails_DeptCode]
           ,[ARISTADetails_WorkCode]
           ,[ARISTADetails_MatterAccidentDate]
           ,[ARISTADetails_InsurerRef]
           ,[ARISTADetails_MatterExtField1]
           ,[ARISTADetails_MatterExtField10]
           ,[ARISTADetails_CreatedDate])
SELECT  RIGHT('0000000'+ CONVERT(VARCHAR,c.CLIENT_NUMBER),8) as CLIENT_CODE, 
RIGHT('0000000'+ CONVERT(VARCHAR,m.MATTER_NUMBER),8) AS MATTER_NUMBER, 
m.OFFC AS BRANCH, 
m.MATTER_NAME,  
c.CLNT_CAT_CODE AS MATTERGROUP,
RTRIM(FES.EMPLOYEE_CODE) AS FES, 
RTRIM(TL.EMPLOYEE_CODE) AS TL, 
m.DEPT AS DEPARTMENT, 
m.MATT_CAT_CODE AS WORKTYPE,
u.DATE_ACCIDENT_INCIDENT AS Date_Of_Accident,
m.CLAIM_NUMBER AS insurance_ref, 
m.MATTER_UNO,
m.MATTER_UNO,
GETDATE() AS CREATEDATE
FROM       [MANZ01C03\MANZ01C03].[AderantLiveBLM].dbo.HBM_MATTER m INNER JOIN
dbo.HBM_CLIENT c ON m.CLIENT_UNO = c.CLIENT_UNO INNER JOIN
dbo._HBM_MATTER_USR_DATA u ON m.MATTER_UNO = u.MATTER_UNO LEFT OUTER JOIN
[MANZ01C03\MANZ01C03].[AderantLiveBLM].dbo.HBM_PERSNL FES ON m.BILL_EMPL_UNO = FES.EMPL_UNO INNER JOIN
[MANZ01C03\MANZ01C03].[AderantLiveBLM].dbo.HBM_PERSNL TL ON m.RESP_EMPL_UNO = TL.EMPL_UNO
--where c.CLNT_CAT_CODE = ''
WHERE clnt_matt_code IN (
'' --FORMAT IS '139251.2932' ETC
)

--RUN THIS AFTER INSERT
--LTMM_ARISTADetails_Process

--CHECK CASE HAS GONE IN - CHECK IN FLOCASE AS WELL
--SELECT * FROM  [Case] where Case_BLMREF = ''
