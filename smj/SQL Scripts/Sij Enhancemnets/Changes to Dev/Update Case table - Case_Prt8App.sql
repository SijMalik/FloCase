--CREATE TEMPORY COLUMN
ALTER TABLE [Case] ADD Case_Prt8Apptmp bit
GO

--SET TEMPORY COLUMN TO CONTENTS OF EXISTING COLUMN
UPDATE [Case] 
SET Case_Prt8Apptmp = Case_Prt8App 
GO

--REMOVE EXISTING COLUMN
ALTER TABLE [case] DROP COLUMN Case_Prt8App
GO

--READD COLUMN AS NVARCHAR
ALTER TABLE [case] ADD Case_Prt8App nvarchar(255)
GO

--REPOPULATE COLUMN WITH 1 = YES AND ALL OTHER VALUES = NO
UPDATE [Case] 
SET Case_Prt8App = CASE WHEN Case_Prt8Apptmp = 1 THEN 'Yes' ELSE 'No' END
GO

--REMOVE TEMPORY COLUMN
ALTER TABLE [case] DROP COLUMN Case_Prt8Apptmp
GO