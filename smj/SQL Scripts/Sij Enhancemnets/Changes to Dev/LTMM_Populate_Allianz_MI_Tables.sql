
ALTER PROCEDURE [dbo].[LTMM_Populate_Allianz_MI_Tables]
AS

	-- =============================================
	-- Author: SMJ
	-- Create date: 10/05/2012
	-- Description:	Create tables for Allianz MI data
	-- =============================================	
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		2
	-- Modify date: 02-09-2012
	-- Description:	Changed error handling, added WITH (NOLOCK), added schema names
	-- ===============================================================		
	-- ===============================================================
	-- Author:		SMJ
	-- Version:		3
	-- Modify date: 03-09-2012
	-- Description:	Changed all code to use dynamic SQL to use replicated Aderant DB
	-- ===============================================================			
DECLARE @DynSQL NVARCHAR(MAX)

	BEGIN TRY
		/***** TRUNCATE TABLES FIRST *****/
		TRUNCATE TABLE AllianzBillDates
		TRUNCATE TABLE AllianzBills
		TRUNCATE TABLE AllianzOffice
		TRUNCATE TABLE AllianzPostingDates
		/***** TRUNCATE TABLES END *****/	
		
		/***** FINAL BILL DATES ******/
		--STAGE 1
		SELECT @DynSQL = '
			SELECT 
				ba.[Matter_Uno],
				ba.[Bill_Tran_uno],
				b.[Bill_Date],
				ba.[Billp_uno],
				bp.[FEES_AR]+bp.[HARD_AR]+bp.[SOFT_AR]+bp.[TAX_AR]+bp.[OAFEE_AR]+bp.[OADISB_AR]+bp.[RETAINER_AR]+bp.[PREMDISC_AR]+bp.[INTEREST_AR] as "Tot_AR"
			INTO
				#AZBTMP1
			FROM ' + 
				+ SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].[blt_bill_amt]	ba WITH (NOLOCK)
				inner join '
				+ SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].[blt_bill] b WITH (NOLOCK)
				on ba.bill_tran_uno = b.tran_uno
				inner join ' + + SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].[blt_billp] bp WITH (NOLOCK)
				on ba.billp_uno = bp.billp_uno
			WHERE 
				ba.[tran_type] In (''BL'',''BLX'',''CN'',''CNX'') 
				and b.bill_num <> 0 
				and ba.[payr_client_uno] In (select client_uno from ' + SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].hbm_client WITH (NOLOCK) where clnt_cat_code In (select  clnt_cat_code from ' + SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].hbl_clnt_cat WITH (NOLOCK) where group_code = ''AZ''))
				and ba.[Matter_uno] In (select matter_uno from '+ SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].hbm_matter WITH (NOLOCK) where status_code In(''CLOSE'',''FINAL''))'
			FROM SystemSettings				

		--STAGE 2
		SELECT @DynSQL = @DynSQL + ' 
			
			SELECT
				t.[Matter_Uno],
				t.[Bill_Date],
				t.[Billp_uno],
				t.[Tot_AR],
				CASE
					WHEN t.[Tot_AR]>0
					THEN DATEADD(yy,10,getdate())
					ELSE COALESCE(paydate.[Lst_Bill_Paid],t.[Bill_Date])
				END	as	"FBill_Paid_Date"
			INTO 
				#AZBTMP2
			FROM
				#AZBTMP1 t WITH (NOLOCK)
				inner join
					(SELECT Matter_uno, MAX(Bill_Date) as "Lst_Bill"
					FROM #AZBTMP1 WITH (NOLOCK) GROUP BY Matter_Uno
					)				tsum
					on	t.matter_uno = tsum.matter_uno
					and	t.bill_date = tsum.lst_bill
				left outer join
					(SELECT Billp_uno, MAX(TRAN_DATE) as "Lst_Bill_Paid"
					FROM ' + SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].[blt_bill_amt] WITH (NOLOCK)
					WHERE tran_type In (''RA'',''CR'') GROUP BY Billp_uno
					)				paydate
					on t.billp_uno = paydate.billp_uno'
			FROM SystemSettings
					
		SELECT @DynSQL = @DynSQL +  '	
			
			--STAGE3			
			SELECT 
				[Matter_uno],
				MAX([Bill_Date]) as	"Final_Bill_Date"
			INTO 
				#AZBTMP3
			FROM
				#AZBTMP2 WITH (NOLOCK)
			GROUP BY
				[Matter_uno]

			--STAGE 4
			SELECT 
				[Matter_uno],
				MAX([FBill_Paid_Date]) as "Final_Bill_Paid_Date"
			INTO 
				#AZBTMP4
			FROM
				#AZBTMP2 WITH (NOLOCK)
			GROUP BY
				[matter_uno]
			HAVING
				MAX([FBill_Paid_Date])<=getdate()
				


			--INSERT FINAL BILL DATE AND FINAL BILL DATE PAID
			INSERT INTO AllianzBillDates (AllianzBillDates_CaseID, AllianzBillDates_AEMatterUno,AllianzBillDates_FinalBillDate, AllianzBillDates_FinalBillDatePaid, AllianzBillDates_LastScheduledUpdateDate)	
			SELECT ai.CaseID, ai.AExpert_MatterUno,  a.Final_Bill_Date, b.Final_Bill_Paid_Date, GETDATE() 
			FROM #AZBTMP3 a WITH (NOLOCK) FULL OUTER JOIN #AZBTMP4 b WITH (NOLOCK)
			ON a.Matter_Uno = b.Matter_Uno
			INNER JOIN ApplicationInstance ai
			ON a.Matter_Uno = ai.AExpert_MatterUno

			--DROP TEMP TABLES JUST TO BE SAFE
			DROP TABLE #AZBTMP1
			DROP TABLE #AZBTMP2
			DROP TABLE #AZBTMP3
			DROP TABLE #AZBTMP4'
			
			EXEC sp_executesql @Dynsql			
			/***** FINAL BILL DATES END******/

		SELECT @DynSQL = ''
		
			/***** DATE FIRST POSTING ******/
		SELECT @DynSQL = '
		
			SELECT 
				[MATTER_UNO],
				MIN([TRAN_DATE]) as "First_Time_Posting"
			INTO
				#AZFTP
			FROM '
				+ SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].[TAT_TIME] WITH (NOLOCK)
			WHERE
				WIP_STATUS Not In(''X'',''N'',''C'')
			AND
				BILLABLE_FLAG = ''B''
			GROUP BY
				[MATTER_UNO]'
			FROM SystemSettings
			
	SELECT @DynSQL = @DynSQL + '
				
			INSERT INTO AllianzPostingDates (AllianzPostingDates_CaseID,AllianzPostingDates_AEMatter_Uno,AllianzPostingDates_FirstTimePosting,AllianzPostingDates_LastScheduledUpdateDate)
			SELECT ai.CaseID, ai.AExpert_MatterUno, a.First_Time_Posting, GETDATE() FROM #AZFTP a WITH (NOLOCK)
			INNER JOIN ApplicationInstance ai
			on a.Matter_Uno = ai.AExpert_MatterUno

			DROP TABLE #AZFTP'
			
			EXEC sp_executesql @Dynsql	
						
			/***** DATE FIRST POSTING END******/	
			
			SELECT @DynSQL = ''						
			
			/***** ALLIANZ OFFICE ******/
			SELECT @DynSQL = '
			SELECT
				m.[Matter_Uno],
				cud.[Client_Location] as "Instr_AZ_Office"
			INTO 
				#AZOFF
			FROM '
				+ SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].[HBM_MATTER] m WITH (NOLOCK)
			inner join '
				+ SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].[_HBM_CLIENT_USR_DATA] cud WITH (NOLOCK)
				on m.client_uno = cud.client_uno'
			FROM SystemSettings 

			SELECT @DynSQL = @DynSQL + '
							
			INSERT INTO AllianzOffice (AllianzOffice_CaseID, AllianzOffice_AEMatter_Uno, AllianzOffice_Office, AllianzOffice_LastScheduledUpdateDate)
			SELECT ai.CaseID, ai.AExpert_MatterUno, a.Instr_AZ_Office, GETDATE() FROM #AZOFF a WITH (NOLOCK)
			INNER JOIN dbo.ApplicationInstance ai WITH (NOLOCK)
			ON a.Matter_Uno = ai.AExpert_MatterUno	
					
			DROP TABLE #AZOFF'
			
			EXEC sp_executesql @Dynsql	
			
			/***** ALLIANZ OFFICE END ******/

			SELECT @DynSQL = ''
			
			/***** ALLIANZ BILLS ******/		
			SELECT @DynSQL = '
			
			SELECT
				m.[CLIENT_CODE] + ''-'' + m.[MATTER_CODE] AS "ClI_MAT_CODE",
				m.[Matter_uno],
				coalesce(bamt.[PC],0)+coalesce(bamt.[VAT],0)+coalesce(bamt.[PROG],0)+coalesce(bamt.[Retainer],0)-coalesce(bilm.[Credit],0)
							as	"BLM_Profit_Costs_Billed",
				coalesce(bamt.[PC],0)+coalesce(bamtall.[VATALL],0)+coalesce(bamt.[PROG],0)+coalesce(bamt.[Retainer],0)-coalesce(bilm.[Credit],0)+coalesce(bamt.[Disbs],0)
							as	"BLM_Costs_Billed",
				coalesce(bamtcfa.[PC],0)+coalesce(bamtcfa.[VAT],0)+coalesce(bamtcfa.[Disbs],0)
							as	"CCFA_Billed"
			INTO 
				#AZBILLS
			FROM '
			+ SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].[HBM_MATTER] m WITH (NOLOCK)
			left outer join
				(
				SELECT [Matter_Uno],SUM([Fees_amt]*[Sign]) as"PC",SUM([TAX_amt]*[Sign]) as "VAT",SUM([PROGRESS_AMT]*[SIGN]) as "Prog",SUM([RETAINER_AMT]*[SIGN]) as "Retainer",SUM(([HARD_AMT]+[SOFT_AMT])*[SIGN]) as "Disbs"
				FROM ' + SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].[blt_bill_amt] WITH (NOLOCK)
				WHERE [tran_type] In (''BL'',''BLX'',''CN'',''CNX'') and [bill_tran_uno] Not In (select tran_uno from ' + SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].blt_bill WITH (NOLOCK) where bill_num = 0) and [payr_client_uno] In (select client_uno from ' + SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].hbm_client where clnt_cat_code In (select  clnt_cat_code from ' + SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].hbl_clnt_cat where group_code = ''AZ''))
				GROUP BY [Matter_Uno]
				) bamt 
				on m.matter_uno = bamt.matter_uno

			left outer join
				(
				SELECT [Matter_uno], SUM([Credit_Tot]) as"Credit"
				FROM ' + SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].[blt_billm] WITH (NOLOCK)
				WHERE [AR_Status] <> ''X''
				GROUP BY [Matter_Uno]
				) bilm 
				on m.matter_uno = bilm.matter_uno
			left outer join
				(
				SELECT [Matter_Uno],SUM([TAX_amt]*[Sign]) as "VATALL"
				FROM ' + SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].[blt_bill_amt] WITH (NOLOCK)
				WHERE [tran_type] In (''BL'',''BLX'',''CN'',''CNX'') and [bill_tran_uno] Not In (select tran_uno from ' + SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].blt_bill WITH (NOLOCK) where bill_num = 0) 
				GROUP BY [Matter_Uno]
				) bamtall
				on m.matter_uno = bamtall.matter_uno
			left outer join
				(
				SELECT [Matter_Uno],SUM([Fees_amt]*[Sign]) as"PC",SUM([TAX_amt]*[Sign]) as "VAT",SUM(([HARD_AMT]+[SOFT_AMT])*[SIGN]) as "Disbs"
				FROM ' + SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings.SystemSettings_ADERANTEXPERTDB + '.[dbo].[blt_bill_amt] WITH (NOLOCK)
				WHERE [tran_type] In (''BL'',''BLX'',''CN'',''CNX'') and [bill_tran_uno] Not In (select tran_uno from ' + SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].blt_bill WITH (NOLOCK) where bill_num = 0) and [payr_client_uno] In (select client_uno from ' + SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].hbm_client where clnt_cat_code In (select  clnt_cat_code from ' + SystemSettings_ADERANTEXPERTSERVER + '.' + SystemSettings_ADERANTEXPERTDB + '.[dbo].hbl_clnt_cat where Client_name LIKE ''%CFA%''))
				GROUP BY [Matter_Uno]
				) bamtcfa
				on m.matter_uno = bamtcfa.matter_uno'
				FROM systemsettings				

			SELECT @DynSQL = @DynSQL + '
							
				INSERT INTO AllianzBills (AllianzBills_CaseID,AllianzBills_AEMatterUno,AllianzBills_BLMProf,AllianzBills_BLMCosts,AllianzBills_CCFA,AllianzBills_LastScheduledUpdateDate)
				SELECT ai.CaseID, ai.AExpert_MatterUno, a.BLM_Profit_Costs_Billed, a.BLM_Costs_Billed, a.CCFA_Billed, GETDATE() FROM #AZBILLS a WITH (NOLOCK)
				INNER JOIN dbo.ApplicationInstance ai WITH (NOLOCK)
				ON a.Matter_Uno = ai.AExpert_MatterUno	
				
				DROP TABLE #AZBILLS'

			EXEC sp_executesql @Dynsql					
			/***** ALLIANZ BILLS END******/
			
			SELECT @DynSQL = ''
	END TRY


	BEGIN CATCH

		--DON'T REALLY NEED TO DROP TEMP TABLE AS THEY'LL GET DROPPED
		--WHEN SP BOMBS OUT, BUT SQL CAN SOMETIMES CACHE TEMP TABLES
		IF OBJECT_ID('tempdb..#AZBTMP1') IS NOT NULL 
			DROP TABLE #AZBTMP1
			
		IF OBJECT_ID('tempdb..#AZBTMP2') IS NOT NULL 
			DROP TABLE #AZBTMP2

		IF OBJECT_ID('tempdb..#AZBTMP3') IS NOT NULL 
			DROP TABLE #AZBTMP3

		IF OBJECT_ID('tempdb..#AZBTMP4') IS NOT NULL 
			DROP TABLE #AZBTMP4
			
		IF OBJECT_ID('tempdb..#AZFTP') IS NOT NULL 
			DROP TABLE #AZFTP		
			
		IF OBJECT_ID('tempdb..#AZOFF') IS NOT NULL 
			DROP TABLE #AZOFF				

		IF OBJECT_ID('tempdb..#AZBILLS') IS NOT NULL 
			DROP TABLE #AZBILLS	
		------------------------
		
		SELECT ERROR_MESSAGE() + ' SP:' + OBJECT_NAME(@@PROCID)

	END CATCH
	

