USE [ADERANTLIVEBLM]

SELECT
m.[Matter_Uno],
cud.[Client_Location] as "Instr_AZ_Office"

FROM
[HBM_MATTER]					m

inner join
	[_HBM_CLIENT_USR_DATA]		cud
	on m.client_uno = cud.client_uno

