--------------------------- Rahma add Feed FeedKPIDeliveryRate 10/05/2021 -------------------------



/****** Object:  StoredProcedure [Reporting].[FeedKPIDeliveryRate]    Script Date: 10/05/2021 15:52:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


 


CREATE PROCEDURE [Reporting].[FeedKPIDeliveryRate]
AS 
BEGIN

 

DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
--*************************Select Data For Delivery Rate *************************--
BEGIN TRY   
    



--DROP TABLE #TempS1

 

--Sales Order
SELECT 
IdDocumentLine,
ItemQuantity,
DocumentMonth,
DocumentYear

 

INTO #TempS1
 
FROM [Reporting].[FctSales]

 

WHERE DocumentTypeCode LIKE '%O-SA%' 
AND IdStatus != 1 AND IdStatus !=2 

 

--DROP TABLE #TempS2

 
--Bon De Livraison
SELECT 
sale.IdDocumentLine,
t.IdDocumentLine AS IdDocumentLineAssociated,
sale.ItemQuantity,
sale.DocumentMonth,
sale.DocumentYear

 


INTO #TempS2 

 

FROM [Reporting].[FctSales] sale
LEFT JOIN #TempS1 t ON t.IdDocumentLine=sale.IdDocumentLineAssociated

 

WHERE sale.IdDocumentLineAssociated=t.IdDocumentLine


--Purchases Order

--DROP TABLE #TempP1


SELECT 
IdDocumentLine,
ItemQuantity,
DocumentMonth,
DocumentYear

 

INTO #TempP1
 
FROM [Reporting].[FctPurchases]

 

WHERE DocumentTypeCode LIKE '%O-PU%' 
AND IdStatus != 1 AND IdStatus !=2 

 

--DROP TABLE #TempP2

 
--Bon De Livraison
SELECT 
purchase.IdDocumentLine,
t.IdDocumentLine AS IdDocumentLineAssociated,
purchase.ItemQuantity,
purchase.DocumentMonth,
purchase.DocumentYear

 


INTO #TempP2 

 

FROM [Reporting].[FctPurchases] purchase
LEFT JOIN #TempP1 t ON t.IdDocumentLine=purchase.IdDocumentLineAssociated

 

WHERE purchase.IdDocumentLineAssociated=t.IdDocumentLine

--Delivery Rate

SELECT *

 INTO #Final
 
 FROM (

 --SALES
 --By Month
SELECT
 

SUM(t1.ItemQuantity) AS TotalCommanded,
SUM(t2.ItemQuantity) AS TotalDelivred,
CAST(SUM(t2.ItemQuantity) AS FLOAT)/CAST(SUM(t1.ItemQuantity) AS FLOAT) AS DeliveryRate,
t1.DocumentMonth,
t1.DocumentYear,
p.PeriodEnum,
p.Period, 
p.StartPeriod, 
p.EndPeriod,
'SA' AS [Type]


 

FROM #TempS2 t2
LEFT JOIN #TempS1 t1 ON t1.IdDocumentLine=t2.IdDocumentLineAssociated
CROSS JOIN Reporting.ParameterPeriod p
WHERE t1.DocumentMonth=t2.DocumentMonth AND
DATEFROMPARTS(t1.DocumentYear,t1.DocumentMonth, 1) BETWEEN StartPeriod AND EndPeriod

GROUP BY t1.DocumentMonth, t1.DocumentYear,p.PeriodEnum, p.Period, p.StartPeriod, p.EndPeriod

UNION ALL

--ByPeriod
SELECT

 
SUM(t1.ItemQuantity) AS TotalCommanded,
SUM(t2.ItemQuantity) AS TotalDelivred,
CAST(SUM(t2.ItemQuantity) AS FLOAT)/CAST(SUM(t1.ItemQuantity) AS FLOAT) AS DeliveryRate,
null as DocumentMonth,
null as DocumentYear,
p.PeriodEnum,
p.Period, 
p.StartPeriod, 
p.EndPeriod,
'SA' AS [Type]


 

FROM #TempS2 t2
LEFT JOIN #TempS1 t1 ON t1.IdDocumentLine=t2.IdDocumentLineAssociated
CROSS JOIN Reporting.ParameterPeriod p
WHERE t1.DocumentMonth=t2.DocumentMonth AND
DATEFROMPARTS(t1.DocumentYear,t1.DocumentMonth, 1) BETWEEN StartPeriod AND EndPeriod

GROUP BY p.PeriodEnum, p.Period, p.StartPeriod, p.EndPeriod

UNION ALL

 --PURCHASES
 --By Month
SELECT
 

SUM(t1.ItemQuantity) AS TotalCommanded,
SUM(t2.ItemQuantity) AS TotalDelivred,
CAST(SUM(t2.ItemQuantity) AS FLOAT)/CAST(SUM(t1.ItemQuantity) AS FLOAT) AS DeliveryRate,
t1.DocumentMonth,
t1.DocumentYear,
p.PeriodEnum,
p.Period, 
p.StartPeriod, 
p.EndPeriod,
'PU' AS [Type]


 

FROM #TempP2 t2
LEFT JOIN #TempP1 t1 ON t1.IdDocumentLine=t2.IdDocumentLineAssociated
CROSS JOIN Reporting.ParameterPeriod p
WHERE t1.DocumentMonth=t2.DocumentMonth AND
DATEFROMPARTS(t1.DocumentYear,t1.DocumentMonth, 1) BETWEEN StartPeriod AND EndPeriod

GROUP BY t1.DocumentMonth, t1.DocumentYear,p.PeriodEnum, p.Period, p.StartPeriod, p.EndPeriod

UNION ALL

--ByPeriod
SELECT

 
SUM(t1.ItemQuantity) AS TotalCommanded,
SUM(t2.ItemQuantity) AS TotalDelivred,
CAST(SUM(t2.ItemQuantity) AS FLOAT)/CAST(SUM(t1.ItemQuantity) AS FLOAT) AS DeliveryRate,
null as DocumentMonth,
null as DocumentYear,
p.PeriodEnum,
p.Period, 
p.StartPeriod, 
p.EndPeriod,
'PU' AS [Type]


 

FROM #TempP2 t2
LEFT JOIN #TempP1 t1 ON t1.IdDocumentLine=t2.IdDocumentLineAssociated
CROSS JOIN Reporting.ParameterPeriod p
WHERE t1.DocumentMonth=t2.DocumentMonth AND
DATEFROMPARTS(t1.DocumentYear,t1.DocumentMonth, 1) BETWEEN StartPeriod AND EndPeriod

GROUP BY p.PeriodEnum, p.Period, p.StartPeriod, p.EndPeriod

)C
        

 

TRUNCATE TABLE [Reporting].[KPIDeliveryRate]

 

INSERT INTO [Reporting].[KPIDeliveryRate]
            ([TotalCommanded]
            ,[TotalDelivred]
            ,[DeliveryRate]
            ,[DocumentMonth]
            ,[DocumentYear]
            ,[PeriodEnum]
            ,[Period]
            ,[StartPeriod]
            ,[EndPeriod]
			,[Type]
            )

 


SELECT * FROM #Final

 


    SET @NbInserted = @@ROWCOUNT

 

END TRY

 

BEGIN CATCH 
    SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPIDeliveryRate', @NbInserted, GETDATE(), @ErrorMessage
END
GO




------------------------------Rahma add GetKPIDeliveryRate 10/05/2021---------------------------------


/****** Object:  StoredProcedure [Reporting].[GetKPIDeliveryRate]    Script Date: 10/05/2021 15:59:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


 

CREATE PROCEDURE [Reporting].[GetKPIDeliveryRate]

--Parameters

 @Period tinyint= 5,
 @OperationType nvarchar(5)='PU',
 @ByMonth bit = 1


AS
BEGIN


--**************************Select Statement To Load Data*******************************************--

IF @ByMonth = 1

	SELECT *
	FROM [Reporting].[KPIDeliveryRate]
	WHERE (PeriodEnum = @Period OR @Period IS NULL) AND (DocumentMonth IS NOT NULL)
	AND [Type] =  @OperationType

IF @ByMonth = 0

    SELECT *
	FROM [Reporting].[KPIDeliveryRate]
	WHERE (PeriodEnum = @Period OR @Period IS NULL) AND (DocumentMonth IS NULL)
	AND [Type] =  @OperationType
	



END



GO

--------------------Rahma delete garage proc 10/05/2021-------------------------------

DROP PROCEDURE [Reporting].[FeedDimCustomerParts]
GO
DROP PROCEDURE [Reporting].[FeedDimGarage]
GO
DROP PROCEDURE [Reporting].[FeedDimMachine]
GO
DROP PROCEDURE [Reporting].[FeedDimMileage]
GO
DROP PROCEDURE [Reporting].[FeedDimOperation]
GO
DROP PROCEDURE [Reporting].[FeedDimPost]
GO
DROP PROCEDURE [Reporting].[FeedDimReception]
GO
DROP PROCEDURE [Reporting].[FeedDimVehicle]
GO
DROP PROCEDURE [Reporting].[FeedFctIntervention]
GO
DROP PROCEDURE [Reporting].[FeedDimWorker]
GO
DROP PROCEDURE [Reporting].[FeedKPITotalInterventionPerGarage]
GO
DROP PROCEDURE [Reporting].[FeedKPITurnoverPerGarage]
GO
DROP PROCEDURE [Reporting].[GetKPITurnoverPerGarage]
GO
DROP PROCEDURE [Reporting].[GetKPITotalInterventionPerGarage]
GO
-------------------------------------------------------------------


----------------------------------Rahma alter FeedKPISalesPurchaseState 17/05/2021--------------------------------


/****** Object:  StoredProcedure [Reporting].[FeedKPISalesPurchaseState]    Script Date: 5/11/2021 1:16:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [Reporting].[FeedKPISalesPurchaseState]
AS
BEGIN

--variables for LOG data
 DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

BEGIN TRY

--temporary data from fact tables
SELECT DISTINCT IdDocument, DocumentDate, MONTH(DocumentDate) AS Month, YEAR(DocumentDate) AS Year,  DocumentHTPrice, DocumentTTCPrice, DocumentRemainingAmount, DocumentTypeCode, 'SA' AS [Type]
INTO #temp
FROM [Reporting].[FctSales]
WHERE	 [DocumentTypeCode] LIKE 'I-SA'
UNION ALL
SELECT DISTINCT IdDocument, DocumentDate, MONTH(DocumentDate) AS Month, YEAR(DocumentDate) AS Year,  DocumentHTPrice, DocumentTTCPrice, DocumentRemainingAmount, DocumentTypeCode, 'PU' AS [Type]
FROM [Reporting].[FctPurchases]
WHERE	 [DocumentTypeCode] LIKE 'I-PU'

--final calculation with period
SELECT *

INTO #final

FROM

(
--ByMonth
SELECT  ISNULL(SUM(sa.DocumentHTPrice),0) AS InvoiceAmountHT, 
		ISNULL(SUM(sa.DocumentTTCPrice),0) AS InvoiceAmountTTC, 
		ISNULL(SUM(sa.DocumentRemainingAmount),0) AS InvoiceRemainingAmount,
		sa.Month,
		sa.Year,
		sa.Type,
		p.PeriodEnum, 
		p.Period, 
		p.StartPeriod, 
		p.EndPeriod
	

FROM #temp sa
CROSS JOIN Reporting.ParameterPeriod p
WHERE sa.DocumentDate BETWEEN p.StartPeriod AND p.EndPeriod
GROUP BY 
PeriodEnum, Period, StartPeriod, EndPeriod, sa.Type, sa.Month, sa.Year

UNION ALL

--ByPeriod
SELECT  ISNULL(SUM(sa.DocumentHTPrice),0) AS InvoiceAmountHT, 
		ISNULL(SUM(sa.DocumentTTCPrice),0) AS InvoiceAmountTTC, 
		ISNULL(SUM(sa.DocumentRemainingAmount),0) AS InvoiceRemainingAmount,
		null AS Month,
		null AS Year,
		sa.Type,
		p.PeriodEnum, 
		p.Period, 
		p.StartPeriod, 
		p.EndPeriod


FROM #temp sa
CROSS JOIN Reporting.ParameterPeriod p
WHERE sa.DocumentDate BETWEEN p.StartPeriod AND p.EndPeriod
GROUP BY 
PeriodEnum, Period, StartPeriod, EndPeriod, sa.Type

)A

--YTD
SELECT
sa.*,
ISNULL(SUM(DISTINCT saytd.InvoiceAmountHT),0) AS YTDInvoiceAmountHT, 
ISNULL(SUM(DISTINCT saytd.InvoiceAmountTTC),0) AS YTDInvoiceAmountTTC
--SUM(salytd.InvoiceAmountHT) AS LYTDInvoiceAmountHT,
--SUM(salytd.InvoiceAmountTTC) AS LYTDInvoiceAmountTTC

INTO #FinaleYTD

FROM #final sa 
LEFT JOIN #final saytd WITH(NOLOCK) ON saytd.Year = sa.Year  AND saytd.Month <= sa.Month
AND sa.Period=saytd.Period AND sa.Type=saytd.Type 


GROUP BY sa.InvoiceAmountHT,sa.InvoiceAmountTTC,sa.InvoiceRemainingAmount,sa.Month,sa.Year,sa.Type
,sa.PeriodEnum, sa.Period, sa.StartPeriod, sa.EndPeriod

--LYTD
SELECT
sa.*,
ISNULL(SUM(DISTINCT salytd.InvoiceAmountHT),0) AS LYTDInvoiceAmountHT,
ISNULL(SUM(DISTINCT salytd.InvoiceAmountTTC),0) AS LYTDInvoiceAmountTTC

INTO #FinaleLYTD

FROM #final sa 
--LEFT JOIN #final salasty WITH(NOLOCK) ON sa.Year = salasty.Year +1 AND sa.Month = salasty.Month
--AND salasty.Type=sa.Type
LEFT JOIN #final salytd WITH(NOLOCK) ON sa.Year = salytd.Year +1  AND salytd.Month <= sa.Month
AND sa.Type=salytd.Type 


GROUP BY sa.InvoiceAmountHT,sa.InvoiceAmountTTC,sa.InvoiceRemainingAmount,sa.Month,sa.Year,sa.Type
,sa.PeriodEnum, sa.Period, sa.StartPeriod, sa.EndPeriod
--insert statement

TRUNCATE TABLE [Reporting].[KPISalesPurchasesState]

INSERT INTO [Reporting].[KPISalesPurchasesState]
           ([InvoiceAmountHT]
           ,[InvoiceAmountTTC]
           ,[InvoiceRemainingAmount]
           ,[Month]
           ,[Year]
           ,[Type]
           ,[PeriodEnum]
           ,[Period]
           ,[StartPeriod]
           ,[EndPeriod]
		   ,[YTDInvoiceAmountHT]
		   ,[YTDInvoiceAmountTTC]
		   ,[LYTDInvoiceAmountHT]
		   ,[LYTDInvoiceAmountTTC]

		   )

SELECT 
f1.*,
ISNULL(f2.LYTDInvoiceAmountHT,0),
ISNULL(f2.LYTDInvoiceAmountTTC,0)

FROM #FinaleYTD f1
LEFT JOIN #FinaleLYTD f2 ON f1.Month=f2.Month AND f1.Type=f2.Type 

GROUP BY f1.InvoiceAmountHT,f1.InvoiceAmountTTC,f1.InvoiceRemainingAmount,f1.Month,f1.Year,f1.Type
,f1.PeriodEnum, f1.Period, f1.StartPeriod, f1.EndPeriod,f1.YTDInvoiceAmountHT,f1.YTDInvoiceAmountTTC
,f2.LYTDInvoiceAmountHT,f2.LYTDInvoiceAmountTTC

SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPISalesPurchaseState', @NbInserted, GETDATE(), @ErrorMessage

END

------------------------------- Rahma alter GetKPISalesPurchaseState 17/05/2021-----------------------------------


/****** Object:  StoredProcedure [Reporting].[GetKPISalesPurchaseState]    Script Date: 5/17/2021 11:07:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [Reporting].[GetKPISalesPurchaseState]

--Parameters
  @Period tinyint= 3,
  @OperationType nvarchar(5)='SA',
  @ByMonth bit = 1


AS
BEGIN

--DECLARE @StartPeriod date, @EndPeriod date


--SET @StartPeriod = (SELECT StartPeriod FROM [Reporting].[ParameterPeriod] WHERE PeriodEnum = @Period) 
--SET @EndPeriod = (SELECT EndPeriod FROM [Reporting].[ParameterPeriod] WHERE PeriodEnum = @Period) 


IF @ByMonth = 1

	SELECT *
	FROM [Reporting].[KPISalesPurchasesState]
	WHERE (PeriodEnum = @Period OR @Period IS NULL) AND (Month IS NOT NULL)
	AND [Type] IN( SELECT VALUE FROM string_split(@OperationType, ','))

IF @ByMonth = 0

    SELECT *
	FROM [Reporting].[KPISalesPurchasesState]
	WHERE (PeriodEnum = @Period OR @Period IS NULL) AND (Month IS NULL)
	AND [Type] IN( SELECT VALUE FROM string_split(@OperationType, ','))


END

------------------------------- Rahma update FeedParameterReference 18/05/2021----------------------------------------------

 /****** Object:  StoredProcedure [Reporting].[FeedParameterReference]    Script Date: 18/05/2021 10:36:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE   [Reporting].[FeedParameterReference]
AS
BEGIN

TRUNCATE TABLE [Reporting].[ParameterReference]

INSERT INTO [Reporting].[ParameterReference] ( Reference, Code, LabelFr, LabelEng )

--interview

SELECT 'Interview' AS Reference, '1' AS Code,'Entretien demandé à tous les intervieweurs' AS LabelFr, 'Interview requested to all interviewers' AS LabelEng
UNION ALL
SELECT 'Interview' AS Reference, '2' AS Code, 'Disponibilité de tous les intervieweurs confirmée' AS LabelFr, 'All interviewers availability confirmed' AS LabelEng
UNION ALL
SELECT 'Interview' AS Reference, '3' AS Code, 'Entretien demandé au candidat' AS LabelFr, 'Interview requested to candidate' AS LabelEng
UNION ALL
SELECT 'Interview' AS Reference, '4' AS Code, 'Entretien confirmé par le candidat' AS LabelFr, 'Interview confirmed by candidate' AS LabelEng
UNION ALL
SELECT 'Interview' AS Reference, '5' AS Code, 'Entretien terminé' AS LabelFr, 'Interview done' AS LabelEng
UNION ALL
SELECT 'Interview' AS Reference, '6' AS Code, 'Entretien refusé' AS LabelFr, 'Interview refused' AS LabelEng
UNION ALL
SELECT 'Interview' AS Reference, '7' AS Code, 'Entretien reporté' AS LabelFr, 'Interview reported' AS LabelEng

UNION ALL --Gender

SELECT 'Sex' AS Reference, '1' AS Code, 'Homme' AS LabelFr, 'Male' AS LabelEng
UNION ALL
SELECT 'Sex' AS Reference, '2' AS Code, 'Femme' AS LabelFr, 'Female' AS LabelEng


UNION ALL --team
SELECT 'Team' AS Reference, '1' AS Code, 'Actif'  AS LabelFr, 'Active' AS LabelEng
UNION ALL
SELECT 'Team' AS Reference, '0' AS Code, 'Inactif' AS LabelFr, 'Inactive' AS LabelEng

UNION ALL --recruitement

SELECT 'Recruitement' AS Reference, '1' AS Code, 'Brouillon' AS LabelFr, 'Draft' AS LabelEng
UNION ALL
SELECT 'Recruitement' AS Reference, '2' AS Code, 'Candidature' AS LabelFr,'Candidacy' AS LabelEng
UNION ALL
SELECT 'Recruitement' AS Reference, '3' AS Code, 'Préselection' AS LabelFr,'Preselection' AS LabelEng
UNION ALL
SELECT 'Recruitement' AS Reference, '4' AS Code, 'Entretien' AS LabelFr,'Interview' AS LabelEng
UNION ALL
SELECT 'Recruitement' AS Reference, '5' AS Code, 'Evaluation' AS LabelFr,'Evaluation' AS LabelEng
UNION ALL
SELECT 'Recruitement' AS Reference, '6' AS Code, 'Sélection' AS LabelFr,'Selection' AS LabelEng
UNION ALL
SELECT 'Recruitement' AS Reference, '7' AS Code, 'Offre' AS LabelFr, 'Offer' AS LabelEng
UNION ALL
SELECT 'Recruitement' AS Reference, '8' AS Code, 'Embauche' AS LabelFr, 'Hiring' AS LabelEng
UNION ALL
SELECT 'Recruitement' AS Reference, '9' AS Code, 'Cloturé' AS LabelFr, 'Closed' AS LabelEng

UNION ALL --timesheet

SELECT 'TimeSheet' AS Reference, '0' AS Code, 'A faire' AS LabelFr, 'To do' AS LabelEng
UNION ALL
SELECT 'TimeSheet' AS Reference, '1' AS Code, 'Brouillon' AS LabelFr, 'Draft' AS LabelEng
UNION ALL
SELECT 'TimeSheet' AS Reference, '2' AS Code, 'Soumis' AS LabelFr, 'Sended' AS LabelEng
UNION ALL
SELECT 'TimeSheet' AS Reference, '3' AS Code, 'Partiellement validé' AS LabelFr, 'Partially validated' AS LabelEng
UNION ALL
SELECT 'TimeSheet' AS Reference, '4' AS Code, 'Validé' AS LabelFr, 'Validated' AS LabelEng
UNION ALL
SELECT 'TimeSheet' AS Reference, '5' AS Code, 'Corrigé' AS LabelFr, 'To rework' AS LabelEng

UNION ALL --leave

SELECT 'Leave' AS Reference, '1' AS Code, 'En attente' AS LabelFr, 'Waiting' AS LabelEng
UNION ALL
SELECT 'Leave' AS Reference, '2' AS Code, 'Accepté' AS LabelFr, 'Accepted' AS LabelEng
UNION ALL
SELECT 'Leave' AS Reference, '3' AS Code, 'Refusé' AS LabelFr, 'Refused' AS LabelEng
UNION ALL
SELECT 'Leave' AS Reference, '4' AS Code, 'Annulé' AS LabelFr, 'Canceled' AS LabelEng

UNION ALL --expense report

SELECT 'Expense Report' AS Reference, '1' AS Code, 'En attente' AS LabelFr, 'Waiting' AS LabelEng
UNION ALL
SELECT 'Expense Report' AS Reference, '2' AS Code, 'Accepté' AS LabelFr, 'Accepted' AS LabelEng
UNION ALL
SELECT 'Expense Report' AS Reference, '3' AS Code, 'Refusé' AS LabelFr, 'Refused' AS LabelEng

UNION ALL --document

SELECT 'Document' AS Reference, '1' AS Code, 'En attente' AS LabelFr, 'Waiting' AS LabelEng
UNION ALL
SELECT 'Document' AS Reference, '2' AS Code, 'Accepté' AS LabelFr, 'Accepted' AS LabelEng
UNION ALL
SELECT 'Document' AS Reference, '3' AS Code, 'Refusé' AS LabelFr, 'Refused' AS LabelEng

UNION ALL --session

SELECT 'Pay Session' AS Reference, '1' AS Code, 'Nouvelle' AS LabelFr, 'New' AS LabelEng
UNION ALL
SELECT 'Pay Session' AS Reference, '2' AS Code, 'Présence' AS LabelFr, 'Presence' AS LabelEng
UNION ALL
SELECT 'Pay Session' AS Reference, '3' AS Code, 'Prime' AS LabelFr, 'Bonus' AS LabelEng
UNION ALL
SELECT 'Pay Session' AS Reference, '4' AS Code, 'Bulletn De Paie' AS LabelFr, 'Payslip' AS LabelEng
UNION ALL
SELECT 'Pay Session' AS Reference, '5' AS Code, 'Fermé' AS LabelFr, 'Closed' AS LabelEng

UNION ALL --Financial Commitment

SELECT 'Financial Commitment' AS Reference, '1' AS Code, 'Soldé' AS LabelFr, 'Sold' AS LabelEng
UNION ALL
SELECT 'Financial Commitment' AS Reference, '2' AS Code, 'Partiellement soldé' AS LabelFr, 'Partially Sold' AS LabelEng
UNION ALL
SELECT 'Financial Commitment' AS Reference, '3' AS Code, 'Non soldé' AS LabelFr, 'Non Solded' AS LabelEng

UNION ALL --payment method


SELECT 'Payment Method' AS Reference, 'VIR' AS Code , 'Virement' AS LabelFr , 'Transfer' AS LabelEng
UNION ALL
SELECT 'Payment Method' AS Reference, 'ESP' AS Code, 'Espéce' AS LabelFr , 'Currency' AS LabelEng
UNION ALL
SELECT 'Payment Method' AS Reference, 'CB' AS Code, 'Carte Bancaire' AS LabelFr , 'Bank Card' AS LabelEng
UNION ALL
SELECT 'Payment Method' AS Reference, 'CHQ' AS Code, 'Chéque' AS LabelFr , 'Check' AS LabelEng
UNION ALL
SELECT 'Payment Method' AS Reference, 'TRT' AS Code, 'Traite' AS LabelFr , 'Treaty' AS LabelEng
UNION ALL
SELECT 'Payment Method' AS Reference, 'EXT BANCAIRE' AS Code, 'Extrait Bancaire' AS LabelFr , 'Banking receipt
' AS LabelEng



UNION ALL --payment status

SELECT 'Payment Status' AS Reference, 'NotCashed' AS Code , 'Non encaissé' AS LabelFr , 'Not Cashed' AS LabelEng
UNION ALL
SELECT 'Payment Status' AS Reference, 'Cashed' AS Code , 'Encaissé' AS LabelFr , 'Cashed' AS LabelEng
UNION ALL
SELECT 'Payment Status' AS Reference, 'Unpaid' AS Code , 'Impayé' AS LabelFr , 'Unpaid' AS LabelEng


UNION ALL --reportline status

SELECT 'reportline status' AS Reference, 'BS' AS Code , 'Bilan' AS LabelFr , 'Review' AS LabelEng
UNION ALL
SELECT 'reportline status' AS Reference, 'SOI' AS Code , 'Etat des résultats' AS LabelFr , 'Income statement' AS LabelEng
UNION ALL
SELECT 'reportline status' AS Reference, 'CIB' AS Code , 'Balance intermédiaires commerciales' AS LabelFr , 'Intermediate trade balance' AS LabelEng
UNION ALL
SELECT 'reportline status' AS Reference, 'IIB' AS Code , 'Balance intermédiaires industrielles' AS LabelFr , 'Industrial intermediate scales' AS LabelEng
UNION ALL
SELECT 'reportline status' AS Reference, 'CF' AS Code , 'Flux de trésorerie' AS LabelFr , 'Cash flow' AS LabelEng
UNION ALL
SELECT 'reportline status' AS Reference, 'CFA' AS Code , 'Flux de trésorerie annexe' AS LabelFr , 'Ancillary cash flow' AS LabelEng



UNION ALL --documentaccount status

SELECT 'documentaccount status' AS Reference, '0' AS Code , 'Insértion Manuelle' AS LabelFr , 'Manual Insertion' AS LabelEng
UNION ALL
SELECT 'documentaccount status' AS Reference, '1' AS Code , 'Import .Net' AS LabelFr , 'Import .Net' AS LabelEng
UNION ALL
SELECT 'documentaccount status' AS Reference, '2' AS Code , 'A nouveaux' AS LabelFr , 'Again' AS LabelEng
UNION ALL
SELECT 'documentaccount status' AS Reference, '3' AS Code , 'Interface d amortissement' AS LabelFr , 'Damping interface' AS LabelEng

UNION ALL --Intervention Status

SELECT 'Intervention status' AS Reference, '1' AS Code, 'Ouverte' AS LabelFr, 'Open' AS LabelEng
UNION ALL
SELECT 'Intervention status' AS Reference, '2' AS Code, 'En cours' AS LabelFr, 'In progress' AS LabelEng
UNION ALL
SELECT 'Intervention status' AS Reference, '3' AS Code, 'Terminée' AS LabelFr, 'Completed' AS LabelEng

 
 

END