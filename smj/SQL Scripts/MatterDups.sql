select MIN(MatterContact_MatterContactID) AS MatterContactID, MatterContact_Forename + ' ' + MatterContact_Surname + CONVERT(VARCHAR(10),cc.CaseContacts_RoleCode) + CONVERT(VARCHAR(10), cc.CaseContacts_CaseID)  AS MatConName
into #t1
from MatterContact mc
inner join CaseContacts cc on mc.MatterContact_MatterContactID = cc.CaseContacts_MatterContactID
where MatterContact_Forename + ' ' + MatterContact_Surname  +  CONVERT(VARCHAR(10),cc.CaseContacts_RoleCode)+ CONVERT(VARCHAR(10), cc.CaseContacts_CaseID) IN 
(SELECT MatterContact_Forename + ' ' + MatterContact_Surname  +  CONVERT(VARCHAR(10),cc.CaseContacts_RoleCode)+ CONVERT(VARCHAR(10), cc.CaseContacts_CaseID)
FROM MatterContact mc
inner join CaseContacts cc on mc.MatterContact_MatterContactID = cc.CaseContacts_MatterContactID
WHERE MatterContact_Inactive = 0
AND CaseContacts_Inactive = 0
AND MatterContact_Forename + ' ' + MatterContact_Surname <> ''
GROUP BY  MatterContact_Forename + ' ' + MatterContact_Surname, cc.CaseContacts_CaseID,cc.CaseContacts_RoleCode
HAVING COUNT(*) > 1)
AND MatterContact_Inactive  = 0
AND CaseContacts_Inactive = 0
GROUP by MatterContact_Forename + ' ' + MatterContact_Surname  +  CONVERT(VARCHAR(10),cc.CaseContacts_RoleCode)+ CONVERT(VARCHAR(10), cc.CaseContacts_CaseID)

--select * from #t1

--select * from CaseContacts
--where CaseContacts_CaseID = 2192
--and CaseContacts_Inactive = 0
--order by CaseContacts_SearchName


--select (MatterContact_MatterContactID) AS MatterContactID, MatterContact_CompanyName + CONVERT(VARCHAR(10),cc.CaseContacts_RoleCode) + CONVERT(VARCHAR(10), cc.CaseContacts_CaseID)  AS MatConName
----into #t1
--from MatterContact mc
--inner join CaseContacts cc on mc.MatterContact_MatterContactID = cc.CaseContacts_MatterContactID
--where MatterContact_CompanyName + CONVERT(VARCHAR(10),cc.CaseContacts_RoleCode) + CONVERT(VARCHAR(10), cc.CaseContacts_CaseID) IN 
--(SELECT MatterContact_CompanyName + CONVERT(VARCHAR(10),cc.CaseContacts_RoleCode) + CONVERT(VARCHAR(10), cc.CaseContacts_CaseID)
--FROM MatterContact mc
--inner join CaseContacts cc on mc.MatterContact_MatterContactID = cc.CaseContacts_MatterContactID
--WHERE MatterContact_Inactive = 0
--AND CaseContacts_Inactive = 0
--AND MatterContact_CompanyName <> ''
--GROUP BY  MatterContact_CompanyName, cc.CaseContacts_CaseID,cc.CaseContacts_RoleCode
--HAVING COUNT(*) > 1)
--AND MatterContact_Inactive  = 0
--AND CaseContacts_Inactive = 0
--GROUP by MatterContact_CompanyName + CONVERT(VARCHAR(10),cc.CaseContacts_RoleCode) + CONVERT(VARCHAR(10), cc.CaseContacts_CaseID)


UPDATE MatterContact
SET MatterContact_Inactive = 1
FROM MatterContact mc
inner join CaseContacts cc on mc.MatterContact_MatterContactID = cc.CaseContacts_MatterContactID
where MatterContact_Forename + ' ' + MatterContact_Surname  +  CONVERT(VARCHAR(10),cc.CaseContacts_RoleCode)+ CONVERT(VARCHAR(10), cc.CaseContacts_CaseID)
IN  (SELECT MatConName FROM #t1)
AND MatterContact_MatterContactID NOT IN
(SELECT MatterContactID FROM #t1)
and MatterContact_Inactive =0

