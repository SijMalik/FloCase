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

delete from ContactComs
where ContactComs_ContactComsID IN
( 
select ContactComs_ContactComsID from ContactComs cc
where cc.ContactComs_ComType = 'PriTel'
and cc.ContactComs_InActive = 1
)


select a.ContactComs_ContactID, a.ContactComs_ComType, COUNT (*) AS RC
from ContactComs a
where a.ContactComs_InActive  = 0
group by ContactComs_ContactID, ContactComs_ComType
having COUNT(*)  > 1
order by ContactComs_ContactID 