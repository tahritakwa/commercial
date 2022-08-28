--Ahmed : Add New column [IsDecomposable] in  the table [Inventory].[MeasureUnit]
ALTER TABLE [Inventory].[MeasureUnit]
	ADD [IsDecomposable] bit CONSTRAINT [DF_MeasureUnit_IsDecomposable] DEFAULT ((0)) NOT NULL,
		[DigitsAfterComma] INT CONSTRAINT [DF_MeasureUnit_DigitsAfterComma] DEFAULT ((0)) NOT NULL;

---Ahmed : Add new column [ProvisionalCode] in the table [Sales].[Document] 
ALTER TABLE [Sales].[Document]
	ADD [ProvisionalCode]  NVARCHAR (255) NULL;

	-- chedi : add double input inventory
		GO
PRINT N'Altering [Inventory].[StockDocument]...';


GO
ALTER TABLE [Inventory].[StockDocument]
    ADD [IdInputUser1] INT NULL,
        [IdInputUser2] INT NULL;


GO
PRINT N'Altering [Inventory].[StockDocumentLine]...';


GO
ALTER TABLE [Inventory].[StockDocumentLine]
    ADD [ForecastQuantity2] FLOAT (53) NULL;


GO
PRINT N'Creating [Inventory].[FK_StockDocument_User1]...';


GO
ALTER TABLE [Inventory].[StockDocument] WITH NOCHECK
    ADD CONSTRAINT [FK_StockDocument_User1] FOREIGN KEY ([IdInputUser1]) REFERENCES [ERPSettings].[User] ([Id]);


GO
PRINT N'Creating [Inventory].[FK_StockDocument_User2]...';


GO
ALTER TABLE [Inventory].[StockDocument] WITH NOCHECK
    ADD CONSTRAINT [FK_StockDocument_User2] FOREIGN KEY ([IdInputUser2]) REFERENCES [ERPSettings].[User] ([Id]);

-- Mohamed BOUZIDI : Add New column [SearchByNewReferences], [NewReferencesStartDate] and [NewReferencesEndDate]
ALTER TABLE [Sales].[ProvisioningOption] 
	ADD [SearchByNewReferences]  BIT            CONSTRAINT [DF_ProvisioningOption_SearchBySalesHistory1] DEFAULT ((0)) NOT NULL,
    [NewReferencesStartDate] DATETIME       NULL,
    [NewReferencesEndDate]   DATETIME       NULL;


--Fatma add [IsRestaurn] in [Sales].[Document] table
ALTER TABLE [Sales].[Document]
    ADD [IsRestaurn] BIT CONSTRAINT [DF_Document_IsRestourn] DEFAULT ((0)) NOT NULL;


 -- chedi : add is tecdoc to user table 
 GO
ALTER TABLE [ERPSettings].[User]
    ADD [IsTecDoc] BIT NULL;
	--chedi : add oem table
	CREATE TABLE [Inventory].[Oem] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdTecDoc]          INT            NOT NULL,
    [OemCode]           NVARCHAR (50)  NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            CONSTRAINT [DF_Oem_TransactionUserId] DEFAULT ((0)) NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Oem] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO


--chedi 25/05/2020 14h : add tecdoc Image Url
GO
ALTER TABLE [Inventory].[Item]
    ADD [TecDocImageUrl] NVARCHAR (MAX) NULL;


--- Souhail El Kamel : add table bankDeposit

GO
PRINT N'Altering [Payment].[Settlement]...';


GO
ALTER TABLE [Payment].[Settlement]
    ADD [IdPaymentSlip] INT NULL;


GO
PRINT N'Creating [Payment].[PaymentSlip]...';


GO
CREATE TABLE [Payment].[PaymentSlip] (
    [Id]                     INT            IDENTITY (1, 1) NOT NULL,
    [Reference]              INT            NULL,
    [Agency]                 NVARCHAR (50)  NULL,
    [Deposer]                NVARCHAR (50)  NULL,
    [Date]                   DATE           NULL,
    [IdBankAccount]          INT            NULL,
    [NumberOfSettlement]     INT            NULL,
    [TotalAmountWithNumbers] FLOAT (53)     NULL,
    [TotalAmountWithLetters] NVARCHAR (100) NULL,
    [State]                  INT            NULL,
    [Type]                   NVARCHAR (50)  NULL,
    [Deleted_Token]          NVARCHAR (255) NULL,
    [IsDeleted]              BIT            NOT NULL,
    CONSTRAINT [PK_PaymentSlip] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payment].[FK_Settlement_PaymentSlip]...';


GO
ALTER TABLE [Payment].[Settlement] WITH NOCHECK
    ADD CONSTRAINT [FK_Settlement_PaymentSlip] FOREIGN KEY ([IdPaymentSlip]) REFERENCES [Payment].[PaymentSlip] ([Id])
    ON UPDATE  NO ACTION 
    ON DELETE  SET NULL;


GO
PRINT N'Creating [Treasury].[FK_PaymentSlip_BankAccount]...';


GO
ALTER TABLE [Payment].[PaymentSlip] WITH NOCHECK
    ADD CONSTRAINT [FK_PaymentSlip_BankAccount] FOREIGN KEY ([IdBankAccount]) REFERENCES [Shared].[BankAccount] ([Id]);

 --chedi 05/06/2020 15h : add tecdoc Brand Name and change code type
GO
ALTER TABLE [Inventory].[Item]
    ADD [TecDocBrandName] NVARCHAR (MAX) NULL;


GO
ALTER TABLE [Ecommerce].[TriggerItemLog] ALTER COLUMN [Code] NVARCHAR (50) NULL;
