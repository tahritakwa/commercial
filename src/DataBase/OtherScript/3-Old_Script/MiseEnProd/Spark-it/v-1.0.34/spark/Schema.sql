--houssem alter company filed
ALTER TABLE [Shared].[Company] ALTER COLUMN [RegularisationMode] NVARCHAR (250) NULL;
--BOUBAKER ECHIEB: ADD Mail Subject Field to Information table
GO
PRINT N'Altering [ERPSettings].[Information]...';


GO
ALTER TABLE [ERPSettings].[Information]
    ADD [MailSubject] NVARCHAR (500) NULL;


GO
PRINT N'Update complete.';


GO

--


GO
CREATE TABLE [Payroll].[Department] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [DepartmentCode]    NVARCHAR (255) NOT NULL,
    [Name]              NVARCHAR (255) NOT NULL,
    [CreationDate]      DATE           NOT NULL,
    [Domain]            NVARCHAR (255) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[Echellon]...';


GO
CREATE TABLE [Payroll].[Echellon] (
    [Id]               INT            IDENTITY (1, 1) NOT NULL,
    [Label]             NVARCHAR (255) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Echellon] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[Grade]...';


GO
CREATE TABLE [Payroll].[Grade] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Label]             NCHAR (10)     NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Grade] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[MaritalStatus]...';


GO
CREATE TABLE [Payroll].[MaritalStatus] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [label]             NCHAR (255)    NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_MaritalStatus] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[Nationality]...';


GO
CREATE TABLE [Payroll].[Nationality] (
    [Id]                INT            NOT NULL,
    [CountryCode]       NVARCHAR (255) NOT NULL,
    [Name]              NVARCHAR (255) NOT NULL,
    [PhoneCode]         INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Nationality] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[Team]...';


GO
CREATE TABLE [Payroll].[Team] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [TeamCode]          NVARCHAR (255) NOT NULL,
    [Name]              NVARCHAR (255) NOT NULL,
    [CreationDate]      DATE           NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IdDepartment]      INT            NOT NULL,
    CONSTRAINT [PK_Team] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[FK_Team_Department]...';


GO
ALTER TABLE [Payroll].[Team] WITH NOCHECK
    ADD CONSTRAINT [FK_Team_Department] FOREIGN KEY ([IdDepartment]) REFERENCES [Payroll].[Department] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';




GO
ALTER TABLE [Payroll].[Team] WITH CHECK CHECK CONSTRAINT [FK_Team_Department];


GO
PRINT N'Update complete.';

alter table Payroll.Employee
drop column [MaritalStatus]
go

CREATE TABLE [Payroll].[Applicability] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Label]             NVARCHAR (255) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Applicability] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
PRINT N'Creating [Payroll].[ConstantRate]...';


GO

CREATE TABLE [Payroll].[RuleUniqueReference] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Reference]         NVARCHAR (255) NOT NULL,
    [Type]              INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NOT NULL,
    [DeletedToken]      NVARCHAR (255) NULL,
    CONSTRAINT [PK_RuleUniqueReference] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [Payroll].[ConstantRate] (
    [Id]                    INT            IDENTITY (1, 1) NOT NULL,
    [Description]           NVARCHAR (255) NULL,
    [IsDeleted]             BIT            NOT NULL,
    [TransactionUserId]     INT            NULL,
    [Deleted_Token]         NVARCHAR (255) NULL,
    [IdRuleUniqueReference] INT            NOT NULL,
    CONSTRAINT [PK_ConstantRate] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_ConstantRate_RuleUniqueReference] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
);
GO

GO
PRINT N'Creating [Payroll].[ConstantRateValidityPeriod]...';


GO

CREATE TABLE [Payroll].[ConstantRateValidityPeriod] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Date]              DATE           NOT NULL,
    [SalaryRate]        FLOAT (53)     NULL,
    [EmployerRate]      FLOAT (53)     NULL,
    [IdConstantRate]    INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_ConstantRateValidityPeriod] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_ConstantRate_ValidityPeriod] FOREIGN KEY ([IdConstantRate]) REFERENCES [Payroll].[ConstantRate] ([Id])
);
GO


CREATE TABLE [Payroll].[ConstantValue] (
    [Id]                    INT            IDENTITY (1, 1) NOT NULL,
    [Description]           NVARCHAR (255) NULL,
    [IsDeleted]             BIT            NOT NULL,
    [TransactionUserId]     INT            NULL,
    [Deleted_Token]         NVARCHAR (255) NULL,
    [IdRuleUniqueReference] INT            NOT NULL,
    CONSTRAINT [PK_Constant] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_ConstantValue_RuleUniqueReference] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
);
GO


CREATE TABLE [Payroll].[ConstantValueValidityPeriod] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Date]              DATE           NOT NULL,
    [Value]             FLOAT (53)     NOT NULL,
    [IdConstantValue]   INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_RuleValidityPeriod] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_ConstantValueValidityPeriod_ConstantValue] FOREIGN KEY ([IdConstantValue]) REFERENCES [Payroll].[ConstantValue] ([Id])
);
GO

GO
PRINT N'Creating [Payroll].[Contract]...';
CREATE TABLE [Payroll].[ContractType] (
    [Id]                    INT            IDENTITY (1, 1) NOT NULL,
    [ContractTypeReference] NVARCHAR (255) NOT NULL,
    [Label]                 NVARCHAR (255) NOT NULL,
    [Description]           NVARCHAR (255) NOT NULL,
    [IsDeleted]             BIT            NOT NULL,
    [TransactionUserId]     INT            NULL,
    [Deleted_Token]         NVARCHAR (255) NULL,
    CONSTRAINT [PK_ContractType] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [Payroll].[Job] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Label]             NVARCHAR (255) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Job] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [Payroll].[PlannedPayroll] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Value]             NVARCHAR (255) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_PlannedPayroll] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [Payroll].[SalaryStructure] (
    [Id]                       INT            IDENTITY (1, 1) NOT NULL,
    [SalaryStructureReference] NVARCHAR (255) NOT NULL,
    [Name]                     NVARCHAR (255) NOT NULL,
    [Order]                    INT            NOT NULL,
    [IsDeleted]                BIT            NOT NULL,
    [TransactionUserId]        INT            NULL,
    [Deleted_Token]            NVARCHAR (255) NULL,
    [IdParent]                 INT            NULL,
    CONSTRAINT [PK_SalaryStructure] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_SalaryStructure_SalaryStructureParent] FOREIGN KEY ([IdParent]) REFERENCES [Payroll].[SalaryStructure] ([Id])
);
GO

GO
CREATE TABLE [Payroll].[Contract] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [ContractReference] NVARCHAR (255) NOT NULL,
    [StartDate]         DATE           NOT NULL,
    [EndDate]           DATE           NULL,
    [BaseSalary]        FLOAT (53)     NOT NULL,
    [WorkingTime]       FLOAT (53)     NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IdEmployee]        INT            NOT NULL,
    [IdJob]             INT            NOT NULL,
    [IdContractType]    INT            NOT NULL,
    [IdSalaryStructure] INT            NOT NULL,
    [IdPlannedPayroll]  INT            NOT NULL,
    CONSTRAINT [PK_Contract] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Contract_ContractType] FOREIGN KEY ([IdContractType]) REFERENCES [Payroll].[ContractType] ([Id]),
    CONSTRAINT [FK_Contract_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]),
    CONSTRAINT [FK_Contract_Job] FOREIGN KEY ([IdJob]) REFERENCES [Payroll].[Job] ([Id]),
    CONSTRAINT [FK_Contract_PlannedPayroll] FOREIGN KEY ([IdPlannedPayroll]) REFERENCES [Payroll].[PlannedPayroll] ([Id]),
    CONSTRAINT [FK_Contract_SalaryStructure] FOREIGN KEY ([IdSalaryStructure]) REFERENCES [Payroll].[SalaryStructure] ([Id])
);
GO
PRINT N'Creating [Payroll].[ContributionRegister]...';


GO
CREATE TABLE [Payroll].[ContributionRegister] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Name]              NVARCHAR (255) NOT NULL,
    [Description]       NVARCHAR (255) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_ContributionRegister] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

PRINT N'Creating [Payroll].[DayOffHoliday]...';


GO

CREATE TABLE [Payroll].[DayOffHoliday] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [DayOfWeek]         NVARCHAR (10)  NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_DayOffHoliday] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [Payroll].[Skills] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Label]             NVARCHAR (255) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Qualification] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [Payroll].[EmployeeSkills] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdSkills]          INT            NOT NULL,
    [IdEmployee]        INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_EmployeeSkills] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_EmployeeSkills_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]),
    CONSTRAINT [FK_EmployeeSkills_Skills] FOREIGN KEY ([IdSkills]) REFERENCES [Payroll].[Skills] ([Id])
);
GO


CREATE TABLE [Payroll].[Leave] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [StartDate]         DATETIME       NOT NULL,
    [EndDate]           DATETIME       NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IdLeaveStatus]     INT            NOT NULL,
    [IdEmployee]        INT            NOT NULL,
    [IdLeaveType]       INT            NOT NULL,
    CONSTRAINT [PK_Leave] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
PRINT N'Creating [Payroll].[LeaveStatus]...';


GO

CREATE TABLE [Payroll].[LeaveStatus] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Label]             NCHAR (255)    NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_LeaveStatus] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[LeaveType]...';


GO
CREATE TABLE [Payroll].[LeaveType] (
    [Id]                 INT            IDENTITY (1, 1) NOT NULL,
    [Code]               NVARCHAR (255) NOT NULL,
    [IsPayed]            BIT            NOT NULL,
    [OvertakeAuthorized] BIT            NOT NULL,
    [IsDeleted]          BIT            NOT NULL,
    [TransactionUserId]  INT            NULL,
    [Deleted_Token]      NVARCHAR (255) NULL,
    CONSTRAINT [PK_LeaveType] PRIMARY KEY CLUSTERED ([Id] ASC)
);

alter TABLE [Payroll].[Leave] 
add CONSTRAINT [FK_Leave_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]),
    CONSTRAINT [FK_Leave_LeaveStatus] FOREIGN KEY ([IdLeaveStatus]) REFERENCES [Payroll].[LeaveStatus] ([Id]),
    CONSTRAINT [FK_Leave_LeaveType] FOREIGN KEY ([IdLeaveType]) REFERENCES [Payroll].[LeaveType] ([Id])

go


CREATE TABLE [Payroll].[Manager] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [ManagementType]    NVARCHAR (255) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IdEmployee]        INT            NOT NULL,
    [IdTeam]            INT            NOT NULL,
    CONSTRAINT [PK_Manager] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

PRINT N'Creating [Payroll].[ParentInCharge]...';


GO

CREATE TABLE [Payroll].[ParentInCharge] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Name]              NVARCHAR (255) NOT NULL,
    [FirstName]         NVARCHAR (255) NOT NULL,
    [BirthDate]         DATE           NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IdParentType]      INT            NOT NULL,
    [IdEmployee]        INT            NOT NULL,
    CONSTRAINT [PK_ParentInCharge] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

PRINT N'Creating [Payroll].[ParentType]...';


GO
CREATE TABLE [Payroll].[ParentType] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Label]             NVARCHAR (255) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_ParentType] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

PRINT N'Creating [Payroll].[Payslip]...';


GO

CREATE TABLE [Payroll].[Payslip] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [PayslipNumber]     NVARCHAR (255) NOT NULL,
    [StartDate]         DATE           NOT NULL,
    [EndDate]           DATE           NOT NULL,
    [PaymentDate]       DATE           NOT NULL,
    [ExpirationDate]    DATE           NOT NULL,
    [IdContract]        INT            NOT NULL,
    [IdEmployee]        INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_Payslip] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
PRINT N'Creating [Payroll].[PayslipDetails]...';


GO
CREATE TABLE [Payroll].[PayslipDetails] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Rule]              NVARCHAR (255) NOT NULL,
    [SalaryValue]       FLOAT (53)     NOT NULL,
    [EmployerValue]     FLOAT (53)     NOT NULL,
    [Order]             INT            NOT NULL,
    [IdPayslip]         INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_PayslipDetails] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO

PRINT N'Creating [Payroll].[RuleCategory]...';


GO

CREATE TABLE [Payroll].[RuleCategory] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Label]             NVARCHAR (255) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_RuleCategory] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO

PRINT N'Creating [Payroll].[RuleType]...';


GO
CREATE TABLE [Payroll].[RuleType] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Label]             NVARCHAR (255) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_RuleType] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

PRINT N'Creating [Payroll].[SalaryRule]...';


GO

CREATE TABLE [Payroll].[SalaryRule] (
    [Id]                     INT             IDENTITY (1, 1) NOT NULL,
    [Name]                   NVARCHAR (255)  NOT NULL,
    [Description]            NVARCHAR (255)  NOT NULL,
    [Order]                  INT             NOT NULL,
    [rule]                   NVARCHAR (2000) NULL,
    [IdRuleType]             INT             NOT NULL,
    [AppearsOnPaySlip]       BIT             NOT NULL,
    [IdApplicability]        INT             NULL,
    [IdRuleCategory]         INT             NOT NULL,
    [IsDeleted]              BIT             NOT NULL,
    [TransactionUserId]      INT             NULL,
    [Deleted_Token]          NVARCHAR (255)  NULL,
    [IdContributionRegister] INT             NULL,
    [IdRuleUniqueReference]  INT             NOT NULL,
    CONSTRAINT [PK_SalaryRule] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[SalaryStructure_SalaryRule]...';


GO
CREATE TABLE [Payroll].[SalaryStructure_SalaryRule] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdStructure]       INT            NOT NULL,
    [IdRule]            INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_SalaryStructureRule] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[StatutoryHoliday]...';


GO
CREATE TABLE [Payroll].[StatutoryHoliday] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Date]              DATE           NOT NULL,
    [Name]              NVARCHAR (255) NOT NULL,
    [Payed]             BIT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_StatutoryHoliday] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Payroll].[Variable]...';


GO
CREATE TABLE [Payroll].[Variable] (
    [Id]                    INT             IDENTITY (1, 1) NOT NULL,
    [Description]           NVARCHAR (255)  NULL,
    [Formule]               NVARCHAR (2000) NOT NULL,
    [IsDeleted]             BIT             NOT NULL,
    [TransactionUserId]     INT             NULL,
    [Deleted_Token]         NVARCHAR (255)  NULL,
    [IdRuleUniqueReference] INT             NOT NULL,
    CONSTRAINT [PK_Variable] PRIMARY KEY CLUSTERED ([Id] ASC)
);



GO
ALTER TABLE [Payroll].[Manager] WITH NOCHECK
    ADD CONSTRAINT [FK_Manager_Team] FOREIGN KEY ([IdTeam]) REFERENCES [Payroll].[Team] ([Id]);

GO
ALTER TABLE [Payroll].[ParentInCharge] WITH NOCHECK
    ADD CONSTRAINT [FK_ParentInCharge_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]);


GO
ALTER TABLE [Payroll].[Payslip] WITH NOCHECK
    ADD CONSTRAINT [FK_Payslip_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]);

GO
ALTER TABLE [Payroll].[PayslipDetails] WITH NOCHECK
    ADD CONSTRAINT [FK_PayslipDetails_Payslip] FOREIGN KEY ([IdPayslip]) REFERENCES [Payroll].[Payslip] ([Id]);
	

GO
ALTER TABLE [Payroll].[SalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryRule_Applicability] FOREIGN KEY ([IdApplicability]) REFERENCES [Payroll].[Applicability] ([Id]);

GO
ALTER TABLE [Payroll].[SalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryRule_ContributionRegister] FOREIGN KEY ([IdContributionRegister]) REFERENCES [Payroll].[ContributionRegister] ([Id]);

GO
ALTER TABLE [Payroll].[SalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryRule_RuleCategory] FOREIGN KEY ([IdRuleCategory]) REFERENCES [Payroll].[RuleCategory] ([Id]);

	
GO
PRINT N'Creating [Payroll].[FK_SalaryRule_RuleType]...';


GO
ALTER TABLE [Payroll].[SalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryRule_RuleType] FOREIGN KEY ([IdRuleType]) REFERENCES [Payroll].[RuleType] ([Id]);

GO
PRINT N'Creating [Payroll].[FK_SalaryRule_RuleUniqueReference]...';


GO
ALTER TABLE [Payroll].[SalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryRule_RuleUniqueReference] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id]);


GO
PRINT N'Creating [Payroll].[FK_SalaryStructureRule_Rule]...';


GO
ALTER TABLE [Payroll].[SalaryStructure_SalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryStructureRule_Rule] FOREIGN KEY ([IdRule]) REFERENCES [Payroll].[SalaryRule] ([Id]);

	GO
PRINT N'Creating [Payroll].[FK_SalaryStructureRule_Structure]...';


GO
ALTER TABLE [Payroll].[SalaryStructure_SalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_SalaryStructureRule_Structure] FOREIGN KEY ([IdStructure]) REFERENCES [Payroll].[SalaryStructure] ([Id]);


GO
PRINT N'Creating [Payroll].[FK_Variable_RuleUnique]...';


GO
ALTER TABLE [Payroll].[Variable] WITH NOCHECK
    ADD CONSTRAINT [FK_Variable_RuleUnique] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


go


ALTER TABLE [Payroll].[Manager] WITH CHECK CHECK CONSTRAINT [FK_Manager_Team];

ALTER TABLE [Payroll].[Payslip] WITH CHECK CHECK CONSTRAINT [FK_Payslip_Contract];


ALTER TABLE [Payroll].[PayslipDetails] WITH CHECK CHECK CONSTRAINT [FK_PayslipDetails_Payslip];

ALTER TABLE [Payroll].[SalaryRule] WITH CHECK CHECK CONSTRAINT [FK_SalaryRule_Applicability];

ALTER TABLE [Payroll].[SalaryRule] WITH CHECK CHECK CONSTRAINT [FK_SalaryRule_ContributionRegister];

ALTER TABLE [Payroll].[SalaryRule] WITH CHECK CHECK CONSTRAINT [FK_SalaryRule_RuleCategory];

ALTER TABLE [Payroll].[SalaryRule] WITH CHECK CHECK CONSTRAINT [FK_SalaryRule_RuleType];

ALTER TABLE [Payroll].[SalaryRule] WITH CHECK CHECK CONSTRAINT [FK_SalaryRule_RuleUniqueReference];

ALTER TABLE [Payroll].[SalaryStructure_SalaryRule] WITH CHECK CHECK CONSTRAINT [FK_SalaryStructureRule_Rule];

ALTER TABLE [Payroll].[SalaryStructure_SalaryRule] WITH CHECK CHECK CONSTRAINT [FK_SalaryStructureRule_Structure];

ALTER TABLE [Payroll].[Variable] WITH CHECK CHECK CONSTRAINT [FK_Variable_RuleUnique];

GO

ALTER TABLE [ERPSettings].[ReportComponent] ALTER COLUMN [HostAppId] NVARCHAR (50) NULL;


GO
PRINT N'Creating [Administration].[FK_EntityAxisValues_Entity]...';


GO
ALTER TABLE [Administration].[EntityAxisValues] WITH NOCHECK
    ADD CONSTRAINT [FK_EntityAxisValues_Entity] FOREIGN KEY ([Entity]) REFERENCES [ERPSettings].[Entity] ([Id]);
GO

ALTER TABLE [Payroll].[IdentityPieces]
    Add [Current]              BIT            NOT NULL
GO

ALTER TABLE [Payroll].[Manager]
    Add CONSTRAINT [FK_Manager_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
GO

CREATE UNIQUE NONCLUSTERED INDEX [Unique_RuleUniqueReference]
    ON [Payroll].[RuleUniqueReference]([Reference] ASC);
GO

    alter TABLE [Payroll].[Payslip]
	add CONSTRAINT [FK_Payslip_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
	GO

drop table [Payroll].[Nationality]
go

alter table [Payroll].[ParentInCharge]
add CONSTRAINT [FK_ParentInCharge_ParentType] FOREIGN KEY ([IdParentType]) REFERENCES [Payroll].[ParentType] ([Id])
go


alter table [Payroll].[Employee]

  add [IdGrade]                  INT             NULL,
    [IdNationalityCountry]     INT             NULL,
    [IdNationalityCity]        INT            NULL,
    [IdTeam]                   INT            NULL,
    [IdUpperHierarchy]         INT            NULL,
    [IdEchellon]               INT             NULL,
    [WorkingLicenseNumber]     NVARCHAR (255) NULL,
    [IdMaritalStatus]          INT             NULL
	GO

SET IDENTITY_INSERT [Payroll].[Grade] ON
INSERT INTO [Payroll].[Grade] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Ingénieur ', 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[Grade] OFF
GO

SET IDENTITY_INSERT [Payroll].[Echellon] ON
INSERT INTO [Payroll].[Echellon] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Cadre supérieur', 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[Echellon] OFF
GO

SET IDENTITY_INSERT [Payroll].[MaritalStatus] ON
INSERT INTO [Payroll].[MaritalStatus] ([Id], [label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Célibataire                                                                                                                                                                                                                                                    ', 0, NULL, NULL)
INSERT INTO [Payroll].[MaritalStatus] ([Id], [label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Marié                                                                                                                                                                                                                                                          ', 0, NULL, NULL)
INSERT INTO [Payroll].[MaritalStatus] ([Id], [label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Divorcé                                                                                                                                                                                                                                                        ', 0, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[MaritalStatus] OFF
GO

update [Payroll].[Employee]
set [IdGrade] =1,
[IdNationalityCountry] = 2,
[IdEchellon] =1,
[IdMaritalStatus]=1
GO

alter table [Payroll].[Employee]
ALTER COLUMN   [IdGrade]                  INT            NOT NULL
GO

alter table [Payroll].[Employee]	
ALTER COLUMN     [IdNationalityCountry]     INT            NOT NULL
GO

	alter table [Payroll].[Employee]
 ALTER COLUMN    [IdEchellon]               INT            NOT NULL
 GO

	alter table [Payroll].[Employee]
  ALTER COLUMN   [IdMaritalStatus]          INT            NOT NULL

  GO

alter table [Payroll].[Employee]
Add CONSTRAINT [FK_Employee_Echellon] FOREIGN KEY ([IdEchellon]) REFERENCES [Payroll].[Echellon] ([Id]),
    CONSTRAINT [FK_Employee_Grade] FOREIGN KEY ([IdGrade]) REFERENCES [Payroll].[Grade] ([Id]),
    CONSTRAINT [FK_Employee_MaritalStatus] FOREIGN KEY ([IdMaritalStatus]) REFERENCES [Payroll].[MaritalStatus] ([Id]),
    CONSTRAINT [FK_Employee_NationalityCity] FOREIGN KEY ([IdNationalityCity]) REFERENCES [Shared].[City] ([Id]),
    CONSTRAINT [FK_Employee_NationalityCountry] FOREIGN KEY ([IdNationalityCountry]) REFERENCES [Shared].[Country] ([Id]),
    CONSTRAINT [FK_Employee_Team] FOREIGN KEY ([IdTeam]) REFERENCES [Payroll].[Team] ([Id]),
    CONSTRAINT [FK_Employee_UpperHierarchy] FOREIGN KEY ([IdUpperHierarchy]) REFERENCES [Payroll].[Employee] ([Id])

	GO

alter table [ERPSettings].[UserRole]
drop CONSTRAINT [PK_UserRole] 
GO

alter table [ERPSettings].[UserRole]
add [Id]                INT            IDENTITY (1, 1) NOT NULL
GO

alter table [ERPSettings].[UserRole]
add CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED ([Id] ASC)
GO

PRINT N'Altering [Administration].[AxisEntity]...';


GO
ALTER TABLE [Administration].[AxisEntity]
    ADD [IsRequired] BIT NULL;


GO

