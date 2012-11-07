/****** Object:  View [dbo].[vewAderantEXPMI_FBP_DATE_FIN]    Script Date: 05/08/2012 16:33:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vewAderantEXPMI_FBP_DATE_FIN]
AS
SELECT 
[Matter_uno],
MAX([FBill_Paid_Date])		as	"Final_Bill_Paid_Date"
FROM
vewAderantEXPMI_FB_AND_FBP_DATE_T2
GROUP BY
matter_uno
HAVING
MAX([FBill_Paid_Date])<=getdate()
GO

