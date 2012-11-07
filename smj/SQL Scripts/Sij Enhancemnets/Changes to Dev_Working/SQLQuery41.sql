
	
select * from AppTask a
where a.AppInstanceValue = '147427-214'
and a.AppTaskDefinitionCode = 'KeyDate'
and a.StatusCode = 'Active'
order by a.CreatedDate desc

delete from apptask where 
apptaskid IN
(
133734
)



update AppTask
set Description = 'Key Date: Accident Date 05/10/2012 - (Mr Andrew J H  Claimant4)'
,CompletedDate = null, CompletedBy = null, StatusCode = 'Active'
where AppTaskID = 133479

update AppTask
set Description = 'Key Date: Accident Date 05/10/2012 - (Gretel Hansel)'
,CompletedDate = null, CompletedBy = null, StatusCode = 'Active'
where AppTaskID = 133481

update AppTask
set Description = 'KeyDate: Limitation Period Expires 05/10/2015 - (Mr Andrew J H Claimant4)'
,CompletedDate = null, CompletedBy = null, StatusCode = 'Active'
where AppTaskID = 133487

update AppTask
set Description = 'KeyDate: Limitation Period Expires 05/10/2015 - (Gretel Hansel)'
,CompletedDate = null, CompletedBy = null, StatusCode = 'Active'
where AppTaskID = 133494


select * from CaseKeyDates ckd
where ckd.CaseKeyDates_CaseID = 1956
and ckd.CaseKeyDates_Inactive = 0

DELETE FROM CaseKeyDates
WHERE CaseKeyDates_CaseKeyDatesID IN
(
6090811,
6090815,
6090819,
6090822
)