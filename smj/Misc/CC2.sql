select * from ContactComs cc
where --cc.ContactComs_ContactID  =697246
cc.ContactComs_ComType = 'Tel'
and cc.ContactComs_InActive = 0
order by ContactComs_ContactID

select max (a.ContactComs_ContactComsID), a.ContactComs_ContactID, a.ContactComs_ComType, COUNT (*) AS RC
from ContactComs a
where a.ContactComs_InActive  = 0
group by ContactComs_ContactID, ContactComs_ComType
having COUNT(*)  > 1
order by ContactComs_ContactID 


select max (a.ContactComs_ContactComsID)
from ContactComs a
where a.ContactComs_InActive  = 0
and a.ContactComs_ComType = 'Tel'
group by ContactComs_ContactID, ContactComs_ComType
having COUNT(*)  > 1
order by ContactComs_ContactID 

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


SELECT MAX(c.ContactComs_ContactComsID) FROM ContactComs c
WHERE c.ContactComs_ComType = 'Tel'
AND c.ContactComs_ContactID IN
(

)