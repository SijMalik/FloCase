UPDATE [dbo].[AppTaskDefinition]
   SET [WorkflowName] = '10- Allocation Questionnaire Received'
 WHERE [WorkflowName] = '10 - Allocation Questionnaire Received'
GO
UPDATE [dbo].[AppTaskDefinition]
   SET [WorkflowName] = '7 - Draft Admission Received from Counsel'
 WHERE [WorkflowName] = '7 - Draft Admission'
GO
UPDATE [dbo].[AppTaskDefinition]
   SET [WorkflowName] = '11 - Produce Allocation Questionnaire'
 WHERE [WorkflowName] = '11 - Produce Allocation Q'
GO
UPDATE [dbo].[AppTaskDefinition]
   SET [WorkflowName] = '3 - Chase Informat Extension of Time'
 WHERE [WorkflowName] = '3 - Chase Informal Extension of Time'
GO

UPDATE [dbo].[AppTaskDefinition]
   SET [WorkflowName] = '8 - Review Typed Admission'
 WHERE [WorkflowName] = '8 - Review Admission'
GO
