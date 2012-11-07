/****** Object:  View [dbo].[vewAderantEXPMI_FB_AND_FBP_DATE_T1]    Script Date: 05/08/2012 16:30:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vewAderantEXPMI_FB_AND_FBP_DATE_T1]
AS
SELECT 
ba.[Matter_Uno],
ba.[Bill_Tran_uno],
b.[Bill_Date],
ba.[Billp_uno],
bp.[FEES_AR]+bp.[HARD_AR]+bp.[SOFT_AR]+bp.[TAX_AR]+bp.[OAFEE_AR]+bp.[OADISB_AR]+bp.[RETAINER_AR]+bp.[PREMDISC_AR]+bp.[INTEREST_AR]				as	"Tot_AR"

FROM 
[MANZ01C03\MANZ01C03].[ADERANTLIVEBLM].[dbo].[blt_bill_amt]			ba 
inner join 
[MANZ01C03\MANZ01C03].[ADERANTLIVEBLM].[dbo].[blt_bill]			b 
	on ba.bill_tran_uno = b.tran_uno
inner join
[MANZ01C03\MANZ01C03].[ADERANTLIVEBLM].[dbo].[blt_billp] bp
	on ba.billp_uno = bp.billp_uno
WHERE 
ba.[tran_type] In ('BL','BLX','CN','CNX') 
and b.bill_num <> 0 
and ba.[payr_client_uno] In (select client_uno from [MANZ01C03\MANZ01C03].[ADERANTLIVEBLM].[dbo].hbm_client where clnt_cat_code In (select  clnt_cat_code from [MANZ01C03\MANZ01C03].[ADERANTLIVEBLM].[dbo].hbl_clnt_cat where group_code = 'AZ'))
and ba.[Matter_uno] In (select matter_uno from [MANZ01C03\MANZ01C03].[ADERANTLIVEBLM].[dbo].hbm_matter where status_code In('CLOSE','FINAL'))

GO