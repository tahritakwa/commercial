
------------------------------- MAK delete RH card From S.P FeedCartes 03/09/2021------------------------------

GO
/****** Object:  StoredProcedure [Reporting].[FeedCartes]    Script Date: 03/09/2021 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [Reporting].[FeedCartes]
	
AS
BEGIN

	DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

	BEGIN TRY
		--Truncate Cartes Table	
		TRUNCATE TABLE [Reporting].[Cartes]

		--Insert Into Cartes Table	
		INSERT INTO [Reporting].[Cartes]
				   (   [Module]
				  	  ,[Label]
					  ,[Year]
					  ,[Month]
					  ,[Day]
					  ,[WeekOfMonth]
					  ,[Value]
				   )

		--*************Load Data In Cartes Table********************--	


--Nombre de commandes livrées par mois

SELECT DISTINCT 
 'Sales',
 'Nombre de commandes livrees',
  DocumentYear,
  DocumentMonth,
  CAST(NULL As nvarchar(255)),
  CAST(NULL As nvarchar(255)),
  COUNT(*) AS NbCommand
  FROM [Reporting].[FctSales]
  WHERE DocumentStatus = 'valid' and DocumentTypeCode like '%D-SA'
  GROUP BY DocumentYear,
  DocumentMonth

UNION ALL

--Total des achats

SELECT DISTINCT
  'Purchase',
  'Total des achats',
  DocumentYear,
  DocumentMonth,
  DAY(DocumentDate),
  CAST(NULL As nvarchar(255)),
  COUNT(*) AS TotalAchat --DocumentCode DISTINCT 
  FROM [Reporting].[FctPurchases]
  WHERE DocumentTypeCode like '%I-PU'
  GROUP BY DocumentYear, DocumentMonth, DAY(DocumentDate)
  --ORDER BY DocumentMonth,DAY(DocumentDate) ASC


UNION ALL

-- Current Month Turnover
SELECT DISTINCT
	'SALES',
	'Current Month Turnover',
	DocumentYear,
	DocumentMonth,
	CAST(NULL As nvarchar(255)),
    CAST(NULL As nvarchar(255)),
	ISNULL(SUM(HtTotalLine),0)
	
	FROM [Reporting].[FctSales] 
	WHERE DocumentTypeCode LIKE '%I-SA' AND DocumentMonth=MONTH(GETDATE()) AND DocumentYear=YEAR(GETDATE())
	GROUP BY DocumentYear, DocumentMonth

UNION ALL

-- Current Month Depense
SELECT
	'PURCHASES',
	'Current Month Depense',
	DocumentYear,
	DocumentMonth,
	CAST(NULL As nvarchar(255)),
    CAST(NULL As nvarchar(255)),
	ISNULL(SUM(HtTotalLine),0)
	
	FROM [Reporting].[FctPurchases]
	WHERE DocumentTypeCode LIKE '%I-PU'  AND DocumentMonth=MONTH(GETDATE()) AND DocumentYear=YEAR(GETDATE())
	GROUP BY DocumentYear, DocumentMonth

UNION ALL

-- Last Month Turnover
SELECT DISTINCT
	'SALES',
	'Last Month Turnover',
	DocumentYear,
	DocumentMonth,
	CAST(NULL As nvarchar(255)),
    CAST(NULL As nvarchar(255)),
	ISNULL(SUM(HtTotalLine),0)
	
	FROM [Reporting].[FctSales] 

	WHERE DocumentTypeCode LIKE '%I-SA' 
	AND DocumentMonth=MONTH(DATEADD(MONTH,-1,GETDATE()))
	AND DocumentYear=YEAR(GETDATE())

	GROUP BY DocumentYear, DocumentMonth

UNION ALL

-- Last Month Depense
SELECT DISTINCT
	'PURCHASES',
	'Last Month Depense',
	DocumentYear,
	DocumentMonth,
	CAST(NULL As nvarchar(255)),
    CAST(NULL As nvarchar(255)),
	ISNULL(SUM(HtTotalLine),0)
	
	FROM [Reporting].[FctPurchases]

	WHERE DocumentTypeCode LIKE '%I-PU' 
	AND DocumentMonth=MONTH(DATEADD(MONTH,-1,GETDATE()))
	AND DocumentYear=YEAR(GETDATE())

	GROUP BY DocumentYear, DocumentMonth

UNION ALL

-- Nombre des articles disponibles en stock 

SELECT 'STOCK',
       'Nombre des articles en stock ',
	   CAST(NULL As nvarchar(255)),
       CAST(NULL As nvarchar(255)),
       CAST(NULL As nvarchar(255)),
	   CAST(NULL As nvarchar(255)),
       SUM([AvailableQuantity]) AS Available_Quantity

	
  FROM [Inventory].[ItemWarehouse] WITH(NOLOCK)


--Number Of Invalid Purchase Requisitions

UNION ALL

SELECT 
'PURCHASE',
'NumberOfInvalidPurchaseRequisitions',
YEAR(DocumentDate) AS Year,
MONTH(DocumentDate) AS Month,
CAST(NULL As nvarchar(255)),
CAST(NULL As nvarchar(255)),
COUNT (*) AS NumberOfInvalidPurchaseRequisitions


FROM [Reporting].[FctPurchases] WITH(NOLOCK)

WHERE DocumentTypeCode ='O-PU' AND DocumentStatus='Refused'

GROUP BY YEAR(DocumentDate), MONTH(DocumentDate)


UNION ALL

--Get Total Company Per Report Type
SELECT 'COMPTA',
	rl.[ReportType],
	fy.FiscalYearName AS FiscalYear,
	CAST(NULL As nvarchar(255)),
	CAST(NULL As nvarchar(255)),
	CAST(NULL As nvarchar(255)),
	SUM(rl.[ReportLineAmount]) AS Amount
	  

  FROM [Reporting].[FctReportLine] rl WITH(NOLOCK)
  LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=rl.FiscalYearId

  GROUP BY [ReportType],fy.FiscalYearName

UNION ALL

--Get Journal Totals
SELECT 'COMPTA',
jn.JournalLabel AS JournalLabel,
YEAR(da.DocumentAccountDate) AS FiscalYear,
CAST(NULL As nvarchar(255)),
CAST(NULL As nvarchar(255)),
CAST(NULL As nvarchar(255)),
SUM(da.DocumentAccountLineDebitAmount) AS Amount


FROM [Reporting].[FctDocumentAccountLine]  da WITH(NOLOCK)
LEFT JOIN [Reporting].[DimJournal] jn WITH(NOLOCK) ON jn.journalID=da.JournalId
LEFT JOIN [Reporting].[DimAccount] a WITH(NOLOCK) ON a.AccountId=da.AccountIdAssociated
--LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=da.FiscalYearId


WHERE jn.JournalLabel ='Vente' 
AND da.DocumentAccountLabel  LIKE 'FA%' 

GROUP BY jn.JournalLabel,
YEAR(da.DocumentAccountDate)


UNION ALL

SELECT
'COMPTA',
jn.JournalLabel AS JournalLabel,
YEAR(da.DocumentAccountDate) AS FiscalYear,
CAST(NULL As nvarchar(255)),
CAST(NULL As nvarchar(255)),
CAST(NULL As nvarchar(255)),
SUM(da.DocumentAccountLineCreditAmount) AS Amount


FROM [Reporting].[FctDocumentAccountLine]  da WITH(NOLOCK)
LEFT JOIN [Reporting].[DimJournal] jn WITH(NOLOCK) ON jn.journalID=da.JournalId
LEFT JOIN [Reporting].[DimAccount] a WITH(NOLOCK) ON a.AccountId=da.AccountIdAssociated
--LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=da.FiscalYearId


WHERE jn.JournalLabel ='Achat' 

GROUP BY jn.JournalLabel,
YEAR(da.DocumentAccountDate)

UNION ALL

SELECT
'COMPTA',
jn.JournalLabel AS JournalLabel,
YEAR(da.DocumentAccountDate) AS FiscalYear,
CAST(NULL As nvarchar(255)),
CAST(NULL As nvarchar(255)),
CAST(NULL As nvarchar(255)),
SUM(da.DocumentAccountLineDebitAmount) AS Amount


FROM [Reporting].[FctDocumentAccountLine]  da WITH(NOLOCK)
LEFT JOIN [Reporting].[DimJournal] jn WITH(NOLOCK) ON jn.journalID=da.JournalId
LEFT JOIN [Reporting].[DimAccount] a WITH(NOLOCK) ON a.AccountId=da.AccountIdAssociated
--LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=da.FiscalYearId


WHERE jn.JournalLabel ='Banque' 

GROUP BY jn.JournalLabel,
YEAR(da.DocumentAccountDate)

UNION ALL

SELECT
'COMPTA',
jn.JournalLabel AS JournalLabel,
YEAR(da.DocumentAccountDate) AS FiscalYear,
CAST(NULL As nvarchar(255)),
CAST(NULL As nvarchar(255)),
CAST(NULL As nvarchar(255)),
SUM(da.DocumentAccountLineDebitAmount) AS DebitAmount


FROM [Reporting].[FctDocumentAccountLine]  da WITH(NOLOCK)
LEFT JOIN [Reporting].[DimJournal] jn WITH(NOLOCK) ON jn.journalID=da.JournalId
LEFT JOIN [Reporting].[DimAccount] a WITH(NOLOCK) ON a.AccountId=da.AccountIdAssociated
--LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=da.FiscalYearId


WHERE jn.JournalLabel ='Caisse' 

GROUP BY jn.JournalLabel,
YEAR(da.DocumentAccountDate)

UNION ALL

SELECT
'COMPTA',
jn.JournalLabel AS JournalLabel,
YEAR(da.DocumentAccountDate) AS FiscalYear,
CAST(NULL As nvarchar(255)),
CAST(NULL As nvarchar(255)),
CAST(NULL As nvarchar(255)),
SUM(da.DocumentAccountLineDebitAmount) AS DebitAmount


FROM [Reporting].[FctDocumentAccountLine]  da WITH(NOLOCK)
LEFT JOIN [Reporting].[DimJournal] jn WITH(NOLOCK) ON jn.journalID=da.JournalId
LEFT JOIN [Reporting].[DimAccount] a WITH(NOLOCK) ON a.AccountId=da.AccountIdAssociated
--LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=da.FiscalYearId


WHERE jn.JournalLabel ='Operations diverses' 

GROUP BY jn.JournalLabel,
YEAR(da.DocumentAccountDate)

UNION ALL

SELECT
'COMPTA',
jn.JournalLabel AS JournalLabel,
YEAR(da.DocumentAccountDate) AS FiscalYear,
CAST(NULL As nvarchar(255)),
CAST(NULL As nvarchar(255)),
CAST(NULL As nvarchar(255)),
SUM(da.DocumentAccountLineDebitAmount) AS DebitAmount


FROM [Reporting].[FctDocumentAccountLine]  da WITH(NOLOCK)
LEFT JOIN [Reporting].[DimJournal] jn WITH(NOLOCK) ON jn.journalID=da.JournalId
LEFT JOIN [Reporting].[DimAccount] a WITH(NOLOCK) ON a.AccountId=da.AccountIdAssociated
--LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=da.FiscalYearId


WHERE jn.JournalLabel ='À Nouveaux' 

GROUP BY jn.JournalLabel,
YEAR(da.DocumentAccountDate)

--Total Depreciation
UNION ALL

SELECT
'COMPTA',
'TotalDepreciation',
	FiscalYear,
	CAST(NULL As nvarchar(255)),
    CAST(NULL As nvarchar(255)),
	CAST(NULL As nvarchar(255)),
	SUM(Amount) AS DepreciationAmount
FROM

(
SELECT 

	YEAR(dal.DocumentAccountDate) AS FiscalYear,
	-SUM(dal.[DocumentAccountLineDebitAmount]) AS Amount

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	--LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
	WHERE a.AccountCode LIKE '68%'


	GROUP BY
		YEAR(dal.DocumentAccountDate)


UNION ALL

SELECT 

	YEAR(dal.DocumentAccountDate) AS FiscalYear,
	SUM(dal.[DocumentAccountLineCreditAmount]) AS Amount

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	--LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
	WHERE a.AccountCode LIKE '28%'
	

	GROUP BY YEAR(dal.DocumentAccountDate)

)A

GROUP BY FiscalYear

--Total Client
UNION ALL

SELECT DISTINCT
'SALES',
'TotalClient',
CAST(NULL As nvarchar(255)),
--YEAR(dal.DocumentAccountDate) AS FiscalYear,
CAST(NULL As nvarchar(255)),
CAST(NULL As nvarchar(255)),
CAST(NULL As nvarchar(255)),
COUNT(*) AS TotalClient

FROM [Reporting].[DimTiers] t WITH(NOLOCK)
	--LEFT JOIN [Reporting].[DimAccount] a WITH(NOLOCK) ON t.IdAccount=a.AccountId
	--LEFT JOIN [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK) ON dal.AccountIdAssociated=a.AccountId
	--LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId

WHERE t.TypeTiersLabel  like '%client%'

--GROUP BY YEAR(dal.DocumentAccountDate)

UNION ALL

--CA pour l'année derniére

    SELECT 
	'COMPTA' ,
	'CA Last Year',
	FiscalYear,
    CAST(NULL As nvarchar(255)),
	CAST(NULL As nvarchar(255)),
	CAST(NULL As nvarchar(255)),
    SUM(Amount) AS  CA
	from
	(
	SELECT
	ISNULL(SUM(dal.[DocumentAccountLineCreditAmount]),0) AS Amount,
    YEAR(dal.DocumentAccountDate) AS FiscalYear
    FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
    LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
    WHERE a.AccountCode like  '70%' AND     YEAR(dal.DocumentAccountDate)=YEAR(GETDATE())-1


    GROUP BY   
                 YEAR(dal.DocumentAccountDate)


 

    UNION ALL

 

    --Déduction des rabais,remises et ristournes accordés par l'entreprise pour la vente (Compte 709)
    SELECT

    -ISNULL(SUM(dal.[DocumentAccountLineCreditAmount]),0) AS Amount,
    YEAR(dal.DocumentAccountDate) AS FiscalYear
    FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
    LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]

    WHERE a.AccountCode like  '709%' AND     YEAR(dal.DocumentAccountDate)=YEAR(GETDATE())-1
		--AND dal.DocumentAccountLineDate=GETDATE()

    GROUP BY YEAR(dal.DocumentAccountDate)

	    

	
	)A

	GROUP BY FiscalYear


	UNION ALL
		
  ----CA cette année---

    SELECT 
	'COMPTA' ,
	'CA Current Year',
	FiscalYear,
    CAST(NULL As nvarchar(255)),
	CAST(NULL As nvarchar(255)),
	CAST(NULL As nvarchar(255)),
    SUM(Amount) AS  CA
	from
	(
	SELECT
	ISNULL(SUM(dal.[DocumentAccountLineCreditAmount]),0) AS Amount,
    YEAR(dal.DocumentAccountDate) AS FiscalYear
    FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
    LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
    WHERE a.AccountCode like  '70%' AND     YEAR(dal.DocumentAccountDate)=YEAR(GETDATE())


    GROUP BY YEAR(dal.DocumentAccountDate)

 

    UNION ALL

 

    --Déduction des rabais,remises et ristournes accordés par l'entreprise pour la vente (Compte 709)
    SELECT

    -ISNULL(SUM(dal.[DocumentAccountLineCreditAmount]),0) AS Amount,
    YEAR(dal.DocumentAccountDate) AS FiscalYear
    FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
    LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]

    WHERE a.AccountCode like  '709%' AND     YEAR(dal.DocumentAccountDate)=YEAR(GETDATE())

    GROUP BY YEAR(dal.DocumentAccountDate)

	    

	
	)A

	GROUP BY FiscalYear

	

--**************************************************************************--

SET @NbInserted = @@ROWCOUNT
	
END TRY


BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'Cartes', @NbInserted, GETDATE(), @ErrorMessage

		
END
GO

---------------------------------- MAK update FeedParameterReference SP 01/10/2021 -------------------------------

/****** Object:  StoredProcedure [Reporting].[FeedParameterReference]    Script Date: 01/10/2021 11:21:08 ******/
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

--expense report

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
GO

------------------------------- MAK delete RH card From S.P Fix Reporting script------------------------------

PRINT N'Dropping [Reporting].[FeedDimEmployeeTeam]...';
GO


DROP PROCEDURE [Reporting].[FeedDimEmployeeTeam]
GO

PRINT N'Dropping [Reporting].[FeedKPIDailyLeaves]...';
GO

DROP PROCEDURE [Reporting].[FeedKPIDailyLeaves]
GO

PRINT N'Dropping [Reporting].[GetKPIDailyLeaves]...';
GO

DROP PROCEDURE [Reporting].[GetKPIDailyLeaves]
GO

PRINT N'Dropping [Reporting].[FeedKPIEmployerChargePerTeam]...';
GO

DROP PROCEDURE [Reporting].[FeedKPIEmployerChargePerTeam]
GO

PRINT N'Dropping [Reporting].[GetKPIEmployerChargePerTeam]...';
GO

DROP PROCEDURE [Reporting].[GetKPIEmployerChargePerTeam]
GO

PRINT N'Dropping [Reporting].[FeedKPITotalWorkDays]...';
GO

DROP PROCEDURE [Reporting].[FeedKPITotalWorkDays]
GO

PRINT N'Dropping [Reporting].[GetKPITotalWorkDays]...';
GO

DROP PROCEDURE [Reporting].[GetKPITotalWorkDays]
GO

PRINT N'Dropping [Reporting].[AverageLeaves]...';
GO

DROP PROCEDURE [Reporting].[AverageLeaves]
GO

PRINT N'Dropping [Reporting].[FeedDimCandidate]...';
GO

DROP PROCEDURE [Reporting].[FeedDimCandidate]
GO

PRINT N'Dropping [Reporting].[FeedDimContract]...';
GO

DROP PROCEDURE [Reporting].[FeedDimContract]
GO

PRINT N'Dropping [Reporting].[FeedDimEmployeeContract]...';
GO

DROP PROCEDURE [Reporting].[FeedDimEmployeeContract]
GO

PRINT N'Dropping [Reporting].[FeedDimEmployeeExit]...';
GO

DROP PROCEDURE [Reporting].[FeedDimEmployeeExit]
GO

PRINT N'Dropping [Reporting].[FeedDimEmployeeProject]...';
GO

DROP PROCEDURE [Reporting].[FeedDimEmployeeProject]
GO

PRINT N'Dropping [Reporting].[FeedDimExitReason]...';
GO

DROP PROCEDURE [Reporting].[FeedDimExitReason]
GO

PRINT N'Dropping [Reporting].[FeedDimGrade]...';
GO

DROP PROCEDURE [Reporting].[FeedDimGrade]
GO

PRINT N'Dropping [Reporting].[FeedDimSalaryStructure]...';
GO

DROP PROCEDURE [Reporting].[FeedDimSalaryStructure]
GO

PRINT N'Dropping [Reporting].[FeedFctEmployeeContract]...';
GO

DROP PROCEDURE [Reporting].[FeedFctEmployeeContract]
GO

PRINT N'Dropping [Reporting].[FeedFctRecruitement]...';
GO

DROP PROCEDURE [Reporting].[FeedFctRecruitement]
GO

PRINT N'Dropping [Reporting].[FeedFctTimeSheetLine]...';
GO

DROP PROCEDURE [Reporting].[FeedFctTimeSheetLine]
GO

PRINT N'Dropping [Reporting].[FeedFctTimeSheetLineHours]...';
GO

DROP PROCEDURE [Reporting].[FeedFctTimeSheetLineHours]
GO

PRINT N'Dropping [Reporting].[FeedKPICandidaciesPerRecruitment]...';
GO

DROP PROCEDURE [Reporting].[FeedKPICandidaciesPerRecruitment]
GO

PRINT N'Dropping [Reporting].[GetKPICandidaciesPerRecruitment]...';
GO

DROP PROCEDURE [Reporting].[GetKPICandidaciesPerRecruitment]
GO


PRINT N'Dropping [Reporting].[FeedKPIEmployeeByOffice]...';
GO

DROP PROCEDURE [Reporting].[FeedKPIEmployeeByOffice]
GO

PRINT N'Dropping [Reporting].[GetKPIEmployeeByOffice]...';
GO

DROP PROCEDURE [Reporting].[GetKPIEmployeeByOffice]
GO

PRINT N'Dropping [Reporting].[FeedKPIEmployerChargePerEmployee]...';
GO

DROP PROCEDURE [Reporting].[FeedKPIEmployerChargePerEmployee]
GO

PRINT N'Dropping [Reporting].[GetKPIEmployerChargePerEmployee]...';
GO

DROP PROCEDURE [Reporting].[GetKPIEmployerChargePerEmployee]
GO

PRINT N'Dropping [Reporting].[FeedKPIInterviewByCandidacy]...';
GO

DROP PROCEDURE [Reporting].[FeedKPIInterviewByCandidacy]
GO

PRINT N'Dropping [Reporting].[GetKPIInterviewByCandidacy]...';
GO

DROP PROCEDURE [Reporting].[GetKPIInterviewByCandidacy]
GO

PRINT N'Dropping [Reporting].[FeedKPIInterviewDetails]...';
GO

DROP PROCEDURE [Reporting].[FeedKPIInterviewDetails]
GO

PRINT N'Dropping [Reporting].[GetKPIInterviewDetails]...';
GO

DROP PROCEDURE [Reporting].[GetKPIInterviewDetails]
GO

PRINT N'Dropping [Reporting].[FeedKPILeaveDistribution]...';
GO

DROP PROCEDURE [Reporting].[FeedKPILeaveDistribution]
GO

PRINT N'Dropping [Reporting].[GetKPILeaveDistribution]...';
GO

DROP PROCEDURE [Reporting].[GetKPILeaveDistribution]
GO

PRINT N'Dropping [Reporting].[FeedKPIPayrollPerEmployee]...';
GO

DROP PROCEDURE [Reporting].[FeedKPIPayrollPerEmployee]
GO

PRINT N'Dropping [Reporting].[GetKPIPayrollPerEmployee]...';
GO

DROP PROCEDURE [Reporting].[GetKPIPayrollPerEmployee]
GO

PRINT N'Dropping [Reporting].[FeedKPIProductivity]...';
GO

DROP PROCEDURE [Reporting].[FeedKPIProductivity]
GO

PRINT N'Dropping [Reporting].[GetKPIProductivity]...';
GO

DROP PROCEDURE [Reporting].[GetKPIProductivity]
GO

PRINT N'Dropping [Reporting].[FeedKPIRecruitmentsByOffice]...';
GO

DROP PROCEDURE [Reporting].[FeedKPIRecruitmentsByOffice]
GO

PRINT N'Dropping [Reporting].[GetKPIRecruitmentsByOffice]...';
GO

DROP PROCEDURE [Reporting].[GetKPIRecruitmentsByOffice]
GO

PRINT N'Dropping [Reporting].[FeedKPITotalEmployerCharge]...';
GO

DROP PROCEDURE [Reporting].[FeedKPITotalEmployerCharge]
GO

PRINT N'Dropping [Reporting].[GetKPITotalEmployeeCharge]...';
GO

DROP PROCEDURE [Reporting].[GetKPITotalEmployeeCharge]
GO

PRINT N'Dropping [Reporting].[FeedKPIUpcomingEmployeeEvent]...';
GO

DROP PROCEDURE [Reporting].[FeedKPIUpcomingEmployeeEvent]
GO

PRINT N'Dropping [Reporting].[GetKPIUpcomingEmployeeEvent]...';
GO

DROP PROCEDURE [Reporting].[GetKPIUpcomingEmployeeEvent]
GO

PRINT N'Dropping [Reporting].[FeedKPIUpcomingInterviews]...';
GO

DROP PROCEDURE [Reporting].[FeedKPIUpcomingInterviews]
GO

PRINT N'Dropping [Reporting].[GetKPIUpcomingInterviews]...';
GO

DROP PROCEDURE [Reporting].[GetKPIUpcomingInterviews]
GO

PRINT N'Dropping [Reporting].[StaffUpcomingExit]...';
GO

DROP PROCEDURE [Reporting].[StaffUpcomingExit]
GO

PRINT N'Dropping [Reporting].[FeedDimJob]...';
GO

DROP PROCEDURE [Reporting].[FeedDimJob]
GO


--- COMPTA

PRINT N'Dropping [Reporting].[FeedDimJournal]...';
GO

DROP PROCEDURE [Reporting].[FeedDimJournal]
GO

PRINT N'Dropping [Reporting].[FeedDimChartAccounts]...';
GO

DROP PROCEDURE [Reporting].[FeedDimChartAccounts]
GO

PRINT N'Dropping [Reporting].[FeedDimPayment]...';
GO

DROP PROCEDURE [Reporting].[FeedDimPayment]
GO

PRINT N'Dropping [Reporting].[FeedFctReportLine]...';
GO

DROP PROCEDURE [Reporting].[FeedFctReportLine]
GO

PRINT N'Dropping [Reporting].[FeedFinancialCommitmentNonPaidAmounts]...';
GO

DROP PROCEDURE [Reporting].[FeedFinancialCommitmentNonPaidAmounts]
GO

PRINT N'Dropping [Reporting].[GetKPIFinancialCommitmentNonPaidAmounts]...';
GO

DROP PROCEDURE [Reporting].[GetKPIFinancialCommitmentNonPaidAmounts]
GO

PRINT N'Dropping [Reporting].[FeedKPIAmountsPerImmobilisation]...';
GO

DROP PROCEDURE [Reporting].[FeedKPIAmountsPerImmobilisation]
GO

PRINT N'Dropping [Reporting].[GetKPIAmountsPerImmobilisation]...';
GO

DROP PROCEDURE [Reporting].[GetKPIAmountsPerImmobilisation]
GO

PRINT N'Dropping [Reporting].[FeedKPIAverageRevenuePerCustomer]...';
GO

DROP PROCEDURE [Reporting].[FeedKPIAverageRevenuePerCustomer]
GO

PRINT N'Dropping [Reporting].[GetKPIAverageRevenuePerCustomer]...';
GO

DROP PROCEDURE [Reporting].[GetKPIAverageRevenuePerCustomer]
GO

PRINT N'Dropping [Reporting].[FeedKPIDelayedPayment]...';
GO

DROP PROCEDURE [Reporting].[FeedKPIDelayedPayment]
GO

PRINT N'Dropping [Reporting].[GetKPIDelayedPayment]...';
GO

DROP PROCEDURE [Reporting].[GetKPIDelayedPayment]
GO

PRINT N'Dropping [Reporting].[FeedKPINeedInFunds]...';
GO

DROP PROCEDURE [Reporting].[FeedKPINeedInFunds]
GO

PRINT N'Dropping [Reporting].[GetKPINeedInFunds]...';
GO

DROP PROCEDURE [Reporting].[GetKPINeedInFunds]
GO

PRINT N'Dropping [Reporting].[FeedKPIRetentionRate]...';
GO

DROP PROCEDURE [Reporting].[FeedKPIRetentionRate]
GO

PRINT N'Dropping [Reporting].[GetKPIRetentionRate]...';
GO

DROP PROCEDURE [Reporting].[GetKPIRetentionRate]
GO

PRINT N'Dropping [Reporting].[FeedKPITotalDepreciationPerAccount]...';
GO

DROP PROCEDURE [Reporting].[FeedKPITotalDepreciationPerAccount]
GO

PRINT N'Dropping [Reporting].[GetKPITotalDepreciationPerAccount]...';
GO

DROP PROCEDURE [Reporting].[GetKPITotalDepreciationPerAccount]
GO

PRINT N'Dropping [Reporting].[FeedKPITotalGrossPayroll]...';
GO

DROP PROCEDURE [Reporting].[FeedKPITotalGrossPayroll]
GO

PRINT N'Dropping [Reporting].[GetKPITotalGrossPayroll]...';
GO

DROP PROCEDURE [Reporting].[GetKPITotalGrossPayroll]
GO

PRINT N'Dropping [Reporting].[FeedKPITotalPremium]...';
GO

DROP PROCEDURE [Reporting].[FeedKPITotalPremium]
GO

PRINT N'Dropping [Reporting].[GetKPITotalPremium]...';
GO

DROP PROCEDURE [Reporting].[GetKPITotalPremium]
GO

---------------------------------- MAK update FeedParameterReference SP 01/10/2021 -------------------------------

/****** Object:  StoredProcedure [Reporting].[FeedParameterReference]    Script Date: 01/10/2021 11:21:08 ******/
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

--expense report

SELECT 'Expense Report' AS Reference, '1' AS Code, 'En attente' AS LabelFr, 'Waiting' AS LabelEng
UNION ALL
SELECT 'Expense Report' AS Reference, '2' AS Code, 'Accept' AS LabelFr, 'Accepted' AS LabelEng
UNION ALL
SELECT 'Expense Report' AS Reference, '3' AS Code, 'Refus' AS LabelFr, 'Refused' AS LabelEng

UNION ALL --document

SELECT 'Document' AS Reference, '1' AS Code, 'En attente' AS LabelFr, 'Waiting' AS LabelEng
UNION ALL
SELECT 'Document' AS Reference, '2' AS Code, 'Accept' AS LabelFr, 'Accepted' AS LabelEng
UNION ALL
SELECT 'Document' AS Reference, '3' AS Code, 'Refus' AS LabelFr, 'Refused' AS LabelEng

UNION ALL --session

SELECT 'Pay Session' AS Reference, '1' AS Code, 'Nouvelle' AS LabelFr, 'New' AS LabelEng
UNION ALL
SELECT 'Pay Session' AS Reference, '2' AS Code, 'Prsence' AS LabelFr, 'Presence' AS LabelEng
UNION ALL
SELECT 'Pay Session' AS Reference, '3' AS Code, 'Prime' AS LabelFr, 'Bonus' AS LabelEng
UNION ALL
SELECT 'Pay Session' AS Reference, '4' AS Code, 'Bulletn De Paie' AS LabelFr, 'Payslip' AS LabelEng
UNION ALL
SELECT 'Pay Session' AS Reference, '5' AS Code, 'Ferm' AS LabelFr, 'Closed' AS LabelEng

UNION ALL --Financial Commitment

SELECT 'Financial Commitment' AS Reference, '1' AS Code, 'Sold' AS LabelFr, 'Sold' AS LabelEng
UNION ALL
SELECT 'Financial Commitment' AS Reference, '2' AS Code, 'Partiellement sold' AS LabelFr, 'Partially Sold' AS LabelEng
UNION ALL
SELECT 'Financial Commitment' AS Reference, '3' AS Code, 'Non sold' AS LabelFr, 'Non Solded' AS LabelEng

UNION ALL --payment method


SELECT 'Payment Method' AS Reference, 'VIR' AS Code , 'Virement' AS LabelFr , 'Transfer' AS LabelEng
UNION ALL
SELECT 'Payment Method' AS Reference, 'ESP' AS Code, 'Espce' AS LabelFr , 'Currency' AS LabelEng
UNION ALL
SELECT 'Payment Method' AS Reference, 'CB' AS Code, 'Carte Bancaire' AS LabelFr , 'Bank Card' AS LabelEng
UNION ALL
SELECT 'Payment Method' AS Reference, 'CHQ' AS Code, 'Chque' AS LabelFr , 'Check' AS LabelEng
UNION ALL
SELECT 'Payment Method' AS Reference, 'TRT' AS Code, 'Traite' AS LabelFr , 'Treaty' AS LabelEng
UNION ALL
SELECT 'Payment Method' AS Reference, 'EXT BANCAIRE' AS Code, 'Extrait Bancaire' AS LabelFr , 'Banking receipt
' AS LabelEng



UNION ALL --payment status

SELECT 'Payment Status' AS Reference, 'NotCashed' AS Code , 'Non encaiss' AS LabelFr , 'Not Cashed' AS LabelEng
UNION ALL
SELECT 'Payment Status' AS Reference, 'Cashed' AS Code , 'Encaiss' AS LabelFr , 'Cashed' AS LabelEng
UNION ALL
SELECT 'Payment Status' AS Reference, 'Unpaid' AS Code , 'Impay' AS LabelFr , 'Unpaid' AS LabelEng


UNION ALL --reportline status

SELECT 'reportline status' AS Reference, 'BS' AS Code , 'Bilan' AS LabelFr , 'Review' AS LabelEng
UNION ALL
SELECT 'reportline status' AS Reference, 'SOI' AS Code , 'Etat des rsultats' AS LabelFr , 'Income statement' AS LabelEng
UNION ALL
SELECT 'reportline status' AS Reference, 'CIB' AS Code , 'Balance intermdiaires commerciales' AS LabelFr , 'Intermediate trade balance' AS LabelEng
UNION ALL
SELECT 'reportline status' AS Reference, 'IIB' AS Code , 'Balance intermdiaires industrielles' AS LabelFr , 'Industrial intermediate scales' AS LabelEng
UNION ALL
SELECT 'reportline status' AS Reference, 'CF' AS Code , 'Flux de trsorerie' AS LabelFr , 'Cash flow' AS LabelEng
UNION ALL
SELECT 'reportline status' AS Reference, 'CFA' AS Code , 'Flux de trsorerie annexe' AS LabelFr , 'Ancillary cash flow' AS LabelEng



UNION ALL --documentaccount status

SELECT 'documentaccount status' AS Reference, '0' AS Code , 'Insrtion Manuelle' AS LabelFr , 'Manual Insertion' AS LabelEng
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
SELECT 'Intervention status' AS Reference, '3' AS Code, 'Termine' AS LabelFr, 'Completed' AS LabelEng

 
 

END
GO
