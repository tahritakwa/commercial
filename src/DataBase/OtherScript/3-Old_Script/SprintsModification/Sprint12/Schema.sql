---Add Immobilisation table
 GO
PRINT N'Creating [Immobilisation]...';


GO
CREATE SCHEMA [Immobilisation]
    AUTHORIZATION [dbo];


GO
PRINT N'Altering [Sales].[DocumentLine]...';


GO
ALTER TABLE [Sales].[DocumentLine]
    ADD [isActive] BIT NULL;
GO
PRINT N'Creating [Immobilisation].[Active]...';


GO
CREATE TABLE [Immobilisation].[Active] (
	[Id]                 INT IDENTITY (1, 1) NOT NULL,
    [Label]              NVARCHAR (50)  NULL,
    [DepreciationPeriod] INT            NULL,
    [AcquisationDate]    DATE           NULL,
    [ServiceDate]        DATE           NULL,
    [Status]             NVARCHAR (50)  NULL,
    [IdDocumentLine]     INT            NULL,
    [Value]              FLOAT (53)     NULL,
    [IdCategory]         INT            NULL,
    [Code]               NVARCHAR (255) NULL,
    [Deleted_Token]      NVARCHAR (50)  NULL,
    [IsDeleted]          BIT            NOT NULL,
    [TransactionUserId]  INT            NULL,
    [NumSerie]           NVARCHAR (50)  NULL,
    CONSTRAINT [PK_Active] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Immobilisation].[Category]...';


GO
CREATE TABLE [Immobilisation].[Category] (
    [Id]                 INT IDENTITY (1, 1) NOT NULL,
    [MinPeriod]          INT           NULL,
    [MaxPeriod]          INT           NULL,
    [ImmobilisationType] INT           NULL,
    [Label]              NVARCHAR (50) NULL,
    [Deleted_Token]      NVARCHAR (50) NULL,
    [IsDeleted]          BIT           NOT NULL,
    [TransactionUserId]  INT           NULL,
    [Code]               NVARCHAR (50) NULL,
    CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
PRINT N'Creating [Immobilisation].[History]...';


GO
CREATE TABLE [Immobilisation].[History] (
    [Id]                INT IDENTITY (1, 1) NOT NULL,
    [IdEmployee]        INT           NULL,
    [IdActive]          INT           NULL,
    [AcquisationDate]   DATE          NULL,
    [AbandonmentDate]   DATE          NULL,
    [Deleted_Token]     NVARCHAR (50) NULL,
    [IsDeleted]         BIT           NOT NULL,
    [TransactionUserId] INT           NULL,
    CONSTRAINT [PK_History_1] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Immobilisation].[FK_Active_DocumentLine1]...';

GO
PRINT N'Creating [Immobilisation].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Immobilisation Schema', @level0type = N'SCHEMA', @level0name = N'Immobilisation';

GO
ALTER TABLE [Immobilisation].[Active] WITH NOCHECK
    ADD CONSTRAINT [FK_Active_DocumentLine1] FOREIGN KEY ([IdDocumentLine]) REFERENCES [Sales].[DocumentLine] ([Id]);


GO
PRINT N'Creating [Immobilisation].[FK_Active_Category1]...';


GO
ALTER TABLE [Immobilisation].[Active] WITH NOCHECK
    ADD CONSTRAINT [FK_Active_Category1] FOREIGN KEY ([IdCategory]) REFERENCES [Immobilisation].[Category] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

GO
PRINT N'Creating [Immobilisation].[FK_History_Employee]...';


GO
ALTER TABLE [Immobilisation].[History] WITH NOCHECK
    ADD CONSTRAINT [FK_History_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]);


GO
PRINT N'Creating [Immobilisation].[FK_History_Active]...';


GO
ALTER TABLE [Immobilisation].[History] WITH NOCHECK
    ADD CONSTRAINT [FK_History_Active] FOREIGN KEY ([IdActive]) REFERENCES [Immobilisation].[Active] ([Id]);

ALTER TABLE [Immobilisation].[Active] WITH CHECK CHECK CONSTRAINT [FK_Active_DocumentLine1];

ALTER TABLE [Immobilisation].[Active] WITH CHECK CHECK CONSTRAINT [FK_Active_Category1];

ALTER TABLE [Immobilisation].[History] WITH CHECK CHECK CONSTRAINT [FK_History_Employee];

ALTER TABLE [Immobilisation].[History] WITH CHECK CHECK CONSTRAINT [FK_History_Active];

----Nihel: Add constraint for isActive column in DocumentLine Table
---- Add [IsActiveGeneration] column in [DocumentType] Table
GO
PRINT N'Altering [Sales].[DocumentLine]...';

EXEC sp_RENAME '[Sales].[DocumentLine].isActive' , 'IsActive', 'COLUMN'
GO


UPDATE [Sales].[DocumentLine] SET IsActive = 0 WHERE IsActive IS NULL
ALTER TABLE [Sales].[DocumentLine] ALTER COLUMN IsActive BIT NOT NULL

GO
PRINT N'Creating [Sales].[DF_DocumentLine_IsActive]...';


GO
ALTER TABLE [Sales].[DocumentLine]
    ADD CONSTRAINT [DF_DocumentLine_IsActive] DEFAULT ((0)) FOR [IsActive];


GO
PRINT N'Altering [Sales].[DocumentType]...';


GO
ALTER TABLE [Sales].[DocumentType]
    ADD [IsActiveGeneration] BIT CONSTRAINT [DF_DocumentType_IsImmobilisationGeneration] DEFAULT ((0)) NOT NULL;

GO

/****** Object:  Index [UniqueCodeImmobilisationCategory]    Script Date: 04/09/2018 09:22:44 ******/
ALTER TABLE [Immobilisation].[Category] ADD  CONSTRAINT [UniqueCodeImmobilisationCategory] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


--Change Stuts to int

IF EXISTS (select top 1 1 from [Immobilisation].[Active])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Altering [Immobilisation].[Active]...';


GO
ALTER TABLE [Immobilisation].[Active] ALTER COLUMN [Status] INT NULL;


GO
PRINT N'Update complete.';


GO


-- Narcisse 

GO
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Echellon];


GO
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Grade];


GO
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_Job];


GO
ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_Applicability];


GO
ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_ContributionRegister];


GO
ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_RuleCategory];


GO
ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_RuleType];


GO
ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_RuleUniqueReference];


GO
ALTER TABLE [Payroll].[SalaryStructure_SalaryRule] DROP CONSTRAINT [FK_SalaryStructureRule_Rule];


GO
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_ContractType];


GO
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_NationalityCity];


GO
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_NationalityCountry];


GO
DROP TABLE [Payroll].[Applicability];

GO
DROP TABLE [Payroll].[RuleCategory];

GO
DROP TABLE [Payroll].[RuleType];

GO
ALTER TABLE [Payroll].[Contract] DROP COLUMN [IdContractType];

CREATE TABLE [Payroll].[tmp_ms_xx_Echellon] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Designation]       NVARCHAR (255) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [Description]       NVARCHAR (255) NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Echellon1] PRIMARY KEY CLUSTERED ([Id] ASC)
);

DROP TABLE [Payroll].[Echellon];

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_Echellon]', N'Echellon';

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_constraint_PK_Echellon1]', N'PK_Echellon', N'OBJECT';

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
ALTER TABLE [Payroll].[Employee] DROP COLUMN [EndContractDate], COLUMN [IdNationalityCity], COLUMN [IdNationalityCountry], COLUMN [RecruitmentDate];

GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [Payroll].[tmp_ms_xx_Grade] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Designation]       NVARCHAR (255) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [Description]       NVARCHAR (255) NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Grade1] PRIMARY KEY CLUSTERED ([Id] ASC)
);

DROP TABLE [Payroll].[Grade];

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_Grade]', N'Grade';

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_constraint_PK_Grade1]', N'PK_Grade', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [Payroll].[tmp_ms_xx_Job] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Designation]       NVARCHAR (255) NOT NULL,
    [Description]       NVARCHAR (255) NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Job1] PRIMARY KEY CLUSTERED ([Id] ASC)
);


DROP TABLE [Payroll].[Job];

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_Job]', N'Job';

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_constraint_PK_Job1]', N'PK_Job', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

GO
ALTER TABLE [Payroll].[Payslip] DROP COLUMN [ExpirationDate];


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [Payroll].[tmp_ms_xx_SalaryRule] (
    [Id]                     INT             IDENTITY (1, 1) NOT NULL,
    [Name]                   NVARCHAR (255)  NOT NULL,
    [Description]            NVARCHAR (255)  NOT NULL,
    [Order]                  INT             NOT NULL,
    [rule]                   NVARCHAR (2000) NULL,
    [RuleType]               INT             NOT NULL,
    [AppearsOnPaySlip]       BIT             NOT NULL,
    [Applicability]          INT             NULL,
    [RuleCategory]           INT             NOT NULL,
    [IsDeleted]              BIT             NOT NULL,
    [TransactionUserId]      INT             NULL,
    [Deleted_Token]          NVARCHAR (255)  NULL,
    [IdContributionRegister] INT             NULL,
    [IdRuleUniqueReference]  INT             NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_SalaryRule1] PRIMARY KEY CLUSTERED ([Id] ASC)
);


DROP TABLE [Payroll].[SalaryRule];

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_SalaryRule]', N'SalaryRule';

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_constraint_PK_SalaryRule1]', N'PK_SalaryRule', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

GO
ALTER TABLE [Payroll].[Employee] WITH NOCHECK
    ADD CONSTRAINT [FK_Employee_Echellon] FOREIGN KEY ([IdEchellon]) REFERENCES [Payroll].[Echellon] ([Id]);

GO
ALTER TABLE [Payroll].[Employee] WITH NOCHECK
    ADD CONSTRAINT [FK_Employee_Grade] FOREIGN KEY ([IdGrade]) REFERENCES [Payroll].[Grade] ([Id]);

GO
ALTER TABLE [Payroll].[Contract] WITH NOCHECK
    ADD CONSTRAINT [FK_Contract_Job] FOREIGN KEY ([IdJob]) REFERENCES [Payroll].[Job] ([Id]);


GO
ALTER TABLE [Payroll].[SalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryRule_ContributionRegister] FOREIGN KEY ([IdContributionRegister]) REFERENCES [Payroll].[ContributionRegister] ([Id]);


GO
ALTER TABLE [Payroll].[SalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryRule_RuleUniqueReference] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id]);

GO
ALTER TABLE [Payroll].[SalaryStructure_SalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryStructureRule_Rule] FOREIGN KEY ([IdRule]) REFERENCES [Payroll].[SalaryRule] ([Id]);

GO
PRINT N'Mise à jour terminée.';

GO

---Fix bug delete ---
GO
PRINT N'Dropping [Immobilisation].[FK_Active_DocumentLine1]...';


GO
ALTER TABLE [Immobilisation].[Active] DROP CONSTRAINT [FK_Active_DocumentLine1];


GO
PRINT N'Dropping [Immobilisation].[FK_History_Active]...';


GO
ALTER TABLE [Immobilisation].[History] DROP CONSTRAINT [FK_History_Active];


GO
PRINT N'Dropping [Immobilisation].[FK_History_Employee]...';


GO
ALTER TABLE [Immobilisation].[History] DROP CONSTRAINT [FK_History_Employee];


GO
PRINT N'Creating [Immobilisation].[FK_Active_DocumentLine1]...';


GO
ALTER TABLE [Immobilisation].[Active] WITH NOCHECK
    ADD CONSTRAINT [FK_Active_DocumentLine1] FOREIGN KEY ([IdDocumentLine]) REFERENCES [Sales].[DocumentLine] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating [Immobilisation].[FK_History_Active]...';


GO
ALTER TABLE [Immobilisation].[History] WITH NOCHECK
    ADD CONSTRAINT [FK_History_Active] FOREIGN KEY ([IdActive]) REFERENCES [Immobilisation].[Active] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating [Immobilisation].[FK_History_Employee]...';


GO
ALTER TABLE [Immobilisation].[History] WITH NOCHECK
    ADD CONSTRAINT [FK_History_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Checking existing data against newly created constraints';


GO
ALTER TABLE [Immobilisation].[Active] WITH CHECK CHECK CONSTRAINT [FK_Active_DocumentLine1];

ALTER TABLE [Immobilisation].[History] WITH CHECK CHECK CONSTRAINT [FK_History_Active];

ALTER TABLE [Immobilisation].[History] WITH CHECK CHECK CONSTRAINT [FK_History_Employee];


GO
PRINT N'Update complete.';


GO
--BOUBAKER ECHIEB : Drop Transfer table
GO
/*
Table [Administration].[Transfer] is being dropped.  Deployment will halt if the table contains data.
*/

IF EXISTS (select top 1 1 from [Administration].[Transfer])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Dropping [Administration].[FK_Transfer_Entity]...';


GO
ALTER TABLE [Administration].[Transfer] DROP CONSTRAINT [FK_Transfer_Entity];


GO
PRINT N'Dropping [Administration].[Transfer]...';


GO
DROP TABLE [Administration].[Transfer];


GO
PRINT N'Update complete.';


GO
--integration hot fix 


---- Nihel: Add TaxeType Column in Taxe type
GO
PRINT N'Altering [Shared].[Taxe]...';


GO
ALTER TABLE [Shared].[Taxe]
    ADD [TaxeType] INT CONSTRAINT [DF_Taxe_TaxeType] DEFAULT ((1)) NOT NULL;


GO
PRINT N'Update complete.';


GO
---- Nihel: Change colmn name + add columns in table documentLine + Document
EXEC sp_rename 'Sales.DocumentLine.TaxAmount', 'VatTaxAmount', 'COLUMN'
EXEC sp_rename 'Sales.DocumentLine.TaxAmountWithCurrency', 'VatTaxAmountWithCurrency', 'COLUMN'
EXEC sp_rename 'Sales.DocumentLine.TaxRate', 'VatTaxRate', 'COLUMN'
EXEC sp_rename 'Sales.Document.DocumentTotalTaxes', 'DocumentTotalVatTaxes', 'COLUMN'
EXEC sp_rename 'Sales.Document.DocumentTotalTaxesWithCurrency', 'DocumentTotalVatTaxesWithCurrency', 'COLUMN'

GO
PRINT N'Altering [Sales].[Document]...';


GO
ALTER TABLE [Sales].[Document]
    ADD [DocumentTotalBaseHtTaxes]             FLOAT (53) NULL,
        [DocumentTotalBaseHtTaxesWithCurrency] FLOAT (53) NULL;


GO
PRINT N'Altering [Sales].[DocumentLine]...';


GO
ALTER TABLE [Sales].[DocumentLine]
    ADD [BaseHtTaxAmount]             FLOAT (53) NULL,
        [BaseHtTaxRate]               FLOAT (53) NULL,
        [BaseHtTaxAmountWithCurrency] FLOAT (53) NULL;

GO
PRINT N'Update complete.';


GO

-----
EXEC sp_rename 'Sales.DocumentLine.BaseHtTaxAmount', 'ExcVatTaxAmount', 'COLUMN'
EXEC sp_rename 'Sales.DocumentLine.BaseHtTaxRate', 'ExcVatTaxRate', 'COLUMN'
EXEC sp_rename 'Sales.DocumentLine.BaseHtTaxAmountWithCurrency', 'ExcVatTaxAmountWithCurrency', 'COLUMN'

EXEC sp_rename 'Sales.Document.DocumentTotalBaseHtTaxes', 'DocumentTotalExcVatTaxes', 'COLUMN'
EXEC sp_rename 'Sales.Document.DocumentTotalBaseHtTaxesWithCurrency', 'DocumentTotalExcVatTaxesWithCurrency', 'COLUMN'



-------- Marwa Merge hays -------------

GO
ALTER TABLE [Inventory].[Item]
    ADD [IdTiers] INT NULL;

GO
ALTER TABLE [Inventory].[Item] WITH NOCHECK
    ADD CONSTRAINT [FK_Item_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id]);

ALTER TABLE [Inventory].[Item] WITH CHECK CHECK CONSTRAINT [FK_Item_Tiers];

GO
ALTER TABLE [ERPSettings].[Information]
    ADD [IsAcceptedInfo] BIT CONSTRAINT [DF_Information_IsAcceptedInfo] DEFAULT ((0)) NULL;
GO

---- Nihel : add purchasingManager id in purchasingSettings table
GO
PRINT N'Altering [Sales].[PurchaseSettings]...';


GO
ALTER TABLE [Sales].[PurchaseSettings]
    ADD [IdPurchasingManager] INT NULL;


GO
PRINT N'Creating [Sales].[FK_PurchaseSettings_User]...';


GO
ALTER TABLE [Sales].[PurchaseSettings] WITH NOCHECK
    ADD CONSTRAINT [FK_PurchaseSettings_User] FOREIGN KEY ([IdPurchasingManager]) REFERENCES [ERPSettings].[User] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';




GO
ALTER TABLE [Sales].[PurchaseSettings] WITH CHECK CHECK CONSTRAINT [FK_PurchaseSettings_User];

---- Marwa : Add configuration isToManager ----
GO
ALTER TABLE [ERPSettings].[Information]
    ADD [IsToManager] BIT CONSTRAINT [DF_Information_IsToManager] DEFAULT ((0)) NULL;


GO

--Narcisse : Make applicability column not null

GO
ALTER TABLE [Payroll].[SalaryRule] ALTER COLUMN [Applicability] INT NOT NULL;


GO
PRINT N'Mise à jour terminée.';


GO

-- Narcisse : Make description column null


GO
ALTER TABLE [Payroll].[SalaryRule] ALTER COLUMN [Description] NVARCHAR (255) NULL;
GO
PRINT N'Mise à jour terminée.';


GO