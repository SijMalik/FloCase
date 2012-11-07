
/****** Object:  StoredProcedure [dbo].[LTMM_Populate_LV_MI_Tables]    Script Date: 05/31/2012 10:48:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[LTMM_Populate_LV_MI_Tables]
AS

	-- =============================================
	-- Author: SMJ
	-- Create date: 31/05/2012
	-- Description:	Create tables for LV MI data
	-- =============================================	

	BEGIN TRY
		/***** TRUNCATE TABLES FIRST *****/
		TRUNCATE TABLE LVOffice
		TRUNCATE TABLE LVFinalBillDP
		TRUNCATE TABLE LVFeesBilled
		/***** TRUNCATE TABLES END *****/

		/***** LV OFFICE ******/
		SELECT
			m.[Matter_Uno],
			cud.[Client_Location] as "LV_Office"
		INTO 
			#AZOFF
		FROM
			[MAN81SQL\MANZ01C03].[AderantTrainBLM].[dbo].[HBM_MATTER] m
		inner join
			[MAN81SQL\MANZ01C03].[AderantTrainBLM].[dbo].[_HBM_CLIENT_USR_DATA] cud
			on m.client_uno = cud.client_uno
			
		INSERT INTO LVOffice (LVOffice_CaseID, LVOffice_AEMatter_Uno, LVOffice_Office, LVOffice_LastScheduledUpdateDate)
		SELECT ai.CaseID, ai.AExpert_MatterUno, a.LV_Office, GETDATE() FROM #AZOFF a
		INNER JOIN ApplicationInstance ai
		ON a.Matter_Uno = ai.AExpert_MatterUno			
		/***** LV OFFICE END******/	
	
	
		/***** DATE OF LAST ACTION (FINAL BILL PAID DATE) ******/
		SELECT 
		ba.[Matter_Uno],
		ba.[Bill_Tran_uno],
		b.[Bill_Date],
		ba.[Billp_uno],
		bp.[FEES_AR]+bp.[HARD_AR]+bp.[SOFT_AR]+bp.[TAX_AR]+bp.[OAFEE_AR]+bp.[OADISB_AR]+bp.[RETAINER_AR]+bp.[PREMDISC_AR]+bp.[INTEREST_AR]				as	"Tot_AR"
		INTO
		#LVBTMP1
		FROM 
		[MAN81SQL\MANZ01C03].[AderantTrainBLM].[dbo].[blt_bill_amt]			ba 
		inner join 
			[MAN81SQL\MANZ01C03].[AderantTrainBLM].[dbo].[blt_bill]			b 
			on ba.bill_tran_uno = b.tran_uno
		inner join
			[MAN81SQL\MANZ01C03].[AderantTrainBLM].[dbo].[blt_billp]			bp
			on ba.billp_uno = bp.billp_uno
		WHERE 
		ba.[tran_type] In ('BL','BLX','CN','CNX') 
		and b.bill_num <> 0 
		and ba.[payr_client_uno] In (select client_uno from [MAN81SQL\MANZ01C03].[AderantTrainBLM].[dbo].hbm_client where clnt_cat_code In (select  clnt_cat_code from [MAN81SQL\MANZ01C03].[AderantTrainBLM].[dbo].hbl_clnt_cat where group_code = 'LV'))
		and ba.[Matter_uno] In (select matter_uno from [MAN81SQL\MANZ01C03].[AderantTrainBLM].[dbo].hbm_matter where status_code In('CLOSE','FINAL'))

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

		INTO 
		#LVBTMP2
		FROM
		#LVBTMP1 t

		inner join
			(SELECT Matter_uno, MAX(Bill_Date) as "Lst_Bill"
			FROM #LVBTMP1 GROUP BY Matter_Uno
			)				tsum
			on	t.matter_uno = tsum.matter_uno
			and	t.bill_date = tsum.lst_bill
			
		left outer join
			(SELECT Billp_uno, MAX(TRAN_DATE) as "Lst_Bill_Paid"
			FROM [MAN81SQL\MANZ01C03].[AderantTrainBLM].[dbo].[blt_bill_amt] 
			WHERE tran_type In ('RA','CR') GROUP BY Billp_uno
			)				paydate
			on t.billp_uno = paydate.billp_uno

		SELECT 
			[Matter_uno],
			MAX([FBill_Paid_Date]) as "Date_Of_Last_Action"
		INTO 
			#LVBTMP3
		FROM
			#LVBTMP2
		GROUP BY
			[matter_uno]
		HAVING
			MAX([FBill_Paid_Date])<=getdate()
			
		INSERT INTO LVFinalBillDP (LVFinalBillDP_CaseID, LVFinalBillDP_AEMatterUno, LVFinalBillDP_FinalBillDatePaid, LVFinalBillDP_LastScheduledUpdateDate)
		SELECT ai.CaseID, ai.AExpert_MatterUno, a.Date_Of_Last_Action , GETDATE() 
		FROM #LVBTMP3 a
		INNER JOIN ApplicationInstance ai
		ON a.Matter_Uno = ai.AExpert_MatterUno		
		/***** DATE OF LAST ACTION (FINAL BILL PAID DATE) ******/		

		/***** OWN FEES BILLED ******/	
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
		INTO #OwnFees
		FROM 
		[MAN81SQL\MANZ01C03].[AderantTrainBLM].[dbo].[blt_bill_amt]	ba
		left outer join
			(
			SELECT adr_disb.bill_tran_uno, SUM(adr_disb.billed_amt)	as	"C_E_Amount"
			FROM [MAN81SQL\MANZ01C03].[AderantTrainBLM].[dbo].[CDT_Disb] adr_disb
			left outer join [MAN81SQL\MANZ01C03].[AderantTrainBLM].[dbo].[APT_Invoice] adr_invoice on adr_disb.Source_Tran_Uno = adr_invoice.Tran_Uno
			left outer join	[MAN81SQL\MANZ01C03].[AderantTrainBLM].[dbo].[APL_APType] adr_aptype on adr_invoice.APType_Code = adr_aptype.APType_Code
			WHERE adr_aptype.APType_Code In('EXP','COU')
			GROUP BY adr_disb.bill_tran_uno
			)					disb_CE
			on ba.bill_tran_uno = disb_ce.bill_tran_uno
		left outer join
			(
			SELECT adr_disb.bill_tran_uno, SUM(adr_disb.billed_amt)	as	"Total_Disb_Amount"
			FROM [MAN81SQL\MANZ01C03].[AderantTrainBLM].[dbo].[CDT_Disb] adr_disb
			GROUP BY  adr_disb.bill_tran_uno
			)					disb_all
			on ba.bill_tran_uno = disb_all.bill_tran_uno
		WHERE	[TC_TOTAL_AMT]<>0
		and		[tran_type] In ('BL','BLX','CN','CNX')
		and		[payr_client_uno] In (select client_uno from [MAN81SQL\MANZ01C03].[AderantTrainBLM].[dbo].hbm_client where clnt_cat_code In (select  clnt_cat_code from [MAN81SQL\MANZ01C03].[AderantTrainBLM].[dbo].hbl_clnt_cat where group_code = 'LV'))
		GROUP BY
		ba.Matter_uno
		
		INSERT INTO LVFeesBilled (LVFeesBilled_CaseID, LVFeesBilled_AEMatterUno, LVFeesBilled_OwnFees, LVFeesBilled_DisbCouns, LVFeesBilled_DisbOther, LVFeesBilled_CostsTotal, LVFeesBilled_LastScheduledUpdateDate)
		SELECT ai.CaseID, ai.AExpert_MatterUno, a.Fees_Billed, a.Disbs_Counsel_Expert_Billed, a.Disbs_Other_Billed, a.Total_Billed, GETDATE() 
		FROM #OwnFees a
		INNER JOIN ApplicationInstance ai
		ON a.Matter_Uno = ai.AExpert_MatterUno			
		/***** OWN FEES BILLED END ******/	
		
		DROP TABLE #AZOFF
		DROP TABLE #LVBTMP1
		DROP TABLE #LVBTMP2
		DROP TABLE #LVBTMP3
		DROP TABLE #OwnFees


	END TRY


	BEGIN CATCH

		--DON'T REALLY NEED TO DROP TEMP TABLE AS THEY'LL GET DROPPED
		--IF SP BOMBS OUT, BUT SQL CAN SOMETIMES CACHE TEMP TABLES

		IF OBJECT_ID('tempdb..#AZOFF') IS NOT NULL 
			DROP TABLE #AZOFF

		IF OBJECT_ID('tempdb..#LVBTMP1') IS NOT NULL 
			DROP TABLE #LVBTMP1
		
		IF OBJECT_ID('tempdb..#LVBTMP2') IS NOT NULL 
			DROP TABLE #LVBTMP2
		
		IF OBJECT_ID('tempdb..#LVBTMP3') IS NOT NULL 
			DROP TABLE #LVBTMP3		

		IF OBJECT_ID('tempdb..#OwnFees') IS NOT NULL 
			DROP TABLE #OwnFees							
		------------------------
		
		SELECT ERROR_MESSAGE() + ' in SP:' + OBJECT_NAME(@@PROCID)

	END CATCH
	

