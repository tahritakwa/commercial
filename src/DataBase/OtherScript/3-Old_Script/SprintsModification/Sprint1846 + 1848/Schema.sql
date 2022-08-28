-- Mohamed BOUZIDI Contract_Job and Employee_Grade NULL

GO
PRINT N'Dropping [Payroll].[FK_Contract_Job]...';


GO
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_Job];


GO
PRINT N'Altering [Payroll].[Contract]...';


GO
ALTER TABLE [Payroll].[Contract] ALTER COLUMN [IdJob] INT NULL;


GO
PRINT N'Creating [Payroll].[FK_Contract_Job]...';


GO
ALTER TABLE [Payroll].[Contract] WITH NOCHECK
    ADD CONSTRAINT [FK_Contract_Job] FOREIGN KEY ([IdJob]) REFERENCES [Payroll].[Job] ([Id]);

GO
PRINT N'Dropping [Payroll].[FK_Employee_Grade]...';


GO
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Grade];


GO
PRINT N'Altering [Payroll].[Employee]...';


GO
ALTER TABLE [Payroll].[Employee] ALTER COLUMN [IdGrade] INT NULL;


GO
PRINT N'Creating [Payroll].[FK_Employee_Grade]...';


GO
ALTER TABLE [Payroll].[Employee] WITH NOCHECK
    ADD CONSTRAINT [FK_Employee_Grade] FOREIGN KEY ([IdGrade]) REFERENCES [Payroll].[Grade] ([Id]);

-- Narcisse : Improve bonus and bonus contract affectation strategy

GO
ALTER TABLE [Payroll].[ContractBonusValidityPeriod] DROP CONSTRAINT [FK_Contract_PremiumValidityPeriod_Contract_Premium];


GO
PRINT N'Suppression de [Payroll].[ContractBonusValidityPeriod]...';


GO
DROP TABLE [Payroll].[ContractBonusValidityPeriod];


GO
PRINT N'Création de [Payroll].[BonusValidityPeriod]...';


GO
CREATE TABLE [Payroll].[BonusValidityPeriod] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Value]             FLOAT (53)     NOT NULL,
    [StartDate]         DATE           NOT NULL,
    [IdBonus]           INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Contract_PremiumValidityPeriod] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de [Payroll].[FK_ContractBonusValidityPeriod_Bonus]...';


GO
ALTER TABLE [Payroll].[BonusValidityPeriod] WITH NOCHECK
    ADD CONSTRAINT [FK_ContractBonusValidityPeriod_Bonus] FOREIGN KEY ([IdBonus]) REFERENCES [Payroll].[Bonus] ([Id]) ON DELETE CASCADE;


GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';


GO
ALTER TABLE [Payroll].[BonusValidityPeriod] WITH CHECK CHECK CONSTRAINT [FK_ContractBonusValidityPeriod_Bonus];

GO
ALTER TABLE [Payroll].[Attendance] DROP CONSTRAINT [FK_Attendance_Session];


GO
PRINT N'Création de [Payroll].[FK_Attendance_Session]...';


GO
ALTER TABLE [Payroll].[Attendance] WITH NOCHECK
    ADD CONSTRAINT [FK_Attendance_Session] FOREIGN KEY ([IdSession]) REFERENCES [Payroll].[Session] ([Id]) ON DELETE CASCADE;


GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';


GO
ALTER TABLE [Payroll].[Attendance] WITH CHECK CHECK CONSTRAINT [FK_Attendance_Session];


GO
PRINT N'Mise à jour terminée.';


GO

ALter table [Payroll].[ContractBonus] Add [Value]             FLOAT (53)     NULL,
    [ValidityStartDate] DATE           NOT NULL;

ALter table [Payroll].[ContractBonus] drop CONSTRAINT [FK_Contract_Premium_Contract];

ALter table [Payroll].[ContractBonus] drop CONSTRAINT [FK_Contract_Premium_Premium];

Alter table  [Payroll].[ContractBonus] 
ADD CONSTRAINT [FK_Contract_Bonus_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

Alter table  [Payroll].[ContractBonus] 
ADD CONSTRAINT [FK_Contract_Bonus_Bonus] FOREIGN KEY ([IdBonus]) REFERENCES [Payroll].[Bonus] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE

Alter table [Payroll].[Payslip] 
DROP CONSTRAINT [FK_Payslip_Session]

Alter table [Payroll].[Payslip] 
ADD CONSTRAINT [FK_Payslip_Session] FOREIGN KEY ([IdSession]) REFERENCES [Payroll].[Session] ([Id]) ON DELETE CASCADE;

Alter table [Payroll].[PayslipDetails]
DROP CONSTRAINT [FK_PayslipDetails_Payslip]

Alter table [Payroll].[PayslipDetails]
ADD CONSTRAINT [FK_PayslipDetails_Payslip] FOREIGN KEY ([IdPayslip]) REFERENCES [Payroll].[Payslip] ([Id]) ON DELETE CASCADE;

ALTER TABLE [Payroll].[SessionBonus]
DROP CONSTRAINT [FK_PaySlip_Premium_Session]

ALTER TABLE [Payroll].[SessionBonus]
ADD CONSTRAINT [FK_PaySlip_Premium_Session] FOREIGN KEY ([IdSession]) REFERENCES [Payroll].[Session] ([Id]) ON DELETE CASCADE;

ALTER TABLE [Payroll].[SessionEmployee]
DROP CONSTRAINT [FK_SessionEmployee_Session]

ALTER TABLE [Payroll].[SessionEmployee]
ADD CONSTRAINT [FK_SessionEmployee_Session] FOREIGN KEY ([IdSession]) REFERENCES [Payroll].[Session] ([Id]) ON DELETE CASCADE;


--- Marwa delete property Not null of CodeDocumentLine column ---

GO
ALTER TABLE [Sales].[DocumentLine] ALTER COLUMN [CodeDocumentLine] NVARCHAR (50) NULL; 


--houssem add Emmplyee filed

GO
ALTER TABLE [Payroll].[Employee]
    ADD 
        [CinAttached]               NVARCHAR (500) NULL,
        [HomeLoan]                  FLOAT (53)     NULL,
        [ChildrenNoScholar]         INT            NULL,
        [ChildrenDisabled]          INT            NULL,
        [IsForeign]                 BIT            CONSTRAINT [DF_Employee_IsForeign] DEFAULT ((0)) NOT NULL,
		[DependentParent]          	INT            NULL;

--Mohamed add EmployeeDocument table

CREATE TABLE [Payroll].[EmployeeDocument] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Label]             NVARCHAR (250) NULL,
	[Type]              INT            NOT NULL,  
	[Value]				NVARCHAR (250) NULL,
	[IdEmployee]        INT            NOT NULL, 
    [AttachedFile]      NVARCHAR (500) NULL,
    [ExpirationDate]    DATE           NULL,
    [IsPermanent]       BIT            CONSTRAINT [DF_EmployeeDocument_IsPermanent] DEFAULT ((0)) NOT NULL,    
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_EmployeeDocument] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_EmployeeDocument_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- Narcisse : Add Cnss type

CREATE TABLE [Payroll].[Cnss] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Label]             NVARCHAR (255) NOT NULL,
    [EmployerRate]      FLOAT (53)     NOT NULL,
    [SalaryRate]        FLOAT (53)     NOT NULL,
    [WorkAccidentQuota] FLOAT (53)     NULL,
    [OperatingCode]     NVARCHAR (20)  NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Cnss] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO
ALTER TABLE [Payroll].[Contract] ADD  [IdCnss] INT NOT NULL
ALTER TABLE [Payroll].[Contract] ADD CONSTRAINT [FK_Contract_Cnss] FOREIGN KEY ([IdCnss]) REFERENCES [Payroll].[Cnss] ([Id])

-- narcisse : Cnss type rename, delete employer value in payslipdetails 

ALTER TABLE [Payroll].[PayslipDetails] DROP COLUMN [EmployerValue];  

---- Nihel: add [ApiRole] column
GO
PRINT N'Altering [ERPSettings].[Functionality]...';

GO
ALTER TABLE [ERPSettings].[Functionality]
    ADD [ApiRole] NVARCHAR (50) NULL;


--notifification v2
ALTER TABLE [ERPSettings].[Information] ADD [TranslationKey]  NVARCHAR (500)   NULL,  [Type]  NVARCHAR (500) NULL


--update Picture
alter table   Payroll.Employee
drop column Photo 

alter table   Payroll.Employee
add Picture  nvarchar(500)

--- Marwa Add table comment ---
GO
CREATE TABLE [ERPSettings].[Comment] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdEntityReference] INT            NULL,
    [IdEntityCreated]   INT            NULL,
    [IdCreator]         INT            NULL,
    [Message]           NVARCHAR (MAX) NULL,
    [CreationDate]      DATETIME       NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO
ALTER TABLE [ERPSettings].[Comment]
    ADD CONSTRAINT [DF_Comment_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];
	
	GO
ALTER TABLE [ERPSettings].[Comment] WITH NOCHECK
    ADD CONSTRAINT [FK_Comment_Entity] FOREIGN KEY ([IdEntityReference]) REFERENCES [ERPSettings].[Entity] ([Id]);

	GO
ALTER TABLE [ERPSettings].[Comment] WITH NOCHECK
    ADD CONSTRAINT [FK_Comment_User] FOREIGN KEY ([IdCreator]) REFERENCES [ERPSettings].[User] ([Id]);

	GO
ALTER TABLE [ERPSettings].[Comment] WITH CHECK CHECK CONSTRAINT [FK_Comment_Entity];

ALTER TABLE [ERPSettings].[Comment] WITH CHECK CHECK CONSTRAINT [FK_Comment_User];

--add new document type 
ALTER TABLE [Sales].[Document]   ADD [IdDocumentAssociated] INT NULL;
--Fatma :Add QuotationUnitPrice column in document line 

ALTER TABLE [Sales].[DocumentLine]
    ADD [UnitPriceFromQuotation] FLOAT (53) NULL;

