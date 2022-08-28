---Rahma add fullName column to user ,employee and candidate tables 29/07/2021
ALTER TABLE [ERPSettings].[User]
    ADD [FullName] NVARCHAR (255) NULL;

GO
ALTER TABLE [Payroll].[Employee]
    ADD [FullName] NVARCHAR (100) NULL;
GO
ALTER TABLE [RH].[Candidate]
    ADD [FullName] NVARCHAR (100) NULL;
---Ghazoua add AllowRelationSupplierItems in company table 01/09/2021
ALTER TABLE [Shared].[Company]
    ADD  AllowRelationSupplierItems BIT            DEFAULT ('false') NOT NULL;


--- Rahma add Table [Sales].[VehicleEnergy]   Script Date: 03/09/2021 16:58:58 

CREATE TABLE [Sales].[VehicleEnergy](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[TransactionUserId] [int] NULL,
 CONSTRAINT [PK_VehicleEnergy] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--- Rahma add Table [Sales].[Vehicle]   Script Date: 03/09/2021 16:58:58 

CREATE TABLE [Sales].[Vehicle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTiers] [int] NULL,
	[IdVehicleBrand] [int] NULL,
	[IdVehicleModel] [int] NULL,
	[IdVehicleEnergy] [int] NULL,
	[RegistrationNumber] [nvarchar](255) NOT NULL,
	[ChassisNumber] [nvarchar](255) NULL,
	[Power] [nvarchar](255) NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
	[TransactionUserId] [int] NULL,
 CONSTRAINT [PK_Vehicle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Sales].[Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle_ModelOfItem] FOREIGN KEY([IdVehicleModel])
REFERENCES [Inventory].[ModelOfItem] ([Id])
GO

ALTER TABLE [Sales].[Vehicle] CHECK CONSTRAINT [FK_Vehicle_ModelOfItem]
GO

ALTER TABLE [Sales].[Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
GO

ALTER TABLE [Sales].[Vehicle] CHECK CONSTRAINT [FK_Vehicle_Tiers]
GO

ALTER TABLE [Sales].[Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle_VehicleBrand] FOREIGN KEY([IdVehicleBrand])
REFERENCES [Inventory].[VehicleBrand] ([Id])
GO

ALTER TABLE [Sales].[Vehicle] CHECK CONSTRAINT [FK_Vehicle_VehicleBrand]
GO

ALTER TABLE [Sales].[Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle_VehicleEnergy] FOREIGN KEY([IdVehicleEnergy])
REFERENCES [Sales].[VehicleEnergy] ([Id])
GO

ALTER TABLE [Sales].[Vehicle] CHECK CONSTRAINT [FK_Vehicle_VehicleEnergy]
GO

--Ahmed 06/09/2021

-- Add SalesPrice table
GO
CREATE TABLE [Sales].[SalesPrice] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Code]              NVARCHAR (255) NOT NULL,
    [Label]             NVARCHAR (255) NULL,
    [IsActivated]       BIT            NOT NULL,
	[Value]				FLOAT	 (53)  NOT NULL DEFAULT ((0)),
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_SalesPrice] PRIMARY KEY CLUSTERED ([Id] ASC)
);

-- Add ItemSalesPrice table 
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Inventory].[ItemSalesPrice](
	[Id]				int IDENTITY(1,1) NOT NULL,
	[IdItem]			int				NOT NULL,
	[IdSalesPrice]		int				NOT NULL,
	[Price]				FLOAT(53)		NOT NULL,
	[Percentage]		FLOAT(53)		NOT NULL,
	[DeletedToken]		nchar(250)		NULL,
	[IsDeleted]			bit				NOT NULL,
 CONSTRAINT [PK_ItemSlaesPrice] PRIMARY KEY CLUSTERED ([Id] ASC)
 );
GO

ALTER TABLE [Inventory].[ItemSalesPrice]  WITH CHECK ADD  CONSTRAINT [FK_ItemSalesPrice_Item] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [Inventory].[ItemSalesPrice] CHECK CONSTRAINT [FK_ItemSalesPrice_Item]
GO

ALTER TABLE [Inventory].[ItemSalesPrice]  WITH CHECK ADD  CONSTRAINT [FK_ItemSalesPrice_SalesPrice] FOREIGN KEY([IdSalesPrice])
REFERENCES [Sales].[SalesPrice] ([Id])
GO

ALTER TABLE [Inventory].[ItemSalesPrice] CHECK CONSTRAINT [FK_ItemSalesPrice_SalesPrice]
GO

-- Add IdSalesPrice to tiers table 
GO
ALTER TABLE [Sales].[Tiers]
    ADD [IdSalesPrice] int  NULL;
GO
ALTER TABLE [Sales].[Tiers] WITH NOCHECK
    ADD CONSTRAINT [FK_Tiers_SalesPrice] FOREIGN KEY ([IdSalesPrice]) REFERENCES [Sales].[SalesPrice] ([Id]);
	

--- Bechir add Table [Sales].[TierCategory] and update Table [Sales].[Tiers] Date: 13/09/2021 13:58 
	GO
CREATE TABLE [Sales].[TierCategory] (
    [Id]            INT            IDENTITY (1, 1) NOT NULL,
    [Code]          NVARCHAR (50)  NOT NULL,
    [IsDeleted]     BIT            NOT NULL,
    [Deleted_Token] NVARCHAR (255) NULL,
    [Name]          NVARCHAR (255) NULL,
    CONSTRAINT [PK_TierCategory] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UniqueCodeTierCategory] UNIQUE NONCLUSTERED ([Code] ASC)
);

	GO
	ALTER TABLE [Sales].[Tiers]
		ADD [IdTierCategory] INT NULL;

--- Bechir edit Table [Sales].[Tiers] Date: 15/.09/2021 13:29

	GO
ALTER TABLE [Sales].[Tiers] WITH NOCHECK
    ADD CONSTRAINT [FK_Tiers_TierCategory] FOREIGN KEY ([IdTierCategory]) REFERENCES [Sales].[TierCategory] ([Id]);
--Ahmed 17/09/2021 delete price column from itemsalesprice table
GO
ALTER TABLE [Inventory].[ItemSalesPrice] DROP COLUMN [Price];
