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