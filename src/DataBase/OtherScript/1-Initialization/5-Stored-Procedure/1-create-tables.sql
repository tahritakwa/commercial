/****** Object:  Table [Reporting].[DimAccount]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimAccount](
	[AccountId] [bigint] NULL,
	[AccountCode] [int] NULL,
	[AccountLabel] [varchar](255) NULL,
	[AccountIsLitrable] [bit] NULL,
	[AccountIsReconcilable] [bit] NULL,
	[AccountPlanId] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimCandidate]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimCandidate](
	[IdCandidate] [int] NULL,
	[FirstName] [nvarchar](255) NULL,
	[LastName] [nvarchar](255) NULL,
	[Gender] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimChartAccounts]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimChartAccounts](
	[ChartAccountId] [bigint] NULL,
	[ChartAccountCode] [int] NULL,
	[ChartAccountLabel] [varchar](255) NULL,
	[ChartAccountToBalanced] [bit] NULL,
	[ChartAccountParentId] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimContract]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimContract](
	[Id] [int] NULL,
	[ContractReference] [nvarchar](255) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[WorkingTime] [float] NULL,
	[IsDeleted] [bit] NULL,
	[IdEmployee] [int] NULL,
	[IdSalaryStructure] [int] NULL,
	[IdCnss] [int] NULL,
	[ContractAttached] [nvarchar](500) NULL,
	[IdContractType] [int] NULL,
	[State] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimCountry]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimCountry](
	[IdCountry] [int] NULL,
	[NameEn] [nvarchar](255) NULL,
	[NameFr] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimCurrency]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimCurrency](
	[IdCurrency] [int] NOT NULL,
	[CurrencyCode] [nvarchar](255) NULL,
 CONSTRAINT [PK_Currency_1] PRIMARY KEY CLUSTERED 
(
	[IdCurrency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimDate]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimDate](
	[DateId] [varchar](8) NULL,
	[Date] [date] NULL,
	[DayName] [nvarchar](30) NULL,
	[TheDay] [int] NULL,
	[TheDayOfYear] [int] NULL,
	[TheWeekOfMonth] [varchar](1) NULL,
	[Month] [nvarchar](30) NULL,
	[TheMonth] [int] NULL,
	[Quarter] [int] NULL,
	[Year] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimEmployee]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimEmployee](
	[IdEmployee] [int] NULL,
	[Matricule] [nvarchar](255) NULL,
	[FirstName] [nvarchar](255) NULL,
	[LastName] [nvarchar](255) NULL,
	[Gender] [nvarchar](255) NULL,
	[BirthDate] [date] NULL,
	[Age] [int] NULL,
	[AgeRange] [nvarchar](255) NULL,
	[HiringDate] [date] NULL,
	[IsForeign] [int] NULL,
	[FamilyLeader] [bit] NULL,
	[ChildrenNumber] [int] NULL,
	[Bank] [nvarchar](255) NULL,
	[CountryNameFr] [nvarchar](255) NULL,
	[IdOffice] [int] NULL,
	[OfficeName] [nvarchar](255) NULL,
	[Grade] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimEmployeeContract]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimEmployeeContract](
	[IdContract] [int] NULL,
	[ContractReference] [nvarchar](255) NULL,
	[ContractStartDate] [date] NULL,
	[ContractEndDate] [date] NULL,
	[IdEmployee] [int] NULL,
	[WorkingTime] [float] NULL,
	[IdContractType] [int] NULL,
	[ContractTypeDescription] [nvarchar](255) NULL,
	[ContractTypeCode] [nvarchar](255) NULL,
	[IdSalaryStructure] [int] NULL,
	[SalaryStructureReference] [nvarchar](255) NULL,
	[SalaryStructureName] [nvarchar](255) NULL,
	[IdCnss] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimEmployeeExit]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimEmployeeExit](
	[Id] [int] NOT NULL,
	[IdExitReason] [int] NOT NULL,
	[IdEmployee] [int] NOT NULL,
	[ExitReasonLabel] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[ReleaseDate] [date] NOT NULL,
	[ExitEmployeeAttachementFile] [nvarchar](500) NULL,
	[CommentRh] [nvarchar](255) NULL,
	[Status] [int] NULL,
	[TreatmentDate] [date] NULL,
	[TreatedBy] [int] NULL,
	[LegalExitDate] [date] NULL,
	[DamagingDeparture] [bit] NULL,
	[ExitDepositDate] [date] NULL,
	[MinNoticePeriodDate] [date] NULL,
	[MaxNoticePeriodDate] [date] NULL,
	[ExitPhysicalDate] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimEmployeeProject]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimEmployeeProject](
	[IdEmployeeProject] [int] NULL,
	[AssignmentDate] [date] NULL,
	[UnassignmentDate] [date] NULL,
	[IdEmployee] [int] NULL,
	[IdProject] [int] NULL,
	[AverageDailyRateEmpProject] [float] NULL,
	[ProjectName] [nvarchar](255) NULL,
	[ProjectStartDate] [date] NULL,
	[ProjectExpectedEndDate] [date] NULL,
	[ProjectType] [int] NULL,
	[AverageDailyRateProject] [float] NULL,
	[IdTiers] [int] NULL,
	[IdSettlmentMode] [int] NULL,
	[IdCurrency] [int] NULL,
	[IsBillable] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimEmployeeTeam]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimEmployeeTeam](
	[IdEmployeeTeam] [int] NULL,
	[AssignmentDate] [date] NULL,
	[UnassignmentDate] [date] NULL,
	[IdEmployee] [int] NULL,
	[IdTeam] [int] NULL,
	[TeamCode] [nvarchar](255) NULL,
	[TeamName] [nvarchar](255) NULL,
	[AssignmentPercentage] [float] NULL,
	[IdManager] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimExitReason]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimExitReason](
	[Id] [int] NULL,
	[IsDeleted] [bit] NULL,
	[Description] [nvarchar](255) NULL,
	[Label] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimFiscalYear]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimFiscalYear](
	[FiscalYearId] [bigint] NULL,
	[FiscalYearClosingState] [int] NULL,
	[FiscalYearConclusionDate] [datetime2](7) NULL,
	[FiscalYearStartDate] [datetime2](7) NULL,
	[FiscalYearEndDate] [datetime2](7) NULL,
	[FiscalYearName] [varchar](255) NULL,
	[FiscalYearClosingDate] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimGrade]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimGrade](
	[Id] [int] NULL,
	[Designation] [nvarchar](255) NULL,
	[IsDeleted] [bit] NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimItem]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimItem](
	[IdItem] [int] NOT NULL,
	[IdUnitStock] [int] NULL,
	[IdUnitSales] [int] NULL,
	[ItemCode] [nvarchar](255) NULL,
	[ItemDescription] [nvarchar](255) NULL,
	[IdItemFamily] [int] NULL,
	[LabelItemFamily] [nvarchar](255) NULL,
	[IdSubFamily] [int] NULL,
	[LabelSubFamily] [nvarchar](255) NULL,
	[IdItemNature] [int] NULL,
	[LabelItemNature] [nvarchar](255) NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[IdItem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimJournal]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimJournal](
	[journalID] [bigint] NULL,
	[JournalCode] [varchar](255) NULL,
	[JournalCreatedDate] [datetime2](7) NULL,
	[JournalIsMovable] [bit] NULL,
	[JournalIsReconcilable] [bit] NULL,
	[JournalLabel] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimOffice]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimOffice](
	[IdOffice] [int] NULL,
	[OfficeName] [nvarchar](255) NULL,
	[IdCountry] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimPayment]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimPayment](
	[IdPaymentType] [int] NULL,
	[IdPaymentMethod] [int] NULL,
	[PaymentTypeLabel] [nvarchar](255) NULL,
	[PaymentTypeCode] [nvarchar](255) NULL,
	[PaymentMethodCode] [nvarchar](255) NULL,
	[PaymentMethodName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimSalaryStructure]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimSalaryStructure](
	[Id] [int] NOT NULL,
	[SalaryStructureReference] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_SalaryStructure] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimTiers]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimTiers](
	[IdTiers] [int] NOT NULL,
	[TiersName] [nvarchar](255) NULL,
	[TiersCode] [nvarchar](255) NULL,
	[IdTypeTiers] [int] NULL,
	[TypeTiersLabel] [nvarchar](255) NULL,
	[TiersAdress] [nvarchar](255) NULL,
	[IdCountryTiers] [int] NULL,
	[CountryEn] [nvarchar](255) NULL,
	[CountryFr] [nvarchar](255) NULL,
	[IdAccount] [int] NULL,
	[CreationDate] [date] NULL,
 CONSTRAINT [PK_Dim.Tiers] PRIMARY KEY CLUSTERED 
(
	[IdTiers] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimWarehouse]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimWarehouse](
	[IdWarehouse] [int] NOT NULL,
	[WarehouseCode] [nvarchar](255) NULL,
	[WarehouseName] [nvarchar](255) NULL,
	[WarehouseAdress] [nvarchar](255) NULL,
 CONSTRAINT [PK_Warehouse] PRIMARY KEY CLUSTERED 
(
	[IdWarehouse] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[FctClaims]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[FctClaims](
	[IdClaim] [int] NULL,
	[ClaimCode] [nvarchar](255) NULL,
	[ClaimDescription] [nvarchar](255) NULL,
	[IdDocument] [int] NULL,
	[IdDocumentLine] [int] NULL,
	[DocumentDate] [datetime] NULL,
	[ClaimQty] [float] NULL,
	[IdMouvementIn] [int] NULL,
	[IdMovementOut] [int] NULL,
	[IdWarehouse] [int] NULL,
	[IdSupplier] [int] NULL,
	[IdClient] [int] NULL,
	[IdClaimStatus] [int] NULL,
	[LabelClaimStatus] [nvarchar](255) NULL,
	[TranslationClaimStatus] [nvarchar](255) NULL,
	[DescriptionClaimType] [nvarchar](255) NULL,
	[TranslationClaimType] [nvarchar](255) NULL,
	[IdItem] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[FctDocumentAccountLine]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[FctDocumentAccountLine](
	[DocumentAccountId] [bigint] NULL,
	[DocumentAccountCode] [varchar](255) NULL,
	[DocumentAccountCreationDate] [datetime2](7) NULL,
	[DocumentAccountDate] [datetime2](7) NULL,
	[DocumentAccountLabel] [varchar](255) NULL,
	[DocumentAccountStatus] [varchar](255) NULL,
	[FiscalYearId] [bigint] NULL,
	[JournalId] [bigint] NULL,
	[DocumentAccountLineId] [bigint] NULL,
	[DocumentAccountLineCreditAmount] [numeric](19, 3) NULL,
	[DocumentAccountLineDebitAmount] [numeric](19, 3) NULL,
	[DocumentAccountLineDate] [datetime2](7) NULL,
	[DocumentAccountLineIsClose] [bit] NULL,
	[DocumentAccountLineLabel] [varchar](255) NULL,
	[DocumentAccountLineLetter] [varchar](255) NULL,
	[DocumentAccountLineReconciliationDate] [date] NULL,
	[DocumentAccountLineReference] [varchar](255) NULL,
	[AccountIdAssociated] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[FctEmployeeContract]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[FctEmployeeContract](
	[Id] [int] NULL,
	[IdEmployee] [int] NULL,
	[Matricule] [nvarchar](10) NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[Gender] [int] NULL,
	[BirthDate] [date] NULL,
	[Age] [int] NULL,
	[AgeRange] [nvarchar](255) NULL,
	[HiringDate] [date] NULL,
	[HasContract] [int] NULL,
	[ContractReference] [nvarchar](255) NULL,
	[ContractStartDate] [date] NULL,
	[ContractEndDate] [date] NULL,
	[Seniority] [int] NULL,
	[SeniorityRange] [nvarchar](255) NULL,
	[NextHiringAnniversary] [date] NULL,
	[WorkingTime] [float] NULL,
	[SalaryStructureReference] [nvarchar](255) NULL,
	[Grade] [nvarchar](255) NULL,
	[LegalExitDate] [date] NULL,
	[ExitTreatmentDate] [date] NULL,
	[ExitReason] [nvarchar](255) NULL,
	[IsForeign] [bit] NULL,
	[FamilyLeader] [bit] NULL,
	[ChildrenNumber] [tinyint] NULL,
	[CountryNameFr] [nvarchar](255) NULL,
	[Bank] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[FctFinancialCommitment]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[FctFinancialCommitment](
	[IdSettlementCommitment] [int] NULL,
	[CommitmentId] [int] NULL,
	[SettlementId] [int] NULL,
	[AssignedAmount] [float] NULL,
	[RemplacedBy] [int] NULL,
	[ExchangeRate] [int] NULL,
	[IdSettlement] [int] NULL,
	[SettlementDate] [date] NULL,
	[SettlementCode] [nvarchar](255) NULL,
	[SettlementAmount] [float] NULL,
	[CommitmentDate] [date] NULL,
	[Holder] [nvarchar](255) NULL,
	[Note] [nvarchar](255) NULL,
	[Idpaymentmethod] [int] NULL,
	[MethodName] [nvarchar](50) NULL,
	[IdPaymentStatus] [int] NULL,
	[PaymentStatus] [nvarchar](255) NULL,
	[IdFinancialCommitment] [int] NULL,
	[BenefitPeriod] [int] NULL,
	[FinancialCommitmentDate] [date] NULL,
	[RemainingAmount] [float] NULL,
	[AmountWithCurrency] [float] NULL,
	[RemainingAmountWithCurrency] [float] NULL,
	[IdTiers] [int] NULL,
	[IdDocument] [int] NULL,
	[DocumentTypeCode] [nvarchar](255) NULL,
	[DocumentDate] [date] NULL,
	[DocumentTTCPrice] [float] NULL,
	[DocumentRemainingAmount] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[FctPayslip]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[FctPayslip](
	[IdPayslipDetails] [int] NULL,
	[IdSalaryRule] [int] NULL,
	[SalaryRuleDescription] [nvarchar](255) NULL,
	[Order] [int] NULL,
	[Gain] [float] NULL,
	[Deduction] [float] NULL,
	[IdPayslip] [int] NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[IdBonus] [int] NULL,
	[IdContract] [int] NULL,
	[IdEmployee] [int] NULL,
	[IdSession] [int] NULL,
	[NumberDaysLeaveTaken] [int] NULL,
	[NumberDaysNonPaidLeaveTaken] [int] NULL,
	[NumberDaysWorked] [int] NULL,
	[NumberOfDays] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[FctPurchases]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[FctPurchases](
	[IdDocument] [int] NULL,
	[DocumentCode] [nvarchar](255) NULL,
	[DocumentTypeCode] [nvarchar](255) NULL,
	[DocumentTypeLabel] [nvarchar](255) NULL,
	[DocumentDate] [datetime] NULL,
	[DocumentMonth] [int] NULL,
	[DocumentYear] [int] NULL,
	[DocumentTTCPrice] [float] NULL,
	[DocumentRemainingAmount] [float] NULL,
	[DocumentHTPrice] [float] NULL,
	[DocumentHTPriceWithCurrency] [float] NULL,
	[DocumentTTCPriceWithCurrency] [float] NULL,
	[IdCurrency] [int] NULL,
	[IdStatus] [int] NULL,
	[DocumentStatus] [nvarchar](255) NULL,
	[IdTiers] [int] NULL,
	[IdItem] [int] NULL,
	[IdDocumentLine] [int] NULL,
	[DocumentLineDesignation] [nvarchar](255) NULL,
	[TtcTotalLine] [float] NULL,
	[HtTotalLine] [float] NULL,
	[AmountPerItem] [float] NULL,
	[ItemQuantity] [int] NULL,
	[IdWarehouse] [int] NULL,
	[AvailableQuantityPerItem] [int] NULL,
	[IdPaymentMethod] [int] NULL,
	[IdDocumentAssociated] [int] NULL,
	[CodeDocumentAssociated] [nvarchar](255) NULL,
	[DocumentTypeCodeAssociated] [nvarchar](255) NULL,
	[DocumentDateAssociated] [datetime] NULL,
	[IdDocumentLineAssociated] [int] NULL,
	[DocumentAssTypeLabel] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[FctRecruitment]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[FctRecruitment](
	[IdRecruitment] [int] NULL,
	[RecruitmentDescription] [nvarchar](255) NULL,
	[RecruitmentStatus] [nvarchar](255) NULL,
	[RecruitmentCreationDate] [date] NULL,
	[RecruitmentClosingDate] [date] NULL,
	[IdCandidacy] [int] NULL,
	[IdCandidate] [int] NULL,
	[CandidateFirstName] [nvarchar](255) NULL,
	[CandidateLastName] [nvarchar](255) NULL,
	[CandidateGender] [nvarchar](255) NULL,
	[IdOffice] [int] NULL,
	[IdCountry] [int] NULL,
	[IdInterview] [int] NULL,
	[InterviewDate] [date] NULL,
	[InterviewStatus] [nvarchar](255) NULL,
	[InterviewType] [nvarchar](255) NULL,
	[IdSupervisor] [int] NULL,
	[IdJob] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[FctReportLine]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[FctReportLine](
	[ReportLineId] [bigint] NULL,
	[ReportLineAmount] [numeric](19, 3) NULL,
	[ReportLineAnnexCode] [varchar](255) NULL,
	[ReportLineFormula] [varchar](255) NULL,
	[ReportLineIsManuallyChanged] [bit] NULL,
	[ReportLineIsNegatif] [bit] NULL,
	[ReportLineLabel] [varchar](255) NULL,
	[ReportLineLastUpdated] [datetime2](7) NULL,
	[ReportLineIndex] [varchar](255) NULL,
	[ReportType] [varchar](255) NULL,
	[ReportLineUser] [varchar](255) NULL,
	[FiscalYearId] [bigint] NULL,
	[ReportLineIsTotal] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[FctSales]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[FctSales](
	[IdDocument] [int] NULL,
	[DocumentCode] [nvarchar](255) NULL,
	[DocumentTypeCode] [nvarchar](255) NULL,
	[DocumentTypeLabel] [nvarchar](255) NULL,
	[DocumentDate] [datetime] NULL,
	[DocumentMonth] [int] NULL,
	[DocumentYear] [int] NULL,
	[DocumentTTCPrice] [float] NULL,
	[DocumentRemainingAmount] [float] NULL,
	[DocumentHTPrice] [float] NULL,
	[DocumentHTPriceWithCurrency] [float] NULL,
	[DocumentTTCPriceWithCurrency] [float] NULL,
	[IdCurrency] [int] NULL,
	[IdStatus] [int] NULL,
	[DocumentStatus] [nvarchar](255) NULL,
	[IdTiers] [int] NULL,
	[IdItem] [int] NULL,
	[IdDocumentLine] [int] NULL,
	[DocumentLineDesignation] [nvarchar](255) NULL,
	[TtcTotalLine] [float] NULL,
	[HtTotalLine] [float] NULL,
	[AmountPerItem] [float] NULL,
	[ItemQuantity] [int] NULL,
	[IdWarehouse] [int] NULL,
	[AvailableQuantityPerItem] [int] NULL,
	[IdPaymentMethod] [int] NULL,
	[IdDocumentAssociated] [int] NULL,
	[CodeDocumentAssociated] [nvarchar](255) NULL,
	[DocumentTypeCodeAssociated] [nvarchar](255) NULL,
	[DocumentDateAssociated] [datetime] NULL,
	[IdDocumentLineAssociated] [int] NULL,
	[DocumentAssTypeLabel] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[FctTimeSheetLine]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[FctTimeSheetLine](
	[EmployeeID] [int] NOT NULL,
	[CRAStatus] [nvarchar](255) NULL,
	[MonthCRA] [varchar](100) NULL,
	[DayOfMonth] [varchar](30) NULL,
	[DayName] [nvarchar](30) NULL,
	[TheDay] [int] NULL,
	[TheDayOfWeek] [int] NULL,
	[TheDayOfYear] [int] NULL,
	[TheWeekOfMonth] [varchar](1) NULL,
	[Month] [nvarchar](30) NULL,
	[TheMonth] [int] NULL,
	[Quarter] [int] NULL,
	[Year] [int] NULL,
	[DayOff] [nvarchar](255) NULL,
	[Regime] [varchar](6) NULL,
	[Créneau] [nvarchar](255) NULL,
	[StartTime_Créneau] [time](7) NULL,
	[EndTime_Créneau] [time](7) NULL,
	[LeaveType] [nvarchar](250) NULL,
	[LeaveStatus] [varchar](8) NULL,
	[StartTimeAbsence] [time](7) NULL,
	[EndTimeAbsence] [time](7) NULL,
	[Conges] [numeric](2, 1) NULL,
	[CongesMaladie] [numeric](2, 1) NULL,
	[Conges_SansSoldes] [numeric](2, 1) NULL,
	[Créneau_Travaillé] [numeric](2, 1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[FctTimeSheetLineHours]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[FctTimeSheetLineHours](
	[EmployeeID] [int] NOT NULL,
	[CRAStatus] [nvarchar](255) NULL,
	[MonthCRA] [varchar](100) NULL,
	[DayOfMonth] [varchar](30) NULL,
	[DayName] [nvarchar](30) NULL,
	[TheDay] [int] NULL,
	[TheDayOfWeek] [int] NULL,
	[TheDayOfYear] [int] NULL,
	[TheWeekOfMonth] [varchar](1) NULL,
	[Month] [nvarchar](30) NULL,
	[TheMonth] [int] NULL,
	[Quarter] [int] NULL,
	[Year] [int] NULL,
	[DayOff] [nvarchar](255) NULL,
	[Regime] [varchar](6) NULL,
	[DailyWorkDuration] [int] NULL,
	[TotalWork] [int] NULL,
	[TotalLeave] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[FeedLOG]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[FeedLOG](
	[TableName] [nvarchar](255) NULL,
	[InsertedRowsNumber] [int] NULL,
	[Date] [datetime] NULL,
	[ErrorMessage] [nvarchar](4000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIAmountPerSalaryRule]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIAmountPerSalaryRule](
	[IdSalaryRule] [int] NULL,
	[Rule] [nvarchar](255) NULL,
	[Gain] [float] NULL,
	[Deduction] [float] NULL,
	[RuleFormula] [nvarchar](2000) NULL,
	[Year] [int] NULL,
	[Month] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIAmountsPerImmobilisation]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIAmountsPerImmobilisation](
	[Month] [int] NULL,
	[Year] [int] NULL,
	[AccountLabel] [nvarchar](255) NULL,
	[CurrentImmobilisationAmount] [float] NULL,
	[LastMonthImmobilisationAmount] [float] NULL,
	[LastYearImmobilisationAmount] [float] NULL,
	[LastMonthLastYearImmobilisationAmount] [float] NULL,
	[YearToDateImmobilisationAmount] [float] NULL,
	[LastYearYearToDateImmobilisationAmount] [float] NULL,
	[VariationCurrentMonthLastMonthImmobilisationAmount] [float] NULL,
	[VariationCurrentYearLastYearImmobilisationAmount] [float] NULL,
	[VariationCurrentYearToDateLastYearToDateImmobilisationAmount] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIAverageRevenuePerCustomer]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIAverageRevenuePerCustomer](
	[CA] [numeric](19, 3) NULL,
	[FiscalYear] [nvarchar](255) NULL,
	[Month] [nvarchar](255) NULL,
	[CustomerNumber] [int] NULL,
	[AccountLabel] [nvarchar](255) NULL,
	[AccountCode] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPICandidaciesPerRecruitment]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPICandidaciesPerRecruitment](
	[Year] [int] NULL,
	[Month] [int] NULL,
	[RecruitmentDescription] [nvarchar](255) NULL,
	[CandidaciesCurrentYear] [int] NULL,
	[CandidaciesLastMonth] [int] NULL,
	[CandidaciesLastYearLastMonth] [int] NULL,
	[CandidaciesLastYear] [int] NULL,
	[CandidaciesYearToDate] [int] NULL,
	[CandidaciesLastYearToDate] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIClaimsPerProduct]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIClaimsPerProduct](
	[IdClaim] [int] NULL,
	[ClaimCode] [nvarchar](255) NULL,
	[ClaimDescription] [nvarchar](255) NULL,
	[DocumentDate] [datetime] NULL,
	[ClaimQty] [float] NULL,
	[IdClaimStatus] [int] NULL,
	[LabelClaimStatus] [nvarchar](255) NULL,
	[IdItem] [int] NULL,
	[ItemCode] [nvarchar](255) NULL,
	[ItemDescription] [nvarchar](255) NULL,
	[LabelItemFamily] [nvarchar](255) NULL,
	[LabelItemNature] [nvarchar](255) NULL,
	[LabelSubFamily] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIConversionRate]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIConversionRate](
	[DocumentId] [int] NULL,
	[DocumentType] [nvarchar](255) NULL,
	[Month] [int] NULL,
	[Year] [int] NULL,
	[TiersName] [nvarchar](255) NULL,
	[Type] [nvarchar](255) NULL,
	[QtyDelivered] [int] NULL,
	[QtyOrdered] [int] NULL,
	[ConversionRate1] [float] NULL,
	[ConversionRate2] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIConversionRateDetails]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIConversionRateDetails](
	[IdDocumentLine] [int] NULL,
	[IdDocument] [int] NULL,
	[DocumentType] [nvarchar](255) NULL,
	[Month] [int] NULL,
	[Year] [int] NULL,
	[IdItem] [int] NULL,
	[ItemDescription] [nvarchar](255) NULL,
	[ItemNature] [nvarchar](255) NULL,
	[ItemFamily] [nvarchar](255) NULL,
	[TiersName] [nvarchar](255) NULL,
	[Type] [nvarchar](255) NULL,
	[QtyDelivered] [int] NULL,
	[QtyOrdered] [int] NULL,
	[ConversionRateDetails] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPICustomerAcquisitionCost]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPICustomerAcquisitionCost](
	[CAC] [float] NULL,
	[FiscalYear] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIDailyLeaves]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIDailyLeaves](
	[EmployeeID] [int] NULL,
	[EmployeeName] [nvarchar](255) NULL,
	[TeamName] [nvarchar](255) NULL,
	[DayOfMonth] [date] NULL,
	[DayName] [nvarchar](30) NULL,
	[TheDay] [int] NULL,
	[TheDayOfWeek] [int] NULL,
	[TheMonth] [int] NULL,
	[Year] [int] NULL,
	[Créneau] [nvarchar](255) NULL,
	[LeaveType] [nvarchar](250) NULL,
	[LeaveStatus] [nvarchar](8) NULL,
	[StartTimeAbsence] [time](7) NULL,
	[EndTimeAbsence] [time](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIDelayedPayment]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIDelayedPayment](
	[Year] [float] NULL,
	[Month] [float] NULL,
	[DelayedPaymentCurrentYear] [float] NULL,
	[DelayedPaymentLastMonth] [float] NULL,
	[DelayedPaymentLastMonthLastYear] [float] NULL,
	[DelayedPaymentLastYear] [float] NULL,
	[DelayedPaymentYearToDate] [float] NULL,
	[DelayedPaymentYearToDateLastYear] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIEmployeeByOffice]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIEmployeeByOffice](
	[Office] [nvarchar](55) NULL,
	[TotalEmployees] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIEmployerChargePerEmployee]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIEmployerChargePerEmployee](
	[IdPayslip] [int] NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[IdContract] [int] NULL,
	[IdEmployee] [int] NULL,
	[IdSession] [int] NULL,
	[ChargePatronale] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIEmployerChargePerTeam]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIEmployerChargePerTeam](
	[PayslipMonth] [int] NULL,
	[PayslipYear] [int] NULL,
	[IdTeam] [int] NULL,
	[TeamName] [nvarchar](255) NULL,
	[TeamCode] [nvarchar](255) NULL,
	[EmployerContributorPerTeam] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIFinancialCommitmentNonPaidAmounts]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIFinancialCommitmentNonPaidAmounts](
	[Year] [float] NULL,
	[Month] [float] NULL,
	[NonPaidAmountsCurrentYear] [float] NULL,
	[NonPaidAmountsLastMonth] [float] NULL,
	[NonPaidAmountsLastMonthLastYear] [float] NULL,
	[NonPaidAmountsLastYear] [float] NULL,
	[NonPaidAmountsYearToDate] [float] NULL,
	[NonPaidAmountsYearToDateLastYear] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIGrossMargin]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIGrossMargin](
	[Year] [int] NULL,
	[Month] [int] NULL,
	[GrossMarginCurrentYear] [float] NULL,
	[GrossMarginLastMonth] [float] NULL,
	[GrossMarginLastYear] [float] NULL,
	[GrossMarginLastMonthLastYear] [float] NULL,
	[GrossMarginYearToDate] [float] NULL,
	[GrossMarginLastYearYearToDate] [float] NULL,
	[GrossMarginVariationCurrentMonthLastMonth] [float] NULL,
	[GrossMarginVariationCurrentYearLastYear] [float] NULL,
	[GrossMarginVariationCurrentYearToDateLastYearToDate] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIGrossOperatingSurplus]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIGrossOperatingSurplus](
	[Year] [int] NULL,
	[Month] [int] NULL,
	[GrossOperatingSurplusCurrentYear] [float] NULL,
	[GrossOperatingSurplusLastMonth] [float] NULL,
	[GrossOperatingSurplusLastMonthLastYear] [float] NULL,
	[GrossOperatingSurplusLastYear] [float] NULL,
	[GrossOperatingSurplusYearToDate] [float] NULL,
	[GrossOperatingSurplusYearToDateLastYear] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIInterviewByCandidacy]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIInterviewByCandidacy](
	[IdRecruitment] [int] NULL,
	[RecruitmentDescription] [nvarchar](55) NULL,
	[RecruitmentCreationDate] [date] NULL,
	[RecruitmentClosingDate] [date] NULL,
	[RecruitmentYear] [int] NULL,
	[RecruitmentMonth] [int] NULL,
	[RecruitmentDuration] [int] NULL,
	[IdCandidacy] [int] NULL,
	[CandidateFirstName] [nvarchar](55) NULL,
	[InterviewType] [nvarchar](55) NULL,
	[CountTotalInterview] [int] NULL,
	[CountInterviewRH] [int] NULL,
	[CountInterviewTechnical] [int] NULL,
	[CountInterviewFunctional] [int] NULL,
	[CountInterviewPsychotechnical] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIInterviewDetails]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIInterviewDetails](
	[IdInterview] [int] NULL,
	[InterviewDate] [datetime] NULL,
	[InterviewType] [nvarchar](255) NULL,
	[InterviewStatus] [nvarchar](255) NULL,
	[CandidateName] [nvarchar](255) NULL,
	[IdSupervisor] [int] NULL,
	[SupervisorName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPILeaveDistribution]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPILeaveDistribution](
	[year] [int] NULL,
	[TheMonth] [int] NULL,
	[TheWeekOfMonth] [varchar](1) NULL,
	[TheDay] [int] NULL,
	[LeaveType] [nvarchar](250) NULL,
	[Monday] [numeric](38, 1) NULL,
	[Tuesday] [numeric](38, 1) NULL,
	[Wednesday] [numeric](38, 1) NULL,
	[Thursday] [numeric](38, 1) NULL,
	[Friday] [numeric](38, 1) NULL,
	[Saturday] [numeric](38, 1) NULL,
	[Sunday] [numeric](38, 1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPINeedInFunds]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPINeedInFunds](
	[Year] [int] NULL,
	[Month] [int] NULL,
	[NeedInFundsCurrentYear] [float] NULL,
	[NeedInFundsLastMonth] [float] NULL,
	[NeedInFundsLastMonthLastYear] [float] NULL,
	[NeedInFundsLastYear] [float] NULL,
	[NeedInFundsYearToDate] [float] NULL,
	[NeedInFundsYearToDateLastYear] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIOrderState]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIOrderState](
	[DocumentDate] [datetime] NULL,
	[Year] [int] NULL,
	[Month] [int] NULL,
	[IdOrder] [int] NULL,
	[OrderCode] [nvarchar](255) NULL,
	[HtAmount] [float] NULL,
	[IdStatus] [int] NULL,
	[DocumentStatus] [nvarchar](255) NULL,
	[TiersName] [nvarchar](255) NULL,
	[TiersCode] [nvarchar](255) NULL,
	[Type] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIPaymentMethodPerClient]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIPaymentMethodPerClient](
	[Year] [int] NULL,
	[Month] [int] NULL,
	[PaymentMethod] [nvarchar](255) NULL,
	[PaymentMethodCurrentYear] [int] NULL,
	[PaymentMethodLastMonth] [int] NULL,
	[PaymentMethodLastYearLastMonth] [int] NULL,
	[PaymentMethodLastYear] [int] NULL,
	[PaymentMethodYearToDate] [int] NULL,
	[PaymentMethodLastYearToDate] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIPayrollPerEmployee]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIPayrollPerEmployee](
	[IdPayslip] [int] NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[IdContract] [int] NULL,
	[IdEmployee] [int] NULL,
	[IdSession] [int] NULL,
	[MasseSalariale] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIProductivity]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIProductivity](
	[year] [int] NULL,
	[month] [int] NULL,
	[DocumentTypeCode] [varchar](50) NULL,
	[productivity] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIRecruitmentsByOffice]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIRecruitmentsByOffice](
	[Year] [int] NULL,
	[Month] [int] NULL,
	[Office] [nvarchar](55) NULL,
	[OfficeRecruitmentCurrentYear] [int] NULL,
	[OfficeRecruitmentLastMonth] [int] NULL,
	[OfficeRecruitmentLastYearLastMonth] [int] NULL,
	[OfficeRecruitmentLastYear] [int] NULL,
	[OfficeRecruitmentYearToDate] [int] NULL,
	[OfficeRecruitmentLastYearToDate] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIRetentionRate]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIRetentionRate](
	[Year] [float] NULL,
	[Month] [float] NULL,
	[RetentionRateCurrentYear] [float] NULL,
	[RetentionRateLastMonth] [float] NULL,
	[RetentionRateLastMonthLastYear] [float] NULL,
	[RetentionRateLastYear] [float] NULL,
	[RetentionRateYearToDate] [float] NULL,
	[RetentionRateYearToDateLastYear] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPISalesPerItem]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPISalesPerItem](
	[HtTotalPerItem] [float] NULL,
	[QuantityPerItem] [float] NULL,
	[IdItem] [int] NULL,
	[ItemCode] [nvarchar](255) NULL,
	[ItemDescription] [nvarchar](255) NULL,
	[LabelItemFamily] [nvarchar](255) NULL,
	[OperationType] [nvarchar](20) NULL,
	[PeriodEnum] [tinyint] NULL,
	[Period] [nvarchar](50) NULL,
	[StartPeriod] [date] NULL,
	[EndPeriod] [date] NULL,
	[RankByAmount] [int] NULL,
	[RankByQuantity] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPISalesPerItemFamily]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPISalesPerItemFamily](
	[HtTotalPerItemFamily] [float] NULL,
	[QuantityPerItemFamily] [int] NULL,
	[ItemFamily] [nvarchar](255) NULL,
	[OperationType] [nvarchar](255) NULL,
	[PeriodEnum] [tinyint] NULL,
	[Period] [nvarchar](50) NULL,
	[StartPeriod] [date] NULL,
	[EndPeriod] [date] NULL,
	[RankByAmount] [int] NULL,
	[RankByQuantity] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPISalesPurchasesState]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPISalesPurchasesState](
	[InvoiceAmountHT] [float] NULL,
	[InvoiceAmountTTC] [float] NULL,
	[InvoiceRemainingAmount] [float] NULL,
	[Month] [tinyint] NULL,
	[Year] [smallint] NULL,
	[Type] [nvarchar](255) NULL,
	[PeriodEnum] [tinyint] NULL,
	[Period] [nvarchar](50) NULL,
	[StartPeriod] [date] NULL,
	[EndPeriod] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPISearchItems]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPISearchItems](
	[Month] [int] NULL,
	[Year] [int] NULL,
	[SearchItemValue] [nvarchar](255) NULL,
	[ItemCode] [nvarchar](255) NULL,
	[ItemDescription] [nvarchar](max) NULL,
	[NumberSearched] [int] NULL,
	[SearchMethod] [nvarchar](15) NULL,
	[Rank] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPITopTiers]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPITopTiers](
	[DocumentDate] [datetime] NULL,
	[DocumentMonth] [int] NULL,
	[PeriodEnum] [tinyint] NULL,
	[Period] [nvarchar](50) NULL,
	[StartPeriod] [date] NULL,
	[EndPeriod] [date] NULL,
	[DocumentYear] [int] NULL,
	[IdTiers] [int] NULL,
	[TiersName] [nvarchar](255) NULL,
	[TiersCode] [nvarchar](255) NULL,
	[HTAmount] [float] NULL,
	[TTCAmount] [float] NULL,
	[Quantity] [int] NULL,
	[Type] [nvarchar](255) NULL,
	[RankByTTCAmount] [int] NULL,
	[RankByQuantity] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPITotalDepreciationPerAccount]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPITotalDepreciationPerAccount](
	[Year] [int] NULL,
	[Month] [int] NULL,
	[AccountLabel] [nvarchar](255) NULL,
	[CurrentDepreciationAmount] [float] NULL,
	[LastMonthDepreciationAmount] [float] NULL,
	[LastYearDepreciationAmount] [float] NULL,
	[LastMonthLastYearDepreciationAmount] [float] NULL,
	[YearToDateDepreciationAmount] [float] NULL,
	[LastYearYearToDateDepreciationAmount] [float] NULL,
	[VariationCurrentLMonthLastMonthDepreciationAmount] [float] NULL,
	[VariationCurrentYearLastYearDepreciationAmount] [float] NULL,
	[VariationYearToDateLastYearToDateDepreciationAmount] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPITotalEmployerCharge]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPITotalEmployerCharge](
	[Month] [int] NULL,
	[Year] [int] NULL,
	[TotalEmployerCharge] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPITotalGrossPayroll]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPITotalGrossPayroll](
	[Month] [int] NULL,
	[Year] [int] NULL,
	[TotalGrossPayroll] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPITotalPremium]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPITotalPremium](
	[Month] [int] NULL,
	[Year] [int] NULL,
	[TotalPremium] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPITotalWorkDays]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPITotalWorkDays](
	[IdEmployee] [int] NULL,
	[EmployeeName] [nvarchar](255) NULL,
	[Year] [int] NULL,
	[Month] [int] NULL,
	[CRAStatus] [nvarchar](255) NULL,
	[MonthCRA] [varchar](100) NULL,
	[TotalWorkDays] [float] NULL,
	[IdTeam] [int] NULL,
	[TeamName] [nvarchar](255) NULL,
	[TotalDayOff] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPITurnoverChangeRate]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPITurnoverChangeRate](
	[FirstYear] [date] NULL,
	[SecondYear] [date] NULL,
	[Month] [date] NULL,
	[DocumentTypeCode] [nvarchar](55) NULL,
	[TurnoverFirstYear] [float] NULL,
	[TurnoverSecondYear] [float] NULL,
	[ChangeRate] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPITurnoverPerSales]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPITurnoverPerSales](
	[Year] [float] NULL,
	[Month] [float] NULL,
	[TurnoverPerSalesCurrentYear] [float] NULL,
	[TurnoverPerSalesLastMonth] [float] NULL,
	[TurnoverPerSalesLastMonthLastYear] [float] NULL,
	[TurnoverPerSalesLastYear] [float] NULL,
	[TurnoverPerSalesYearToDate] [float] NULL,
	[TurnoverPerSalesYearToDateLastYear] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIUpcomingEmployeeEvent]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIUpcomingEmployeeEvent](
	[IdEmployee] [int] NULL,
	[EmployeeName] [nvarchar](50) NULL,
	[EventDate] [date] NULL,
	[ContractReference] [nvarchar](255) NULL,
	[SalaryStructureReference] [nvarchar](50) NULL,
	[NextContractAnniversary] [nvarchar](255) NULL,
	[EventType] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPIUpcomingInterviews]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPIUpcomingInterviews](
	[Year] [float] NULL,
	[Month] [float] NULL,
	[Day] [float] NULL,
	[WeekOfMonth] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[LeaveConsolidated]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[LeaveConsolidated](
	[ID] [int] NULL,
	[EmployeeName] [varchar](100) NULL,
	[Gender] [int] NULL,
	[Age] [int] NULL,
	[SalaryStructureReference] [nvarchar](255) NULL,
	[TeamName] [nvarchar](255) NULL,
	[DepartmentName] [nvarchar](255) NULL,
	[ProjectName] [nvarchar](125) NULL,
	[CRAStatus] [varchar](18) NULL,
	[MonthCRA] [varchar](100) NULL,
	[IdLeave] [int] NULL,
	[StartLeave] [varchar](81) NULL,
	[EndLeave] [varchar](81) NULL,
	[SubmissionDate] [datetime] NULL,
	[DayCalculator] [float] NULL,
	[LeaveType] [nvarchar](250) NULL,
	[LeaveStatus] [varchar](8) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[ParameterPeriod]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[ParameterPeriod](
	[PeriodEnum] [int] NULL,
	[Period] [nvarchar](255) NULL,
	[StartPeriod] [date] NULL,
	[EndPeriod] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[ParameterReference]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[ParameterReference](
	[Reference] [nvarchar](255) NULL,
	[Code] [nvarchar](255) NULL,
	[LabelFr] [nvarchar](255) NULL,
	[LabelEng] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[SearchLOG]    Script Date: 4/6/2021 3:54:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[SearchLOG](
	[Id] [int] NULL,
	[IdTiers] [int] NULL,
	[Date] [datetime] NULL,
	[IdCashier] [int] NULL,
	[Property] [nvarchar](255) NULL,
	[Value] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimJob]    Script Date: 4/6/2021 3:54:03 ******/

CREATE TABLE [Reporting].[DimJob](
[IdJob] [int] NOT NULL,
[Designation] [nvarchar](max) NOT NULL,
CONSTRAINT [PK_Dim.Job] PRIMARY KEY CLUSTERED
(
[IdJob] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

--------------------------- Rahma add create and exec proc garage 15/04/2021----------------------------------

/****** Object:  Table [Reporting].[DimCustomerParts]    Script Date: 4/12/2021 5:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimCustomerParts](
	[IdCustomerPart] [int] NULL,
	[CustomerPartReference] [nvarchar](255) NULL,
	[CustomerPartDesignation] [nvarchar](255) NULL,
	[CustomerPartQuantity] [float] NULL,
	[IdIntervention] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimGarage]    Script Date: 4/12/2021 5:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimGarage](
	[IdGarage] [int] NULL,
	[GarageName] [nvarchar](255) NULL,
	[GaragePhone] [nvarchar](255) NULL,
	[GarageAdress] [nvarchar](255) NULL,
	[IdCountry] [int] NULL,
	[CountryName] [nvarchar](255) NULL,
	[IdWarehouse] [int] NULL,
	[WarehouseName] [nvarchar](255) NULL,
	[IdWorker] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimMachine]    Script Date: 4/12/2021 5:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimMachine](
	[IdMachine] [int] NULL,
	[MachineName] [nvarchar](255) NULL,
	[MachineState] [int] NULL,
	[MachineConstructor] [nvarchar](255) NULL,
	[MachineModel] [nvarchar](255) NULL,
	[IdPost] [int] NULL,
	[IdOperation] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimMileage]    Script Date: 4/12/2021 5:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimMileage](
	[IdMileage] [int] NULL,
	[MileageValue] [numeric](18, 0) NULL,
	[MileageName] [nvarchar](255) NULL,
	[IdOperation] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimOperation]    Script Date: 4/12/2021 5:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimOperation](
	[IdOperation] [int] NULL,
	[OperationName] [nvarchar](255) NULL,
	[OperationType] [nvarchar](255) NULL,
	[ExpectedDuration] [int] NULL,
	[OperationKitName] [nvarchar](255) NULL,
	[HTPrice] [float] NULL,
	[ItemQuantity] [int] NULL,
	[IdItem] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimPost]    Script Date: 4/12/2021 5:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimPost](
	[IdPost] [int] NULL,
	[PostName] [nvarchar](255) NULL,
	[IdGarage] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimReception]    Script Date: 4/12/2021 5:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimReception](
	[IdReception] [nvarchar](255) NULL,
	[ReceiptDate] [date] NULL,
	[ReceiptHours] [time](7) NULL,
	[CurrentMileage] [float] NULL,
	[FuelLevel] [float] NULL,
	[CigaretteLigher] [bit] NULL,
	[CrickTools] [bit] NULL,
	[SpareWheel] [bit] NULL,
	[Radio] [bit] NULL,
	[HandTools] [bit] NULL,
	[HubCap] [bit] NULL,
	[IdVehicle] [int] NULL,
	[IdReceiverWorker] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimVehicle]    Script Date: 4/12/2021 5:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimVehicle](
	[IdVehicle] [int] NULL,
	[RegistrationNumber] [nvarchar](255) NULL,
	[ChassisNumber] [nvarchar](255) NULL,
	[VehiclePower] [nvarchar](255) NULL,
	[FirstTraficDate] [datetime] NULL,
	[IdVehicleBrand] [int] NULL,
	[VehicleBrandCode] [nvarchar](255) NULL,
	[VehicleBrandDesignation] [nvarchar](255) NULL,
	[IdVehicleModel] [int] NULL,
	[VehicleModelCode] [nvarchar](255) NULL,
	[VehicleModelDesignation] [nvarchar](255) NULL,
	[IdVehicleEnergy] [int] NULL,
	[VehicleEnergyName] [nvarchar](255) NULL,
	[IdVehicleType] [int] NULL,
	[VehicleTypeName] [nvarchar](255) NULL,
	[IdTiers] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DimWorker]    Script Date: 4/12/2021 5:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DimWorker](
	[IdWorker] [int] NULL,
	[FirstNameWorker] [nvarchar](255) NULL,
	[LastNameWorker] [nvarchar](255) NULL,
	[AdressWorker] [nvarchar](255) NULL,
	[PhoneWorker] [nvarchar](255) NULL,
	[EmailWorker] [nvarchar](255) NULL,
	[CinWorker] [nvarchar](255) NULL,
	[IdGarage] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[FctIntervention]    Script Date: 4/12/2021 5:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[FctIntervention](
	[IdIntervention] [int] NULL,
	[InterventionDate] [datetime] NULL,
	[InterventionTTCPrice] [float] NULL,
	[InterventionStatus] [nvarchar](255) NULL,
	[InterventionCode] [nvarchar](255) NULL,
	[IdOperation] [int] NULL,
	[IdGarage] [int] NULL,
	[IdReception] [int] NULL,
	[IdMileage] [int] NULL,
	[IdDocument] [int] NULL,
	[DocumentCode] [nvarchar](255) NULL,
	[DocumentTypeCode] [nvarchar](255) NULL,
	[IdDocumentStatus] [int] NULL,
	[DocumentHTPrice] [float] NULL,
	[DocumentTTCPrice] [float] NULL,
	[DocumentStatus] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPITotalInterventionPerGarage]    Script Date: 4/12/2021 5:24:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Reporting].[KPITotalInterventionPerGarage](
	[TotalIntervention] [int] NULL,
	[IdGarage] [int] NULL,
	[GarageName] [nvarchar](255) NULL,
	[PeriodEnum] [tinyint] NULL,
	[Period] [nvarchar](50) NULL,
	[StartPeriod] [date] NULL,
	[EndPeriod] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[KPITurnoverPerGarage]    Script Date: 4/12/2021 5:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[KPITurnoverPerGarage](
	[IdGarage] [int] NULL,
	[GarageName] [nvarchar](255) NULL,
	[TTCAmount] [float] NULL,
	[PeriodEnum] [tinyint] NULL,
	[Period] [nvarchar](50) NULL,
	[StartPeriod] [date] NULL,
	[EndPeriod] [date] NULL
) ON [PRIMARY]
GO
----------------------------------------Rahma create  [Reporting].[Cartes] 22/04/2021----------------------------------------------
CREATE TABLE [Reporting].[Cartes](
	[Module] [nvarchar](255) NULL,
	[Label] [nvarchar](255) NULL,
	[Date] [nvarchar](255) NULL,
	[Month] [nvarchar](255) NULL,
	[Day] [nvarchar](255) NULL,
	[WeekOfMonth] [nvarchar](255) NULL,
	[Value] [float] NULL
) ON [PRIMARY]
GO
---------Rahma delete DimSalaryStructure 26/04/2021---------
DROP TABLE [Reporting].[DimSalaryStructure]
GO

-------------------------- Rahma add kpiDeliveryRate 10/05/2021------------------------------------------

/****** Object:  Table [Reporting].[KPIDeliveryRate]    Script Date: 5/10/2021 12:33:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Reporting].[KPIDeliveryRate](
	[TotalCommanded] [int] NULL,
	[TotalDelivred] [int] NULL,
	[DeliveryRate] [float] NULL,
	[DocumentMonth] [int] NULL,
	[DocumentYear] [int] NULL,
	[PeriodEnum] [tinyint] NULL,
	[Period] [nvarchar](50) NULL,
	[StartPeriod] [date] NULL,
	[EndPeriod] [date] NULL
) ON [PRIMARY]
GO

--------------------------- Rahma delete garage table 10/05/2021----------------------------------------

DROP TABLE [Reporting].DimCustomerParts
GO
DROP TABLE [Reporting].DimGarage
GO
DROP TABLE [Reporting].DimMachine
GO
DROP TABLE [Reporting].DimMileage
GO
DROP TABLE [Reporting].DimOperation
GO
DROP TABLE [Reporting].DimPost
GO
DROP TABLE [Reporting].DimReception
GO
DROP TABLE [Reporting].DimVehicle
GO
DROP TABLE [Reporting].DimWorker
GO
DROP TABLE [Reporting].FctIntervention
GO
DROP TABLE [Reporting].KPITotalInterventionPerGarage
GO
DROP TABLE [Reporting].KPITurnoverPerGarage
GO


---------------------Rahma drop and create KPISalesPurchasesState 17/05/2021---------------------------------------------

/****** Object:  Table [Reporting].[KPISalesPurchasesState]    Script Date: 17/05/2021 11:15:58 ******/
DROP TABLE [Reporting].[KPISalesPurchasesState]
GO

/****** Object:  Table [Reporting].[KPISalesPurchasesState]    Script Date: 17/05/2021 11:15:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Reporting].[KPISalesPurchasesState](
	[InvoiceAmountHT] [float] NULL,
	[InvoiceAmountTTC] [float] NULL,
	[InvoiceRemainingAmount] [float] NULL,
	[Month] [tinyint] NULL,
	[Year] [smallint] NULL,
	[Type] [nvarchar](255) NULL,
	[PeriodEnum] [tinyint] NULL,
	[Period] [nvarchar](50) NULL,
	[StartPeriod] [date] NULL,
	[EndPeriod] [date] NULL,
	[YTDInvoiceAmountHT] [float] NULL,
	[YTDInvoiceAmountTTC] [float] NULL,
	[LYTDInvoiceAmountHT] [float] NULL,
	[LYTDInvoiceAmountTTC] [float] NULL
) ON [PRIMARY]
GO

--------------------------------Rahma update KPIDeliveryRate 18/05/2021---------------------------------



/****** Object:  Table [Reporting].[KPIDeliveryRate]    Script Date: 18/05/2021 16:11:52 ******/
DROP TABLE [Reporting].[KPIDeliveryRate]
GO

/****** Object:  Table [Reporting].[KPIDeliveryRate]    Script Date: 18/05/2021 16:11:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Reporting].[KPIDeliveryRate](
	[TotalCommanded] [int] NULL,
	[TotalDelivred] [int] NULL,
	[DeliveryRate] [float] NULL,
	[DocumentMonth] [int] NULL,
	[DocumentYear] [int] NULL,
	[PeriodEnum] [tinyint] NULL,
	[Period] [nvarchar](50) NULL,
	[StartPeriod] [date] NULL,
	[EndPeriod] [date] NULL,
	[Type] [nvarchar](255) NULL
) ON [PRIMARY]
GO

-------------------------------------------Rahma update Cartes 18/05/2021-------------------------------------


/****** Object:  Table [Reporting].[Cartes]    Script Date: 19/05/2021 11:17:26 ******/
DROP TABLE [Reporting].[Cartes]
GO

/****** Object:  Table [Reporting].[Cartes]    Script Date: 19/05/2021 11:17:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Reporting].[Cartes](
	[Module] [nvarchar](255) NULL,
	[Label] [nvarchar](255) NULL,
	[Year] [nvarchar](255) NULL,
	[Month] [nvarchar](255) NULL,
	[Day] [nvarchar](255) NULL,
	[WeekOfMonth] [nvarchar](255) NULL,
	[Value] [float] NULL
) ON [PRIMARY]
GO






