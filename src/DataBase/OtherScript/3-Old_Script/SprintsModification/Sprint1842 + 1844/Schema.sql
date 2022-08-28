
-- Narcisse : Add SessionEmployee, Attendance and delete [StatutoryHoliday] and [DayOffHoliday]

GO
PRINT N'Suppression de [Payroll].[DayOffHoliday]...';


GO
DROP TABLE [Payroll].[DayOffHoliday];


GO
PRINT N'Suppression de [Payroll].[StatutoryHoliday]...';


GO
DROP TABLE [Payroll].[StatutoryHoliday];


GO
PRINT N'Modification de [Payroll].[Payslip]...';


GO
ALTER TABLE [Payroll].[Payslip] DROP COLUMN [PayPeriod];


GO
ALTER TABLE [Payroll].[Payslip]
    ADD [IdSession] INT NOT NULL;


GO
PRINT N'Création de [Payroll].[Attendance]...';


GO
CREATE TABLE [Payroll].[Attendance] (
    [Id]                     INT            NOT NULL,
    [IdSession]              INT            NOT NULL,
    [IdEmployee]             INT            NOT NULL,
    [NumberDaysWorked]       FLOAT (53)     NOT NULL,
    [NumberDaysPaidLeave]    FLOAT (53)     NOT NULL,
    [NumberDaysNonPaidLeave] FLOAT (53)     NULL,
    [IsDeleted]              BIT            NOT NULL,
    [TransactionUserId]      INT            NULL,
    [Deleted_Token]          NVARCHAR (255) NULL,
    CONSTRAINT [PK_Attendance] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de [Payroll].[Session]...';


GO
CREATE TABLE [Payroll].[Session] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [SessionNumber]     INT            NOT NULL,
    [Title]             NVARCHAR (125) NOT NULL,
    [CreationDate]      DATE           NOT NULL,
    [Month]             DATE           NOT NULL,
    [StartDate]         DATE           NOT NULL,
    [EndDate]           DATE           NOT NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Session] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de [Payroll].[SessionEmployee]...';


GO
CREATE TABLE [Payroll].[SessionEmployee] (
    [Id]                INT            NOT NULL,
    [IdSession]         INT            NOT NULL,
    [IdEmployee]        INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_SessionEmployee] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
PRINT N'Création de [Payroll].[FK_Attendance_Employee]...';


GO
ALTER TABLE [Payroll].[Attendance] WITH NOCHECK
    ADD CONSTRAINT [FK_Attendance_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]);

GO
PRINT N'Création de [Payroll].[FK_Attendance_Session]...';


GO
ALTER TABLE [Payroll].[Attendance] WITH NOCHECK
    ADD CONSTRAINT [FK_Attendance_Session] FOREIGN KEY ([IdSession]) REFERENCES [Payroll].[Session] ([Id]);

GO
PRINT N'Création de [Payroll].[FK_SessionEmployee_Employee]...';

GO
ALTER TABLE [Payroll].[SessionEmployee] WITH NOCHECK
    ADD CONSTRAINT [FK_SessionEmployee_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]);


GO
PRINT N'Création de [Payroll].[FK_SessionEmployee_Session]...';

GO
ALTER TABLE [Payroll].[SessionEmployee] WITH NOCHECK
    ADD CONSTRAINT [FK_SessionEmployee_Session] FOREIGN KEY ([IdSession]) REFERENCES [Payroll].[Session] ([Id]);


GO
PRINT N'Création de [Payroll].[FK_Payslip_Session]...';

GO
ALTER TABLE [Payroll].[Payslip] WITH NOCHECK
    ADD CONSTRAINT [FK_Payslip_Session] FOREIGN KEY ([IdSession]) REFERENCES [Payroll].[Session] ([Id]);


GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';


GO
ALTER TABLE [Payroll].[Attendance] WITH CHECK CHECK CONSTRAINT [FK_Attendance_Employee];

ALTER TABLE [Payroll].[Attendance] WITH CHECK CHECK CONSTRAINT [FK_Attendance_Session];

ALTER TABLE [Payroll].[SessionEmployee] WITH CHECK CHECK CONSTRAINT [FK_SessionEmployee_Employee];

ALTER TABLE [Payroll].[SessionEmployee] WITH CHECK CHECK CONSTRAINT [FK_SessionEmployee_Session];

ALTER TABLE [Payroll].[Payslip] WITH CHECK CHECK CONSTRAINT [FK_Payslip_Session];

GO
PRINT N'Mise à jour terminée.';


GO

-- Narcisse : Set attendance, sessionemployee primary key identity

GO
PRINT N'Suppression de [Payroll].[FK_Attendance_Employee]...';


GO
ALTER TABLE [Payroll].[Attendance] DROP CONSTRAINT [FK_Attendance_Employee];


GO
PRINT N'Suppression de [Payroll].[FK_Attendance_Session]...';


GO
ALTER TABLE [Payroll].[Attendance] DROP CONSTRAINT [FK_Attendance_Session];


GO
PRINT N'Suppression de [Payroll].[FK_Payslip_Session]...';


GO
ALTER TABLE [Payroll].[Payslip] DROP CONSTRAINT [FK_Payslip_Session];


GO
PRINT N'Suppression de [Payroll].[FK_Payslip_Contract]...';


GO
ALTER TABLE [Payroll].[Payslip] DROP CONSTRAINT [FK_Payslip_Contract];


GO
PRINT N'Suppression de [Payroll].[FK_Payslip_Employee]...';


GO
ALTER TABLE [Payroll].[Payslip] DROP CONSTRAINT [FK_Payslip_Employee];


GO
PRINT N'Suppression de [Payroll].[FK_PayslipDetails_Payslip]...';


GO
ALTER TABLE [Payroll].[PayslipDetails] DROP CONSTRAINT [FK_PayslipDetails_Payslip];


GO
PRINT N'Suppression de [Payroll].[FK_PaySlip_Premium_Payslip]...';


GO
ALTER TABLE [Payroll].[PaySlip_Premium] DROP CONSTRAINT [FK_PaySlip_Premium_Payslip];


GO
PRINT N'Suppression de [Payroll].[FK_SessionEmployee_Session]...';


GO
ALTER TABLE [Payroll].[SessionEmployee] DROP CONSTRAINT [FK_SessionEmployee_Session];


GO
PRINT N'Suppression de [Payroll].[FK_SessionEmployee_Employee]...';


GO
ALTER TABLE [Payroll].[SessionEmployee] DROP CONSTRAINT [FK_SessionEmployee_Employee];


GO
PRINT N'Début de la régénération de la table [Payroll].[Attendance]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [Payroll].[tmp_ms_xx_Attendance] (
    [Id]                     INT            IDENTITY (1, 1) NOT NULL,
    [IdSession]              INT            NOT NULL,
    [IdEmployee]             INT            NOT NULL,
    [NumberDaysWorked]       FLOAT (53)     NOT NULL,
    [NumberDaysPaidLeave]    FLOAT (53)     NOT NULL,
    [NumberDaysNonPaidLeave] FLOAT (53)     NOT NULL,
    [IsDeleted]              BIT            NOT NULL,
    [TransactionUserId]      INT            NULL,
    [Deleted_Token]          NVARCHAR (255) NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Attendance1] PRIMARY KEY CLUSTERED ([Id] ASC)
);

DROP TABLE [Payroll].[Attendance];

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_Attendance]', N'Attendance';

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_constraint_PK_Attendance1]', N'PK_Attendance', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Début de la régénération de la table [Payroll].[Payslip]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [Payroll].[tmp_ms_xx_Payslip] (
    [Id]                          INT            IDENTITY (1, 1) NOT NULL,
    [PayslipNumber]               NVARCHAR (255) NULL,
    [StartDate]                   DATE           NOT NULL,
    [EndDate]                     DATE           NOT NULL,
    [IdContract]                  INT            NOT NULL,
    [IdEmployee]                  INT            NOT NULL,
    [IsDeleted]                   BIT            NOT NULL,
    [TransactionUserId]           INT            NULL,
    [Deleted_Token]               NVARCHAR (255) NULL,
    [NumberDaysWorked]            FLOAT (53)     NOT NULL,
    [NumberDaysLeaveTaken]        FLOAT (53)     NOT NULL,
    [NumberDaysNonPaidLeaveTaken] FLOAT (53)     NOT NULL,
    [IdSession]                   INT            NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Payslip1] PRIMARY KEY CLUSTERED ([Id] ASC)
);

DROP TABLE [Payroll].[Payslip];

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_Payslip]', N'Payslip';

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_constraint_PK_Payslip1]', N'PK_Payslip', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Début de la régénération de la table [Payroll].[Session]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [Payroll].[tmp_ms_xx_Session] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [SessionNumber]     INT            NOT NULL,
    [Title]             NVARCHAR (125) NOT NULL,
    [CreationDate]      DATE           NOT NULL,
    [Month]             DATE           NOT NULL,
    [StartDate]         DATE           NOT NULL,
    [EndDate]           DATE           NOT NULL,
    [State]             INT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Session1] PRIMARY KEY CLUSTERED ([Id] ASC)
);

DROP TABLE [Payroll].[Session];

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_Session]', N'Session';

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_constraint_PK_Session1]', N'PK_Session', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Début de la régénération de la table [Payroll].[SessionEmployee]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [Payroll].[tmp_ms_xx_SessionEmployee] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdSession]         INT            NOT NULL,
    [IdEmployee]        INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_SessionEmployee1] PRIMARY KEY CLUSTERED ([Id] ASC)
);

DROP TABLE [Payroll].[SessionEmployee];

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_SessionEmployee]', N'SessionEmployee';

EXECUTE sp_rename N'[Payroll].[tmp_ms_xx_constraint_PK_SessionEmployee1]', N'PK_SessionEmployee', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Création de [Payroll].[FK_Attendance_Employee]...';


GO
ALTER TABLE [Payroll].[Attendance] WITH NOCHECK
    ADD CONSTRAINT [FK_Attendance_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]);


GO
PRINT N'Création de [Payroll].[FK_Attendance_Session]...';


GO
ALTER TABLE [Payroll].[Attendance] WITH NOCHECK
    ADD CONSTRAINT [FK_Attendance_Session] FOREIGN KEY ([IdSession]) REFERENCES [Payroll].[Session] ([Id]);


GO
PRINT N'Création de [Payroll].[FK_Payslip_Session]...';


GO
ALTER TABLE [Payroll].[Payslip] WITH NOCHECK
    ADD CONSTRAINT [FK_Payslip_Session] FOREIGN KEY ([IdSession]) REFERENCES [Payroll].[Session] ([Id]);


GO
PRINT N'Création de [Payroll].[FK_Payslip_Contract]...';


GO
ALTER TABLE [Payroll].[Payslip] WITH NOCHECK
    ADD CONSTRAINT [FK_Payslip_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]);


GO
PRINT N'Création de [Payroll].[FK_Payslip_Employee]...';


GO
ALTER TABLE [Payroll].[Payslip] WITH NOCHECK
    ADD CONSTRAINT [FK_Payslip_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]);


GO
PRINT N'Création de [Payroll].[FK_PayslipDetails_Payslip]...';


GO
ALTER TABLE [Payroll].[PayslipDetails] WITH NOCHECK
    ADD CONSTRAINT [FK_PayslipDetails_Payslip] FOREIGN KEY ([IdPayslip]) REFERENCES [Payroll].[Payslip] ([Id]);


GO
PRINT N'Création de [Payroll].[FK_PaySlip_Premium_Payslip]...';


GO
ALTER TABLE [Payroll].[PaySlip_Premium] WITH NOCHECK
    ADD CONSTRAINT [FK_PaySlip_Premium_Payslip] FOREIGN KEY ([IdPaySlip]) REFERENCES [Payroll].[Payslip] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Création de [Payroll].[FK_SessionEmployee_Session]...';


GO
ALTER TABLE [Payroll].[SessionEmployee] WITH NOCHECK
    ADD CONSTRAINT [FK_SessionEmployee_Session] FOREIGN KEY ([IdSession]) REFERENCES [Payroll].[Session] ([Id]);


GO
PRINT N'Création de [Payroll].[FK_SessionEmployee_Employee]...';


GO
ALTER TABLE [Payroll].[SessionEmployee] WITH NOCHECK
    ADD CONSTRAINT [FK_SessionEmployee_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]);


GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';


GO
ALTER TABLE [Payroll].[Attendance] WITH CHECK CHECK CONSTRAINT [FK_Attendance_Employee];

ALTER TABLE [Payroll].[Attendance] WITH CHECK CHECK CONSTRAINT [FK_Attendance_Session];

ALTER TABLE [Payroll].[Payslip] WITH CHECK CHECK CONSTRAINT [FK_Payslip_Session];

ALTER TABLE [Payroll].[Payslip] WITH CHECK CHECK CONSTRAINT [FK_Payslip_Contract];

ALTER TABLE [Payroll].[Payslip] WITH CHECK CHECK CONSTRAINT [FK_Payslip_Employee];

ALTER TABLE [Payroll].[PayslipDetails] WITH CHECK CHECK CONSTRAINT [FK_PayslipDetails_Payslip];

ALTER TABLE [Payroll].[PaySlip_Premium] WITH CHECK CHECK CONSTRAINT [FK_PaySlip_Premium_Payslip];

ALTER TABLE [Payroll].[SessionEmployee] WITH CHECK CHECK CONSTRAINT [FK_SessionEmployee_Session];

ALTER TABLE [Payroll].[SessionEmployee] WITH CHECK CHECK CONSTRAINT [FK_SessionEmployee_Employee];


GO
PRINT N'Mise à jour terminée.';


GO

-- Imen add isactive column to employee table

ALTER TABLE [Payroll].[Employee]
    ADD [IsActive] BIT NOT NULL DEFAULT ('1');
	


GO
PRINT N'Mise à jour terminée.';


GO
-- Mohamed BOUZIDI Required fields

GO
/*
The column HiringDate on table [Payroll].[Employee] must be changed from NULL to NOT NULL. If the table contains data, the ALTER script may not work. To avoid this issue, you must add values to this column for all rows or mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/

IF EXISTS (select top 1 1 from [Payroll].[Employee])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Dropping [Payroll].[GraduationYear_Constraint]...';


GO
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [GraduationYear_Constraint];


GO
PRINT N'Dropping unnamed constraint on [Payroll].[Employee]...';


GO
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [DF__Employee__IsActi__5C8CB268];


GO
PRINT N'Dropping [Payroll].[FK_Employee_QualificationCountry]...';


GO
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_QualificationCountry];


GO
PRINT N'Dropping [Payroll].[FK_Employee_QualificationType]...';


GO
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_QualificationType];


GO
PRINT N'Altering [Payroll].[Employee]...';


GO
ALTER TABLE [Payroll].[Employee] ALTER COLUMN [GraduationYear] INT NULL;

ALTER TABLE [Payroll].[Employee] ALTER COLUMN [HiringDate] DATE NOT NULL;

ALTER TABLE [Payroll].[Employee] ALTER COLUMN [IdQualificationCountry] INT NULL;

ALTER TABLE [Payroll].[Employee] ALTER COLUMN [IdQualificationType] INT NULL;

ALTER TABLE [Payroll].[Employee] ALTER COLUMN [University] NVARCHAR (100) NULL;


GO
PRINT N'Creating [Payroll].[DF__Employee__IsActi__5C8CB268]...';


GO
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [DF__Employee__IsActi__5C8CB268] DEFAULT ('1') FOR [IsActive];


GO
PRINT N'Creating [Payroll].[FK_Employee_QualificationCountry]...';


GO
ALTER TABLE [Payroll].[Employee] WITH NOCHECK
    ADD CONSTRAINT [FK_Employee_QualificationCountry] FOREIGN KEY ([IdQualificationCountry]) REFERENCES [Shared].[Country] ([Id]);


GO
PRINT N'Creating [Payroll].[FK_Employee_QualificationType]...';


GO
ALTER TABLE [Payroll].[Employee] WITH NOCHECK
    ADD CONSTRAINT [FK_Employee_QualificationType] FOREIGN KEY ([IdQualificationType]) REFERENCES [Payroll].[QualificationType] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
ALTER TABLE [Payroll].[Employee] WITH CHECK CHECK CONSTRAINT [FK_Employee_QualificationCountry];

ALTER TABLE [Payroll].[Employee] WITH CHECK CHECK CONSTRAINT [FK_Employee_QualificationType];


GO
PRINT N'Update complete.';


GO

-- Narcisse : Delete Employee foreign key in Attendance end make a new key with the contract.


GO
ALTER TABLE [Payroll].[Attendance] DROP CONSTRAINT [FK_Attendance_Employee];


GO
PRINT N'Suppression de [Payroll].[FK_Attendance_Session]...';


GO
ALTER TABLE [Payroll].[Attendance] DROP CONSTRAINT [FK_Attendance_Session];


GO
PRINT N'Début de la régénération de la table [Payroll].[Attendance]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

DROP TABLE [Payroll].[Attendance];

CREATE TABLE [Payroll].[Attendance] (
    [Id]                     INT            IDENTITY (1, 1) NOT NULL,
    [IdSession]              INT            NOT NULL,
    [IdContract]             INT            NOT NULL,
    [NumberDaysWorked]       FLOAT (53)     NOT NULL,
    [NumberDaysPaidLeave]    FLOAT (53)     NOT NULL,
    [NumberDaysNonPaidLeave] FLOAT (53)     NOT NULL,
    [IsDeleted]              BIT            NOT NULL,
    [TransactionUserId]      INT            NULL,
    [Deleted_Token]          NVARCHAR (255) NULL,
    CONSTRAINT [PK_Attendance] PRIMARY KEY CLUSTERED ([Id] ASC)
);

COMMIT TRANSACTION;

GO
PRINT N'Création de [Payroll].[FK_Attendance_Session]...';

GO
ALTER TABLE [Payroll].[Attendance] WITH NOCHECK
    ADD CONSTRAINT [FK_Attendance_Session] FOREIGN KEY ([IdSession]) REFERENCES [Payroll].[Session] ([Id]);

GO
PRINT N'Création de [Payroll].[FK_Attendance_Contract]...';

GO
ALTER TABLE [Payroll].[Attendance] WITH NOCHECK
    ADD CONSTRAINT [FK_Attendance_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]);

GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';

GO
ALTER TABLE [Payroll].[Attendance] WITH CHECK CHECK CONSTRAINT [FK_Attendance_Session];

ALTER TABLE [Payroll].[Attendance] WITH CHECK CHECK CONSTRAINT [FK_Attendance_Contract];

GO
PRINT N'Mise à jour terminée.';

GO

-- Narcisse : All remunerations with period

GO
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_PlannedPayroll];
ALTER TABLE [Payroll].[Contract] DROP COLUMN [BaseSalary];
ALTER TABLE [Payroll].[Contract] DROP COLUMN [IdPlannedPayroll];
GO
CREATE TABLE [Payroll].[BaseSalary] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdContract]        INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_BaseSalary] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO
ALTER TABLE [Payroll].[Contract] ADD [IdBaseSalary] INT NULL;
ALTER TABLE [Payroll].[Contract] ADD CONSTRAINT [FK_Contract_BaseSalary] FOREIGN KEY ([IdBaseSalary]) REFERENCES [Payroll].[BaseSalary] ([Id]); 
ALTER TABLE [Payroll].[BaseSalary] ADD CONSTRAINT [FK_BaseSalary_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]) ON DELETE CASCADE;
DELETE [Payroll].[PlannedPayroll];
DROP TABLE [Payroll].[PlannedPayroll];
ALTER TABLE [Payroll].[Contract_Premium] DROP COLUMN [Value];
ALTER TABLE [Payroll].[PayslipDetails] ADD [IdSalaryRule] INT NULL;
ALTER TABLE [Payroll].[PayslipDetails] ADD CONSTRAINT [FK_PayslipDetails_SalaryRule] FOREIGN KEY ([IdSalaryRule]) REFERENCES [Payroll].[SalaryRule] ([Id]);
CREATE TABLE [Payroll].[BaseSalaryValidityPeriod] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Value]             FLOAT (53)     NOT NULL,
    [StartDate]         DATE           NOT NULL,
    [IdBaseSalary]      INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_BaseSalaryValidityPeriod] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_BaseSalaryValidityPeriod_BaseSalary] FOREIGN KEY ([IdBaseSalary]) REFERENCES [Payroll].[BaseSalary] ([Id])
);
GO
ALTER TABLE [Payroll].[Premium] DROP COLUMN [Value];
ALTER TABLE [Payroll].[SalaryRule] ADD [UsedinNewsPaper] BIT NULL;
GO
ALTER TABLE [Shared].[Company] ALTER COLUMN [IdDaysOfWork] FLOAT (53) NOT NULL;
CREATE TABLE [Payroll].[Contract_PremiumValidityPeriod] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Value]             FLOAT (53)     NOT NULL,
    [StartDate]         DATE           NOT NULL,
    [IdContractPremium] INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Contract_PremiumValidityPeriod] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Contract_PremiumValidityPeriod_Contract_Premium] FOREIGN KEY ([IdContractPremium]) REFERENCES [Payroll].[Contract_Premium] ([Id])
);
GO

GO
ALTER TABLE [Payroll].[BaseSalaryValidityPeriod] DROP CONSTRAINT [FK_BaseSalaryValidityPeriod_BaseSalary];
GO
DROP TABLE [Payroll].[BaseSalaryValidityPeriod];
ALTER TABLE [Payroll].[BaseSalary] ADD [Value] FLOAT (53) NOT NULL;
ALTER TABLE [Payroll].[BaseSalary] ADD [StartDate] DATE NOT NULL;
GO
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_BaseSalary];
GO
ALTER TABLE [Payroll].[Contract] DROP COLUMN [IdBaseSalary];

-- Narcisse : Change all premium terme with bonus 

GO
PRINT N'Suppression de [Payroll].[FK_Contract_PremiumValidityPeriod_Contract_Premium]...';


GO
ALTER TABLE [Payroll].[Contract_PremiumValidityPeriod] DROP CONSTRAINT [FK_Contract_PremiumValidityPeriod_Contract_Premium];


GO
PRINT N'Suppression de [Payroll].[FK_Contract_Premium_Premium]...';


GO
ALTER TABLE [Payroll].[Contract_Premium] DROP CONSTRAINT [FK_Contract_Premium_Premium];


GO
PRINT N'Suppression de [Payroll].[FK_PaySlip_Premium_Premium]...';


GO
ALTER TABLE [Payroll].[PaySlip_Premium] DROP CONSTRAINT [FK_PaySlip_Premium_Premium];


GO
PRINT N'Suppression de [Payroll].[FK_Contract_Premium_Contract]...';


GO
ALTER TABLE [Payroll].[Contract_Premium] DROP CONSTRAINT [FK_Contract_Premium_Contract];


GO
PRINT N'Suppression de [Payroll].[FK_PaySlip_Premium_Payslip]...';

GO
ALTER TABLE [Payroll].[PaySlip_Premium] DROP CONSTRAINT [FK_PaySlip_Premium_Payslip];

GO
PRINT N'Suppression de [Payroll].[FK_SalaryStructureRule_Rule]...';

GO
ALTER TABLE [Payroll].[SalaryStructure_SalaryRule] DROP CONSTRAINT [FK_SalaryStructureRule_Rule];

GO
PRINT N'Suppression de [Payroll].[FK_SalaryStructureRule_Structure]...';

GO
ALTER TABLE [Payroll].[SalaryStructure_SalaryRule] DROP CONSTRAINT [FK_SalaryStructureRule_Structure];

GO
PRINT N'Suppression de [Payroll].[Contract_Premium]...';

GO
DROP TABLE [Payroll].[Contract_Premium];

GO
PRINT N'Suppression de [Payroll].[Contract_PremiumValidityPeriod]...';

GO
DROP TABLE [Payroll].[Contract_PremiumValidityPeriod];

GO
PRINT N'Suppression de [Payroll].[PaySlip_Premium]...';

GO
DROP TABLE [Payroll].[PaySlip_Premium];

GO
PRINT N'Suppression de [Payroll].[Premium]...';

GO
DROP TABLE [Payroll].[Premium];

GO
PRINT N'Suppression de [Payroll].[SalaryStructure_SalaryRule]...';

GO
DROP TABLE [Payroll].[SalaryStructure_SalaryRule];

GO
PRINT N'Création de [Payroll].[Bonus]...';

GO
CREATE TABLE [Payroll].[Bonus] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Code]              NVARCHAR (50)  NOT NULL,
    [Name]              NVARCHAR (255) NOT NULL,
    [Description]       NVARCHAR (255) NULL,
    [IsFixe]            BIT            NOT NULL,
    [IsContributory]    BIT            NOT NULL,
    [IsTaxable]         BIT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Premium] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
PRINT N'Création de [Payroll].[ContractBonus]...';

GO
CREATE TABLE [Payroll].[ContractBonus] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdBonus]           INT            NOT NULL,
    [IdContract]        INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Contract_Premium] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
PRINT N'Création de [Payroll].[ContractBonusValidityPeriod]...';

GO
CREATE TABLE [Payroll].[ContractBonusValidityPeriod] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Value]             FLOAT (53)     NOT NULL,
    [StartDate]         DATE           NOT NULL,
    [IdContractBonus]   INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Contract_PremiumValidityPeriod] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
PRINT N'Création de [Payroll].[SalaryStructureSalaryRule]...';

GO
CREATE TABLE [Payroll].[SalaryStructureSalaryRule] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdStructure]       INT            NOT NULL,
    [IdRule]            INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_SalaryStructureRule] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
PRINT N'Création de [Payroll].[SessionBonus]...';

GO
CREATE TABLE [Payroll].[SessionBonus] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdBonus]           INT            NOT NULL,
    [IdSession]         INT            NOT NULL,
    [IdContract]        INT            NOT NULL,
    [Value]             FLOAT (53)     NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_PaySlip_Premium] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de [Payroll].[FK_Contract_Premium_Contract]...';

GO
ALTER TABLE [Payroll].[ContractBonus] WITH NOCHECK
    ADD CONSTRAINT [FK_Contract_Premium_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Création de [Payroll].[FK_Contract_Premium_Premium]...';


GO
ALTER TABLE [Payroll].[ContractBonus] WITH NOCHECK
    ADD CONSTRAINT [FK_Contract_Premium_Premium] FOREIGN KEY ([IdBonus]) REFERENCES [Payroll].[Bonus] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

GO
PRINT N'Création de [Payroll].[FK_Contract_PremiumValidityPeriod_Contract_Premium]...';

GO
ALTER TABLE [Payroll].[ContractBonusValidityPeriod] WITH NOCHECK
    ADD CONSTRAINT [FK_Contract_PremiumValidityPeriod_Contract_Premium] FOREIGN KEY ([IdContractBonus]) REFERENCES [Payroll].[ContractBonus] ([Id]);

GO
PRINT N'Création de [Payroll].[FK_SalaryStructureRule_Rule]...';

GO
ALTER TABLE [Payroll].[SalaryStructureSalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryStructureRule_Rule] FOREIGN KEY ([IdRule]) REFERENCES [Payroll].[SalaryRule] ([Id]);

GO
PRINT N'Création de [Payroll].[FK_SalaryStructureRule_Structure]...';

GO
ALTER TABLE [Payroll].[SalaryStructureSalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryStructureRule_Structure] FOREIGN KEY ([IdStructure]) REFERENCES [Payroll].[SalaryStructure] ([Id]);

GO
PRINT N'Création de [Payroll].[FK_PaySlip_Premium_Premium]...';

GO
ALTER TABLE [Payroll].[SessionBonus] WITH NOCHECK
    ADD CONSTRAINT [FK_PaySlip_Premium_Premium] FOREIGN KEY ([IdBonus]) REFERENCES [Payroll].[Bonus] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

GO
PRINT N'Création de [Payroll].[FK_PaySlip_Premium_Session]...';

GO
ALTER TABLE [Payroll].[SessionBonus] WITH NOCHECK
    ADD CONSTRAINT [FK_PaySlip_Premium_Session] FOREIGN KEY ([IdSession]) REFERENCES [Payroll].[Session] ([Id]);

GO
PRINT N'Création de [Payroll].[FK_PaySlip_Premium_Contract]...';

GO
ALTER TABLE [Payroll].[SessionBonus] WITH NOCHECK
    ADD CONSTRAINT [FK_PaySlip_Premium_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]);

GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';

GO
ALTER TABLE [Payroll].[ContractBonus] WITH CHECK CHECK CONSTRAINT [FK_Contract_Premium_Contract];

ALTER TABLE [Payroll].[ContractBonus] WITH CHECK CHECK CONSTRAINT [FK_Contract_Premium_Premium];

ALTER TABLE [Payroll].[ContractBonusValidityPeriod] WITH CHECK CHECK CONSTRAINT [FK_Contract_PremiumValidityPeriod_Contract_Premium];

ALTER TABLE [Payroll].[SalaryStructureSalaryRule] WITH CHECK CHECK CONSTRAINT [FK_SalaryStructureRule_Rule];

ALTER TABLE [Payroll].[SalaryStructureSalaryRule] WITH CHECK CHECK CONSTRAINT [FK_SalaryStructureRule_Structure];

ALTER TABLE [Payroll].[SessionBonus] WITH CHECK CHECK CONSTRAINT [FK_PaySlip_Premium_Premium];

ALTER TABLE [Payroll].[SessionBonus] WITH CHECK CHECK CONSTRAINT [FK_PaySlip_Premium_Session];

ALTER TABLE [Payroll].[SessionBonus] WITH CHECK CHECK CONSTRAINT [FK_PaySlip_Premium_Contract];

GO
PRINT N'Mise à jour terminée.';


GO

ALTER TABLE [Sales].[DocumentLine] drop COLUMN TtcAmount