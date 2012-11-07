select COUNT(*) from ContactComs
select 1166155 - 1165958 

1167019
LTMM_InsertMedicalFromReferenceDB 0, 0
select * from ContactComs a
where a.ContactComs_ComType = 'Tel'
order by a.CreateDate desc

select * from ContactComs cc
where cc.ContactComs_ContactID = 696793
and cc.ContactComs_ComType = 'Tel'
and cc.ContactComs_InActive = 0
order by CreateDate desc

select c.ContactComs_ContactID, COUNT(*) from ContactComs c
order  by c.ContactComs_ContactComsID desc

select c.ContactComs_ContactID, COUNT(*) AS RC
from ContactComs c
where c.ContactComs_InActive  = 0
group by ContactComs_ContactID


