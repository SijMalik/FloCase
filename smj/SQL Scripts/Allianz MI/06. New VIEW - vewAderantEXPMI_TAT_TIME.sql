/****** Object:  View [dbo].[vewAderantEXPMI_TAT_TIME]    Script Date: 05/08/2012 16:36:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vewAderantEXPMI_TAT_TIME]
AS
SELECT 
[MATTER_UNO],
MIN([TRAN_DATE]) as "First_Time_Posting"
FROM
[MAN81SQL\MANZ01C03].[AderantTrainBLM].[dbo].[TAT_TIME]
WHERE
WIP_STATUS Not In('X','N','C')
AND
BILLABLE_FLAG = 'B'
GROUP BY
[MATTER_UNO]



GO