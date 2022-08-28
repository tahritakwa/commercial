---- Nihel: Add unique Constraint in tables : ComponentByRole, FunctionalityByRole, ModuleByRole
---- Delete duplicate from ComponentByRole
DELETE FROM ERPSettings.ComponentByRole
WHERE ERPSettings.ComponentByRole.Id In (Select RowId from (SELECT
   MAX(Id) as RowId, IdComponent, IdRole
FROM
    ERPSettings.ComponentByRole
GROUP BY
    IdComponent, IdRole
HAVING 
    COUNT(*) > 1
) as KeepRows)

---- Delete duplicate from FunctionalityByRole
DELETE FROM ERPSettings.FunctionalityByRole
WHERE ERPSettings.FunctionalityByRole.Id In (Select RowId from (SELECT
   MAX(Id) as RowId, IdFunctionality, IdRole
FROM
    ERPSettings.FunctionalityByRole
GROUP BY
    IdFunctionality, IdRole
HAVING 
    COUNT(*) > 1
) as KeepRows)

---- Delete duplicate from ModuleByRole
DELETE FROM ERPSettings.ModuleByRole
WHERE ERPSettings.ModuleByRole.Id In (Select RowId from (SELECT
   MAX(Id) as RowId, IdModule, IdRole
FROM
    ERPSettings.ModuleByRole
GROUP BY
    IdModule, IdRole
HAVING 
    COUNT(*) > 1
) as KeepRows)



GO
PRINT N'Creating [ERPSettings].[UniqueIdxCompByRole]...';


GO
ALTER TABLE [ERPSettings].[ComponentByRole]
    ADD CONSTRAINT [UniqueIdxCompByRole] UNIQUE NONCLUSTERED ([IdComponent] ASC, [IdRole] ASC);


GO
PRINT N'Creating [ERPSettings].[UniqueIdxFunctByRole]...';


GO
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [UniqueIdxFunctByRole] UNIQUE NONCLUSTERED ([IdFunctionality] ASC, [IdRole] ASC);


GO
PRINT N'Creating [ERPSettings].[UniqueIdxModuleByRole]...';


GO
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [UniqueIdxModuleByRole] UNIQUE NONCLUSTERED ([IdModule] ASC, [IdRole] ASC);


GO
PRINT N'Update complete.';


GO

---- Houssem: Payroll
alter table Payroll.ContractType
drop column  Label
GO

alter table Payroll.ContractType
add Fr nvarchar(250) null,
 En nvarchar(250) null
 GO

---- rename constraint
EXEC sp_rename N'ERPSettings.FK_ViewConfigurationRole_ViewConfiguration', N'FK_ComponentByRole_Component'
EXEC sp_rename N'ERPSettings.FK_ViewConfigurationRole_Role', N'FK_ComponentByRole_Role'


----
---Add Immobilisation table

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

---- sprint 1840
--Narcisse payroll task



GO
ALTER TABLE [Payroll].[Payslip] DROP CONSTRAINT [FK_Payslip_Contract];

GO
ALTER TABLE [Payroll].[Payslip] DROP CONSTRAINT [FK_Payslip_Employee];

GO
ALTER TABLE [Payroll].[PayslipDetails] DROP CONSTRAINT [FK_PayslipDetails_Payslip];

GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [Payroll].[tmp_ms_xx_Payslip] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [PayslipNumber]     NVARCHAR (255) NOT NULL,
    [PayPeriod]         DATE           NOT NULL,
    [StartDate]         DATE           NOT NULL,
    [EndDate]           DATE           NOT NULL,
    [PaymentDate]       DATE           NOT NULL,
    [IdContract]        INT            NOT NULL,
    [IdEmployee]        INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Payslip1] PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [Payroll].[Payslip])
    BEGIN
        SET IDENTITY_INSERT [Payroll].[tmp_ms_xx_Payslip] ON;
        INSERT INTO [Payroll].[tmp_ms_xx_Payslip] ([Id], [PayslipNumber], [StartDate], [EndDate], [PaymentDate], [IdContract], [IdEmployee], [IsDeleted], [TransactionUserId], [Deleted_Token])
        SELECT   [Id],
                 [PayslipNumber],
                 [StartDate],
                 [EndDate],
                 [PaymentDate],
                 [IdContract],
                 [IdEmployee],
                 [IsDeleted],
                 [TransactionUserId],
                 [Deleted_Token]
        FROM     [Payroll].[Payslip]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [Payroll].[tmp_ms_xx_Payslip] OFF;
    END

DROP TABLE [Payroll].[Payslip];

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_Payslip]', N'Payslip';

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_constraint_PK_Payslip1]', N'PK_Payslip', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Début de la régénération de la table [Payroll].[PayslipDetails]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [Payroll].[tmp_ms_xx_PayslipDetails] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Rule]              NVARCHAR (255) NOT NULL,
    [SalaryValue]       FLOAT (53)     NOT NULL,
    [EmployerValue]     FLOAT (53)     NOT NULL,
    [Order]             INT            NOT NULL,
    [AppearsOnPaySlip]  BIT            NOT NULL,
    [IdPayslip]         INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_PayslipDetails1] PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [Payroll].[PayslipDetails])
    BEGIN
        SET IDENTITY_INSERT [Payroll].[tmp_ms_xx_PayslipDetails] ON;
        INSERT INTO [Payroll].[tmp_ms_xx_PayslipDetails] ([Id], [Rule], [SalaryValue], [EmployerValue], [Order], [IdPayslip], [IsDeleted], [TransactionUserId], [Deleted_Token])
        SELECT   [Id],
                 [Rule],
                 [SalaryValue],
                 [EmployerValue],
                 [Order],
                 [IdPayslip],
                 [IsDeleted],
                 [TransactionUserId],
                 [Deleted_Token]
        FROM     [Payroll].[PayslipDetails]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [Payroll].[tmp_ms_xx_PayslipDetails] OFF;
    END

DROP TABLE [Payroll].[PayslipDetails];

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_PayslipDetails]', N'PayslipDetails';

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_constraint_PK_PayslipDetails1]', N'PK_PayslipDetails', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
ALTER TABLE [Payroll].[Payslip] WITH NOCHECK
    ADD CONSTRAINT [FK_Payslip_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]);

GO
ALTER TABLE [Payroll].[Payslip] WITH NOCHECK
    ADD CONSTRAINT [FK_Payslip_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]);


GO
ALTER TABLE [Payroll].[PayslipDetails] WITH NOCHECK
    ADD CONSTRAINT [FK_PayslipDetails_Payslip] FOREIGN KEY ([IdPayslip]) REFERENCES [Payroll].[Payslip] ([Id]);


GO
ALTER TABLE [Payroll].[Payslip] WITH CHECK CHECK CONSTRAINT [FK_Payslip_Contract];

ALTER TABLE [Payroll].[Payslip] WITH CHECK CHECK CONSTRAINT [FK_Payslip_Employee];

ALTER TABLE [Payroll].[PayslipDetails] WITH CHECK CHECK CONSTRAINT [FK_PayslipDetails_Payslip];


GO
PRINT N'Mise à jour terminée.';

----Marwa: delete PaymentDate ---
GO
ALTER TABLE [Payroll].[Payslip] DROP COLUMN [PaymentDate];

GO

---- Nihel: table Employee, field Matricule from int to string
ALTER TABLE Payroll.Employee
DROP CONSTRAINT UniqueKeyMatricule;

ALTER TABLE Payroll.Employee
ALTER COLUMN Matricule nvarchar(10);

ALTER TABLE Payroll.Employee
ADD CONSTRAINT UniqueKeyMatricule UNIQUE(Matricule, Deleted_Token)

--Mohamed BOUZIDI Premium management




GO
PRINT N'Creating [Payroll].[Contract_Premium]...';


GO
CREATE TABLE [Payroll].[Contract_Premium] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdPremium]         INT            NOT NULL,
    [IdContract]        INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Contract_Premium] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[PaySlip_Premium]...';


GO
CREATE TABLE [Payroll].[PaySlip_Premium] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdPremium]         INT            NOT NULL,
    [IdPaySlip]         INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_PaySlip_Premium] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[Premium]...';


GO
CREATE TABLE [Payroll].[Premium] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Code]              NVARCHAR (50)  NOT NULL,
    [Name]              NVARCHAR (255) NOT NULL,
    [Description]       NVARCHAR (255) NULL,
    [Valeur]            FLOAT (53)     NOT NULL,
    [IsFixe]            BIT            NOT NULL,
    [IsContributory]    BIT            NOT NULL,
    [IsTaxable]         BIT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Premium] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[FK_Contract_Premium_Premium]...';


GO
ALTER TABLE [Payroll].[Contract_Premium] WITH NOCHECK
    ADD CONSTRAINT [FK_Contract_Premium_Premium] FOREIGN KEY ([IdPremium]) REFERENCES [Payroll].[Premium] ([Id]);


GO
PRINT N'Creating [Payroll].[FK_Contract_Premium_Contract]...';


GO
ALTER TABLE [Payroll].[Contract_Premium] WITH NOCHECK
    ADD CONSTRAINT [FK_Contract_Premium_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]);


GO
PRINT N'Creating [Payroll].[FK_PaySlip_Premium_Premium]...';


GO
ALTER TABLE [Payroll].[PaySlip_Premium] WITH NOCHECK
    ADD CONSTRAINT [FK_PaySlip_Premium_Premium] FOREIGN KEY ([IdPremium]) REFERENCES [Payroll].[Premium] ([Id]);


GO
PRINT N'Creating [Payroll].[FK_PaySlip_Premium_Payslip]...';


GO
ALTER TABLE [Payroll].[PaySlip_Premium] WITH NOCHECK
    ADD CONSTRAINT [FK_PaySlip_Premium_Payslip] FOREIGN KEY ([IdPaySlip]) REFERENCES [Payroll].[Payslip] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';



GO
ALTER TABLE [Payroll].[Contract_Premium] WITH CHECK CHECK CONSTRAINT [FK_Contract_Premium_Premium];

ALTER TABLE [Payroll].[Contract_Premium] WITH CHECK CHECK CONSTRAINT [FK_Contract_Premium_Contract];

ALTER TABLE [Payroll].[PaySlip_Premium] WITH CHECK CHECK CONSTRAINT [FK_PaySlip_Premium_Premium];

ALTER TABLE [Payroll].[PaySlip_Premium] WITH CHECK CHECK CONSTRAINT [FK_PaySlip_Premium_Payslip];


GO
PRINT N'Update complete.';

GO
ALTER TABLE [Immobilisation].[Active]
    ADD [Description] NVARCHAR (500) NULL,
        [IdWarehouse] INT            NULL;

		GO
ALTER TABLE [Immobilisation].[Active] WITH NOCHECK
    ADD CONSTRAINT [FK_Active_Warehouse] FOREIGN KEY ([IdWarehouse]) REFERENCES [Inventory].[Warehouse] ([Id]);


---- Nihel: add relation: information iformation parent
GO
PRINT N'Altering [ERPSettings].[Information]...';


GO
ALTER TABLE [ERPSettings].[Information]
    ADD [IdInfoParent] INT NULL;


GO
PRINT N'Creating [ERPSettings].[FK_Information_Information]...';


GO
ALTER TABLE [ERPSettings].[Information] WITH NOCHECK
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
ALTER TABLE [ERPSettings].[Information] WITH CHECK CHECK CONSTRAINT [FK_Information_Information];




--- Marwa : Reporting paie ----

GO
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_MaritalStatus];



GO
ALTER TABLE [Payroll].[Employee] DROP COLUMN [IdMaritalStatus];


GO
ALTER TABLE [Payroll].[Employee]
    ADD [HiringDate]   DATE          NULL,
        [Category]     NVARCHAR (50) NULL,
        [CIN]          NVARCHAR (50) NULL,
        [FamilyLeader] BIT           NULL;



GO
ALTER TABLE [Payroll].[Payslip]
    ADD [NumberDaysWorked]     INT NULL,
        [NumberDaysLeaveTaken] INT NULL;



GO
ALTER TABLE [Shared].[Company]
    ADD [CnssAffiliation] NVARCHAR (50) NULL;


GO

--Mohamed BOUZIDI Premium list in Contract and PaySlip

GO
PRINT N'Dropping [Payroll].[FK_Contract_Premium_Contract]...';


GO
ALTER TABLE [Payroll].[Contract_Premium] DROP CONSTRAINT [FK_Contract_Premium_Contract];


GO
PRINT N'Dropping [Payroll].[FK_Contract_Premium_Premium]...';


GO
ALTER TABLE [Payroll].[Contract_Premium] DROP CONSTRAINT [FK_Contract_Premium_Premium];


GO
PRINT N'Dropping [Payroll].[FK_PaySlip_Premium_Payslip]...';


GO
ALTER TABLE [Payroll].[PaySlip_Premium] DROP CONSTRAINT [FK_PaySlip_Premium_Payslip];


GO
PRINT N'Dropping [Payroll].[FK_PaySlip_Premium_Premium]...';


GO
ALTER TABLE [Payroll].[PaySlip_Premium] DROP CONSTRAINT [FK_PaySlip_Premium_Premium];


GO
PRINT N'Creating [Payroll].[FK_Contract_Premium_Contract]...';


GO
ALTER TABLE [Payroll].[Contract_Premium] WITH NOCHECK
    ADD CONSTRAINT [FK_Contract_Premium_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating [Payroll].[FK_Contract_Premium_Premium]...';


GO
ALTER TABLE [Payroll].[Contract_Premium] WITH NOCHECK
    ADD CONSTRAINT [FK_Contract_Premium_Premium] FOREIGN KEY ([IdPremium]) REFERENCES [Payroll].[Premium] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating [Payroll].[FK_PaySlip_Premium_Payslip]...';


GO
ALTER TABLE [Payroll].[PaySlip_Premium] WITH NOCHECK
    ADD CONSTRAINT [FK_PaySlip_Premium_Payslip] FOREIGN KEY ([IdPaySlip]) REFERENCES [Payroll].[Payslip] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating [Payroll].[FK_PaySlip_Premium_Premium]...';


GO
ALTER TABLE [Payroll].[PaySlip_Premium] WITH NOCHECK
    ADD CONSTRAINT [FK_PaySlip_Premium_Premium] FOREIGN KEY ([IdPremium]) REFERENCES [Payroll].[Premium] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Checking existing data against newly created constraints';

GO
ALTER TABLE [Payroll].[Contract_Premium] WITH CHECK CHECK CONSTRAINT [FK_Contract_Premium_Contract];

ALTER TABLE [Payroll].[Contract_Premium] WITH CHECK CHECK CONSTRAINT [FK_Contract_Premium_Premium];

ALTER TABLE [Payroll].[PaySlip_Premium] WITH CHECK CHECK CONSTRAINT [FK_PaySlip_Premium_Payslip];

ALTER TABLE [Payroll].[PaySlip_Premium] WITH CHECK CHECK CONSTRAINT [FK_PaySlip_Premium_Premium];


GO
PRINT N'Update complete.';


GO
GO


-- Narcisse : Add Column [AppearsOnPaySlip] in PayslipDetails table


GO
PRINT N'Suppression de [Payroll].[FK_PayslipDetails_Payslip]...';


GO
ALTER TABLE [Payroll].[PayslipDetails] DROP CONSTRAINT [FK_PayslipDetails_Payslip];


GO
PRINT N'Début de la régénération de la table [Payroll].[PayslipDetails]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [Payroll].[tmp_ms_xx_PayslipDetails] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Rule]              NVARCHAR (255) NOT NULL,
    [SalaryValue]       FLOAT (53)     NOT NULL,
    [EmployerValue]     FLOAT (53)     NOT NULL,
    [Order]             INT            NOT NULL,
    [AppearsOnPaySlip]  BIT            NOT NULL,
    [IdPayslip]         INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_PayslipDetails1] PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [Payroll].[PayslipDetails])
    BEGIN
        SET IDENTITY_INSERT [Payroll].[tmp_ms_xx_PayslipDetails] ON;
        INSERT INTO [Payroll].[tmp_ms_xx_PayslipDetails] ([Id], [Rule], [SalaryValue], [EmployerValue], [Order], [IdPayslip], [IsDeleted], [TransactionUserId], [Deleted_Token])
        SELECT   [Id],
                 [Rule],
                 [SalaryValue],
                 [EmployerValue],
                 [Order],
                 [IdPayslip],
                 [IsDeleted],
                 [TransactionUserId],
                 [Deleted_Token]
        FROM     [Payroll].[PayslipDetails]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [Payroll].[tmp_ms_xx_PayslipDetails] OFF;
    END

DROP TABLE [Payroll].[PayslipDetails];

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_PayslipDetails]', N'PayslipDetails';

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_constraint_PK_PayslipDetails1]', N'PK_PayslipDetails', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Création de [Payroll].[FK_PayslipDetails_Payslip]...';


GO
ALTER TABLE [Payroll].[PayslipDetails] WITH NOCHECK
    ADD CONSTRAINT [FK_PayslipDetails_Payslip] FOREIGN KEY ([IdPayslip]) REFERENCES [Payroll].[Payslip] ([Id]);


GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';


GO
ALTER TABLE [Payroll].[PayslipDetails] WITH CHECK CHECK CONSTRAINT [FK_PayslipDetails_Payslip];


GO
PRINT N'Mise à jour terminée.';


GO

-- Narcissee Payroll new strategy

GO
/*
La colonne [Payroll].[PayslipDetails].[SalaryValue] est en cours de suppression, des données risquent d'être perdues.

La colonne [Payroll].[PayslipDetails].[Deduction] de la table [Payroll].[PayslipDetails] doit être ajoutée mais la colonne ne comporte pas de valeur par défaut et n'autorise pas les valeurs NULL. Si la table contient des données, le script ALTER ne fonctionnera pas. Pour éviter ce problème, vous devez ajouter une valeur par défaut à la colonne, la marquer comme autorisant les valeurs Null ou activer la génération de smart-defaults en tant qu'option de déploiement.

La colonne [Payroll].[PayslipDetails].[Gain] de la table [Payroll].[PayslipDetails] doit être ajoutée mais la colonne ne comporte pas de valeur par défaut et n'autorise pas les valeurs NULL. Si la table contient des données, le script ALTER ne fonctionnera pas. Pour éviter ce problème, vous devez ajouter une valeur par défaut à la colonne, la marquer comme autorisant les valeurs Null ou activer la génération de smart-defaults en tant qu'option de déploiement.
*/

IF EXISTS (select top 1 1 from [Payroll].[PayslipDetails])
    RAISERROR (N'Lignes détectées. Arrêt de la mise à jour du schéma en raison d''''un risque de perte de données.', 16, 127) WITH NOWAIT

GO
PRINT N'Suppression de [Payroll].[FK_PayslipDetails_Payslip]...';


GO
ALTER TABLE [Payroll].[PayslipDetails] DROP CONSTRAINT [FK_PayslipDetails_Payslip];


GO
PRINT N'Début de la régénération de la table [Payroll].[PayslipDetails]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [Payroll].[tmp_ms_xx_PayslipDetails] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Rule]              NVARCHAR (255) NOT NULL,
    [Gain]              FLOAT (53)     NOT NULL,
    [Deduction]         FLOAT (53)     NOT NULL,
    [EmployerValue]     FLOAT (53)     NOT NULL,
    [Order]             INT            NOT NULL,
    [AppearsOnPaySlip]  BIT            NOT NULL,
    [IdPayslip]         INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_PayslipDetails1] PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [Payroll].[PayslipDetails])
    BEGIN
        SET IDENTITY_INSERT [Payroll].[tmp_ms_xx_PayslipDetails] ON;
        INSERT INTO [Payroll].[tmp_ms_xx_PayslipDetails] ([Id], [Rule], [EmployerValue], [Order], [AppearsOnPaySlip], [IdPayslip], [IsDeleted], [TransactionUserId], [Deleted_Token])
        SELECT   [Id],
                 [Rule],
                 [EmployerValue],
                 [Order],
                 [AppearsOnPaySlip],
                 [IdPayslip],
                 [IsDeleted],
                 [TransactionUserId],
                 [Deleted_Token]
        FROM     [Payroll].[PayslipDetails]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [Payroll].[tmp_ms_xx_PayslipDetails] OFF;
    END

DROP TABLE [Payroll].[PayslipDetails];

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_PayslipDetails]', N'PayslipDetails';

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_constraint_PK_PayslipDetails1]', N'PK_PayslipDetails', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Création de [Payroll].[FK_PayslipDetails_Payslip]...';


GO
ALTER TABLE [Payroll].[PayslipDetails] WITH NOCHECK
    ADD CONSTRAINT [FK_PayslipDetails_Payslip] FOREIGN KEY ([IdPayslip]) REFERENCES [Payroll].[Payslip] ([Id]);


GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';

GO
ALTER TABLE [Payroll].[PayslipDetails] WITH CHECK CHECK CONSTRAINT [FK_PayslipDetails_Payslip];


GO
PRINT N'Mise à jour terminée.';


GO



---- Marwa Modification reporting paie -----

GO
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Echellon];



GO
ALTER TABLE [Payroll].[Contract] ALTER COLUMN [WorkingTime] FLOAT (53) NULL;




GO
ALTER TABLE [Payroll].[Employee] ALTER COLUMN [IdEchellon] INT NULL;




GO
ALTER TABLE [Payroll].[Payslip] ALTER COLUMN [PayslipNumber] NVARCHAR (255) NULL;




GO
ALTER TABLE [Payroll].[Employee] WITH NOCHECK
    ADD CONSTRAINT [FK_Employee_Echellon] FOREIGN KEY ([IdEchellon]) REFERENCES [Payroll].[Echellon] ([Id]);



--GO
--ALTER TABLE [Payroll].[Employee] WITH CHECK CHECK CONSTRAINT [FK_Employee_Echellon];


-- Narcisse Payslip with nombre de jours

GO
ALTER TABLE [Payroll].[Payslip] ALTER COLUMN [NumberDaysLeaveTaken] FLOAT (53) NOT NULL;

ALTER TABLE [Payroll].[Payslip] ALTER COLUMN [NumberDaysWorked] FLOAT (53) NOT NULL;

ALTER TABLE [Payroll].[PayslipDetails] ADD [NumberOfDays] FLOAT (53)  NOT NULL

ALTER TABLE [Payroll].[SalaryRule] ADD [DependNumberDaysWorked] BIT NOT NULL;

GO
PRINT N'Creating [Payroll].[DF_SalaryRule_DependNumberDaysWorked]...';


GO
ALTER TABLE [Payroll].[SalaryRule]
    ADD CONSTRAINT [DF_SalaryRule_DependNumberDaysWorked] DEFAULT ((0)) FOR [DependNumberDaysWorked];


GO
PRINT N'Mise à jour terminée.';

GO

---- Marwa delete Echelon Table -----

GO
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Echellon];


GO
DROP TABLE [Payroll].[Echellon];

GO
ALTER TABLE [Payroll].[Employee] DROP COLUMN IdEchellon;

GO
ALTER TABLE [Payroll].[Employee] ADD [Echelon]  INT NULL;

GO

---- Nihel : Add IdValidator to document table
GO
PRINT N'Altering [Sales].[Document]...';


GO
ALTER TABLE [Sales].[Document]
    ADD [IdValidator] INT NULL;

--Mohamed BOUZIDI Correct bug 5686 set value of Premium


IF EXISTS (select top 1 1 from [Payroll].[Premium])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Dropping [Payroll].[FK_Contract_Premium_Contract]...';


GO
ALTER TABLE [Payroll].[Contract_Premium] DROP CONSTRAINT [FK_Contract_Premium_Contract];


GO
PRINT N'Dropping [Payroll].[FK_Contract_Premium_Premium]...';


GO
ALTER TABLE [Payroll].[Contract_Premium] DROP CONSTRAINT [FK_Contract_Premium_Premium];


GO
PRINT N'Dropping [Payroll].[FK_PaySlip_Premium_Payslip]...';


GO
ALTER TABLE [Payroll].[PaySlip_Premium] DROP CONSTRAINT [FK_PaySlip_Premium_Payslip];


GO
PRINT N'Dropping [Payroll].[FK_PaySlip_Premium_Premium]...';


GO
ALTER TABLE [Payroll].[PaySlip_Premium] DROP CONSTRAINT [FK_PaySlip_Premium_Premium];


GO
PRINT N'Starting rebuilding table [Payroll].[Contract_Premium]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [Payroll].[tmp_ms_xx_Contract_Premium] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdPremium]         INT            NOT NULL,
    [IdContract]        INT            NOT NULL,
    [Value]             FLOAT (53)     NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Contract_Premium1] PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [Payroll].[Contract_Premium])
    BEGIN
        SET IDENTITY_INSERT [Payroll].[tmp_ms_xx_Contract_Premium] ON;
        INSERT INTO [Payroll].[tmp_ms_xx_Contract_Premium] ([Id], [IdPremium], [IdContract], [IsDeleted], [TransactionUserId], [Deleted_Token])
        SELECT   [Id],
                 [IdPremium],
                 [IdContract],
                 [IsDeleted],
                 [TransactionUserId],
                 [Deleted_Token]
        FROM     [Payroll].[Contract_Premium]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [Payroll].[tmp_ms_xx_Contract_Premium] OFF;
    END

DROP TABLE [Payroll].[Contract_Premium];

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_Contract_Premium]', N'Contract_Premium';

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_constraint_PK_Contract_Premium1]', N'PK_Contract_Premium', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Starting rebuilding table [Payroll].[PaySlip_Premium]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [Payroll].[tmp_ms_xx_PaySlip_Premium] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdPremium]         INT            NOT NULL,
    [IdPaySlip]         INT            NOT NULL,
    [Value]             FLOAT (53)     NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_PaySlip_Premium1] PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [Payroll].[PaySlip_Premium])
    BEGIN
        SET IDENTITY_INSERT [Payroll].[tmp_ms_xx_PaySlip_Premium] ON;
        INSERT INTO [Payroll].[tmp_ms_xx_PaySlip_Premium] ([Id], [IdPremium], [IdPaySlip], [IsDeleted], [TransactionUserId], [Deleted_Token])
        SELECT   [Id],
                 [IdPremium],
                 [IdPaySlip],
                 [IsDeleted],
                 [TransactionUserId],
                 [Deleted_Token]
        FROM     [Payroll].[PaySlip_Premium]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [Payroll].[tmp_ms_xx_PaySlip_Premium] OFF;
    END

DROP TABLE [Payroll].[PaySlip_Premium];

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_PaySlip_Premium]', N'PaySlip_Premium';

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_constraint_PK_PaySlip_Premium1]', N'PK_PaySlip_Premium', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Starting rebuilding table [Payroll].[Premium]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [Payroll].[tmp_ms_xx_Premium] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Code]              NVARCHAR (50)  NOT NULL,
    [Name]              NVARCHAR (255) NOT NULL,
    [Description]       NVARCHAR (255) NULL,
    [Value]             FLOAT (53)     NOT NULL,
    [IsFixe]            BIT            NOT NULL,
    [IsContributory]    BIT            NOT NULL,
    [IsTaxable]         BIT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Premium1] PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [Payroll].[Premium])
    BEGIN
        SET IDENTITY_INSERT [Payroll].[tmp_ms_xx_Premium] ON;
        INSERT INTO [Payroll].[tmp_ms_xx_Premium] ([Id], [Code], [Name], [Description], [IsFixe], [IsContributory], [IsTaxable], [IsDeleted], [TransactionUserId], [Deleted_Token])
        SELECT   [Id],
                 [Code],
                 [Name],
                 [Description],
                 [IsFixe],
                 [IsContributory],
                 [IsTaxable],
                 [IsDeleted],
                 [TransactionUserId],
                 [Deleted_Token]
        FROM     [Payroll].[Premium]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [Payroll].[tmp_ms_xx_Premium] OFF;
    END

DROP TABLE [Payroll].[Premium];

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_Premium]', N'Premium';

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_constraint_PK_Premium1]', N'PK_Premium', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating [Payroll].[FK_Contract_Premium_Contract]...';


GO
ALTER TABLE [Payroll].[Contract_Premium] WITH NOCHECK
    ADD CONSTRAINT [FK_Contract_Premium_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating [Payroll].[FK_Contract_Premium_Premium]...';


GO
ALTER TABLE [Payroll].[Contract_Premium] WITH NOCHECK
    ADD CONSTRAINT [FK_Contract_Premium_Premium] FOREIGN KEY ([IdPremium]) REFERENCES [Payroll].[Premium] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating [Payroll].[FK_PaySlip_Premium_Payslip]...';


GO
ALTER TABLE [Payroll].[PaySlip_Premium] WITH NOCHECK
    ADD CONSTRAINT [FK_PaySlip_Premium_Payslip] FOREIGN KEY ([IdPaySlip]) REFERENCES [Payroll].[Payslip] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating [Payroll].[FK_PaySlip_Premium_Premium]...';


GO
ALTER TABLE [Payroll].[PaySlip_Premium] WITH NOCHECK
    ADD CONSTRAINT [FK_PaySlip_Premium_Premium] FOREIGN KEY ([IdPremium]) REFERENCES [Payroll].[Premium] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Checking existing data against newly created constraints';



GO
ALTER TABLE [Payroll].[Contract_Premium] WITH CHECK CHECK CONSTRAINT [FK_Contract_Premium_Contract];

ALTER TABLE [Payroll].[Contract_Premium] WITH CHECK CHECK CONSTRAINT [FK_Contract_Premium_Premium];

ALTER TABLE [Payroll].[PaySlip_Premium] WITH CHECK CHECK CONSTRAINT [FK_PaySlip_Premium_Payslip];

ALTER TABLE [Payroll].[PaySlip_Premium] WITH CHECK CHECK CONSTRAINT [FK_PaySlip_Premium_Premium];


GO
PRINT N'Update complete.';


GO

----
GO
PRINT N'Dropping [Immobilisation].[FK_Active_Category1]...';


GO
ALTER TABLE [Immobilisation].[Active] DROP CONSTRAINT [FK_Active_Category1];


GO
PRINT N'Creating [Immobilisation].[FK_Active_Category1]...';


GO
ALTER TABLE [Immobilisation].[Active] WITH NOCHECK
    ADD CONSTRAINT [FK_Active_Category1] FOREIGN KEY ([IdCategory]) REFERENCES [Immobilisation].[Category] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
ALTER TABLE [Immobilisation].[Active] WITH CHECK CHECK CONSTRAINT [FK_Active_Category1];


GO
PRINT N'Update complete.';


GO