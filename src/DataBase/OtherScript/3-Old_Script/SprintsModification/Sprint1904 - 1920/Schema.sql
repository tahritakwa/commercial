
---- Nihel: Add item's tables
GO
PRINT N'Altering [Inventory].[Item]...';


GO
ALTER TABLE [Inventory].[Item]
    ADD [IdBrand]     INT            NULL,
        [IdModel]     INT            NULL,
        [IdSubModel]  INT            NULL,
        [IdFamily]    INT            NULL,
        [IdSubFamily] INT            NULL,
        [OnOrder]     BIT            CONSTRAINT [DF_Item_OnOrder] DEFAULT ((0)) NOT NULL,
        [Note]        NVARCHAR (MAX) NULL;

GO
PRINT N'Altering [Inventory].[ItemWarehouse]...';


GO
ALTER TABLE [Inventory].[ItemWarehouse]
    ADD [Shelf]   NVARCHAR (50) NULL,
        [Storage] NVARCHAR (50) NULL;


GO
PRINT N'Creating [Inventory].[Brand]...';


GO
CREATE TABLE [Inventory].[Brand] (
    [Id]    INT            IDENTITY (1, 1) NOT NULL,
    [Code]  NVARCHAR (50)  NULL,
    [Label] NVARCHAR (250) NULL,
    CONSTRAINT [PK_Brand] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Inventory].[Family]...';


GO
CREATE TABLE [Inventory].[Family] (
    [Id]    INT            IDENTITY (1, 1) NOT NULL,
    [Code]  NVARCHAR (50)  NULL,
    [Label] NVARCHAR (250) NULL,
    CONSTRAINT [PK_Family] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Inventory].[ModelOfItem]...';


GO
CREATE TABLE [Inventory].[ModelOfItem] (
    [Id]      INT            IDENTITY (1, 1) NOT NULL,
    [Code]    NVARCHAR (50)  NULL,
    [Label]   NVARCHAR (250) NULL,
    [IdBrand] INT            NULL,
    CONSTRAINT [PK_Model] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Inventory].[SubFamily]...';


GO
CREATE TABLE [Inventory].[SubFamily] (
    [Id]       INT            IDENTITY (1, 1) NOT NULL,
    [Code]     NVARCHAR (50)  NULL,
    [Label]    NVARCHAR (250) NULL,
    [IdFamily] INT            NOT NULL,
    CONSTRAINT [PK_SubFamily] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Inventory].[SubModel]...';


GO
CREATE TABLE [Inventory].[SubModel] (
    [Id]      INT            IDENTITY (1, 1) NOT NULL,
    [Code]    NVARCHAR (50)  NULL,
    [Label]   NVARCHAR (250) NULL,
    [IdModel] INT            NOT NULL,
    CONSTRAINT [PK_SubModel] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Inventory].[FK_Model_Brand]...';


GO
ALTER TABLE [Inventory].[ModelOfItem] WITH NOCHECK
    ADD CONSTRAINT [FK_Model_Brand] FOREIGN KEY ([IdBrand]) REFERENCES [Inventory].[Brand] ([Id]);


GO
PRINT N'Creating [Inventory].[FK_SubFamily_Family]...';


GO
ALTER TABLE [Inventory].[SubFamily] WITH NOCHECK
    ADD CONSTRAINT [FK_SubFamily_Family] FOREIGN KEY ([IdFamily]) REFERENCES [Inventory].[Family] ([Id]);


GO
PRINT N'Creating [Inventory].[FK_SubModel_Model]...';


GO
ALTER TABLE [Inventory].[SubModel] WITH NOCHECK
    ADD CONSTRAINT [FK_SubModel_Model] FOREIGN KEY ([IdModel]) REFERENCES [Inventory].[ModelOfItem] ([Id]);


GO
PRINT N'Creating [Inventory].[FK_Item_Brand]...';


GO
ALTER TABLE [Inventory].[Item] WITH NOCHECK
    ADD CONSTRAINT [FK_Item_Brand] FOREIGN KEY ([IdBrand]) REFERENCES [Inventory].[Brand] ([Id]);


GO
PRINT N'Creating [Inventory].[FK_Item_Family]...';


GO
ALTER TABLE [Inventory].[Item] WITH NOCHECK
    ADD CONSTRAINT [FK_Item_Family] FOREIGN KEY ([IdFamily]) REFERENCES [Inventory].[Family] ([Id]);


GO
PRINT N'Creating [Inventory].[FK_Item_Model]...';


GO
ALTER TABLE [Inventory].[Item] WITH NOCHECK
    ADD CONSTRAINT [FK_Item_Model] FOREIGN KEY ([IdModel]) REFERENCES [Inventory].[ModelOfItem] ([Id]);


GO
PRINT N'Creating [Inventory].[FK_Item_SubFamily]...';


GO
ALTER TABLE [Inventory].[Item] WITH NOCHECK
    ADD CONSTRAINT [FK_Item_SubFamily] FOREIGN KEY ([IdSubFamily]) REFERENCES [Inventory].[SubFamily] ([Id]);


GO
PRINT N'Creating [Inventory].[FK_Item_SubModel]...';


GO
ALTER TABLE [Inventory].[Item] WITH NOCHECK
    ADD CONSTRAINT [FK_Item_SubModel] FOREIGN KEY ([IdSubModel]) REFERENCES [Inventory].[SubModel] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
ALTER TABLE [Inventory].[ModelOfItem] WITH CHECK CHECK CONSTRAINT [FK_Model_Brand];

ALTER TABLE [Inventory].[SubFamily] WITH CHECK CHECK CONSTRAINT [FK_SubFamily_Family];

ALTER TABLE [Inventory].[SubModel] WITH CHECK CHECK CONSTRAINT [FK_SubModel_Model];

ALTER TABLE [Inventory].[Item] WITH CHECK CHECK CONSTRAINT [FK_Item_Brand];

ALTER TABLE [Inventory].[Item] WITH CHECK CHECK CONSTRAINT [FK_Item_Family];

ALTER TABLE [Inventory].[Item] WITH CHECK CHECK CONSTRAINT [FK_Item_Model];

ALTER TABLE [Inventory].[Item] WITH CHECK CHECK CONSTRAINT [FK_Item_SubFamily];

ALTER TABLE [Inventory].[Item] WITH CHECK CHECK CONSTRAINT [FK_Item_SubModel];


---- Imen Chaaben : Add Expense Entity and ExpenseLine in sales module 
GO
CREATE TABLE [Sales].[DocumentExpenseLine] (
    [Id]                        INT            IDENTITY (1, 1) NOT NULL,
    [CodeExpenseLine]           NVARCHAR (50)  NULL,
    [IdDocument]                INT            NOT NULL,
    [IdExpense]                 INT            NOT NULL,
    [Designation]               NVARCHAR (300) NULL,
    [IdTaxe]                    INT            NULL,
    [HtAmoutLine]               FLOAT (53)     NOT NULL,
    [TtcAmoutLine]              FLOAT (53)     NOT NULL,
    [HtAmountLineWithCurrency]  FLOAT (53)     NOT NULL,
    [TtcAmountLineWithCurrency] FLOAT (53)     NOT NULL,
    [IsDeleted]                 BIT            NOT NULL,
    [Deleted_Token]             NVARCHAR (255) NULL,
    [TransactionUserId]         INT            NOT NULL,
    CONSTRAINT [PK_DocumentExpenseLine] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Sales].[Expense]...';


GO
CREATE TABLE [Sales].[Expense] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Code]              NVARCHAR (255) NOT NULL,
    [Description]       NVARCHAR (255) NOT NULL,
    [IdItem]            INT            NOT NULL,
    [IdCurrency]        INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Expense] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Sales].[DF_DocumentExpenseLine_TransactionUserId]...';


GO
ALTER TABLE [Sales].[DocumentExpenseLine]
    ADD CONSTRAINT [DF_DocumentExpenseLine_TransactionUserId] DEFAULT ((0)) FOR [TransactionUserId];


GO
PRINT N'Creating [Sales].[DF_Expense_TransactionUserId]...';


GO
ALTER TABLE [Sales].[Expense]
    ADD CONSTRAINT [DF_Expense_TransactionUserId] DEFAULT ((0)) FOR [TransactionUserId];


GO
PRINT N'Creating [Sales].[FK_DocumentExpenseLine_Document]...';


GO
ALTER TABLE [Sales].[DocumentExpenseLine] WITH NOCHECK
    ADD CONSTRAINT [FK_DocumentExpenseLine_Document] FOREIGN KEY ([IdDocument]) REFERENCES [Sales].[Document] ([Id]);


GO
PRINT N'Creating [Sales].[FK_DocumentExpenseLine_Taxe]...';


GO
ALTER TABLE [Sales].[DocumentExpenseLine] WITH NOCHECK
    ADD CONSTRAINT [FK_DocumentExpenseLine_Taxe] FOREIGN KEY ([IdTaxe]) REFERENCES [Shared].[Taxe] ([Id]);


GO
PRINT N'Creating [Sales].[FK_DocumentExpenseLine_Expense]...';


GO
ALTER TABLE [Sales].[DocumentExpenseLine] WITH NOCHECK
    ADD CONSTRAINT [FK_DocumentExpenseLine_Expense] FOREIGN KEY ([IdExpense]) REFERENCES [Sales].[Expense] ([Id]);


GO
PRINT N'Creating [Sales].[FK_Expense_Item]...';


GO
ALTER TABLE [Sales].[Expense] WITH NOCHECK
    ADD CONSTRAINT [FK_Expense_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id]) ON DELETE CASCADE;


GO
PRINT N'Creating [Sales].[FK_Expense_Currency]...';


GO
ALTER TABLE [Sales].[Expense] WITH NOCHECK
    ADD CONSTRAINT [FK_Expense_Currency] FOREIGN KEY ([IdCurrency]) REFERENCES [Administration].[Currency] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


GO


GO
ALTER TABLE [Sales].[DocumentExpenseLine] WITH CHECK CHECK CONSTRAINT [FK_DocumentExpenseLine_Document];

ALTER TABLE [Sales].[DocumentExpenseLine] WITH CHECK CHECK CONSTRAINT [FK_DocumentExpenseLine_Taxe];

ALTER TABLE [Sales].[DocumentExpenseLine] WITH CHECK CHECK CONSTRAINT [FK_DocumentExpenseLine_Expense];

ALTER TABLE [Sales].[Expense] WITH CHECK CHECK CONSTRAINT [FK_Expense_Item];

ALTER TABLE [Sales].[Expense] WITH CHECK CHECK CONSTRAINT [FK_Expense_Currency];


GO
PRINT N'Update complete.';


GO
--- Marwa add fields to warehouse ---
ALTER TABLE [Inventory].[Warehouse]
ADD [IsCentral]     BIT CONSTRAINT [DF_Warehouse_IsCentral] DEFAULT ((0)) NOT NULL,
    [IsWarehouse]   BIT CONSTRAINT [DF_Warehouse_IsWarehouse] DEFAULT ((0)) NOT NULL,
    [IdResponsable] INT NULL;
		
ALTER TABLE [Inventory].[Warehouse] WITH NOCHECK
    ADD CONSTRAINT [FK_Warehouse_Employee] FOREIGN KEY ([IdResponsable]) REFERENCES [Payroll].[Employee] ([Id]);
	
ALTER TABLE [Inventory].[Warehouse] WITH CHECK CHECK CONSTRAINT [FK_Warehouse_Employee];


-- Mohamed BOUZIDI ADD [IsTermBilling](facturation à terme) in [Sales].[Document] table

GO
PRINT N'Altering [Sales].[Document]...';


GO
ALTER TABLE [Sales].[Document]
    ADD [IsTermBilling] BIT NULL;


GO
PRINT N'Update complete.';


--Fatma : Add delvery delay-----
ALTER TABLE [Sales].[Tiers]
    ADD [DeleveryDelay] INT NULL;

---- Nihel: add constraint
GO
PRINT N'Dropping [Inventory].[FK_Model_Brand]...';


GO
ALTER TABLE [Inventory].[ModelOfItem] DROP CONSTRAINT [FK_Model_Brand];


GO
PRINT N'Altering [Inventory].[ModelOfItem]...';


GO
ALTER TABLE [Inventory].[ModelOfItem] ALTER COLUMN [IdBrand] INT NOT NULL;


GO
PRINT N'Creating [Inventory].[FK_Model_Brand]...';


GO
ALTER TABLE [Inventory].[ModelOfItem] WITH NOCHECK
    ADD CONSTRAINT [FK_Model_Brand] FOREIGN KEY ([IdBrand]) REFERENCES [Inventory].[Brand] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';

GO
ALTER TABLE [Inventory].[ModelOfItem] WITH CHECK CHECK CONSTRAINT [FK_Model_Brand];

-- Narcisse: Transfer order

ALTER TABLE [Payroll].[TransferOrder] DROP COLUMN [IdRib]

ALTER TABLE [Payroll].[TransferOrder] ADD [IdBankAccount] INT NOT NULL

ALTER TABLE [Payroll].[TransferOrder] ADD CONSTRAINT [FK_TransferOrder_BankAccount] FOREIGN KEY ([IdBankAccount]) REFERENCES [Shared].[BankAccount] ([Id])

ALTER TABLE [Payroll].[TransferOrderDetails] DROP CONSTRAINT [FK_TransferOrderDetails_Employee]

ALTER TABLE [Payroll].[TransferOrderDetails] DROP CONSTRAINT [FK_TransferOrderDetails_TransferOrder]

ALTER TABLE [Payroll].[TransferOrderDetails] DROP COLUMN [IdEmployee]

ALTER TABLE [Payroll].[TransferOrderDetails] ADD [IdContract] INT NOT NULL

ALTER TABLE [Payroll].[TransferOrderDetails] ADD CONSTRAINT [FK_TransferOrderDetails_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id])

ALTER TABLE [Payroll].[TransferOrderDetails] ADD CONSTRAINT [FK_TransferOrderDetails_TransferOrder] FOREIGN KEY ([IdTransferOrder]) REFERENCES [Payroll].[TransferOrder] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE

-- Delete cascade employee with its contracts

ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_Employee]
ALTER TABLE [Payroll].[Contract] ADD CONSTRAINT [FK_Contract_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]) ON DELETE CASCADE


-- Mohamed BOUZIDI Add Unique Constraint To Item Warehouse
ALTER TABLE [Inventory].[ItemWarehouse]
  ADD CONSTRAINT unique_ItemWarehouse_IdItemAndIdWarehouse UNIQUE(IdItem, IdWarehouse, Deleted_Token);
  
  
  
  -- Mohamed BOUZIDI [FK_StockMovement_DocumentLine]  ON DELETE CASCADE
ALTER TABLE [Stock].[StockMovement] DROP CONSTRAINT [FK_StockMovement_DocumentLine]
ALTER TABLE [Stock].[StockMovement]
    ADD CONSTRAINT [FK_StockMovement_DocumentLine] FOREIGN KEY ([IdDocumentLine]) REFERENCES [Sales].[DocumentLine] ([Id]) ON DELETE CASCADE

-- Rabeb: Alter Leave table and drop leave status table

GO
PRINT N'Suppression de [Payroll].[FK_Leave_LeaveStatus]...';

GO
ALTER TABLE [Payroll].[Leave] DROP CONSTRAINT [FK_Leave_LeaveStatus];
GO
PRINT N'Suppression de Column [IdLeaveStatus] ...';

ALTER TABLE [Payroll].[Leave] DROP COLUMN [IdLeaveStatus]
GO
PRINT N'Ajout de Column [Status] et [DaysNumber] ...';

ALTER TABLE [Payroll].[Leave] ADD [Status] INT NOT NULL, 
[DaysNumber] FLOAT (53) NOT NULL

GO
PRINT N'Suppression de table [Payroll].[LeaveStatus] ...';

DROP TABLE [Payroll].[LeaveStatus]

-- Nihel ksontini
GO
PRINT N'Altering [Sales].[DocumentLine]...';


GO
ALTER TABLE [Sales].[DocumentLine]
    ADD [CostPrice]        FLOAT (53) NULL,
        [PercentageMargin] FLOAT (53) NULL,
        [SellingPrice]     FLOAT (53) NULL;

GO


-- Imen: Add ExpenseReport , ExpenseReportDetails and ExpenseReportDetailsType

GO
PRINT N'Creating [Payroll].[ExpenseReport]...';


GO
CREATE TABLE [Payroll].[ExpenseReport] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Purpose]           NVARCHAR (255) NOT NULL,
    [SubmissionDate]    DATETIME       NOT NULL,
    [TreatmentDate]     DATETIME       NULL,
    [State]             INT            NOT NULL,
    [IdEmployee]        INT            NOT NULL,
    [TotalAmount]       FLOAT (53)     NOT NULL,
	[IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_ExpenseReport] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[ExpenseReportDetails]...';


GO
CREATE TABLE [Payroll].[ExpenseReportDetails] (
    [Id]                         INT            IDENTITY (1, 1) NOT NULL,
    [Description]                NVARCHAR (255) NULL,
    [Amount]                     FLOAT (53)     NOT NULL,
    [IdCurrency]                 INT            NOT NULL,
    [IdExpenseReport]            INT            NOT NULL,
    [IdExpenseReportDetailsType] INT            NOT NULL,
	[IsDeleted]                  BIT            NOT NULL,
    [TransactionUserId]          INT            NULL,
    [Deleted_Token]              NVARCHAR (255) NULL,
    CONSTRAINT [PK_ExpenseReportDetails] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[ExpenseReportDetailsType]...';


GO
CREATE TABLE [Payroll].[ExpenseReportDetailsType] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Code]              NVARCHAR (50)  NULL,
    [Label]             NVARCHAR (250) NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_ExpenseReportDetailsType] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[DF_ExpenseReport_TotalAmount]...';


GO
ALTER TABLE [Payroll].[ExpenseReport]
    ADD CONSTRAINT [DF_ExpenseReport_TotalAmount] DEFAULT ((0)) FOR [TotalAmount];


GO
PRINT N'Creating [Payroll].[FK_ExpenseReport_Employee]...';


GO
ALTER TABLE [Payroll].[ExpenseReport] WITH NOCHECK
    ADD CONSTRAINT [FK_ExpenseReport_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]);


GO
PRINT N'Creating [Payroll].[FK_ExpenseReportDetails_Currency]...';


GO
ALTER TABLE [Payroll].[ExpenseReportDetails] WITH NOCHECK
    ADD CONSTRAINT [FK_ExpenseReportDetails_Currency] FOREIGN KEY ([IdCurrency]) REFERENCES [Administration].[Currency] ([Id]);


GO
PRINT N'Creating [Payroll].[FK_ExpenseReportDetails_ExpenseReport]...';


GO
ALTER TABLE [Payroll].[ExpenseReportDetails] WITH NOCHECK
    ADD CONSTRAINT [FK_ExpenseReportDetails_ExpenseReport] FOREIGN KEY ([IdExpenseReport]) REFERENCES [Payroll].[ExpenseReport] ([Id]) ON DELETE CASCADE;


GO
PRINT N'Creating [Payroll].[FK_ExpenseReportDetails_ExpenseReportDetailsType]...';


GO
ALTER TABLE [Payroll].[ExpenseReportDetails] WITH NOCHECK
    ADD CONSTRAINT [FK_ExpenseReportDetails_ExpenseReportDetailsType] FOREIGN KEY ([IdExpenseReportDetailsType]) REFERENCES [Payroll].[ExpenseReportDetailsType] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';

GO
ALTER TABLE [Payroll].[ExpenseReport] WITH CHECK CHECK CONSTRAINT [FK_ExpenseReport_Employee];

ALTER TABLE [Payroll].[ExpenseReportDetails] WITH CHECK CHECK CONSTRAINT [FK_ExpenseReportDetails_Currency];

ALTER TABLE [Payroll].[ExpenseReportDetails] WITH CHECK CHECK CONSTRAINT [FK_ExpenseReportDetails_ExpenseReport];

ALTER TABLE [Payroll].[ExpenseReportDetails] WITH CHECK CHECK CONSTRAINT [FK_ExpenseReportDetails_ExpenseReportDetailsType];


GO
PRINT N'Update complete.';


GO

---- Nihel
ALTER TABLE [Inventory].[Item] DROP COLUMN [PolicyValorization];
ALTER TABLE [Inventory].[Item] ADD [IdPolicyValorization] INT NULL

-- Narcisse : Add CNSS declaration, CNSS declaration details, Document Request, Document request type

GO
PRINT N'Modification de [ERPSettings].[User]...';

GO
ALTER TABLE [ERPSettings].[User]
    ADD [IdEmployee] INT NULL;

GO
PRINT N'Création de [ERPSettings].[FK_User_Employee]...';

GO
ALTER TABLE [ERPSettings].[User] WITH NOCHECK
    ADD CONSTRAINT [FK_User_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]);

GO
ALTER TABLE [ERPSettings].[User] WITH CHECK CHECK CONSTRAINT [FK_User_Employee];

GO
PRINT N'Mise à jour terminée.';

GO

GO
PRINT N'Création de [Payroll].[CnssDeclaration]...';

GO
CREATE TABLE [Payroll].[CnssDeclaration] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Code]              NVARCHAR (50)  NOT NULL,
    [Label]             NVARCHAR (255) NULL,
    [Trimester]         INT            NOT NULL,
    [Year]              INT            NOT NULL,
    [CreationDate]      DATE           NOT NULL,
    [TotalAmount]       FLOAT (53)     NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IdCnss]            INT            NOT NULL,
    CONSTRAINT [PK_CnssDeclaration] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
PRINT N'Création de [Payroll].[CnssDeclarationDetails]...';

GO
CREATE TABLE [Payroll].[CnssDeclarationDetails] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [NumberOrder]       INT            NOT NULL,
    [IdEmployee]        INT            NOT NULL,
    [FirstMonthValue]   FLOAT (53)     NOT NULL,
    [SecondMonthValue]  FLOAT (53)     NOT NULL,
    [ThirdMonthValue]   FLOAT (53)     NOT NULL,
    [Total]             FLOAT (53)     NOT NULL,
    [IdCnssDeclaration] INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_CnssDeclarationDetails] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
PRINT N'Création de [Payroll].[DocumentRequest]...';

GO
CREATE TABLE [Payroll].[DocumentRequest] (
    [Id]                    INT            IDENTITY (1, 1) NOT NULL,
    [Label]                 NVARCHAR (255) NOT NULL,
    [CreationDate]          DATE           NOT NULL,
    [DeadLine]              DATE           NOT NULL,
    [Description]           NVARCHAR (255) NULL,
    [State]                 INT            NOT NULL,
    [IsDeleted]             BIT            NOT NULL,
    [TransactionUserId]     INT            NULL,
    [Deleted_Token]         NVARCHAR (255) NULL,
    [IdDocumentRequestType] INT            NOT NULL,
    [IdUser]                INT            NOT NULL,
    CONSTRAINT [PK_DocumentRequest] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
PRINT N'Création de [Payroll].[DocumentRequestType]...';

GO
CREATE TABLE [Payroll].[DocumentRequestType] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Code]              NVARCHAR (50)  NOT NULL,
    [Label]             NVARCHAR (255) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_DocumentRequestType] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
PRINT N'Création de [Payroll].[FK_CnssDeclaration_Cnss]...';

GO
ALTER TABLE [Payroll].[CnssDeclaration] WITH NOCHECK
    ADD CONSTRAINT [FK_CnssDeclaration_Cnss] FOREIGN KEY ([IdCnss]) REFERENCES [Payroll].[Cnss] ([Id]);

GO
PRINT N'Création de [Payroll].[FK_CnssDeclarationDetails_CnssDeclaration]...';


GO
ALTER TABLE [Payroll].[CnssDeclarationDetails] WITH NOCHECK
    ADD CONSTRAINT [FK_CnssDeclarationDetails_CnssDeclaration] FOREIGN KEY ([IdCnssDeclaration]) REFERENCES [Payroll].[CnssDeclaration] ([Id]);

GO
PRINT N'Création de [Payroll].[FK_CnssDelarationDetails_Employee]...';

GO
ALTER TABLE [Payroll].[CnssDeclarationDetails] WITH NOCHECK
    ADD CONSTRAINT [FK_CnssDelarationDetails_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]);

GO
PRINT N'Création de [Payroll].[FK_DocumentRequest_DocumentRequestType]...';

GO
ALTER TABLE [Payroll].[DocumentRequest] WITH NOCHECK
    ADD CONSTRAINT [FK_DocumentRequest_DocumentRequestType] FOREIGN KEY ([IdDocumentRequestType]) REFERENCES [Payroll].[DocumentRequestType] ([Id]);

GO
PRINT N'Création de [Payroll].[FK_DocumentRequest_User]...';

GO
ALTER TABLE [Payroll].[DocumentRequest] WITH NOCHECK
    ADD CONSTRAINT [FK_DocumentRequest_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]);

GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';

GO
ALTER TABLE [Payroll].[CnssDeclaration] WITH CHECK CHECK CONSTRAINT [FK_CnssDeclaration_Cnss];

ALTER TABLE [Payroll].[CnssDeclarationDetails] WITH CHECK CHECK CONSTRAINT [FK_CnssDeclarationDetails_CnssDeclaration];

ALTER TABLE [Payroll].[CnssDeclarationDetails] WITH CHECK CHECK CONSTRAINT [FK_CnssDelarationDetails_Employee];

ALTER TABLE [Payroll].[DocumentRequest] WITH CHECK CHECK CONSTRAINT [FK_DocumentRequest_DocumentRequestType];

ALTER TABLE [Payroll].[DocumentRequest] WITH CHECK CHECK CONSTRAINT [FK_DocumentRequest_User];

GO
PRINT N'Mise à jour terminée.';

--- Kossi: Add label in LeaveType

GO
ALTER TABLE [Payroll].[LeaveType]
    ADD [Label] NVARCHAR (250) NULL;

GO

-- Nihel
UPDATE [Administration].[Currency]
   SET [SalePrecision] = 2
 WHERE [SalePrecision] IS NULL

UPDATE [Administration].[Currency]
   SET PurchasePrecision = 2
 WHERE PurchasePrecision IS NULL

 UPDATE [Administration].[CurrencyRate]
   SET [Rate] = 3
 WHERE Rate IS NULL

 UPDATE [Administration].[CurrencyRate]
   SET [Coefficient] = 1
 WHERE [Coefficient] IS NULL

 GO
PRINT N'Altering [Administration].[Currency]...';


GO
ALTER TABLE [Administration].[Currency] ALTER COLUMN [PurchasePrecision] INT NOT NULL;

ALTER TABLE [Administration].[Currency] ALTER COLUMN [SalePrecision] INT NOT NULL;

GO
PRINT N'Altering [Administration].[CurrencyRate]...';


GO
ALTER TABLE [Administration].[CurrencyRate] ALTER COLUMN [Coefficient] FLOAT (53) NOT NULL;

ALTER TABLE [Administration].[CurrencyRate] ALTER COLUMN [Rate] FLOAT (53) NOT NULL;

GO
PRINT N'Altering [Sales].[DocumentExpenseLine]...';


GO
ALTER TABLE [Sales].[DocumentExpenseLine]
    ADD [IdCurrency]   INT        NULL,
        [ExchangeRate] FLOAT (53) NULL;


GO
PRINT N'Creating [Sales].[FK_DocumentExpenseLine_Currency]...';


GO
ALTER TABLE [Sales].[DocumentExpenseLine] WITH NOCHECK
    ADD CONSTRAINT [FK_DocumentExpenseLine_Currency] FOREIGN KEY ([IdCurrency]) REFERENCES [Administration].[Currency] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
ALTER TABLE [Sales].[DocumentExpenseLine] WITH CHECK CHECK CONSTRAINT [FK_DocumentExpenseLine_Currency];

-- Narcisse: Add Cascading delete constraint in CnssDeclaration, CnssDeclarationDetails and Transfer order


GO
PRINT N'Suppression de [Payroll].[FK_CnssDeclarationDetails_CnssDeclaration]...';

GO
ALTER TABLE [Payroll].[CnssDeclarationDetails] DROP CONSTRAINT [FK_CnssDeclarationDetails_CnssDeclaration];

GO
PRINT N'Suppression de [Payroll].[FK_TransferOrder_Session]...';

GO
ALTER TABLE [Payroll].[TransferOrder] DROP CONSTRAINT [FK_TransferOrder_Session];

GO
PRINT N'Création de [Payroll].[FK_CnssDeclarationDetails_CnssDeclaration]...';

GO
ALTER TABLE [Payroll].[CnssDeclarationDetails] WITH NOCHECK
    ADD CONSTRAINT [FK_CnssDeclarationDetails_CnssDeclaration] FOREIGN KEY ([IdCnssDeclaration]) REFERENCES [Payroll].[CnssDeclaration] ([Id]) ON DELETE CASCADE;

GO
PRINT N'Création de [Payroll].[FK_TransferOrder_Session]...';

GO
ALTER TABLE [Payroll].[TransferOrder] WITH NOCHECK
    ADD CONSTRAINT [FK_TransferOrder_Session] FOREIGN KEY ([IdSession]) REFERENCES [Payroll].[Session] ([Id]) ON DELETE CASCADE;

GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';

GO
ALTER TABLE [Payroll].[CnssDeclarationDetails] WITH CHECK CHECK CONSTRAINT [FK_CnssDeclarationDetails_CnssDeclaration];

ALTER TABLE [Payroll].[TransferOrder] WITH CHECK CHECK CONSTRAINT [FK_TransferOrder_Session];

GO
PRINT N'Mise à jour terminée.';


GO


GO

--Fatma : add price request to document
ALTER TABLE [Sales].[Document]
    ADD [IdPriceRequest] INT NULL;


GO
PRINT N'Creating [Sales].[FK_Document_PriceRequest]...';


GO
ALTER TABLE [Sales].[Document] WITH NOCHECK
    ADD CONSTRAINT [FK_Document_PriceRequest] FOREIGN KEY ([IdPriceRequest]) REFERENCES [Sales].[PriceRequest] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Checking existing data against newly created constraints';


GO
ALTER TABLE [Sales].[Document] WITH CHECK CHECK CONSTRAINT [FK_Document_PriceRequest];

---- Imen Alter table ExpenseReportDetails

ALTER TABLE [Payroll].[ExpenseReportDetails]
ADD [Date]                       DATETIME       NOT NULL,
    [AttachmentUrl]              NVARCHAR (255) NULL


-- Mohamed BOUZIDI [CodeEntity] VARCHAR (MAX) (was 50) because this column must be able to accept JSON parameters to string

GO
PRINT N'Altering [ERPSettings].[Message]...';


GO
ALTER TABLE [ERPSettings].[Message] ALTER COLUMN [CodeEntity] VARCHAR (MAX) NULL;

--- kossi: add column HoursNumber
GO
ALTER TABLE [Payroll].[Leave]
    ADD [HoursNumber] FLOAT (53) NULL;

---kossi: add columns TimeLeaveStart, TimeLeaveEnd, Description into the table Leave
ALTER TABLE [Payroll].[Leave] ADD
	[TimeLeaveStart]    FLOAT (53)     NULL,
    [TimeLeaveEnd]      FLOAT (53)     NULL,
    [Description]       NVARCHAR (250) NOT NULL


GO
PRINT N'Update complete.';

--- Marwa add column IdJob to Employee ---

ALTER TABLE [Payroll].[Employee]
    ADD [IdJob] INT NULL;
	
ALTER TABLE [Payroll].[Employee] WITH NOCHECK
    ADD CONSTRAINT [FK_Employee_Job] FOREIGN KEY ([IdJob]) REFERENCES [Payroll].[Job] ([Id]);
	
ALTER TABLE [Payroll].[Employee] WITH CHECK CHECK CONSTRAINT [FK_Employee_Job];

---- Imen chaaben: add rate in EmployeeSkills 

ALTER TABLE [Payroll].[EmployeeSkills]
ADD [Rate] INT  CONSTRAINT [DF_EmployeeSkills_Rate] DEFAULT ((0)) NOT NULL 

---- Imen chaaben: add code and description in EmployeeSkills 
ALTER TABLE [Payroll].[Skills]
ADD  [Code]    NVARCHAR (255) NULL,
	 [Description]       NVARCHAR (255)    NULL

-- Narcisse: Altter column description of document request to required

GO
PRINT N'Modification de [Payroll].[DocumentRequest]...';


GO
ALTER TABLE [Payroll].[DocumentRequest] ALTER COLUMN [Description] NVARCHAR (255) NOT NULL;


GO
PRINT N'Mise à jour terminée.';

---- Marwa delete IdJob from contract table ---
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_Job];

ALTER TABLE [Payroll].[Contract] DROP COLUMN [IdJob];

--- Narcisse : Restructurate Transfer order and declaration cnss tables

GO
PRINT N'Suppression de [Payroll].[FK_TransferOrder_Session]...';

GO
ALTER TABLE [Payroll].[TransferOrder] DROP CONSTRAINT [FK_TransferOrder_Session];

ALTER TABLE [Payroll].[TransferOrder] DROP COLUMN [Date], [Total], [IdSession]

ALTER TABLE [Payroll].[TransferOrder] ADD
	[TransferNumber]    INT            NOT NULL,
    [CreationDate]      DATE           NOT NULL,
    [Month]             DATE           NOT NULL,
    [TotalAmount]       FLOAT (53)     NULL

ALTER TABLE [Payroll].[CnssDeclaration] DROP COLUMN [Code], [Label]

ALTER TABLE [Payroll].[CnssDeclaration] ADD
	[DeclarationNumber] INT            NOT NULL,
	[Title]             NVARCHAR (255) NOT NULL

ALTER TABLE [Payroll].[TransferOrder] DROP COLUMN [TotalAmount], [Label]

ALTER TABLE [Payroll].[TransferOrder] ADD
	 [Title]             NVARCHAR (125) NOT NULL,
	 [TotalAmount]       FLOAT (53)     NOT NULL
	 ---Kossi: add column Comment to Leave table 
GO
ALTER TABLE [Payroll].[Leave]
    ADD [Comment] NVARCHAR (250) NULL;

---- Nihel
UPDATE [Inventory].[ItemWarehouse]
   SET [AvailableQuantity] = 0
GO

GO
PRINT N'Altering [Inventory].[ItemWarehouse]...';


GO
ALTER TABLE [Inventory].[ItemWarehouse] ALTER COLUMN [AvailableQuantity] FLOAT (53) NOT NULL;


GO
PRINT N'Creating [Inventory].[DF_ItemWarehouse_AvailableQuantity]...';


GO
ALTER TABLE [Inventory].[ItemWarehouse]
    ADD CONSTRAINT [DF_ItemWarehouse_AvailableQuantity] DEFAULT ((0)) FOR [AvailableQuantity];


GO
PRINT N'Creating [Stock].[UpdateAvailableQtyWhenInsert]...';


GO

---- Nihel: Trigger: update available Qty
CREATE TRIGGER [Stock].[UpdateAvailableQtyWhenInsert] 
ON [Stock].[StockMovement] 
AFTER INSERT, UPDATE
AS 

BEGIN
    DECLARE @IdItem int, @IdWarehouse int, @MovementQty float, @Operation nvarchar(5), @Status nvarchar(5);
	Select Top (1) @IdItem = [IdItem], 
			@IdWarehouse = [IdWarehouse],
			@MovementQty = [MovementQty],
			@Operation = [Operation],
			@Status = [Status] 
			From inserted

	IF (@Status = 'R')
		UPDATE [Inventory].[ItemWarehouse]
	
		SET [AvailableQuantity] = CASE WHEN (@Operation = 'I') THEN 
										[AvailableQuantity] + @MovementQty
								  ELSE 
										[AvailableQuantity] - @MovementQty
								  END
		WHERE [IdItem] = @IdItem AND [IdWarehouse] = @IdWarehouse
END
GO

-- Mohamed BOUZIDI Job CalculateAverageSalesPerDay

GO
ALTER TABLE [Inventory].[Item]
    ADD [AverageSalesPerDay] float NULL;


-- Mohamed BOUZIDI Add last Price in Item

GO
ALTER TABLE [Inventory].[Item]
    ADD [LastPrice] float NULL;

-- nihel
GO
PRINT N'Altering [Sales].[Expense]...';


GO
ALTER TABLE [Sales].[Expense]
    ADD [IdTaxe] INT NULL;


GO
PRINT N'Creating [Sales].[FK_Expense_Taxe]...';


GO
ALTER TABLE [Sales].[Expense] WITH NOCHECK
    ADD CONSTRAINT [FK_Expense_Taxe] FOREIGN KEY ([IdTaxe]) REFERENCES [Shared].[Taxe] ([Id]);




GO
ALTER TABLE [Sales].[Expense] WITH CHECK CHECK CONSTRAINT [FK_Expense_Taxe];

--- Marwa change poste -----

ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Job];

ALTER TABLE [Payroll].[Employee] DROP COLUMN [IdJob];

ALTER TABLE [Payroll].[Job] DROP COLUMN [Description];

ALTER TABLE [Payroll].[Job]
    ADD [FunctionSheet] NVARCHAR (MAX) NULL;
	
	
ALTER TABLE [Payroll].[Job]
    ADD [IdUpperJob] INT NULL;
	
ALTER TABLE [Payroll].[Job] WITH NOCHECK
    ADD CONSTRAINT [FK_Job_Job] FOREIGN KEY ([IdUpperJob]) REFERENCES [Payroll].[Job] ([Id]);
	
	
CREATE TABLE [Payroll].[JobEmployee] (
    [Id]         INT IDENTITY (1, 1) NOT NULL,
    [IdEmployee] INT NULL,
    [IdJob]      INT NULL,
	[IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_JobEmployee] PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [Payroll].[JobSkills] (
    [Id]      INT IDENTITY (1, 1) NOT NULL,
    [IdJob]   INT NOT NULL,
    [IdSkill] INT NOT NULL,
    [Rate]    INT NULL,
	[IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_JobSkills] PRIMARY KEY CLUSTERED ([Id] ASC)
);


ALTER TABLE [Payroll].[JobEmployee]
    ADD CONSTRAINT [DF_JobEmployee_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];

ALTER TABLE [Payroll].[JobEmployee]
    ADD CONSTRAINT [DF_JobEmployee_TransactionUserId] DEFAULT ((0)) FOR [TransactionUserId];
	
ALTER TABLE [Payroll].[JobSkills]
    ADD CONSTRAINT [DF_JobSkills_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];

ALTER TABLE [Payroll].[JobSkills]
    ADD CONSTRAINT [DF_JobSkills_TransactionUserId] DEFAULT ((0)) FOR [TransactionUserId];	
	
ALTER TABLE [Payroll].[JobEmployee] WITH NOCHECK
    ADD CONSTRAINT [FK_JobEmployee_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]);
	
ALTER TABLE [Payroll].[JobEmployee] WITH NOCHECK
    ADD CONSTRAINT [FK_JobEmployee_Job] FOREIGN KEY ([IdJob]) REFERENCES [Payroll].[Job] ([Id]);
	
ALTER TABLE [Payroll].[JobSkills] WITH NOCHECK
    ADD CONSTRAINT [FK_JobSkills_Job] FOREIGN KEY ([IdJob]) REFERENCES [Payroll].[Job] ([Id]);

ALTER TABLE [Payroll].[JobSkills] WITH NOCHECK
    ADD CONSTRAINT [FK_JobSkills_Skills] FOREIGN KEY ([IdSkill]) REFERENCES [Payroll].[Skills] ([Id]);
	
	
ALTER TABLE [Payroll].[JobEmployee] WITH CHECK CHECK CONSTRAINT [FK_JobEmployee_Employee];

ALTER TABLE [Payroll].[JobEmployee] WITH CHECK CHECK CONSTRAINT [FK_JobEmployee_Job];

ALTER TABLE [Payroll].[JobSkills] WITH CHECK CHECK CONSTRAINT [FK_JobSkills_Job];

ALTER TABLE [Payroll].[JobSkills] WITH CHECK CHECK CONSTRAINT [FK_JobSkills_Skills];
	--houssem Add index
CREATE INDEX index_name
ON [Inventory].[Item] (Id,[Code],[IdTiers],IdNature);

----
GO
PRINT N'Altering [Sales].[Document]...';


GO
ALTER TABLE [Sales].[Document]
    ADD [IsGenerated] BIT CONSTRAINT [DF_Document_IsGenerated] DEFAULT ((0)) NOT NULL;

--- kossi alter tablea from leave	
GO
ALTER TABLE [Payroll].[Leave] ALTER COLUMN [HoursNumber] FLOAT (53) NOT NULL;

ALTER TABLE [Payroll].[Leave] ALTER COLUMN [TimeLeaveEnd] FLOAT (53) NOT NULL;

ALTER TABLE [Payroll].[Leave] ALTER COLUMN [TimeLeaveStart] FLOAT (53) NOT NULL;
GO

ALTER TABLE [Sales].[TiersPriceRequest] ALTER COLUMN [IdContact] Int  NULL;

-- Narcisse : Add Idbonus column in PayslipDetails table

ALTER TABLE [Payroll].[PayslipDetails] ADD [IdBonus] INT NULL

ALTER TABLE [Payroll].[PayslipDetails] ADD CONSTRAINT [FK_PayslipDetails_Bonus] FOREIGN KEY ([IdBonus]) REFERENCES [Payroll].[Bonus] ([Id])

---- Kossi alter table Leave: set startDate and endDate to type date
GO
ALTER TABLE [Payroll].[Leave] ALTER COLUMN [EndDate] DATE NOT NULL;

ALTER TABLE [Payroll].[Leave] ALTER COLUMN [StartDate] DATE NOT NULL;
GO

---- Kossi add table to Leave
GO
ALTER TABLE [Payroll].[Leave]
    ADD [LeaveAttachementFile] NVARCHAR (500) NULL;
GO

-- Rabeb : Drop IdUser column in document request and add IdEmployee 

ALTER TABLE [Payroll].[DocumentRequest] DROP CONSTRAINT [FK_DocumentRequest_User]

ALTER TABLE [Payroll].[DocumentRequest] DROP COLUMN [IdUser]

ALTER TABLE [Payroll].[DocumentRequest] ADD [IdEmployee] INT NOT NULL

ALTER TABLE [Payroll].[DocumentRequest] ADD CONSTRAINT [FK_DocumentRequest_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])

-- Mohamed BOUZIDI table Candidate

CREATE TABLE [RH].[Candidate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Sex] [int] NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[CIN] [nvarchar](50) NULL,
	[IsForeign] [bit] NOT NULL,
	[IdEmployee] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NOT NULL,
	[Deleted_Token] [nvarchar](255) NULL,
 CONSTRAINT [PK_Candidate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [RH].[Candidate] ADD  CONSTRAINT [DF_Candidate_IsForeign]  DEFAULT ((0)) FOR [IsForeign]
GO

ALTER TABLE [RH].[Candidate] ADD  CONSTRAINT [DF_Candidate_TransactionUserId]  DEFAULT ((0)) FOR [TransactionUserId]
GO

ALTER TABLE [RH].[Candidate]  WITH CHECK ADD  CONSTRAINT [FK_Candidate_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id])
GO

ALTER TABLE [RH].[Candidate] CHECK CONSTRAINT [FK_Candidate_Employee]
GO

-- Mohamed BOUZIDI interview type table

CREATE TABLE [RH].[InterviewType] (
    [Id]                INT            NOT NULL,
    [Code]              NVARCHAR (50)  NOT NULL,
    [Label]             NVARCHAR (50)  NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            CONSTRAINT [DF_InterviewType_TransactionUserId] DEFAULT ((0)) NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_InterviewType] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO


-- Kossi : recruitment process tables

GO
PRINT N'Creating [RH].[Candidacy]...';


GO
CREATE TABLE [RH].[Candidacy] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [State]             INT            NOT NULL,
    [IdRecruitment]     INT            NULL,
    [IdCandidate]       INT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Candidacy] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[Interview]...';


GO
CREATE TABLE [RH].[Interview] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [AverageMark]       FLOAT (53)     NULL,
	[CreationDate]      DATETIME       CONSTRAINT [DF_Interview_CreationDate] DEFAULT (getdate()) NOT NULL,
    [InterviewDate]     DATETIME       NOT NULL,
    [Remarks]           NVARCHAR (MAX) NULL,
    [EmailSubject]      NVARCHAR (255) NULL,
    [EmailBody]         NVARCHAR (MAX) NULL,
	[Status]			INT			   CONSTRAINT [DF_Interview_Status]  DEFAULT ((1)) NOT NULL,
    [IdInterviewType]   INT            NULL,
    [IdCandidacy]       INT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Interview] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[InterviewMark]...';


GO
CREATE TABLE [RH].[InterviewMark] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Mark]              FLOAT (53)     NULL,
	[IsRequired]		BIT			   CONSTRAINT [DF_InterviewMark_isRequired]  DEFAULT ((0)) NOT NULL,
	[Status]			INT			   CONSTRAINT [DF_InterviewMark_Status]  DEFAULT ((1)) NOT NULL,
    [IdEmployee]        INT            NOT NULL,
    [IdInterview]       INT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
	[InterviewerDecision] INT            NULL,
    [StrongPoints]        NVARCHAR (255) NULL,
    [Weaknesses]          NVARCHAR (255) NULL,
    [OtherInformations]   NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_InterviewMark] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[Offer]...';


GO
CREATE TABLE [RH].[Offer] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [State]             INT            NOT NULL,
    [IdCandidacy]       INT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Offer] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[Recruitment]...';


GO
CREATE TABLE [RH].[Recruitment] (
    [Id]                  INT            IDENTITY (1, 1) NOT NULL,
    [YearOfExperience]    INT            NULL,
    [WorkingHoursPerDays] FLOAT (53)     NULL,
    [Priority]             INT            NOT NULL,
    [Description]         NVARCHAR (500) NULL,
    [State]               INT            NOT NULL,
    [CreationDate]        DATE           NOT NULL,
    [ClosingDate]         DATE           NULL,
    [IdQualificationType] INT            NOT NULL,
    [IdJob]               INT            NULL,
    [IdEmployeeAuthor]    INT            NOT NULL,
    [IdEmployeeValidator] INT            NULL,
    [TransactionUserId]   INT            NULL,
    [IsDeleted]           BIT            NOT NULL,
    [Deleted_Token]       NVARCHAR (255) NULL,
    CONSTRAINT [PK_Recruitment] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [RH].[FK_Candidacy_Recruitment]...';


GO
ALTER TABLE [RH].[Candidacy] WITH NOCHECK
    ADD CONSTRAINT [FK_Candidacy_Recruitment] FOREIGN KEY ([IdRecruitment]) REFERENCES [RH].[Recruitment] ([Id]);


GO
PRINT N'Creating [RH].[FK_Interview_Candidacy]...';


GO
ALTER TABLE [RH].[Interview] WITH NOCHECK
    ADD CONSTRAINT [FK_Interview_Candidacy] FOREIGN KEY ([IdCandidacy]) REFERENCES [RH].[Candidacy] ([Id]);

GO
PRINT N'Creating [RH].[FK_Interview_InterviewType]...';


GO
ALTER TABLE [RH].[Interview] WITH NOCHECK
    ADD CONSTRAINT [FK_Interview_InterviewType] FOREIGN KEY ([IdInterviewType]) REFERENCES [RH].[InterviewType] ([Id]);


GO
PRINT N'Creating [RH].[FK_InterviewMark_Employee]...';


GO
ALTER TABLE [RH].[InterviewMark] WITH NOCHECK
    ADD CONSTRAINT [FK_InterviewMark_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]);


GO
PRINT N'Creating [RH].[FK_InterviewMark_Interview]...';


GO
ALTER TABLE [RH].[InterviewMark] WITH NOCHECK
    ADD CONSTRAINT [FK_InterviewMark_Interview] FOREIGN KEY ([IdInterview]) REFERENCES [RH].[Interview] ([Id]);


GO
PRINT N'Creating [RH].[FK_Offer_Candidacy]...';


GO
ALTER TABLE [RH].[Offer] WITH NOCHECK
    ADD CONSTRAINT [FK_Offer_Candidacy] FOREIGN KEY ([IdCandidacy]) REFERENCES [RH].[Candidacy] ([Id]);


GO
PRINT N'Creating [RH].[FK_Recruitment_Job]...';


GO
ALTER TABLE [RH].[Recruitment] WITH NOCHECK
    ADD CONSTRAINT [FK_Recruitment_Job] FOREIGN KEY ([IdJob]) REFERENCES [Payroll].[Job] ([Id]);


GO
PRINT N'Creating [RH].[FK_Recruitment_EmployeeAuthor]...';


GO
ALTER TABLE [RH].[Recruitment] WITH NOCHECK
    ADD CONSTRAINT [FK_Recruitment_EmployeeAuthor] FOREIGN KEY ([IdEmployeeAuthor]) REFERENCES [Payroll].[Employee] ([Id]);


GO
PRINT N'Creating [RH].[FK_Recruitment_EmployeeValidator]...';


GO
ALTER TABLE [RH].[Recruitment] WITH NOCHECK
    ADD CONSTRAINT [FK_Recruitment_EmployeeValidator] FOREIGN KEY ([IdEmployeeValidator]) REFERENCES [Payroll].[Employee] ([Id]);


GO
PRINT N'Creating [RH].[FK_Recruitment_QualificationType]...';


GO
ALTER TABLE [RH].[Recruitment] WITH NOCHECK
    ADD CONSTRAINT [FK_Recruitment_QualificationType] FOREIGN KEY ([IdQualificationType]) REFERENCES [Payroll].[QualificationType] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
ALTER TABLE [RH].[Candidacy] WITH CHECK CHECK CONSTRAINT [FK_Candidacy_Recruitment];

ALTER TABLE [RH].[Interview] WITH CHECK CHECK CONSTRAINT [FK_Interview_Candidacy];

ALTER TABLE [RH].[InterviewMark] WITH CHECK CHECK CONSTRAINT [FK_InterviewMark_Employee];

ALTER TABLE [RH].[InterviewMark] WITH CHECK CHECK CONSTRAINT [FK_InterviewMark_Interview];

ALTER TABLE [RH].[Offer] WITH CHECK CHECK CONSTRAINT [FK_Offer_Candidacy];

ALTER TABLE [RH].[Recruitment] WITH CHECK CHECK CONSTRAINT [FK_Recruitment_Job];

ALTER TABLE [RH].[Recruitment] WITH CHECK CHECK CONSTRAINT [FK_Recruitment_EmployeeAuthor];

ALTER TABLE [RH].[Recruitment] WITH CHECK CHECK CONSTRAINT [FK_Recruitment_EmployeeValidator];

ALTER TABLE [RH].[Recruitment] WITH CHECK CHECK CONSTRAINT [FK_Recruitment_QualificationType];


GO
PRINT N'Update complete.';

-- Narcisse: Create table InterviewQuestion and InterviewQuestionTheme

GO
PRINT N'Création de [RH].[InterviewQuestion]...';


GO
CREATE TABLE [RH].[InterviewQuestion] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Type]              INT            NOT NULL,
    [Question]          NVARCHAR (MAX) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IdTheme]           INT            NOT NULL,
    CONSTRAINT [PK_InterviewQuestion] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de [RH].[InterviewQuestionTheme]...';


GO
CREATE TABLE [RH].[InterviewQuestionTheme] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Theme]             NVARCHAR (255) NOT NULL,
    [Description]       NVARCHAR (255) NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_InterviewQuestionTheme] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de [RH].[FK_InterviewQuestion_InterviewQuestionTheme]...';


GO
ALTER TABLE [RH].[InterviewQuestion] WITH NOCHECK
    ADD CONSTRAINT [FK_InterviewQuestion_InterviewQuestionTheme] FOREIGN KEY ([IdTheme]) REFERENCES [RH].[InterviewQuestionTheme] ([Id]);


GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';


GO
ALTER TABLE [RH].[InterviewQuestion] WITH CHECK CHECK CONSTRAINT [FK_InterviewQuestion_InterviewQuestionTheme];


GO
PRINT N'Mise à jour terminée.';


GO

-- Narcisse : Create Project table and add Company working time

GO
CREATE TABLE [RH].[Project] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Name]              NVARCHAR (125) NOT NULL,
    [Description]       NVARCHAR (255) NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
PRINT N'Mise à jour terminée.';


GO

ALTER TABLE [Shared].[Company] ADD [StartTimeOfWork] TIME (7) NULL,
    [EndTimeOfWork] TIME (7) NULL


ALTER TABLE [RH].[Candidacy] ADD CONSTRAINT [FK_Candidacy_Candidate] FOREIGN KEY ([IdCandidate]) REFERENCES [RH].[Candidate] ([Id])

--- Imen chaaben Add Skills Family relation
GO
PRINT N'Altering [Payroll].[Skills]...';


GO
ALTER TABLE [Payroll].[Skills]
    ADD [Id_Family] INT NULL;


GO
PRINT N'Creating [Payroll].[SkillsFamily]...';


GO
CREATE TABLE [Payroll].[SkillsFamily] (
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [Code]  NVARCHAR (50)  NULL,
    [Label] NVARCHAR (250) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TransactionUserId] [int] NULL,
	[Deleted_Token] [nvarchar](255) NULL,
    CONSTRAINT [PK_SkillsFamily] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[FK_Family_Skills]...';


GO
ALTER TABLE [Payroll].[Skills] WITH NOCHECK
    ADD CONSTRAINT [FK_Family_Skills] FOREIGN KEY ([Id_Family]) REFERENCES [Payroll].[SkillsFamily] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
ALTER TABLE [Payroll].[Skills] WITH CHECK CHECK CONSTRAINT [FK_Family_Skills];


GO
PRINT N'Update complete.';


GO
--Rabeb ADD LinkedIn column to candidate table

ALTER TABLE [RH].[Candidate] ADD [LinkedIn] NVARCHAR (50)  NULL


-- houssem update schema

GO
ALTER TABLE [accounting].[AccountingAccount] DROP CONSTRAINT [DF__Accountin__Trans__37A5467C];


GO
PRINT N'Dropping [Stock].[DF__Article__Transac__288DEB75]...';


GO
ALTER TABLE [Stock].[Article] DROP CONSTRAINT [DF__Article__Transac__288DEB75];


GO
PRINT N'Dropping [Stock].[DF__Location__Transa__1CBC4616]...';


GO
ALTER TABLE [Stock].[Location] DROP CONSTRAINT [DF__Location__Transa__1CBC4616];


GO
PRINT N'Dropping unnamed constraint on [Stock].[Storage]...';


GO
ALTER TABLE [Stock].[Storage] DROP CONSTRAINT [DF__Storage__Transac__6C390A4C];


GO
PRINT N'Dropping unnamed constraint on [Stock].[TypeStockCalculation]...';


GO
ALTER TABLE [Stock].[TypeStockCalculation] DROP CONSTRAINT [DF__TypeStock__Trans__70FDBF69];


GO
PRINT N'Dropping [Stock].[FK_Article_AccountingAccount]...';


GO
ALTER TABLE [Stock].[Article] DROP CONSTRAINT [FK_Article_AccountingAccount];


GO
PRINT N'Dropping [Sales].[FK_Tiers_AccountingAccount]...';


GO
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_Tiers_AccountingAccount];


GO
PRINT N'Dropping [Stock].[FK_SerialNumber_Article1]...';


GO
ALTER TABLE [Stock].[SerialNumber] DROP CONSTRAINT [FK_SerialNumber_Article1];


GO
PRINT N'Dropping [Stock].[FK_STORAGE_ASSOCIATI_ARTICLE]...';


GO
ALTER TABLE [Stock].[Storage] DROP CONSTRAINT [FK_STORAGE_ASSOCIATI_ARTICLE];


GO
PRINT N'Dropping [Stock].[FK_SerialNumber_Batch]...';


GO
ALTER TABLE [Stock].[SerialNumber] DROP CONSTRAINT [FK_SerialNumber_Batch];


GO
PRINT N'Dropping [Stock].[FK_StockDocumentSerialNumber_SerialNumber]...';


GO
ALTER TABLE [Stock].[StockDocumentLineSerialNumber] DROP CONSTRAINT [FK_StockDocumentSerialNumber_SerialNumber];


GO
PRINT N'Dropping [Stock].[FK_Article_StockManagementMethod]...';


GO
ALTER TABLE [Stock].[Article] DROP CONSTRAINT [FK_Article_StockManagementMethod];


GO
PRINT N'Dropping [Stock].[FK_Article_SaleManagementMethod]...';


GO
ALTER TABLE [Stock].[Article] DROP CONSTRAINT [FK_Article_SaleManagementMethod];


GO
PRINT N'Dropping [Stock].[FK_STORAGE_ASSOCIATI_SECTION]...';


GO
ALTER TABLE [Stock].[Storage] DROP CONSTRAINT [FK_STORAGE_ASSOCIATI_SECTION];


GO
PRINT N'Dropping [Stock].[FK_TYPESTOC_ASSOCIATI_STOCKCAL]...';


GO
ALTER TABLE [Stock].[TypeStockCalculation] DROP CONSTRAINT [FK_TYPESTOC_ASSOCIATI_STOCKCAL];


GO
PRINT N'Dropping [accounting].[AccountingAccount]...';


GO
DROP TABLE [accounting].[AccountingAccount];


GO
PRINT N'Dropping [Stock].[Article]...';


GO
DROP TABLE [Stock].[Article];


GO
PRINT N'Dropping [Stock].[Batch]...';


GO
DROP TABLE [Stock].[Batch];


GO
PRINT N'Dropping [Stock].[Location]...';


GO
DROP TABLE [Stock].[Location];


GO
PRINT N'Dropping [Stock].[SerialNumber]...';


GO
DROP TABLE [Stock].[SerialNumber];


GO
PRINT N'Dropping [Stock].[StockDocumentLineSerialNumber]...';


GO
DROP TABLE [Stock].[StockDocumentLineSerialNumber];


GO
PRINT N'Dropping [Stock].[Storage]...';


GO
DROP TABLE [Stock].[Storage];


GO
PRINT N'Dropping [Stock].[TypeStockCalculation]...';


GO
DROP TABLE [Stock].[TypeStockCalculation];


GO
PRINT N'Altering [Shared].[Company]...';


GO
ALTER TABLE [Shared].[Company]
    ADD [IdAccountingAccount] INT NULL;


--Rabeb ADD Candidacy columns

 alter table [RH].[Candidacy] ADD
	[CreationDate]      DATETIME       CONSTRAINT [DF_Candidacy_CreationDate] DEFAULT (getdate()) NOT NULL,
	[DepositDate]       DATETIME       NOT NULL,
	[CV]                NVARCHAR (255) NULL

	
-- Narcisse : Add TimeSheet and TimeSheetLine

GO
PRINT N'Création de [RH].[TimeSheet]...';

GO
CREATE TABLE [RH].[TimeSheet] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [CreationDate]      DATE           NOT NULL,
    [IdEmployee]        INT            NOT NULL,
    [State]             INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_TimeSheet] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
PRINT N'Création de [RH].[TimeSheetLine]...';

GO
CREATE TABLE [RH].[TimeSheetLine] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [StartTime]         TIME (7)       NOT NULL,
    [EndTime]           TIME (7)       NOT NULL,
    [IdProject]         INT            NULL,
    [Description]       NVARCHAR (255) NULL,
    [Day]               DATE           NOT NULL,
    [IdTimeSheet]       INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_TimeSheetLine] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
PRINT N'Création de [RH].[FK_TimeSheet_Employee]...';

GO
ALTER TABLE [RH].[TimeSheet] WITH NOCHECK
    ADD CONSTRAINT [FK_TimeSheet_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]);

GO
PRINT N'Création de [RH].[FK_TimeSheetLine_Project]...';

GO
ALTER TABLE [RH].[TimeSheetLine] WITH NOCHECK
    ADD CONSTRAINT [FK_TimeSheetLine_Project] FOREIGN KEY ([IdProject]) REFERENCES [RH].[Project] ([Id]);

GO
PRINT N'Création de [RH].[FK_TimeSheetLine_TimeSheet]...';

GO
ALTER TABLE [RH].[TimeSheetLine] WITH NOCHECK
    ADD CONSTRAINT [FK_TimeSheetLine_TimeSheet] FOREIGN KEY ([IdTimeSheet]) REFERENCES [RH].[TimeSheet] ([Id]);

GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';

GO
ALTER TABLE [RH].[TimeSheet] WITH CHECK CHECK CONSTRAINT [FK_TimeSheet_Employee];

ALTER TABLE [RH].[TimeSheetLine] WITH CHECK CHECK CONSTRAINT [FK_TimeSheetLine_Project];

ALTER TABLE [RH].[TimeSheetLine] WITH CHECK CHECK CONSTRAINT [FK_TimeSheetLine_TimeSheet];

GO
PRINT N'Mise à jour terminée.';

ALTER TABLE [RH].[TimeSheet] ADD [Month] DATE NOT NULL
   
--Kossi alter table recruitment

ALTER TABLE [RH].[Recruitment] ALTER COLUMN [IdJob] INT NOT NULL;


-- Mohamed BOUZIDI ON DELETE INTEVIEW CASCADE DELETING [InterviewMark]

GO
PRINT N'Dropping [RH].[FK_InterviewMark_Interview]...';


GO
ALTER TABLE [RH].[InterviewMark] DROP CONSTRAINT [FK_InterviewMark_Interview];


GO
PRINT N'Creating [RH].[FK_InterviewMark_Interview]...';


GO
ALTER TABLE [RH].[InterviewMark] WITH NOCHECK
    ADD CONSTRAINT [FK_InterviewMark_Interview] FOREIGN KEY ([IdInterview]) REFERENCES [RH].[Interview] ([Id]) ON DELETE CASCADE;


-- Narcisse: Cahnge Transfer order details contract constraint with employee constraint

ALTER TABLE [Payroll].[TransferOrderDetails] DROP CONSTRAINT [FK_TransferOrderDetails_Contract]
ALTER TABLE [Payroll].[TransferOrderDetails] DROP COLUMN [IdContract]

ALTER TABLE [Payroll].[TransferOrderDetails] ADD [IdEmployee] INT NOT NULL
ALTER TABLE [Payroll].[TransferOrderDetails] ADD CONSTRAINT [FK_TransferOrderDetails_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])

GO
ALTER TABLE [Inventory].[Item] DROP COLUMN [LastPrice];


GO
ALTER TABLE [Inventory].[Item]
    ADD [IdAccountingAccountSales]    INT NULL,
        [IdAccountingAccountPurchase] INT NULL;


GO
ALTER TABLE [Shared].[Taxe]
    ADD [IdAccountingAccountSales]    INT NULL,
        [IdAccountingAccountPurchase] INT NULL;

GO
ALTER TABLE [Shared].[Company] DROP COLUMN [IdAccountingAccount];


EXEC sp_rename 'Sales.Tiers.IdAccountingAccount', 'IdAccountingAccountTiers', 'COLUMN';  
GO 

---Imen Chaaben: Rename Column State to Status in ExpenseReport and DocumentRequest

EXECUTE sp_rename '[Payroll].[DocumentRequest].State','Status', 'COLUMN';
EXECUTE sp_rename '[Payroll].[ExpenseReport].State','Status', 'COLUMN';

---Imen Chaaben:  add column TreatedBy to Leave, ExpenseReport and DocumentRequest

ALTER TABLE [Payroll].[ExpenseReport]
      ADD [TreatedBy] INT NULL;

EXECUTE sp_rename '[Payroll].[DocumentRequest].CreationDate','SubmissionDate', 'COLUMN';
ALTER TABLE [Payroll].[DocumentRequest]
	   ADD [TreatmentDate] DATETIME NULL,
           [TreatedBy] INT NULL;

ALTER TABLE [Payroll].[Leave] DROP COLUMN Comment;
ALTER TABLE [Payroll].[Leave]
      ADD [SubmissionDate] DATETIME NOT NULL,
          [TreatmentDate] DATETIME NULL,
          [TreatedBy] INT NULL;
GO
PRINT N'Creating [Payroll].[FK_DocumentRequest_Superior]...';


GO
ALTER TABLE [Payroll].[DocumentRequest] WITH NOCHECK
    ADD CONSTRAINT [FK_DocumentRequest_Superior] FOREIGN KEY ([TreatedBy]) REFERENCES [Payroll].[Employee] ([Id]);


GO
PRINT N'Creating [Payroll].[FK_ExpenseReport_Superior]...';


GO
ALTER TABLE [Payroll].[ExpenseReport] WITH NOCHECK
    ADD CONSTRAINT [FK_ExpenseReport_Superior] FOREIGN KEY ([TreatedBy]) REFERENCES [Payroll].[Employee] ([Id]);


GO
PRINT N'Creating [Payroll].[FK_Leave_Superior]...';


GO
ALTER TABLE [Payroll].[Leave] WITH NOCHECK
    ADD CONSTRAINT [FK_Leave_Superior] FOREIGN KEY ([TreatedBy]) REFERENCES [Payroll].[Employee] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';

GO
ALTER TABLE [Payroll].[DocumentRequest] WITH CHECK CHECK CONSTRAINT [FK_DocumentRequest_Superior];

ALTER TABLE [Payroll].[ExpenseReport] WITH CHECK CHECK CONSTRAINT [FK_ExpenseReport_Superior];

ALTER TABLE [Payroll].[Leave] WITH CHECK CHECK CONSTRAINT [FK_Leave_Superior];


GO
PRINT N'Update complete.';

-------- Marwa add relation between document and contact ----------------
ALTER TABLE [Sales].[Document] WITH NOCHECK
    ADD CONSTRAINT [FK_Document_Contact] FOREIGN KEY ([IdContact]) REFERENCES [Shared].[Contact] ([Id]);
	
ALTER TABLE [Sales].[Document] WITH CHECK CHECK CONSTRAINT [FK_Document_Contact];

--------Marwa Add table reportTemplate----------------------
CREATE TABLE [ERPSettings].[ReportTemplate] (
    [Id]             INT            IDENTITY (1, 1) NOT NULL,
    [IdEntity]       INT            NULL,
    [TemplateCode]   NVARCHAR (255) NULL,
    [TemplateNameFr] NVARCHAR (255) NULL,
    [TemplateNameEn] NVARCHAR (255) NULL,
    CONSTRAINT [PK_ReportTemplate] PRIMARY KEY CLUSTERED ([Id] ASC)
);

ALTER TABLE [ERPSettings].[ReportTemplate] WITH NOCHECK
    ADD CONSTRAINT [FK_ReportTemplate_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id]);
	
ALTER TABLE [ERPSettings].[ReportTemplate] WITH CHECK CHECK CONSTRAINT [FK_ReportTemplate_Entity];
ALTER TABLE [Sales].[Document] WITH CHECK CHECK CONSTRAINT [FK_Document_Contact];



-- Mohamed BOUZIDI add Email table

CREATE TABLE [Shared].[Email] (
    [Id]					INT            IDENTITY (1, 1) NOT NULL,
    [Subject]				NVARCHAR (255) NOT NULL,
    [Body]					NVARCHAR (MAX) NOT NULL,
    [Status]				INT            NOT NULL,
    [Sender]				NVARCHAR (255) NOT NULL,
    [Receivers]				NVARCHAR (MAX) NOT NULL,
	[AttemptsToSendNumber]	INT            CONSTRAINT [DF_Email_AttemptsToSendNumber] DEFAULT ((0)) NOT NULL,
    [TransactionUserId]		INT            NULL,
    [IsDeleted]				BIT            NOT NULL,
    [Deleted_Token]			NVARCHAR (255) NULL,
    CONSTRAINT [PK_Email] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

ALTER TABLE [RH].[Interview]
DROP COLUMN [EmailSubject], [EmailBody];

ALTER TABLE [RH].[Interview]
  ADD [IdEmail] INT 
  CONSTRAINT [FK_Interview_Email] FOREIGN KEY ([IdEmail]) REFERENCES [Shared].[Email] ([Id]) NULL;



--Rabeb Create table Cv

CREATE TABLE [RH].[CV] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Entitled]          NVARCHAR (500) NOT NULL,
    [CurriculumVitaePath]            NVARCHAR (500) NOT NULL,
    [CreationDate]      DATE           CONSTRAINT [DF_CV_CreationDate] DEFAULT (getdate()) NOT NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IdCandidate]       INT            NOT NULL,
    [DepositDate]       DATE           NOT NULL,
    CONSTRAINT [PK_CV] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_CV_Candidate] FOREIGN KEY ([IdCandidate]) REFERENCES [RH].[Candidate] ([Id])
);

--Rabeb alter table delete CV column

ALTER TABLE [RH].[Candidacy]
DROP COLUMN [CV]

--Rabeb delete cv table
drop table [RH].[CV]

--Rabeb create CurriculumVitae table
CREATE TABLE [RH].[CurriculumVitae] (
    [Id]                  INT            IDENTITY (1, 1) NOT NULL,
    [Entitled]            NVARCHAR (500) NOT NULL,
    [CurriculumVitaePath] NVARCHAR (500) NOT NULL,
    [CreationDate]        DATE           CONSTRAINT [DF_CV_CreationDate] DEFAULT (getdate()) NOT NULL,
    [TransactionUserId]   INT            NULL,
    [IsDeleted]           BIT            NOT NULL,
    [Deleted_Token]       NVARCHAR (255) NULL,
    [IdCandidate]         INT            NOT NULL,
    [DepositDate]         DATE           NOT NULL,
    CONSTRAINT [PK_CV] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_CV_Candidate] FOREIGN KEY ([IdCandidate]) REFERENCES [RH].[Candidate] ([Id])
);

------Kossi alter table Offer and create table Advantages

ALTER TABLE [RH].[Offer]
	   ADD	 
			[StartDate]				DATE           NOT NULL,
			[EndDate]				DATE           NULL,
			[WorkingHoursPerWeek]	FLOAT (53)     NOT NULL,
			[Salary]				FLOAT (53)     NOT NULL,
			[MealVoucher]			FLOAT (53)     NULL,
			[AvailableCar]			BIT            NULL,
			[AvailableHouse]		BIT            NULL,
			[ThirteenthMonthBonus]	BIT            NULL,
			[CommissionType]		INT			   NULL,
			[CommissionValue]		FLOAT (53)     NULL,
			[IdSalaryStructure]		INT            NOT NULL;

ALTER TABLE [RH].[Offer] WITH NOCHECK
    ADD CONSTRAINT [FK_Offer_SalaryStructure] FOREIGN KEY ([IdSalaryStructure]) REFERENCES [Payroll].[SalaryStructure] ([Id]);

CREATE TABLE [RH].[Advantages] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Description]       NVARCHAR (250) NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IdOffer]           INT            NOT NULL,
    CONSTRAINT [PK_Advantages] PRIMARY KEY CLUSTERED ([Id] ASC)
);

ALTER TABLE [RH].[Advantages] WITH NOCHECK
    ADD CONSTRAINT [FK_Advantages_Advantages] FOREIGN KEY ([IdOffer]) REFERENCES [RH].[Offer] ([Id]) ON DELETE CASCADE;

ALTER TABLE [RH].[Offer] WITH CHECK CHECK CONSTRAINT [FK_Offer_Candidacy];

ALTER TABLE [RH].[Offer] WITH CHECK CHECK CONSTRAINT [FK_Offer_SalaryStructure];
ALTER TABLE [RH].[Advantages] WITH CHECK CHECK CONSTRAINT [FK_Advantages_Advantages];
ALTER TABLE [RH].[Advantages] WITH CHECK CHECK CONSTRAINT [FK_Advantages_Advantages];


--Rabeb BEN SALAH add EvaluationCriteriaTheme , EvaluationCriteria, CriteriaMark  tables 

CREATE TABLE [RH].[EvaluationCriteriaTheme] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Label]             NVARCHAR (100) NOT NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_EvaluationCriteriaTheme] PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [RH].[EvaluationCriteria] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Label]                     NVARCHAR (100) NOT NULL,
    [IdEvaluationCriteriaTheme] INT            NOT NULL,
    [Code]                      NVARCHAR (50)  NOT NULL,
    [TransactionUserId]         INT            NULL,
    [IsDeleted]                 BIT            NOT NULL,
    [Deleted_Token]             NVARCHAR (255) NULL,
    CONSTRAINT [PK_EvaluationCriteria] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_EvaluationCriteria_EvaluationCriteriaTheme] FOREIGN KEY ([IdEvaluationCriteriaTheme]) REFERENCES [RH].[EvaluationCriteriaTheme] ([Id])
);

CREATE TABLE [RH].[CriteriaMark] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Mark]                 FLOAT (53)     NULL,
    [IdEvaluationCriteria] INT            NOT NULL,
    [IdInterviewMark]      INT            NOT NULL,
    [TransactionUserId]    INT            NULL,
    [IsDeleted]            BIT            NOT NULL,
    [Deleted_Token]        NVARCHAR (255) NULL,
    CONSTRAINT [PK_CriteriaMark] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_CriteriaMark_EvaluationCriteria] FOREIGN KEY ([IdEvaluationCriteria]) REFERENCES [RH].[EvaluationCriteria] ([Id]),
	CONSTRAINT [FK_CriteriaMark_InterviewMark] FOREIGN KEY ([IdInterviewMark]) REFERENCES [RH].[InterviewMark] ([Id])
);

-- Imen: Add codification
ALTER TABLE [Payroll].[DocumentRequest] ADD [Code] NVARCHAR (255) NULL
ALTER TABLE [Payroll].[ExpenseReport] ADD [Code] NVARCHAR (255) NULL
ALTER TABLE [Payroll].[Leave] ADD [Code] NVARCHAR (255) NULL


---- Nihel add sale settings column
GO
PRINT N'Altering [Sales].[SaleSettings]...';


GO
ALTER TABLE [Sales].[SaleSettings]
    ADD [InvoicingDay]      INT NULL,
        [InvoicingEndMonth] BIT CONSTRAINT [DF_SaleSettings_InvoicingEndMonth] DEFAULT ((1)) NOT NULL;
GO

-- chedi Add TecDoc Reference column
ALTER TABLE [Inventory].[Item]
    ADD [TecDocRef]  NVARCHAR (20)  NULL;

---- nihel: add constraint Document- DocumentExpenseLine
GO
PRINT N'Dropping [Sales].[FK_DocumentExpenseLine_Document]...';


GO
ALTER TABLE [Sales].[DocumentExpenseLine] DROP CONSTRAINT [FK_DocumentExpenseLine_Document];


GO
PRINT N'Creating [Sales].[FK_DocumentExpenseLine_Document]...';


GO
ALTER TABLE [Sales].[DocumentExpenseLine] WITH NOCHECK
    ADD CONSTRAINT [FK_DocumentExpenseLine_Document] FOREIGN KEY ([IdDocument]) REFERENCES [Sales].[Document] ([Id]) ON DELETE CASCADE;


GO
PRINT N'Checking existing data against newly created constraints';


GO
ALTER TABLE [Sales].[DocumentExpenseLine] WITH CHECK CHECK CONSTRAINT [FK_DocumentExpenseLine_Document];

---- Nihel set bool to false default

UPDATE [Sales].[Document]
   SET [IsTermBilling] = 0
 WHERE [IsTermBilling] IS NULL
GO

GO
PRINT N'Altering [Sales].[Document]...';


GO
ALTER TABLE [Sales].[Document] ALTER COLUMN [IsTermBilling] BIT NOT NULL;


GO
PRINT N'Creating [Sales].[DF_Document_IsTermBilling]...';


GO
ALTER TABLE [Sales].[Document]
    ADD CONSTRAINT [DF_Document_IsTermBilling] DEFAULT ((0)) FOR [IsTermBilling];

	-- chedi Add TecDoc ID column
ALTER TABLE [Inventory].[Item] ADD [TecDocId] INT NULL;
   ALTER TABLE [Inventory].[Item] DROP COLUMN [TecDocRef];


-- Narcisse : TimeSheet
 
ALTER TABLE [RH].[TimeSheet] DROP COLUMN [CreationDate]
ALTER TABLE [RH].[TimeSheet] DROP COLUMN [State]

ALTER TABLE [RH].[TimeSheet] ADD [CreationDate] DATETIME CONSTRAINT [DF_TimeSheet_CreationDate] DEFAULT (getdate()) NOT NULL,
 [Status] INT NOT NULL,
 [TreatmentDate] DATETIME NULL,
 [IdEmployeeTreated] INT NULL
ALTER TABLE [RH].[TimeSheet] ADD CONSTRAINT [FK_TimeSheet_Employee1] FOREIGN KEY ([IdEmployeeTreated]) REFERENCES [Payroll].[Employee] ([Id])

ALTER TABLE [RH].[TimeSheetLine] DROP CONSTRAINT [FK_TimeSheetLine_TimeSheet]
ALTER TABLE [RH].[TimeSheetLine] ADD  CONSTRAINT [FK_TimeSheetLine_TimeSheet] FOREIGN KEY ([IdTimeSheet]) REFERENCES [RH].[TimeSheet] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE

-- NArcisse: Add project structure alter

ALTER TABLE [RH].[Project] ADD
[StartDate]         DATE           NOT NULL,
    [ExpectedEndDate]   DATE           NULL,
    [ProjectType]       INT            NOT NULL
---Kossi atler table Offer
GO
ALTER TABLE  [RH].[Offer] ADD
	[CreationDate]         DATE           CONSTRAINT [DF_Offer_CreationDate] DEFAULT (getdate()) NOT NULL,
    [SendingDate]          DATE           NULL;
-- Rabeb  ADD CONSTRAINT UC_Employee_Interview UNIQUE

  ALTER TABLE [RH].[InterviewMark]
  ADD CONSTRAINT UC_Employee_Interview UNIQUE (IdEmployee, IdInterview, Deleted_Token)

-- Narcisse : Add Period, Hours and DayOff


CREATE TABLE [Shared].[Period] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Label]             NVARCHAR (255) NOT NULL,
    [StartDate]         DATE           NOT NULL,
    [EndDate]           DATE           NULL,
    [FirstDayOfWork]    INT            NOT NULL,
    [LastDayOfWork]     INT            NOT NULL,
    [IsDeleted]         BIT            CONSTRAINT [DF_Period_IsDeleted] DEFAULT ((0)) NOT NULL,
    [TransactionUserId] INT            CONSTRAINT [DF_Period_TransactionUserId] DEFAULT ((0)) NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Period] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [Shared].[DayOff] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Label]             NVARCHAR (255) NOT NULL,
    [Date]              DATE           NOT NULL,
    [IsDeleted]         BIT            CONSTRAINT [DF_DayOff_IsDeleted] DEFAULT ((0)) NOT NULL,
    [TransactionUserId] INT            CONSTRAINT [DF_DayOff_TransactionUserId] DEFAULT ((0)) NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IdPeriod]          INT            NOT NULL,
    CONSTRAINT [PK_DayOff] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_DayOff_Period] FOREIGN KEY ([IdPeriod]) REFERENCES [Shared].[Period] ([Id])  ON DELETE CASCADE
);
GO

CREATE TABLE [Shared].[Hours] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Label]             NVARCHAR (255) NOT NULL,
    [StartTime]         TIME (7)       NOT NULL,
    [EndTime]           TIME (7)       NOT NULL,
    [IdPeriod]          INT            NOT NULL,
	[WorkTimeTable]    BIT           NOT NULL,
    [IsDeleted]         BIT            CONSTRAINT [DF_Hours_IsDeleted] DEFAULT ((0)) NOT NULL,
    [TransactionUserId] INT            CONSTRAINT [DF_Hours_TransactionUserId] DEFAULT ((0)) NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Hours] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Hours_Period] FOREIGN KEY ([IdPeriod]) REFERENCES [Shared].[Period] ([Id])  ON DELETE CASCADE
);
GO

ALTER TABLE [RH].[TimeSheetLine] DROP COLUMN [Description]

ALTER TABLE [RH].[TimeSheetLine] ADD [Details] NVARCHAR (MAX) NULL

-- Rabeb Add unique email constraint on candidate table

ALTER TABLE [RH].[Candidate]
ADD UNIQUE (Email);

-- Rabeb Add IdCitizenship to the candidate table with constraint

 ALTER TABLE [RH].[Candidate]
 ADD [IdCitizenship] INT NULL;

 ALTER TABLE [RH].[Candidate] WITH NOCHECK
 ADD CONSTRAINT [FK_Candidate_Country] FOREIGN KEY ([IdCitizenship]) REFERENCES [Shared].[Country] ([Id]);

 ALTER TABLE [RH].[Candidate] WITH CHECK CHECK CONSTRAINT [FK_Candidate_Country];
---Kossi atler table Offer  add Email fk
GO
ALTER TABLE  [RH].[Offer] ADD
	[IdEmail]	INT		CONSTRAINT [FK_Offer_Email] FOREIGN KEY ([IdEmail]) REFERENCES [Shared].[Email] ([Id])		NULL,
	[IdCnss]	INT		CONSTRAINT [FK_Offer_Cnss] FOREIGN KEY ([IdCnss]) REFERENCES [Payroll].[Cnss] ([Id])		NOT NULL

--- Imen chaaben : create LeaveEmail DocumentRequestEmail, ExpenseReportEmail

CREATE TABLE [Payroll].[LeaveEmail] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdLeave]           INT            NOT NULL,
    [IdEmail]           INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_LeaveEmail] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Leave] FOREIGN KEY ([IdLeave]) REFERENCES [Payroll].[Leave] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Mail] FOREIGN KEY ([IdEmail]) REFERENCES [Shared].[Email] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [Payroll].[DocumentRequestEmail] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdDocumentRequest] INT            NOT NULL,
    [IdEmail]           INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_DocumentRequestEmail] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_DocumentRequest] FOREIGN KEY ([IdDocumentRequest]) REFERENCES [Payroll].[DocumentRequest] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_DocumentRequestEmail] FOREIGN KEY ([IdEmail]) REFERENCES [Shared].[Email] ([Id])
);
GO

CREATE TABLE [Payroll].[ExpenseReportEmail] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdExpenseReport]   INT            NOT NULL,
    [IdEmail]           INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_ExpenseReportEmail] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Email] FOREIGN KEY ([IdEmail]) REFERENCES [Shared].[Email] ([Id]),
    CONSTRAINT [FK_ExpenseReport] FOREIGN KEY ([IdExpenseReport]) REFERENCES [Payroll].[ExpenseReport] ([Id]) ON DELETE CASCADE
);
GO

-- Narcisse: Change leave time columns name by the new name adopted, add Employee project 

ALTER TABLE [Payroll].[Leave] ADD [StartTime] TIME (7) NOT NULL,
    [EndTime] TIME (7) NOT NULL

ALTER TABLE [Payroll].[Leave] DROP COLUMN [TimeLeaveStart], [TimeLeaveEnd]

ALTER TABLE [RH].[Project] ADD [IdTaxe] INT NULL,
    [AverageDailyRate] FLOAT (53) NULL,
    [IdTiers] INT NOT NULL

ALTER TABLE [RH].[Project] DROP COLUMN [Description]

ALTER TABLE [RH].[Project] ADD CONSTRAINT [FK_Project_Taxe] FOREIGN KEY ([IdTaxe]) REFERENCES [Shared].[Taxe] ([Id]),
    CONSTRAINT [FK_Project_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])

ALTER TABLE [Shared].[Company] DROP COLUMN [StartTimeOfWork], [EndTimeOfWork]

CREATE TABLE [RH].[EmployeeProject] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [AssignmentDate]    DATETIME       CONSTRAINT [DF_EmployeeProject_AssignmentDate] DEFAULT (getdate()) NOT NULL,
    [UnassignmentDate]  DATETIME       NULL,
    [IdEmployee]        INT            NOT NULL,
    [IdProject]         INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_EmployeeProject] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_EmployeeProject_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]),
    CONSTRAINT [FK_EmployeeProject_Project] FOREIGN KEY ([IdProject]) REFERENCES [RH].[Project] ([Id])
);

ALTER TABLE [Shared].[Period] ALTER COLUMN [EndDate] DATE NOT NULL;

-- Narcisse : Alter start and end time column to nullable

ALTER TABLE [Payroll].[Leave] ALTER COLUMN [StartTime] TIME (7) NULL
ALTER TABLE [Payroll].[Leave] ALTER COLUMN [EndTime] TIME (7) NULL

-- Narcisse : Add delete cascade constraint on period, hours and day off

ALTER TABLE [Shared].[DayOff] DROP CONSTRAINT [FK_DayOff_Period]

ALTER TABLE [Shared].[DayOff] ADD CONSTRAINT [FK_DayOff_Period] FOREIGN KEY ([IdPeriod]) REFERENCES [Shared].[Period] ([Id]) ON DELETE CASCADE

ALTER TABLE [Shared].[Hours] DROP CONSTRAINT [FK_Hours_Period]

ALTER TABLE [Shared].[Hours] ADD CONSTRAINT [FK_Hours_Period] FOREIGN KEY ([IdPeriod]) REFERENCES [Shared].[Period] ([Id]) ON DELETE CASCADE
PRINT N'Update complete.';

-- Narcisse : Add page number in declaration details table

ALTER TABLE Payroll.CnssDeclarationDetails ADD PageNumber int Not null DEFAULT 0

---- Change item constraint
ALTER TABLE Inventory.Item
DROP CONSTRAINT UniqueCodeItem;
ALTER TABLE Inventory.Item
ADD CONSTRAINT UC_Item UNIQUE (Deleted_Token,Code,IdTiers);

-- chedi Add TecDoc Reference column
ALTER TABLE [Inventory].[Item]
    ADD [TecDocRef]  NVARCHAR (50)  NULL;
	
	--houssem
	
DROP TABLE [Sales].[TiersPriceRequest];

alter table  [Sales].[PriceRequestDetail]   add 
[IdTiers]           INT            NULL,
[IdContact]         INT            NULL
   GO

UPDATE [Sales].[PriceRequestDetail]
   SET IdTiers = (Select top 1 Id from Sales.Tiers Where IdTypeTiers = 2)
   Where IdTiers IS NULL
GO  

ALTER TABLE [Sales].[PriceRequestDetail]
ALTER COLUMN IdTiers INT NOT NULL 

ALTER TABLE [Sales].[PriceRequestDetail] WITH NOCHECK
    ADD CONSTRAINT [FK_PriceRequestDetail_Contact] FOREIGN KEY ([IdContact]) REFERENCES [Shared].[Contact] ([Id]);
GO

ALTER TABLE [Sales].[PriceRequestDetail] WITH NOCHECK
    ADD CONSTRAINT [FK_PriceRequestDetail_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id]);
GO

-- chedi Add TecDoc Supplier column
ALTER TABLE [Inventory].[Item]
    ADD [TecDocIdSupplier]  INT  NULL;
	GO