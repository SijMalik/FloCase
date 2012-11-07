--SET EXISTING DUPLICATES INACTIVE
UPDATE ContactComs
SET ContactComs_InActive = 1
WHERE ContactComs_ContactComsID NOT IN
(
select max (a.ContactComs_ContactComsID)
from ContactComs a
where a.ContactComs_InActive  = 0
group by ContactComs_ContactID, ContactComs_ComType
having COUNT(*)  > 1
)
and ContactComs_ComType = 'Tel'

delete from ContactComs
where ContactComs_ContactComsID IN
( 
select max (a.ContactComs_ContactComsID)
from ContactComs a
where a.ContactComs_InActive  = 1
and a.ContactComs_ComType = 'Tel'
group by ContactComs_ContactID, ContactComs_ComType
having COUNT(*)  > 1
)


select max (a.ContactComs_ContactComsID), a.ContactComs_ContactID, a.ContactComs_ComType, COUNT (*) AS RC
from ContactComs a
where a.ContactComs_InActive  = 0
group by ContactComs_ContactID, ContactComs_ComType
having COUNT(*)  > 1

select * from ContactComs cc
where cc.ContactComs_ContactComsID = 1980862
order by ContactComs_ContactID 


