


USE [AderantLiveBLM]

SELECT 
ba.Matter_uno				as	"Matter_Uno",
sum(ba.sign*ba.Fees_amt)	as	"Fees_Billed",
sum(
cast(
(ba.sign*ba.hard_amt+ba.sign*ba.soft_amt)
*
CASE
WHEN (ba.sign*ba.hard_amt+ba.sign*ba.soft_amt) = 0 
THEN 0
ELSE coalesce(cast(disb_CE.C_E_Amount as float),0)
END							
/
CASE
WHEN coalesce(cast(disb_all.Total_Disb_Amount as float),0) = 0
THEN 1
ELSE coalesce(cast(disb_all.Total_Disb_Amount as float),0)
END	
as money))					as	"Disbs_Counsel_Expert_Billed",

sum(
cast(
(ba.sign*ba.hard_amt+ba.sign*ba.soft_amt)
-
(ba.sign*ba.hard_amt+ba.sign*ba.soft_amt)
*
CASE
WHEN (ba.sign*ba.hard_amt+ba.sign*ba.soft_amt) = 0 
THEN 0
ELSE coalesce(cast(disb_CE.C_E_Amount as float),0)
END							
/
CASE
WHEN coalesce(cast(disb_all.Total_Disb_Amount as float),0) = 0
THEN 1
ELSE coalesce(cast(disb_all.Total_Disb_Amount as float),0)
END
as money))					as	"Disbs_Other_Billed",

sum(ba.sign*ba.Fees_amt+ba.sign*ba.hard_amt+ba.sign*ba.soft_amt+ba.sign*tax_amt)
							as	"Total_Billed"

FROM 
[blt_bill_amt]			ba

left outer join
	(
	SELECT adr_disb.bill_tran_uno, SUM(adr_disb.billed_amt)	as	"C_E_Amount"
	FROM [CDT_Disb] adr_disb
	left outer join [APT_Invoice] adr_invoice on adr_disb.Source_Tran_Uno = adr_invoice.Tran_Uno
	left outer join	[APL_APType] adr_aptype on adr_invoice.APType_Code = adr_aptype.APType_Code
	WHERE adr_aptype.APType_Code In('EXP','COU')
	GROUP BY adr_disb.bill_tran_uno
	)					disb_CE
	on ba.bill_tran_uno = disb_ce.bill_tran_uno

left outer join
	(
	SELECT adr_disb.bill_tran_uno, SUM(adr_disb.billed_amt)	as	"Total_Disb_Amount"
	FROM [CDT_Disb] adr_disb
	GROUP BY  adr_disb.bill_tran_uno
	)					disb_all
	on ba.bill_tran_uno = disb_all.bill_tran_uno


WHERE	[TC_TOTAL_AMT]<>0
and		[tran_type] In ('BL','BLX','CN','CNX')
and		[payr_client_uno] In (select client_uno from hbm_client where clnt_cat_code In (select  clnt_cat_code from hbl_clnt_cat where group_code = 'LV'))

GROUP BY
ba.Matter_uno