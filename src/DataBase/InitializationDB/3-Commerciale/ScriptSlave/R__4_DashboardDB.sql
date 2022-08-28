GO
PRINT N'Cr�ation de Table [Reporting].[Cartes]...';


GO
CREATE TABLE [Reporting].[Cartes] (
    [Module]      NVARCHAR (255) NULL,
    [Label]       NVARCHAR (255) NULL,
    [Year]        NVARCHAR (255) NULL,
    [Month]       NVARCHAR (255) NULL,
    [Day]         NVARCHAR (255) NULL,
    [WeekOfMonth] NVARCHAR (255) NULL,
    [Value]       FLOAT (53)     NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[DimAccount]...';


GO
CREATE TABLE [Reporting].[DimAccount] (
    [AccountId]             BIGINT        NULL,
    [AccountCode]           INT           NULL,
    [AccountLabel]          VARCHAR (255) NULL,
    [AccountIsLitrable]     BIT           NULL,
    [AccountIsReconcilable] BIT           NULL,
    [AccountPlanId]         BIGINT        NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[DimCountry]...';


GO
CREATE TABLE [Reporting].[DimCountry] (
    [IdCountry] INT            NULL,
    [NameEn]    NVARCHAR (255) NULL,
    [NameFr]    NVARCHAR (255) NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[DimCurrency]...';


GO
CREATE TABLE [Reporting].[DimCurrency] (
    [IdCurrency]   INT            NOT NULL,
    [CurrencyCode] NVARCHAR (255) NULL,
    CONSTRAINT [PK_Currency_1] PRIMARY KEY CLUSTERED ([IdCurrency] ASC)
);


GO
PRINT N'Cr�ation de Table [Reporting].[DimDate]...';


GO
CREATE TABLE [Reporting].[DimDate] (
    [DateId]         VARCHAR (8)   NULL,
    [Date]           DATE          NULL,
    [DayName]        NVARCHAR (30) NULL,
    [TheDay]         INT           NULL,
    [TheDayOfYear]   INT           NULL,
    [TheWeekOfMonth] VARCHAR (1)   NULL,
    [Month]          NVARCHAR (30) NULL,
    [TheMonth]       INT           NULL,
    [Quarter]        INT           NULL,
    [Year]           INT           NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[DimFiscalYear]...';


GO
CREATE TABLE [Reporting].[DimFiscalYear] (
    [FiscalYearId]             BIGINT        NULL,
    [FiscalYearClosingState]   INT           NULL,
    [FiscalYearConclusionDate] DATETIME2 (7) NULL,
    [FiscalYearStartDate]      DATETIME2 (7) NULL,
    [FiscalYearEndDate]        DATETIME2 (7) NULL,
    [FiscalYearName]           VARCHAR (255) NULL,
    [FiscalYearClosingDate]    DATETIME2 (7) NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[DimItem]...';


GO
CREATE TABLE [Reporting].[DimItem] (
    [IdItem]          INT            NOT NULL,
    [IdUnitStock]     INT            NULL,
    [IdUnitSales]     INT            NULL,
    [ItemCode]        NVARCHAR (255) NULL,
    [ItemDescription] NVARCHAR (255) NULL,
    [IdItemFamily]    INT            NULL,
    [LabelItemFamily] NVARCHAR (255) NULL,
    [IdSubFamily]     INT            NULL,
    [LabelSubFamily]  NVARCHAR (255) NULL,
    [IdItemNature]    INT            NULL,
    [LabelItemNature] NVARCHAR (255) NULL,
    CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED ([IdItem] ASC)
);


GO
PRINT N'Cr�ation de Table [Reporting].[DimTiers]...';


GO
CREATE TABLE [Reporting].[DimTiers] (
    [IdTiers]        INT            NOT NULL,
    [TiersName]      NVARCHAR (255) NULL,
    [TiersCode]      NVARCHAR (255) NULL,
    [IdTypeTiers]    INT            NULL,
    [TypeTiersLabel] NVARCHAR (255) NULL,
    [TiersAdress]    NVARCHAR (255) NULL,
    [IdCountryTiers] INT            NULL,
    [CountryEn]      NVARCHAR (255) NULL,
    [CountryFr]      NVARCHAR (255) NULL,
    [IdAccount]      INT            NULL,
    [CreationDate]   DATE           NULL,
    CONSTRAINT [PK_Dim.Tiers] PRIMARY KEY CLUSTERED ([IdTiers] ASC)
);


GO
PRINT N'Cr�ation de Table [Reporting].[DimWarehouse]...';


GO
CREATE TABLE [Reporting].[DimWarehouse] (
    [IdWarehouse]     INT            NOT NULL,
    [WarehouseCode]   NVARCHAR (255) NULL,
    [WarehouseName]   NVARCHAR (255) NULL,
    [WarehouseAdress] NVARCHAR (255) NULL,
    CONSTRAINT [PK_Warehouse] PRIMARY KEY CLUSTERED ([IdWarehouse] ASC)
);


GO
PRINT N'Cr�ation de Table [Reporting].[FctClaims]...';


GO
CREATE TABLE [Reporting].[FctClaims] (
    [IdClaim]                INT            NULL,
    [ClaimCode]              NVARCHAR (255) NULL,
    [ClaimDescription]       NVARCHAR (255) NULL,
    [IdDocument]             INT            NULL,
    [IdDocumentLine]         INT            NULL,
    [DocumentDate]           DATETIME       NULL,
    [ClaimQty]               FLOAT (53)     NULL,
    [IdMouvementIn]          INT            NULL,
    [IdMovementOut]          INT            NULL,
    [IdWarehouse]            INT            NULL,
    [IdSupplier]             INT            NULL,
    [IdClient]               INT            NULL,
    [IdClaimStatus]          INT            NULL,
    [LabelClaimStatus]       NVARCHAR (255) NULL,
    [TranslationClaimStatus] NVARCHAR (255) NULL,
    [DescriptionClaimType]   NVARCHAR (255) NULL,
    [TranslationClaimType]   NVARCHAR (255) NULL,
    [IdItem]                 INT            NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[FctDocumentAccountLine]...';


GO
CREATE TABLE [Reporting].[FctDocumentAccountLine] (
    [DocumentAccountId]                     BIGINT          NULL,
    [DocumentAccountCode]                   VARCHAR (255)   NULL,
    [DocumentAccountCreationDate]           DATETIME2 (7)   NULL,
    [DocumentAccountDate]                   DATETIME2 (7)   NULL,
    [DocumentAccountLabel]                  VARCHAR (255)   NULL,
    [DocumentAccountStatus]                 VARCHAR (255)   NULL,
    [FiscalYearId]                          BIGINT          NULL,
    [JournalId]                             BIGINT          NULL,
    [DocumentAccountLineId]                 BIGINT          NULL,
    [DocumentAccountLineCreditAmount]       NUMERIC (19, 3) NULL,
    [DocumentAccountLineDebitAmount]        NUMERIC (19, 3) NULL,
    [DocumentAccountLineDate]               DATETIME2 (7)   NULL,
    [DocumentAccountLineIsClose]            BIT             NULL,
    [DocumentAccountLineLabel]              VARCHAR (255)   NULL,
    [DocumentAccountLineLetter]             VARCHAR (255)   NULL,
    [DocumentAccountLineReconciliationDate] DATE            NULL,
    [DocumentAccountLineReference]          VARCHAR (255)   NULL,
    [AccountIdAssociated]                   BIGINT          NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[FctFinancialCommitment]...';


GO
CREATE TABLE [Reporting].[FctFinancialCommitment] (
    [IdSettlementCommitment]      INT            NULL,
    [CommitmentId]                INT            NULL,
    [SettlementId]                INT            NULL,
    [AssignedAmount]              FLOAT (53)     NULL,
    [RemplacedBy]                 INT            NULL,
    [ExchangeRate]                INT            NULL,
    [IdSettlement]                INT            NULL,
    [SettlementDate]              DATE           NULL,
    [SettlementCode]              NVARCHAR (255) NULL,
    [SettlementAmount]            FLOAT (53)     NULL,
    [CommitmentDate]              DATE           NULL,
    [Holder]                      NVARCHAR (255) NULL,
    [Note]                        NVARCHAR (255) NULL,
    [Idpaymentmethod]             INT            NULL,
    [MethodName]                  NVARCHAR (50)  NULL,
    [IdPaymentStatus]             INT            NULL,
    [PaymentStatus]               NVARCHAR (255) NULL,
    [IdFinancialCommitment]       INT            NULL,
    [BenefitPeriod]               INT            NULL,
    [FinancialCommitmentDate]     DATE           NULL,
    [RemainingAmount]             FLOAT (53)     NULL,
    [AmountWithCurrency]          FLOAT (53)     NULL,
    [RemainingAmountWithCurrency] FLOAT (53)     NULL,
    [IdTiers]                     INT            NULL,
    [IdDocument]                  INT            NULL,
    [DocumentTypeCode]            NVARCHAR (255) NULL,
    [DocumentDate]                DATE           NULL,
    [DocumentTTCPrice]            FLOAT (53)     NULL,
    [DocumentRemainingAmount]     FLOAT (53)     NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[FctPayslip]...';


GO
CREATE TABLE [Reporting].[FctPayslip] (
    [IdPayslipDetails]            INT            NULL,
    [IdSalaryRule]                INT            NULL,
    [SalaryRuleDescription]       NVARCHAR (255) NULL,
    [Order]                       INT            NULL,
    [Gain]                        FLOAT (53)     NULL,
    [Deduction]                   FLOAT (53)     NULL,
    [IdPayslip]                   INT            NULL,
    [StartDate]                   DATE           NULL,
    [EndDate]                     DATE           NULL,
    [IdBonus]                     INT            NULL,
    [IdContract]                  INT            NULL,
    [IdEmployee]                  INT            NULL,
    [IdSession]                   INT            NULL,
    [NumberDaysLeaveTaken]        INT            NULL,
    [NumberDaysNonPaidLeaveTaken] INT            NULL,
    [NumberDaysWorked]            INT            NULL,
    [NumberOfDays]                INT            NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[FctPurchases]...';


GO
CREATE TABLE [Reporting].[FctPurchases] (
    [IdDocument]                   INT            NULL,
    [DocumentCode]                 NVARCHAR (255) NULL,
    [DocumentTypeCode]             NVARCHAR (255) NULL,
    [DocumentTypeLabel]            NVARCHAR (255) NULL,
    [DocumentDate]                 DATETIME       NULL,
    [DocumentMonth]                INT            NULL,
    [DocumentYear]                 INT            NULL,
    [DocumentTTCPrice]             FLOAT (53)     NULL,
    [DocumentRemainingAmount]      FLOAT (53)     NULL,
    [DocumentHTPrice]              FLOAT (53)     NULL,
    [DocumentHTPriceWithCurrency]  FLOAT (53)     NULL,
    [DocumentTTCPriceWithCurrency] FLOAT (53)     NULL,
    [IdCurrency]                   INT            NULL,
    [IdStatus]                     INT            NULL,
    [DocumentStatus]               NVARCHAR (255) NULL,
    [IdTiers]                      INT            NULL,
    [IdItem]                       INT            NULL,
    [IdDocumentLine]               INT            NULL,
    [DocumentLineDesignation]      NVARCHAR (255) NULL,
    [TtcTotalLine]                 FLOAT (53)     NULL,
    [HtTotalLine]                  FLOAT (53)     NULL,
    [AmountPerItem]                FLOAT (53)     NULL,
    [ItemQuantity]                 INT            NULL,
    [IdWarehouse]                  INT            NULL,
    [AvailableQuantityPerItem]     INT            NULL,
    [IdPaymentMethod]              INT            NULL,
    [IdDocumentAssociated]         INT            NULL,
    [CodeDocumentAssociated]       NVARCHAR (255) NULL,
    [DocumentTypeCodeAssociated]   NVARCHAR (255) NULL,
    [DocumentDateAssociated]       DATETIME       NULL,
    [IdDocumentLineAssociated]     INT            NULL,
    [DocumentAssTypeLabel]         NVARCHAR (255) NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[FctSales]...';


GO
CREATE TABLE [Reporting].[FctSales] (
    [IdDocument]                   INT            NULL,
    [DocumentCode]                 NVARCHAR (255) NULL,
    [DocumentTypeCode]             NVARCHAR (255) NULL,
    [DocumentTypeLabel]            NVARCHAR (255) NULL,
    [DocumentDate]                 DATETIME       NULL,
    [DocumentMonth]                INT            NULL,
    [DocumentYear]                 INT            NULL,
    [DocumentTTCPrice]             FLOAT (53)     NULL,
    [DocumentRemainingAmount]      FLOAT (53)     NULL,
    [DocumentHTPrice]              FLOAT (53)     NULL,
    [DocumentHTPriceWithCurrency]  FLOAT (53)     NULL,
    [DocumentTTCPriceWithCurrency] FLOAT (53)     NULL,
    [IdCurrency]                   INT            NULL,
    [IdStatus]                     INT            NULL,
    [DocumentStatus]               NVARCHAR (255) NULL,
    [IdTiers]                      INT            NULL,
    [IdItem]                       INT            NULL,
    [IdDocumentLine]               INT            NULL,
    [DocumentLineDesignation]      NVARCHAR (255) NULL,
    [TtcTotalLine]                 FLOAT (53)     NULL,
    [HtTotalLine]                  FLOAT (53)     NULL,
    [AmountPerItem]                FLOAT (53)     NULL,
    [ItemQuantity]                 INT            NULL,
    [IdWarehouse]                  INT            NULL,
    [AvailableQuantityPerItem]     INT            NULL,
    [IdPaymentMethod]              INT            NULL,
    [IdDocumentAssociated]         INT            NULL,
    [CodeDocumentAssociated]       NVARCHAR (255) NULL,
    [DocumentTypeCodeAssociated]   NVARCHAR (255) NULL,
    [DocumentDateAssociated]       DATETIME       NULL,
    [IdDocumentLineAssociated]     INT            NULL,
    [DocumentAssTypeLabel]         NVARCHAR (255) NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[FeedLOG]...';


GO
CREATE TABLE [Reporting].[FeedLOG] (
    [TableName]          NVARCHAR (255)  NULL,
    [InsertedRowsNumber] INT             NULL,
    [Date]               DATETIME        NULL,
    [ErrorMessage]       NVARCHAR (4000) NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[KPIAmountPerSalaryRule]...';


GO
CREATE TABLE [Reporting].[KPIAmountPerSalaryRule] (
    [IdSalaryRule] INT             NULL,
    [Rule]         NVARCHAR (255)  NULL,
    [Gain]         FLOAT (53)      NULL,
    [Deduction]    FLOAT (53)      NULL,
    [RuleFormula]  NVARCHAR (2000) NULL,
    [Year]         INT             NULL,
    [Month]        INT             NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[KPIClaimsPerProduct]...';


GO
CREATE TABLE [Reporting].[KPIClaimsPerProduct] (
    [IdClaim]          INT            NULL,
    [ClaimCode]        NVARCHAR (255) NULL,
    [ClaimDescription] NVARCHAR (255) NULL,
    [DocumentDate]     DATETIME       NULL,
    [ClaimQty]         FLOAT (53)     NULL,
    [IdClaimStatus]    INT            NULL,
    [LabelClaimStatus] NVARCHAR (255) NULL,
    [IdItem]           INT            NULL,
    [ItemCode]         NVARCHAR (255) NULL,
    [ItemDescription]  NVARCHAR (255) NULL,
    [LabelItemFamily]  NVARCHAR (255) NULL,
    [LabelItemNature]  NVARCHAR (255) NULL,
    [LabelSubFamily]   NVARCHAR (255) NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[KPIConversionRate]...';


GO
CREATE TABLE [Reporting].[KPIConversionRate] (
    [DocumentId]      INT            NULL,
    [DocumentType]    NVARCHAR (255) NULL,
    [Month]           INT            NULL,
    [Year]            INT            NULL,
    [TiersName]       NVARCHAR (255) NULL,
    [Type]            NVARCHAR (255) NULL,
    [QtyDelivered]    INT            NULL,
    [QtyOrdered]      INT            NULL,
    [ConversionRate1] FLOAT (53)     NULL,
    [ConversionRate2] FLOAT (53)     NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[KPIConversionRateDetails]...';


GO
CREATE TABLE [Reporting].[KPIConversionRateDetails] (
    [IdDocumentLine]        INT            NULL,
    [IdDocument]            INT            NULL,
    [DocumentType]          NVARCHAR (255) NULL,
    [Month]                 INT            NULL,
    [Year]                  INT            NULL,
    [IdItem]                INT            NULL,
    [ItemDescription]       NVARCHAR (255) NULL,
    [ItemNature]            NVARCHAR (255) NULL,
    [ItemFamily]            NVARCHAR (255) NULL,
    [TiersName]             NVARCHAR (255) NULL,
    [Type]                  NVARCHAR (255) NULL,
    [QtyDelivered]          INT            NULL,
    [QtyOrdered]            INT            NULL,
    [ConversionRateDetails] FLOAT (53)     NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[KPICustomerAcquisitionCost]...';


GO
CREATE TABLE [Reporting].[KPICustomerAcquisitionCost] (
    [CAC]        FLOAT (53)     NULL,
    [FiscalYear] NVARCHAR (255) NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[KPIDeliveryRate]...';


GO
CREATE TABLE [Reporting].[KPIDeliveryRate] (
    [TotalCommanded] INT            NULL,
    [TotalDelivred]  INT            NULL,
    [DeliveryRate]   FLOAT (53)     NULL,
    [DocumentMonth]  INT            NULL,
    [DocumentYear]   INT            NULL,
    [PeriodEnum]     TINYINT        NULL,
    [Period]         NVARCHAR (50)  NULL,
    [StartPeriod]    DATE           NULL,
    [EndPeriod]      DATE           NULL,
    [Type]           NVARCHAR (255) NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[KPIGrossMargin]...';


GO
CREATE TABLE [Reporting].[KPIGrossMargin] (
    [Year]                                                INT        NULL,
    [Month]                                               INT        NULL,
    [GrossMarginCurrentYear]                              FLOAT (53) NULL,
    [GrossMarginLastMonth]                                FLOAT (53) NULL,
    [GrossMarginLastYear]                                 FLOAT (53) NULL,
    [GrossMarginLastMonthLastYear]                        FLOAT (53) NULL,
    [GrossMarginYearToDate]                               FLOAT (53) NULL,
    [GrossMarginLastYearYearToDate]                       FLOAT (53) NULL,
    [GrossMarginVariationCurrentMonthLastMonth]           FLOAT (53) NULL,
    [GrossMarginVariationCurrentYearLastYear]             FLOAT (53) NULL,
    [GrossMarginVariationCurrentYearToDateLastYearToDate] FLOAT (53) NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[KPIGrossOperatingSurplus]...';


GO
CREATE TABLE [Reporting].[KPIGrossOperatingSurplus] (
    [Year]                                    INT        NULL,
    [Month]                                   INT        NULL,
    [GrossOperatingSurplusCurrentYear]        FLOAT (53) NULL,
    [GrossOperatingSurplusLastMonth]          FLOAT (53) NULL,
    [GrossOperatingSurplusLastMonthLastYear]  FLOAT (53) NULL,
    [GrossOperatingSurplusLastYear]           FLOAT (53) NULL,
    [GrossOperatingSurplusYearToDate]         FLOAT (53) NULL,
    [GrossOperatingSurplusYearToDateLastYear] FLOAT (53) NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[KPIOrderState]...';


GO
CREATE TABLE [Reporting].[KPIOrderState] (
    [DocumentDate]   DATETIME       NULL,
    [Year]           INT            NULL,
    [Month]          INT            NULL,
    [IdOrder]        INT            NULL,
    [OrderCode]      NVARCHAR (255) NULL,
    [HtAmount]       FLOAT (53)     NULL,
    [IdStatus]       INT            NULL,
    [DocumentStatus] NVARCHAR (255) NULL,
    [TiersName]      NVARCHAR (255) NULL,
    [TiersCode]      NVARCHAR (255) NULL,
    [Type]           NVARCHAR (255) NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[KPIPaymentMethodPerClient]...';


GO
CREATE TABLE [Reporting].[KPIPaymentMethodPerClient] (
    [Year]                           INT            NULL,
    [Month]                          INT            NULL,
    [PaymentMethod]                  NVARCHAR (255) NULL,
    [PaymentMethodCurrentYear]       INT            NULL,
    [PaymentMethodLastMonth]         INT            NULL,
    [PaymentMethodLastYearLastMonth] INT            NULL,
    [PaymentMethodLastYear]          INT            NULL,
    [PaymentMethodYearToDate]        INT            NULL,
    [PaymentMethodLastYearToDate]    INT            NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[KPISalesPerItem]...';


GO
CREATE TABLE [Reporting].[KPISalesPerItem] (
    [HtTotalPerItem]  FLOAT (53)     NULL,
    [QuantityPerItem] FLOAT (53)     NULL,
    [IdItem]          INT            NULL,
    [ItemCode]        NVARCHAR (255) NULL,
    [ItemDescription] NVARCHAR (255) NULL,
    [LabelItemFamily] NVARCHAR (255) NULL,
    [OperationType]   NVARCHAR (20)  NULL,
    [PeriodEnum]      TINYINT        NULL,
    [Period]          NVARCHAR (50)  NULL,
    [StartPeriod]     DATE           NULL,
    [EndPeriod]       DATE           NULL,
    [RankByAmount]    INT            NULL,
    [RankByQuantity]  INT            NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[KPISalesPerItemFamily]...';


GO
CREATE TABLE [Reporting].[KPISalesPerItemFamily] (
    [HtTotalPerItemFamily]  FLOAT (53)     NULL,
    [QuantityPerItemFamily] INT            NULL,
    [ItemFamily]            NVARCHAR (255) NULL,
    [OperationType]         NVARCHAR (255) NULL,
    [PeriodEnum]            TINYINT        NULL,
    [Period]                NVARCHAR (50)  NULL,
    [StartPeriod]           DATE           NULL,
    [EndPeriod]             DATE           NULL,
    [RankByAmount]          INT            NULL,
    [RankByQuantity]        INT            NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[KPISalesPurchasesState]...';


GO
CREATE TABLE [Reporting].[KPISalesPurchasesState] (
    [InvoiceAmountHT]        FLOAT (53)     NULL,
    [InvoiceAmountTTC]       FLOAT (53)     NULL,
    [InvoiceRemainingAmount] FLOAT (53)     NULL,
    [Month]                  TINYINT        NULL,
    [Year]                   SMALLINT       NULL,
    [Type]                   NVARCHAR (255) NULL,
    [PeriodEnum]             TINYINT        NULL,
    [Period]                 NVARCHAR (50)  NULL,
    [StartPeriod]            DATE           NULL,
    [EndPeriod]              DATE           NULL,
    [YTDInvoiceAmountHT]     FLOAT (53)     NULL,
    [YTDInvoiceAmountTTC]    FLOAT (53)     NULL,
    [LYTDInvoiceAmountHT]    FLOAT (53)     NULL,
    [LYTDInvoiceAmountTTC]   FLOAT (53)     NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[KPISearchItems]...';


GO
CREATE TABLE [Reporting].[KPISearchItems] (
    [Month]           INT            NULL,
    [Year]            INT            NULL,
    [SearchItemValue] NVARCHAR (255) NULL,
    [ItemCode]        NVARCHAR (255) NULL,
    [ItemDescription] NVARCHAR (MAX) NULL,
    [NumberSearched]  INT            NULL,
    [SearchMethod]    NVARCHAR (15)  NULL,
    [Rank]            INT            NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[KPITopTiers]...';


GO
CREATE TABLE [Reporting].[KPITopTiers] (
    [DocumentDate]    DATETIME       NULL,
    [DocumentMonth]   INT            NULL,
    [PeriodEnum]      TINYINT        NULL,
    [Period]          NVARCHAR (50)  NULL,
    [StartPeriod]     DATE           NULL,
    [EndPeriod]       DATE           NULL,
    [DocumentYear]    INT            NULL,
    [IdTiers]         INT            NULL,
    [TiersName]       NVARCHAR (255) NULL,
    [TiersCode]       NVARCHAR (255) NULL,
    [HTAmount]        FLOAT (53)     NULL,
    [TTCAmount]       FLOAT (53)     NULL,
    [Quantity]        INT            NULL,
    [Type]            NVARCHAR (255) NULL,
    [RankByTTCAmount] INT            NULL,
    [RankByQuantity]  INT            NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[KPITurnoverChangeRate]...';


GO
CREATE TABLE [Reporting].[KPITurnoverChangeRate] (
    [FirstYear]          DATE          NULL,
    [SecondYear]         DATE          NULL,
    [Month]              DATE          NULL,
    [DocumentTypeCode]   NVARCHAR (55) NULL,
    [TurnoverFirstYear]  FLOAT (53)    NULL,
    [TurnoverSecondYear] FLOAT (53)    NULL,
    [ChangeRate]         FLOAT (53)    NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[KPITurnoverPerSales]...';


GO
CREATE TABLE [Reporting].[KPITurnoverPerSales] (
    [Year]                               FLOAT (53) NULL,
    [Month]                              FLOAT (53) NULL,
    [TurnoverPerSalesCurrentYear]        FLOAT (53) NULL,
    [TurnoverPerSalesLastMonth]          FLOAT (53) NULL,
    [TurnoverPerSalesLastMonthLastYear]  FLOAT (53) NULL,
    [TurnoverPerSalesLastYear]           FLOAT (53) NULL,
    [TurnoverPerSalesYearToDate]         FLOAT (53) NULL,
    [TurnoverPerSalesYearToDateLastYear] FLOAT (53) NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[KPIUpcomingInterviews]...';


GO
CREATE TABLE [Reporting].[KPIUpcomingInterviews] (
    [Year]        FLOAT (53) NULL,
    [Month]       FLOAT (53) NULL,
    [Day]         FLOAT (53) NULL,
    [WeekOfMonth] FLOAT (53) NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[LeaveConsolidated]...';


GO
CREATE TABLE [Reporting].[LeaveConsolidated] (
    [ID]                       INT            NULL,
    [EmployeeName]             VARCHAR (100)  NULL,
    [Gender]                   INT            NULL,
    [Age]                      INT            NULL,
    [SalaryStructureReference] NVARCHAR (255) NULL,
    [TeamName]                 NVARCHAR (255) NULL,
    [DepartmentName]           NVARCHAR (255) NULL,
    [ProjectName]              NVARCHAR (125) NULL,
    [CRAStatus]                VARCHAR (18)   NULL,
    [MonthCRA]                 VARCHAR (100)  NULL,
    [IdLeave]                  INT            NULL,
    [StartLeave]               VARCHAR (81)   NULL,
    [EndLeave]                 VARCHAR (81)   NULL,
    [SubmissionDate]           DATETIME       NULL,
    [DayCalculator]            FLOAT (53)     NULL,
    [LeaveType]                NVARCHAR (250) NULL,
    [LeaveStatus]              VARCHAR (8)    NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[ParameterPeriod]...';


GO
CREATE TABLE [Reporting].[ParameterPeriod] (
    [PeriodEnum]  INT            NULL,
    [Period]      NVARCHAR (255) NULL,
    [StartPeriod] DATE           NULL,
    [EndPeriod]   DATE           NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[ParameterReference]...';


GO
CREATE TABLE [Reporting].[ParameterReference] (
    [Reference] NVARCHAR (255) NULL,
    [Code]      NVARCHAR (255) NULL,
    [LabelFr]   NVARCHAR (255) NULL,
    [LabelEng]  NVARCHAR (255) NULL
);


GO
PRINT N'Cr�ation de Table [Reporting].[SearchLOG]...';


GO
CREATE TABLE [Reporting].[SearchLOG] (
    [Id]        INT            NULL,
    [IdTiers]   INT            NULL,
    [Date]      DATETIME       NULL,
    [IdCashier] INT            NULL,
    [Property]  NVARCHAR (255) NULL,
    [Value]     NVARCHAR (255) NULL
);


GO
PRINT N'Cr�ation de Proc�dure [Reporting].[DaysSalesOutstanding]...';


GO


CREATE PROCEDURE [Reporting].[DaysSalesOutstanding]
  @Period tinyint= 2
  --@DocumentType nvarchar(5)='I-SA'
 AS
 BEGIN

DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
DECLARE @StartPeriod date, @EndPeriod date

SET @StartPeriod = (SELECT StartPeriod FROM [Reporting].[ParameterPeriod] WHERE PeriodEnum = @Period) 
SET @EndPeriod = (SELECT EndPeriod FROM [Reporting].[ParameterPeriod] WHERE PeriodEnum = @Period) 
--	SELECT  SUM(DocumentTTCPrice) AS TotalPrice,
--		DocumentTypeCode,
--		MONTH(DocumentDate) AS [Month],
--		YEAR(DocumentDate) AS [Year],
--		DATEDIFF( day, @StartPeriod,@EndPeriod ) AS Days

		
--		INTO #totalTTCprice
--		-- select * from #totalTTCprice
--			from[Reporting].[FinancialCommitmentConsolidated] 
--				WHERE DocumentTypeCode = 'I-SA'
--				--AND DocumentDate BETWEEN @StartPeriod AND @EndPeriod
--				group by
--				DocumentTypeCode,
--                MONTH(DocumentDate) ,
--		        YEAR(DocumentDate) 				--),
--			--	select * from #totalTTCprice
--			--	drop table #totalTTCprice

--	--  Remaining as (				    
--	  --Total	Remaining Amount
		
--		SELECT SUM(RemainingAmountWithCurrency) AS TotalReamining,
--		DocumentTypeCode,
--		MONTH(DocumentDate) AS [Month],
--		YEAR(DocumentDate) AS [Year],
--		DATEDIFF( day, @StartPeriod,@StartPeriod ) AS Days

		
--		INTO #totalRemainingAmountWithCurrency
--			from[Reporting].[FinancialCommitmentConsolidated] 
--				WHERE DocumentTypeCode = 'I-SA'
--				AND DocumentDate BETWEEN @StartPeriod AND @EndPeriod
--				group by
--				DocumentTypeCode,
--				DocumentDate,
--				MONTH(DocumentDate) ,
--		        YEAR(DocumentDate) ---)
--								--drop table #totalRemainingAmountWithCurrency
--								--select * from #totalRemainingAmountWithCurrency

			
			
			
--	   SELECT total.Year,
--	   total.Month,
--	   total.DocumentTypeCode,
--	   total.TotalPrice,
--	   total.Days,
--	   refused.TotalReamining,
--	   CAST((ISNULL(total.TotalPrice - refused.TotalReamining,0)/total.TotalPrice)*total.Days AS NUMERIC(15,2)) AS DaysSalesOutstanding,
--	   CASE 
--     WHEN CAST((ISNULL(total.TotalPrice - refused.TotalReamining,0)/total.TotalPrice)*total.Days AS NUMERIC(15,2))>45 THEN 'Bad'
--     WHEN CAST((ISNULL(total.TotalPrice - refused.TotalReamining,0)/total.TotalPrice)*total.Days AS NUMERIC(15,2))<45 THEN 'Excellent'
--END AS Status
--FROM #totalTTCprice total
--LEFT JOIN #totalRemainingAmountWithCurrency refused
--ON     total.Month = refused.Month
--   AND total.Year = refused.Year
--   --AND DocumentCreationDate BETWEEN @StartPeriod AND @EndPeriod



---------------------------------------------------------------------------------------------------------------------------------


BEGIN TRY

	select    CAST((ISNULL(a.TotalPrice - a.TotalReamining,0)/a.TotalPrice)*a.Days AS NUMERIC(15,2)) AS DaysSalesOutstanding,
 		   CASE 
		 WHEN CAST((ISNULL(a.TotalPrice - a.TotalReamining,0)/a.TotalPrice)*a.Days AS NUMERIC(15,2))>45 THEN 'Bad'
		 WHEN CAST((ISNULL(a.TotalPrice - a.TotalReamining,0)/a.TotalPrice)*a.Days AS NUMERIC(15,2))<45 THEN 'Excellent'
	END AS Status,
			   a.[Month] ,
				a.[Year],
				DocumentTypeCode

	 from (
   		SELECT
		--SUM()
		AssignedAmount AS TotalPrice,
		--SUM()
		RemainingAmount AS TotalReamining,
		DocumentTypeCode,
			MONTH(DocumentDate) AS [Month],
			YEAR(DocumentDate) AS [Year],
			DATEDIFF( day, @StartPeriod,@EndPeriod ) AS Days

					from[Reporting].[FinancialCommitmentConsolidatedV2] 
					WHERE DocumentTypeCode = 'I-SA'
					AND DocumentDate BETWEEN @StartPeriod AND @EndPeriod
					group by
					AssignedAmount,
					RemainingAmount,
					DocumentTypeCode,
					MONTH(DocumentDate) ,
					YEAR(DocumentDate)
					)a

	----------------------------------------------------------------------------




	--	SELECT  AssignedAmount AS TotalPrice,
	--		    DocumentTypeCode,
	--		MONTH(DocumentDate) AS [Month],
	--		SettlementId AS SettlementId,
	--		YEAR(DocumentDate) AS [Year],

	--		DATEDIFF( day, @StartPeriod,@EndPeriod ) AS Days

		
	--		INTO #totalTTCprice
	--		--drop table #totalTTCprice
	--		-- select * from #totalTTCprice
	--			from[Reporting].[FinancialCommitmentConsolidatedV2] 
	--				WHERE DocumentTypeCode = 'I-SA'
	--				AND DocumentDate BETWEEN @StartPeriod AND @EndPeriod
	--				group by
	--				DocumentTypeCode,
	--				SettlementId,
	--                MONTH(DocumentDate) ,
	--		        YEAR(DocumentDate) 	,
	--				AssignedAmount--),
	--			--	select * from #totalTTCprice
	--			--	drop table #totalTTCprice

	--	--  Remaining as (				    
	--	  --Total	Remaining Amount
		
	--		SELECT RemainingAmount AS TotalReamining,
	--		DocumentTypeCode,
	--		MONTH(DocumentDate) AS [Month],
	--		YEAR(DocumentDate) AS [Year],
	--		DATEDIFF( day, @StartPeriod,@StartPeriod ) AS Days

		
	--		INTO #totalRemainingAmountWithCurrency
	--			from[Reporting].[FinancialCommitmentConsolidatedV2] 
	--				WHERE DocumentTypeCode = 'I-SA'
	--				AND DocumentDate BETWEEN @StartPeriod AND @EndPeriod
	--				group by
	--				DocumentTypeCode,
	--				DocumentDate,
	--				MONTH(DocumentDate) ,
	--				RemainingAmount,
	--		        YEAR(DocumentDate)
	--				---)
	--								--drop table #totalRemainingAmountWithCurrency
	--								--select * from #totalRemainingAmountWithCurrency

			
			
			
	--	   SELECT total.Year,
	--	   total.Month,
	--	   total.DocumentTypeCode,
	--	   total.TotalPrice,
	--	   total.Days,
	--	   total.SettlementId,
	--	   refused.TotalReamining,
	--	   CAST((ISNULL(total.TotalPrice - refused.TotalReamining,0)/total.TotalPrice)*total.Days AS NUMERIC(15,2)) AS DaysSalesOutstanding,
	--	   CASE 
	--     WHEN CAST((ISNULL(total.TotalPrice - refused.TotalReamining,0)/total.TotalPrice)*total.Days AS NUMERIC(15,2))>45 THEN 'Bad'
	--     WHEN CAST((ISNULL(total.TotalPrice - refused.TotalReamining,0)/total.TotalPrice)*total.Days AS NUMERIC(15,2))<45 THEN 'Excellent'
	--END AS Status
	--FROM #totalTTCprice total
	--LEFT JOIN #totalRemainingAmountWithCurrency refused
	--ON     total.Month = refused.Month
	--   AND total.Year = refused.Year
	--   --AND DocumentCreationDate BETWEEN @StartPeriod AND @EndPeriod

	SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT '[DaysSalesOutstanding', @NbInserted, GETDATE(), @ErrorMessage
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[ExportSalesPurchasesPerItem]...';


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Reporting].[ExportSalesPurchasesPerItem]

	 @Period tinyint= 4,
	 @OperationType nvarchar(255)='SA'

AS
BEGIN

DECLARE @StartPeriod date, @EndPeriod date

	SET @StartPeriod = (SELECT StartPeriod FROM [Reporting].[ParameterPeriod] WHERE PeriodEnum = @Period) 
	SET @EndPeriod = (SELECT EndPeriod FROM [Reporting].[ParameterPeriod] WHERE PeriodEnum = @Period) 


----FINAL QUERY--

IF @OperationType='SA'

SELECT * , @Period As PeriodEnum, @OperationType As [Type]
FROM [Reporting].[FctSales] sale WITH(NOLOCK)
INNER JOIN [Reporting].[DimItem] item WITH(NOLOCK) ON item.IdItem=sale.IdItem
WHERE sale.DocumentDate BETWEEN @StartPeriod AND @EndPeriod
AND sale.DocumentTypeCode IN ('A-SA','BS-SA','D-SA','IA-SA','I-SA','O-SA','Q-SA')


IF @OperationType='PU'

SELECT * , @Period As PeriodEnum, @OperationType As [Type]
FROM [Reporting].[FctPurchases] purchase WITH(NOLOCK)
INNER JOIN [Reporting].[DimItem] item WITH(NOLOCK) ON item.IdItem=purchase.IdItem
WHERE purchase.DocumentDate BETWEEN @StartPeriod AND @EndPeriod
AND purchase.DocumentTypeCode IN ('A-PU','BE-SA','B-PU','D-PU','FO-PU','I-PU','O-PU','Q-PU','RQ-PU')

----FINAL QUERY--

--SELECT *
--FROM(
--		SELECT t.*, ROW_NUMBER() OVER (PARTITION BY PeriodEnum ORDER BY DocumentHtPrice DESC) AS [Rank]
--		FROM #temp t
--)A
--WHERE [Rank] <= @NumberOfRows OR @NumberOfRows IS NULL
    
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[ExportSalesPurchasesPerTiers]...';


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Reporting].[ExportSalesPurchasesPerTiers]

	 @Period tinyint= 4,
	 @OperationType nvarchar(255)='SA'

AS
BEGIN

DECLARE @StartPeriod date, @EndPeriod date

	SET @StartPeriod = (SELECT StartPeriod FROM [Reporting].[ParameterPeriod] WHERE PeriodEnum = @Period) 
	SET @EndPeriod = (SELECT EndPeriod FROM [Reporting].[ParameterPeriod] WHERE PeriodEnum = @Period) 


----FINAL QUERY--

IF @OperationType='SA'

SELECT * , @Period As PeriodEnum, @OperationType As [Type]
FROM [Reporting].[FctSales] sale WITH(NOLOCK)
INNER JOIN [Reporting].[DimTiers] tier WITH(NOLOCK) ON tier.IdTiers=sale.IdTiers
WHERE sale.DocumentDate BETWEEN @StartPeriod AND @EndPeriod
AND sale.DocumentTypeCode IN ('A-SA','BS-SA','D-SA','IA-SA','I-SA','O-SA','Q-SA')


IF @OperationType='PU'

SELECT * , @Period As PeriodEnum, @OperationType As [Type]
FROM [Reporting].[FctPurchases] purchase WITH(NOLOCK)
INNER JOIN [Reporting].[DimTiers] tier WITH(NOLOCK) ON tier.IdTiers=purchase.IdTiers
WHERE purchase.DocumentDate BETWEEN @StartPeriod AND @EndPeriod
AND purchase.DocumentTypeCode IN ('A-PU','BE-SA','B-PU','D-PU','FO-PU','I-PU','O-PU','Q-PU','RQ-PU')

----FINAL QUERY--

--SELECT *
--FROM(
--		SELECT t.*, ROW_NUMBER() OVER (PARTITION BY PeriodEnum ORDER BY DocumentHtPrice DESC) AS [Rank]
--		FROM #temp t
--)A
--WHERE [Rank] <= @NumberOfRows OR @NumberOfRows IS NULL
    
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedCartes]...';


GO



------------------- MAK delete compta cards  19/10/2021-------------------------------------


CREATE PROCEDURE [Reporting].[FeedCartes]
	
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


--Nombre de commandes livr�es par mois

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
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedDimAccount]...';


GO
CREATE PROCEDURE [Reporting].[FeedDimAccount]
	
AS
BEGIN

	DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

	BEGIN TRY
		--Truncate DimAccount Dimension	
		TRUNCATE TABLE [Reporting].[DimAccount]

		--Insert Into DimAccount Dimension	
		INSERT INTO [Reporting].[DimAccount]
				   (
					   [AccountId]
					  ,[AccountCode]
					  ,[AccountLabel]
					  ,[AccountIsLitrable]
					  ,[AccountIsReconcilable]
					  ,[AccountPlanId]
				   
				   )

		--Load Data In DimAccount Dimension	
		  SELECT
				       [AC_ID]
					  ,[AC_CODE]
					  ,[AC_LABEL]
					  ,[AC_IS_LITRABLE]
					  ,[AC_IS_RECONCILABLE]
					  ,[AC_PLAN_ID]
		  FROM [compta].[T_ACCOUNT] AS T_ACCOUNT WITH(NOLOCK)
		  LEFT JOIN  [Reporting].[DimChartAccounts] AS DimChartAccounts WITH(NOLOCK)
		  ON T_ACCOUNT.AC_PLAN_ID=DimChartAccounts.[ChartAccountId] 
		  WHERE T_ACCOUNT.[AC_IS_DELETED]=0

	      SET @NbInserted = @@ROWCOUNT
	
	END TRY


	BEGIN CATCH 
		SET @ErrorMessage = ERROR_MESSAGE()
	END CATCH 

	----LOG
	INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
	SELECT 'DimAccount', @NbInserted, GETDATE(), @ErrorMessage

	
		
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedDimChartAccounts]...';


GO
CREATE PROCEDURE [Reporting].[FeedDimChartAccounts]
	
AS
BEGIN

	DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

	BEGIN TRY
		--Truncate ChartAccounts Dimension	
		TRUNCATE TABLE [Reporting].[DimChartAccounts]

		--Insert Into ChartAccounts Dimension	
		INSERT INTO [Reporting].[DimChartAccounts]
				   (
					   [ChartAccountId]
					  ,[ChartAccountCode]
					  ,[ChartAccountLabel]
					  ,[ChartAccountToBalanced]
					  ,[ChartAccountParentId]
				   
				   )

		--Load Data In ChartAccounts Dimension	
		SELECT 
					   [CA_ID]
					  ,[CA_CODE]
					  ,[CA_LABEL]
					  ,[CA_TO_BALANCED]
					  ,ISNULL([CA_PARENT_ACCOUNT_ID],-1) AS [CA_PARENT_ACCOUNT_ID]
        FROM [compta].[T_CHART_ACCOUNTS] WITH(NOLOCK)
        WHERE [CA_IS_DELETED]=0


		SET @NbInserted = @@ROWCOUNT
	
	END TRY


	BEGIN CATCH 
		SET @ErrorMessage = ERROR_MESSAGE()
	END CATCH 

	----LOG
	INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
	SELECT 'DimChartAccounts', @NbInserted, GETDATE(), @ErrorMessage

	
		
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedDimCountry]...';


GO
CREATE PROCEDURE [Reporting].[FeedDimCountry]
AS
BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

BEGIN TRY
-- Truncate Country Dimension
TRUNCATE TABLE [Reporting].[DimCountry]
	
--Insert into Country Dimension
INSERT INTO [Reporting].[DimCountry]
		([IdCountry]
		,[NameEn]
		,[NameFr]
		)
	
--Load Data In Country Dimension
SELECT 
country.Id AS IdCountry,
country.NameEn,
country.NameFr

FROM [Shared].[Country] country WITH(NOLOCK)
SET @NbInserted = @@ROWCOUNT
END TRY


BEGIN CATCH 
SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'DimCountry', @NbInserted, GETDATE(), @ErrorMessage
	
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedDimCurrency]...';


GO
CREATE PROCEDURE [Reporting].[FeedDimCurrency]
AS
BEGIN
	---- SET NOCOUNT ON added to prevent extra result sets from
	---- interfering with SELECT statements.
	--SET NOCOUNT ON;


DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

BEGIN TRY	
-- Truncate Currency Dimension
TRUNCATE TABLE [Reporting].[DimCurrency]
	
--Insert into Currency Dimension
INSERT INTO [Reporting].[DimCurrency]
        ([IdCurrency]
        ,[CurrencyCode])
	
--Load Data In Currency Dimension
SELECT 

Id AS IdCurrency,
Code AS CurrencyCode
	
FROM [Administration].[Currency] WITH(NOLOCK)
	SET @NbInserted = @@ROWCOUNT
END TRY


BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'DimCurrency', @NbInserted, GETDATE(), @ErrorMessage

END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedDimDate]...';


GO
CREATE PROCEDURE [Reporting].[FeedDimDate]
AS
BEGIN
DECLARE @NbInserted int =0, @ErrorMessage nvarchar(max) = NULL

BEGIN TRY
    --Truncate Date Dimension	
	TRUNCATE TABLE [Reporting].[DimDate]
	DECLARE @StartDate  date = '20180101';
	DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR,5 , @StartDate));   
	
	WITH seq(n) AS 
	(
	  SELECT 0 UNION ALL SELECT n + 1 FROM seq
	  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
	),
	d(d) AS 
	(
	  SELECT DATEADD(DAY, n, @StartDate) FROM seq
	),
	Calendar AS
	(
	  SELECT
		    CONVERT(char(8),  d, 112) AS DateId,
			Date         = CONVERT(date, d),
			DayName      = DATENAME(WEEKDAY,   d),
			TheDay          = DATEPART(DAY,       d),
			TheDayOfYear    = DATEPART(DAYOFYEAR, d),
			CASE WHEN DATEPART(day,d) < 8 THEN '1' 
					ELSE CASE WHEN DATEPART(day,d) < 15 then '2' 
					ELSE CASE WHEN  DATEPART(day,d) < 22 then '3' 
					ELSE CASE WHEN  DATEPART(day,d) < 29 then '4'     
					ELSE '5'
					END
					END
					END
					END AS TheWeekOfMonth,
			Month    = DATENAME(MONTH,     d),
			TheMonth        = DATEPART(MONTH,     d),
			Quarter      = DATEPART(Quarter,   d),
			Year         = DATEPART(YEAR,      d)
	
	  FROM d)
		
	
--Insert into date Dimension	
	INSERT INTO [Reporting].[DimDate]
				  ([DateId],
				   [Date],
				   [DayName],
				   [TheDay],
				   [TheDayOfYear] ,
				   [TheWeekOfMonth],
				   [Month],
				   [TheMonth],
				   [Quarter],
				   [Year] 
				 )
           
  SELECT * FROM calendar WITH (NOLOCK)
  OPTION (MAXRECURSION 0)

  SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
  SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 


----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'DimDate', @NbInserted, GETDATE(), @ErrorMessage
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedDimEmployee]...';


GO
CREATE PROCEDURE [Reporting].[FeedDimEmployee]

AS
BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

	
--******************Select Data To Load Employee Dimension****************************************--
SELECT *

INTO #Temp



FROM

(
	SELECT 
	    
	emp.Id AS IdEmployee,
	emp.Matricule,
	emp.FirstName,
	emp.LastName,
	emp.Sex AS Gender,
	emp.BirthDate,
	DATEDIFF(yy, emp.BirthDate, getdate()) AS Age,
	CASE WHEN DATEDIFF(yy, emp.BirthDate, getdate()) BETWEEN 20 AND 30 THEN '20 - 30'
		WHEN DATEDIFF(yy, emp.BirthDate, getdate()) BETWEEN 30 AND 50 THEN '30 - 50'
		WHEN DATEDIFF(yy, emp.BirthDate, getdate()) > 50  THEN '50+'
	END AS AgeRange,
	emp.HiringDate,
	-- aciennet� en jours par rapport a la date d'embauche (HiringDate) --TODO?
	-- DATEDIFF(dd, emp.HiringDate, COALESCE(ext.LegalExitDate, getdate())) AS Seniority, 
	-- CASE WHEN DATEDIFF(dd, emp.HiringDate, COALESCE(ext.LegalExitDate, getdate())) < 180 THEN '0-6 months'
		--   WHEN DATEDIFF(dd, emp.HiringDate, COALESCE(ext.LegalExitDate, getdate())) < 360 THEN '6-12 months'
		--WHEN DATEDIFF(dd, emp.HiringDate, COALESCE(ext.LegalExitDate, getdate())) < 720 THEN '1-2 years'
		--WHEN DATEDIFF(dd, emp.HiringDate, COALESCE(ext.LegalExitDate, getdate())) < 1800 THEN '2-5 years'
		--WHEN DATEDIFF(dd, emp.HiringDate, COALESCE(ext.LegalExitDate, getdate())) > 1800 THEN '5+ years'
	-- END AS SeniorityRange,
	--CASE WHEN salstr.SalaryStructureReference IN ('CDI') THEN
			--  CASE WHEN  DATEFROMPARTS(YEAR(getdate()), MONTH(emp.HiringDate), DAY(emp.HiringDate)) >= CAST(GETDATE() AS DATE)
			--	THEN  DATEFROMPARTS(YEAR(getdate()), MONTH(emp.HiringDate), DAY(emp.HiringDate))
			--	ELSE  DATEFROMPARTS(YEAR(getdate()) + 1, MONTH(emp.HiringDate), DAY(emp.HiringDate))
			--  END 
	--END AS NextHiringAnniversary,
	emp.IsForeign,
	emp.FamilyLeader,
	emp.ChildrenNumber,
	emp.IdBank,
	cntry.NameFr CountryNameFr,
	emp.IdOffice,
	office.OfficeName,
	grade.Designation AS Grade

	--SELECT COUNT(*)
	FROM [Payroll].[Employee] emp WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimOffice] office WITH(NOLOCK) ON office.IdOffice=emp.IdOffice
	LEFT JOIN [Reporting].[DimGrade] grade WITH(NOLOCK) ON grade.Id=emp.IdGrade
	LEFT JOIN [Reporting].[DimCountry] cntry WITH(NOLOCK) ON cntry.IdCountry=emp.IdCountry

)A
BEGIN TRY
--****************************************Final Query***************************************************************--
TRUNCATE TABLE [Reporting].[DimEmployee]

INSERT INTO [Reporting].[DimEmployee]
           ([IdEmployee]
           ,[Matricule]
           ,[FirstName]
           ,[LastName]
           ,[Gender]
           ,[BirthDate]
           ,[Age]
           ,[AgeRange]
           ,[HiringDate]
           ,[IsForeign]
           ,[FamilyLeader]
           ,[ChildrenNumber]
           ,[Bank]
           ,[CountryNameFr]
           ,[IdOffice]
           ,[OfficeName]
           ,[Grade])

SELECT * FROM #Temp WITH(NOLOCK)
SET @NbInserted = @@ROWCOUNT
END TRY


BEGIN CATCH 
SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'DimEmployee', @NbInserted, GETDATE(), @ErrorMessage

END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedDimFiscalYear]...';


GO
CREATE PROCEDURE [Reporting].[FeedDimFiscalYear]
	
AS
BEGIN

	DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

	BEGIN TRY
		--Truncate DimFiscalYear Dimension	
		TRUNCATE TABLE [Reporting].[DimFiscalYear]

		--Insert Into DimFiscalYear Dimension	
		INSERT INTO [Reporting].[DimFiscalYear]
				   (
					       [FiscalYearId]
						  ,[FiscalYearClosingState]
						  ,[FiscalYearConclusionDate]
						  ,[FiscalYearStartDate]
						  ,[FiscalYearEndDate]
						  ,[FiscalYearName]
						  ,[FiscalYearClosingDate]
				   )

		--Load Data In DimFiscalYear Dimension	
		SELECT 
		                   [FY_ID]
						  ,[FY_CLOSING_STATE]
						  ,[FY_CONCLUSION_DATE]
						  ,[FY_START_DATE]
						  ,[FY_END_DATE]
						  ,[FY_NAME]
						  ,[FY_CLOSING_DATE]
	   FROM [compta].[T_FISCAL_YEAR] WITH(NOLOCK)
	   WHERE [FY_IS_DELETED]=0

	   SET @NbInserted = @@ROWCOUNT
	
	END TRY


	BEGIN CATCH 
		SET @ErrorMessage = ERROR_MESSAGE()
	END CATCH 

	----LOG
	INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
	SELECT 'DimFiscalYear', @NbInserted, GETDATE(), @ErrorMessage

	
		
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedDimItem]...';


GO
CREATE PROCEDURE [Reporting].[FeedDimItem]
	
AS
BEGIN

DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

BEGIN TRY
--Truncate Item Dimension
TRUNCATE TABLE [Reporting].[DimItem]

--Insert Into Item Dimension
INSERT INTO [Reporting].[DimItem]
           ([IdItem]
		   ,[IdUnitStock]
		   ,[IdUnitSales]
           ,[ItemCode]
           ,[ItemDescription]
           ,[IdItemFamily]
           ,[LabelItemFamily]
		   ,[IdSubFamily]
		   ,[LabelSubFamily]
           ,[IdItemNature]
           ,[LabelItemNature])

--Load Data In Item Dimension
SELECT 
	
	item.[Id] AS IdItem,
	ISNULL(item.IdUnitStock,-1) AS IdUnitStock,
	ISNULL(item.IdUnitSales,-1) AS IdUnitSales,
	item.Code AS ItemCode,
	item.Description AS ItemDescription,
	ISNULL(family.Id,-1) AS IdItemFamily,
	ISNULL(family.Label,'N/A') AS LabelItemFamily,
	ISNULL(subF.Id,-1) AS IdSubFamily,
	ISNULL(subF.Label,'N/A') AS LabelSubFamily,
	ISNULL(nature.Id,-1) AS IdItemNature,
	ISNULL(nature.Label,'N/A') AS LabelItemNature

	
FROM [Inventory].[Item] item WITH(NOLOCK)
LEFT JOIN [Inventory].[Nature] nature  WITH(NOLOCK) ON item.IdNature=nature.Id
LEFT JOIN [Inventory].[Family] family WITH(NOLOCK)  ON family.Id=item.IdFamily
LEFT JOIN [Inventory].[SubFamily] subF WITH(NOLOCK) ON subF.Id=item.IdSubFamily
SET @NbInserted = @@ROWCOUNT

END TRY


BEGIN CATCH 
SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'DimItem', @NbInserted, GETDATE(), @ErrorMessage

		
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedDimJournal]...';


GO
CREATE PROCEDURE [Reporting].[FeedDimJournal]
	
AS
BEGIN

	DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

	BEGIN TRY
		--Truncate Journal Dimension	
		TRUNCATE TABLE [Reporting].[DimJournal]

		--Insert Into Journal Dimension	
		INSERT INTO [Reporting].[DimJournal]
				   (
				  	   [journalID]
					  ,[JournalCode]
					  ,[JournalCreatedDate]
					  ,[JournalIsMovable]
					  ,[JournalIsReconcilable]
					  ,[JournalLabel]
				   
				   )

		--Load Data In Journal Dimension	
SELECT                 
                           [JN_ID] AS journalID
                          ,[JN_CODE]
                          ,[JN_CREATED_DATE]
                          ,[JN_IS_MOVABLE]
                          ,[JN_IS_RECONCILABLE]
                          ,[JN_LABEL]
  FROM [compta].[T_JOURNAL] WITH(NOLOCK)
  WHERE [JN_IS_DELETED]=0


		SET @NbInserted = @@ROWCOUNT
	
	END TRY


	BEGIN CATCH 
		SET @ErrorMessage = ERROR_MESSAGE()
	END CATCH 

	----LOG
	INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
	SELECT 'DimJournal', @NbInserted, GETDATE(), @ErrorMessage

		
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedDimPayment]...';


GO
CREATE PROCEDURE [Reporting].[FeedDimPayment]
	
AS
BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

BEGIN TRY
		--Truncate Payment Dimension	
		TRUNCATE TABLE [Reporting].[DimPayment]

		--Insert Into Payment Dimension	
		INSERT INTO [Reporting].[DimPayment]
				   ([IdPaymentType]
				   ,[IdPaymentMethod]
				   ,[PaymentTypeLabel]
				   ,[PaymentTypeCode]
				   ,[PaymentMethodCode]
				   ,[PaymentMethodName])

		--Load Data In Payment Dimension	
		SELECT 
			payt.Id AS IdPaymentType,
			paym.Id AS IdPaymentMethod,
			payt.Label AS PaymentTypeLabel,
			payt.Code AS PaymentTypeCode,
			paym.Code AS PaymentMethodCode,
			paym.MethodName AS PaymentMethodName

	
		FROM [Payment].[PaymentMethod] paym WITH(NOLOCK)
		LEFT JOIN [Payment].[PaymentType] payt  WITH(NOLOCK) ON paym.[IdPaymentType]=payt.Id
		
		SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
		SET @ErrorMessage = ERROR_MESSAGE()
END CATCH
	
	----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'DimPayment', @NbInserted, GETDATE(), @ErrorMessage
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedDimTiers]...';


GO
CREATE PROCEDURE [Reporting].[FeedDimTiers]
	
AS
BEGIN

DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

BEGIN TRY
--Truncate Tiers Dimension	
TRUNCATE TABLE [Reporting].[DimTiers]

--Insert Into Tiers Dimension	
INSERT INTO [Reporting].[DimTiers]
           ([IdTiers]
           ,[TiersName]
           ,[TiersCode]
           ,[IdTypeTiers]
           ,[TypeTiersLabel]
		   ,[TiersAdress]
		   ,[IdCountryTiers]
		   ,[CountryEn]
		   ,[CountryFr]
		   ,[IdAccount]
		   ,[CreationDate])

--Load Data In Tiers Dimension	
SELECT 
	tiers.[Id] AS IdTiers,
	tiers.[Name] AS TiersName,
	tiers.CodeTiers AS TiersCode,
	tiers.IdTypeTiers,
	TypeT.Label AS TypeTiers,
	tiers.Adress AS TiersAdress,
	tiers.IdCountry AS IdCountryTiers,
	ISNULL(country.NameEn,'N/A') AS CountryEn,
	ISNULL(country.NameFr,'N/A') AS CountryFr,
	account.AccountId AS IdAccount,
	tiers.CreationDate



FROM [Sales].[Tiers] tiers WITH(NOLOCK)
LEFT JOIN [Sales].[TypeTiers] TypeT WITH(NOLOCK) ON tiers.IdTypeTiers=TypeT.Id
LEFT JOIN [Reporting].[DimCountry] country  WITH(NOLOCK) ON tiers.IdCountry=country.IdCountry
LEFT JOIN [Reporting].[DimAccount] account WITH(NOLOCK) ON tiers.IdAccountingAccountTiers=account.AccountId
SET @NbInserted = @@ROWCOUNT
END TRY


BEGIN CATCH 
SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'DimTiers', @NbInserted, GETDATE(), @ErrorMessage

	
		
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedDimWarehouse]...';


GO
CREATE PROCEDURE [Reporting].[FeedDimWarehouse]
	
AS
BEGIN

DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

BEGIN TRY
--Truncate Warehouse Dimension	
TRUNCATE TABLE [Reporting].[DimWarehouse]

--Insert Into Warehouse Dimension	
INSERT INTO [Reporting].[DimWarehouse]
           ([IdWarehouse]
           ,[WarehouseCode]
           ,[WarehouseName]
           ,[WarehouseAdress])

--Load Data In Warehouse Dimension	
SELECT 
	[Id] AS IdWarehouse,
	[WarehouseCode],
	[WarehouseName],
	[WarehouseAdresse]
	
FROM [Inventory].[Warehouse] WITH(NOLOCK)
SET @NbInserted = @@ROWCOUNT
END TRY


BEGIN CATCH 
SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'DimWarehouse', @NbInserted, GETDATE(), @ErrorMessage

		
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedFctClaims]...';


GO
CREATE PROCEDURE [Reporting].[FeedFctClaims]

AS

BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

BEGIN TRY
	--Truncate Fact Claims
	TRUNCATE TABLE [Reporting].[FctClaims]

	--Insert Into Fact Claims
	INSERT INTO [Reporting].[FctClaims]
           ([IdClaim]
           ,[ClaimCode]
           ,[ClaimDescription]
           ,[IdDocument]
           ,[IdDocumentLine]
           ,[DocumentDate]
           ,[ClaimQty]
           ,[IdMouvementIn]
           ,[IdMovementOut]
           ,[IdWarehouse]
           ,[IdSupplier]
           ,[IdClient]
           ,[IdClaimStatus]
           ,[LabelClaimStatus]
           ,[TranslationClaimStatus]
           ,[DescriptionClaimType]
           ,[TranslationClaimType]
           ,[IdItem])
		


--Load Data In Fact Claims

SELECT

--Claim
c.Id AS IdClaim,
c.Code AS ClaimCode,
c.Description AS ClaimDescription,
c.IdDocument,
c.IdDocumentLine,
c.DocumentDate,
c.ClaimQty,
c.IdMovementIn,
c.IdMovementOut,

--Warehouse
c.IdWarehouse,

--Tiers
c.IdFournisseur AS IdSupplier,
c.IdClient,


--ClaimStatus
c.IdClaimStatus,
cs.Label AS LabelClaimStatus,
cs.TranslationCode AS TranslationClaimStatus,

--ClaimType
ct.Description AS DescriptionClaimType,
ct.TranslationCode AS TranslationClaimType,

--Item
c.IdItem


--SELECT COUNT(*)                      
FROM [Helpdesk].[Claim] c

LEFT JOIN [Helpdesk].[ClaimStatus] cs ON cs.Id=c.IdClaimStatus

LEFT JOIN [Helpdesk].[ClaimType] ct ON c.ClaimType=ct.CodeType

	
SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'FctClaims', @NbInserted, GETDATE(), @ErrorMessage
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedFctDocumentAccountLine]...';


GO
CREATE PROCEDURE [Reporting].[FeedFctDocumentAccountLine]
	
AS
BEGIN

	DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

	BEGIN TRY
		--Truncate FctDocumentAccountLine Fact	
		TRUNCATE TABLE [Reporting].[FctDocumentAccountLine]

		--Insert Into FctDocumentAccountLine Fact	
		INSERT INTO [Reporting].[FctDocumentAccountLine]
				   (
					   [DocumentAccountId]
					  ,[DocumentAccountCode]
					  ,[DocumentAccountCreationDate]
					  ,[DocumentAccountDate]
					  ,[DocumentAccountLabel]
					  ,[DocumentAccountStatus]
					  ,[FiscalYearId]
					  ,[JournalId]
					  ,[DocumentAccountLineId]
					  ,[DocumentAccountLineCreditAmount]
					  ,[DocumentAccountLineDebitAmount]
					  ,[DocumentAccountLineDate]
					  ,[DocumentAccountLineIsClose]
					  ,[DocumentAccountLineLabel]
					  ,[DocumentAccountLineLetter]
					  ,[DocumentAccountLineReconciliationDate]
					  ,[DocumentAccountLineReference]
					  ,[AccountIdAssociated]
				   )

		--Load Data In FctDocumentAccountLine Fact	
		SELECT
					   DOCUMENT_ACCOUNT.[DA_ID]
					  ,DOCUMENT_ACCOUNT.[DA_CODE_DOCUMENT]
					  ,DOCUMENT_ACCOUNT.[DA_CREATION_DOCUMENT_DATE]
					  ,DOCUMENT_ACCOUNT.[DA_DOCUMENT_DATE]
					  ,DOCUMENT_ACCOUNT.[DA_LABEL]
					  ,documentaccountStatus.LabelFr AS Status
					  ,DOCUMENT_ACCOUNT.[DA_FISCAL_YEAR_ID]
					  ,DOCUMENT_ACCOUNT.[DA_JOURNAL_ID]

					  ,DOCUMENT_ACCOUNT_LINE.[DAL_ID]
					  ,DOCUMENT_ACCOUNT_LINE.[DAL_CREDIT_AMOUNT]
					  ,DOCUMENT_ACCOUNT_LINE.[DAL_DEBIT_AMOUNT]
					  ,DOCUMENT_ACCOUNT_LINE.[DAL_DOCUMENT_LINE_DATE]
					  ,DOCUMENT_ACCOUNT_LINE.[DAL_IS_CLOSE]
					  ,DOCUMENT_ACCOUNT_LINE.[DAL_LABEL]
					  ,DOCUMENT_ACCOUNT_LINE.[DAL_LETTER]
					  ,DOCUMENT_ACCOUNT_LINE.[DAL_RECONCILIATION_DATE]
					  ,DOCUMENT_ACCOUNT_LINE.[DAL_REFERENCE]
					  ,DOCUMENT_ACCOUNT_LINE.[DAL_ACCOUNT_ID]

		FROM [compta].[T_DOCUMENT_ACCOUNT_LINE] AS DOCUMENT_ACCOUNT_LINE WITH(NOLOCK)
		LEFT JOIN [compta].[T_DOCUMENT_ACCOUNT] AS DOCUMENT_ACCOUNT WITH(NOLOCK)
		ON DOCUMENT_ACCOUNT_LINE.[DAL_DOCUMENT_ACCOUNT_ID]= DOCUMENT_ACCOUNT.DA_ID  
		--LEFT JOIN [Reporting].[DimAccount] AS DimAccount WITH(NOLOCK)
		--ON DOCUMENT_ACCOUNT_LINE.DAL_ACCOUNT_ID=DimAccount.[AccountId]
		--LEFT JOIN [Reporting].[DimChartAccounts] AS DimChartAccounts WITH(NOLOCK)
		--ON DimAccount.AccountId=DimChartAccounts.ChartAccountId
		--LEFT JOIN [Reporting].[DimJournal] AS DimJournal WITH(NOLOCK)
		--ON DOCUMENT_ACCOUNT.[DA_JOURNAL_ID]=DimJournal.[journalID]
		--LEFT JOIN [Reporting].[DimFiscalYear] AS DimFiscalYear WITH(NOLOCK)
		--ON DOCUMENT_ACCOUNT.[DA_FISCAL_YEAR_ID]=DimFiscalYear.[FiscalYearId]
		LEFT JOIN [Reporting].[ParameterReference] documentaccountStatus WITH(NOLOCK)
	    ON DOCUMENT_ACCOUNT.[DA_STATUS] = documentaccountStatus.Code AND documentaccountStatus.Reference = 'documentaccount status' 
		WHERE  DOCUMENT_ACCOUNT.DA_IS_DELETED=0 AND DOCUMENT_ACCOUNT_LINE.DAL_IS_DELETED =0

	      SET @NbInserted = @@ROWCOUNT
	
	END TRY


	BEGIN CATCH 
		SET @ErrorMessage = ERROR_MESSAGE()
	END CATCH 

	----LOG
	INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
	SELECT 'FctDocumentAccountLine', @NbInserted, GETDATE(), @ErrorMessage

	
		
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedFctPurchases]...';


GO
CREATE PROCEDURE [Reporting].[FeedFctPurchases]

AS

BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
BEGIN TRY

	--Truncate Fact Purchases
	TRUNCATE TABLE  [Reporting].[FctPurchases]

	--Insert Into Fact Purchases
	INSERT INTO [Reporting].[FctPurchases]
			   ([IdDocument]
			   ,[DocumentCode]
			   ,[DocumentTypeCode]
			   ,[DocumentTypeLabel]
			   ,[DocumentDate]
			   ,[DocumentMonth]
			   ,[DocumentYear]
			   ,[DocumentTTCPrice]
			   ,[DocumentRemainingAmount]
			   ,[DocumentHTPrice]
			   ,[DocumentHTPriceWithCurrency]
			   ,[DocumentTTCPriceWithCurrency]
			   ,[IdCurrency]
			   ,[IdStatus]
			   ,[DocumentStatus]
			   ,[IdTiers]
			   ,[IdItem]
			   ,[IdDocumentLine]
			   ,[DocumentLineDesignation]
			   ,[TtcTotalLine]
			   ,[HtTotalLine]
			   ,[AmountPerItem]
			   ,[ItemQuantity]
			   ,[IdWarehouse]
			   ,[AvailableQuantityPerItem]
			   ,[IdPaymentMethod]
			   ,[IdDocumentAssociated]
			   ,[CodeDocumentAssociated]
			   ,[DocumentTypeCodeAssociated]
			   ,[DocumentDateAssociated]
			   ,[IdDocumentLineAssociated]
			   ,[DocumentAssTypeLabel])
		


	--Load Data In Fact Purchases

	SELECT 

	--Document
	doc.Id AS IdDocument, --IdOrder
	doc.Code AS DocumentCode,--OrderCode
	doc.DocumentTypeCode,
	docT.Label AS DocumentTypeLabel,
	doc.DocumentDate,
	MONTH(doc.DocumentDate) AS DocumentMonth,
	YEAR(doc.DocumentDate) AS DocumentYear,
	ROUND(doc.DocumentTTCPrice,3) AS DocumentTTCPrice,
	ROUND(doc.DocumentRemainingAmount,3) AS DocumentRemainingAmount,
	ROUND(doc.DocumentHTPrice,3) AS  DocumentHTPrice,
	ROUND(doc.DocumentHTPriceWithCurrency,3) AS DocumentHTPriceWithCurrency,
	ROUND(doc.DocumentTTCPriceWithCurrency,3) AS DocumentTTCPriceWithCurrency,

	--DimCurrency
	currency.IdCurrency,

	--DocumentStatus
	docStat.Id AS IdStatus,
	docStat.Code AS DocumentStatus,

	--DimTiers
	tiers.IdTiers,

	--DimItem
	item.IdItem,


	--DocumentLine
	docL.Id AS IdDocumentLine,
	docL.Designation AS DocumentLineDesignation,--filtre
	ROUND(docL.TtcTotalLine,3) AS TtcTotalLine,
	ROUND(docL.HtTotalLine,3) AS HtTotalLine,
	docL.MovementQty*docL.SellingPrice AS AmountPerItem,
	docL.MovementQty AS ItemQuantity,

	--DimWarehouse
	warehouse.IdWarehouse ,
	ISNULL(itemWarehouse.AvailableQuantity,0) AS AvailableQuantityPerItem,

	--DimPayment
	pay.IdPaymentMethod,


	--DocumentAssociated
	associated.id AS IdDocumentAssociated,
	associated.code AS CodeDocumentAssociated,
	associated.DocumentTypeCode AS DocumentTypeCodeAssociated,
	associated.DocumentDate AS DocumentDateAssociated,


	--DocumentLineAssociated
	docL.IdDocumentLineAssociated,

	--DocumentTypeAssociated
	typeDocAss.Label AS DocumentAssTypeLabel

 
	--SELECT COUNT(*)
	FROM [Sales].[DocumentLine] docL WITH(NOLOCK)
	LEFT JOIN [Sales].[Document] doc WITH(NOLOCK) ON doc.Id=docL.IdDocument
	LEFT JOIN [Sales].[Document] associated WITH(NOLOCK) ON doc.IdDocumentAssociated = associated.Id
	LEFT JOIN [Sales].[DocumentType] docT  WITH(NOLOCK) ON doc.DocumentTypeCode = docT.code
	LEFT JOIN [Sales].[DocumentType] typeDocAss  WITH(NOLOCK) ON associated.DocumentTypeCode = typeDocAss.code
	LEFT JOIN [Sales].[DocumentStatus] docStat WITH(NOLOCK) ON doc.IdDocumentStatus=docStat.Id
	LEFT JOIN [Reporting].[DimTiers] tiers WITH(NOLOCK) ON doc.IdTiers=tiers.IdTiers
	LEFT JOIN [Reporting].[DimItem] item  WITH(NOLOCK) ON  item.IdItem=docL.IdItem
	LEFT JOIN [Inventory].[ItemWarehouse] itemWarehouse WITH(NOLOCK) ON docL.IdWarehouse=itemWarehouse.Id
	LEFT JOIN [Reporting].[DimWarehouse] warehouse WITH(NOLOCK) ON itemWarehouse.IdWarehouse = warehouse.IdWarehouse
	LEFT JOIN [Reporting].[DimCurrency] currency WITH(NOLOCK) ON currency.IdCurrency=doc.IdUsedCurrency
	LEFT JOIN [Reporting].[DimPayment] pay  WITH(NOLOCK) ON pay.IdPaymentMethod=doc.IdPaymentMethod

	WHERE docL.IsDeleted <> 1 AND doc.DocumentTypeCode LIKE '%PU'
	SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'FctPurchases', @NbInserted, GETDATE(), @ErrorMessage
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedFctReportLine]...';


GO
CREATE PROCEDURE [Reporting].[FeedFctReportLine]
	
AS
BEGIN

	DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

	BEGIN TRY
		--Truncate FctReportLine Fact	
		TRUNCATE TABLE [Reporting].[FctReportLine]

		--Insert Into FctReportLine Fact	
		INSERT INTO [Reporting].[FctReportLine]
				   (
					   [ReportLineId]
					  ,[ReportLineAmount]
					  ,[ReportLineAnnexCode]
					  ,[ReportLineFormula]
					  ,[ReportLineIsManuallyChanged]
					  ,[ReportLineIsNegatif]
					  ,[ReportLineLabel]
					  ,[ReportLineLastUpdated]
					  ,[ReportLineIndex]
					  ,[ReportType]
					  ,[ReportLineUser]
					  ,[FiscalYearId]
					  ,[ReportLineIsTotal]
				   )

		--Load Data In FctReportLine Fact	
SELECT 
					  REPORT_LINE.[RL_ID]
					  ,REPORT_LINE.[RL_AMOUNT]
	                  ,REPORT_LINE.[RL_ANNEX_CODE]
					  ,REPORT_LINE.[RL_FORMULA]
					  ,REPORT_LINE.[RL_IS_MANUALLY_CHANGED]
					  ,REPORT_LINE.[RL_IS_NEGATIVE]
					  ,REPORT_LINE.[RL_LABEL]
					  ,REPORT_LINE.[RL_LAST_UPDATED]
					  ,REPORT_LINE.[RL_LINE_INDEX]
					  ,reportlinestatus.LabelFr AS ReportType
					  ,REPORT_LINE.[RL_USER]
					  ,REPORT_LINE.[RL_FISCAL_YEAR_ID]
					  ,REPORT_LINE.[RL_IS_TOTAL]
  FROM [compta].[T_REPORT_LINE] AS REPORT_LINE WITH(NOLOCK)
  LEFT JOIN [Reporting].[DimFiscalYear] AS FiscalYear WITH(NOLOCK)
  ON REPORT_LINE.RL_FISCAL_YEAR_ID=FiscalYear.[FiscalYearId]
  LEFT JOIN [Reporting].[ParameterReference] reportlinestatus WITH(NOLOCK)
  ON REPORT_LINE.[RL_REPORT_TYPE] = reportlinestatus.Code AND reportlinestatus.Reference = 'reportline status' 
  WHERE [RL_IS_DELETED]=0


	      SET @NbInserted = @@ROWCOUNT
	
	END TRY


	BEGIN CATCH 
		SET @ErrorMessage = ERROR_MESSAGE()
	END CATCH 

	----LOG
	INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
	SELECT 'FctReportLine', @NbInserted, GETDATE(), @ErrorMessage

	
		
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedFctSales]...';


GO
CREATE PROCEDURE [Reporting].[FeedFctSales]

AS

BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

BEGIN TRY
	--Truncate Fact Sales
	TRUNCATE TABLE  [Reporting].[FctSales]

	--Insert Into Fact Sales
	INSERT INTO [Reporting].[FctSales]
			   ([IdDocument]
			   ,[DocumentCode]
			   ,[DocumentTypeCode]
			   ,[DocumentTypeLabel]
			   ,[DocumentDate]
			   ,[DocumentMonth]
			   ,[DocumentYear]
			   ,[DocumentTTCPrice]
			   ,[DocumentRemainingAmount]
			   ,[DocumentHTPrice]
			   ,[DocumentHTPriceWithCurrency]
			   ,[DocumentTTCPriceWithCurrency]
			   ,[IdCurrency]
			   ,[IdStatus]
			   ,[DocumentStatus]
			   ,[IdTiers]
			   ,[IdItem]
			   ,[IdDocumentLine]
			   ,[DocumentLineDesignation]
			   ,[TtcTotalLine]
			   ,[HtTotalLine]
			   ,[AmountPerItem]
			   ,[ItemQuantity]
			   ,[IdWarehouse]
			   ,[AvailableQuantityPerItem]
			   ,[IdPaymentMethod]
			   ,[IdDocumentAssociated]
			   ,[CodeDocumentAssociated]
			   ,[DocumentTypeCodeAssociated]
			   ,[DocumentDateAssociated]
			   ,[IdDocumentLineAssociated]
			   ,[DocumentAssTypeLabel])
		


	--Load Data In Fact Sales

	SELECT 

	--Document
	doc.Id AS IdDocument, --IdOrder
	doc.Code AS DocumentCode,--OrderCode
	doc.DocumentTypeCode,
	docT.Label AS DocumentTypeLabel,
	doc.DocumentDate,
	MONTH(doc.DocumentDate) AS DocumentMonth,
	YEAR(doc.DocumentDate) AS DocumentYear,
	ROUND(doc.DocumentTTCPrice,3) AS DocumentTTCPrice,
	ROUND(doc.DocumentRemainingAmount,3) AS DocumentRemainingAmount,
	ROUND(doc.DocumentHTPrice,3) AS  DocumentHTPrice,
	ROUND(doc.DocumentHTPriceWithCurrency,3) AS DocumentHTPriceWithCurrency,
	ROUND(doc.DocumentTTCPriceWithCurrency,3) AS DocumentTTCPriceWithCurrency,

	--DimCurrency
	currency.IdCurrency,

	--DocumentStatus
	docStat.Id AS IdStatus,
	docStat.Code AS DocumentStatus,

	--DimTiers
	tiers.IdTiers,

	--DimItem
	item.IdItem,


	--DocumentLine
	docL.Id AS IdDocumentLine,
	docL.Designation AS DocumentLineDesignation,--filtre
	ROUND(docL.TtcTotalLine,3) AS TtcTotalLine,
	ROUND(docL.HtTotalLine,3) AS HtTotalLine,
	docL.MovementQty*docL.SellingPrice AS AmountPerItem,
	docL.MovementQty AS ItemQuantity,

	--DimWarehouse
	warehouse.IdWarehouse ,
	ISNULL(itemWarehouse.AvailableQuantity,0) AS AvailableQuantityPerItem,

	--DimPayment
	pay.IdPaymentMethod,


	--DocumentAssociated
	associated.id AS IdDocumentAssociated,
	associated.code AS CodeDocumentAssociated,
	associated.DocumentTypeCode AS DocumentTypeCodeAssociated,
	associated.DocumentDate AS DocumentDateAssociated,


	--DocumentLineAssociated
	docL.IdDocumentLineAssociated,

	--DocumentTypeAssociated
	typeDocAss.Label AS DocumentAssTypeLabel

 
	--SELECT COUNT(*)
	FROM [Sales].[DocumentLine] docL WITH(NOLOCK)
	LEFT JOIN [Sales].[Document] doc WITH(NOLOCK) ON doc.Id=docL.IdDocument
	LEFT JOIN [Sales].[Document] associated WITH(NOLOCK) ON doc.IdDocumentAssociated = associated.Id
	LEFT JOIN [Sales].[DocumentType] docT WITH(NOLOCK) ON doc.DocumentTypeCode = docT.code
	LEFT JOIN [Sales].[DocumentType] typeDocAss WITH(NOLOCK) ON associated.DocumentTypeCode = typeDocAss.code
	LEFT JOIN [Sales].[DocumentStatus] docStat WITH(NOLOCK) ON doc.IdDocumentStatus=docStat.Id
	LEFT JOIN [Reporting].[DimTiers] tiers WITH(NOLOCK) ON doc.IdTiers=tiers.IdTiers
	LEFT JOIN [Reporting].[DimItem] item  WITH(NOLOCK) ON  item.IdItem=docL.IdItem
	LEFT JOIN [Inventory].[ItemWarehouse] itemWarehouse WITH(NOLOCK) ON docL.IdWarehouse=itemWarehouse.Id
	LEFT JOIN [Reporting].[DimWarehouse] warehouse WITH(NOLOCK) ON itemWarehouse.IdWarehouse = warehouse.IdWarehouse
	LEFT JOIN [Reporting].[DimCurrency] currency  WITH(NOLOCK) ON currency.IdCurrency=doc.IdUsedCurrency
	LEFT JOIN [Reporting].[DimPayment] pay WITH(NOLOCK) ON pay.IdPaymentMethod=doc.IdPaymentMethod
	WHERE docL.IsDeleted <> 1 AND doc.DocumentTypeCode LIKE '%SA'
	SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'FctSales', @NbInserted, GETDATE(), @ErrorMessage
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedFinancialCommitmentNonPaidAmounts]...';


GO

CREATE PROCEDURE [Reporting].[FeedFinancialCommitmentNonPaidAmounts] 

 
	@SelectYear int= 2020,
	@SelectMonth int=2

	AS
BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

BEGIN TRY
	  DROP TABLE #TempAmounts
  SELECT 
          Year,
          Month,
          --CommitmentStatusCode,
          NotPaidAmounts

		  INTO #TempAmounts

FROM (

SELECT 
                
                YEAR(CommitmentDate) AS Year,
                MONTH(CommitmentDate) AS Month,
                ISNULL(COUNT(*),0) AS NotPaidAmounts
                FROM [Reporting].[FctFinancialCommitment] financialCommitment WITH(NOLOCK)
         
               WHERE RemainingAmountWithCurrency IS NOT NULL OR RemainingAmountWithCurrency <> 0
               GROUP BY YEAR(CommitmentDate),MONTH(CommitmentDate)
)A 
--WHERE CommitmentStatusCode=3
GROUP BY Year,Month,
--CommitmentStatusCode,
NotPaidAmounts
ORDER BY Month ASC



TRUNCATE TABLE [Reporting].[KPIFinancialCommitmentNonPaidAmounts]
 INSERT INTO [Reporting].[KPIFinancialCommitmentNonPaidAmounts]
   (
 [Year]
,[Month]
,[NonPaidAmountsCurrentYear]
,[NonPaidAmountsLastMonth]
,[NonPaidAmountsLastMonthLastYear]
,[NonPaidAmountsLastYear]
,[NonPaidAmountsYearToDate]
,[NonPaidAmountsYearToDateLastYear]
   )

 SELECT AmountCurrentY.Year, 
        AmountCurrentY.Month,
		AmountCurrentY.NotPaidAmounts AS NotPaidAmountsCY,
		ISNULL(AmountLastM.NotPaidAmounts,0) AS NotPaidAmountsLM,
        ISNULL(AmountLastY.NotPaidAmounts,0) AS NotPaidAmountsLY,
		ISNULL(AmountLastMLastY.NotPaidAmounts,0) AS NotPaidAmountsLMLY,
		ISNULL(AmountYTD.NotPaidAmounts,0) AS NotPaidAmountsYTD,
		ISNULL((AmountLastYTD.NotPaidAmounts),0) AS NotPaidAmountsLastYTD

        
    FROM #TempAmounts AmountCurrentY
    LEFT JOIN #TempAmounts AmountLastM
    ON AmountCurrentY.Year = AmountLastM.Year and AmountCurrentY.Month =AmountLastM.Month +1
	LEFT JOIN #TempAmounts AmountLastY
    ON AmountCurrentY.Year = AmountLastY.Year +1 and AmountCurrentY.Month = AmountLastY.Month
	LEFT JOIN #TempAmounts AmountYTD
    ON AmountYTD.Year = AmountLastY.Year +1 and AmountYTD.Month = AmountCurrentY.Month
	LEFT JOIN #TempAmounts AmountLastYTD
    ON AmountLastYTD.Year = AmountLastY.Year and AmountYTD.Month = AmountLastY.Month
	LEFT JOIN #TempAmounts AmountLastMLastY
    ON AmountLastMLastY.Year = AmountCurrentY.Year-1
    AND   AmountLastMLastY.Month= MONTH(DateADD(MONTH,-13,DATEFROMPARTS(AmountLastY.Year, AmountCurrentY.Month, 1)))
 
GROUP BY AmountCurrentY.NotPaidAmounts,AmountLastM.NotPaidAmounts,AmountLastY.NotPaidAmounts, AmountLastMLastY.NotPaidAmounts,
AmountYTD.NotPaidAmounts, AmountLastYTD.NotPaidAmounts, AmountCurrentY.Year, AmountCurrentY.Month


	SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPIFinancialCommitmentNonPaidAmounts', @NbInserted, GETDATE(), @ErrorMessage


END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPIAmountsPerImmobilisation]...';


GO

 

CREATE PROCEDURE [Reporting].[FeedKPIAmountsPerImmobilisation]

AS
BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
--*************************Select Data For Immobilisations*************************--  
BEGIN TRY

SELECT *

INTO #temp

FROM

(
	SELECT 

	ISNULL(SUM(dal.[DocumentAccountLineDebitAmount]),0) AS ImmobilisationAmount,
	MONTH(dal.DocumentAccountDate) AS Month,
	YEAR(dal.DocumentAccountDate) AS Year,
	a.AccountLabel

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]

	WHERE a.AccountCode LIKE '2%'

	GROUP BY 
	MONTH(dal.DocumentAccountDate),
	YEAR(dal.DocumentAccountDate),
	a.AccountLabel

)A

--**AmountPerImmobilisation
SELECT 
	Year,
	Month,
	AccountLabel,
	ISNULL(SUM(DISTINCT CurrentAmount),0) AS CurrentImmobilisationAmount,
	ISNULL(SUM(DISTINCT LastMonthAmount),0)AS LastMonthImmobilisationAmount,
	ISNULL(SUM(DISTINCT LastYearAmount),0) AS LastYearImmobilisationAmount,
	ISNULL(SUM(DISTINCT LastMonthLastYearAmount),0) AS LastMonthLastYearImmobilisationAmount,
	ISNULL(SUM(DISTINCT YearToDateAmount),0) AS YearToDateImmobilisationAmount,
	ISNULL(SUM(DISTINCT LastYearYearToDateAmount),0) AS LastYearYearToDateImmobilisationAmount,
	SUM(DISTINCT VariationCurrentMonthLastMonthAmount) AS VariationCurrentMonthLastMonthImmobilisationAmount,
	SUM(DISTINCT VariationCurrentYearLastYearAmount) AS VariationCurrentYearLastYearImmobilisationAmount,
	SUM(DISTINCT VariationCurrentYearToDateLastYearToDateAmount) AS VariationCurrentYearToDateLastYearToDateImmobilisationAmount

	INTO #TempImmo

	FROM
	(
	
	
	SELECT  
	
	t2.Year,
    t2.Month,
	t2.AccountLabel,
    t2.ImmobilisationAmount AS CurrentAmount,
    lm2.ImmobilisationAmount AS LastMonthAmount,
    ly2.ImmobilisationAmount AS LastYearAmount,
	lmly2.ImmobilisationAmount AS LastMonthLastYearAmount,
	SUM(DISTINCT ytd2.ImmobilisationAmount) AS YearToDateAmount,
	SUM(DISTINCT lytd2.ImmobilisationAmount) AS LastYearYearToDateAmount,
	ISNULL(((t2.ImmobilisationAmount-lm2.ImmobilisationAmount)/NULLIF(lm2.ImmobilisationAmount,0))*100,0) AS VariationCurrentMonthLastMonthAmount,
	ISNULL(((t2.ImmobilisationAmount-ly2.ImmobilisationAmount)/NULLIF(ly2.ImmobilisationAmount,0))*100,0) AS VariationCurrentYearLastYearAmount,
	ISNULL(((ytd2.ImmobilisationAmount-lytd2.ImmobilisationAmount)/NULLIF(lytd2.ImmobilisationAmount,0))*100,0) AS VariationCurrentYearToDateLastYearToDateAmount
    
	FROM #Temp t2
    LEFT JOIN #Temp lm2 ON t2.Year = lm2.Year AND t2.Month =month(DATEADD(month,1,DATEFROMPARTS(lm2.year, lm2.month, 1)))
    LEFT JOIN #Temp ly2 ON t2.Year = ly2.Year +1 AND t2.Month = ly2.Month
	LEFT JOIN #Temp lmly2 ON t2.Year = lmly2.Year +1 AND lmly2.Month =month(DATEADD(month,-1,DATEFROMPARTS(t2.year, t2.month, 1)))
    LEFT JOIN #Temp ytd2 ON t2.Year = ytd2.Year AND ytd2.Month <= t2.Month
	LEFT JOIN #Temp lytd2 ON t2.Year = lytd2.Year+1  AND lytd2.Month <=ly2.Month
	
	GROUP BY 
	t2.Year,
    t2.Month, 
	t2.AccountLabel,
    t2.ImmobilisationAmount,
    lm2.ImmobilisationAmount,
    ly2.ImmobilisationAmount,
	lmly2.ImmobilisationAmount,
	ytd2.ImmobilisationAmount,
	lytd2.ImmobilisationAmount
)B

GROUP BY Year,Month,AccountLabel

	--***********************************FINAL QUERY*************************************************--
TRUNCATE TABLE [Reporting].[KPIAmountsPerImmobilisation]


INSERT INTO [Reporting].[KPIAmountsPerImmobilisation]
           ([Month]
           ,[Year]
           ,[AccountLabel]
           ,[CurrentImmobilisationAmount]
           ,[LastMonthImmobilisationAmount]
           ,[LastYearImmobilisationAmount]
           ,[LastMonthLastYearImmobilisationAmount]
           ,[YearToDateImmobilisationAmount]
           ,[LastYearYearToDateImmobilisationAmount]
           ,[VariationCurrentMonthLastMonthImmobilisationAmount]
           ,[VariationCurrentYearLastYearImmobilisationAmount]
           ,[VariationCurrentYearToDateLastYearToDateImmobilisationAmount])

SELECT * FROM #TempImmo 


	SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPIAmountsPerImmobilisation', @NbInserted, GETDATE(), @ErrorMessage



END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPIAverageRevenuePerCustomer]...';


GO

 

CREATE PROCEDURE [Reporting].[FeedKPIAverageRevenuePerCustomer]

AS
BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
--*************************Select Data For Average Revenue Per Customer*************************--  
BEGIN TRY

      SELECT

      SUM(Amount) AS CA,
      FiscalYear,
	  FiscalMonth,
      Count(CustomerValue) AS CustomerValue,
      AccountLabel,
      AccountCode


INTO #Tempdal

FROM

(

	SELECT 
    SUM([DocumentAccountLineCreditAmount]) AS Amount,	
	YEAR(dal.DocumentAccountDate) AS FiscalYear,
	MONTH(dal.DocumentAccountDate) AS FiscalMonth,
	COUNT(a.AccountCode) AS CustomerValue,
	a.AccountLabel,
	a.AccountCode

 	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
    WHERE dal.AccountIdAssociated IN
    (SELECT a.AccountId 
    from  [Reporting].[DimAccount] a WITH(NOLOCK)
    where AccountCode like  '70%' ) AND dal.FiscalYearId=1
	
	GROUP BY 
	YEAR(dal.DocumentAccountDate),
	MONTH(dal.DocumentAccountDate),
    a.AccountLabel,
    a.AccountCode

	UNION ALL

	SELECT
    -SUM([DocumentAccountLineCreditAmount]) AS Amount,
	YEAR(dal.DocumentAccountDate) AS FiscalYear,
	MONTH(dal.DocumentAccountDate) AS FiscalMonth,
    Count(a.AccountCode) AS CustomerValue,
	a.AccountLabel,
	a.AccountCode
	

 	 FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	 LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
     WHERE dal.AccountIdAssociated IN
     (SELECT a.AccountId 
     from  [Reporting].[DimAccount] a WITH(NOLOCK)
     where AccountCode like '709%' ) AND  dal.FiscalYearId=1


	 GROUP BY
     YEAR(dal.DocumentAccountDate),
	 MONTH(dal.DocumentAccountDate),
     a.AccountLabel,
	 a.AccountCode

	 UNION ALL 

	 SELECT 

     --Compte Clients--
     SUM([DocumentAccountLineCreditAmount]) AS Amount,
     YEAR(dal.DocumentAccountDate) AS FiscalYear,
	 MONTH(dal.DocumentAccountDate) AS FiscalMonth,
     COUNT(DISTINCT(a.AccountCode)) AS CustomerValue,
	 a.AccountLabel,
	 AccountCode

    FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
    LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
    WHERE a.AccountCode LIKE '411%'

 

    GROUP BY 
    YEAR(dal.DocumentAccountDate),
	MONTH(dal.DocumentAccountDate),
	a.AccountLabel,
	a.AccountCode



)A

GROUP BY FiscalYear,
FiscalMonth,
 a.AccountLabel,
 a.AccountCode


--Select * from #Tempdal
--DROP TABLE #Tempdal
--SELECT * FROM #Tempdal

--DROP TABLE #Tempdal


	--***********************************FINAL QUERY*************************************************--
	TRUNCATE TABLE [Reporting].[KPIAverageRevenuePerCustomer]
	
	INSERT INTO [Reporting].[KPIAverageRevenuePerCustomer]
				([CA]
                ,[FiscalYear]
				,[Month]
                ,[CustomerNumber]
                ,[AccountLabel]
                ,[AccountCode])

	SELECT * FROM #Tempdal WITH(NOLOCK)


	SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPIAverageRevenuePerCustomer', @NbInserted, GETDATE(), @ErrorMessage



END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPIClaimsPerProduct]...';


GO

 

CREATE PROCEDURE [Reporting].[FeedKPIClaimsPerProduct]

AS
BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
--*************************Select Data For Claims Per Product*************************--  
BEGIN TRY

SELECT *

INTO #temp

FROM

(
	SELECT
	c.[IdClaim],
	c.[ClaimCode],
	c.[ClaimDescription],
	c.[DocumentDate],
	c.[ClaimQty],
	c.[IdClaimStatus],
	c.[LabelClaimStatus],
	c.[IdItem],
	item.ItemCode,
	item.ItemDescription,
	item.LabelItemFamily,
	item.LabelItemNature,
	item.LabelSubFamily


	FROM [Reporting].[FctClaims] c
	LEFT JOIN [Reporting].[DimItem] item ON item.IdItem=c.IdItem


)A



	--***********************************FINAL QUERY*************************************************--
	TRUNCATE TABLE [Reporting].[KPIClaimsPerProduct]
	
	INSERT INTO [Reporting].[KPIClaimsPerProduct]
           ([IdClaim]
           ,[ClaimCode]
           ,[ClaimDescription]
           ,[DocumentDate]
           ,[ClaimQty]
           ,[IdClaimStatus]
           ,[LabelClaimStatus]
           ,[IdItem]
           ,[ItemCode]
           ,[ItemDescription]
           ,[LabelItemFamily]
           ,[LabelItemNature]
           ,[LabelSubFamily])

	SELECT * FROM #temp


	SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPIClaimsPerProduct', @NbInserted, GETDATE(), @ErrorMessage



END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPIConversionRate]...';


GO

CREATE PROCEDURE [Reporting].[FeedKPIConversionRate]


AS
BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
BEGIN TRY

	--*************************Select Data For Conversion Rate (Sales/Purchases)*************************--
	SELECT  

			DocumentIdAssociated AS DocumentId,
			DocumentTypeLabelAssociated AS DocumentType,
			MONTH(DocumentDateAssociated) AS Month,
			YEAR(DocumentDateAssociated) AS Year,
			--IdItem,
			--ItemDescription,
			--ItemNature,
			--ItemFamily,
			TiersName,
			[Type],
			SUM(QtyDelivered) AS QtyDelivered,
			SUM(QtyOrdered) AS QtyOrdered,
			(SUM(QtyDelivered)*1.0/NULLIF(SUM(QtyOrdered)*1.0, 0)) *100 AS ConversionRate1, --moyenne
			ISNULL(SUM(QtyDelivered/QtyOrdered)*1.0/SUM(QtyOrdered)*1.0,0)*100 AS ConversionRate2 -- somme des moyennes

			INTO #temp
			FROM
			(
	----***************************Sales********************************************--
		SELECT 
			--dlc.DocumentId,
	  --      dlc.DocumentLineId,
	  --      dlc.DocumentTypeCode,
	  --      dlc.DocumentTypeLabel,
			--dlc.DocumentDate,
			dlc.IdDocumentlineAssociated,
			dlass.IdDocument AS DocumentIdAssociated,
			dlass.DocumentTypeCode AS DocumentTypeCodeAssociated,
			dlass.DocumentTypeLabel AS DocumentTypeLabelAssociated,
			dlass.DocumentDate AS DocumentDateAssociated,
			--dlc.IdItem,
			--dlc.ItemDescription,
			--dlc.ItemNature,
			--dlc.ItemFamily,
			SUM(dlc.ItemQuantity) AS QtyDelivered,
			tier.TiersName,
			dlass.ItemQuantity AS QtyOrdered,
			--ISNULL(SUM(dlc.MovementQty)/dlass.MovementQty,0)*100 AS ConversionRate,
			'SA' AS [Type]
		FROM [Reporting].[FctSales] dlc WITH(NOLOCK)
		LEFT JOIN [Reporting].[FctSales] dlass  WITH(NOLOCK) ON dlc.IdDocumentLineAssociated = dlass.IdDocumentLine
		LEFT JOIN [Reporting].[DimTiers] tier  WITH(NOLOCK) ON tier.IdTiers=dlc.IdTiers
		WHERE dlc.IdDocumentlineAssociated IS NOT NULL AND dlc.DocumentTypeCode IN ('D-SA','BS-SA') 
		GROUP BY    
		--dlc.IdItem,
		--			dlc.ItemDescription,
		--			dlc.ItemNature,
		--			dlc.ItemFamily,
					tier.TiersName,
					dlc.IdDocumentlineAssociated,
					dlass.IdDocument ,
					dlass.DocumentTypeCode ,
					dlass.DocumentTypeLabel ,
					dlass.DocumentDate ,
					dlass.ItemQuantity 

		UNION ALL

		---******************************Purchases**************************************--
	SELECT 
			--dlc.DocumentId,
	  --      dlc.DocumentLineId,
	  --      dlc.DocumentTypeCode,
	  --      dlc.DocumentTypeLabel,
			--dlc.DocumentDate,
			dlc.IdDocumentlineAssociated,
			dlass.IdDocument AS DocumentIdAssociated,
			dlass.DocumentTypeCode AS DocumentTypeCodeAssociated,
			dlass.DocumentTypeLabel AS DocumentTypeLabelAssociated,
			dlass.DocumentDate AS DocumentDateAssociated,
			--dlc.IdItem,
			--dlc.ItemDescription,
			--dlc.ItemNature,
			--dlc.ItemFamily,
			SUM(dlc.ItemQuantity) AS QtyDelivered,
			tier.TiersName,
			dlass.ItemQuantity AS QtyOrdered,
			--ISNULL(SUM(dlc.MovementQty)/dlass.MovementQty,0)*100 AS ConversionRate,
			'PU' AS [Type]
		FROM [Reporting].[FctPurchases] dlc WITH(NOLOCK)
		LEFT JOIN [Reporting].[FctPurchases] dlass WITH(NOLOCK) ON dlc.IdDocumentLineAssociated = dlass.IdDocumentLine
		LEFT JOIN [Reporting].[DimTiers] tier WITH(NOLOCK) ON tier.IdTiers=dlc.IdTiers
		WHERE dlc.IdDocumentlineAssociated IS NOT NULL AND dlc.DocumentTypeCode IN ( 'FO-PU' ) 
		GROUP BY    
		--dlc.IdItem,
		--			dlc.ItemDescription,
		--			dlc.ItemNature,
		--			dlc.ItemFamily,
					tier.TiersName,
					dlc.IdDocumentlineAssociated,
					dlass.IdDocument ,
					dlass.DocumentTypeCode ,
					dlass.DocumentTypeLabel ,
					dlass.DocumentDate ,
					dlass.ItemQuantity 
	
	

	)A	
	GROUP BY 
			DocumentIdAssociated,
			DocumentTypeLabelAssociated,
			MONTH(DocumentDateAssociated),
			YEAR(DocumentDateAssociated),
			TiersName,
			[Type]
		


	--***********************************FINAL QUERY*************************************************--
	TRUNCATE TABLE [Reporting].[KPIConversionRate]

	INSERT INTO [Reporting].[KPIConversionRate]
			   ([DocumentId]
			   ,[DocumentType]
			   ,[Month]
			   ,[Year]
			   ,[TiersName]
			   ,[Type]
			   ,[QtyDelivered]
			   ,[QtyOrdered]
			   ,[ConversionRate1]
			   ,[ConversionRate2])

	SELECT * FROM #temp WITH(NOLOCK)
	SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPIConversionRate', @NbInserted, GETDATE(), @ErrorMessage
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPIConversionRateDetails]...';


GO

CREATE PROCEDURE [Reporting].[FeedKPIConversionRateDetails]


AS
BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
BEGIN TRY
	--*************************Select Data For Conversion Rate Details (Sales/Purchases)*************************--
	SELECT  
			IdDocumentLineAssociated AS IdDocumentLine,
			DocumentIdAssociated AS IdDocument,
			DocumentTypeLabelAssociated AS DocumentType,
			MONTH(DocumentDateAssociated) AS Month,
			YEAR(DocumentDateAssociated) AS Year,
			IdItem,
			ItemDescription,
			LabelItemNature AS ItemNature,
			LabelItemFamily AS ItemFamily,
			TiersName,
			[Type],
			QtyDelivered,
			QtyOrdered,
			ConversionRateDetails

			INTO #temp
			FROM
			(
	----***************************Sales********************************************--
		SELECT 
			--dlc.DocumentId,
	  --      dlc.DocumentLineId,
	  --      dlc.DocumentTypeCode,
	  --      dlc.DocumentTypeLabel,
			--dlc.DocumentDate,
			dlc.IdDocumentlineAssociated,
			dlass.IdDocument AS DocumentIdAssociated,
			dlass.DocumentTypeCode AS DocumentTypeCodeAssociated,
			dlass.DocumentTypeLabel AS DocumentTypeLabelAssociated,
			dlass.DocumentDate AS DocumentDateAssociated,
			dlc.IdItem,
			item.ItemDescription,
			item.LabelItemNature,
			item.LabelItemFamily,
			SUM(dlc.ItemQuantity) AS QtyDelivered,
			tier.TiersName,
			dlass.ItemQuantity AS QtyOrdered,
			--ISNULL(SUM((dlc.MovementQty/dlass.MovementQty))/SUM(dlass.MovementQty),0)*100 AS ConversionRateDetails,
			(SUM(dlc.ItemQuantity)*1.0/NULLIF(dlass.ItemQuantity, 0)) *100 AS ConversionRateDetails,
			'SA' AS [Type]
		FROM [Reporting].[FctSales] dlc WITH(NOLOCK)
		LEFT JOIN [Reporting].[FctSales] dlass WITH(NOLOCK) ON dlc.IdDocumentLineAssociated = dlass.IdDocumentLine
		LEFT JOIN [Reporting].[DimItem] item WITH(NOLOCK) ON item.IdItem=dlc.IdItem
		LEFT JOIN [Reporting].[DimTiers] tier WITH(NOLOCK) ON tier.IdTiers=dlc.IdTiers
		WHERE dlc.IdDocumentlineAssociated IS NOT NULL AND dlc.DocumentTypeCode IN ('D-SA','BS-SA') 
		GROUP BY
					dlc.IdItem,
					item.ItemDescription,
					item.LabelItemNature,
					item.LabelItemFamily,
					tier.TiersName,
					dlc.IdDocumentlineAssociated,
					dlass.IdDocument ,
					dlass.DocumentTypeCode ,
					dlass.DocumentTypeLabel ,
					dlass.DocumentDate ,
					dlass.ItemQuantity 
		UNION ALL

		---******************************Purchase**************************************--
		SELECT 
			--dlc.DocumentId,
	  --      dlc.DocumentLineId,
	  --      dlc.DocumentTypeCode,
	  --      dlc.DocumentTypeLabel,
			--dlc.DocumentDate,
			dlc.IdDocumentlineAssociated,
			dlass.IdDocument AS DocumentIdAssociated,
			dlass.DocumentTypeCode AS DocumentTypeCodeAssociated,
			dlass.DocumentTypeLabel AS DocumentTypeLabelAssociated,
			dlass.DocumentDate AS DocumentDateAssociated,
			dlc.IdItem,
			item.ItemDescription,
			item.LabelItemNature,
			item.LabelItemFamily,
			SUM(dlc.ItemQuantity) AS QtyDelivered,
			tier.TiersName,
			dlass.ItemQuantity AS QtyOrdered,
			--ISNULL(SUM((dlc.MovementQty/dlass.MovementQty))/SUM(dlass.MovementQty),0)*100 AS ConversionRateDetails,
			(SUM(dlc.ItemQuantity)*1.0/NULLIF(dlass.ItemQuantity, 0)) *100 AS ConversionRateDetails,
			'SA' AS [Type]
		FROM [Reporting].[FctPurchases] dlc WITH(NOLOCK)
		LEFT JOIN [Reporting].[FctPurchases] dlass  WITH(NOLOCK) ON dlc.IdDocumentLineAssociated = dlass.IdDocumentLine
		LEFT JOIN [Reporting].[DimItem] item  WITH(NOLOCK) ON item.IdItem=dlc.IdItem
		LEFT JOIN [Reporting].[DimTiers] tier WITH(NOLOCK)  ON tier.IdTiers=dlc.IdTiers
		WHERE dlc.IdDocumentlineAssociated IS NOT NULL AND dlc.DocumentTypeCode IN ( 'FO-PU' ) 
		GROUP BY
					dlc.IdItem,
					item.ItemDescription,
					item.LabelItemNature,
					item.LabelItemFamily,
					tier.TiersName,
					dlc.IdDocumentlineAssociated,
					dlass.IdDocument ,
					dlass.DocumentTypeCode ,
					dlass.DocumentTypeLabel ,
					dlass.DocumentDate ,
					dlass.ItemQuantity 

	)A	


	--***********************************FINAL QUERY*************************************************--
	TRUNCATE TABLE [Reporting].[KPIConversionRateDetails]

	INSERT INTO [Reporting].[KPIConversionRateDetails]
			   ([IdDocumentLine]
			   ,[IdDocument]
			   ,[DocumentType]
			   ,[Month]
			   ,[Year]
			   ,[IdItem]
			   ,[ItemDescription]
			   ,[ItemNature]
			   ,[ItemFamily]
			   ,[TiersName]
			   ,[Type]
			   ,[QtyDelivered]
			   ,[QtyOrdered]
			   ,[ConversionRateDetails])


	SELECT * FROM #temp WITH(NOLOCK)
	SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPIConversionRateDetails', @NbInserted, GETDATE(), @ErrorMessage
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPICustomerAcquisitionCost]...';


GO

 

CREATE PROCEDURE [Reporting].[FeedKPICustomerAcquisitionCost]

AS
BEGIN

DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

--*************************Select Data For Customer Acquisition Cost *************************--  
BEGIN TRY

--DROP TABLE #temp
--DROP TABLE #temp2

--**Amount spent on Marketing related activities**--
SELECT 

SUM(Amount) AS TotalAmount,
FiscalYear

INTO #temp

FROM

(
	--posting of announcements and insertions (account 6231)

	SELECT

	-SUM(dal.DocumentAccountLineDebitAmount) AS Amount,
	fy.FiscalYearName AS FiscalYear

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
	LEFT JOIN [Reporting].[DimTiers] t WITH(NOLOCK) ON t.IdAccount=a.AccountId
	
	WHERE a.AccountCode like  '6231%' 

	GROUP BY fy.FiscalYearName

	UNION ALL

	SELECT

	-SUM(dal.DocumentAccountLineDebitAmount) AS Amount,
	fy.FiscalYearName AS FiscalYear

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
	LEFT JOIN [Reporting].[DimTiers] t WITH(NOLOCK) ON t.IdAccount=a.AccountId
	
	WHERE a.AccountCode like  '44566%' 

	GROUP BY fy.FiscalYearName

	UNION ALL

	SELECT

	SUM(dal.DocumentAccountLineCreditAmount) AS Amount,
	fy.FiscalYearName AS FiscalYear

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
	LEFT JOIN [Reporting].[DimTiers] t WITH(NOLOCK) ON t.IdAccount=a.AccountId
	
	WHERE a.AccountCode like  '401%' 

	GROUP BY fy.FiscalYearName

	UNION ALL


	--accounting for trade fairs and exhibitions (account 6233)
	SELECT

	-SUM(dal.DocumentAccountLineDebitAmount) AS Amount,
	fy.FiscalYearName AS FiscalYear

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
	LEFT JOIN [Reporting].[DimTiers] t WITH(NOLOCK) ON t.IdAccount=a.AccountId
	
	WHERE a.AccountCode like  '6233%' 

	GROUP BY fy.FiscalYearName

	UNION ALL

	SELECT

	-SUM(dal.DocumentAccountLineDebitAmount) AS Amount,
	fy.FiscalYearName AS FiscalYear

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
	LEFT JOIN [Reporting].[DimTiers] t WITH(NOLOCK) ON t.IdAccount=a.AccountId
	
	WHERE a.AccountCode like  '44566%' 

	GROUP BY fy.FiscalYearName

	UNION ALL

	SELECT

	SUM(dal.DocumentAccountLineCreditAmount) AS Amount,
	fy.FiscalYearName AS FiscalYear

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
	LEFT JOIN [Reporting].[DimTiers] t WITH(NOLOCK) ON t.IdAccount=a.AccountId
	
	WHERE a.AccountCode like  '401%' 

	GROUP BY fy.FiscalYearName

	UNION ALL

	--accounting of printed matter and advertising catalogs (account 6236)
	SELECT

	-SUM(dal.DocumentAccountLineDebitAmount) AS Amount,
	fy.FiscalYearName AS FiscalYear

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
	LEFT JOIN [Reporting].[DimTiers] t WITH(NOLOCK) ON t.IdAccount=a.AccountId
	
	WHERE a.AccountCode like  '6236%' 

	GROUP BY fy.FiscalYearName

	UNION ALL

	SELECT

	-SUM(dal.DocumentAccountLineDebitAmount) AS Amount,
	fy.FiscalYearName AS FiscalYear

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
	LEFT JOIN [Reporting].[DimTiers] t WITH(NOLOCK) ON t.IdAccount=a.AccountId
	
	WHERE a.AccountCode like  '44566%' 

	GROUP BY fy.FiscalYearName

	UNION ALL

	SELECT

	SUM(dal.DocumentAccountLineCreditAmount) AS Amount,
	fy.FiscalYearName AS FiscalYear

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
	LEFT JOIN [Reporting].[DimTiers] t WITH(NOLOCK) ON t.IdAccount=a.AccountId
	
	WHERE a.AccountCode like  '401%' 

	GROUP BY fy.FiscalYearName

	UNION ALL

	--samples (account 6232)

	SELECT

	-SUM(dal.DocumentAccountLineDebitAmount) AS Amount,
	fy.FiscalYearName AS FiscalYear

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
	LEFT JOIN [Reporting].[DimTiers] t WITH(NOLOCK) ON t.IdAccount=a.AccountId
	
	WHERE a.AccountCode like  '6236%' 

	GROUP BY fy.FiscalYearName

	UNION ALL

	SELECT

	-SUM(dal.DocumentAccountLineDebitAmount) AS Amount,
	fy.FiscalYearName AS FiscalYear

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
	LEFT JOIN [Reporting].[DimTiers] t WITH(NOLOCK) ON t.IdAccount=a.AccountId
	
	WHERE a.AccountCode like  '44566%' 

	GROUP BY fy.FiscalYearName

	UNION ALL

	SELECT

	SUM(dal.DocumentAccountLineCreditAmount) AS Amount,
	fy.FiscalYearName AS FiscalYear

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
	LEFT JOIN [Reporting].[DimTiers] t WITH(NOLOCK) ON t.IdAccount=a.AccountId
	
	WHERE a.AccountCode like  '401%' 

	GROUP BY fy.FiscalYearName

	UNION ALL

	--gifts to clients (account 6234)
	SELECT

	-SUM(dal.DocumentAccountLineDebitAmount) AS Amount,
	fy.FiscalYearName AS FiscalYear

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
	LEFT JOIN [Reporting].[DimTiers] t WITH(NOLOCK) ON t.IdAccount=a.AccountId
	
	WHERE a.AccountCode like  '6234%' 

	GROUP BY fy.FiscalYearName

	UNION ALL

	SELECT

	-SUM(dal.DocumentAccountLineDebitAmount) AS Amount,
	fy.FiscalYearName AS FiscalYear

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
	LEFT JOIN [Reporting].[DimTiers] t WITH(NOLOCK) ON t.IdAccount=a.AccountId
	
	WHERE a.AccountCode like  '44566%' 

	GROUP BY fy.FiscalYearName

	UNION ALL

	SELECT

	SUM(dal.DocumentAccountLineCreditAmount) AS Amount,
	fy.FiscalYearName AS FiscalYear

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
	LEFT JOIN [Reporting].[DimTiers] t WITH(NOLOCK) ON t.IdAccount=a.AccountId
	
	WHERE a.AccountCode like  '401%' 

	GROUP BY fy.FiscalYearName



)A

GROUP BY   FiscalYear


SELECT * 

INTO #temp2

FROM

(

--** Total Client**--
	SELECT 
	
	COUNT(*) AS TotalClient
	,YEAR(CreationDate) AS Year
	
	FROM [Reporting].[DimTiers]
	where TypeTiersLabel like '%client%' and idaccount is not null

	GROUP BY YEAR(CreationDate)

)B	
	--***********************************FINAL QUERY*************************************************--
	TRUNCATE TABLE [Reporting].[KPICustomerAcquisitionCost]
	
	INSERT INTO [Reporting].[KPICustomerAcquisitionCost]
           ([CAC]
           ,[FiscalYear]
          )

	SELECT 

	ISNULL((t.TotalAmount / NULLIF(t2.TotalClient,0)),0) AS CAC , t.FiscalYear

	FROM #temp t

	LEFT JOIN #temp2 t2 on t.FiscalYear=t2.Year

	



SET @NbInserted = @@ROWCOUNT

END TRY

BEGIN CATCH 

SET @ErrorMessage = ERROR_MESSAGE()

END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPICustomerAcquisitionCost', @NbInserted, GETDATE(), @ErrorMessage



END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPIDelayedPayment]...';


GO
CREATE PROCEDURE [Reporting].[FeedKPIDelayedPayment]
AS
BEGIN

DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
BEGIN TRY

    DROP TABLE #TempPay
	SELECT 
	NbDelayPay,
	FiscalYear,
	FiscalMonth

	INTO #TempPay
	
	FROM
	(

	
  SELECT COUNT(*) AS NbDelayPay,
  YEAR(dal.DocumentAccountDate) AS FiscalYear,
  MONTH(dal.DocumentAccountDate) AS FiscalMonth
  FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
  LEFT JOIN [Reporting].[DimAccount] a WITH(NOLOCK) ON dal.AccountIdAssociated=a.[AccountId]
  LEFT JOIN [Reporting].[DimJournal] jn WITH(NOLOCK) ON jn.journalID=dal.JournalId
  
  WHERE jn.JournalLabel IN ('Achat','Vente') AND dal.[DocumentAccountLineLetter] IS NULL 

  GROUP BY YEAR(dal.DocumentAccountDate), MONTH(dal.DocumentAccountDate)
	 
	 )A

--------------------------Final Query-------------------------


TRUNCATE TABLE [Reporting].[KPIDelayedPayment]
   INSERT INTO [Reporting].[KPIDelayedPayment]
   (
 [Year]
,[Month]
,[DelayedPaymentCurrentYear]
,[DelayedPaymentLastMonth]
,[DelayedPaymentLastMonthLastYear]
,[DelayedPaymentLastYear]
,[DelayedPaymentYearToDate]
,[DelayedPaymentYearToDateLastYear]
   )

  SELECT
        PayCurrentY.FiscalYear, 
        PayCurrentY.FiscalMonth,
		ISNULL(PayCurrentY.NbDelayPay,0) AS DelayPayCY,
		ISNULL(PayLastM.NbDelayPay,0) AS DelayPayLM,
        ISNULL(PayLastY.NbDelayPay,0) AS DelayPayLY,
		ISNULL(PayLastMLastY.NbDelayPay,0) AS DelayPayLMLY,
		ISNULL(PayYTD.NbDelayPay,0) AS DelayPayYTD,
		ISNULL(PayLastYTD.NbDelayPay,0) AS DelayPayLastYTD

        
    FROM #TempPay PayCurrentY
    LEFT JOIN #TempPay PayLastM
    ON PayCurrentY.FiscalYear = PayLastM.FiscalYear and PayCurrentY.FiscalMonth =PayLastM.FiscalMonth +1
	LEFT JOIN #TempPay PayLastY
    ON PayCurrentY.FiscalYear = PayLastY.FiscalYear +1 and PayCurrentY.FiscalMonth = PayLastY.FiscalMonth
	LEFT JOIN #TempPay PayYTD
    ON PayYTD.FiscalYear = PayLastY.FiscalYear +1 and PayYTD.FiscalMonth = PayLastY.FiscalMonth
	LEFT JOIN #TempPay PayLastYTD
    ON PayLastYTD.FiscalYear = PayLastY.FiscalYear and PayLastYTD.FiscalMonth = PayLastY.FiscalMonth
	LEFT JOIN #TempPay PayLastMLastY
    ON PayLastMLastY.FiscalYear = PayCurrentY.FiscalYear-1
    AND   PayLastMLastY.FiscalMonth= MONTH(DateADD(MONTH,-13,DATEFROMPARTS(PayLastY.FiscalYear, PayCurrentY.FiscalMonth, 1)))
 
GROUP BY PayCurrentY.NbDelayPay,PayLastM.NbDelayPay,PayLastY.NbDelayPay, PayLastMLastY.NbDelayPay,
PayYTD.NbDelayPay, PayLastYTD.NbDelayPay, PayCurrentY.FiscalYear, PayCurrentY.FiscalMonth
ORDER BY FiscalYear,FiscalMonth

	SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPIDelayedPayment', @NbInserted, GETDATE(), @ErrorMessage
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPIDeliveryRate]...';


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
        

 


    
    --***********************************FINAL QUERY*************************************************--

 


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
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPIGrossMargin]...';


GO


CREATE PROCEDURE [Reporting].[FeedKPIGrossMargin]

AS
BEGIN

DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

--*************************Select Data For Gross Margin*************************--  
BEGIN TRY

	--DROP TABLE #Tempdepense
	--DROP TABLE #TempTurn
	--DROP TABLE #TempFinal

--**Turnover**--
	SELECT 
	
	SUM(Amount) AS Turnover,
	Month,
	Year
	
	INTO #TempTurn 
	
	FROM
	(
	SELECT

	ISNULL(SUM(dal.[DocumentAccountLineCreditAmount]),0) AS Amount,
	MONTH(dal.DocumentAccountDate) AS Month,
	YEAR(dal.DocumentAccountDate) AS Year

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]

	WHERE a.AccountCode like  '70%' 

	GROUP BY MONTH(dal.DocumentAccountDate),YEAR(dal.DocumentAccountDate)


	UNION ALL

	--D�duction des rabais,remises et ristournes accord�s par l'entreprise pour la vente (Compte 709)
	SELECT
	 
	ISNULL(-SUM(dal.[DocumentAccountLineCreditAmount]),0) AS Amount,
	MONTH(dal.DocumentAccountDate) AS Month,
	YEAR(dal.DocumentAccountDate) AS Year

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	
	WHERE a.AccountCode like  '709%' 

	GROUP BY MONTH(dal.DocumentAccountDate),YEAR(dal.DocumentAccountDate) 

	)A

	GROUP BY Month,Year


--**D�penses**--
	SELECT 

	SUM(Amount) AS Depense,
	Month,
	Year

	INTO #Tempdepense
	
	FROM

	(
	SELECT

	ISNULL(-SUM(dal.DocumentAccountLineDebitAmount),0) AS Amount,
	MONTH(dal.DocumentAccountDate) AS Month,
	YEAR(dal.DocumentAccountDate) AS Year

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	
	WHERE a.AccountCode like  '60%'

	GROUP BY MONTH(dal.DocumentAccountDate),YEAR(dal.DocumentAccountDate)
	

	UNION ALL

	--D�duction des rabais,remises et ristournes accord�s par l'entreprise pour l'achat (Compte 609)
	SELECT

	ISNULL(SUM(dal.DocumentAccountLineDebitAmount),0) AS Amount,
	MONTH(dal.DocumentAccountDate) AS Month,
	YEAR(dal.DocumentAccountDate) AS Year

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	
	WHERE a.AccountCode like  '609%'

	GROUP BY MONTH(dal.DocumentAccountDate),YEAR(dal.DocumentAccountDate)
	
	)A

	GROUP BY Month,Year

--**GrossMargin**--

	SELECT 
	Year,
	Month,
	ISNULL(SUM(DISTINCT CurrentAmount),0) AS GrossMargionCurrentYear,
	ISNULL(SUM(DISTINCT LastMonthAmount),0)AS GrossMarginLastMonth,
	ISNULL(SUM(DISTINCT LastYearAmount),0) AS GrossMarginLastYear,
	ISNULL(SUM(DISTINCT LastMonthLastYearAmount),0) AS GrossMarginLastMonthLastYear,
	ISNULL(SUM(DISTINCT YearToDateAmount),0) AS GrossMarginYearToDate,
	ISNULL(SUM(DISTINCT LastYearYearToDateAmount),0) AS GrossMarginLastYearYearToDate,
	SUM(DISTINCT VariationCurrentMonthLastMonthAmount) AS GrossMarginVariationCurrentMonthLastMonth,
	SUM(DISTINCT VariationCurrentYearLastYearAmount) AS GrossMarginVariationCurrentYearLastYear
	
	INTO #TempFinal

	FROM
	(
	
	
	SELECT  
	
	t2.Year,
    t2.Month, 
    t2.Depense AS CurrentAmount,
    lm2.Depense AS LastMonthAmount,
    ly2.Depense AS LastYearAmount,
	lmly2.Depense AS LastMonthLastYearAmount,
	SUM(DISTINCT ytd2.Depense) AS YearToDateAmount,
	SUM(DISTINCT lytd2.Depense) AS LastYearYearToDateAmount,
	ISNULL(((t2.Depense-lm2.Depense)/NULLIF(lm2.Depense,0))*100,0) AS VariationCurrentMonthLastMonthAmount,
	ISNULL(((t2.Depense-ly2.Depense)/NULLIF(ly2.Depense,0))*100,0) AS VariationCurrentYearLastYearAmount

	

    
	FROM #Tempdepense t2
	LEFT JOIN #Tempdepense lm2 ON lm2.Year = t2.Year AND lm2.Month=t2.Month-1
    LEFT JOIN #Tempdepense ly2 ON ly2.Year=t2.Year-1 AND ly2.Month =t2.Month
	LEFT JOIN #Tempdepense lmly2 ON lmly2.Year = t2.Year-1 AND lmly2.Month =MONTH(DATEADD(MONTH,-1,DATEFROMPARTS(t2.Year, t2.Month, 1)))
    LEFT JOIN #Tempdepense ytd2 ON t2.Year = ytd2.Year AND ytd2.Month <= t2.Month
	LEFT JOIN #Tempdepense lytd2 ON t2.Year = lytd2.Year+1  AND lytd2.Month <=ly2.Month

	GROUP BY 
	t2.Year,
    t2.Month,
    t2.Depense,
    lm2.Depense,
    ly2.Depense,
	lmly2.Depense,
	lytd2.Depense,
	ytd2.Depense
	
	--ORDER BY Year, Month

	UNION ALL

	SELECT  

	t1.Year,
    t1.Month, 
    t1.Turnover AS CurrentAmount,
    lm.Turnover AS LastMonthAmount,
    ly.Turnover AS LastYearAmount,
	lmly.Turnover AS LastMonthLastYearAmount,
	SUM(DISTINCT ytd.Turnover) AS YearToDateAmount,
	SUM(DISTINCT lytd.Turnover) AS LastYearYearToDateAmount,
	ISNULL(((t1.Turnover-lm.Turnover)/NULLIF(lm.Turnover,0))*100,0) AS VariationCurrentMonthLastMonthAmount,
	ISNULL(((t1.Turnover-ly.Turnover)/NULLIF(ly.Turnover,0))*100,0) AS VariationCurrentYearLastYearAmount
	
    
	FROM #TempTurn t1
	LEFT JOIN #TempTurn lm ON lm.Year = t1.Year AND lm.Month=t1.Month-1
    LEFT JOIN #TempTurn ly ON ly.Year=t1.Year-1 AND ly.Month=t1.Month 
	LEFT JOIN #TempTurn lmly ON lmly.Year = t1.Year-1 AND lmly.Month =MONTH(DATEADD(MONTH,-1,DATEFROMPARTS(t1.Year, t1.Month, 1)))
    LEFT JOIN #TempTurn ytd ON t1.Year = ytd.Year AND ytd.Month <= t1.Month
	LEFT JOIN #TempTurn lytd ON t1.Year = lytd.Year+1  AND lytd.Month <= ly.Month
	
	GROUP BY 
	t1.Year,
	t1.Month,
	t1.Turnover ,
	lm.Turnover ,
	ly.Turnover ,
	lmly.Turnover ,
	ytd.Turnover ,
	lytd.Turnover
	--ORDER BY Year, Month

	)B
	
	WHERE
	Year IN
	(
		SELECT
		
		Year,
		Month,
		SUM(DISTINCT VariationCurrentYearToDateLastYearToDateAmount) AS GrossMarginVariationCurrentYearToDateLastYearToDate

		FROM

		(
			SELECT
			t2.Year,
			t2.Month,
			ISNULL(((ytd2.Depense-lytd2.Depense)/NULLIF(lytd2.Depense,0))*100,0) AS VariationCurrentYearToDateLastYearToDateAmount

			FROM #Tempdepense t2

			LEFT JOIN #Tempdepense ly2 ON ly2.Year=t2.Year-1 AND ly2.Month =t2.Month
			LEFT JOIN #Tempdepense ytd2 ON t2.Year = ytd2.Year AND ytd2.Month <= t2.Month
			LEFT JOIN #Tempdepense lytd2 ON t2.Year = lytd2.Year+1  AND lytd2.Month <=ly2.Month
			
			UNION ALL

			SELECT 
			t1.Year,
			t1.Month,
			ISNULL(((ytd.Turnover-lytd.Turnover)/NULLIF(lytd.Turnover,0))*100,0) AS VariationCurrentYearToDateLastYearToDateAmount

			FROM #TempTurn t1
			
			LEFT JOIN #TempTurn ly ON ly.Year=t1.Year-1 AND ly.Month=t1.Month 
			LEFT JOIN #TempTurn ytd ON t1.Year = ytd.Year AND ytd.Month <= t1.Month
			LEFT JOIN #TempTurn lytd ON t1.Year = lytd.Year+1  AND lytd.Month <= ly.Month
		)A
		GROUP BY Year,Month
	)
	GROUP BY Month,Year
	--,VariationCurrentYearToDateLastYearToDateAmount
	--,CurrentAmount
	--DROP TABLE #TempFinal
	--SELECT * from #TempFinal

	--***********************************FINAL QUERY*************************************************--
	TRUNCATE TABLE [Reporting].[KPIGrossMargin]
	
	INSERT INTO [Reporting].[KPIGrossMargin]
           ([Year]
           ,[Month]
           ,[GrossMarginCurrentYear]
           ,[GrossMarginLastYear]
           ,[GrossMarginLastMonth]
           ,[GrossMarginLastMonthLastYear]
           ,[GrossMarginYearToDate]
           ,[GrossMarginLastYearYearToDate]
           ,[GrossMarginVariationCurrentMonthLastMonth]
           ,[GrossMarginVariationCurrentYearLastYear]
           ,[GrossMarginVariationCurrentYearToDateLastYearToDate])

	
	SELECT * FROM #TempFinal


	SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPIGrossMargin', @NbInserted, GETDATE(), @ErrorMessage



END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPIGrossOperatingSurplus]...';


GO

 

CREATE PROCEDURE [Reporting].[FeedKPIGrossOperatingSurplus]

AS
BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
--,@year SMALLINT
--SET @year = YEAR(GETDATE());

--*************************Select Data For Gross Operating Surplus*************************--  
BEGIN TRY


  -------------CA------------------
  
  SELECT 
	
    SUM(Amount) AS  CA
    ,Year
	,Month

	INTO #TempCA
	
	FROM
	(    SELECT
    ISNULL(SUM(dal.[DocumentAccountLineCreditAmount]),0) AS Amount,
    YEAR(dal.DocumentAccountDate) AS Year,
    MONTH(dal.DocumentAccountDate) AS Month
   
	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
    LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
    WHERE a.AccountCode like  '70%' 

    GROUP BY   YEAR(dal.DocumentAccountDate),
    MONTH(dal.DocumentAccountDate)

	UNION ALL


	
    SELECT
    -ISNULL(SUM(dal.[DocumentAccountLineCreditAmount]),0) AS Amount,
    YEAR(dal.DocumentAccountDate) AS Year,
	MONTH(dal.DocumentAccountDate) AS Month

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
    LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
    LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId

    WHERE a.AccountCode like  '709%' --AND     --YEAR(dal.DocumentAccountDate)=YEAR(GETDATE())-1
    
	GROUP BY YEAR(dal.DocumentAccountDate),
	MONTH(dal.DocumentAccountDate)

)A
GROUP BY Year,
         Month
--select *from #TempCA
--drop table #TempCA



	-------- Achats de marchandises --------------
	SELECT
	
	ISNULL(SUM(dal.[DocumentAccountLineCreditAmount]),0) AS Amount,
    YEAR(dal.DocumentAccountDate) AS Year,
	MONTH(dal.DocumentAccountDate) AS Month
	INTO #TempAchatMarchandise
    FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
    LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
    LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
    WHERE a.AccountCode like  '607%' AND     YEAR(dal.DocumentAccountDate)=YEAR(GETDATE())-1
  
    GROUP BY YEAR(dal.DocumentAccountDate),
	MONTH(dal.DocumentAccountDate)
    --drop table #TempAchatMarchandise


	
	-------- Autres charges externes ---------
	SELECT
	
	ISNULL(SUM(dal.[DocumentAccountLineCreditAmount]),0) AS Amount,
    YEAR(dal.DocumentAccountDate) AS Year,
	MONTH(dal.DocumentAccountDate) AS Month
	INTO #TempChargeExterne
    FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
    LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
    LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
    WHERE a.AccountCode like  '61%' AND a.AccountCode like  '62%' AND YEAR(dal.DocumentAccountDate)=YEAR(GETDATE())-1
  
    GROUP BY YEAR(dal.DocumentAccountDate),
	MONTH(dal.DocumentAccountDate)
	    --drop table #TempChargeExterne


   --Imp�ts, taxes et versements assimil�s
     
	SELECT
	
	ISNULL(SUM(dal.[DocumentAccountLineCreditAmount]),0) AS Amount,
    YEAR(dal.DocumentAccountDate) AS Year,
	MONTH(dal.DocumentAccountDate) AS Month
	INTO #TempImpot
    FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
    LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
    LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
    WHERE a.AccountCode like  '66%' AND YEAR(dal.DocumentAccountDate)=YEAR(GETDATE())-1
  
    GROUP BY YEAR(dal.DocumentAccountDate),
	MONTH(dal.DocumentAccountDate)
	--drop table #TempImpot



    --Salaires, appointements

	SELECT
	
	ISNULL(SUM(dal.[DocumentAccountLineCreditAmount]),0) AS Amount,
    YEAR(dal.DocumentAccountDate) AS Year,
	MONTH(dal.DocumentAccountDate) AS Month
	INTO #Tempsalaire
    FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
    LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
    LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
    WHERE a.AccountCode like  '6411%' AND YEAR(dal.DocumentAccountDate)=YEAR(GETDATE())-1
  
    GROUP BY YEAR(dal.DocumentAccountDate),
	MONTH(dal.DocumentAccountDate)
		--drop table #Tempsalaire

		--Subventions accord�es
	SELECT

	-ISNULL(SUM(dal.[DocumentAccountLineCreditAmount]),0) AS Amount,
    YEAR(dal.DocumentAccountDate) AS Year,
	MONTH(dal.DocumentAccountDate) AS Month
	INTO #Tempsubvention
    FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
    LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
    LEFT JOIN [Reporting].[DimFiscalYear] fy WITH(NOLOCK) ON fy.FiscalYearId=dal.FiscalYearId
    WHERE a.AccountCode like  '741%' AND   YEAR(dal.DocumentAccountDate)=YEAR(GETDATE())-1
  
    GROUP BY YEAR(dal.DocumentAccountDate),
	MONTH(dal.DocumentAccountDate)
			--drop table #Tempsubvention


	
	ORDER BY Year, Month


--***********************************FINAL QUERY*************************************************--
TRUNCATE TABLE [Reporting].[KPIGrossOperatingSurplus]
	
INSERT INTO [Reporting].[KPIGrossOperatingSurplus]
([Year]
,[Month]
,[GrossOperatingSurplusCurrentYear]
,[GrossOperatingSurplusLastMonth]
,[GrossOperatingSurplusLastMonthLastYear]
,[GrossOperatingSurplusLastYear]
,[GrossOperatingSurplusYearToDate]
,[GrossOperatingSurplusYearToDateLastYear])


  SELECT 
	
    FiscalYear,
    FiscalMonth,
	ISNULL(SUM(CurrentAmount),0) AS GrossOperatingCurrentYear,
	ISNULL(SUM(LastMonthAmount),0)AS GrossOperatingLastMonth ,
	ISNULL(SUM(DISTINCT LastMonthLastYearAmount),0) AS GrossOperatingLastYearLastMonth,
	ISNULL(SUM(DISTINCT lastYearAmount),0) AS GrossOperatingLastYear,
	ISNULL(SUM(DISTINCT yearToDateAmount),0) AS GrossOperatingYearToDate,
	ISNULL(SUM(DISTINCT LastYearToDateAmount),0) AS GrossOperatingLastYearToDate

	
	FROM
	(
	--Chiffre d'affaire--
	select  cacurrenty.Year AS FiscalYear, 
        cacurrenty.Month AS FiscalMonth, 
        SUM(DISTINCT cacurrenty.CA)  AS CurrentAmount,
        SUM(DISTINCT calastm.CA) AS LastMonthAmount,
		SUM(DISTINCT calastmlasty.CA)AS LastMonthLastYearAmount,
        SUM(DISTINCT calasty.CA)AS lastYearAmount,
		SUM(DISTINCT caytd.CA)AS yearToDateAmount,
		SUM(DISTINCT calastytd.CA)AS LastYearToDateAmount


    FROM #TempCA cacurrenty WITH(NOLOCK)
    LEFT JOIN #TempCA calastm WITH(NOLOCK)
    ON cacurrenty.Year = calastm.Year
	AND cacurrenty.Month =calastm.Month +1
    LEFT JOIN #TempCA calasty WITH(NOLOCK)
    on cacurrenty.Year = calasty.Year +1 
	AND cacurrenty.Month = calasty.Month
    LEFT JOIN #TempCA caytd WITH(NOLOCK)
    ON caytd.Year = calasty.Year +1
	--OR caytd.FiscalYear = cacurrenty.FiscalYear -1
	and caytd.Month	<= cacurrenty.Month
--	and caytd.FiscalMonth < cacurrenty.FiscalMonth
    LEFT JOIN #TempCA calastytd WITH(NOLOCK)
    ON calastytd.Year = calasty.Year
	AND calastytd.Month <= calasty.Month
  	LEFT JOIN #TempCA calastmlasty WITH(NOLOCK)
    ON calastmlasty.Year = cacurrenty.Year-1
	AND   calastmlasty.Month= MONTH(DateADD(MONTH,-13,DATEFROMPARTS(calasty.Year, cacurrenty.Month, 1)))  
	GROUP BY  cacurrenty.Year ,cacurrenty.Month
	
	UNION ALL

	
	--Achats--

	SELECT 
	    achatcurrenty.Year AS FiscalYear, 
        achatcurrenty.Month AS FiscalMonth, 
        -SUM(DISTINCT achatcurrenty.Amount)AS CurrentAmount,
        -SUM(DISTINCT achatlastm.Amount) AS LastMonthAmount,
		-SUM(DISTINCT achatlastmlasty.Amount) AS LastMonthLastYearAmount,
        -SUM(DISTINCT achatlasty.Amount) AS lastYearAmount,
		-SUM(DISTINCT achatytd.Amount) AS YearToDateAmount,
		-SUM(DISTINCT achatlastytd.Amount) AS LastYearToDateAmount

    FROM #TempAchatMarchandise achatcurrenty WITH(NOLOCK)
    LEFT JOIN #TempAchatMarchandise achatlastm WITH(NOLOCK)
    ON achatcurrenty.Year = achatlastm.Year
	AND achatcurrenty.Month =achatlastm.Month +1
    LEFT JOIN #TempAchatMarchandise achatlasty WITH(NOLOCK)
	ON achatcurrenty.Year = achatlasty.Year +1
	AND achatcurrenty.Month = achatlasty.Month
    LEFT JOIN #TempAchatMarchandise achatytd WITH(NOLOCK)
    ON achatytd.Year = achatlasty.Year +1 
	AND achatytd.Month = achatcurrenty.Month
    LEFT JOIN #TempAchatMarchandise achatlastytd WITH(NOLOCK)
    ON achatlastytd.Year = achatlasty.Year 
	AND achatlastytd.Month = achatlasty.Month
    LEFT JOIN #TempAchatMarchandise achatlastmlasty WITH(NOLOCK)
    ON achatlastmlasty.Year = achatcurrenty.Year-1
	AND   achatlastmlasty.Month= MONTH(DateADD(MONTH,-13,DATEFROMPARTS(achatlasty.Year, achatcurrenty.Month, 1)))  
    GROUP BY achatcurrenty.Year, achatcurrenty.Month
	
	UNION ALL

		--Charges--


	SELECT
	    chargecurrenty.Year AS FiscalYear, 
        chargecurrenty.Month AS FiscalMonth, 
        -SUM(DISTINCT chargecurrenty.Amount) AS CurrentAmount,
        -SUM(DISTINCT chargelastm.Amount) AS LastMonthAmount,
		-SUM(DISTINCT chargelastmlasty.Amount) AS LastMonthLastYearAmount,
        -SUM(DISTINCT chargelasty.Amount) AS lastYearAmount,
		-SUM(DISTINCT chargeytd.Amount) AS YearToDateAmount,
		-SUM(DISTINCT chargelastytd.Amount) AS LastYearToDateAmount

    FROM #TempChargeExterne chargecurrenty WITH(NOLOCK)
    LEFT JOIN #TempChargeExterne chargelastm WITH(NOLOCK)
    ON chargecurrenty.Year = chargelastm.Year
	AND chargecurrenty.Month =chargelastm.Month +1
    LEFT JOIN #TempChargeExterne chargelasty WITH(NOLOCK)
    ON chargecurrenty.Year = chargelasty.Year +1 
	AND chargecurrenty.Month = chargelasty.Month
    LEFT JOIN #TempChargeExterne chargeytd WITH(NOLOCK)
    ON chargeytd.Year = chargelasty.Year +1 
	AND chargeytd.Month = chargecurrenty.Month
    LEFT JOIN #TempChargeExterne chargelastytd WITH(NOLOCK)
    ON chargelastytd.Year = chargelasty.Year 
	AND chargelastytd.Month = chargelasty.Month
	LEFT JOIN #TempChargeExterne chargelastmlasty WITH(NOLOCK)
    ON chargelastmlasty.Year = chargecurrenty.Year-1
	AND   chargelastmlasty.Month= MONTH(DateADD(MONTH,-13,DATEFROMPARTS(chargelasty.Year, chargecurrenty.Month, 1)))  
    GROUP BY chargecurrenty.Year,chargecurrenty.Month
    
      UNION ALL

		--Impots--

	SELECT
	    impotcurrenty.Year AS FiscalYear, 
        impotcurrenty.Month AS FiscalMonth, 
        -SUM(DISTINCT impotcurrenty.Amount) AS CurrentAmount,
        -SUM(DISTINCT impotlastm.Amount) AS LastMonthAmount,
		-SUM(DISTINCT impotlastmlasty.Amount) AS LastMonthLastYearAmount,
        -SUM(DISTINCT impotlasty.Amount) AS lastYearAmount,
		-SUM(DISTINCT impotytd.Amount) AS YearToDateAmount,
		-SUM(DISTINCT impotlastytd.Amount) AS LastYearToDateAmount

    FROM #TempImpot impotcurrenty WITH(NOLOCK)
    LEFT JOIN #TempImpot impotlastm WITH(NOLOCK)
    ON impotcurrenty.Year = impotlastm.Year 
	AND impotcurrenty.Month =impotlastm.Month +1
    LEFT JOIN #TempImpot impotlasty WITH(NOLOCK)
    ON impotcurrenty.Year = impotlasty.Year +1
	AND impotcurrenty.Month = impotlasty.Month
    LEFT JOIN #TempImpot impotytd WITH(NOLOCK)
    ON impotytd.Year = impotlasty.Year +1 
	AND impotytd.Month = impotcurrenty.Month
    LEFT JOIN #TempImpot impotlastytd WITH(NOLOCK)
    ON impotlastytd.Year = impotlasty.Year 
	AND impotlastytd.Month = impotlasty.Month
	LEFT JOIN #TempImpot impotlastmlasty WITH(NOLOCK)
    ON impotlastmlasty.Year = impotcurrenty.Year-1
	AND   impotlastmlasty.Month= MONTH(DateADD(MONTH,-13,DATEFROMPARTS(impotlasty.Year, impotcurrenty.Month, 1)))  
    GROUP BY impotcurrenty.Year,impotcurrenty.Month

	UNION ALL

	    --Salaires
	SELECT
	    salairecurrenty.Year AS FiscalYear, 
        salairecurrenty.Month AS FiscalMonth, 
        -SUM(DISTINCT salairecurrenty.Amount) AS CurrentAmount,
        -SUM(DISTINCT salairelastm.Amount) AS LastMonthAmount,
		-SUM(DISTINCT salairelastmlasty.Amount) AS LastMonthLastYearAmount,
        -SUM(DISTINCT salairelasty.Amount) AS lastYearAmount,
		-SUM(DISTINCT salaireytd.Amount) AS YearToDateAmount,
		-SUM(DISTINCT salairelastytd.Amount) AS LastYearToDateAmount

    FROM #Tempsalaire salairecurrenty WITH(NOLOCK)
    LEFT JOIN #Tempsalaire salairelastm WITH(NOLOCK)
    ON salairecurrenty.Year = salairelastm.Year 
	AND salairecurrenty.Month =salairelastm.Month +1
    LEFT JOIN #Tempsalaire salairelasty WITH(NOLOCK)
    ON salairecurrenty.Year = salairelasty.Year +1 
	AND salairecurrenty.Month = salairelasty.Month
    LEFT JOIN #Tempsalaire salaireytd WITH(NOLOCK)
    ON salaireytd.Year = salairelasty.Year +1 
	AND salaireytd.Month = salairecurrenty.Month
    LEFT JOIN #Tempsalaire salairelastytd WITH(NOLOCK)
    ON salairelastytd.Year = salairelasty.Year 
	AND salairelastytd.Month = salairelasty.Month
	LEFT JOIN #Tempsalaire salairelastmlasty WITH(NOLOCK)
    ON salairelastmlasty.Year = salairecurrenty.Year-1
	AND   salairelastmlasty.Month= MONTH(DateADD(MONTH,-13,DATEFROMPARTS(salairelasty.Year, salairecurrenty.Month, 1)))  
	GROUP BY salairecurrenty.Year, salairecurrenty.Month

  UNION ALL
		--Subvention--

	SELECT
	    subventioncurrenty.Year AS FiscalYear, 
        subventioncurrenty.Month AS FiscalMonth, 
        SUM(DISTINCT subventioncurrenty.Amount) AS CurrentAmount,
        SUM(DISTINCT subventionlastm.Amount) AS LastMonthAmount,
		SUM(DISTINCT subventionlastmlasty.Amount) AS LastMonthLastYearAmount,
        SUM(DISTINCT subventionlasty.Amount) AS lastYearAmount,
		SUM(DISTINCT subventionytd.Amount) AS YearToDateAmount,
		SUM(DISTINCT subventionlastytd.Amount) AS LastYearToDateAmount

    FROM #Tempsubvention subventioncurrenty WITH(NOLOCK)
    LEFT JOIN #Tempsubvention subventionlastm WITH(NOLOCK)
    ON subventioncurrenty.Year = subventionlastm.Year 
	AND subventioncurrenty.Month =subventionlastm.Month +1 
    LEFT JOIN #Tempsubvention subventionlasty WITH(NOLOCK)
    ON subventioncurrenty.Year = subventionlasty.Year +1 
	AND subventioncurrenty.Month = subventionlasty.Month
    LEFT JOIN #Tempsubvention subventionytd WITH(NOLOCK)
    ON subventionytd.Year = subventionlasty.Year +1 
	AND subventionytd.Month = subventioncurrenty.Month
    LEFT JOIN #Tempsubvention subventionlastytd WITH(NOLOCK)
    ON subventionlastytd.Year = subventionlasty.Year 
	AND subventionlastytd.Month = subventionlasty.Month
	LEFT JOIN #Tempsubvention subventionlastmlasty WITH(NOLOCK)
    ON subventionlastmlasty.Year = subventioncurrenty.Year-1
	AND   subventionlastmlasty.Month= MONTH(DateADD(MONTH,-13,DATEFROMPARTS(subventionlasty.Year, subventioncurrenty.Month, 1)))  
    GROUP BY subventioncurrenty.Year, subventioncurrenty.Month
 
 )B
   GROUP BY FiscalYear,
            FiscalMonth
   ORDER BY FiscalYear, FiscalMonth

	SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPIGrossOperatingSurplus', @NbInserted, GETDATE(), @ErrorMessage



END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPINeedInFunds]...';


GO

 

CREATE PROCEDURE [Reporting].[FeedKPINeedInFunds]

AS
BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
--*************************Select Data For BFR*************************--  
BEGIN TRY

--**********************BFR:Besoin en Fonds de Roulement *********************************--

--Stock En Cours
SELECT 

SUM(Stock) AS BFR,
FiscalYear,
FiscalMonth
 
INTO #TemStock

FROM


(



  SELECT 
  SUM(dal.DocumentAccountLineCreditAmount) AS Stock,
  YEAR(dal.DocumentAccountDate) AS FiscalYear,
  Month(dal.DocumentAccountDate) AS FiscalMonth

  FROM [Reporting].[FctDocumentAccountLine] dal
  LEFT JOIN Reporting.DimAccount a
  ON dal.AccountIdAssociated=a.AccountId
  
  WHERE a.AccountCode like '68173%' 
  GROUP BY 	   YEAR(dal.DocumentAccountDate),
  Month(dal.DocumentAccountDate)

)A

  GROUP BY FiscalYear,
  FiscalMonth


   ----  Clients & comptes rattach�s & CLIENTS ET COMPTES

SELECT 

SUM(Comptes) AS Comptes,
FiscalYear,
FiscalMonth
 

INTO #TemComptes

FROM


(
  SELECT 
  SUM(dal.DocumentAccountLineCreditAmount)	AS Comptes,
  YEAR(dal.DocumentAccountDate) AS FiscalYear,
  MONTH(dal.DocumentAccountDate) AS FiscalMonth

  FROM [Reporting].[FctDocumentAccountLine] dal
  LEFT JOIN Reporting.DimAccount a
  ON dal.AccountIdAssociated=a.AccountId
  WHERE a.AccountCode like '410%' 
  GROUP BY 	    YEAR(dal.DocumentAccountDate),
  MONTH(dal.DocumentAccountDate)

)A

  GROUP BY FiscalYear,
  FiscalMonth



  ----    Fournisseurs - retenues de garantie & Fournisseurs - achats de biens ou de prestations de services & Fournisseurs d'exploitation
 
SELECT 

SUM(Fournisseur) AS Fournisseur,
FiscalYear,
FiscalMonth
 

INTO #TemFournisseur

FROM


(

 ----    Fournisseurs - retenues de garantie & Fournisseurs - achats de biens ou de prestations de services & Fournisseurs d'exploitation

  SELECT 
 -SUM(dal.DocumentAccountLineDebitAmount) AS Fournisseur,
  YEAR(dal.DocumentAccountDate) AS FiscalYear,
  MONTH(dal.DocumentAccountDate) AS FiscalMonth


  FROM [Reporting].[FctDocumentAccountLine] dal
  LEFT JOIN Reporting.DimAccount a
  ON dal.AccountIdAssociated=a.AccountId
  WHERE a.AccountCode like '401%'
  GROUP BY 	    YEAR(dal.DocumentAccountDate),
  MONTH(dal.DocumentAccountDate)

 
)A

  GROUP BY FiscalYear,
  FiscalMonth

 ----  Dettes rattach�es � des participations & Dettes rattach�es � des participations (groupe) & Dettes rattach�es � des participations (hors groupe)& Dettes rattach�es � des soci�t�s en participation

  SELECT 

SUM(Dettes) AS Dettes,
FiscalYear,
FiscalMonth
 

INTO #TemDettes

FROM


(
  SELECT 
 -SUM(dal.DocumentAccountLineDebitAmount)AS Dettes,
  YEAR(dal.DocumentAccountDate) AS FiscalYear,
  Month(dal.DocumentAccountDate) AS FiscalMonth


  FROM [Reporting].[FctDocumentAccountLine] dal
  LEFT JOIN Reporting.DimAccount a
  ON dal.AccountIdAssociated=a.AccountId
  WHERE a.AccountCode like '166%'
  GROUP BY 	   YEAR(dal.DocumentAccountDate),
  Month(dal.DocumentAccountDate)


)A

  GROUP BY FiscalYear,
  FiscalMonth


  TRUNCATE TABLE [Reporting].[KPINeedInFunds]
	
INSERT INTO [Reporting].[KPINeedInFunds]
([Year]
,[Month]
,[NeedInFundsCurrentYear]
,[NeedInFundsLastMonth]
,[NeedInFundsLastMonthLastYear]
,[NeedInFundsLastYear]
,[NeedInFundsYearToDate]
,[NeedInFundsYearToDateLastYear])


SELECT 
   FiscalYear,
   FiscalMonth,
   SUM(CurrentAmount) AS NeedInFundsCurrentYear,
   SUM(LastMonthAmount)as NeedInFundsLastMonth ,
   SUM(DISTINCT LastMonthLastYearAmount) as NeedInFundsLastYearLastMonth,
   SUM(DISTINCT lastYearAmount) as NeedInFundsLastYear,
   SUM(DISTINCT yearToDateAmount) as NeedInFundsYearToDate,
   SUM(DISTINCT LastYearToDateAmount) as NeedInFundsLastYearToDate

	FROM
	(
	--Stock En Cours
	    select  stockcurrenty.FiscalYear AS FiscalYear, 
        stockcurrenty.FiscalMonth AS FiscalMonth, 
        SUM(DISTINCT stockcurrenty.BFR)  AS CurrentAmount,
        SUM(DISTINCT stocklastm.BFR) AS LastMonthAmount,
		SUM(DISTINCT stocklastmlasty.BFR)AS LastMonthLastYearAmount,
        SUM(DISTINCT stocklasty.BFR)AS lastYearAmount,
		SUM(DISTINCT stockytd.BFR)AS yearToDateAmount,
		SUM(DISTINCT stocklastytd.BFR)AS LastYearToDateAmount
	


    from #TemStock stockcurrenty 
    left join #TemStock stocklastm
    on stockcurrenty.FiscalYear = stocklastm.FiscalYear
	and stockcurrenty.FiscalMonth =stocklastm.FiscalMonth +1
    left join #TemStock stocklasty
    on stockcurrenty.FiscalYear = stocklasty.FiscalYear +1 
	and stockcurrenty.FiscalMonth = stocklasty.FiscalMonth
    left join #TemStock stockytd
    on stockytd.FiscalYear = stocklasty.FiscalYear +1
	and stockytd.FiscalMonth	<= stockcurrenty.FiscalMonth
    left join #TemStock stocklastytd
    on stocklastytd.FiscalYear = stocklasty.FiscalYear
	and stocklastytd.FiscalMonth <= stocklasty.FiscalMonth
  	left join #TemStock stocklastmlasty
    on stocklastmlasty.FiscalYear = stockcurrenty.FiscalYear-1
	AND   stocklastmlasty.FiscalMonth= MONTH(DateADD(MONTH,-13,DATEFROMPARTS(stocklasty.FiscalYear, stockcurrenty.FiscalMonth, 1)))  

	group by  stockcurrenty.FiscalYear ,stockcurrenty.FiscalMonth
	
	UNION ALL

	
	   ----  Clients & comptes rattach�s & CLIENTS ET COMPTES


	select 
	    comptecurrenty.FiscalYear AS FiscalYear, 
        comptecurrenty.FiscalMonth AS FiscalMonth, 
        SUM(DISTINCT comptecurrenty.Comptes)AS CurrentAmount,
        SUM(DISTINCT comptelastm.Comptes) AS LastMonthAmount,
		SUM(DISTINCT comptelastmlasty.Comptes) AS LastMonthLastYearAmount,
        SUM(DISTINCT comptelasty.Comptes) AS lastYearAmount,
		SUM(DISTINCT compteytd.Comptes) AS YearToDateAmount,
		SUM(DISTINCT comptelastytd.Comptes) AS LastYearToDateAmount
    from #TemComptes comptecurrenty
    left join #TemComptes comptelastm
    on comptecurrenty.FiscalYear = comptelastm.FiscalYear and comptecurrenty.FiscalMonth =comptelastm.FiscalMonth +1
    left join #TemComptes comptelasty
	on comptecurrenty.FiscalYear = comptelasty.FiscalYear +1 and comptecurrenty.FiscalMonth = comptelasty.FiscalMonth
    left join #TemComptes compteytd
    on compteytd.FiscalYear = comptelasty.FiscalYear +1 and compteytd.FiscalMonth = comptecurrenty.FiscalMonth
    left join #TemComptes comptelastytd
    on comptelastytd.FiscalYear = comptelasty.FiscalYear and comptelastytd.FiscalMonth = comptelasty.FiscalMonth
    left join #TemComptes comptelastmlasty
    on comptelastmlasty.FiscalYear = comptecurrenty.FiscalYear-1
	AND   comptelastmlasty.FiscalMonth= MONTH(DateADD(MONTH,-13,DATEFROMPARTS(comptelasty.FiscalYear, comptecurrenty.FiscalMonth, 1)))  

   --
	group by comptecurrenty.FiscalYear, comptecurrenty.FiscalMonth

	UNION ALL

	  ----    Fournisseurs - retenues de garantie & Fournisseurs - achats de biens ou de prestations de services & Fournisseurs d'exploitation



	select  fournisseurcurrenty.FiscalYear AS FiscalYear, 
        fournisseurcurrenty.FiscalMonth AS FiscalMonth, 
        -SUM(DISTINCT fournisseurcurrenty.Fournisseur) AS CurrentAmount,
        -SUM(DISTINCT fournisseurlastm.Fournisseur) as LastMonthAmount,
		-SUM(DISTINCT fournisseurlastmlasty.Fournisseur) AS LastMonthLastYearAmount,
        -SUM(DISTINCT fournisseurlasty.Fournisseur) as lastYearAmount,
		-SUM(DISTINCT fournisseurytd.Fournisseur) as YearToDateAmount,
		-SUM(DISTINCT fournisseurlastytd.Fournisseur) as LastYearToDateAmount
    from #TemFournisseur fournisseurcurrenty
    left join #TemFournisseur fournisseurlastm
    on fournisseurcurrenty.FiscalYear = fournisseurlastm.FiscalYear and fournisseurcurrenty.FiscalMonth =fournisseurlastm.FiscalMonth +1
    left join #TemFournisseur fournisseurlasty
    on fournisseurcurrenty.FiscalYear = fournisseurlasty.FiscalYear +1 and fournisseurcurrenty.FiscalMonth = fournisseurlasty.FiscalMonth
    left join #TemFournisseur fournisseurytd
    on fournisseurytd.FiscalYear = fournisseurlasty.FiscalYear +1 and fournisseurytd.FiscalMonth = fournisseurcurrenty.FiscalMonth
    left join #TemFournisseur fournisseurlastytd
    on fournisseurlastytd.FiscalYear = fournisseurlasty.FiscalYear and fournisseurlastytd.FiscalMonth = fournisseurlasty.FiscalMonth
	left join #TemFournisseur fournisseurlastmlasty
    on fournisseurlastmlasty.FiscalYear = fournisseurcurrenty.FiscalYear-1
	AND   fournisseurlastmlasty.FiscalMonth= MONTH(DateADD(MONTH,-13,DATEFROMPARTS(fournisseurlasty.FiscalYear, fournisseurcurrenty.FiscalMonth, 1)))  

      group by fournisseurcurrenty.FiscalYear,fournisseurcurrenty.FiscalMonth


      UNION ALL

 ----  Dettes rattach�es � des participations & Dettes rattach�es � des participations (groupe) & Dettes rattach�es � des participations (hors groupe)& Dettes rattach�es � des soci�t�s en participation

	select  dettecurrenty.FiscalYear AS FiscalYear, 
        dettecurrenty.FiscalMonth AS FiscalMonth, 
        -SUM(DISTINCT dettecurrenty.Dettes) AS CurrentAmount,
        -SUM(DISTINCT dettelastm.Dettes) AS LastMonthAmount,
		-SUM(DISTINCT dettelastmlasty.Dettes) AS LastMonthLastYearAmount,
        -SUM(DISTINCT dettelasty.Dettes) AS lastYearAmount,
		-SUM(DISTINCT detteytd.Dettes) AS YearToDateAmount,
		-SUM(DISTINCT dettelastytd.Dettes) AS LastYearToDateAmount

    from #TemDettes dettecurrenty
    left join #TemDettes dettelastm
    on dettecurrenty.FiscalYear = dettelastm.FiscalYear and dettecurrenty.FiscalMonth =dettelastm.FiscalMonth +1
    left join #TemDettes dettelasty
    on dettecurrenty.FiscalYear = dettelasty.FiscalYear +1 and dettecurrenty.FiscalMonth = dettelasty.FiscalMonth
    left join #TemDettes detteytd
    on detteytd.FiscalYear = dettelasty.FiscalYear +1 and detteytd.FiscalMonth = dettecurrenty.FiscalMonth
    left join #TemDettes dettelastytd
    on dettelastytd.FiscalYear = dettelasty.FiscalYear and dettelastytd.FiscalMonth = dettelasty.FiscalMonth
	left join #TemDettes dettelastmlasty
    on dettelastmlasty.FiscalYear = dettecurrenty.FiscalYear-1
	AND   dettelastmlasty.FiscalMonth= MONTH(DateADD(MONTH,-13,DATEFROMPARTS(dettelasty.FiscalYear, dettecurrenty.FiscalMonth, 1)))  

    group by dettecurrenty.FiscalYear,dettecurrenty.FiscalMonth


 )B
   GROUP BY FiscalYear,
            FiscalMonth
   order by FiscalYear, FiscalMonth



	SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPINeedInFunds', @NbInserted, GETDATE(), @ErrorMessage



END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPIOrderStatus]...';


GO

 

CREATE PROCEDURE [Reporting].[FeedKPIOrderStatus]

 AS
 BEGIN
 DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
--*************************Select Data For Order Status (Sales/Purchases)*************************--  
BEGIN TRY
	SELECT 
			DocumentDate,
			YEAR(DocumentDate) AS [Year],
			MONTH(DocumentDate) AS [Month],
			IdDocument AS IdOrder,
			DocumentCode AS OrderCode,
			SUM(DocumentHtPrice) AS HtAmount,
			IdStatus,
			DocumentStatus,
			TiersName,
			TiersCode,
			[Type]
	INTO #Temp
	FROM (

			--Sales Order
			SELECT DISTINCT sale.DocumentDate, sale.IdDocument, sale.DocumentCode, sale.IdStatus, sale.DocumentStatus, sale.DocumentHtPrice, tier.TiersName, tier.TiersCode, 'SA' AS [Type]
			FROM [Reporting].[FctSales] sale WITH(NOLOCK)
			LEFT JOIN [Reporting].[DimTiers] tier WITH(NOLOCK) ON sale.IdTiers=tier.IdTiers
			WHERE [DocumentTypeCode] IN ('BS-SA','D-SA','O-SA')

			UNION ALL

			--Purchases Order
			SELECT DISTINCT purchase.DocumentDate, purchase.IdDocument, purchase.DocumentCode, purchase.IdStatus, purchase.DocumentStatus, purchase.DocumentHtPrice, tier.TiersName, tier.TiersCode, 'PU' AS [Type]
			FROM [Reporting].[FctPurchases] purchase WITH(NOLOCK)
			LEFT JOIN [Reporting].[DimTiers] tier WITH(NOLOCK) ON purchase.IdTiers=tier.IdTiers
			WHERE [DocumentTypeCode] IN ('FO-PU','D-PU','O-PU')

	)A


	GROUP BY 
	DocumentDate,
	YEAR(DocumentDate) , 
	MONTH(DocumentDate), 
	[Type], 
	DocumentCode, 
	IdDocument, 
	IdStatus, 
	DocumentStatus, 
	TiersName, 
	TiersCode

 
	--***********************************FINAL QUERY*************************************************--
	TRUNCATE TABLE [Reporting].[KPIOrderState]

	INSERT INTO [Reporting].[KPIOrderState]
			   ([DocumentDate]
			   ,[Year]
			   ,[Month]
			   ,[IdOrder]
			   ,[OrderCode]
			   ,[HtAmount]
			   ,[IdStatus]
			   ,[DocumentStatus]
			   ,[TiersName]
			   ,[TiersCode]
			   ,[Type])

	SELECT * FROM #Temp


	SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPIOrderStatus', @NbInserted, GETDATE(), @ErrorMessage



END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPIPaymentMethodPerClient]...';


GO
CREATE PROCEDURE [Reporting].[FeedKPIPaymentMethodPerClient] 
	
	--@SelectYear int= 2020,
	--@SelectMonth int=4

AS
BEGIN
	SET NOCOUNT ON;
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
BEGIN TRY	
			--*******************Load Data To Get Count payment method By tiers*************************--

   SELECT Year,
   Month,
   PaymentMethod,
   TotalCustomers

	INTO #temp

	FROM
	(
		SELECT 
			
				--tiers.TiersName AS TiersName,
				YEAR(fc.SettlementDate) AS Year,
				MONTH(fc.SettlementDate) AS Month,
				
				--Id,
				MethodName AS PaymentMethod,
				Count( distinct IdSettlement )  AS TotalCustomers
			
				--from #Settlement
				FROM [Reporting].[FctFinancialCommitment] fc WITH(NOLOCK)
				LEFT JOIN [Reporting].[DimTiers] tiers WITH(NOLOCK)
				ON tiers.IdTiers = fc.IdTiers
					LEFT JOIN [Reporting].[DimPayment] payment WITH(NOLOCK)
				ON payment.IdPaymentMethod = fc.Idpaymentmethod
	--WHERE 	YEAR([SettlementDate]) =  @SelectYear AND MONTH([SettlementDate])=@SelectMonth			--where TiersName is null
	WHERE 	YEAR(fc.SettlementDate) IS NOT NULL	
	GROUP BY
	--Id,
	--tiers.TiersName,
	MethodName,
	MONTH(SettlementDate),
	YEAR(SettlementDate)
	)A
	GROUP BY Year,Month,PaymentMethod,TotalCustomers
	--select * from #temp
	--DROP TABLE #temp
	--*********************************Final Query To Feed Table****************************************************--

	TRUNCATE TABLE [Reporting].[KPICandidaciesPerRecruitment]


	INSERT INTO [Reporting].[KPIPaymentMethodPerClient]
			   ([Year]
               ,[Month]
               ,[PaymentMethod]
               ,[PaymentMethodCurrentYear]
               ,[PaymentMethodLastMonth]
               ,[PaymentMethodLastYearLastMonth]
               ,[PaymentMethodLastYear]
               ,[PaymentMethodYearToDate]
               ,[PaymentMethodLastYearToDate])

	--SELECT * FROM #temp
	
 SELECT 
	
    Year,
	Month,
    PaymentMethod,
	SUM(CurrentAmount) AS PaymentMethodCurrentYear,
	--CurrentAmount AS PaymentMethodCurrentYear,
	ISNULL(SUM(LastMonthAmount),0) AS PaymentMethodLastMonth ,
	--LastMonthAmount AS PaymentMethodLastMonth ,

	ISNULL(SUM(DISTINCT LastMonthLastYearAmount),0) AS PaymentMethodLastYearLastMonth,
	ISNULL(SUM(DISTINCT lastYearAmount),0)AS PaymentMethodLastYear,
	ISNULL(SUM(DISTINCT yearToDateAmount),0) AS PaymentMethodYearToDate,
	ISNULL(SUM(DISTINCT LastYearToDateAmount),0) AS PaymentMethodLastYearToDate

	FROM
	(

	SELECT
	        mncurrenty.Year AS Year, 
	        mncurrenty.Month AS Month,
            mncurrenty.PaymentMethod AS PaymentMethod, 
            mncurrenty.TotalCustomers  AS CurrentAmount,
            mnlastm.TotalCustomers AS LastMonthAmount,
		    mnlastmlasty.TotalCustomers AS LastMonthLastYearAmount,
            mnlasty.TotalCustomers AS lastYearAmount,
		    SUM(DISTINCT mnytd.TotalCustomers) AS yearToDateAmount,
		    SUM(DISTINCT mnlastytd.TotalCustomers) AS LastYearToDateAmount
		
    FROM #temp mncurrenty WITH(NOLOCK)
    LEFT JOIN #temp mnlastm WITH(NOLOCK)
    on mncurrenty.Year = mnlastm.Year
	AND mncurrenty.Month = mnlastm.Month +1
	AND mncurrenty.PaymentMethod=mnlastm.PaymentMethod
    LEFT JOIN #temp mnlasty WITH(NOLOCK)
	ON mncurrenty.Year = mnlasty.Year +1 
	AND mncurrenty.Month = mnlasty.Month
    AND mncurrenty.PaymentMethod=mnlasty.PaymentMethod
	LEFT JOIN #temp mnytd WITH(NOLOCK)
	ON mncurrenty.Year = mnytd.Year 
	AND mnytd.Month <= mncurrenty.Month
    AND mnytd.PaymentMethod=mncurrenty.PaymentMethod
	LEFT JOIN #temp mnlastytd WITH(NOLOCK)
    ON mncurrenty.Year = mnlastytd.Year+1  
	AND mnlastytd.Month <=mnlasty.Month
  	AND mnlastytd.PaymentMethod=mncurrenty.PaymentMethod
	LEFT JOIN #temp mnlastmlasty WITH(NOLOCK)
    ON mncurrenty.Year = mnlastmlasty.Year +1
	AND mnlastmlasty.Month =month(DATEADD(month,-1,DATEFROMPARTS(mncurrenty.Year, mncurrenty.Month, 1)))
	AND mnlastmlasty.PaymentMethod=mncurrenty.PaymentMethod
	GROUP BY  mncurrenty.Year,
	mncurrenty.Month,
	mncurrenty.PaymentMethod,
	mncurrenty.TotalCustomers,
	mnlastm.TotalCustomers,
	mnlastmlasty.TotalCustomers,
    mnlasty.TotalCustomers
	
	)A
	--WHERE PaymentMethod=PaymentMethod
	 GROUP BY Year,Month,PaymentMethod
	 --,CurrentAmount
	 --,LastMonthAmount






	SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPIPaymentMethodPerClient', @NbInserted, GETDATE(), @ErrorMessage
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPIRetentionRate]...';


GO

CREATE PROCEDURE [Reporting].[FeedKPIRetentionRate]

AS
BEGIN

DECLARE @NbClient int, @NbCmd int
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

 BEGIN TRY

-------------Nombre des Clients--------------------
 DROP TABLE #TempNbClient
 SELECT 
    '1' AS Jointure,
    ID AS clients

    INTO #TempNbClient
    
    FROM
    (
    SELECT COUNT(*) AS ID 
	FROM [Reporting].[DimTiers] t WITH(NOLOCK)
    LEFT JOIN [Reporting].[DimAccount] a WITH(NOLOCK) ON t.IdAccount=a.AccountId
    WHERE t.TypeTiersLabel  like '%client%'
    )A
	
 -----------Nombre des commandes--------------------
 
     DROP TABLE #TempNbCmd
     SELECT 
    '1' AS Jointure,
     Code AS NbCmd,
     FiscalYear,
	 FiscalMonth
   
    INTO #TempNbCmd
    FROM
    (
    SELECT COUNT(a.AccountCode)  AS Code,
    YEAR(dal.DocumentAccountDate) AS FiscalYear,
	MONTH(dal.DocumentAccountDate) AS FiscalMonth
    FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
    LEFT JOIN [Reporting].[DimAccount] a WITH(NOLOCK) ON a.AccountId=dal.AccountIdAssociated 
    LEFT JOIN [Reporting].[DimJournal] jn WITH(NOLOCK) ON jn.journalID=dal.JournalId
    WHERE 
    a.AccountCode LIKE '41%'  AND  jn.JournalLabel LIKE '%vente%' 
    AND YEAR(dal.DocumentAccountDate)= YEAR(GETDATE()) 
    GROUP BY 
    AccountCode,
    YEAR(dal.DocumentAccountDate),
    MONTH(dal.DocumentAccountDate)
    )B
  
   GROUP BY Code, FiscalYear, FiscalMonth 


------------------Final Query-------------------
   TRUNCATE TABLE [Reporting].[KPIRetentionRate]
   INSERT INTO [Reporting].[KPIRetentionRate]
   (
 [Year]
,[Month]
,[RetentionRateCurrentYear]
,[RetentionRateLastMonth]
,[RetentionRateLastMonthLastYear]
,[RetentionRateLastYear]
,[RetentionRateYearToDate]
,[RetentionRateYearToDateLastYear]
   )

  SELECT
        NbCmdCurrentY.FiscalYear, 
        NbCmdCurrentY.FiscalMonth,
		ISNULL(((NbCmdCurrentY.NbCmd/NbClient.clients)*100),0) AS RetentionRateCY,
		ISNULL(((NbCmdLastM.NbCmd/NbClient.clients)*100),0) AS RetentionRateLM,
        ISNULL(((NbCmdLastY.NbCmd/NbClient.clients)*100),0) AS RetentionRateLY,
		ISNULL((NbCmdLastMLastY.NbCmd/NbClient.clients)*100,0) AS RetentionRateLMLY,
		ISNULL((NbCmdYTD.NbCmd/NbClient.clients)*100,0) AS RetentionRateYTD,
		ISNULL((NbCmdLastYTD.NbCmd/NbClient.clients)*100,0) AS RetentionRateLastYTD

        
    FROM #TempNbCmd NbCmdCurrentY
	LEFT JOIN #TempNbClient NbClient
    ON NbCmdCurrentY.Jointure=NbClient.Jointure
    LEFT JOIN #TempNbCmd NbCmdLastM
    ON NbCmdCurrentY.FiscalYear = NbCmdLastM.FiscalYear AND NbCmdCurrentY.FiscalMonth =NbCmdLastM.FiscalMonth +1
	LEFT JOIN #TempNbCmd NbCmdLastY
    ON NbCmdCurrentY.FiscalYear = NbCmdLastY.FiscalYear +1 AND NbCmdCurrentY.FiscalMonth = NbCmdLastY.FiscalMonth
	LEFT JOIN #TempNbCmd NbCmdYTD
    ON NbCmdYTD.FiscalYear = NbCmdLastY.FiscalYear +1 AND NbCmdYTD.FiscalMonth = NbCmdCurrentY.FiscalMonth
	LEFT JOIN #TempNbCmd NbCmdLastYTD
    ON NbCmdLastYTD.FiscalYear = NbCmdLastY.FiscalYear AND NbCmdLastYTD.FiscalMonth = NbCmdLastY.FiscalMonth
	LEFT JOIN #TempNbCmd NbCmdLastMLastY
    ON NbCmdLastMLastY.FiscalYear = NbCmdCurrentY.FiscalYear-1
    AND NbCmdLastMLastY.FiscalMonth= MONTH(DateADD(MONTH,-13,DATEFROMPARTS(NbCmdLastY.FiscalYear, NbCmdCurrentY.FiscalMonth, 1)))
 
    GROUP BY NbCmdCurrentY.NbCmd,NbCmdLastM.NbCmd,NbCmdLastY.NbCmd,NbCmdLastMLastY.NbCmd, NbCmdYTD.NbCmd,
	NbCmdLastYTD.NbCmd, NbClient.clients, NbCmdCurrentY.FiscalYear, NbCmdCurrentY.FiscalMonth



 SET @NbInserted = @@ROWCOUNT
END TRY
BEGIN CATCH 
SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 


----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPIRetentionRate', @NbInserted, GETDATE(), @ErrorMessage
    
    END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPISalesPerItem]...';


GO


CREATE PROCEDURE [Reporting].[FeedKPISalesPerItem]
AS 
BEGIN

DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
--*************************Select Data For Sales/Purchases Per Item*************************--
BEGIN TRY   
	SELECT 
	SUM(HtTotal) AS HTAmount,
	SUM(QuantityTotal) AS Quantity,
	IdItem, 
	ItemCode, 
	ItemDescription, 
	LabelItemFamily, 
	[Month], 
	[Year],
	[OperationType]
	INTO #Temp
	FROM
	(
	--******************************************Sales Per Item***************************************************--
	SELECT SUM(HtTotalLine) AS HtTotal, SUM(MovementQty) AS QuantityTotal, IdItem, ItemCode, ItemDescription,LabelItemFamily, [Month], [Year], 'SA' AS [OperationType]
	FROM (
			 SELECT SUM(sale.HtTotalLine) AS HtTotalLine, SUM(sale.ItemQuantity) AS MovementQty, item.IdItem, item.ItemCode, item.ItemDescription,item.LabelItemFamily ,sale.DocumentMonth AS [Month], sale.DocumentYear AS [Year]
			 FROM  [Reporting].[FctSales] sale WITH(NOLOCK)
			 LEFT JOIN [Reporting].[DimItem] item  WITH(NOLOCK) ON sale.IdItem=item.IdItem 
			 WHERE sale.DocumentTypeCode='D-SA'
			 GROUP BY item.IdItem, item.ItemCode, item.ItemDescription,item.LabelItemFamily ,sale.DocumentMonth, sale.DocumentYear

			 UNION ALL

			 SELECT SUM(sale.HtTotalLine) AS HtTotalLine, SUM(sale.ItemQuantity) AS MovementQty, item.IdItem, item.ItemCode, item.ItemDescription,item.LabelItemFamily ,sale.DocumentMonth AS [Month], sale.DocumentYear AS [Year]         FROM  [Reporting].[FctSales] sale
			 LEFT JOIN [Reporting].[DimItem] item  WITH(NOLOCK) ON sale.IdItem=item.IdItem
			 WHERE sale.DocumentTypeCode='BS-SA'
			 GROUP BY item.IdItem, item.ItemCode, item.ItemDescription,item.LabelItemFamily ,sale.DocumentMonth, sale.DocumentYear


			 UNION ALL

			 SELECT -SUM(sale.HtTotalLine) AS HtTotalLine, SUM(sale.ItemQuantity) AS MovementQty, item.IdItem, item.ItemCode, item.ItemDescription,item.LabelItemFamily ,sale.DocumentMonth AS [Month], sale.DocumentYear AS [Year]
			 FROM  [Reporting].[FctSales] sale WITH(NOLOCK)
			 LEFT JOIN [Reporting].[DimItem] item WITH(NOLOCK) ON sale.IdItem=item.IdItem
			 WHERE sale.DocumentTypeCode='A-SA'
			 GROUP BY item.IdItem, item.ItemCode, item.ItemDescription, item.LabelItemFamily,sale.DocumentMonth, sale.DocumentYear

	  )A
	GROUP BY IdItem, ItemCode, ItemDescription,LabelItemFamily ,[Month], [Year]

	UNION ALL

	--*************************************************Purchases Per Item**********************************************************--
	SELECT SUM(HtTotalLine) AS HtTotal, SUM(MovementQty) AS QuantityTotal, IdItem, ItemCode, ItemDescription, LabelItemFamily, [Month], [Year], 'PU' AS [OperationType]
	FROM (
			 SELECT SUM(purchase.HtTotalLine) AS HtTotalLine, SUM(purchase.ItemQuantity) AS MovementQty, item.IdItem, item.ItemCode, item.ItemDescription,item.LabelItemFamily ,purchase.DocumentMonth AS [Month], purchase.DocumentYear AS [Year]
			 FROM  [Reporting].[FctPurchases] purchase WITH(NOLOCK)
			 LEFT JOIN [Reporting].[DimItem] item WITH(NOLOCK) ON purchase.IdItem=item.IdItem
			 WHERE purchase.DocumentTypeCode='I-PU'
			 GROUP BY item.IdItem, item.ItemCode, item.ItemDescription, item.LabelItemFamily ,purchase.DocumentMonth, purchase.DocumentYear


			 UNION ALL

			 SELECT SUM(purchase.HtTotalLine) AS HtTotalLine, SUM(purchase.ItemQuantity) AS MovementQty, item.IdItem, item.ItemCode, item.ItemDescription,item.LabelItemFamily ,purchase.DocumentMonth AS [Month], purchase.DocumentYear AS [Year]
			 FROM  [Reporting].[FctPurchases] purchase WITH(NOLOCK)
			 LEFT JOIN [Reporting].[DimItem] item  WITH(NOLOCK) ON purchase.IdItem=item.IdItem
			 WHERE purchase.DocumentTypeCode='BE-PU'
			 GROUP BY item.IdItem, item.ItemCode, item.ItemDescription,item.LabelItemFamily,purchase.DocumentMonth, purchase.DocumentYear

			 UNION ALL

			 SELECT -SUM(purchase.HtTotalLine) AS HtTotalLine, SUM(purchase.ItemQuantity) AS MovementQty, item.IdItem, item.ItemCode, item.ItemDescription,item.LabelItemFamily,purchase.DocumentMonth AS [Month], purchase.DocumentYear AS [Year]
			 FROM  [Reporting].[FctPurchases] purchase WITH(NOLOCK)
			 LEFT JOIN [Reporting].[DimItem] item WITH(NOLOCK) ON purchase.IdItem=item.IdItem
			 WHERE purchase.DocumentTypeCode='A-PU'
			 GROUP BY item.IdItem, item.ItemCode, item.ItemDescription, item.LabelItemFamily,purchase.DocumentMonth, purchase.DocumentYear

	  )A

	GROUP BY IdItem, ItemCode, ItemDescription,LabelItemFamily, [Month], [Year]

	)B

	GROUP BY
	IdItem, 
	ItemCode, 
	ItemDescription,
	LabelItemFamily,
	[Month], 
	[Year],
	[OperationType]


	--***********************************FINAL QUERY*************************************************--
SELECT a.*,
	   ROW_NUMBER() OVER (PARTITION BY [OperationType], PeriodEnum ORDER BY HTAmount DESC) AS [RankByAmount],
	   ROW_NUMBER() OVER (PARTITION BY [OperationType], PeriodEnum ORDER BY Quantity DESC) AS [RankByQuantity]
INTO #final
FROM(
		SELECT  SUM(t.HTAmount) AS HTAmount,
				SUM(t.Quantity) AS Quantity,
				t.IdItem,
				t.ItemCode,
				t.ItemDescription,
				t.LabelItemFamily,
				t.OperationType,
				p.PeriodEnum,
				p.Period,
				p.StartPeriod,
				p.EndPeriod
		
		FROM #temp t
		CROSS JOIN Reporting.ParameterPeriod p 
		WHERE  HTAmount <> 0 
			AND  DATEFROMPARTS([Year], [Month], 1) BETWEEN p.StartPeriod AND p.EndPeriod
		GROUP BY IdItem, ItemCode, ItemDescription, LabelItemFamily, OperationType, PeriodEnum, Period, StartPeriod, EndPeriod
)a	

--****** insert statement

	TRUNCATE TABLE [Reporting].[KPISalesPerItem]

	INSERT INTO [Reporting].[KPISalesPerItem]
			   ([HtTotalPerItem]
			   ,[QuantityPerItem]
			   ,[IdItem]
			   ,[ItemCode]
			   ,[ItemDescription]
			   ,[LabelItemFamily]
			   ,[OperationType]
			   ,[PeriodEnum]
			   ,[Period]
			   ,[StartPeriod]
			   ,[EndPeriod]
			   ,[RankByAmount]
			   ,[RankByQuantity])


	SELECT * FROM #final


	SET @NbInserted = @@ROWCOUNT

END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPISalesPerItem', @NbInserted, GETDATE(), @ErrorMessage
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPISalesPerItemFamily]...';


GO


CREATE PROCEDURE [Reporting].[FeedKPISalesPerItemFamily]
AS 
BEGIN

DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

BEGIN TRY
--*************************Select Data For Sales/Purchases Per Item Family*************************--   
		SELECT 
	SUM(HtTotal) AS HTAmount,
	SUM(QuantityTotal) AS Quantity,
	LabelItemFamily, 
	[Month], 
	[Year],
	[OperationType]
	INTO #Temp
	FROM
	(
	--******************************************Sales Per Item***************************************************--
	SELECT SUM(HtTotalLine) AS HtTotal, SUM(MovementQty) AS QuantityTotal, LabelItemFamily, [Month], [Year], 'SA' AS [OperationType]
	FROM (
			 SELECT SUM(sale.HtTotalLine) AS HtTotalLine, SUM(sale.ItemQuantity) AS MovementQty, item.IdItem, item.ItemCode, item.ItemDescription,item.LabelItemFamily ,sale.DocumentMonth AS [Month], sale.DocumentYear AS [Year]
			 FROM  [Reporting].[FctSales] sale WITH(NOLOCK)
			 LEFT JOIN [Reporting].[DimItem] item  WITH(NOLOCK) ON sale.IdItem=item.IdItem 
			 WHERE sale.DocumentTypeCode='D-SA'
			 GROUP BY item.IdItem, item.ItemCode, item.ItemDescription,item.LabelItemFamily ,sale.DocumentMonth, sale.DocumentYear

			 UNION ALL

			 SELECT SUM(sale.HtTotalLine) AS HtTotalLine, SUM(sale.ItemQuantity) AS MovementQty, item.IdItem, item.ItemCode, item.ItemDescription,item.LabelItemFamily ,sale.DocumentMonth AS [Month], sale.DocumentYear AS [Year]         FROM  [Reporting].[FctSales] sale
			 LEFT JOIN [Reporting].[DimItem] item  WITH(NOLOCK) ON sale.IdItem=item.IdItem
			 WHERE sale.DocumentTypeCode='BS-SA'
			 GROUP BY item.IdItem, item.ItemCode, item.ItemDescription,item.LabelItemFamily ,sale.DocumentMonth, sale.DocumentYear


			 UNION ALL

			 SELECT -SUM(sale.HtTotalLine) AS HtTotalLine, SUM(sale.ItemQuantity) AS MovementQty, item.IdItem, item.ItemCode, item.ItemDescription,item.LabelItemFamily ,sale.DocumentMonth AS [Month], sale.DocumentYear AS [Year]
			 FROM  [Reporting].[FctSales] sale WITH(NOLOCK)
			 LEFT JOIN [Reporting].[DimItem] item WITH(NOLOCK) ON sale.IdItem=item.IdItem
			 WHERE sale.DocumentTypeCode='A-SA'
			 GROUP BY item.IdItem, item.ItemCode, item.ItemDescription, item.LabelItemFamily,sale.DocumentMonth, sale.DocumentYear

	  )A
	GROUP BY LabelItemFamily ,[Month], [Year]

	UNION ALL

	--*************************************************Purchases Per Item**********************************************************--
	SELECT SUM(HtTotalLine) AS HtTotal, SUM(MovementQty) AS QuantityTotal, LabelItemFamily, [Month], [Year], 'PU' AS [OperationType]
	FROM (
			 SELECT SUM(purchase.HtTotalLine) AS HtTotalLine, SUM(purchase.ItemQuantity) AS MovementQty, item.IdItem, item.ItemCode, item.ItemDescription,item.LabelItemFamily ,purchase.DocumentMonth AS [Month], purchase.DocumentYear AS [Year]
			 FROM  [Reporting].[FctPurchases] purchase WITH(NOLOCK)
			 LEFT JOIN [Reporting].[DimItem] item WITH(NOLOCK) ON purchase.IdItem=item.IdItem
			 WHERE purchase.DocumentTypeCode='I-PU'
			 GROUP BY item.IdItem, item.ItemCode, item.ItemDescription, item.LabelItemFamily ,purchase.DocumentMonth, purchase.DocumentYear


			 UNION ALL

			 SELECT SUM(purchase.HtTotalLine) AS HtTotalLine, SUM(purchase.ItemQuantity) AS MovementQty, item.IdItem, item.ItemCode, item.ItemDescription,item.LabelItemFamily ,purchase.DocumentMonth AS [Month], purchase.DocumentYear AS [Year]
			 FROM  [Reporting].[FctPurchases] purchase WITH(NOLOCK)
			 LEFT JOIN [Reporting].[DimItem] item  WITH(NOLOCK) ON purchase.IdItem=item.IdItem
			 WHERE purchase.DocumentTypeCode='BE-PU'
			 GROUP BY item.IdItem, item.ItemCode, item.ItemDescription,item.LabelItemFamily,purchase.DocumentMonth, purchase.DocumentYear

			 UNION ALL

			 SELECT -SUM(purchase.HtTotalLine) AS HtTotalLine, SUM(purchase.ItemQuantity) AS MovementQty, item.IdItem, item.ItemCode, item.ItemDescription,item.LabelItemFamily,purchase.DocumentMonth AS [Month], purchase.DocumentYear AS [Year]
			 FROM  [Reporting].[FctPurchases] purchase WITH(NOLOCK)
			 LEFT JOIN [Reporting].[DimItem] item WITH(NOLOCK) ON purchase.IdItem=item.IdItem
			 WHERE purchase.DocumentTypeCode='A-PU'
			 GROUP BY item.IdItem, item.ItemCode, item.ItemDescription, item.LabelItemFamily,purchase.DocumentMonth, purchase.DocumentYear

	  )A

	GROUP BY LabelItemFamily, [Month], [Year]

	)B

	GROUP BY
	LabelItemFamily,
	[Month], 
	[Year],
	[OperationType]


	--***********************************FINAL QUERY*************************************************--
SELECT a.*,
	   ROW_NUMBER() OVER (PARTITION BY [OperationType], PeriodEnum ORDER BY HTAmount DESC) AS [RankByAmount],
	   ROW_NUMBER() OVER (PARTITION BY [OperationType], PeriodEnum ORDER BY Quantity DESC) AS [RankByQuantity]
INTO #final
FROM(
		SELECT  SUM(t.HTAmount) AS HTAmount,
				SUM(t.Quantity) AS Quantity,
				t.LabelItemFamily,
				t.OperationType,
				p.PeriodEnum,
				p.Period,
				p.StartPeriod,
				p.EndPeriod
		
		FROM #temp t
		CROSS JOIN Reporting.ParameterPeriod p 
		WHERE  HTAmount <> 0 
			AND  DATEFROMPARTS([Year], [Month], 1) BETWEEN p.StartPeriod AND p.EndPeriod
		GROUP BY LabelItemFamily, OperationType, PeriodEnum, Period, StartPeriod, EndPeriod
)a	

--****** insert statement

	TRUNCATE TABLE [Reporting].[KPISalesPerItemFamily]

	INSERT INTO [Reporting].[KPISalesPerItemFamily]
			   ([HtTotalPerItemFamily]
			   ,[QuantityPerItemFamily]
			   ,[ItemFamily]
			   ,[OperationType]
			   ,[PeriodEnum]
			   ,[Period]
			   ,[StartPeriod]
			   ,[EndPeriod]
			   ,[RankByAmount]
			   ,[RankByQuantity])


	SELECT * FROM #final


	SET @NbInserted = @@ROWCOUNT
END TRY 


BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPISalesPerItemFamily', @NbInserted, GETDATE(), @ErrorMessage
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPISalesPurchaseState]...';


GO
CREATE PROCEDURE [Reporting].[FeedKPISalesPurchaseState]
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

INTO #temp_final

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


--cte all months in period
;WITH cte AS   
(  
    SELECT dt = DATEADD(DAY, -(DAY(StartPeriod) - 1), StartPeriod), StartPeriod, EndPeriod, PeriodEnum, Period
	FROM [Reporting].[ParameterPeriod]
    UNION ALL  
    SELECT DATEADD(MONTH, 1, dt), StartPeriod, EndPeriod, PeriodEnum, Period  
    FROM cte  
    WHERE dt < DATEADD(DAY, -(DAY(EndPeriod) - 1), EndPeriod)  
)  


SELECT PeriodEnum, Period, StartPeriod, EndPeriod, MONTH(dt) AS [Month], YEAR(dt) AS [Year]
INTO #ctePeriod
FROM cte

--final


SELECT *
INTO #final
FROM #temp_final tf
UNION ALL
SELECT 0, 0, 0, p.Month, p.Year, 'SA' AS type, p.PeriodEnum, p.Period, p.StartPeriod, p.EndPeriod
FROM #ctePeriod p
WHERE NOT EXISTS 
(
	SELECT month, year, type , periodenum 
	FROM #temp_final ff
	WHERE p.Month = ff.Month
	AND p.Year = ff.Year
	AND p.PeriodEnum = ff.PeriodEnum
	AND ff.Type = 'SA'
)
UNION ALL
SELECT 0, 0, 0, p.Month, p.Year, 'PU' AS type, p.PeriodEnum, p.Period, p.StartPeriod, p.EndPeriod
FROM #ctePeriod p
WHERE NOT EXISTS 
(
	SELECT month, year, type , periodenum 
	FROM #temp_final ff
	WHERE p.Month = ff.Month
	AND p.Year = ff.Year
	AND p.PeriodEnum = ff.PeriodEnum
	AND ff.Type = 'PU'
)


--select * 
--from #final
--where periodenum = 3 
--and type like'SA'


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
LEFT JOIN #FinaleLYTD f2 ON f1.Month=f2.Month AND f1.Month=f2.Month AND f1.Type=f2.Type AND f1.PeriodEnum=f2.PeriodEnum




--GROUP BY f1.InvoiceAmountHT,f1.InvoiceAmountTTC,f1.InvoiceRemainingAmount,f1.Month,f1.Year,f1.Type
--,f1.PeriodEnum, f1.Period, f1.StartPeriod, f1.EndPeriod,f1.YTDInvoiceAmountHT,f1.YTDInvoiceAmountTTC
--,f2.LYTDInvoiceAmountHT,f2.LYTDInvoiceAmountTTC







SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPISalesPurchaseState', @NbInserted, GETDATE(), @ErrorMessage

END





------------------------------- MAK delete RH card From S.P FeedCartes 03/09/2021------------------------------
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPISearchItems]...';


GO



CREATE PROCEDURE [Reporting].[FeedKPISearchItems]
AS
BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL

--Seach by item code
SELECT MONTH(Date) AS Month,
	   YEAR(Date) AS Year,
	   srch.Value AS SearchItemValue,
	   item.ItemCode,
	   item.ItemDescription,
	   COUNT(*) AS NumberSearched,
	   'Code' AS SearchMethod
INTO #temp
FROM [Reporting].[SearchLOG] srch WITH(NOLOCK)
LEFT JOIN (SELECT DISTINCT ItemCode,ItemDescription FROM [Reporting].DimItem ) item 
ON  srch.Value = item.ItemCode
WHERE srch.Property = 'reference'
GROUP BY MONTH(Date),
	     YEAR(Date),
	     srch.Value,
		 item.ItemCode,
	     item.ItemDescription


UNION ALL

--Search by item description
SELECT MONTH(Date) AS Month,
	   YEAR(Date) AS Year,
	   srch.Value AS SearchItemValue,
	   item.ItemCode,
	   item.ItemDescription,
	   COUNT(*) AS NumberSearched,
	   'Description' AS SearchMethod 
FROM [Reporting].[SearchLOG] srch WITH(NOLOCK)
LEFT JOIN (SELECT DISTINCT ItemCode,ItemDescription FROM [Reporting].DimItem ) item
ON  srch.Value = item.ItemCode
WHERE srch.Property = 'description'
GROUP BY MONTH(Date),
	     YEAR(Date),
	     srch.Value,
		 item.ItemCode,
	     item.ItemDescription


---FINAL QUERY---
BEGIN TRY
TRUNCATE TABLE [Reporting].[KPISearchItems]

INSERT INTO [Reporting].[KPISearchItems]
(
	Month,
	Year,
	SearchItemValue,
	ItemCode,
	ItemDescription,
	NumberSearched,
	SearchMethod,
	[Rank]
)

SELECT *, ROW_NUMBER() OVER(PARTITION BY Month, Year, SearchMethod ORDER BY NumberSearched desc) AS [Rank]
FROM #temp
SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPISearchItems', @NbInserted, GETDATE(), @ErrorMessage

END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPITopTiers]...';


GO

CREATE PROCEDURE [Reporting].[FeedKPITopTiers]
 

AS
BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
--*************************Select Data For Top Tiers (Client/Supplier)*************************--

BEGIN TRY
	SELECT 	
			null as DocumentDate,
			DocumentMonth,
			DocumentYear,
			IdTiers, 
			TiersName, 
			TiersCode, 
			SUM(DocumentHTPrice) AS HTAmount,
			SUM(DocumentTTCPrice) AS TTCAmount,
			SUM(Quantity) AS [Quantity],
			[Type]
		
	INTO #temp
	FROM(

			-- Client
			SELECT DISTINCT sale.IdDocument, sale.DocumentMonth, sale.DocumentYear, sale.IdTiers, tier.TiersName, tier.TiersCode, sale.DocumentHTPrice,sale.DocumentTTCPrice, SUM(sale.ItemQuantity) AS Quantity, 'SA' AS [Type]
			FROM [Reporting].[FctSales] sale WITH(NOLOCK)
			LEFT JOIN [Reporting].[DimTiers] tier WITH(NOLOCK)  ON tier.IdTiers=sale.IdTiers
			WHERE DocumentTypeCode='I-SA'
			GROUP BY sale.IdDocument, sale.DocumentMonth, sale.DocumentYear, sale.IdTiers, tier.TiersName, tier.TiersCode, sale.DocumentHTPrice,sale.DocumentTTCPrice

			UNION ALL

			-- Fournisseur
			SELECT DISTINCT purchase.IdDocument, purchase.DocumentMonth, purchase.DocumentYear, purchase.IdTiers, tier.TiersName, tier.TiersCode, purchase.DocumentHTPrice, purchase.DocumentTTCPrice, SUM(purchase.ItemQuantity) AS Quantity, 'PU' AS [Type]
			FROM [Reporting].FctPurchases purchase WITH(NOLOCK)
			LEFT JOIN [Reporting].[DimTiers] tier WITH(NOLOCK) ON tier.IdTiers=purchase.IdTiers
			WHERE DocumentTypeCode='I-PU'
			GROUP BY purchase.IdDocument, purchase.DocumentMonth, purchase.DocumentYear, purchase.IdTiers, tier.TiersName, tier.TiersCode, purchase.DocumentHTPrice, purchase.DocumentTTCPrice
		
	)A
	--where idtiers = 1506

	GROUP BY --DocumentDate, 
	DocumentMonth, DocumentYear,IdTiers, TiersName, TiersCode, [Type]




	
	select --DocumentMonth, DocumentYear, 
	IdTiers, TiersName, TiersCode, SUM(HTAmount) AS HTAmount, SUM(TTCAmount) AS TTCAmount, SUM(Quantity) Quantity, Type, PeriodEnum, Period, StartPeriod, EndPeriod
	into #f
	from (
	select t.*, p.PeriodEnum, p.Period, p.StartPeriod, p.EndPeriod 
	from #temp t
	cross join Reporting.ParameterPeriod p
	) e
	where DATEFROMPARTS(DocumentYear, DocumentMonth, 1) between StartPeriod and EndPeriod
	group by   IdTiers, TiersName, TiersCode,  Type, PeriodEnum, Period, StartPeriod, EndPeriod


	--***********************************FINAL QUERY*************************************************--
	TRUNCATE TABLE [Reporting].[KPITopTiers]

	INSERT INTO [Reporting].[KPITopTiers]
			   ([IdTiers]
			   ,[TiersName]
			   ,[TiersCode]
			   ,[HTAmount]
			   ,[TTCAmount]
			   ,[Quantity]
			   ,[Type]
			   ,[PeriodEnum]
			   ,[Period]
			   ,[StartPeriod]
			   ,[EndPeriod]
			   ,[RankByTTCAmount]
			   ,[RankByQuantity]
				)

	-------old with month and year
	--SELECT *, ROW_NUMBER() OVER ( PARTITION BY DocumentMonth, DocumentYear, [Type] ORDER BY [Amount] DESC) AS [RankByAmount]
	--		, ROW_NUMBER() OVER ( PARTITION BY DocumentMonth, DocumentYear, [Type] ORDER BY [Quantity] DESC) AS [RankByQuantity]
	--FROM #temp

	SELECT *, ROW_NUMBER() OVER ( PARTITION BY  PeriodEnum, [Type] ORDER BY [TTCAmount] DESC) AS [RankByTTCAmount],
		      ROW_NUMBER() OVER ( PARTITION BY  PeriodEnum, [Type] ORDER BY [Quantity] DESC) AS [RankByQuantity]
	FROM #f



	SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPITopTiers', @NbInserted, GETDATE(), @ErrorMessage
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPITotalDepreciationPerAccount]...';


GO

 

CREATE PROCEDURE [Reporting].[FeedKPITotalDepreciationPerAccount]

AS
BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
--*************************Select Data For Depreciation*************************--  
BEGIN TRY

SELECT

SUM(Amount) AS DepreciationAmount,
Month,
Year,
AccountLabel

INTO #temp

FROM

(SELECT 

	SUM(dal.[DocumentAccountLineDebitAmount]) AS Amount,
	MONTH(dal.DocumentAccountDate) AS Month,
	YEAR(dal.DocumentAccountDate) AS Year,
	a.AccountLabel

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	WHERE a.AccountCode LIKE '68%'


	GROUP BY 
	MONTH(dal.DocumentAccountDate),
	YEAR(dal.DocumentAccountDate),
	a.AccountLabel

UNION ALL

SELECT 

	SUM(dal.[DocumentAccountLineCreditAmount]) AS Amount,
	MONTH(dal.DocumentAccountDate) AS Month,
	YEAR(dal.DocumentAccountDate) AS Year,
	a.AccountLabel

	FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
	LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
	WHERE a.AccountCode LIKE '28%'
	

	GROUP BY 
	MONTH(dal.DocumentAccountDate),
	YEAR(dal.DocumentAccountDate),
	a.AccountLabel


)A

GROUP BY 
Month,
Year,
AccountLabel

--**Toal Depreiation**--

SELECT 
	Year,
	Month,
	AccountLabel,
	ISNULL(SUM(DISTINCT CurrentAmount),0) AS CurrentDepreciationAmount,
	ISNULL(SUM(DISTINCT LastMonthAmount),0)AS LastMonthDepreciationAmount,
	ISNULL(SUM(DISTINCT LastYearAmount),0) AS LastYearDepreciationAmount,
	ISNULL(SUM(DISTINCT LastMonthLastYearAmount),0) AS LastMonthLastYearDepreciationAmount,
	ISNULL(SUM(DISTINCT YearToDateAmount),0) AS YearToDateDepreciationAmount,
	ISNULL(SUM(DISTINCT LastYearYearToDateAmount),0) AS LastYearYearToDateDepreciationAmount,
	SUM(DISTINCT VariationCurrentLMonthLastMonthAmount) AS VariationCurrentLMonthLastMonthDepreciationAmount,
	SUM(DISTINCT VariationCurrentYearLastYearAmount) AS VariationCurrentYearLastYearDepreciationAmount,
	SUM(DISTINCT VariationCurrentYearLastYearAmount) AS VariationYearToDateLastYearToDateDepreciationAmount

	INTO #TempDep

	FROM
	(
	
	
	SELECT  
	
	t2.Year,
    t2.Month,
	t2.AccountLabel,
    t2.DepreciationAmount AS CurrentAmount,
    lm2.DepreciationAmount AS LastMonthAmount,
    ly2.DepreciationAmount AS LastYearAmount,
	lmly2.DepreciationAmount AS LastMonthLastYearAmount,
	SUM(DISTINCT ytd2.DepreciationAmount) AS YearToDateAmount,
	SUM(DISTINCT lytd2.DepreciationAmount) AS LastYearYearToDateAmount,
	ISNULL(((t2.DepreciationAmount-lm2.DepreciationAmount)/NULLIF(lm2.DepreciationAmount,0))*100,0) AS VariationCurrentLMonthLastMonthAmount,
	ISNULL(((t2.DepreciationAmount-ly2.DepreciationAmount)/NULLIF(ly2.DepreciationAmount,0))*100,0)AS VariationCurrentYearLastYearAmount,
	ISNULL(((ytd2.DepreciationAmount-lytd2.DepreciationAmount)/NULLIF(lytd2.DepreciationAmount,0))*100,0) AS VariationYearToDateLastYearToDateAmount
    
	FROM #Temp t2
    LEFT JOIN #Temp lm2 ON t2.Year = lm2.Year AND t2.Month =month(DATEADD(month,1,DATEFROMPARTS(lm2.year, lm2.month, 1)))
    LEFT JOIN #Temp ly2 ON t2.Year = ly2.Year +1 AND t2.Month = ly2.Month
	LEFT JOIN #Temp lmly2 ON t2.Year = lmly2.Year +1 AND lmly2.Month =month(DATEADD(month,-1,DATEFROMPARTS(t2.year, t2.month, 1)))
    LEFT JOIN #Temp ytd2 ON t2.Year = ytd2.Year AND ytd2.Month <= t2.Month
	LEFT JOIN #Temp lytd2 ON t2.Year = lytd2.Year+1  AND lytd2.Month <=ly2.Month
	
	GROUP BY 
	t2.Year,
    t2.Month, 
	t2.AccountLabel,
    t2.DepreciationAmount,
    lm2.DepreciationAmount,
    ly2.DepreciationAmount,
	lmly2.DepreciationAmount,
	lytd2.DepreciationAmount,
	ytd2.DepreciationAmount

)B

GROUP BY Year,Month,AccountLabel


	--***********************************FINAL QUERY*************************************************--
	TRUNCATE TABLE [Reporting].[KPITotalDepreciationPerAccount]
	
	INSERT INTO [Reporting].[KPITotalDepreciationPerAccount]
           ([Year]
           ,[Month]
           ,[AccountLabel]
           ,[CurrentDepreciationAmount]
           ,[LastMonthDepreciationAmount]
           ,[LastYearDepreciationAmount]
           ,[LastMonthLastYearDepreciationAmount]
           ,[YearToDateDepreciationAmount]
           ,[LastYearYearToDateDepreciationAmount]
           ,[VariationCurrentLMonthLastMonthDepreciationAmount]
           ,[VariationCurrentYearLastYearDepreciationAmount]
           ,[VariationYearToDateLastYearToDateDepreciationAmount])

	SELECT * FROM #TempDep


	SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPIDepreciationPerAccount', @NbInserted, GETDATE(), @ErrorMessage



END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPITotalGrossPayroll]...';


GO

CREATE PROCEDURE [Reporting].[FeedKPITotalGrossPayroll]
	
AS
BEGIN
	
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
BEGIN TRY
	--*********************Select Data To Load In KPITotalGrossPayroll**************************************--

	TRUNCATE TABLE [Reporting].[KPITotalGrossPayroll]

	INSERT INTO [Reporting].[KPITotalGrossPayroll]
			   ([Month]
			   ,[Year]
			   ,[TotalGrossPayroll])

	SELECT

		MONTH(StartDate) AS Month,
		YEAR(EndDate) AS Year,
		SUM(Gain) AS TotalEmployerCharge

	 FROM [Reporting].[FctPayslip] WITH(NOLOCK)

	 WHERE SalaryRuleDescription='SALAIRE BRUT'

	GROUP BY MONTH(StartDate),YEAR(EndDate) 
	SET @NbInserted = @@ROWCOUNT
END TRY
	
BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPITotalGrossPayroll', @NbInserted, GETDATE(), @ErrorMessage

END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPITotalPremium]...';


GO

CREATE PROCEDURE [Reporting].[FeedKPITotalPremium]
AS
BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
BEGIN TRY

--*****************************Select Data To Load In KPITotalPremium**********************************--

		SELECT *

		INTO #Temp

		FROM

		(
			SELECT
			MONTH(StartDate) AS Month,
			YEAR(StartDate) AS Year,
			SUM(Gain) AS TotalPremium

			FROM [Reporting].[FctPayslip] WITH(NOLOCK)

			WHERE IdBonus IS NOT NULL

			GROUP BY MONTH(StartDate),YEAR(StartDate)

		)A


	--**************************************Final Query*********************************************--
	TRUNCATE TABLE [Reporting].[KPITotalPremium]

	INSERT INTO [Reporting].[KPITotalPremium]
			   ([Month]
			   ,[Year]
			   ,[TotalPremium])

	SELECT * FROM #Temp
		SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPITotalPremium', @NbInserted, GETDATE(), @ErrorMessage
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedKPITunoverPerSales]...';


GO

CREATE PROCEDURE [Reporting].[FeedKPITunoverPerSales]

AS
BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
BEGIN TRY

------------------Turnover---------------------------

    DROP TABLE #TempCA

	SELECT 
 
	'1' AS Jointure,
	FiscalYear,
	FiscalMonth,
    SUM(Amount) AS  CA
	
	INTO #TempCA
    FROM
    (

    SELECT

    ISNULL(SUM(dal.[DocumentAccountLineCreditAmount]),0) AS Amount,
	YEAR(dal.[DocumentAccountDate]) AS FiscalYear,
	MONTH(dal.[DocumentAccountDate]) AS FiscalMonth
    FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
    LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
    WHERE a.AccountCode like  '70%' AND YEAR(dal.[DocumentAccountDate])=YEAR(GETDATE())-1 
  
    GROUP BY YEAR(dal.DocumentAccountDate), MONTH(dal.DocumentAccountDate)
			 
		
    UNION ALL

    --D�duction des rabais,remises et ristournes accord�s par l'entreprise pour la vente (Compte 709)
    SELECT

    -ISNULL(SUM(dal.[DocumentAccountLineCreditAmount]),0) AS Amount,
	YEAR(dal.[DocumentAccountDate]),
	MONTH(dal.[DocumentAccountDate])
    FROM [Reporting].[FctDocumentAccountLine] dal WITH(NOLOCK)
    LEFT JOIN [Reporting].[DimAccount] a  WITH(NOLOCK) ON a.AccountId=dal.[AccountIdAssociated]
 
    WHERE a.AccountCode like '709%' AND YEAR(dal.[DocumentAccountDate])=YEAR(GETDATE())-1

    GROUP BY YEAR(dal.[DocumentAccountDate]), MONTH(dal.[DocumentAccountDate])
        
    )A

    GROUP BY FiscalYear,
			 FiscalMonth

----------------------NbVente------------------------------------
DROP TABLE #TempNbVente
SELECT 

'1' AS Jointure,
FiscalYear,
FiscalMonth,
COUNT(code) as nbvente

INTO #TempNbVente
FROM
(
SELECT
da.DocumentAccountCode AS code,
YEAR(da.DocumentAccountDate) AS FiscalYear,
MONTH(da.DocumentAccountDate) AS FiscalMonth
	
FROM  [Reporting].[FctDocumentAccountLine] da WITH(NOLOCK)
LEFT JOIN [Reporting].[DimAccount] a WITH(NOLOCK) ON a.AccountId=da.DocumentAccountLineId
LEFT JOIN  [Reporting].[DimJournal] jn WITH(NOLOCK) ON jn.journalID=da.JournalId


WHERE jn.JournalLabel IN ('Vente') AND da.DocumentAccountLabel  LIKE 'FAC%' 


)A
GROUP BY FiscalYear,
         FiscalMonth
         
----------------Final Query-----------------------
TRUNCATE TABLE [Reporting].[KPITurnoverPerSales]
	
INSERT INTO [Reporting].[KPITurnoverPerSales]
([Year]
,[Month]
,[TurnoverPerSalesCurrentYear]
,[TurnoverPerSalesLastMonth]
,[TurnoverPerSalesLastMonthLastYear]
,[TurnoverPerSalesLastYear]
,[TurnoverPerSalesYearToDate]
,[TurnoverPerSalesYearToDateLastYear])


	--Chiffre d'affaire--
	    SELECT 
	
	    CaCurrentY.FiscalYear AS FiscalYear, 
        CaCurrentY.FiscalMonth AS FiscalMonth, 
        ISNULL((CaCurrentY.CA / NbVente.nbvente),0) AS CurrentTurnoverPerSales,
        ISNULL((CaLastM.CA / NbVente.nbvente),0) AS LastMonthTurnoverPerSales,
		ISNULL((CaLastMlastY.CA / NbVente.nbvente),0) AS LastMonthLastYearTurnoverPerSales,
        ISNULL((CaLastY.CA / NbVente.nbvente),0) AS lastYearTurnoverPerSales,
	    ISNULL((CaYTD.CA / NbVente.nbvente),0) AS yearToDateTurnoverPerSales,
		ISNULL((CaLastYTD.CA / NbVente.nbvente),0) AS LastYearToDateTurnoverPerSales
		

    FROM #TempCA CaCurrentY
    LEFT JOIN #TempNbVente NbVente
    ON CaCurrentY.FiscalYear = NbVente.FiscalYear
	AND CaCurrentY.FiscalMonth =NbVente.FiscalMonth +1
	LEFT JOIN #TempCA CaLastM
    ON CaCurrentY.FiscalYear = CaLastM.FiscalYear AND CaCurrentY.FiscalMonth =CaLastM.FiscalMonth +1
    LEFT JOIN #TempCA CaLastY
    ON CaCurrentY.FiscalYear = CaLastY.FiscalYear +1 AND CaCurrentY.FiscalMonth = CaLastY.FiscalMonth
    LEFT JOIN #TempCA CaYTD
    ON CaYTD.FiscalYear = CaLastY.FiscalYear +1
	AND CaYTD.FiscalMonth	<= CaCurrentY.FiscalMonth
    LEFT JOIN #TempCA CaLastYTD
    ON CaLastYTD.FiscalYear = CaLastY.FiscalYear
	AND CaLastYTD.FiscalMonth <= CaLastY.FiscalMonth
  	LEFT JOIN #TempCA CaLastMlastY
    ON CaLastMlastY.FiscalYear = CaCurrentY.FiscalYear-1
	AND   CaLastMlastY.FiscalMonth= MONTH(DateADD(MONTH,-13,DATEFROMPARTS(CaLastY.FiscalYear, CaCurrentY.FiscalMonth, 1)))  

	GROUP BY NbVente.nbvente, CaCurrentY.CA, CaLastM.CA, CaLastMlastY.CA, CaLastY.CA, CaYTD.CA, 
	CaLastYTD.CA, CaCurrentY.FiscalYear ,CaCurrentY.FiscalMonth
	ORDER BY FiscalYear,FiscalMonth

SET @NbInserted = @@ROWCOUNT
END TRY
BEGIN CATCH 
SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'KPITurnoverPerSales', @NbInserted, GETDATE(), @ErrorMessage

END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedParameterPeriod]...';


GO

CREATE PROCEDURE [Reporting].[FeedParameterPeriod]
AS
BEGIN

TRUNCATE TABLE [Reporting].[ParameterPeriod]

DECLARE @FirstDayCurrentMonth DATE = CAST(DATEADD(m, DATEDIFF(m, 0, GETDATE()), 0) AS DATE),
		@LastDayCurrentMonth DATE = CAST(EOMONTH(GETDATE()) AS DATE),

		@FirstDayPreviousMonth DATE = CAST(DATEADD(m, DATEDIFF(m, 0, GETDATE()) -1, 0) AS DATE),
		@LastDayPreviousMonth DATE = CAST(DATEADD(DAY, -(DAY(GETDATE())), GETDATE()) AS DATE),

		@FirstDayPreviousSixMonth DATE = CAST(DATEADD(m, DATEDIFF(m, 0, DATEADD(m,-5,GETDATE())) , 0) AS DATE),

		@FirstDayCurrentYear DATE = CAST(DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0) AS DATE),

		@FirstDayPreviousYear DATE = CAST(DATEADD(yy, DATEDIFF(yy, 0, DATEADD(yy,-1,GETDATE())), 0) AS DATE),
		@LastDayPreviousYear DATE = CAST(DATEADD(yy, DATEDIFF(yy, 0, DATEADD(yy,-1,GETDATE())) + 1, -1) AS DATE)



INSERT INTO [Reporting].[ParameterPeriod]
           ([PeriodEnum]
           ,[Period]
           ,[StartPeriod]
           ,[EndPeriod])
SELECT 1 AS PeriodEnum,
	   'CurrentMonth' AS [Period],
	   @FirstDayCurrentMonth AS StartPeriod,
	   @LastDayCurrentMonth AS EndPeriod

UNION ALL

SELECT 2 AS PeriodEnum,
	   'LastMonth' AS [Period],
	   @FirstDayPreviousMonth AS StartPeriod,
	   @LastDayPreviousMonth AS EndPeriod

UNION ALL

SELECT 3 AS PeriodEnum,
	   'LastSixMonth' AS [Period],
	   @FirstDayPreviousSixMonth AS StartPeriod,
	   @LastDayCurrentMonth AS EndPeriod

UNION ALL

SELECT 4 AS PeriodEnum,
	   'CurrentYear' AS [Period],
	   @FirstDayCurrentYear AS StartPeriod,
	   @LastDayCurrentMonth AS EndPeriod

UNION ALL

SELECT 5 AS PeriodEnum,
	   'LastYear' AS [Period],
	   @FirstDayPreviousYear AS StartPeriod,
	   @LastDayPreviousYear AS EndPeriod



END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedParameterReference]...';


GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE   [Reporting].[FeedParameterReference]
AS
BEGIN

TRUNCATE TABLE [Reporting].[ParameterReference]

INSERT INTO [Reporting].[ParameterReference] ( Reference, Code, LabelFr, LabelEng )

--expense report

SELECT 'Expense Report' AS Reference, '1' AS Code, 'En attente' AS LabelFr, 'Waiting' AS LabelEng
UNION ALL
SELECT 'Expense Report' AS Reference, '2' AS Code, 'Accept�' AS LabelFr, 'Accepted' AS LabelEng
UNION ALL
SELECT 'Expense Report' AS Reference, '3' AS Code, 'Refus�' AS LabelFr, 'Refused' AS LabelEng

UNION ALL --document

SELECT 'Document' AS Reference, '1' AS Code, 'En attente' AS LabelFr, 'Waiting' AS LabelEng
UNION ALL
SELECT 'Document' AS Reference, '2' AS Code, 'Accept�' AS LabelFr, 'Accepted' AS LabelEng
UNION ALL
SELECT 'Document' AS Reference, '3' AS Code, 'Refus�' AS LabelFr, 'Refused' AS LabelEng

UNION ALL --session

SELECT 'Pay Session' AS Reference, '1' AS Code, 'Nouvelle' AS LabelFr, 'New' AS LabelEng
UNION ALL
SELECT 'Pay Session' AS Reference, '2' AS Code, 'Pr�sence' AS LabelFr, 'Presence' AS LabelEng
UNION ALL
SELECT 'Pay Session' AS Reference, '3' AS Code, 'Prime' AS LabelFr, 'Bonus' AS LabelEng
UNION ALL
SELECT 'Pay Session' AS Reference, '4' AS Code, 'Bulletn De Paie' AS LabelFr, 'Payslip' AS LabelEng
UNION ALL
SELECT 'Pay Session' AS Reference, '5' AS Code, 'Ferm�' AS LabelFr, 'Closed' AS LabelEng

UNION ALL --Financial Commitment

SELECT 'Financial Commitment' AS Reference, '1' AS Code, 'Sold�' AS LabelFr, 'Sold' AS LabelEng
UNION ALL
SELECT 'Financial Commitment' AS Reference, '2' AS Code, 'Partiellement sold�' AS LabelFr, 'Partially Sold' AS LabelEng
UNION ALL
SELECT 'Financial Commitment' AS Reference, '3' AS Code, 'Non sold�' AS LabelFr, 'Non Solded' AS LabelEng

UNION ALL --payment method


SELECT 'Payment Method' AS Reference, 'VIR' AS Code , 'Virement' AS LabelFr , 'Transfer' AS LabelEng
UNION ALL
SELECT 'Payment Method' AS Reference, 'ESP' AS Code, 'Esp�ce' AS LabelFr , 'Currency' AS LabelEng
UNION ALL
SELECT 'Payment Method' AS Reference, 'CB' AS Code, 'Carte Bancaire' AS LabelFr , 'Bank Card' AS LabelEng
UNION ALL
SELECT 'Payment Method' AS Reference, 'CHQ' AS Code, 'Ch�que' AS LabelFr , 'Check' AS LabelEng
UNION ALL
SELECT 'Payment Method' AS Reference, 'TRT' AS Code, 'Traite' AS LabelFr , 'Treaty' AS LabelEng
UNION ALL
SELECT 'Payment Method' AS Reference, 'EXT BANCAIRE' AS Code, 'Extrait Bancaire' AS LabelFr , 'Banking receipt
' AS LabelEng



UNION ALL --payment status

SELECT 'Payment Status' AS Reference, 'NotCashed' AS Code , 'Non encaiss�' AS LabelFr , 'Not Cashed' AS LabelEng
UNION ALL
SELECT 'Payment Status' AS Reference, 'Cashed' AS Code , 'Encaiss�' AS LabelFr , 'Cashed' AS LabelEng
UNION ALL
SELECT 'Payment Status' AS Reference, 'Unpaid' AS Code , 'Impay�' AS LabelFr , 'Unpaid' AS LabelEng


UNION ALL --reportline status

SELECT 'reportline status' AS Reference, 'BS' AS Code , 'Bilan' AS LabelFr , 'Review' AS LabelEng
UNION ALL
SELECT 'reportline status' AS Reference, 'SOI' AS Code , 'Etat des r�sultats' AS LabelFr , 'Income statement' AS LabelEng
UNION ALL
SELECT 'reportline status' AS Reference, 'CIB' AS Code , 'Balance interm�diaires commerciales' AS LabelFr , 'Intermediate trade balance' AS LabelEng
UNION ALL
SELECT 'reportline status' AS Reference, 'IIB' AS Code , 'Balance interm�diaires industrielles' AS LabelFr , 'Industrial intermediate scales' AS LabelEng
UNION ALL
SELECT 'reportline status' AS Reference, 'CF' AS Code , 'Flux de tr�sorerie' AS LabelFr , 'Cash flow' AS LabelEng
UNION ALL
SELECT 'reportline status' AS Reference, 'CFA' AS Code , 'Flux de tr�sorerie annexe' AS LabelFr , 'Ancillary cash flow' AS LabelEng



UNION ALL --documentaccount status

SELECT 'documentaccount status' AS Reference, '0' AS Code , 'Ins�rtion Manuelle' AS LabelFr , 'Manual Insertion' AS LabelEng
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
SELECT 'Intervention status' AS Reference, '3' AS Code, 'Termin�e' AS LabelFr, 'Completed' AS LabelEng

 
 

END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[FeedSearchLOG]...';


GO


CREATE PROCEDURE [Reporting].[FeedSearchLOG]

AS
BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
BEGIN TRY	

	TRUNCATE TABLE [Reporting].[SearchLOG]



	SELECT A.*, 
			 REPLACE(REPLACE(REPLACE(value, '{', ''), '}', ''), '"', '') v1, 
		   ROW_NUMBER() OVER(PARTITION BY [Id], [SearchMethod] ORDER BY [SearchMethod]) rn1
	INTO #t1
	FROM (
			SELECT [Id]
				  ,[IdTiers]
				  ,[Date]
				  ,REPLACE((REPLACE(REPLACE([SearchMethod], '},{', '}*{') , '[', '')), ']', '') [SearchMethod]
				  ,[IdCashier]
				  ,[IsDeleted]
				  ,[TransactionUserId]
				  ,[Deleted_Token]
			FROM [Sales].[SearchItem] WITH(NOLOCK)
			--where id =2644
	) A
	CROSS APPLY STRING_SPLIT([SearchMethod], '*') AS BK


	;
	WITH Cte AS(
	SELECT t1.*, value v2, ROW_NUMBER() OVER(PARTITION BY [Id], v1 ORDER BY [SearchMethod]) rn2
	FROM #t1 t1
	CROSS APPLY STRING_SPLIT(v1, ',')
	WHERE rn1>1
	)

	SELECT Id, IdTiers, Date, IdCashier, [1] AS [Property], [2] AS [Value]
	INTO #t2
	FROM Cte
	PIVOT (
			MAX (v2) FOR rn2 IN ([1], [2]) 
			) pvt

	---final query---

	INSERT INTO [Reporting].[SearchLOG] ( Id, IdTiers, Date, IdCashier, Property, [Value])


	SELECT *
	FROM (
			SELECT Id, 
				   IdTiers, 
				   Date, 
				   IdCashier, 
				   REPLACE(Property, 'property:', '') AS Property , 
				   REPLACE(Value, 'value:', '') AS [Value]
			FROM #t2
	) f
	WHERE [Value] <> '' AND [Value] IS NOT NULL

	--drop table #t1
	--drop table #t2
	SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'SearchLOG', @NbInserted, GETDATE(), @ErrorMessage
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetCartes]...';


GO

CREATE PROCEDURE [Reporting].[GetCartes]

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
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetExportSalesFileExcel]...';


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Reporting].[GetExportSalesFileExcel]

	 @Period tinyint= 4
AS
BEGIN

DECLARE @StartPeriod date, @EndPeriod date

	SET @StartPeriod = (SELECT StartPeriod FROM [Reporting].[ParameterPeriod] WHERE PeriodEnum = @Period) 
	SET @EndPeriod = (SELECT EndPeriod FROM [Reporting].[ParameterPeriod] WHERE PeriodEnum = @Period) 




----FINAL QUERY--

SELECT * , @Period As PeriodEnum
FROM [Reporting].[FctSales] WITH(NOLOCK)
WHERE DocumentDate BETWEEN @StartPeriod AND @EndPeriod




----FINAL QUERY--

--SELECT *
--FROM(
--		SELECT t.*, ROW_NUMBER() OVER (PARTITION BY PeriodEnum ORDER BY DocumentHtPrice DESC) AS [Rank]
--		FROM #temp t
--)A
--WHERE [Rank] <= @NumberOfRows OR @NumberOfRows IS NULL
    
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPIAmountsPerImmobilisation]...';


GO

CREATE PROCEDURE [Reporting].[GetKPIAmountsPerImmobilisation]

--Parameters

 @FiscalYear nvarchar(255)= '2019'

AS
BEGIN



--**************************Select Statement To Load Data*******************************************--

	SELECT * FROM [Reporting].[KPIAmountsPerImmobilisation]
	WHERE [Year]=@FiscalYear



END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPIAverageRevenuePerCustomer]...';


GO

CREATE PROCEDURE [Reporting].[GetKPIAverageRevenuePerCustomer]

--Parameters

 @FiscalYear nvarchar(255)= '2019'

AS
BEGIN



--**************************Select Statement To Load Data*******************************************--

SELECT	SUM(a.CA)/a.CustomerNumber AS AverageRevenuePerClient,
a.FiscalYear
  FROM [Reporting].[KPIAverageRevenuePerCustomer]a
  GROUP BY a.CustomerNumber ,
  a.FiscalYear




END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPIClaimsPerProduct]...';


GO

CREATE PROCEDURE [Reporting].[GetKPIClaimsPerProduct]

--Parameters

 @Year int = 2020 ,
 @Month int = 2,
 @ClaimType nvarchar(255) = 'manque'

AS
BEGIN



--**************************Select Statement To Load Data*******************************************--
SELECT * FROM [Reporting].[KPIClaimsPerProduct] WITH(NOLOCK)
	WHERE MONTH(DocumentDate)=@Month AND YEAR(DocumentDate)=@Year
	AND ClaimDescription=@ClaimType



END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPIConversionRate]...';


GO

CREATE PROCEDURE [Reporting].[GetKPIConversionRate]

--parameters
@Year int= 2020,
@Month int= 3,
@OperationType nvarchar(5)='SA'

AS
BEGIN


--**************************Select Statement To Load Data*******************************************--
	SELECT *
	FROM [Reporting].[KPIConversionRate]
	WHERE [Month]=@Month AND [Year]=@Year AND  [Type] LIKE @OperationType


END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPIConversionRateDetails]...';


GO

CREATE PROCEDURE [Reporting].[GetKPIConversionRateDetails]

--parameters
@Year int= 2020,
@Month int= 3,
@OperationType nvarchar(5)='SA'

AS
BEGIN

--**************************Select Statement To Load Data*******************************************--
	SELECT *
	FROM [Reporting].[KPIConversionRateDetails]
	WHERE [Month]=@Month AND [Year]=@Year AND  [Type] LIKE @OperationType

END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPIDelayedPayment]...';


GO
CREATE PROCEDURE [Reporting].[GetKPIDelayedPayment]

--Parameters


AS
BEGIN



--**************************Select Statement To Load Data*******************************************--

	SELECT * FROM [Reporting].[KPIDelayedPayment]



END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPIDeliveryRate]...';


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
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPIFinancialCommitmentNonPaidAmounts]...';


GO

CREATE PROCEDURE [Reporting].[GetKPIFinancialCommitmentNonPaidAmounts]

	-- Add the parameters for the stored procedure here
	@SelectYear int=2020,
	@SelectMonth  int =2


AS
BEGIN
    --********Select data From Table [Reporting].[KPITotalGrossPayroll]******************************--
	SELECT *
	
	FROM [Reporting].[KPIFinancialCommitmentNonPaidAmounts] WITH(NOLOCK)
	ORDER BY Year,Month
	

END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPIGrossMargin]...';


GO

CREATE PROCEDURE [Reporting].[GetKPIGrossMargin]

--Parameters

 @Year int= 2020,
 @Month int = 8

AS
BEGIN



--**************************Select Statement To Load Data*******************************************--

	SELECT * FROM [Reporting].[KPIGrossMargin] WITH(NOLOCK)
	WHERE Year=@Year AND Month=@Month



END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPIGrossOperatingSurplus]...';


GO
CREATE PROCEDURE [Reporting].[GetKPIGrossOperatingSurplus]

--Parameters
 @Year int= 2020,
 @Month int = 8

AS
BEGIN



--**************************Select Statement To Load Data*******************************************--

	SELECT * FROM [Reporting].[KPIGrossOperatingSurplus] WITH(NOLOCK)
    WHERE Year=@Year AND Month=@Month



END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPINeedInFunds]...';


GO

CREATE PROCEDURE [Reporting].[GetKPINeedInFunds]

--Parameters

 @FiscalYear nvarchar(255)= '2019'

AS
BEGIN

--**************************Select Statement To Load Data*******************************************--

	SELECT * FROM [Reporting].[KPINeedInFunds]  WITH(NOLOCK)
	WHERE [Year]=@FiscalYear



END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPIOrderStatus]...';


GO

 

CREATE PROCEDURE [Reporting].[GetKPIOrderStatus]

--Parameters
  @Period tinyint= 3,
  @OperationType nvarchar(5)='PU',
  @NumberOfRows int = 10

 
 AS
 BEGIN

--Period Parameters In Stark Dashboard
DECLARE @StartPeriod date, @EndPeriod date


SET @StartPeriod = (SELECT StartPeriod FROM [Reporting].[ParameterPeriod] WHERE PeriodEnum = @Period) 
SET @EndPeriod = (SELECT EndPeriod FROM [Reporting].[ParameterPeriod] WHERE PeriodEnum = @Period) 

 

--**************************Select Statement To Load Data*******************************************--
	SELECT *
	INTO #temp
	FROM [Reporting].[KPIOrderState]
			WHERE    DocumentDate BETWEEN @StartPeriod AND @EndPeriod
					AND [Type] = @OperationType


 
	--**************************FINAL QUERY*************************************************************--
	SELECT *
	FROM(
			SELECT t.*, ROW_NUMBER() OVER ( ORDER BY HtAmount DESC) AS [Rank]
			FROM #temp t
	)A
	WHERE [Rank] <= @NumberOfRows OR @NumberOfRows IS NULL

END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPIPaymentMethodPerClient]...';


GO

CREATE PROCEDURE [Reporting].[GetKPIPaymentMethodPerClient]
--parameters
	@SelectYear int= 2020,
	@SelectMonth int = 4
AS
BEGIN

--**************************Select Statement To Load Data*******************************************--

	SELECT *
	FROM [Reporting].[KPIPaymentMethodPerClient] WITH(NOLOCK)
	WHERE 	[Year] =  @SelectYear  AND  [Month] =  @SelectMonth
	--WHERE 	YEAR([SettlementDate]) =  @SelectYear AND MONTH([SettlementDate])=@SelectMonth			--where TiersName is null

END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPIRankTiers]...';


GO
-------------------------------------------------------------------
CREATE PROCEDURE [Reporting].[GetKPIRankTiers]

--Parameters

 @Period tinyint= 4,
 @IdTier int= 0

AS
BEGIN


--**************************Select Statement To Load Data*******************************************--

		SELECT 	* 
		FROM [Reporting].[KPITopTiers]
		WHERE      PeriodEnum = @Period 
			   AND [IdTiers] =  @IdTier


END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPIRetentionRate]...';


GO

CREATE PROCEDURE [Reporting].[GetKPIRetentionRate]

	-- Add the parameters for the stored procedure here
	--@StarDate int=2019,
	--@EndDate int =2020
@Year int= 2020,
 @Month int = 8

AS
BEGIN
    --********Select data From Table [Reporting].[KPIRetentionRate]******************************--
	SELECT *
	
	FROM [Reporting].[KPIRetentionRate] WITH(NOLOCK)
	WHERE Year=@Year AND Month=@Month

	

END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPISalesPerItem]...';


GO

 

CREATE PROCEDURE [Reporting].[GetKPISalesPerItem]

--Parameters
  @Period tinyint= 4,
  @OperationType nvarchar(10)='SA',  -- Possbile values: PU for purchase , SA for sales 
  @RankCriteria nvarchar(5) = 'Qty', -- Possbile values: Amnt for rank based on amount, Qty for rank based on quantity
  @NumberOfRows int = 10


AS
BEGIN

--Total Per Item Family
	SELECT 

	HtTotalPerItemFamily,
	QuantityPerItemFamily,
	ItemFamily

	into #family
	FROM [Reporting].[KPISalesPerItemFamily] 
	WHERE PeriodEnum = @Period
	AND [OperationType] LIKE @OperationType
	--AND [RankByQuantity] <= @NumberOfRows
	--ORDER BY [RankByQuantity]

IF @RankCriteria = 'Amnt'
BEGIN
	SELECT 
	*
	, ROW_NUMBER() OVER (PARTITION BY [LabelItemFamily], PeriodEnum ORDER BY HTTotalPerItem DESC) AS [RankByFamilyPerAmount]
	, ROW_NUMBER() OVER (PARTITION BY [LabelItemFamily], PeriodEnum ORDER BY QuantityPerItem DESC) AS [RankByFamilyPerQuantity]
	

	FROM [Reporting].[kPISalesPerItem] item
	INNER JOIN #family family ON family.ItemFamily=item.LabelItemFamily
	
	WHERE PeriodEnum = @Period
	AND [OperationType] LIKE @OperationType
	AND [RankByAmount] <= @NumberOfRows

	
	ORDER BY [RankByAmount]
END 

IF @RankCriteria = 'Qty'
BEGIN
	SELECT 
	*
	, ROW_NUMBER() OVER (PARTITION BY [LabelItemFamily], PeriodEnum ORDER BY HTTotalPerItem DESC) AS [RankByFamilyPerAmount]
	, ROW_NUMBER() OVER (PARTITION BY [LabelItemFamily], PeriodEnum ORDER BY QuantityPerItem DESC) AS [RankByFamilyPerQuantity]
	

	FROM [Reporting].[kPISalesPerItem]  item
	INNER JOIN #family family ON family.ItemFamily=item.LabelItemFamily
	
	WHERE PeriodEnum = @Period
	AND [OperationType] LIKE @OperationType
	AND [RankByQuantity] <= @NumberOfRows

	ORDER BY [RankByQuantity]
END 


--SELECT * FROM #family family
--INNER JOIN [Reporting].[kPISalesPerItem] items ON family.ItemFamily=items.LabelItemFamily






END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPISalesPerItemFamily]...';


GO

 

CREATE PROCEDURE [Reporting].[GetKPISalesPerItemFamily]

--Parameters
  @Period tinyint= 4,
  @OperationType nvarchar(10)='PU',  -- Possbile values: PU for purchase , SA for sales 
  @RankCriteria nvarchar(5) = 'Amnt', -- Possbile values: Amnt for rank based on amount, Qty for rank based on quantity
  @NumberOfRows int = 10


AS
BEGIN



IF @RankCriteria = 'Amnt'
BEGIN
	SELECT *
	FROM [Reporting].[KPISalesPerItemFamily] 
	WHERE PeriodEnum = @Period
	AND [OperationType] LIKE @OperationType
	AND [RankByAmount] <= @NumberOfRows
	ORDER BY [RankByAmount]
END 

IF @RankCriteria = 'Qty'
BEGIN
	SELECT *
	FROM [Reporting].[KPISalesPerItemFamily] 
	WHERE PeriodEnum = @Period
	AND [OperationType] LIKE @OperationType
	AND [RankByQuantity] <= @NumberOfRows
	ORDER BY [RankByQuantity]
END 









END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPISalesPurchaseState]...';


GO

CREATE PROCEDURE [Reporting].[GetKPISalesPurchaseState]

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
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPISearchItems]...';


GO

CREATE PROCEDURE [Reporting].[GetKPISearchItems]

 --@Period tinyint= 3,
 @Month int = 3,
 @Year int = 2020,
 @SearchMethod nvarchar(15)='code', -- Possbile values: code, description
 @NumberOfRows int = 5

AS
BEGIN

	SELECT * FROM [Reporting].[KPISearchItems]
	WHERE    Month = @Month 
		 AND Year = @Year
		 AND SearchMethod = @SearchMethod
		 AND [Rank] <= @NumberOfRows OR @NumberOfRows IS NULL

END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPITopTiers]...';


GO

CREATE PROCEDURE [Reporting].[GetKPITopTiers]

--Parameters

 @Period tinyint= 4,
 --@Month int = 3,
 --@Year int = 2020,
 @OperationType nvarchar(5)='PU', -- Possbile values: PU for purchase (supplier), SA for sales (client)
 @RankCriteria nvarchar(5) = 'Amnt', -- Possbile values: Amnt for rank based on amount, Qty for rank based on quantity
 @NumberOfRows int = 5

AS
BEGIN

----Period Parameters In Stark Dashboard
--DECLARE @StartPeriod date, @EndPeriod date

--SET @StartPeriod = (SELECT StartPeriod FROM [Reporting].[ParameterPeriod] WHERE PeriodEnum = @Period) 
--SET @EndPeriod = (SELECT EndPeriod FROM [Reporting].[ParameterPeriod] WHERE PeriodEnum = @Period) 



--**************************Select Statement To Load Data*******************************************--

	IF @RankCriteria = 'Amnt'
	BEGIN
		SELECT 	* 
		FROM [Reporting].[KPITopTiers]
		WHERE      PeriodEnum = @Period 
			   AND [Type] =  @OperationType
			   AND [RankByTTCAmount] <= @NumberOfRows
		ORDER BY [RankByTTCAmount]
	END

	IF @RankCriteria = 'Qty'
	BEGIN
		SELECT 	* 
		FROM [Reporting].[KPITopTiers]
		WHERE      PeriodEnum = @Period  
			   AND [Type] =  @OperationType
			   AND [RankByQuantity] <= @NumberOfRows
		ORDER BY [RankByQuantity]
	END



END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPITotalAmountPerSalaryRule]...';


GO

CREATE PROCEDURE [Reporting].[GetKPITotalAmountPerSalaryRule]

	-- Add the parameters for the stored procedure here
	@Year int=2019,
	@Month int =3


AS
BEGIN

    --********Select data From Table [Reporting].[KPITotalGrossPayroll]******************************--

	SELECT *
	
	FROM [Reporting].[KPIAmountPerSalaryRule]

	WHERE Month=@Month AND Year=@Year

END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPITotalDepreciationPerAccount]...';


GO

CREATE PROCEDURE [Reporting].[GetKPITotalDepreciationPerAccount]

--Parameters

 @FiscalYear nvarchar(255)= '2019'

AS
BEGIN



--**************************Select Statement To Load Data*******************************************--

	SELECT * FROM [Reporting].[KPITotalDepreciationPerAccount]
	WHERE [Year]=@FiscalYear



END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPITotalGrossPayroll]...';


GO

CREATE PROCEDURE [Reporting].[GetKPITotalGrossPayroll]

	-- Add the parameters for the stored procedure here
	@Year int=2019,
	@Month int =3


AS
BEGIN

    --********Select data From Table [Reporting].[KPITotalGrossPayroll]******************************--
	SELECT *
	
	FROM [Reporting].[KPITotalGrossPayroll]

	WHERE Month=@Month AND Year=@Year

END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPITotalPremium]...';


GO

CREATE PROCEDURE [Reporting].[GetKPITotalPremium]

	-- Add the parameters for the stored procedure here
	@Year int=2019,
	@Month int =3


AS
BEGIN

    --********Select data From Table [Reporting].[KPITotalGrossPayroll]******************************--

	SELECT *
	
	FROM [Reporting].[KPITotalPremium]

	WHERE Month=@Month AND Year=@Year

END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetKPITurnoverPerSales]...';


GO
CREATE PROCEDURE [Reporting].[GetKPITurnoverPerSales]

--Parameters
 @Year int= 2020,
 @Month int = 8

AS
BEGIN



--**************************Select Statement To Load Data*******************************************--

	SELECT * FROM [Reporting].[KPITurnoverPerSales] WITH(NOLOCK)
    WHERE Year=@Year AND Month=@Month



END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[GetTurnoverPerStock]...';


GO

CREATE PROCEDURE [Reporting].[GetTurnoverPerStock]
	@Month int=3,
	@Year int =2020,
	@NumberOfRows int =10
AS
BEGIN

--STOCK ROTATION RATE--

		SELECT IdItem,ItemCode,ItemDescription,ItemFamily,ItemNature,AvailableQuantityPerItem,MONTH(DocumentDate) AS Month ,YEAR(DocumentDate) AS Year,SUM(MovementQty) AS SalesQuantity,SUM(DocumentHTPrice) AS TotalSalesAmount,ISNULL(SUM(DocumentHTPrice)/NULLIF(SUM(AvailableQuantityPerItem),0),0) AS TurnoverPerStock
		INTO #temp
		FROM
		(	SELECT IdItem,ItemCode,ItemDescription,ItemFamily,ItemNature,AvailableQuantityPerItem,DocumentDate,MovementQty,DocumentHTPrice

			FROM [Reporting].[DocumentLineConsolidated]
		
			WHERE MONTH(DocumentDate)=@Month AND YEAR(DocumentDate)=@Year
			AND DocumentTypeCode IN ('D-SA','BS-SA')
		)A
		GROUP BY IdItem,ItemCode,ItemDescription,ItemFamily,ItemNature,AvailableQuantityPerItem,MONTH(DocumentDate),YEAR(DocumentDate),MovementQty

	--FINAL QUERY--

	SELECT *
	FROM(
			SELECT t.*, ROW_NUMBER() OVER ( ORDER BY TotalSalesAmount DESC) AS [Rank]
			FROM #temp t
	)A
	WHERE [Rank] <= @NumberOfRows OR @NumberOfRows IS NULL


END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[LeavesYTD]...';


GO

CREATE PROCEDURE [Reporting].[LeavesYTD]
@Month int = 12,
@Year int=2019
AS

BEGIN

	SET NOCOUNT ON;
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
    -- Insert statements for procedure here
BEGIN TRY	
	SELECT  a.EmployeeName
		   ,a.Year
		   ,a.TheMonth
		   ,a.MonthCRA
		   ,SUM(a.DayConges) OVER (
						  PARTITION BY Year,EmployeeName
						  ORDER BY a.TheMonth
						  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			 )AS CongesYTD

				
		INTO #temp
	   FROM (
				SELECT   EmployeeName
						,Year
						,TheMonth
						,MonthCRA
						,SUM(conges) AS DayConges
				FROM [Reporting].[TimeSheetLineConsolidated] 
				GROUP BY EmployeeName,Year,TheMonth,MonthCRA
			)a

		 SELECT * FROM  #temp
		 WHERE Year=@Year AND TheMonth<=@Month
		 SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'LeavesYTD', @NbInserted, GETDATE(), @ErrorMessage
END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[RententionRate]...';


GO
 

CREATE PROCEDURE [Reporting].[RententionRate]
@Year int = 2020
AS
BEGIN
--- rentention rate per year
--- % of quiting employees vs hired employees


DECLARE @NbHiring int =0, @NbExit int =0

SET @NbHiring=(
SELECT count(*) AS [Count]
FROM [Reporting].[FctEmployeeContract]
WHERE YEAR(HiringDate) = @Year)

SET @NbExit=(
SELECT count(*) AS [Count]
FROM [Reporting].[FctEmployeeContract]
WHERE YEAR(LegalExitDate) = @Year)

SELECT CAST(((@NbHiring-@NbExit)*1.0/@NbHiring*1.0)*100 AS numeric(36,2)) AS RentetionRate, @Year AS [Year]

END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[StaffRententionRatev2]...';


GO
 
CREATE PROCEDURE [Reporting].[StaffRententionRatev2]
@Period int = 5
AS
BEGIN
--- rentention rate per year
--- % of employees change in period

DECLARE @StartPeriod date, 
		@EndPeriod date, 
		@StaffCountAtStart int =0, 
		@StaffCountAtEnd int =0,
		@PeriodLabel nvarchar(255)

 

SET @StartPeriod = (SELECT StartPeriod FROM [Reporting].[ParameterPeriod] WHERE PeriodEnum = @Period) 
SET @EndPeriod = (SELECT EndPeriod FROM [Reporting].[ParameterPeriod] WHERE PeriodEnum = @Period) 
SET @PeriodLabel = (SELECT [Period] FROM [Reporting].[ParameterPeriod] WHERE PeriodEnum = @Period) 

 

SET @StaffCountAtStart=(
SELECT count(*) AS [Count]
FROM [Reporting].[FctEmployeeContract]
WHERE @StartPeriod BETWEEN ContractStartDate AND ISNULL(ContractEndDate, '9999-12-31'))

SET @StaffCountAtEnd=(
SELECT count(*) AS [Count]
FROM [Reporting].[FctEmployeeContract]
WHERE @EndPeriod BETWEEN ContractStartDate AND ISNULL(ContractEndDate, '9999-12-31'))

SELECT @StaffCountAtStart AS StaffCountAtStart,
	   @StaffCountAtEnd AS StaffCountAtEnd,
	   CAST(((@StaffCountAtEnd)*1.0/@StaffCountAtStart*1.0)*100 AS numeric(36,2)) AS RentetionRate, 
	   @PeriodLabel AS [Period]

END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[StaffUpcomingContractAnniversary]...';


GO

CREATE PROCEDURE [Reporting].[StaffUpcomingContractAnniversary]
AS 
BEGIN
----upcoming annual contract anniversary 
--- Only fel contract type CDI or SIVP TODO ?
-- anniversary date calculation based on hiring date


--**this month--**
SELECT Matricule, 
	   FirstName, 
	   LastName, 
	   HiringDate, 
	   NextHiringAnniversary, 
	   SalaryStructureReference, 
	   ContractStartDate, 
	   ContractEndDate,
	   'This month' AS [Period],
	   YEAR(NextHiringAnniversary) AS [Year],
	   MONTH(NextHiringAnniversary) AS [Month],
	  -- CASE WHEN DAY(NextHiringAnniversary) < DAY(getdate()) THEN CONCAT(DATEDIFF(day, NextHiringAnniversary, getdate()), 'day(s) ago')
			--WHEN NextHiringAnniversary > getdate() THEN CONCAT(DATEDIFF(day, getdate(), NextHiringAnniversary), 'day(s) innn')
	  -- end as stat
	  DATEDIFF(day, getdate(), NextHiringAnniversary) AS DaysTill


FROM  [Reporting].[FctEmployeeContract]
WHERE MONTH(NextHiringAnniversary) = MONTH(getdate()) 
  AND YEAR(NextHiringAnniversary) = YEAR(getdate())

UNION ALL
--**next 2 months --**
SELECT Matricule, 
	   FirstName, 
	   LastName, 
	   HiringDate, 
	   NextHiringAnniversary, 
	   SalaryStructureReference, 
	   ContractStartDate, 
	   ContractEndDate,
	   'Later in 90 days' AS [Period],
	   YEAR(NextHiringAnniversary) AS [Year],
	   MONTH(NextHiringAnniversary) AS [Month],
	   DATEDIFF(day, getdate(), NextHiringAnniversary) AS DaysTill

	   

FROM [Reporting].[FctEmployeeContract]
WHERE (MONTH(NextHiringAnniversary) = MONTH(getdate()) + 1 OR MONTH(NextHiringAnniversary) = MONTH(getdate()) + 2)
   AND YEAR(NextHiringAnniversary) = YEAR(getdate())


END
GO
PRINT N'Cr�ation de Proc�dure [Reporting].[TurnoverChangeRate]...';


GO


CREATE PROCEDURE [Reporting].[TurnoverChangeRate]
  --@Period tinyint= 2
@DocumentType nvarchar(5)='I-SA',
@StartPeriod datetime = '2020-01-01',
@EndPeriod datetime = '2020-01-01'
 
AS
BEGIN
DECLARE @NbInserted int = 0, @ErrorMessage nvarchar(max) = NULL
BEGIN TRY  
	   --Remplissage de la 1�re table temporaire
		SELECT 
		SUM(DocumentTTCPrice) AS TurnoverFirstYear,
		DocumentTypeCode, 
		MONTH(DocumentDate) AS Month,
		YEAR(DocumentDate) AS Year

		INTO #turnoverFirstYear
		--INTO [Reporting].[KPITurnoverChangeRate]

		from(

		SELECT DISTINCT IdDocument,
	    DocumentTTCPrice,
		DocumentTypeCode,
		DocumentDate,
		MONTH(DocumentDate) AS [Month],
		YEAR(DocumentDate) AS [Year]

			from[Reporting].[FctSales] 
				WHERE DocumentTypeCode = 'I-SA'
				AND YEAR(DocumentDate) = YEAR(@StartPeriod)
		)a
		        
				group by
				--DocumentId,
				DocumentTypeCode,
				--DocumentDate,
                MONTH(DocumentDate),
		        YEAR(DocumentDate) 		


		--Remplissage de la 2�me table temporaire
		SELECT 
		SUM(DocumentTTCPrice) AS TurnoverSecondYear,
		DocumentTypeCode, 
		MONTH(DocumentDate) AS Month,
		YEAR(DocumentDate) AS Year

		INTO #turnoverSecondYear
		--INTO [Reporting].[KPITurnoverChangeRate]

		from(

		SELECT DISTINCT IdDocument,
	    DocumentTTCPrice,
		DocumentTypeCode,
		DocumentDate,
		MONTH(DocumentDate) AS [Month],
		YEAR(DocumentDate) AS [Year]

			from[Reporting].[FctSales] 
				WHERE DocumentTypeCode = 'I-SA'
				AND YEAR(DocumentDate) = YEAR(@EndPeriod)
		)b
		        
				group by
				--DocumentId,
				DocumentTypeCode,
				--DocumentDate,
                MONTH(DocumentDate),
		        YEAR(DocumentDate) 
				
								
	   --Calcul taux de variation		
	   SELECT  
	   tfy.Year,
	   tsy.Year,
	   tfy.Month,
	   tfy.DocumentTypeCode,
	   tfy.TurnoverFirstYear,
	   tsy.TurnoverSecondYear,
	   CAST((tsy.TurnoverSecondYear - tfy.TurnoverFirstYear)/tfy.TurnoverFirstYear*100 AS numeric(36,2)) AS ChangeRate
	   

FROM #turnoverFirstYear tfy
LEFT JOIN #turnoverSecondYear tsy
ON     tfy.Month = tsy.Month
order by tfy.Month
SET @NbInserted = @@ROWCOUNT
END TRY

BEGIN CATCH 
	SET @ErrorMessage = ERROR_MESSAGE()
END CATCH 

----LOG
INSERT INTO [Reporting].[FeedLOG] (TableName, InsertedRowsNumber, [Date], ErrorMessage)
SELECT 'TurnoverChangeRate', @NbInserted, GETDATE(), @ErrorMessage
END
GO
PRINT N'Mise � jour termin�e.';


GO
