alter table Sales.document add 
 CONSTRAINT [FK_Document_BankAccount] FOREIGN KEY ([IdBankAccount]) REFERENCES [Shared].[BankAccount] ([Id]),
    CONSTRAINT [FK_Document_Contact] FOREIGN KEY ([IdContact]) REFERENCES [Shared].[Contact] ([Id]),
    CONSTRAINT [FK_Document_Currency] FOREIGN KEY ([IdUsedCurrency]) REFERENCES [Administration].[Currency] ([Id]),
    CONSTRAINT [FK_Document_CurrencyRate] FOREIGN KEY ([IdExchangeRate]) REFERENCES [Administration].[CurrencyRate] ([Id]),
    CONSTRAINT [FK_Document_DeliveryType] FOREIGN KEY ([IdDeliveryType]) REFERENCES [Sales].[DeliveryType] ([Id]),
    CONSTRAINT [FK_Document_DocumentStatus] FOREIGN KEY ([IdDocumentStatus]) REFERENCES [Sales].[DocumentStatus] ([Id]),
    CONSTRAINT [FK_Document_Employee] FOREIGN KEY ([IdDecisionMaker]) REFERENCES [Payroll].[Employee] ([Id]),
    CONSTRAINT [FK_Document_PaymentMethod] FOREIGN KEY ([IdPaymentMethod]) REFERENCES [Payment].[PaymentMethod] ([Id]),
    CONSTRAINT [FK_Document_PriceRequest] FOREIGN KEY ([IdPriceRequest]) REFERENCES [Sales].[PriceRequest] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [FK_Document_Project] FOREIGN KEY ([IdProject]) REFERENCES [RH].[Project] ([Id]),
    CONSTRAINT [FK_Document_Provisioning] FOREIGN KEY ([IdProvision]) REFERENCES [Sales].[Provisioning] ([Id]),
    CONSTRAINT [FK_Document_SettlementMode] FOREIGN KEY ([IdSettlementMode]) REFERENCES [Sales].[SettlementMode] ([Id]),
    CONSTRAINT [FK_Document_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id]),
    CONSTRAINT [FK_Document_TimeSheet] FOREIGN KEY ([IdTimeSheet]) REFERENCES [RH].[TimeSheet] ([Id]),
    CONSTRAINT [FK_Document_User] FOREIGN KEY ([IdValidator]) REFERENCES [ERPSettings].[User] ([Id]),
    CONSTRAINT [FK_Document_User1] FOREIGN KEY ([IdCreator]) REFERENCES [ERPSettings].[User] ([Id])


---- Souhail El Kamel : add table bank
GO
CREATE TABLE [Shared].[Bank] (
    [Id]            INT            IDENTITY (1, 1) NOT NULL,
    [Name]          NVARCHAR (255) NOT NULL,
    [Address]       NVARCHAR (255) NULL,
    [Phone]         NVARCHAR (50)  NULL,
    [Fax]           NVARCHAR (50)  NULL,
    [Email]         NVARCHAR (255) NOT NULL,
    [AttachmentUrl] NVARCHAR (255) NULL,
    [WebSite]       NVARCHAR (50)  NULL,
    [IdCountry]     INT            NULL,
    [IsDeleted]     BIT            NOT NULL,
    [Deleted_Token] NVARCHAR (255) NULL,
    CONSTRAINT [PK_Bank] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Bank_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id])
);

GO
ALTER TABLE [Shared].[BankAccount]
    ADD [InitialBalance] Float DEFAULT ((0)) NOT NULL,
        [CurrentBalance] Float DEFAULT ((0)) NOT NULL,
        [IdBank]         INT NOT NULL;
GO

ALTER TABLE [Shared].[BankAccount]
    ADD CONSTRAINT [FK_BankAccount_Bank] FOREIGN KEY ([IdBank]) REFERENCES [Shared].[Bank] ([Id]);
GO
-----Ghofrane : changes at the table bankaccount

GO
ALTER TABLE [Shared].[BankAccount] DROP CONSTRAINT [FK_BankAccount_Country];

GO
ALTER TABLE [Shared].[BankAccount] DROP COLUMN [Bank], COLUMN [IdCountry];


--- Imen chaaben : delete handed column from Settlement

GO
ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [DF_Settlement_Handed];

GO
ALTER TABLE [Payment].[Settlement] DROP COLUMN [Handed];


---- Nihel: New columns in stock document
GO
PRINT N'Altering [Inventory].[StockDocument]...';


GO
ALTER TABLE [Inventory].[StockDocument]
    ADD [IdTiers] INT           NULL,
        [Shelf]   NVARCHAR (50) NULL,
		[IdUser] INT NULL;


GO
PRINT N'Altering [Inventory].[StockDocumentLine]...';


GO
ALTER TABLE [Inventory].[StockDocumentLine]
    ADD [IdWarehouse] INT           NULL,
        [Shelf]       NVARCHAR (50) NULL,
        [Storage]     NVARCHAR (50) NULL;


GO
PRINT N'Creating [Inventory].[FK_StockDocument_Tiers]...';


GO
ALTER TABLE [Inventory].[StockDocument] WITH NOCHECK
    ADD CONSTRAINT [FK_StockDocument_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id]);


GO
PRINT N'Creating [Inventory].[FK_StockDocument_User]...';


GO
ALTER TABLE [Inventory].[StockDocument] WITH NOCHECK
    ADD CONSTRAINT [FK_StockDocument_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]);


GO
PRINT N'Creating [Inventory].[FK_StockDocumentLine_Warehouse]...';


GO
ALTER TABLE [Inventory].[StockDocumentLine] WITH NOCHECK
    ADD CONSTRAINT [FK_StockDocumentLine_Warehouse] FOREIGN KEY ([IdWarehouse]) REFERENCES [Inventory].[Warehouse] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
ALTER TABLE [Inventory].[StockDocument] WITH CHECK CHECK CONSTRAINT [FK_StockDocument_Tiers];

ALTER TABLE [Inventory].[StockDocument] WITH CHECK CHECK CONSTRAINT [FK_StockDocument_User];

ALTER TABLE [Inventory].[StockDocumentLine] WITH CHECK CHECK CONSTRAINT [FK_StockDocumentLine_Warehouse];


GO
PRINT N'Update complete.';

--Yasmine: Create role SalesDelivery_Deliver
GO
PRINT N'Altering [ERPSettings].[RoleConfigByRole]...';

ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_Role]
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_RoleConfig] 

ALTER TABLE [ERPSettings].[RoleConfigByRole]
    ADD CONSTRAINT [FK_RoleConfigRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[RoleConfigByRole]
    WITH NOCHECK ADD CONSTRAINT [FK_RoleConfigRole_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])


--Fatma : Add [Coefficient] 
GO
PRINT N'Altering [Sales].[Document]...';


GO
ALTER TABLE [Sales].[Document]
    ADD [Coefficient] FLOAT (53) CONSTRAINT [DF_Document_Coefficient] DEFAULT ((1)) NULL;



--Fatma : Add DocumentLineNegotiationOptions for Negotiate price and Qty
CREATE TABLE [Sales].[DocumentLineNegotiationOptions] (
    [Id]             INT        IDENTITY (1, 1) NOT NULL,
    [IdDocumentLine] INT        NOT NULL,
    [Price]          FLOAT (53) NULL,
    [Qty]            FLOAT (53) NULL,
    [IsFinal]        BIT        NOT NULL,
    [IsAccepted]     BIT        NOT NULL,
    [IsRejected]     BIT        NOT NULL,
    [CreationDate]   DATETIME   NOT NULL,
    [IdUser]         INT        NOT NULL,
    [QteSupplier]    FLOAT (53) NULL,
    [PriceSupplier]  FLOAT (53) NULL,
    [IdItem]         INT        NOT NULL,
    CONSTRAINT [PK_DocumentLineNegotiationOptions] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Sales].[DF_DocumentLineNegotiationOptions_IsFinal]...';


GO
ALTER TABLE [Sales].[DocumentLineNegotiationOptions]
    ADD CONSTRAINT [DF_DocumentLineNegotiationOptions_IsFinal] DEFAULT ((0)) FOR [IsFinal];


GO
PRINT N'Creating [Sales].[DF_DocumentLineNegotiationOptions_IsAccepted]...';


GO
ALTER TABLE [Sales].[DocumentLineNegotiationOptions]
    ADD CONSTRAINT [DF_DocumentLineNegotiationOptions_IsAccepted] DEFAULT ((0)) FOR [IsAccepted];


GO
PRINT N'Creating  [Sales].[DF_DocumentLineNegotiationOptions_IsRejected]...';


GO
ALTER TABLE [Sales].[DocumentLineNegotiationOptions]
    ADD CONSTRAINT [DF_DocumentLineNegotiationOptions_IsRejected] DEFAULT ((0)) FOR [IsRejected];


GO
PRINT N'Creating [Sales].[FK_DocumentLineNegotiationOptions_DocumentLineNegotiationOptions]...';


GO
ALTER TABLE [Sales].[DocumentLineNegotiationOptions] WITH NOCHECK
    ADD CONSTRAINT [FK_DocumentLineNegotiationOptions_DocumentLineNegotiationOptions] FOREIGN KEY ([IdDocumentLine]) REFERENCES [Sales].[DocumentLine] ([Id]);


GO
PRINT N'Creating [Sales].[FK_DocumentLineNegotiationOptions_Item]...';


GO
ALTER TABLE [Sales]
.[DocumentLineNegotiationOptions] WITH NOCHECK
    ADD CONSTRAINT [FK_DocumentLineNegotiationOptions_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


GO

ALTER TABLE [Sales].[DocumentLineNegotiationOptions] WITH CHECK CHECK CONSTRAINT [FK_DocumentLineNegotiationOptions_DocumentLineNegotiationOptions];

ALTER TABLE [Sales].[DocumentLineNegotiationOptions] WITH CHECK CHECK CONSTRAINT [FK_DocumentLineNegotiationOptions_Item];


GO
PRINT N'Update complete.';


GO

----- Marwa : add item details -----

ALTER TABLE [Inventory].[Item]
    ADD [CreationDate] DATE NULL;

	---- houssem 
alter table Sales.Tiers
add ProvisionalAuthorizedAmountDelivery float null	


-----Marwa add date dispo documentLine -----

ALTER TABLE [Sales].[DocumentLine]
    ADD [DateAvailability] DATE NULL;

--Fatma add relation between user and negotiateQtyOptions
GO
PRINT N'Creating [Sales].[FK_DocumentLineNegotiationOptions_User]...';


GO
ALTER TABLE [Sales].[DocumentLineNegotiationOptions] WITH NOCHECK
    ADD CONSTRAINT [FK_DocumentLineNegotiationOptions_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
ALTER TABLE [Sales].[DocumentLineNegotiationOptions] WITH CHECK CHECK CONSTRAINT [FK_DocumentLineNegotiationOptions_User];


GO
PRINT N'Update complete.';





GO
PRINT N'Dropping [Sales].[FK_DocumentLineNegotiationOptions_DocumentLineNegotiationOptions]...';


GO
ALTER TABLE [Sales].[DocumentLineNegotiationOptions] DROP CONSTRAINT [FK_DocumentLineNegotiationOptions_DocumentLineNegotiationOptions];


GO
PRINT N'Creating [Sales].[FK_DocumentLineNegotiationOptions_DocumentLineNegotiationOptions]...';


GO
ALTER TABLE [Sales].[DocumentLineNegotiationOptions] WITH NOCHECK
    ADD CONSTRAINT [FK_DocumentLineNegotiationOptions_DocumentLineNegotiationOptions] FOREIGN KEY ([IdDocumentLine]) REFERENCES [Sales].[DocumentLine] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Checking existing data against newly created constraints';


GO

ALTER TABLE [Sales].[DocumentLineNegotiationOptions] WITH CHECK CHECK CONSTRAINT [FK_DocumentLineNegotiationOptions_DocumentLineNegotiationOptions];


GO
PRINT N'Update complete.';


GO