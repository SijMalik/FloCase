--THIS IS TO APPLY A CR SET TO A ClientCode THAT DOESN'T EXIST/NOT OVERWRITING AN EXISTING RULE


--RULE YOU WANT TO APPLY - REPLACE ClientCode AS APPROPRIATE
select * from ClientRule a
where a.ClientRule_ClientCode = '37044'
and a.ClientRule_InActive = 0


--RULE TO APPLY TO -  REPLACE ClientCode AS APPROPRIATE - THE RULE FROM ABOVE SHOULDN'T
--EXIST - IF IT DOES, RUN THE CRREPLICATE.SQL FILE
select * from ClientRule a
where a.ClientRule_ClientCode = '149099'
and a.ClientRule_InActive = 0

----ONCE YOU'RE HAPPY - UNCOMMENT AND RUN CODE BELOW REPLACING ClientCodes AS APPROPRIATE
--INSERT INTO ClientRule
--SELECT 
--ClientRule_Code, 
--ClientRule_Name, 
--'149099', 
--ClientRule_ClientGroupID, 
--ClientRule_InActive, 
--GETDATE(), 
--'SMJ'
--FROM ClientRule
--where ClientRule_ClientCode = '37044'
--and ClientRule_InActive = 0
