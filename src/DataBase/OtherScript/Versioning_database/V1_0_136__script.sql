
-- Mohamed BOUZIDI User
ALTER TABLE [ERPSettings].[User] ADD [IsWithEmailNotification] BIT CONSTRAINT [DF_User_IsWithEmailNotification] DEFAULT ((1)) NOT NULL
ALTER TABLE [ERPSettings].[User] ADD [IdPhone] INT CONSTRAINT [FK_User_Phone] FOREIGN KEY ([IdPhone]) REFERENCES [Shared].[Phone] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE NULL
ALTER TABLE [ERPSettings].[User] ADD [UrlPicture] NVARCHAR (255) NULL

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

	--chedi : add storagtransert add and list functionalities
INSERT INTO [Inventory].[StockDocumentType] ([CodeType], [Type], [StockOperation], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (N'TShSt', N'TShSt', N'T', N'TransferShelfStorage', 0, 0, NULL)


 SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values
(104150,N'RC_movement',N'Mouvement de RC',0,null, 22222)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES
(N'fd101f2f-5b91-4de3-9a07-337b4a3c5150', N'rc movement', 4, N'mouvement de rc', N'rc movement', NULL, NULL, NULL, NULL, N'/Stock', 0, N'RC_movement')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES
( 104150, N'fd101f2f-5b91-4de3-9a07-337b4a3c5150', 1)
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES
(N'fd101f2f-5b91-4de3-9a07-337b4a3c5151', N'ADD-TransferShelfStorage', 4, N'ADD Transfer Shelf Storage', N'ADD Transfer Shel fStorage', NULL, NULL, NULL, NULL, N'/Stock', 0, N'ADD-TransferShelfStorage')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES
( 104150, N'fd101f2f-5b91-4de3-9a07-337b4a3c5151', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES
( N'2193DDF9-9631-4AAF-BB15-5F95FC25E44F', 104150, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7153', N'fd101f2f-5b91-4de3-9a07-337b4a3c5150', N'2193DDF9-9631-4AAF-BB15-5F95FC25E44F')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES
(N'fd101f2f-5b91-4de3-9a07-337b4a3c5152', N'LIST-TransferShelfStorage', 4, N'List Transfer Shelf Storage', N'List Transfer Shelf Storage', NULL, NULL, NULL, NULL, N'/Stock', 0, N'LIST-TransferShelfStorage')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES
( 104150, N'fd101f2f-5b91-4de3-9a07-337b4a3c5152', 1)

-- add storage transfer codifaction
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (83, 137, N'TypeStockDocument', N'TShSt', 394)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (394, N'CodeStockDocument-TRC', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (395, N'CaractereTD', 1, NULL, NULL, N'TRC', 394, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (396, N'Annee', 2, NULL, N'string', N'20', 394, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (397, N'Caractere/', 3, NULL, NULL, N'/', 394, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (398, N'compteurTM', 4, NULL, NULL, NULL, 394, 1, 1, N'00000000', 8)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
COMMIT TRANSACTION

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
ALTER TABLE [Inventory].[Storage] WITH NOCHECK
    ADD CONSTRAINT [FK_Storage_User] FOREIGN KEY ([IdResponsable]) REFERENCES [ERPSettings].[User] ([Id]);


GO
ALTER TABLE [Inventory].[Storage] WITH CHECK CHECK CONSTRAINT [FK_Storage_User];
--- Donia change MaximumNumberOfDays in leavetype to not null and add default value 11/11/2020
ALTER TABLE [Payroll].[LeaveType] ALTER COLUMN [MaximumNumberOfDays] INT NOT NULL;
ALTER TABLE [Payroll].[LeaveType] ADD DEFAULT ((1)) FOR [MaximumNumberOfDays];


-- 12/11/2020 : Narcisse: DELETE CASCADE on [IdExitEmployeePayLine]
		
ALTER TABLE [Payroll].[LinesSalaryRule] DROP CONSTRAINT [FK_LinesSalaryRule_ExitEmployeePayLine];

GO
ALTER TABLE [Payroll].[LinesSalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_LinesSalaryRule_ExitEmployeePayLine] FOREIGN KEY ([IdExitEmployeePayLine]) REFERENCES [Payroll].[ExitEmployeePayLine] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE [Sales].[DocumentLineTaxe]
	ADD [TaxeBase] FLOAT (53) NULL;

--- kossi alter table bankAccount 19/11/2020
GO
ALTER TABLE [Shared].[BankAccount] ALTER COLUMN [Fax] NVARCHAR (255) NULL;

ALTER TABLE [Shared].[BankAccount] ALTER COLUMN [Telephone] NVARCHAR (255) NULL;


-- 17/11/2020 : Narcisse: Standardize the names of the tables of the employee output

ALTER TABLE [Payroll].[ActionExitEmployee] DROP CONSTRAINT [FK_ActionExitEmployee_Actions];
ALTER TABLE [Payroll].[ActionExitEmployee] DROP CONSTRAINT [FK_ActionExitEmployee_EmployeeExit];
ALTER TABLE [Payroll].[EmployeeExit] DROP CONSTRAINT [FK_EmployeeExit_Employee];
ALTER TABLE [Payroll].[EmployeeExit] DROP CONSTRAINT [FK_EmployeeExit_ExitReason];
ALTER TABLE [Payroll].[LinesSalaryRule] DROP CONSTRAINT [FK_LinesSalaryRule_ExitEmployeePayLine];
ALTER TABLE [Payroll].[LinesSalaryRule] DROP CONSTRAINT [FK_LinesSalaryRule_SalaryRule];

ALTER TABLE [RH].[Interview] DROP CONSTRAINT [FK_Interview_EmployeeExit];
ALTER TABLE [Payroll].[ExitEmailForEmployee] DROP CONSTRAINT [FK_ExitEmailForEmployee_EmployeeExit];
ALTER TABLE [Payroll].[ExitEmployeeLeaveLine] DROP CONSTRAINT [FK_ExitEmployeeLeaveLine_EmployeeExit];
ALTER TABLE [Payroll].[ExitEmployeePayLine] DROP CONSTRAINT [FK_ExitEmployeePayLine_EmployeeExit];

DROP TABLE [Payroll].[ActionExitEmployee];
DROP TABLE [Payroll].[Actions];
DROP TABLE [Payroll].[LinesSalaryRule];
DROP TABLE [Payroll].[EmployeeExit];

CREATE TABLE [Payroll].[ExitEmployee] (
    [Id]                          INT            IDENTITY (1, 1) NOT NULL,
    [IdExitReason]                INT            NOT NULL,
    [IdEmployee]                  INT            NOT NULL,
    [IsDeleted]                   BIT            NOT NULL,
    [TransactionUserId]           INT            NULL,
    [Deleted_Token]               NVARCHAR (255) NULL,
    [ReleaseDate]                 DATE           NOT NULL,
    [ExitEmployeeAttachementFile] NVARCHAR (500) NULL,
    [CommentRh]                   NVARCHAR (255) NULL,
    [Status]                      INT            NULL,
    [TreatmentDate]               DATE           NULL,
    [TreatedBy]                   INT            NULL,
    [LegalExitDate]               DATE           NULL,
    [DamagingDeparture]           BIT            NULL,
    [ExitDepositDate]             DATE           NULL,
    [MinNoticePeriodDate]         DATE           NULL,
    [MaxNoticePeriodDate]         DATE           NULL,
    [ExitPhysicalDate]            DATE           NULL,
    [StatePay]                    INT            NULL,
    [StateLeave]                  INT            NULL,
    CONSTRAINT [PK_EmployeeExit] PRIMARY KEY CLUSTERED ([Id] ASC)
);
ALTER TABLE [Payroll].[ExitEmailForEmployee] WITH NOCHECK
    ADD CONSTRAINT [FK_ExitEmailForEmployee_EmployeeExit] FOREIGN KEY ([IdEmployeeExit]) REFERENCES [Payroll].[ExitEmployee] ([Id]);

ALTER TABLE [Payroll].[ExitEmployeeLeaveLine] WITH NOCHECK
    ADD CONSTRAINT [FK_ExitEmployeeLeaveLine_EmployeeExit] FOREIGN KEY ([IdEmployeeExit]) REFERENCES [Payroll].[ExitEmployee] ([Id]);

ALTER TABLE [Payroll].[ExitEmployeePayLine] WITH NOCHECK
    ADD CONSTRAINT [FK_ExitEmployeePayLine_EmployeeExit] FOREIGN KEY ([IdEmployeeExit]) REFERENCES [Payroll].[ExitEmployee] ([Id]);

ALTER TABLE [RH].[Interview] WITH NOCHECK
    ADD CONSTRAINT [FK_Interview_EmployeeExit] FOREIGN KEY ([IdEmployeeExit]) REFERENCES [Payroll].[ExitEmployee] ([Id]);


CREATE TABLE [Payroll].[ExitAction] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [Label]             NVARCHAR (255) NULL,
    [Description]       NVARCHAR (255) NULL,
    CONSTRAINT [PK_Actions] PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [Payroll].[ExitActionEmployee] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (MAX) NULL,
    [IdEmployeeExit]    INT            NULL,
    [IdActions]         INT            NULL,
    [Verify_Action]     BIT            NULL,
    CONSTRAINT [PK_ActionExitEmployee] PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [Payroll].[ExitEmployeePayLineSalaryRule] (
    [Id]                    INT        IDENTITY (1, 1) NOT NULL,
    [IdSalaryRule]          INT        NULL,
    [IdExitEmployeePayLine] INT        NULL,
    [Value]                 FLOAT (53) NULL,
    CONSTRAINT [PK_LinesSalaryRule] PRIMARY KEY CLUSTERED ([Id] ASC)
);

ALTER TABLE [Payroll].[ExitActionEmployee] WITH NOCHECK
    ADD CONSTRAINT [FK_ActionExitEmployee_Actions] FOREIGN KEY ([IdActions]) REFERENCES [Payroll].[ExitAction] ([Id]);

ALTER TABLE [Payroll].[ExitActionEmployee] WITH NOCHECK
    ADD CONSTRAINT [FK_ActionExitEmployee_EmployeeExit] FOREIGN KEY ([IdEmployeeExit]) REFERENCES [Payroll].[ExitEmployee] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE [Payroll].[ExitEmployeePayLineSalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_LinesSalaryRule_ExitEmployeePayLine] FOREIGN KEY ([IdExitEmployeePayLine]) REFERENCES [Payroll].[ExitEmployeePayLine] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE [Payroll].[ExitEmployeePayLineSalaryRule] WITH NOCHECK
    ADD CONSTRAINT [FK_LinesSalaryRule_SalaryRule] FOREIGN KEY ([IdSalaryRule]) REFERENCES [Payroll].[SalaryRule] ([Id]);

ALTER TABLE [Payroll].[ExitEmployee] WITH NOCHECK
    ADD CONSTRAINT [FK_EmployeeExit_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE [Payroll].[ExitEmployee] WITH NOCHECK
    ADD CONSTRAINT [FK_EmployeeExit_ExitReason] FOREIGN KEY ([IdExitReason]) REFERENCES [Payroll].[ExitReason] ([Id]);

ALTER TABLE [Payroll].[ExitActionEmployee] DROP  CONSTRAINT [FK_ActionExitEmployee_Actions]
ALTER TABLE [Payroll].[ExitActionEmployee] DROP CONSTRAINT [FK_ActionExitEmployee_EmployeeExit]
ALTER TABLE [Payroll].[ExitActionEmployee] DROP COLUMN [IdEmployeeExit], [IdActions]
ALTER TABLE [Payroll].[ExitActionEmployee] DROP COLUMN [Verify_Action]
ALTER TABLE [Payroll].[ExitActionEmployee] ADD  [Verify_Action] BIT CONSTRAINT [DF_ExitActionEmployee_Verify_Action] DEFAULT ((0)) NOT NULL
ALTER TABLE [Payroll].[ExitActionEmployee] ADD [IdExitEmployee] INT NULL,  [IdExitAction] INT NULL
ALTER TABLE [Payroll].[ExitActionEmployee] ADD CONSTRAINT [FK_ActionExitEmployee_Actions] FOREIGN KEY ([IdExitAction]) REFERENCES [Payroll].[ExitAction] ([Id])
ALTER TABLE [Payroll].[ExitActionEmployee] ADD CONSTRAINT [FK_ActionExitEmployee_EmployeeExit] FOREIGN KEY ([IdExitEmployee]) REFERENCES [Payroll].[ExitEmployee] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [Payroll].[ExitEmailForEmployee] DROP CONSTRAINT [FK_ExitEmailForEmployee_EmployeeExit]
ALTER TABLE [Payroll].[ExitEmailForEmployee] DROP COLUMN [IdEmployeeExit]
ALTER TABLE [Payroll].[ExitEmailForEmployee] ADD [IdExitEmployee] INT NOT NULL
ALTER TABLE [Payroll].[ExitEmailForEmployee] ADD CONSTRAINT [FK_ExitEmailForEmployee_EmployeeExit] FOREIGN KEY ([IdExitEmployee]) REFERENCES [Payroll].[ExitEmployee] ([Id])
ALTER TABLE [Payroll].[ExitEmployeeLeaveLine] DROP CONSTRAINT [FK_ExitEmployeeLeaveLine_EmployeeExit]
ALTER TABLE [Payroll].[ExitEmployeeLeaveLine] DROP COLUMN [IdEmployeeExit]
ALTER TABLE [Payroll].[ExitEmployeeLeaveLine] ADD [IdExitEmployee] INT NULL
ALTER TABLE [Payroll].[ExitEmployeeLeaveLine] ADD CONSTRAINT [FK_ExitEmployeeLeaveLine_EmployeeExit] FOREIGN KEY ([IdExitEmployee]) REFERENCES [Payroll].[ExitEmployee] ([Id])
ALTER TABLE [Payroll].[ExitEmployeePayLine] DROP CONSTRAINT [FK_ExitEmployeePayLine_EmployeeExit]
ALTER TABLE [Payroll].[ExitEmployeePayLine] DROP COLUMN [IdEmployeeExit]
ALTER TABLE [Payroll].[ExitEmployeePayLine] ADD [IdExitEmployee] INT NOT NULL
ALTER TABLE [Payroll].[ExitEmployeePayLine] ADD CONSTRAINT [FK_ExitEmployeePayLine_EmployeeExit] FOREIGN KEY ([IdExitEmployee]) REFERENCES [Payroll].[ExitEmployee] ([Id])
ALTER TABLE [Payroll].[ExitEmailForEmployee] DROP CONSTRAINT [FK_ExitEmailForEmployee_EmployeeExit];
ALTER TABLE [RH].[Interview] DROP CONSTRAINT [FK_Interview_EmployeeExit];
ALTER TABLE [Payroll].[ExitEmailForEmployee] WITH NOCHECK
    ADD CONSTRAINT [FK_ExitEmailForEmployee_EmployeeExit] FOREIGN KEY ([IdExitEmployee]) REFERENCES [Payroll].[ExitEmployee] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE [RH].[Interview] WITH NOCHECK
    ADD CONSTRAINT [FK_Interview_EmployeeExit] FOREIGN KEY ([IdEmployeeExit]) REFERENCES [Payroll].[ExitEmployee] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE [Payroll].[ExitEmailForEmployee] WITH CHECK CHECK CONSTRAINT [FK_ExitEmailForEmployee_EmployeeExit];
ALTER TABLE [RH].[Interview] WITH CHECK CHECK CONSTRAINT [FK_Interview_EmployeeExit];

--- Rahma update skills table and insert counter for skills in codification table 19/11/2020

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [Payroll].[Skills] DROP CONSTRAINT [FK_Family_Skills]
UPDATE [ERPSettings].[Codification] SET [LastCounterValue]=N'0001' WHERE [Id]=304
UPDATE [Payroll].[Skills] SET [Code]=N'SK00000001' WHERE [Id]=1
UPDATE [Payroll].[Skills] SET [Code]=N'SK00000002' WHERE [Id]=2
UPDATE [Payroll].[Skills] SET [Code]=N'SK00000003' WHERE [Id]=3
UPDATE [Payroll].[Skills] SET [Code]=N'SK00000004' WHERE [Id]=4
UPDATE [Payroll].[Skills] SET [Code]=N'SK00000005' WHERE [Id]=5
UPDATE [Payroll].[Skills] SET [Code]=N'SK00000006' WHERE [Id]=6
UPDATE [Payroll].[Skills] SET [Code]=N'SK00000007' WHERE [Id]=9
GO
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (394, N'compteurSkills', 2, NULL, NULL, NULL, 137, 1, 1, N'00000007', 8)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [Payroll].[Skills]
    ADD CONSTRAINT [FK_Family_Skills] FOREIGN KEY ([Id_Family]) REFERENCES [Payroll].[SkillsFamily] ([Id])
COMMIT TRANSACTION


-- Narcisse: update exit employee config data

SET IDENTITY_INSERT [Payroll].[ExitAction] ON
INSERT INTO [Payroll].[ExitAction] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [Label], [Description]) VALUES (1, 0, NULL, NULL, N'TEAM_ACTION', N'DETAILS_OF_THE_TEAM')
INSERT INTO [Payroll].[ExitAction] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [Label], [Description]) VALUES (3, 0, NULL, NULL, N'SUPERVISOR_ACTION', N'DETAILS_OF_THE_TEAM')
INSERT INTO [Payroll].[ExitAction] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [Label], [Description]) VALUES (4, 0, NULL, NULL, N'CONTRACT_ACTION', N'DETAILS_CONTRACT')
INSERT INTO [Payroll].[ExitAction] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [Label], [Description]) VALUES (5, 0, NULL, NULL, N'DESACTIVATED_ACTION', N'DETAILS_DEACTIVATION')
SET IDENTITY_INSERT [Payroll].[ExitAction] OFF

DELETE FROM [ERPSettings].[Entity] where Id = 400

SET IDENTITY_INSERT [Payroll].[ExitAction] ON
INSERT INTO [ERPSettings].[Entity] ([TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (N'Payroll', N'ExitEmployee', N'ExitEmployee', NULL, 0, N'ExitEmployee', N'ExitEmployee', N'ExitEmployee', N'ExitEmployee', N'ExitEmployee', N'ExitEmployee', NULL, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[ExitAction] OFF
ALTER TABLE [RH].[Interview] WITH CHECK CHECK CONSTRAINT [FK_Interview_EmployeeExit];

--- Amine add CumulativeTaken and CumulativeAcquired column 17/11/2020 
ALTER TABLE [Payroll].[LeaveBalanceRemaining] DROP COLUMN [RemainingBalanceDay];
ALTER TABLE [Payroll].[LeaveBalanceRemaining] ADD [RemainingBalanceDay] float NOT NULL DEFAULT(0);
ALTER TABLE [Payroll].[LeaveBalanceRemaining] DROP COLUMN [RemainingBalanceHour];
ALTER TABLE [Payroll].[LeaveBalanceRemaining] ADD [RemainingBalanceHour] float NOT NULL DEFAULT(0);
ALTER TABLE [Payroll].[LeaveBalanceRemaining] ADD [CumulativeTaken] float NOT NULL DEFAULT(0);
ALTER TABLE [Payroll].[LeaveBalanceRemaining] ADD [CumulativeHoursTaken] float NOT NULL DEFAULT(0);
ALTER TABLE [Payroll].[LeaveBalanceRemaining] ADD [CumulativeAcquired] float NOT NULL DEFAULT(0);

-----Rabeb add creation date to exit employee ----

ALTER TABLE [Payroll].[ExitEmployee]
    ADD [CreationDate] DATE NOT NULL;