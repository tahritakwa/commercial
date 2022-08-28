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
