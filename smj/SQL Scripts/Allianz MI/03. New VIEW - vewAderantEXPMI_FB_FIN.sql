/****** Object:  View [dbo].[vewAderantEXPMI_FB_FIN]    Script Date: 05/08/2012 16:33:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vewAderantEXPMI_FB_FIN]
AS
SELECT 
[Matter_uno],
MAX([Bill_Date])		as	"Final_Bill_Date"
FROM
vewAderantEXPMI_FB_AND_FBP_DATE_T2
GROUP BY
matter_uno
GO