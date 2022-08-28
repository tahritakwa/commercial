--- Rabeb: 28/07/2020
GO
ALTER TABLE [Payroll].[Employee] ALTER COLUMN [Status] INT NULL;


GO
PRINT N'Altering [Payroll].[TransferOrder]...';


GO
ALTER TABLE [Payroll].[TransferOrder] DROP COLUMN [Number];


GO
ALTER TABLE [Payroll].[TransferOrder]
    ADD [Code] NVARCHAR (50) NULL;

GO
SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (401, N'Payroll', N'TransferOrder', N'TransferOrder', NULL, 0, N'TransferOrder', N'TransferOrder', N'TransferOrder', N'TransferOrder', N'TransferOrder', N'TransferOrder', NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (325, N'TransferOrdreCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (326, N'CaractereTO', 1, NULL, NULL, N'TO', 325, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (327, N'Caractere-', 3, NULL, NULL, N'-', 325, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (328, N'compteurTransfertOdre', 6, NULL, NULL, NULL, 325, 1, 1, N'0007', 4)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (330, N'Annee', 2, N'return (DateTime.Now.Year.ToString().Substring(2,2));', N'string', NULL, 325, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (331, N'Mois', 4, N'return (DateTime.Now.Month.ToString("d2"));', N'string', NULL, 325, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (332, N'Caractere-', 5, NULL, NULL, N'-', 325, 0, NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (66, 401, NULL, NULL, 325)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF

--- Donia add Code to Payslip session 28/07/2020
ALTER TABLE [Payroll].[Session] ADD Code NVARCHAR (50) NOT NULL DEFAULT (('0'));
ALTER TABLE [Payroll].[Session] DROP COLUMN Number;

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
GO
SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (402, N'Payroll', N'Session', N'Session', NULL, 0, N'Session', N'Session', N'Session', N'Session', N'Session', N'Session', NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (67, 402, NULL, NULL, 333)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (333, N'PayslipSessionCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (334, N'CaracterePS', 1, NULL, NULL, N'PS', 333, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (335, N'Year', 2, N'return (DateTime.Now.Year.ToString().Substring(2,2));', N'string', NULL, 333, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (336, N'Caractere-', 3, NULL, NULL, N'-', 333, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (337, N'Month', 4, N'return (DateTime.Now.Month.ToString("d2"));', N'string', NULL, 333, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (338, N'Caractere-', 5, NULL, NULL, N'-', 333, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (339, N'CounterPayslipSession', 6, NULL, NULL, NULL, 333, 1, 1, N'0001', 4)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
COMMIT TRANSACTION

--29/07/2020  Ahmed
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103104,N'Fabrication_config',N'Fabrication',0,null, 100404)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3120', N'Fabrication', 4, N'Fabrication', N'Fabrication', NULL, NULL, NULL, NULL, N'/Fabrication', 0, N'Fabrication')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103104, N'fd101f2f-5b91-4de3-9a07-337b4a3c3120', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227120D',N'Fabrication',NULL, 12,N'Fabrication',N'Fabrication',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227120D', 103104, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7120', N'fd101f2f-5b91-4de3-9a07-337b4a3c3120', N'51BF3865-133E-4E97-9F99-10562227120D')

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103105,N'Task_config',N'Task',0,null, 100404)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3121', N'Task', 4, N'Task', N'Task', NULL, NULL, NULL, NULL, N'/Task', 0, N'Task')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103105, N'fd101f2f-5b91-4de3-9a07-337b4a3c3121', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227121D',N'Task',NULL, 12,N'Task',N'Task',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227121D', 103105, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7121', N'fd101f2f-5b91-4de3-9a07-337b4a3c3121', N'51BF3865-133E-4E97-9F99-10562227121D')

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103106,N'TimeLine_config',N'Timeline',0,null, 100404)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3122', N'Timeline', 4, N'Timeline', N'Timeline', NULL, NULL, NULL, NULL, N'/Timeline', 0, N'Timeline')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103106, N'fd101f2f-5b91-4de3-9a07-337b4a3c3122', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227122D',N'Timeline',NULL, 12,N'Timeline',N'Timeline',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227122D', 103106, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7122', N'fd101f2f-5b91-4de3-9a07-337b4a3c3122', N'51BF3865-133E-4E97-9F99-10562227122D')

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103107,N'Calander_config',N'Calander',0,null, 100404)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3123', N'Calander', 4, N'Calander', N'Calander', NULL, NULL, NULL, NULL, N'/Calander', 0, N'Calander')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103107, N'fd101f2f-5b91-4de3-9a07-337b4a3c3123', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227123D',N'Calander',NULL, 12,N'Calander',N'Calander',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227123D', 103107, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7123', N'fd101f2f-5b91-4de3-9a07-337b4a3c3123', N'51BF3865-133E-4E97-9F99-10562227123D')

update ERPSettings.RoleConfig set IsDeleted=1 where Id =101101

delete from ERPSettings.ModuleConfig where Id in ( select Id from ERPSettings.ModuleConfig where IdModule in ('BEF67DB7-625D-41E7-99AE-E116177D04A1','24548E5D-76CC-4FC8-A7EE-02986B9274A7') and IdRoleConfig =77777)
delete from ERPSettings.ModuleConfig where Id in ( select Id from ERPSettings.ModuleConfig where IdModule = 'D8661332-0A12-4D10-98FE-4F7E5B91C6A8' and IdRoleConfig =77777)

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103108,N'Loanadvance_config',N'Prêts et avances',0,null, 100300)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3124', N'Loanadvance', 4, N'Loanadvance', N'Loanadvance', NULL, NULL, NULL, NULL, N'/Loanadvance', 0, N'Loanadvance')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103108, N'fd101f2f-5b91-4de3-9a07-337b4a3c3124', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227124D',N'Loanadvance',NULL, 12,N'Loanadvance',N'Loanadvance',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227124D', 103108, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7124', N'fd101f2f-5b91-4de3-9a07-337b4a3c3124', N'51BF3865-133E-4E97-9F99-10562227124D')

delete from ERPSettings.ModuleConfig where Id in ( select Id from ERPSettings.ModuleConfig where IdModule = '2F7D95D8-883A-445E-9EC2-3C4A70854F68' and IdRoleConfig =77777)

--- 23/07/2020 Amine Ben Ayed 
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList])
VALUES (N'589d24dd-72de-4588-9891-a620c2409e29', N'Payroll History', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 1, N'Payroll History', N'Payroll History', N'Payroll History', N'Payroll History', N'Payroll History', N'Payroll History', N'icon-note', 1)


--- Add functionnalities 
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) 
VALUES (N'95020697-9168-48f1-9d67-cf8b18a8f367', N'PayrollHistory-ADD', 1, N'PayrollHistory-ADD', N'PayrollHistory-ADD', NULL, NULL, NULL, NULL,NULL, 1, N'PayrollHistory-ADD')

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) 
VALUES (N'8abdd0ac-9b7f-44d8-8cb7-1ff822f4d8df', N'PayrollHistory-UPDATE', 1, N'PayrollHistory-UPDATE', N'PayrollHistory-UPDATE', NULL, NULL, NULL, NULL, NULL, 1, N'PayrollHistory-UPDATE')

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) 
VALUES (N'7eb32a97-5057-42bd-8978-bf4b34333345', N'PayrollHistory-DELETE', 1, N'PayrollHistory-DELETE', N'PayrollHistory-DELETE', NULL, NULL, NULL, NULL, NULL, 1, N'PayrollHistory-DELETE')

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) 
VALUES (N'41f5a821-ebc9-47d7-a5eb-403d75a3a639', N'PayrollHistory-SHOW', 1, N'PayrollHistory-SHOW', N'PayrollHistory-SHOW', NULL, NULL, NULL, NULL, NULL, 1, N'PayrollHistory-SHOW')

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) 
VALUES (N'11a54559-a008-4bd7-9ace-05a0840bc70e', N'PayrollHistory-LIST', 1, N'PayrollHistory-LIST', N'PayrollHistory-LIST', NULL, NULL, NULL, NULL, NULL, 1, N'PayrollHistory-LIST')

--- Add link between modules and functionnalities
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) 
VALUES (N'353f270f-a977-4ed5-9f25-675f1b209408', N'95020697-9168-48f1-9d67-cf8b18a8f367', N'589d24dd-72de-4588-9891-a620c2409e29')

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) 
VALUES (N'a13b020c-6e71-46e8-b8ad-0a8e99ff99a3', N'8abdd0ac-9b7f-44d8-8cb7-1ff822f4d8df', N'589d24dd-72de-4588-9891-a620c2409e29')

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) 
VALUES (N'837d4c5a-b308-4134-8ae7-ed2eba831f00', N'7eb32a97-5057-42bd-8978-bf4b34333345', N'589d24dd-72de-4588-9891-a620c2409e29')

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) 
VALUES (N'e2a2bc76-6c25-4f78-ba8d-dcc4ff0fc5e6', N'41f5a821-ebc9-47d7-a5eb-403d75a3a639', N'589d24dd-72de-4588-9891-a620c2409e29')

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) 
VALUES (N'2afb089c-39f8-434c-ae46-47b8400d8ece', N'11a54559-a008-4bd7-9ace-05a0840bc70e', N'589d24dd-72de-4588-9891-a620c2409e29')


SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101104, N'Historique de paie', N'Historique de paie', 0, NULL, 100300)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

SET IDENTITY_INSERT [ERPSettings].[ModuleConfig] ON
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1676, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101104, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1677, N'589d24dd-72de-4588-9891-a620c2409e29', 101104, 1)
SET IDENTITY_INSERT [ERPSettings].[ModuleConfig] OFF

SET IDENTITY_INSERT [ERPSettings].[FunctionalityConfig] ON
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8206, 101104, N'11a54559-a008-4bd7-9ace-05a0840bc70e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8207, 101104, N'8abdd0ac-9b7f-44d8-8cb7-1ff822f4d8df', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8208, 101104, N'41f5a821-ebc9-47d7-a5eb-403d75a3a639', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8209, 101104, N'7eb32a97-5057-42bd-8978-bf4b34333345', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8210, 101104, N'95020697-9168-48f1-9d67-cf8b18a8f367', 1)
SET IDENTITY_INSERT [ERPSettings].[FunctionalityConfig] OFF

SET IDENTITY_INSERT [ERPSettings].[RoleConfigByRole] ON
INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (1048, 101104, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (1121, 101104, 100002, 1, 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[RoleConfigByRole] OFF
--- Amine Ben Ayed 28/07/2020

ALTER TABLE [ERPSettings].[User]
DROP CONSTRAINT FK_User_Employee;

ALTER TABLE [ERPSettings].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id]) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE [Payroll].[JobEmployee]
DROP CONSTRAINT FK_JobEmployee_Employee;

ALTER TABLE [Payroll].[JobEmployee] WITH NOCHECK ADD CONSTRAINT [FK_JobEmployee_Employee] FOREIGN KEY ([IdEmployee]) 
REFERENCES [Payroll].[Employee] ([Id]) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE  [Payroll].[EmployeeExit]
DROP CONSTRAINT FK_EmployeeExit_Employee;

alter table [Payroll].[EmployeeExit]
WITH NOCHECK ADD CONSTRAINT [FK_EmployeeExit_Employee] FOREIGN KEY ([IdEmployee]) 
REFERENCES [Payroll].[Employee] ([Id]) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE  [Payroll].[ActionExitEmployee]
DROP CONSTRAINT FK_ActionExitEmployee_EmployeeExit;
ALTER TABLE [Payroll].[ActionExitEmployee] WITH NOCHECK
    ADD CONSTRAINT [FK_ActionExitEmployee_EmployeeExit] FOREIGN KEY ([IdEmployeeExit]) REFERENCES [Payroll].[EmployeeExit] ([Id]) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE  [Payroll].[EmployeeTeam] 
DROP CONSTRAINT FK_EmployeeTeam_Employee;
alter table [Payroll].[EmployeeTeam] 
add CONSTRAINT [FK_EmployeeTeam_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]) ON UPDATE CASCADE ON DELETE CASCADE;

--- Donia add Code to Cnss declaration 29/07/2020
ALTER TABLE [Payroll].[CnssDeclaration] ADD Code NVARCHAR (50) NOT NULL DEFAULT (('0'));
ALTER TABLE [Payroll].[CnssDeclaration] DROP COLUMN DeclarationNumber;

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
GO
SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (403, N'Payroll', N'CnssDeclaration', N'CnssDeclaration', NULL, 0, N'CnssDeclaration', N'CnssDeclaration', N'CnssDeclaration', N'CnssDeclaration', N'CnssDeclaration', N'CnssDeclaration', NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (68, 403, NULL, NULL, 340)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (340, N'CnssDeclarationCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (341, N'CaractereCD', 1, NULL, NULL, N'CD', 340, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (342, N'Year', 2, N'return (DateTime.Now.Year.ToString().Substring(2,2));', N'string', NULL, 340, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (343, N'Caractere-', 3, NULL, NULL, N'-', 340, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (344, N'Month', 4, N'return (DateTime.Now.Month.ToString("d2"));', N'string', NULL, 340, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (345, N'Caractere-', 5, NULL, NULL, N'-', 340, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (346, N'CounterCnssDeclaration', 6, NULL, NULL, NULL, 340, 1, 1, N'0003', 4)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
COMMIT TRANSACTION

--- Donia drop declaration number, add code and cnss declaration table 30/07/2020
ALTER TABLE [Sales].[BillingSession] DROP COLUMN [Number], COLUMN [SessionNumber];
ALTER TABLE [Sales].[BillingSession] ADD [Code] NVARCHAR (50) NOT NULL DEFAULT (('0'));
CREATE TABLE [Payroll].[CnssDeclarationSession] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdSession]         INT            NOT NULL,
    [IdCnssDeclaration] INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_CnssDeclarationSession] PRIMARY KEY CLUSTERED ([Id] ASC)
);
ALTER TABLE [Payroll].[CnssDeclarationSession] WITH NOCHECK
    ADD CONSTRAINT [FK_CnssDeclarationSession_CnssDeclaration] FOREIGN KEY ([IdCnssDeclaration]) REFERENCES [Payroll].[CnssDeclaration] ([Id]) ON DELETE CASCADE;
ALTER TABLE [Payroll].[CnssDeclarationSession] WITH NOCHECK
    ADD CONSTRAINT [FK_CnssDeclarationSession_Session] FOREIGN KEY ([IdSession]) REFERENCES [Payroll].[Session] ([Id]);
ALTER TABLE [Payroll].[CnssDeclarationSession] WITH CHECK CHECK CONSTRAINT [FK_CnssDeclarationSession_CnssDeclaration];
ALTER TABLE [Payroll].[CnssDeclarationSession] WITH CHECK CHECK CONSTRAINT [FK_CnssDeclarationSession_Session];

--- Donia add billing session codification 30/07/2020
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
GO
SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (406, N'Sales', N'BillingSession', N'BillingSession', NULL, 0, N'BillingSession', N'BillingSession', N'BillingSession', N'BillingSession', N'BillingSession', N'BillingSession', NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (69, 406, NULL, NULL, 347)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (347, N'BillingSessionCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (348, N'CaractereBS', 1, NULL, NULL, N'BS', 347, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (349, N'Year', 2, N'return (DateTime.Now.Year.ToString().Substring(2,2));', N'string', NULL, 347, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (350, N'Caractere-', 3, NULL, NULL, N'-', 347, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (351, N'Month', 4, N'return (DateTime.Now.Month.ToString("d2"));', N'string', NULL, 347, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (352, N'Caractere-', 5, NULL, NULL, N'-', 347, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (353, N'CounterBillingSession', 6, NULL, NULL, NULL, 347, 1, 1, N'0003', 4)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
COMMIT TRANSACTION
-- kossi atler table Shared.BankAccount 03/08/2020
GO  
EXEC sp_rename 'Shared.BankAccount.Agence', 'Agency', 'COLUMN';

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103109,N'OEM_config',N'OEM',0,null, 22222)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3125', N'OEM', 4, N'OEM', N'OEM', NULL, NULL, NULL, NULL, N'/OEM', 0, N'OEM')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103109, N'fd101f2f-5b91-4de3-9a07-337b4a3c3125', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227125D',N'OEM',NULL, 12,N'OEM',N'OEM',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227125D', 103109, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7125', N'fd101f2f-5b91-4de3-9a07-337b4a3c3125', N'51BF3865-133E-4E97-9F99-10562227125D')


SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103110,N'movement-history_config',N'Historique de mouvements',0,null, 22222)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3126', N'movement-history', 4, N'movement-history', N'movement-history', NULL, NULL, NULL, NULL, N'/movement-history', 0, N'movement-history')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103110, N'fd101f2f-5b91-4de3-9a07-337b4a3c3126', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227126D',N'movement-history',NULL, 12,N'movement-history',N'movement-history',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227126D', 103110, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7126', N'fd101f2f-5b91-4de3-9a07-337b4a3c3126', N'51BF3865-133E-4E97-9F99-10562227126D')

-- Mohamed BOUZIDI ADD [ActivityArea] 
GO
ALTER TABLE [Shared].[Company]
    ADD [ActivityArea] [int] NOT NULL DEFAULT ((1));

-- chedi add columns to address and tiers for crm


GO
ALTER TABLE [Sales].[Tiers]
    ADD [ActivitySector] NVARCHAR (50) NULL,
        [LeadSource]     NVARCHAR (50) NULL;




GO
ALTER TABLE [Shared].[Address]
    ADD [PrincipalAddress] NVARCHAR (255) NULL,
        [Region]           NVARCHAR (50)  NULL;




--- Rabeb 06/08/2020: Add SourceDeductionSession codification

	GO
ALTER TABLE [Payroll].[SourceDeductionSession]
    ADD [Code] NVARCHAR (50) NOT NULL;

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
GO
SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (407, N'Payroll', N'SourceDeductionSession', N'SourceDeductionSession', NULL, 0, N'SourceDeductionSession', N'SourceDeductionSession', N'SourceDeductionSession', N'SourceDeductionSession', N'SourceDeductionSession', N'SourceDeductionSession', NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (359, N'SourceDeductionSessionCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (360, N'CaractereSD', 1, NULL, NULL, N'SD', 359, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (361, N'Annee', 2, N'return (DateTime.Now.Year.ToString().Substring(2,2));', N'string', NULL, 359, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (362, N'Caractere-', 3, NULL, NULL, N'-', 359, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (363, N'compteurSourceDeduction', 4, NULL, NULL, NULL, 359, 1, 1, N'0000', 4)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (72, 407, NULL, NULL, 359)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF

ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
COMMIT TRANSACTION

GO
ALTER TABLE [Payroll].[SourceDeductionSession] DROP COLUMN [Number]

--chedi 07-08-2020: add labels to address and contact

GO
ALTER TABLE [Shared].[Address]
    ADD [Label] NVARCHAR (50) NULL;

GO
ALTER TABLE [Shared].[Contact]
    ADD [Label] NVARCHAR (50) NULL;

GO

--10/08/2020  Ahmed : Ecommerce 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101102, N'ED8409DB-EEED-4915-9B3B-A650F0EB3AEA', 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7145', N'ED8409DB-EEED-4915-9B3B-A650F0EB3AEA', N'51BF3865-133E-4E97-9F99-14564687942D')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101102, N'2806F1CD-9742-4811-AFF4-1BA3268CA6E2', 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7146', N'2806F1CD-9742-4811-AFF4-1BA3268CA6E2', N'51BF3865-133E-4E97-9F99-14564687942D')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101102, N'D84DD72D-7B49-42A8-8C05-F7AC1B89E292', 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7147', N'D84DD72D-7B49-42A8-8C05-F7AC1B89E292', N'51BF3865-133E-4E97-9F99-14564687942D')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101102, N'15BE47D8-F94E-4512-9077-AD9CACB9E204', 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7148', N'15BE47D8-F94E-4512-9077-AD9CACB9E204', N'51BF3865-133E-4E97-9F99-14564687942D')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101102, N'04C4AE31-23CA-4CF1-8057-C596D605FF56', 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7149', N'04C4AE31-23CA-4CF1-8057-C596D605FF56', N'51BF3865-133E-4E97-9F99-14564687942D')

-- Ahmed 11/08/2020 : CRM

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3165', N'CRM', 4, N'CRM', N'CRM', NULL, NULL, NULL, NULL, N'/CRM', 0, N'CRM')

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101016, N'fd101f2f-5b91-4de3-9a07-337b4a3c3165', 1)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7165', N'fd101f2f-5b91-4de3-9a07-337b4a3c3165', N'79CE368B-AD81-4973-AAE7-FF402F34CFBF')

--Ahmed 12/08/2020 Ahmed : Ecommerce
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES
( 101102, N'37A20E5C-61CE-4CBF-B8A4-F7DD46466E41', 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7175', N'37A20E5C-61CE-4CBF-B8A4-F7DD46466E41', N'51BF3865-133E-4E97-9F99-14564687942D')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES
( 101102, N'997B0595-B07B-49EE-9999-51AD34CD289A', 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7176', N'997B0595-B07B-49EE-9999-51AD34CD289A', N'51BF3865-133E-4E97-9F99-14564687942D')



-- Narcisse: CRM test data 10/08/2020

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[UserRole] DROP CONSTRAINT [FK_UserRole_Role]
ALTER TABLE [ERPSettings].[UserRole] DROP CONSTRAINT [FK_UserRole_User]
ALTER TABLE [Payroll].[BaseSalary] DROP CONSTRAINT [FK_BaseSalary_Contract]
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_ContractType]
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_Employee]
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_Cnss]
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_SalaryStructure]
ALTER TABLE [Payroll].[EmployeeDocument] DROP CONSTRAINT [FK_EmployeeDocument_Employee]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_City]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Country]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Grade]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_UpperHierarchy]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Citizenship]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_PaymentType]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Office]
ALTER TABLE [ERPSettings].[User] DROP CONSTRAINT [FK_User_Employee]
ALTER TABLE [ERPSettings].[User] DROP CONSTRAINT [FK_User_User]
ALTER TABLE [ERPSettings].[User] DROP CONSTRAINT [FK_User_Tiers]
UPDATE [ERPSettings].[UserRole] SET [IsDeleted]=1, [Deleted_Token]=N'4bf82fb4-3c22-46db-a1d5-50cddfda7676' WHERE [Id]=33
UPDATE [Payroll].[Employee] SET [IsDeleted]=1, [Deleted_Token]=N'4c7dc9ed-a952-4134-9c91-301cfc6bee58' WHERE [Id]=48
UPDATE [ERPSettings].[User] SET [IsDeleted]=1, [Deleted_Token]=N'6251d6ae-04c1-41c6-8441-d9f7e93ab140' WHERE [Id]=16
UPDATE [ERPSettings].[User] SET [IdEmployee]=56 WHERE [Id]=51
GO
SET IDENTITY_INSERT [ERPSettings].[User] ON
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee], [IsBToB], [IdTiers], [Role], [IsTecDoc], [IsActif]) VALUES (53, N'Néjia', N'RJILI', NULL, N'80c3df7ac08507cebdffdaed555e23e95527fa111c64af26cdd8f5c2217d7e6e9e43c56e46b25e9a23fadfd5ee0a2f393bfff91016ac21d8b976c97605fb771b', NULL, N'', N'', N'', N'nejia.rjili@spark-it.tn', NULL, NULL, 0, 0, NULL, NULL, N'fr', 50, NULL, NULL, NULL, 0, 1)
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee], [IsBToB], [IdTiers], [Role], [IsTecDoc], [IsActif]) VALUES (54, N'Marwa', N'LTAIEF', NULL, N'80c3df7ac08507cebdffdaed555e23e95527fa111c64af26cdd8f5c2217d7e6e9e43c56e46b25e9a23fadfd5ee0a2f393bfff91016ac21d8b976c97605fb771b', NULL, N'', N'', N'', N'marwa.ltaief@spark-it.tn', NULL, NULL, 0, 0, NULL, NULL, N'fr', 51, NULL, NULL, NULL, 0, 1)
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee], [IsBToB], [IdTiers], [Role], [IsTecDoc], [IsActif]) VALUES (55, N'Houda', N'Atallah', NULL, N'80c3df7ac08507cebdffdaed555e23e95527fa111c64af26cdd8f5c2217d7e6e9e43c56e46b25e9a23fadfd5ee0a2f393bfff91016ac21d8b976c97605fb771b', NULL, N'', N'', N'', N'houda.atallah@spark-it.tn', NULL, NULL, 0, 0, NULL, NULL, N'fr', 52, NULL, NULL, NULL, 0, 1)
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee], [IsBToB], [IdTiers], [Role], [IsTecDoc], [IsActif]) VALUES (56, N'Mohamed Amin', N'Daoud', NULL, N'80c3df7ac08507cebdffdaed555e23e95527fa111c64af26cdd8f5c2217d7e6e9e43c56e46b25e9a23fadfd5ee0a2f393bfff91016ac21d8b976c97605fb771b', NULL, N'', N'', N'', N'amine.daoud@spark-it.tn', NULL, NULL, 0, 0, NULL, NULL, N'fr', 53, NULL, NULL, NULL, 0, 1)
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee], [IsBToB], [IdTiers], [Role], [IsTecDoc], [IsActif]) VALUES (57, N'Jassem', N'Kochbati', NULL, N'80c3df7ac08507cebdffdaed555e23e95527fa111c64af26cdd8f5c2217d7e6e9e43c56e46b25e9a23fadfd5ee0a2f393bfff91016ac21d8b976c97605fb771b', NULL, N'', N'', N'', N'jaccem.kochbati@spark-it.tn', NULL, NULL, 0, 0, NULL, NULL, N'fr', 54, NULL, NULL, NULL, 0, 1)
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee], [IsBToB], [IdTiers], [Role], [IsTecDoc], [IsActif]) VALUES (58, N'Mohamed Ali', N'Bourguiba', NULL, N'80c3df7ac08507cebdffdaed555e23e95527fa111c64af26cdd8f5c2217d7e6e9e43c56e46b25e9a23fadfd5ee0a2f393bfff91016ac21d8b976c97605fb771b', NULL, N'', N'', N'', N'mohamedali.bourguiba@spark-it.tn', NULL, NULL, 0, 0, NULL, NULL, N'fr', 55, NULL, NULL, NULL, 0, 1)
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee], [IsBToB], [IdTiers], [Role], [IsTecDoc], [IsActif]) VALUES (59, N'DoNot', N'Reply', NULL, N'80c3df7ac08507cebdffdaed555e23e95527fa111c64af26cdd8f5c2217d7e6e9e43c56e46b25e9a23fadfd5ee0a2f393bfff91016ac21d8b976c97605fb771b', NULL, N'', N'', N'', N'donotreply@spark-it.tn', NULL, NULL, 0, 0, NULL, NULL, N'fr', 57, NULL, NULL, NULL, 0, 1)
SET IDENTITY_INSERT [ERPSettings].[User] OFF
GO
SET IDENTITY_INSERT [Payroll].[Employee] ON
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon], [CinAttached], [HomeLoan], [ChildrenNoScholar], [ChildrenDisabled], [IsForeign], [DependentParent], [Picture], [Rib], [Bank], [ResignationDate], [ResignationDepositDate], [IdCitizenship], [IdPaymentType], [SharedDocumentsPassword], [PersonalEmail], [IdOffice], [Status], [HierarchyLevel], [MaritalStatus]) VALUES (50, 2, N'Néjia', N'RJILI', N'nejia.rjili@spark-it.tn', N'143', N'', N'', N'', N'', N'', NULL, NULL, N'', N'', N'', NULL, N'', NULL, N'', N'', N'', NULL, 0, 0, NULL, NULL, NULL, NULL, '20200101', N'', N'', 0, NULL, N'Payrool\Employee\NéjiaRJILI\1fa0cceb-f5df-4a08-9d84-2c3fc5f2f8c2', NULL, NULL, NULL, 0, NULL, NULL, N'', N'', NULL, NULL, 235, NULL, NULL, N'', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon], [CinAttached], [HomeLoan], [ChildrenNoScholar], [ChildrenDisabled], [IsForeign], [DependentParent], [Picture], [Rib], [Bank], [ResignationDate], [ResignationDepositDate], [IdCitizenship], [IdPaymentType], [SharedDocumentsPassword], [PersonalEmail], [IdOffice], [Status], [HierarchyLevel], [MaritalStatus]) VALUES (51, 2, N'Marwa', N'LTAIEF', N'marwa.ltaief@spark-it.tn', N'144', N'', N'', N'', N'', N'', NULL, NULL, N'', N'', N'', NULL, N'', NULL, N'', N'', N'', NULL, 0, 0, NULL, NULL, NULL, NULL, '20200101', N'', N'', 0, NULL, N'Payrool\Employee\MarwaLTAIEF\6983afce-5407-441a-a790-5392e0f2aa04', NULL, NULL, NULL, 0, NULL, NULL, N'', N'', NULL, NULL, 235, NULL, NULL, N'', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon], [CinAttached], [HomeLoan], [ChildrenNoScholar], [ChildrenDisabled], [IsForeign], [DependentParent], [Picture], [Rib], [Bank], [ResignationDate], [ResignationDepositDate], [IdCitizenship], [IdPaymentType], [SharedDocumentsPassword], [PersonalEmail], [IdOffice], [Status], [HierarchyLevel], [MaritalStatus]) VALUES (52, 2, N'Houda', N'Atallah', N'houda.atallah@spark-it.tn', N'145', N'', N'', N'', N'', N'', NULL, NULL, N'', N'', N'', NULL, N'', NULL, N'', N'', N'', NULL, 0, 0, NULL, NULL, NULL, NULL, '20200101', N'', N'', 0, NULL, N'Payrool\Employee\HoudaAtallah\c8e1a78b-f1b4-40d2-9421-ef288aa28fa6', NULL, NULL, NULL, 0, NULL, NULL, N'', N'', NULL, NULL, 235, NULL, NULL, N'', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon], [CinAttached], [HomeLoan], [ChildrenNoScholar], [ChildrenDisabled], [IsForeign], [DependentParent], [Picture], [Rib], [Bank], [ResignationDate], [ResignationDepositDate], [IdCitizenship], [IdPaymentType], [SharedDocumentsPassword], [PersonalEmail], [IdOffice], [Status], [HierarchyLevel], [MaritalStatus]) VALUES (53, 1, N'Mohamed Amin', N'Daoud', N'amine.daoud@spark-it.tn', N'146', N'', N'', N'', N'', N'', NULL, NULL, N'', N'', N'', NULL, N'', NULL, N'', N'', N'', NULL, 0, 0, NULL, NULL, NULL, NULL, '20200101', N'', N'', 0, NULL, N'Payrool\Employee\Mohamed AminDaoud\347455ba-1233-4fc7-9239-9330801568d9', NULL, NULL, NULL, 0, NULL, NULL, N'', N'', NULL, NULL, 235, NULL, NULL, N'', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon], [CinAttached], [HomeLoan], [ChildrenNoScholar], [ChildrenDisabled], [IsForeign], [DependentParent], [Picture], [Rib], [Bank], [ResignationDate], [ResignationDepositDate], [IdCitizenship], [IdPaymentType], [SharedDocumentsPassword], [PersonalEmail], [IdOffice], [Status], [HierarchyLevel], [MaritalStatus]) VALUES (54, 1, N'Jassem', N'Kochbati', N'jaccem.kochbati@spark-it.tn', N'147', N'', N'', N'', N'', N'', NULL, NULL, N'', N'', N'', NULL, N'', NULL, N'', N'', N'', NULL, 0, 0, NULL, NULL, NULL, NULL, '20200101', N'', N'', 0, NULL, N'Payrool\Employee\JassemKochbati\0d75fcc7-0bbf-4326-9a5e-6e6faf905cb5', NULL, NULL, NULL, 0, NULL, NULL, N'', N'', NULL, NULL, 235, NULL, NULL, N'', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon], [CinAttached], [HomeLoan], [ChildrenNoScholar], [ChildrenDisabled], [IsForeign], [DependentParent], [Picture], [Rib], [Bank], [ResignationDate], [ResignationDepositDate], [IdCitizenship], [IdPaymentType], [SharedDocumentsPassword], [PersonalEmail], [IdOffice], [Status], [HierarchyLevel], [MaritalStatus]) VALUES (55, 1, N'Mohamed Ali', N'Bourguiba', N'mohamedali.bourguiba@spark-it.tn', N'148', N'', N'', N'', N'', N'', NULL, NULL, N'', N'', N'', NULL, N'', NULL, N'', N'', N'', NULL, 0, 0, NULL, NULL, NULL, NULL, '20200101', N'', N'', 0, NULL, N'Payrool\Employee\Mohamed AliBourguiba\a252bbef-b93d-419f-9121-b9d0cbb28661', NULL, NULL, NULL, 0, NULL, NULL, N'', N'', NULL, NULL, 235, NULL, NULL, N'', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon], [CinAttached], [HomeLoan], [ChildrenNoScholar], [ChildrenDisabled], [IsForeign], [DependentParent], [Picture], [Rib], [Bank], [ResignationDate], [ResignationDepositDate], [IdCitizenship], [IdPaymentType], [SharedDocumentsPassword], [PersonalEmail], [IdOffice], [Status], [HierarchyLevel], [MaritalStatus]) VALUES (56, 1, N'Houssem', N'Ben Mustafa', N'houssem.benmustapha@spark-it.tn', N'149', N'', N'', N'', N'', N'', NULL, NULL, N'', N'', N'', NULL, N'', NULL, N'', N'', N'', NULL, 0, 0, NULL, NULL, NULL, NULL, '20200101', N'', N'', 0, NULL, N'Payrool\Employee\HoussemBen Mustafa\04ccb862-7d32-40dc-a357-760f065ff53d', NULL, NULL, NULL, 0, NULL, NULL, N'', N'', NULL, NULL, 235, NULL, NULL, N'', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon], [CinAttached], [HomeLoan], [ChildrenNoScholar], [ChildrenDisabled], [IsForeign], [DependentParent], [Picture], [Rib], [Bank], [ResignationDate], [ResignationDepositDate], [IdCitizenship], [IdPaymentType], [SharedDocumentsPassword], [PersonalEmail], [IdOffice], [Status], [HierarchyLevel], [MaritalStatus]) VALUES (57, 3, N'DoNot', N'Reply', N'donotreply@spark-it.tn', N'150', N'', N'', N'', N'', N'', NULL, NULL, N'', N'', N'', NULL, N'', NULL, N'', N'', N'', NULL, 0, 0, NULL, NULL, NULL, NULL, '20200101', N'', N'', 0, NULL, N'Payrool\Employee\DoNotReply\ff66400b-9dd9-4b4c-bdb4-d4b924857afe', NULL, NULL, NULL, 0, NULL, NULL, N'', N'', NULL, NULL, 235, NULL, NULL, N'', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[Employee] OFF
GO
SET IDENTITY_INSERT [Payroll].[EmployeeDocument] ON
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'PASSPORT_NUMBER', 1, NULL, 50, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (6, N'WORK_AUTHORIZATION_NUMBER', 2, NULL, 50, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (7, N'VISA_NUMBER', 3, NULL, 50, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (8, N'RESIDENCE_PERMIT_NUMBER', 4, NULL, 50, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (9, N'PASSPORT_NUMBER', 1, NULL, 51, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (10, N'WORK_AUTHORIZATION_NUMBER', 2, NULL, 51, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (11, N'VISA_NUMBER', 3, NULL, 51, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (12, N'RESIDENCE_PERMIT_NUMBER', 4, NULL, 51, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (13, N'PASSPORT_NUMBER', 1, NULL, 52, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (14, N'WORK_AUTHORIZATION_NUMBER', 2, NULL, 52, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (15, N'VISA_NUMBER', 3, NULL, 52, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (16, N'RESIDENCE_PERMIT_NUMBER', 4, NULL, 52, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (17, N'PASSPORT_NUMBER', 1, NULL, 53, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (18, N'WORK_AUTHORIZATION_NUMBER', 2, NULL, 53, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (19, N'VISA_NUMBER', 3, NULL, 53, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (20, N'RESIDENCE_PERMIT_NUMBER', 4, NULL, 53, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (21, N'PASSPORT_NUMBER', 1, NULL, 54, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (22, N'WORK_AUTHORIZATION_NUMBER', 2, NULL, 54, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (23, N'VISA_NUMBER', 3, NULL, 54, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (24, N'RESIDENCE_PERMIT_NUMBER', 4, NULL, 54, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (25, N'PASSPORT_NUMBER', 1, NULL, 55, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (26, N'WORK_AUTHORIZATION_NUMBER', 2, NULL, 55, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (27, N'VISA_NUMBER', 3, NULL, 55, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (28, N'RESIDENCE_PERMIT_NUMBER', 4, NULL, 55, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (29, N'PASSPORT_NUMBER', 1, NULL, 56, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (30, N'WORK_AUTHORIZATION_NUMBER', 2, NULL, 56, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (31, N'VISA_NUMBER', 3, NULL, 56, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (32, N'RESIDENCE_PERMIT_NUMBER', 4, NULL, 56, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (33, N'PASSPORT_NUMBER', 1, NULL, 57, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (34, N'WORK_AUTHORIZATION_NUMBER', 2, NULL, 57, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (35, N'VISA_NUMBER', 3, NULL, 57, NULL, NULL, 1, 0, 0, NULL)
INSERT INTO [Payroll].[EmployeeDocument] ([Id], [Label], [Type], [Value], [IdEmployee], [AttachedFile], [ExpirationDate], [IsPermanent], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (36, N'RESIDENCE_PERMIT_NUMBER', 4, NULL, 57, NULL, NULL, 1, 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[EmployeeDocument] OFF
GO
SET IDENTITY_INSERT [Payroll].[Contract] ON
INSERT INTO [Payroll].[Contract] ([Id], [ContractReference], [StartDate], [EndDate], [WorkingTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdEmployee], [IdSalaryStructure], [IdCnss], [ContractAttached], [IdContractType], [State]) VALUES (17, N'', '20200101', NULL, NULL, 0, 0, NULL, 50, 5, 1, NULL, 1, 2)
INSERT INTO [Payroll].[Contract] ([Id], [ContractReference], [StartDate], [EndDate], [WorkingTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdEmployee], [IdSalaryStructure], [IdCnss], [ContractAttached], [IdContractType], [State]) VALUES (18, N'', '20200101', NULL, NULL, 0, 0, NULL, 51, 5, 1, NULL, 1, 2)
INSERT INTO [Payroll].[Contract] ([Id], [ContractReference], [StartDate], [EndDate], [WorkingTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdEmployee], [IdSalaryStructure], [IdCnss], [ContractAttached], [IdContractType], [State]) VALUES (19, N'', '20200101', NULL, NULL, 0, 0, NULL, 52, 5, 1, NULL, 1, 2)
INSERT INTO [Payroll].[Contract] ([Id], [ContractReference], [StartDate], [EndDate], [WorkingTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdEmployee], [IdSalaryStructure], [IdCnss], [ContractAttached], [IdContractType], [State]) VALUES (20, N'', '20200101', NULL, NULL, 0, 0, NULL, 53, 5, 1, NULL, 1, 2)
INSERT INTO [Payroll].[Contract] ([Id], [ContractReference], [StartDate], [EndDate], [WorkingTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdEmployee], [IdSalaryStructure], [IdCnss], [ContractAttached], [IdContractType], [State]) VALUES (21, N'', '20200101', NULL, NULL, 0, 0, NULL, 54, 5, 1, NULL, 1, 2)
INSERT INTO [Payroll].[Contract] ([Id], [ContractReference], [StartDate], [EndDate], [WorkingTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdEmployee], [IdSalaryStructure], [IdCnss], [ContractAttached], [IdContractType], [State]) VALUES (22, N'', '20200101', NULL, NULL, 0, 0, NULL, 55, 5, 1, NULL, 1, 2)
INSERT INTO [Payroll].[Contract] ([Id], [ContractReference], [StartDate], [EndDate], [WorkingTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdEmployee], [IdSalaryStructure], [IdCnss], [ContractAttached], [IdContractType], [State]) VALUES (23, N'', '20200101', NULL, NULL, 0, 0, NULL, 56, 5, 1, NULL, 1, 2)
INSERT INTO [Payroll].[Contract] ([Id], [ContractReference], [StartDate], [EndDate], [WorkingTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdEmployee], [IdSalaryStructure], [IdCnss], [ContractAttached], [IdContractType], [State]) VALUES (24, N'', '20200101', NULL, NULL, 0, 0, NULL, 57, 5, 1, NULL, 1, 2)
SET IDENTITY_INSERT [Payroll].[Contract] OFF
GO
SET IDENTITY_INSERT [Payroll].[BaseSalary] ON
INSERT INTO [Payroll].[BaseSalary] ([Id], [IdContract], [IsDeleted], [TransactionUserId], [Deleted_Token], [Value], [StartDate]) VALUES (15, 17, 0, 0, NULL, 1000, '20200101')
INSERT INTO [Payroll].[BaseSalary] ([Id], [IdContract], [IsDeleted], [TransactionUserId], [Deleted_Token], [Value], [StartDate]) VALUES (16, 18, 0, 0, NULL, 1000, '20200101')
INSERT INTO [Payroll].[BaseSalary] ([Id], [IdContract], [IsDeleted], [TransactionUserId], [Deleted_Token], [Value], [StartDate]) VALUES (17, 19, 0, 0, NULL, 1000, '20200101')
INSERT INTO [Payroll].[BaseSalary] ([Id], [IdContract], [IsDeleted], [TransactionUserId], [Deleted_Token], [Value], [StartDate]) VALUES (18, 20, 0, 0, NULL, 1000, '20200101')
INSERT INTO [Payroll].[BaseSalary] ([Id], [IdContract], [IsDeleted], [TransactionUserId], [Deleted_Token], [Value], [StartDate]) VALUES (19, 21, 0, 0, NULL, 1000, '20200101')
INSERT INTO [Payroll].[BaseSalary] ([Id], [IdContract], [IsDeleted], [TransactionUserId], [Deleted_Token], [Value], [StartDate]) VALUES (20, 22, 0, 0, NULL, 1000, '20200101')
INSERT INTO [Payroll].[BaseSalary] ([Id], [IdContract], [IsDeleted], [TransactionUserId], [Deleted_Token], [Value], [StartDate]) VALUES (21, 23, 0, 0, NULL, 1000, '20200101')
INSERT INTO [Payroll].[BaseSalary] ([Id], [IdContract], [IsDeleted], [TransactionUserId], [Deleted_Token], [Value], [StartDate]) VALUES (22, 24, 0, 0, NULL, 1000, '20200101')
SET IDENTITY_INSERT [Payroll].[BaseSalary] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[UserRole] ON
INSERT INTO [ERPSettings].[UserRole] ([Id], [IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (63, 100007, 53, 0, 0, NULL)
INSERT INTO [ERPSettings].[UserRole] ([Id], [IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (64, 100007, 54, 0, 0, NULL)
INSERT INTO [ERPSettings].[UserRole] ([Id], [IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (65, 100007, 55, 0, 0, NULL)
INSERT INTO [ERPSettings].[UserRole] ([Id], [IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (66, 100007, 56, 0, 0, NULL)
INSERT INTO [ERPSettings].[UserRole] ([Id], [IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (67, 100007, 57, 0, 0, NULL)
INSERT INTO [ERPSettings].[UserRole] ([Id], [IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (68, 100007, 58, 0, 0, NULL)
INSERT INTO [ERPSettings].[UserRole] ([Id], [IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (69, 100007, 59, 0, 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[UserRole] OFF
ALTER TABLE [ERPSettings].[UserRole]
    ADD CONSTRAINT [FK_UserRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[UserRole]
    ADD CONSTRAINT [FK_UserRole_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payroll].[BaseSalary]
    ADD CONSTRAINT [FK_BaseSalary_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payroll].[Contract]
    ADD CONSTRAINT [FK_Contract_ContractType] FOREIGN KEY ([IdContractType]) REFERENCES [Payroll].[ContractType] ([Id])
ALTER TABLE [Payroll].[Contract]
    ADD CONSTRAINT [FK_Contract_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payroll].[Contract]
    ADD CONSTRAINT [FK_Contract_Cnss] FOREIGN KEY ([IdCnss]) REFERENCES [Payroll].[Cnss] ([Id])
ALTER TABLE [Payroll].[Contract]
    ADD CONSTRAINT [FK_Contract_SalaryStructure] FOREIGN KEY ([IdSalaryStructure]) REFERENCES [Payroll].[SalaryStructure] ([Id])
ALTER TABLE [Payroll].[EmployeeDocument]
    ADD CONSTRAINT [FK_EmployeeDocument_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Grade] FOREIGN KEY ([IdGrade]) REFERENCES [Payroll].[Grade] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_UpperHierarchy] FOREIGN KEY ([IdUpperHierarchy]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Citizenship] FOREIGN KEY ([IdCitizenship]) REFERENCES [Shared].[Country] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_PaymentType] FOREIGN KEY ([IdPaymentType]) REFERENCES [Payment].[PaymentType] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Office] FOREIGN KEY ([IdOffice]) REFERENCES [Shared].[Office] ([Id])
ALTER TABLE [ERPSettings].[User]
    ADD CONSTRAINT [FK_User_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [ERPSettings].[User]
    ADD CONSTRAINT [FK_User_User] FOREIGN KEY ([IdUserParent]) REFERENCES [ERPSettings].[User] ([Id])
ALTER TABLE [ERPSettings].[User]
    ADD CONSTRAINT [FK_User_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
COMMIT TRANSACTION

--chedi :add phone table and cleaning tiers table 13:20 14/08/2020
CREATE TABLE [Shared].[Phone] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Number]            INT            NULL,
    [DialCode]          NCHAR (5)      NULL,
    [CountryCode]       NCHAR (10)     NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IdContact]         INT            NULL,
    CONSTRAINT [PK_Phone] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Phone_Contact] FOREIGN KEY ([IdContact]) REFERENCES [Shared].[Contact] ([Id])
);
GO



GO
ALTER TABLE [Shared].[Contact] DROP 
COLUMN [Contact_bit_1], COLUMN [Contact_bit_10], COLUMN [Contact_bit_2],
COLUMN [Contact_bit_3], COLUMN [Contact_bit_4], COLUMN [Contact_bit_5],
COLUMN [Contact_bit_6], COLUMN [Contact_bit_7], COLUMN [Contact_bit_8],
COLUMN [Contact_bit_9], COLUMN [Contact_date_1], COLUMN [Contact_date_10],
COLUMN [Contact_date_2], COLUMN [Contact_date_3], COLUMN [Contact_date_4],
COLUMN [Contact_date_5], COLUMN [Contact_date_6], COLUMN [Contact_date_7],
COLUMN [Contact_date_8], COLUMN [Contact_date_9], COLUMN [Contact_float_1],
COLUMN [Contact_float_10], COLUMN [Contact_float_2], COLUMN [Contact_float_3],
COLUMN [Contact_float_4], COLUMN [Contact_float_5], COLUMN [Contact_float_6],
COLUMN [Contact_float_7], COLUMN [Contact_float_8], COLUMN [Contact_float_9],
COLUMN [Contact_int_1], COLUMN [Contact_int_10], COLUMN [Contact_int_2],
COLUMN [Contact_int_3], COLUMN [Contact_int_4], COLUMN [Contact_int_5],
COLUMN [Contact_int_6], COLUMN [Contact_int_7], COLUMN [Contact_int_8],
COLUMN [Contact_int_9], COLUMN [Contact_varchar_1], COLUMN [Contact_varchar_10],
COLUMN [Contact_varchar_2], COLUMN [Contact_varchar_3], COLUMN [Contact_varchar_4],
COLUMN [Contact_varchar_5], COLUMN [Contact_varchar_6], COLUMN [Contact_varchar_7],
COLUMN [Contact_varchar_8], COLUMN [Contact_varchar_9];

--Ahmed 14/08/2020 : User Manegment
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES 
(70010, 1, 1, 0, NULL)

--yasmine: alter table Document to change Reference size
ALTER TABLE [Sales].[Document] 
ALTER COLUMN Reference NVARCHAR (MAX) NULL;


--Ahmed 18/08/2020 : Article achat 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 100062, N'D006ADEA-6C46-421A-96D6-2C90FC2B5679', 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-130b4a3c8499', N'D006ADEA-6C46-421A-96D6-2C90FC2B5679', N'817D920F-48EF-4AA2-865A-CC367C37FB3B')

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 100062, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-131b4a3c8499', N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', N'817D920F-48EF-4AA2-865A-CC367C37FB3B')

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 100062, N'A9F6E6F8-A198-4009-9D3F-BBF255F240E3', 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-132b4a3c8499', N'A9F6E6F8-A198-4009-9D3F-BBF255F240E3', N'817D920F-48EF-4AA2-865A-CC367C37FB3B')

-- chedi add id country forign key to address 10:30 19/08/2020



GO
ALTER TABLE [Shared].[Address]
    ADD [IdCountry] INT NULL;


GO
ALTER TABLE [Shared].[Address] WITH NOCHECK
    ADD CONSTRAINT [FK_Address_Address] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id]);

-- narcisse: drop old column IdTeam in Employee 21/08/2020

ALTER TABLE [Payroll].[Employee] Drop Constraint FK_Employee_Team

ALTER TABLE [Payroll].[Employee] Drop Column IdTeam

	-- chedi add tier-phone relation 13:15 24/08/2020
GO
ALTER TABLE [Shared].[Phone]
    ADD [IdTier] INT NULL;

GO
ALTER TABLE [Shared].[Phone] WITH NOCHECK
    ADD CONSTRAINT [FK_Phone_Tiers] FOREIGN KEY ([IdTier]) REFERENCES [Sales].[Tiers] ([Id]);

---Amine Ben Ayed 25/08/2020 : codification team

SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (375, N'CodeTeam', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (377, N'CaractereT-for team', 1, NULL, NULL, N'T-', 375, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (378, N'counterTeams', 2, NULL, NULL, NULL, 375, 1, 1, N'10003', 5)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF

SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (79, 368, N'CodeTeam', N'CT', 375)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
	-- chedi add address country relation 26/03/2020 9h
GO
ALTER TABLE [Shared].[Address] DROP CONSTRAINT [FK_Address_Address];

GO
ALTER TABLE [Shared].[Address]
    ADD [IdCompany] INT NULL;


GO
ALTER TABLE [Shared].[Address] WITH NOCHECK
    ADD CONSTRAINT [FK_Address_Company] FOREIGN KEY ([IdCompany]) REFERENCES [Shared].[Company] ([Id]);

GO
ALTER TABLE [Shared].[Address] WITH NOCHECK
    ADD CONSTRAINT [FK_Country_Address] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id]);

--  chedi fix phone tiers relation 26/03/2020 9h
	GO
ALTER TABLE [Shared].[Phone] DROP CONSTRAINT [FK_Phone_Tiers];

GO
ALTER TABLE [Shared].[Phone] DROP COLUMN [IdTier];

GO
ALTER TABLE [Sales].[Tiers]
    ADD [IdPhone] INT NULL;
	
GO
ALTER TABLE [Sales].[Tiers] WITH NOCHECK
    ADD CONSTRAINT [FK_Tiers_Phone] FOREIGN KEY ([IdPhone]) REFERENCES [Shared].[Phone] ([Id]);

--houssem: Add Codification finacement commitement
update  ERPSettings.EntityCodification set Property=NULL where [IdEntity] =313

-- Narcisse: Update NETTANNUEL RULE 28/08/2020 

BEGIN TRANSACTION
ALTER TABLE [Payroll].[VariableValidityPeriod] DROP CONSTRAINT [FK_VariableValidityPeriod_Variable]
UPDATE [Payroll].[VariableValidityPeriod] SET [Formule]=N'Si (BRUTIMPOSABLEANNUEL > FRAISREELS)
	Alors BRUTIMPOSABLEANNUEL - FRAISREELS
Sinon 0
Finsi' WHERE [Id]=23
ALTER TABLE [Payroll].[VariableValidityPeriod]
    WITH NOCHECK ADD CONSTRAINT [FK_VariableValidityPeriod_Variable] FOREIGN KEY ([IdVariable]) REFERENCES [Payroll].[Variable] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
COMMIT TRANSACTION

--Amine : declaration CNSS and Historique de paie
 UPDATE [MasterGuidTN].[ERPSettings].[RoleConfig] set Code = 'Declaration_Cnss' where Id = 101013
 UPDATE [MasterGuidTN].[ERPSettings].[RoleConfig] set Code = 'PayrollHistory_config' where Id = 101104

--- Donia add type to exit reason 31/08/2020
ALTER TABLE [Payroll].[ExitReason] ALTER COLUMN [Label] NVARCHAR (255) NOT NULL;
ALTER TABLE [Payroll].[ExitReason] ADD [Type] INT NOT NULL;

--- Donia add some exit reasons 31/08/2020
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT [Payroll].[ExitReason] ON
INSERT INTO [Payroll].[ExitReason] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [Description], [Label], [Type]) VALUES (1, 0, NULL, NULL, N'Démission', N'Démission', 1)
INSERT INTO [Payroll].[ExitReason] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [Description], [Label], [Type]) VALUES (2, 0, 0, NULL, N'Départ à la retraite', N'Départ à la retraite', 3)
INSERT INTO [Payroll].[ExitReason] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [Description], [Label], [Type]) VALUES (3, 0, 0, NULL, N'Prise d''acte', N'Prise d''acte', 1)
INSERT INTO [Payroll].[ExitReason] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [Description], [Label], [Type]) VALUES (4, 0, 0, NULL, N'Résiliation judiciaire', N'Résiliation judiciaire', 1)
INSERT INTO [Payroll].[ExitReason] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [Description], [Label], [Type]) VALUES (5, 0, 0, NULL, N'Licenciement pour faute', N'Licenciement pour faute', 2)
INSERT INTO [Payroll].[ExitReason] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [Description], [Label], [Type]) VALUES (6, 0, 0, NULL, N'Licenciement pour motif personnel', N'Licenciement pour motif personnel', 2)
INSERT INTO [Payroll].[ExitReason] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [Description], [Label], [Type]) VALUES (7, 0, 0, NULL, N'Licenciement pour motif économique', N'Licenciement pour motif économique', 2)
INSERT INTO [Payroll].[ExitReason] ([Id], [IsDeleted], [TransactionUserId], [Deleted_Token], [Description], [Label], [Type]) VALUES (8, 0, 0, NULL, N'Rupture conventionnelle', N'Rupture conventionnelle', 3)
SET IDENTITY_INSERT [Payroll].[ExitReason] OFF
COMMIT TRANSACTION

--- houssem add licen curency  28-08-2020 15h

/****** Object:  Table [Master].[CompanyLicence]    Script Date: 28/08/2020 14:21:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Master].[CompanyLicence](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdMasterCompany] [int] NOT NULL,
	[NombreERPUser] [int] NOT NULL,
	[NombreB2BUser] [int] NOT NULL,
	[ExpirationDate] [date] NULL,
	[IntialDate] [date] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Deleted_Token] [nvarchar](250) NULL,
 CONSTRAINT [PK_CompanyLicence] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Master].[CompanyLicence] ADD  CONSTRAINT [DF_Table_1_NombreOfUser]  DEFAULT ((0)) FOR [NombreERPUser]
GO

ALTER TABLE [Master].[CompanyLicence] ADD  CONSTRAINT [DF_CompanyLicence_NombreB2BUser]  DEFAULT ((0)) FOR [NombreB2BUser]
GO

ALTER TABLE [Master].[CompanyLicence] ADD  CONSTRAINT [DF_CompanyLicence_IntialDate]  DEFAULT (getdate()) FOR [IntialDate]
GO

ALTER TABLE [Master].[CompanyLicence]  WITH CHECK ADD  CONSTRAINT [FK_CompanyLicence_MasterCompany] FOREIGN KEY([IdMasterCompany])
REFERENCES [Master].[MasterCompany] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [Master].[CompanyLicence] CHECK CONSTRAINT [FK_CompanyLicence_MasterCompany]
GO

--houssem 28-08-2020 add Nomber of licence
SET IDENTITY_INSERT [Master].[CompanyLicence] ON 
INSERT [Master].[CompanyLicence] ([Id], [IdMasterCompany], [NombreERPUser], [NombreB2BUser], [ExpirationDate], [IntialDate], [IsDeleted], [Deleted_Token]) VALUES (1, 2, 50, 10, NULL, CAST(N'2020-08-28' AS Date), 0, NULL)
INSERT [Master].[CompanyLicence] ([Id], [IdMasterCompany], [NombreERPUser], [NombreB2BUser], [ExpirationDate], [IntialDate], [IsDeleted], [Deleted_Token]) VALUES (2, 4, 50, 10, NULL, CAST(N'2020-08-28' AS Date), 0, NULL)
INSERT [Master].[CompanyLicence] ([Id], [IdMasterCompany], [NombreERPUser], [NombreB2BUser], [ExpirationDate], [IntialDate], [IsDeleted], [Deleted_Token]) VALUES (3, 5, 50, 10, CAST(N'2020-09-01' AS Date), CAST(N'2020-08-28' AS Date), 0, NULL)
SET IDENTITY_INSERT [Master].[CompanyLicence] OFF

update Master.MasterUser set IsBToB = 0 where IsBToB is null
alter table Master.MasterUser alter  column IsBToB  bit not null 

ALTER TABLE [Master].[MasterUser] ADD  CONSTRAINT [DF_MasterUser_IsBToB]  DEFAULT ((0)) FOR [IsBToB]
GO
	
	
update  ERPSettings.EntityCodification set Property=NULL where [IdEntity] =313


	-- chedi: add city - address relation : 15.00 31-08-2020
	GO
ALTER TABLE [Shared].[Address]
    ADD [IdCity] INT NULL;

GO
ALTER TABLE [Shared].[Address] WITH NOCHECK
    ADD CONSTRAINT [FK_Address_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id]);

	-- chedi : change activity area with activity sector in company table 10:25 01-09-2020
GO
ALTER TABLE [Shared].[Company]
    ADD [ActivitySector] NVARCHAR (50) NULL;

 -- Narcisse: Add validate and refuse permission to loan config and pay config 01/09/2020

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103108, N'502bc6d4-8e23-4a32-930c-f5b3b49bee09', 1)

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 100003, N'502bc6d4-8e23-4a32-930c-f5b3b49bee09', 1)


INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103108, N'3f937828-c86b-454b-a6f3-9db6bca39bb6', 1)

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 100003, N'3f937828-c86b-454b-a6f3-9db6bca39bb6', 1)

-- Narcisse : Update LoanInstllment table 02/09/2020


ALTER TABLE [Payroll].[LoanInstallment] ALTER COLUMN [State] INT NOT NULL

ALTER TABLE [Payroll].[LoanInstallment] ADD [Month] DATE NOT NULL

ALTER TABLE [Payroll].[LoanInstallment] DROP COLUMN [Date]


	-- Amine : Add IdBank Foreign Key in Employee 01-09-2020

ALTER TABLE [Payroll].[Employee] DROP COLUMN Bank
ALTER TABLE [Payroll].[Employee]
ADD IdBank int null

ALTER TABLE [Payroll].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Bank] FOREIGN KEY([IdBank])
REFERENCES [Shared].[Bank] ([Id])
GO
ALTER TABLE [Payroll].[Employee] CHECK CONSTRAINT [FK_Employee_Bank]
Go


---Rabeb: modify Information Fr and En message: 03/09/2020

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a ajouté un commentaire pour la demande de note de frais {CODE}' WHERE [IdInfo]=1000501078
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a ajouté demande de note de frais {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501082
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a modifié la demande de note de frais {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501085
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a validé la demande de note de frais {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501088
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a refusé la demande de note de frais {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501091
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a supprimé une demande de note de frais {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501095
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
COMMIT TRANSACTION

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
UPDATE [ERPSettings].[Information] SET [EN]=N'{DOC_CREATOR} added a comment for the expense report request {CODE}' WHERE [IdInfo]=1000501078
UPDATE [ERPSettings].[Information] SET [EN]=N'{DOC_CREATOR} added a new expense report {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501082
UPDATE [ERPSettings].[Information] SET [EN]=N'{DOC_CREATOR} updated the expense report {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501085
UPDATE [ERPSettings].[Information] SET [EN]=N'{DOC_CREATOR} validated the expense report {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501088
UPDATE [ERPSettings].[Information] SET [EN]=N'{DOC_CREATOR} refused the expense report {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501091
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
COMMIT TRANSACTION

--- Donia change leave notifications first parameter 03/09/2020
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a ajouté une demande de congé {DOC_CODE} pour {PROFIL}', [EN]=N'{DOC_CREATOR} added a new leave request {DOC_CODE} for {PROFIL}' WHERE [IdInfo]=1000501081
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a modifié la demande de congé {DOC_CODE} de {PROFIL}', [EN]=N'{DOC_CREATOR} updated the leave request {DOC_CODE} of {PROFIL}' WHERE [IdInfo]=1000501084
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a validé la demande de congé {DOC_CODE} de {PROFIL}', [EN]=N'{DOC_CREATOR} validated the leave request {DOC_CODE} of {PROFIL}' WHERE [IdInfo]=1000501087
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a refusé la demande de congé {DOC_CODE} de {PROFIL}', [EN]=N'{DOC_CREATOR} refused the leave request {DOC_CODE} of {PROFIL}' WHERE [IdInfo]=1000501090
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a annulé la demande de congé {DOC_CODE} de {PROFIL}', [EN]=N'{DOC_CREATOR} canceled the leave request {DOC_CODE} of {PROFIL}' WHERE [IdInfo]=1000501093
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a supprimé une demande de congé {DOC_CODE} de {PROFIL}', [EN]=N'{DOC_CREATOR} removed the leave request {DOC_CODE} of {PROFIL}' WHERE [IdInfo]=1000501094
GO
SET IDENTITY_INSERT [ERPSettings].[Information] ON
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501244, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/leave/add', N'{CREATOR}{DOC_CODE}{PROFIL}', N'{CREATOR}{DOC_CODE}{PROFIL}', NULL, NULL, NULL, NULL, 1, 1, NULL, 0, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501245, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/leave/add', N'{CRATOR}{DOC_CODE}{PROFIL}', N'{CRATOR}{DOC_CODE}{PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIF_ADD_LEAVE', N'ADD_LEAVE')
SET IDENTITY_INSERT [ERPSettings].[Information] OFF
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
COMMIT TRANSACTION


--03/09/2020 : Ahmed 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 100018, N'2619EDD7-D221-43D7-832B-C1C761DF8AC8', 1)

--- Donia change document request first parameter 03/09/2020
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a ajouté une demande de document {DOC_CODE} pour {PROFIL}', [EN]=N'{DOC_CREATOR} added a new document request {DOC_CODE} for {PROFIL}' WHERE [IdInfo]=1000501083
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a modifié la demande de document {DOC_CODE} de {PROFIL}', [EN]=N'{DOC_CREATOR} updated the document request {DOC_CODE} of {PROFIL}' WHERE [IdInfo]=1000501086
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a validé la demande de document {DOC_CODE} de {PROFIL}', [EN]=N'{DOC_CREATOR} validated the document request {DOC_CODE} of {PROFIL}' WHERE [IdInfo]=1000501089
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a refusé la demande de document {DOC_CODE} de {PROFIL}', [EN]=N'{DOC_CREATOR} refused the document request {DOC_CODE} of {PROFIL}' WHERE [IdInfo]=1000501092
UPDATE [ERPSettings].[Information] SET [EN]=N'{DOC_CREATOR} removed the expense report {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501095
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a supprimé une demande de document {DOC_CODE} de {PROFIL}', [EN]=N'{DOC_CREATOR} removed the document request {DOC_CODE} of {PROFIL}' WHERE [IdInfo]=1000501096
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
COMMIT TRANSACTION

-- Narcisse : Merge Month and Year int columns in Month Date Column 04/09/2020

ALTER TABLE [Payroll].[ExitEmployeePayLine] DROP COLUMN [Month], [Year]

ALTER TABLE [Payroll].[ExitEmployeePayLine] ADD [Month] DATE NOT NULL

-- Imen chaaben: changing company WithholingTax
ALTER TABLE Shared.Company DROP CONSTRAINT DF_Company_WithholingTaxPercentage;
ALTER TABLE Shared.Company DROP COLUMN WithholingTaxPercentage;
ALTER TABLE Shared.Company ADD WithholdingTax BIT NOT NULL DEFAULT 1;