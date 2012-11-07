/****** Object:  View [dbo].[vewAderantEXPMI_FB_AND_FBP_DATE_T2]    Script Date: 05/08/2012 16:32:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vewAderantEXPMI_FB_AND_FBP_DATE_T2]
AS
SELECT
t.[Matter_Uno],
t.[Bill_Date],
t.[Billp_uno],
t.[Tot_AR],
CASE
	WHEN t.[Tot_AR]>0
	THEN DATEADD(yy,10,getdate())
	ELSE COALESCE(paydate.[Lst_Bill_Paid],t.[Bill_Date])
END			as	"FBill_Paid_Date"
FROM
vewAderantEXPMI_FB_AND_FBP_DATE_T1			t

inner join
	(SELECT Matter_uno, MAX(Bill_Date) as "Lst_Bill"
	FROM vewAderantEXPMI_FB_AND_FBP_DATE_T1 GROUP BY Matter_Uno
	)				tsum
	on	t.matter_uno = tsum.matter_uno
	and	t.bill_date = tsum.lst_bill
	
left outer join
	(SELECT Billp_uno, MAX(TRAN_DATE) as "Lst_Bill_Paid"
	FROM [MANZ01C03\MANZ01C03].[ADERANTLIVEBLM].[dbo].[blt_bill_amt] 
	WHERE tran_type In ('RA','CR') GROUP BY Billp_uno
	)				paydate
	on t.billp_uno = paydate.billp_uno
GO
