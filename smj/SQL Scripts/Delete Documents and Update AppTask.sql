select a.DocumentID, * from AppTask a
where a.AppInstanceValue = '142813-3627'
and a.AppTaskDefinitionCode = 'UploadDoc'
and a.StatusCode = 'Complete'
order by a.DocumentID

delete from AppTaskDocument 
where AppTaskDocumentID IN

(
469893,
469903,
469948
)

UPDATE AppTask
SET StatusCode = 'Deleted'
WHERE AppTaskID IN
(
1091079,
1091089,
1091170
)