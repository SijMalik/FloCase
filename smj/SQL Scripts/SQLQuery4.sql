SELECT MAX(ckd.CaseKeyDates_CaseKeyDatesID) AS MaxCKDID, ckd.CaseKeyDates_CaseID, CaseKeyDates_KeyDatesCode 
INTO #T2
FROM CaseKeyDates ckd
WHERE CONVERT (CHAR, ckd.CaseKeyDates_CaseID) + CaseKeyDates_KeyDatesCode IN 
(
SELECT CONVERT (CHAR, ckd.CaseKeyDates_CaseID) + CaseKeyDates_KeyDatesCode 
FROM CaseKeyDates ckd
WHERE ckd.CaseKeyDates_Inactive= 0
GROUP BY CONVERT (CHAR, ckd.CaseKeyDates_CaseID) + ckd.CaseKeyDates_KeyDatesCode
HAVING COUNT (*) > 1
)
AND ckd.CaseKeyDates_Inactive = 0
GROUP BY  ckd.CaseKeyDates_CaseID, CaseKeyDates_KeyDatesCode
ORDER BY ckd.CaseKeyDates_CaseID, CaseKeyDates_KeyDatesCode



DELETE FROM CaseKeyDates 
WHERE CaseKeyDates_CaseID IN
(
SELECT CaseKeyDates_CaseID FROM #T1 
WHERE CaseKeyDates_CaseID NOT IN
(
SELECT MaxCKDID FROM #T2)
)

