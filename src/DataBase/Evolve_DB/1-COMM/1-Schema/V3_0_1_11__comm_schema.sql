-- Molka : drop [IdCity] and [IdCountry]  from [Shared].[Office] 28-09-2020

ALTER TABLE [Shared].[Office] ADD [Twitter] NVARCHAR (255) NULL
ALTER TABLE [Shared].[Office] ADD [Email] NVARCHAR (255) NULL
ALTER TABLE [Shared].[Office] ADD [Fax] NVARCHAR (255) NULL
Go

--chedi: 16-12-2020 multi-supplier 

/****** Object:  Table [dbo].[ItemTiers]    Script Date: 08/09/2020 15:09:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Inventory].[ItemTiers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdItem] [int] NOT NULL,
	[IdTiers] [int] NOT NULL,
	[DeletedToken] [nchar](250) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ItemTiers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Inventory].[ItemTiers]  WITH CHECK ADD  CONSTRAINT [FK_ItemTiers_Item] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [Inventory].[ItemTiers] CHECK CONSTRAINT [FK_ItemTiers_Item]
GO

ALTER TABLE [Inventory].[ItemTiers]  WITH CHECK ADD  CONSTRAINT [FK_ItemTiers_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
GO

ALTER TABLE [Inventory].[ItemTiers] CHECK CONSTRAINT [FK_ItemTiers_Tiers]
GO

--chedi 19/01/2021 multisupplier
INSERT INTO [Inventory].[ItemTiers]
           ([IdItem]
           ,[IdTiers]
           ,[DeletedToken]
           ,[IsDeleted])
SELECT Id, IdTiers, null, 0 FROM Inventory.Item
where IdTiers is not null


alter table inventory.item drop constraint  UC_Item

alter table inventory.item drop constraint  FK_Item_Tiers


DROP INDEX index_name ON inventory.item;

alter table inventory.item drop column idtiers

CREATE NONCLUSTERED INDEX [index_name]
    ON [Inventory].[Item]([Id] ASC, [Code] ASC, [IdNature] ASC);


GO

GO
PRINT N'Altering [Inventory].[ItemTiers]...';


GO
ALTER TABLE [Inventory].[ItemTiers]
    ADD [PurchasePrice] FLOAT (53) NULL,
        [ExchangeRate]  FLOAT (53) NULL,
        [Margin]        FLOAT (53) NULL,
        [Cost]          FLOAT (53) NULL;


-- Mohamed BOUZIDI : Price new shema

ALTER TABLE [Inventory].[Item]	DROP	CONSTRAINT [FK_Item_DiscountGroupItem] 
ALTER TABLE [Inventory].[Item]	DROP	COLUMN [IdDiscountGroupItem]

ALTER TABLE [Sales].[Tiers]		DROP	CONSTRAINT [FK_Tiers_DiscountGroupTiers]
ALTER TABLE [Sales].[Tiers]		DROP	COLUMN [IdDiscountGroupTiers]

ALTER TABLE [Sales].[Prices]	DROP	CONSTRAINT [FK_Prices_DiscountGroupItem], 
										CONSTRAINT [FK_Prices_DiscountGroupTiers],
										CONSTRAINT [FK_Prices_Item], 
										CONSTRAINT [FK_Prices_Tiers],
										CONSTRAINT [FK_Prices_ContractServiceType],
										CONSTRAINT [DF_Prices_IsUsed],
										CONSTRAINT [DF_Prices_IsExclusif];
ALTER TABLE [Sales].[Prices]	DROP	COLUMN [IdDiscountGroupItem],
										COLUMN [IdDiscountGroupTiers],
										COLUMN [IdItem],
										COLUMN [IdTiers],
										COLUMN [IdContractServiceType],
										COLUMN [IsUsed],
										COLUMN [IsExclusive],										
										COLUMN [IdTypePrices],  
										COLUMN [StartDate],
										COLUMN [EndDate],
										COLUMN [MinQuantity],
										COLUMN [MaxQuantity],
										COLUMN [TypeValue],
										COLUMN [PricesValue],
										COLUMN [Observations],
										COLUMN [OrderDiscount],
										COLUMN [BonusTypeValue],
										COLUMN [BonusValue],
										COLUMN [BonusPercentage];

DROP TABLE [Inventory].[DiscountGroupItem]
DROP TABLE [Sales].[DiscountGroupTiers]
DROP TABLE [Sales].[ContractServiceType]

CREATE TABLE [Sales].[PriceDetail] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdPrices]          INT            NOT NULL,
    [StartDateTime]     DATETIME       NOT NULL,
    [EndDateTime]       DATETIME       NOT NULL,
    [Percentage]        FLOAT (53)     NULL,
    [ReducedValue]      FLOAT (53)     NULL,
    [SpecialPrice]      FLOAT (53)     NULL,
    [MinimumQuantity]   FLOAT (53)     NULL,
    [MaximumQuantity]   FLOAT (53)     NULL,
    [TotalPrices]       FLOAT (53)     NULL,
    [SaledItemsNumber]  FLOAT (53)     NULL,
    [GiftedItemsNumber] FLOAT (53)     NULL,
    [TypeOfPriceDetail] INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            CONSTRAINT [DF_PriceDetail_TransactionUserId] DEFAULT ((0)) NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_PriceDetail] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_PriceDetail_Prices] FOREIGN KEY ([IdPrices]) REFERENCES [Sales].[Prices] ([Id]) ON DELETE CASCADE
);
GO



CREATE TABLE [Inventory].[ItemPrices] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdItem]            INT            NOT NULL,
    [IdPrices]          INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            CONSTRAINT [DF_ItemPrices_TransactionUserId] DEFAULT ((0)) NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_ItemPrices] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_ItemPrices_ItemPrices] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_ItemPrices_Prices] FOREIGN KEY ([IdPrices]) REFERENCES [Sales].[Prices] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [IX_ItemPrices] UNIQUE NONCLUSTERED ([IdItem] ASC, [IdPrices] ASC, [Deleted_Token] ASC)
);
GO


CREATE TABLE [Sales].[TiersPrices] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdTiers]           INT            NOT NULL,
    [IdPrices]          INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            CONSTRAINT [DF_TiersPrices_TransactionUserId] DEFAULT ((0)) NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_TiersPrices] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_TiersPrices_Prices] FOREIGN KEY ([IdPrices]) REFERENCES [Sales].[Prices] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_TiersPrices_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [IX_TiersPrices] UNIQUE NONCLUSTERED ([IdPrices] ASC, [IdTiers] ASC, [Deleted_Token] ASC)
);
GO

-- chedi DERBALI: add shelf and storage tables 27/10/2020 

GO
PRINT N'Altering [Inventory].[ItemWarehouse]...';


GO
ALTER TABLE [Inventory].[ItemWarehouse]
    ADD [IdShelf]   INT NULL,
        [IdStorage] INT NULL;


GO
PRINT N'Creating [Inventory].[Shelf]...';


GO
CREATE TABLE [Inventory].[Shelf] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Label]             NVARCHAR (250) NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NOT NULL,
    [IdWharehouse]      INT            NULL,
    [IsDefault]         BIT            NULL,
    CONSTRAINT [PK_Shelf] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Inventory].[Storage]...';


GO
CREATE TABLE [Inventory].[Storage] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Label]             NVARCHAR (250) NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NOT NULL,
    [IdShelf]           INT            NULL,
    [IsDefault]         BIT            NULL,
    CONSTRAINT [PK_Storage] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Inventory].[DF_Shelf_TransactionUserId]...';


GO
ALTER TABLE [Inventory].[Shelf]
    ADD CONSTRAINT [DF_Shelf_TransactionUserId] DEFAULT ((0)) FOR [TransactionUserId];


GO
PRINT N'Creating [Inventory].[DF_Shelf_IsDeleted]...';


GO
ALTER TABLE [Inventory].[Shelf]
    ADD CONSTRAINT [DF_Shelf_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];


GO
PRINT N'Creating [Inventory].[DF_Storage_TransactionUserId]...';


GO
ALTER TABLE [Inventory].[Storage]
    ADD CONSTRAINT [DF_Storage_TransactionUserId] DEFAULT ((0)) FOR [TransactionUserId];


GO
PRINT N'Creating [Inventory].[DF_Storage_IsDeleted]...';


GO
ALTER TABLE [Inventory].[Storage]
    ADD CONSTRAINT [DF_Storage_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];


GO
PRINT N'Creating [Inventory].[FK_Shelf_Warehouse]...';


GO
ALTER TABLE [Inventory].[Shelf] WITH NOCHECK
    ADD CONSTRAINT [FK_Shelf_Warehouse] FOREIGN KEY ([IdWharehouse]) REFERENCES [Inventory].[Warehouse] ([Id]);


GO
PRINT N'Creating [Inventory].[FK_Storage_Shelf]...';


GO
ALTER TABLE [Inventory].[Storage] WITH NOCHECK
    ADD CONSTRAINT [FK_Storage_Shelf] FOREIGN KEY ([IdShelf]) REFERENCES [Inventory].[Shelf] ([Id]);


GO
PRINT N'Creating [Inventory].[FK_ItemWarehouse_Shelf]...';


GO
ALTER TABLE [Inventory].[ItemWarehouse] WITH NOCHECK
    ADD CONSTRAINT [FK_ItemWarehouse_Shelf] FOREIGN KEY ([IdShelf]) REFERENCES [Inventory].[Shelf] ([Id]);


GO
PRINT N'Creating [Inventory].[FK_ItemWarehouse_Storage]...';


GO
ALTER TABLE [Inventory].[ItemWarehouse] WITH NOCHECK
    ADD CONSTRAINT [FK_ItemWarehouse_Storage] FOREIGN KEY ([IdStorage]) REFERENCES [Inventory].[Storage] ([Id]);

	-- Molka : add [Twitter,[Fax],[Facebook] and [Linkedin]  to [ERPSettings].[User] 28-10-2020

ALTER TABLE [ERPSettings].[User] ADD [Twitter] NVARCHAR (255) NULL
ALTER TABLE [ERPSettings].[User] ADD [Linkedin] NVARCHAR (255) NULL
ALTER TABLE [ERPSettings].[User] ADD [Fax] NVARCHAR (255) NULL
ALTER TABLE [ERPSettings].[User] ADD [Facebook] NVARCHAR (255) NULL

Go

--- Rafik: Add CashRegister + FundsTransfer 22/04/2021
GO
CREATE TABLE [Payment].[CashRegister] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Code]              NVARCHAR (50)  NOT NULL,
    [Name]              NVARCHAR (100) NOT NULL,
    [Type]              INT            NOT NULL,
    [Address]           NCHAR (255)    NULL,
    [IdResponsible]     INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IdParentCash]      INT            NULL,
    [IdCity]            INT            NULL,
    [IdCountry]         INT            NULL,
    CONSTRAINT [PK_CashRegister] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_CashRegister_CashRegister] FOREIGN KEY ([IdParentCash]) REFERENCES [Payment].[CashRegister] ([Id]),
	CONSTRAINT [FK_CashRegister_User] FOREIGN KEY ([IdResponsible]) REFERENCES [ERPSettings].[User] ([Id]),
	CONSTRAINT [FK_CashRegister_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id]),
	CONSTRAINT [FK_CashRegister_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id])
);

GO
CREATE TABLE [Payment].[FundsTransfer] (
    [Id]                 INT            IDENTITY (1, 1) NOT NULL,
    [Code]               NVARCHAR (50)  NOT NULL,
    [TransfertDate]      DATE           NOT NULL,
    [Type]               INT            NOT NULL,
    [IdSourceCash]       INT            NOT NULL,
    [IdDestinationCash]  INT            NOT NULL,
    [Status]             INT            NOT NULL,
    [Amount]             FLOAT (53)     NOT NULL,
    [AmountWithCurrency] FLOAT (53)     NOT NULL,
    [IdCurrency]         INT            NOT NULL,
    [IsDeleted]          BIT            NOT NULL,
    [TransactionUserId]  INT            NULL,
    [Deleted_Token]      NVARCHAR (255) NULL,
    CONSTRAINT [PK_FundsTransfer] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_FundsTransfer_SourceCashRegister] FOREIGN KEY ([IdSourceCash]) REFERENCES [Payment].[CashRegister] ([Id]),
	CONSTRAINT [FK_FundsTransfer_DestinationCashRegister] FOREIGN KEY ([IdDestinationCash]) REFERENCES [Payment].[CashRegister] ([Id]),
	CONSTRAINT [FK_FundsTransfer_Currency] FOREIGN KEY ([IdCurrency]) REFERENCES [Administration].[Currency] ([Id])
);

--- Donia Add delete cascade on address 28/04/2021
ALTER TABLE [Shared].[Address] DROP CONSTRAINT [FK_Adress_Tiers];
ALTER TABLE [Shared].[Address] WITH NOCHECK
    ADD CONSTRAINT [FK_Adress_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id]) ON DELETE CASCADE;
ALTER TABLE [Shared].[Address] WITH CHECK CHECK CONSTRAINT [FK_Adress_Tiers];

-- Youssef : add TaxeAmount to DocumentLine and add IsCalculable to Taxe 25/03/2021
ALTER TABLE [Sales].[DocumentLine]
    ADD [TaxeAmount] FLOAT (53) NULL;
	
ALTER TABLE [Shared].[Taxe]
    ADD [IsCalculable] BIT NOT NULL DEFAULT 1;

-- Nesrin : add Priority column in Docuemnt table 07/004/2021
ALTER TABLE [Sales].[Document]
    ADD [Priority] INT NULL;
-- Youssef : add TaxeAmount to ExpenseDocumentLine  16/04/2021
ALTER TABLE [Sales].[DocumentExpenseLine]
    ADD [TaxeAmount] FLOAT (53) NULL;

-- Mohamed BOUZIDI Office corrections

ALTER TABLE [Shared].[Office] drop CONSTRAINT [FK_Office_City] 
ALTER TABLE [Shared].[Office] drop CONSTRAINT [FK_Office_Country] 

ALTER TABLE [Shared].[Office] DROP COLUMN [IdCity]
ALTER TABLE [Shared].[Office] DROP COLUMN [IdCountry]


ALTER TABLE [Shared].[Address] ADD [IdOffice] INT CONSTRAINT [FK_Address_Office] FOREIGN KEY([IdOffice]) REFERENCES [Shared].[Office] ([Id]) NULL
ALTER TABLE [Shared].[Contact] ADD [IdOffice] INT CONSTRAINT [FK_Contact_Office] FOREIGN KEY([IdOffice]) REFERENCES [Shared].[Office] ([Id]) NULL

-- chedi : add storage source and destination 
GO
ALTER TABLE [Inventory].[StockDocument]
    ADD [IdStorageSource]      INT        NULL,
        [IdStorageDestination] INT        NULL,
        [TransferType]         NCHAR (10) NULL;


GO
PRINT N'Creating [Inventory].[FK_StockDocument_Storage]...';


GO
ALTER TABLE [Inventory].[StockDocument] WITH NOCHECK
    ADD CONSTRAINT [FK_StockDocument_Storage] FOREIGN KEY ([IdStorageSource]) REFERENCES [Inventory].[Storage] ([Id]);


GO
PRINT N'Creating [Inventory].[FK_StockDocument_Storage1]...';


GO
ALTER TABLE [Inventory].[StockDocument] WITH NOCHECK
    ADD CONSTRAINT [FK_StockDocument_Storage1] FOREIGN KEY ([IdStorageDestination]) REFERENCES [Inventory].[Storage] ([Id]);

-- Mohamed BOUZIDI User
ALTER TABLE [ERPSettings].[User] ADD [IsWithEmailNotification] BIT CONSTRAINT [DF_User_IsWithEmailNotification] DEFAULT ((1)) NOT NULL
ALTER TABLE [ERPSettings].[User] ADD [IdPhone] INT CONSTRAINT [FK_User_Phone] FOREIGN KEY ([IdPhone]) REFERENCES [Shared].[Phone] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE NULL
ALTER TABLE [ERPSettings].[User] ADD [UrlPicture] NVARCHAR (255) NULL



	-- chedi : add transfertype max length 23/11/2020
	
GO
ALTER TABLE [Inventory].[StockDocument] ALTER COLUMN [TransferType] NCHAR (20) NULL;


-- Mohamed BOUZIDI Delete cascad (Bugs 3695, 3696 et 3784)
ALTER TABLE [Shared].[Address] DROP CONSTRAINT [FK_Address_Office]
ALTER TABLE [Shared].[Address] DROP CONSTRAINT [FK_Adress_Tiers]
ALTER TABLE [Shared].[Address] ADD CONSTRAINT [FK_Address_Office] FOREIGN KEY ([IdOffice]) REFERENCES [Shared].[Office] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [Shared].[Address] ADD CONSTRAINT [FK_Adress_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE


ALTER TABLE [Shared].[BankAgency] DROP CONSTRAINT [FK_BankAgency_Bank]
ALTER TABLE [Shared].[BankAgency] ADD CONSTRAINT [FK_BankAgency_Bank] FOREIGN KEY ([IdBank]) REFERENCES [Shared].[Bank] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE


ALTER TABLE [Shared].[Contact] DROP CONSTRAINT [FK_Contact_BankAgency]
ALTER TABLE [Shared].[Contact] DROP CONSTRAINT [FK_Contact_Office]
ALTER TABLE [Shared].[Contact] DROP CONSTRAINT [FK_Contact_Tiers]
ALTER TABLE [Shared].[Contact] ADD CONSTRAINT [FK_Contact_BankAgency] FOREIGN KEY ([IdAgency]) REFERENCES [Shared].[BankAgency] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [Shared].[Contact] ADD CONSTRAINT [FK_Contact_Office] FOREIGN KEY ([IdOffice]) REFERENCES [Shared].[Office] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [Shared].[Contact] ADD CONSTRAINT [FK_Contact_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE


ALTER TABLE [Shared].[Phone] DROP CONSTRAINT [FK_Phone_Contact]
ALTER TABLE [Shared].[Phone] ADD CONSTRAINT [FK_Phone_Contact] FOREIGN KEY ([IdContact]) REFERENCES [Shared].[Contact] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE

--- kossi alter table [Sales].[Tiers] 03/12/2020
ALTER TABLE [Sales].[Tiers]
	ADD [TiersClassification] INT NULL Default(1);

-- chedi: add responsable to storage
GO
ALTER TABLE [Inventory].[Storage] ADD [IdResponsable] INT CONSTRAINT [FK_Storage_User] FOREIGN KEY ([IdResponsable]) REFERENCES [ERPSettings].[User] ([Id])

GO
ALTER TABLE [Inventory].[Storage] WITH CHECK CHECK CONSTRAINT [FK_Storage_User];


-- Ghazoua : add idCatgoryEcommerce to family table  09/02/2021 ---
ALTER TABLE [Inventory].[Family]
    ADD [IdCategoryEcommerce] INT NULL;
-- Ghazoua : add idSubCatgoryEcommerce to Sub family table  09/02/2021 ---
ALTER TABLE [Inventory].[SubFamily]
    ADD [IdSubCategoryEcommerce] INT NULL;
--chedi 17-01-2021 fix edit company profile
PRINT N'Altering [Shared].[Company]...';


GO
ALTER TABLE [Shared].[Company]
    ADD [IdDefaultTax] INT NULL,
        [IdZipCode]    INT NULL;


GO
PRINT N'Creating [Shared].[FK_Company_Taxe]...';


GO
ALTER TABLE [Shared].[Company] WITH NOCHECK
    ADD CONSTRAINT [FK_Company_Taxe] FOREIGN KEY ([IdDefaultTax]) REFERENCES [Shared].[Taxe] ([Id]);


GO
PRINT N'Creating [Shared].[FK_Company_ZipCode]...';


GO
ALTER TABLE [Shared].[Company] WITH NOCHECK
    ADD CONSTRAINT [FK_Company_ZipCode] FOREIGN KEY ([IdZipCode]) REFERENCES [Shared].[ZipCode] ([Id]);

-- Youssef : update transfertType column 03/05/2021
GO
ALTER TABLE [Inventory].[StockDocument] ALTER COLUMN [TransferType] NVARCHAR (50) NULL;