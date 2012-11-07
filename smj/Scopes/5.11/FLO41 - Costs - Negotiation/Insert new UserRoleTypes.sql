  --SMJ - 28/10/2011: Add new User Role Types
  
  INSERT INTO AppUserRoleTypes
  SELECT 'Costs Draftsperson', 'CFE', 30, 0, 'ADMIN', GETDATE()
  
  INSERT INTO AppUserRoleTypes
  SELECT 'Costs Supervisor', 'CTL', 20, 0, 'ADMIN', GETDATE() 
  
  INSERT INTO AppUserRoleTypes
  SELECT 'Costs Team Administrator', 'CTA', 50, 0, 'ADMIN',GETDATE()
  -----------------------------------------------------


  INSERT INTO UserRoleTypes
  SELECT 'Costs Draftsperson', 'CFE', 30, 0
  
  INSERT INTO UserRoleTypes
  SELECT 'Costs Supervisor', 'CTL', 20, 0
  
  INSERT INTO UserRoleTypes
  SELECT 'Costs Team Administrator', 'CTA', 50, 0