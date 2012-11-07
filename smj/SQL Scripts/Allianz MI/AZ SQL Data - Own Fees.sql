
USE [ADERANTLIVEBLM]

SELECT
m.[CLIENT_CODE] + '-' + m.[MATTER_CODE],

m.[Matter_uno],
coalesce(bamt.[PC],0)+coalesce(bamt.[VAT],0)+coalesce(bamt.[PROG],0)+coalesce(bamt.[Retainer],0)-coalesce(bilm.[Credit],0)
				as	"BLM_Profit_Costs_Billed(to_AZ)",
coalesce(bamt.[PC],0)+coalesce(bamtall.[VATALL],0)+coalesce(bamt.[PROG],0)+coalesce(bamt.[Retainer],0)-coalesce(bilm.[Credit],0)+coalesce(bamt.[Disbs],0)
				as	"BLM_Costs_Billed",
coalesce(bamtcfa.[PC],0)+coalesce(bamtcfa.[VAT],0)+coalesce(bamtcfa.[Disbs],0)
				as	"CCFA_Billed"

FROM
[HBM_MATTER]				m

left outer join
	(
	SELECT [Matter_Uno],SUM([Fees_amt]*[Sign]) as"PC",SUM([TAX_amt]*[Sign]) as "VAT",SUM([PROGRESS_AMT]*[SIGN]) as "Prog",SUM([RETAINER_AMT]*[SIGN]) as "Retainer",SUM(([HARD_AMT]+[SOFT_AMT])*[SIGN]) as "Disbs"
	FROM [blt_bill_amt]
	WHERE [tran_type] In ('BL','BLX','CN','CNX') and [bill_tran_uno] Not In (select tran_uno from blt_bill where bill_num = 0) and [payr_client_uno] In (select client_uno from hbm_client where clnt_cat_code In (select  clnt_cat_code from hbl_clnt_cat where group_code = 'AZ'))
	GROUP BY [Matter_Uno]
	)						bamt
	on m.matter_uno = bamt.matter_uno

left outer join
	(
	SELECT [Matter_uno], SUM([Credit_Tot]) as"Credit"
	FROM [blt_billm]
	WHERE [AR_Status] <> 'X'
	GROUP BY [Matter_Uno]
	)						bilm
	on m.matter_uno = bilm.matter_uno

left outer join
	(
	SELECT [Matter_Uno],SUM([TAX_amt]*[Sign]) as "VATALL"
	FROM [blt_bill_amt]
	WHERE [tran_type] In ('BL','BLX','CN','CNX') and [bill_tran_uno] Not In (select tran_uno from blt_bill where bill_num = 0) 
	GROUP BY [Matter_Uno]
	)						bamtall
	on m.matter_uno = bamtall.matter_uno

left outer join
	(
	SELECT [Matter_Uno],SUM([Fees_amt]*[Sign]) as"PC",SUM([TAX_amt]*[Sign]) as "VAT",SUM(([HARD_AMT]+[SOFT_AMT])*[SIGN]) as "Disbs"
	FROM [blt_bill_amt]
	WHERE [tran_type] In ('BL','BLX','CN','CNX') and [bill_tran_uno] Not In (select tran_uno from blt_bill where bill_num = 0) and [payr_client_uno] In (select client_uno from hbm_client where clnt_cat_code In (select  clnt_cat_code from hbl_clnt_cat where Client_name = '%CFA%'))
	GROUP BY [Matter_Uno]
	)						bamtcfa
	on m.matter_uno = bamtcfa.matter_uno
