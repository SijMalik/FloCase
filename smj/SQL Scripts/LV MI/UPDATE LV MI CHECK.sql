


SELECT FinancialReserve_CaseID,
FinancialReserve_Cost,
FinancialReserve_DamagesNET,
FinancialReserve_ClaimantCosts,
* 
FROM FinancialReserve 
WHERE FinancialReserve_CaseID IN
(
select c.Case_CaseID from [Case] c 
inner join FinancialReserve fr
on c.Case_CaseID = fr.FinancialReserve_CaseID
where c.Case_GroupCode like 'lv%'
and fr.FinancialReserve_Inactive = 0
)
AND FinancialReserve_Inactive = 0
order by FinancialReserve.FinancialReserve_CaseID

SELECT FinancialReserveHistory_CaseID,
FinancialReserveHistory_Cost,
FinancialReserveHistory_DamagesNET,
FinancialReserveHistory_ClaimantCosts,
* 
FROM FinancialReserveHistory  
WHERE FinancialReserveHistory_CaseID IN
(
select c.Case_CaseID from [Case] c 
inner join FinancialReserveHistory fr
on c.Case_CaseID = fr.FinancialReserveHistory_CaseID
where c.Case_GroupCode like 'lv%'
and fr.FinancialReserveHistory_Inactive = 0
)
AND FinancialReserveHistory_Inactive = 0
order by FinancialReserveHistory.FinancialReserveHistory_CaseID


