DECLARE @SOURCERULECODE AS NVARCHAR(255)
DECLARE @DESTRULECODE AS NVARCHAR(255)
DECLARE @RULENAME AS NVARCHAR(255)
DECLARE @MINID AS INT
DECLARE @MAXID AS INT


--SOURCERULECODE AND RULENAME ARE ONES TO COPY FROM i.e. 'CTRL0000000238' - Delegated
SELECT @SOURCERULECODE = '', @RULENAME = '', @MINID = 1

DECLARE @temptable as table(
id int identity(1,1),
code nvarchar(255))


INSERT INTO @temptable(code)
SELECT ClientRule_Code 
FROM ClientRule 
where ClientRule_Code in (select ClientRule_Code 
                                          from ClientRule 
                                          where ClientRule_Code <> @SOURCERULECODE
                                          and ClientRule_Name = @RULENAME
                                          and ClientRule_ClientCode = ''--ENTER CLIENT RULE CODE TO COPY TO HERE
                                          AND ClientRule_InActive = 0) and ClientRule_InActive = 0

SELECT @MAXID = MAX(ID) FROM @temptable 

WHILE @MINID <= @MAXID 
BEGIN
      SELECT @DESTRULECODE = code FROM @temptable WHERE ID = @MINID 
      
      UPDATE ClientRuleSet 
      SET ClientRuleSet_InActive = 1 
      WHERE ClientRuleSet_ClientRuleCode = @DESTRULECODE
      
      INSERT INTO [dbo].[ClientRuleSet]
           ([ClientRuleSet_ClientRuleCode]
           ,[ClientRuleSet_ClientRuleDefinitionCode]
           ,[ClientRuleSet_Value]
           ,[ClientRuleSet_Visible]
           ,[ClientRuleSet_InActive]
           ,[ClientRuleSet_CreateDate]
           ,[ClientRuleSet_CreateUser])
    SELECT @DESTRULECODE 
           ,[ClientRuleSet_ClientRuleDefinitionCode]
           ,[ClientRuleSet_Value]
           ,[ClientRuleSet_Visible]
           ,[ClientRuleSet_InActive]
           ,[ClientRuleSet_CreateDate]
           ,[ClientRuleSet_CreateUser]
    FROM ClientRuleSet
    WHERE ClientRuleSet_ClientRuleCode = @SOURCERULECODE AND ClientRuleSet_InActive = 0
      
      SELECT @MINID = @MINID + 1
END
