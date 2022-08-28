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
	[EndPeriod] [date] NULL,
	[Type] [nvarchar](255) NULL
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