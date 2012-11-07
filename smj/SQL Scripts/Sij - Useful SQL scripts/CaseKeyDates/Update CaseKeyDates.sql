--GET THE CASE ID
select * from [Case] where Case_BLMREF = '' --e.g. '37044-1'


--CHECK FOR DUPLICATES OR RECORDS TO BE CHANGED
select * from CaseKeyDates
where CaseKeyDates_Inactive = 0
and CaseKeyDates_CaseID = 
order by CaseKeyDates_KeyDatesCode


--TO REMOVE DUPLICATE - FIND THE ID OF THE ONE TO MAKE INACTIVE AND UPDATE
update CaseKeyDates
set CaseKeyDates_Inactive = 1
where CaseKeyDates_CaseKeyDatesID = -- e.g. 605409


--TO UPDATE A DATE - UPDATE USING ID
update CaseKeyDates
set CaseKeyDates_Date = -- e.g.'2012-05-10'
where CaseKeyDates_CaseKeyDatesID = -- e.g. 605409