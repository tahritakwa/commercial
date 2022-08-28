-----------------------------------Rahma update FeedCartes 19/05/2021----------------------------------------

/****** Object:  StoredProcedure [Reporting].[FeedCartes]    Script Date: 19/05/2021 11:20:32 ******/
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

--Get Number Of Interviews Per Day
SELECT  'RH',
'Entretien Quotidien',
YEAR(Right(DATENAME(dw, GetDate())+','+convert(varchar, GetDate(), 106),11)) AS InterviewYear,
MONTH(Right(DATENAME(dw, GetDate())+','+convert(varchar, GetDate(), 106),11)) AS InterviewMonth ,
Day(Right(DATENAME(dw, GetDate())+','+convert(varchar, GetDate(), 106),11)) AS InterviewDay ,
--(DATEPART(week,GetDate() ) - DATEPART(week, DATEADD(day, 1, EOMONTH(GetDate(), -1)))) + 1
		CASE WHEN DATEPART(day,GetDate()) < 8 THEN '1' 
				ELSE CASE WHEN DATEPART(day,GetDate()) < 15 then '2' 
				ELSE CASE WHEN  DATEPART(day,GetDate()) < 22 then '3' 
				ELSE CASE WHEN  DATEPART(day,GetDate()) < 29 then '4'     
				ELSE '5'
				END
				END
				END
				END AS TheWeekOfMonth,
COUNT( distinct IdInterview)AS NumberOfInterviews
FROM [Reporting].[FctRecruitment] WITH(NOLOCK)

WHERE InterviewDate = getdate()

UNION ALL

------Get Number Of Interviews Per Month
SELECT 'RH',
'Entretien Mensuel',
YEAR(Right(DATENAME(dw, GetDate())+','+convert(varchar, GetDate(), 106),8)) AS CurrentYear,
MONTH(Right(DATENAME(dw, GetDate())+','+convert(varchar, GetDate(), 106),8)) AS CurrentMonth,
CAST(NULL As nvarchar(255)),
CAST(NULL As nvarchar(255)),
COUNT( distinct IdInterview)AS NumberOfInterviews

FROM [Reporting].[FctRecruitment] WITH(NOLOCK)

WHERE Month(InterviewDate) = MONTH(getdate())

UNION ALL

--Total Monthly Interview To Be Done
	
--	SELECT
--	'RH',
--	'Interview ToBeDone',
--    YEAR(InterviewDate),
--    MONTH(InterviewDate),
--    CAST(NULL As nvarchar(255)),
--    CAST(NULL As nvarchar(255)),
--	SUM(ToBeDone)
   
--    FROM [Reporting].[KPIInterviewDetails] WITH(NOLOCK)
--	--WHERE MONTH(InterviewDate)=MONTH(GETDATE()) AND YEAR(InterviewDate)=YEAR(GETDATE())
--	GROUP BY MONTH(InterviewDate),YEAR(InterviewDate)

--UNION ALL

--Total Monthly Interview Done
	
--	SELECT
--	'RH',
--	'Interview Done',
--    YEAR(InterviewDate),
--    MONTH(InterviewDate),
--    CAST(NULL As nvarchar(255)),
--    CAST(NULL As nvarchar(255)),
--	SUM(Done)
   
--    FROM [Reporting].[KPIInterviewDetails] WITH(NOLOCK)
--	--WHERE MONTH(InterviewDate)=MONTH(GETDATE()) AND YEAR(InterviewDate)=YEAR(GETDATE())
--	GROUP BY MONTH(InterviewDate),YEAR(InterviewDate)

--UNION ALL

--Total Daily Interview To Be Done
	
	--SELECT
	--'RH',
	--'Interview ToBeDone',
 --   YEAR(InterviewDate),
 --   MONTH(InterviewDate),
 --   DAY(InterviewDate),
 --   CAST(NULL As nvarchar(255)),
	--SUM(ToBeDone)
   
 --   FROM [Reporting].[KPIInterviewDetails] WITH(NOLOCK)
	----WHERE MONTH(InterviewDate)=MONTH(GETDATE()) AND YEAR(InterviewDate)=YEAR(GETDATE())
	--GROUP BY MONTH(InterviewDate),YEAR(InterviewDate), DAY(InterviewDate)

--UNION ALL

----Total Daily Interview Done
	
--	SELECT
--	'RH',
--	'Interview ToBeDone',
--    YEAR(InterviewDate),
--    MONTH(InterviewDate),
--    DAY(InterviewDate),
--    CAST(NULL As nvarchar(255)),
--	SUM(Done)
   
--    FROM [Reporting].[KPIInterviewDetails] WITH(NOLOCK)
--	--WHERE MONTH(InterviewDate)=MONTH(GETDATE()) AND YEAR(InterviewDate)=YEAR(GETDATE())
--	GROUP BY MONTH(InterviewDate),YEAR(InterviewDate), DAY(InterviewDate)

--UNION ALL

-----salariés par sexe-------

SELECT
  'RH',
  CASE WHEN Gender=1 then 'Homme'
  WHEN Gender=2 then 'Femme'
  END,  
  CAST(NULL As nvarchar(255)),
  CAST(NULL As nvarchar(255)),
  CAST(NULL As nvarchar(255)),
  CAST(NULL As nvarchar(255)),

  Count(*) as Number

  FROM [Reporting].[FctEmployeeContract]
  WHERE ((ContractEndDate IS NULL) OR (GETDATE() BETWEEN ContractStartDate AND ISNULL(ContractEndDate, '9999-12-31')))
  
  GROUP BY Gender

UNION ALL

------anniversary contract per week----------

SELECT 
 'RH',
 'Anniversaire de contrat par semaine',
 CAST(NULL As nvarchar(255)),
 CAST(NULL As nvarchar(255)),
 CAST(NULL As nvarchar(255)),
 CASE WHEN DATEPART(day,GetDate()) < 8 THEN '1' 
				ELSE CASE WHEN DATEPART(day,GetDate()) < 15 then '2' 
				ELSE CASE WHEN  DATEPART(day,GetDate()) < 22 then '3' 
				ELSE CASE WHEN  DATEPART(day,GetDate()) < 29 then '4'     
				ELSE '5'
				END
				END
				END
				END AS TheWeekOfMonth,
COUNT (*) AS Number

 FROM [Reporting].[KPIUpcomingEmployeeEvent]
 WHERE EventType = 'Contract Anniversary' AND DATEPART(WEEK,NextContractAnniversary) = DATEPART(WEEK,GETDATE())
 GROUP BY EventType 
 
UNION ALL

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
	WHERE DocumentTypeCode LIKE '%I-SA' AND DocumentDate=GETDATE()
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
	WHERE DocumentTypeCode LIKE '%I-PU' AND DocumentDate=GETDATE()
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

--number of active employees
SELECT
	'RH',
	'Number of active employees',
	YEAR(GETDATE()),
	MONTH(GETDATE()),
	DAY(GETDATE()),
	CASE WHEN DATEPART(day,GetDate()) < 8 THEN '1' 
				ELSE CASE WHEN DATEPART(day,GetDate()) < 15 then '2' 
				ELSE CASE WHEN  DATEPART(day,GetDate()) < 22 then '3' 
				ELSE CASE WHEN  DATEPART(day,GetDate()) < 29 then '4'     
				ELSE '5'
				END
				END
				END
				END AS TheWeekOfMonth,
	COUNT(DISTINCT IdEmployee)

	FROM [Reporting].[DimEmployeeContract]
	WHERE ((ContractEndDate IS NULL) OR (GETDATE() BETWEEN ContractStartDate AND ISNULL(ContractEndDate, '9999-12-31')))

UNION ALL

--Moyenne Age
SELECT 
	'RH',
	'Moyenne Age',
	CAST(NULL As nvarchar(255)),
	CAST(NULL As nvarchar(255)),
	CAST(NULL As nvarchar(255)),
	CAST(NULL As nvarchar(255)),
	SUM([Age])/COUNT(DISTINCT [IdEmployee])
      
  FROM [Reporting].[FctEmployeeContract] 

  WHERE ((ContractEndDate IS NULL) OR (GETDATE() BETWEEN ContractStartDate AND ISNULL(ContractEndDate, '9999-12-31')))

UNION ALL

--Nombre Salarié Par Tranche Age
SELECT
	'RH',
	CONCAT('AgeRange:',ISNULL(AgeRange,'Unknown')),
	CAST(NULL As nvarchar(255)),
	CAST(NULL As nvarchar(255)),
	CAST(NULL As nvarchar(255)),
	CAST(NULL As nvarchar(255)),
	COUNT (DISTINCT IdEmployee) AS NbreSalarie

	FROM [Reporting].[DimEmployee]

GROUP BY AgeRange


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

------------------------------------Rahma update GetCartes 19/05/2021--------------------------------

/****** Object:  StoredProcedure [Reporting].[GetCartes]    Script Date: 19/05/2021 11:24:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [Reporting].[GetCartes]

	-- Add the parameters for the stored procedure here
	@Label nvarchar(255) = NULL, 
	@Year int = NULL,
	@Month int =NULL,
	@Day int =NULL,
	@WeekOfMonth int =NULL

AS
BEGIN
    --********Select data From Table [Reporting].[Cartes]******************************-
	

	SELECT *
	
	FROM [Reporting].[Cartes]

	WHERE (Label IN( SELECT VALUE FROM string_split(@Label, ',')) OR @Label IS NULL) AND (Year = @Year OR @Year IS NULL) AND (Month = @Month OR @Month IS NULL) 
	AND (Day = @Day OR @Day IS NULL) AND (WeekOfMonth = @WeekOfMonth OR @WeekOfMonth IS NULL)

END