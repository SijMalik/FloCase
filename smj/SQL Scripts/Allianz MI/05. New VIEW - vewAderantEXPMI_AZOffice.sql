/****** Object:  View [dbo].[vewAderantEXPMI_AZOffice]    Script Date: 05/08/2012 16:29:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vewAderantEXPMI_AZOffice]
AS
SELECT
m.[Matter_Uno],
cud.[Client_Location] as "Instr_AZ_Office"

FROM
[MANZ01C03\MANZ01C03].[ADERANTLIVEBLM].[dbo].[HBM_MATTER]					m

inner join
	[MANZ01C03\MANZ01C03].[ADERANTLIVEBLM].[dbo].[_HBM_CLIENT_USR_DATA]		cud
	on m.client_uno = cud.client_uno




GO