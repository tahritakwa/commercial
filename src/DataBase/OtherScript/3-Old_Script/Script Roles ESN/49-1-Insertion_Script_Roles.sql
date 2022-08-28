/*
This script was created by Visual Studio on 21/06/2019 at 16:29.
Run this script on ..MasterGuidOld (SPARKIT\cderbali) to make it the same as ..MasterGuid (SPARKIT\cderbali).
This script performs its actions in the following order:
1. Disable foreign-key constraints.
2. Perform DELETE commands. 
3. Perform UPDATE commands.
4. Perform INSERT commands.
5. Re-enable foreign-key constraints.
Please back up your target database before running this script.
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET XACT_ABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
/*Pointer used for text / image updates. This might not be needed, but is declared here just in case*/
DECLARE @pv binary(16)

BEGIN TRANSACTION

ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [FK_Information_RoleInfo]
ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [FK_Role_RoleInfo]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[RoleConfig] DROP CONSTRAINT [FK_RoleConfigCategory_RoleConfig]



DELETE FROM [ERPSettings].[Role] WHERE [ERPSettings].[Role].[Id] = 11111
DELETE FROM [ERPSettings].[Role] WHERE [ERPSettings].[Role].[Id] = 22222
DELETE FROM [ERPSettings].[Role] WHERE [ERPSettings].[Role].[Id] = 33333
DELETE FROM [ERPSettings].[Role] WHERE [ERPSettings].[Role].[Id] = 44444
--DELETE FROM [ERPSettings].[Role] WHERE [ERPSettings].[Role].[Id] = 55555
--DELETE FROM [ERPSettings].[Role] WHERE [ERPSettings].[Role].[Id] = 66666
DELETE FROM [ERPSettings].[Role] WHERE [ERPSettings].[Role].[Id] = 77777
DELETE FROM [ERPSettings].[Role] WHERE [ERPSettings].[Role].[Id] = 88888
DELETE FROM [ERPSettings].[Role] WHERE [ERPSettings].[Role].[Id] = 90000
DELETE FROM [ERPSettings].[Role] WHERE [ERPSettings].[Role].[Id] = 100000
DELETE FROM [ERPSettings].[Role] WHERE [ERPSettings].[Role].[Id] = 100001
DELETE FROM [ERPSettings].[Role] WHERE [ERPSettings].[Role].[Id] = 100002
DELETE FROM [ERPSettings].[Role] WHERE [ERPSettings].[Role].[Id] = 100003
DELETE FROM [ERPSettings].[Role] WHERE [ERPSettings].[Role].[Id] = 100004
DELETE FROM [ERPSettings].[Role] WHERE [ERPSettings].[Role].[Id] = 100005
DELETE FROM [ERPSettings].[Role] WHERE [ERPSettings].[Role].[Id] = 100006


DELETE FROM [ERPSettings].[User] WHERE [ERPSettings].[User].[Id] = 11111
DELETE FROM [ERPSettings].[User] WHERE [ERPSettings].[User].[Id] = 22222
DELETE FROM [ERPSettings].[User] WHERE [ERPSettings].[User].[Id] = 33333
DELETE FROM [ERPSettings].[User] WHERE [ERPSettings].[User].[Id] = 44444
--DELETE FROM [ERPSettings].[User] WHERE [ERPSettings].[User].[Id] = 55555
--DELETE FROM [ERPSettings].[User] WHERE [ERPSettings].[User].[Id] = 66666
DELETE FROM [ERPSettings].[User] WHERE [ERPSettings].[User].[Id] = 77777
DELETE FROM [ERPSettings].[User] WHERE [ERPSettings].[User].[Id] = 88888
DELETE FROM [ERPSettings].[User] WHERE [ERPSettings].[User].[Id] = 99999
DELETE FROM [ERPSettings].[User] WHERE [ERPSettings].[User].[Id] = 90000
DELETE FROM [ERPSettings].[User] WHERE [ERPSettings].[User].[Id] = 100000
DELETE FROM [ERPSettings].[User] WHERE [ERPSettings].[User].[Id] = 100001
DELETE FROM [ERPSettings].[User] WHERE [ERPSettings].[User].[Id] = 100002
DELETE FROM [ERPSettings].[User] WHERE [ERPSettings].[User].[Id] = 100003

DELETE FROM [ERPSettings].[RoleConfigCategory]

SET IDENTITY_INSERT [ERPSettings].[User] ON
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee]) VALUES (11111, N'achats user', N'achats user', N'Purchase', N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, NULL, NULL, NULL, N'purchaseuser@spark-it.fr', NULL, NULL, 0, 0, NULL, NULL, N'fr', NULL)
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee]) VALUES (22222, N'stock user', N'stock user', N'stock', N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, NULL, NULL, NULL, N'stockuser@spark-it.fr', NULL, NULL, 0, 0, NULL, NULL, N'fr', NULL)
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee]) VALUES (33333, N'ventes user', N'ventes user', N'Sales', N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, NULL, NULL, NULL, N'salesuser@spark-it.fr', NULL, NULL, 0, 0, NULL, NULL, N'fr', NULL)
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee]) VALUES (44444, N'immob user', N'immob user', N'Immob', N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, NULL, NULL, NULL, N'immobuser@spark-it.fr', NULL, NULL, 0, 0, NULL, NULL, N'fr', NULL)
--INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee]) VALUES (55555, N'paie user', N'paie user', NULL, N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, NULL, NULL, NULL, N'payuser@spark-it.fr', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL)
--INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee]) VALUES (66666, N'rh user', N'rh user', NULL, N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, NULL, NULL, NULL, N'rhuser@spark-it.fr', NULL, NULL, 0, 0, NULL, NULL, N'fr', NULL)
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee]) VALUES (77777, N'reglages user', N'reglages user', N'Setings', N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, NULL, NULL, NULL, N'settings@spark-it.fr', NULL, NULL, 0, 0, NULL, NULL, N'fr', NULL)
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee]) VALUES (88888, N'assistance user', N'assistance user', N'Helpdesk', N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, NULL, NULL, NULL, N'helpdeskuser@spark-it.fr', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee]) VALUES (90000, N'Super user', N'Super user', N'SuperAdmin', N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, NULL, NULL, NULL, N'superuser@spark-it.fr', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee]) VALUES (100000, N'consultant user', N'consultant user', N'Consultant', N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, NULL, NULL, NULL, N'consultantuser@spark-it.fr', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee]) VALUES (100001, N'Manager', N'User', NULL, N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, N'', N'', N'', N'manageruser@spark-it.fr', NULL, NULL, 0, 0, NULL, NULL, N'fr', NULL)
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee]) VALUES (100002, N'Responsable RH', N'User', NULL, N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, N'', N'', N'', N'resprh@spark-it.fr', NULL, NULL, 0, 0, NULL, NULL, N'fr', NULL)
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee]) VALUES (100003, N'Responsable Pay', N'User', NULL, N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, N'', N'', N'', N'resppay@spark-it.fr', NULL, NULL, 0, 0, NULL, NULL, N'fr', NULL)
SET IDENTITY_INSERT [ERPSettings].[User] OFF


SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] ON
INSERT INTO [ERPSettings].[RoleConfigCategory] ([Id], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (22222, N'STOCK', N'Stock', N'STOCK', 0, NULL, NULL)
INSERT INTO [ERPSettings].[RoleConfigCategory] ([Id], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (11111, N'PURCHASE', N'Achats', N'PURCHASE', 0, NULL, NULL)
INSERT INTO [ERPSettings].[RoleConfigCategory] ([Id], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (33333, N'SALES', N'Ventes', N'SALES', 0, NULL, NULL)
INSERT INTO [ERPSettings].[RoleConfigCategory] ([Id], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (44444, N'IMMOBILIZATION', N'Immobilisation', N'IMMOBILIZATION', 0, NULL, NULL)
INSERT INTO [ERPSettings].[RoleConfigCategory] ([Id], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (77777, N'SETTINGS', N'Reglages', N'SETTINGS', 0, NULL, NULL)
INSERT INTO [ERPSettings].[RoleConfigCategory] ([Id], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (88888, N'HELPDESK', N'Assistance', N'HELPDESK', 0, NULL, NULL)
INSERT INTO [ERPSettings].[RoleConfigCategory] ([Id], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (100008, N'EMPLOYEES', N'Employés', N'EMPLOYEES', 0, NULL, NULL)
INSERT INTO [ERPSettings].[RoleConfigCategory] ([Id], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (100009, N'ADMINISTRATIVE_MANAGMENT', N'Gestion Administrative', N'ADMINISTRATIVE_MANAGMENT', 0, NULL, NULL)
INSERT INTO [ERPSettings].[RoleConfigCategory] ([Id], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (100010, N'CAREER_MANAGEMENT', N'Gestion de carriéres', N'CAREER_MANAGEMENT', 0, NULL, NULL)
INSERT INTO [ERPSettings].[RoleConfigCategory] ([Id], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (100011, N'PAYROLL', N'Paie', N'PAYROLL', 0, NULL, NULL)
INSERT INTO [ERPSettings].[RoleConfigCategory] ([Id], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (100099, N'SUPERADMIN', N'SuperAdmin', N'SUPERADMIN', 0, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] OFF


SET IDENTITY_INSERT [ERPSettings].[Role] ON
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (11111, N'Achats', N'Gestion des Achats', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (22222, N'Stock', N'Gestion de Stock', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (33333, N'Ventes', N'Gestion des Ventes', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (44444, N'Immobilisation', N'Gestion de Immobilisation', 0, NULL)
--INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (55555, N'Paie', N'Paie', 0, NULL)
--INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (66666, N'RH', N'Rh', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (77777, N'Reglages', N'Gestion des Reglages', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (88888, N'Assistance', N'Assistance', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (100000, N'Consultant', N'Consultant', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (100001, N'Responsable RH', N'Responsable RH', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (100002, N'Responsable Pay', N'Responsable Pay', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (100003, N'Liste Article', N'Liste Article', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (100005, N'Session de facturation', N'Session de facturation', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (100004, N'Historique Achat', N'Historique Achat', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (100006, N'Contrat de prestation', N'Contrat de prestation', 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[Role] OFF




INSERT INTO [ERPSettings].[UserRole] ([IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (11111, 11111, 11111, 0, NULL)
INSERT INTO [ERPSettings].[UserRole] ([IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (22222, 22222, 22222, 0, NULL)
INSERT INTO [ERPSettings].[UserRole] ([IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (33333, 33333, 33333, 0, NULL)
INSERT INTO [ERPSettings].[UserRole] ([IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (44444, 44444, 44444, 0, NULL)
-- INSERT INTO [ERPSettings].[UserRole] ([IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (55555, 55555, 55555, 0, NULL)
-- INSERT INTO [ERPSettings].[UserRole] ([IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (66666, 66666, 0, 0, NULL)
INSERT INTO [ERPSettings].[UserRole] ([IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (77777, 77777, 77777, 0, NULL)
INSERT INTO [ERPSettings].[UserRole] ([IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (88888, 88888, 88888, 0, NULL)
INSERT INTO [ERPSettings].[UserRole] ([IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (100003, 2, 2, 0, NULL)
INSERT INTO [ERPSettings].[UserRole] ([IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (100000, 100000, 100000, 0, NULL)
INSERT INTO [ERPSettings].[UserRole] ([IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (100001, 100002, 100002, 0, NULL)
INSERT INTO [ERPSettings].[UserRole] ([IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (100002, 100003, 100003, 0, NULL)

ALTER TABLE [ERPSettings].[RoleInfo]
    ADD CONSTRAINT [FK_Information_RoleInfo] FOREIGN KEY ([IdInformation]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[RoleInfo]
    ADD CONSTRAINT [FK_Role_RoleInfo] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[RoleConfig] WITH NOCHECK
    ADD CONSTRAINT [FK_RoleConfigCategory_RoleConfig] FOREIGN KEY ([IdRoleConfigCategory]) REFERENCES [ERPSettings].[RoleConfigCategory] ([Id]);

COMMIT TRANSACTION

-- Role Config

BEGIN TRANSACTION

ALTER TABLE [ERPSettings].[ModuleConfig] DROP CONSTRAINT [FK_ModuleConfig_Module]
ALTER TABLE [ERPSettings].[ModuleConfig] DROP CONSTRAINT [FK_ModuleConfig_RoleConfig]
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_Functionality]
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_RoleConfig]
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [DF_FonctionalityConfig_IdFunctionality]
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_RoleConfig]


DELETE FROM [ERPSettings].[RoleConfig]

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON

INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IdRoleConfigCategory], [IsDeleted], [Deleted_Token]) VALUES (11111, N'Achats', N'Achats', 11111, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IdRoleConfigCategory], [IsDeleted], [Deleted_Token]) VALUES (22222, N'Stock', N'Gest stock', 22222, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IdRoleConfigCategory], [IsDeleted], [Deleted_Token]) VALUES (33333, N'Ventes ', N'Ventes', 33333, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IdRoleConfigCategory], [IsDeleted], [Deleted_Token]) VALUES (44444, N'Immob', N'Immob', 44444, 0, NULL)
-- INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IdRoleConfigCategory], [IsDeleted], [Deleted_Token]) VALUES (55555, N'Paie', N'Paie', 55555, 0, NULL)
-- INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IdRoleConfigCategory], [IsDeleted], [Deleted_Token]) VALUES (66666, N'Rh', N'Rh', 66666, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IdRoleConfigCategory], [IsDeleted], [Deleted_Token]) VALUES (77777, N'Reglages', N'Reglages', 77777, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IdRoleConfigCategory], [IsDeleted], [Deleted_Token]) VALUES (88888, N'Assistance', N'Assistance  ', 88888, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IdRoleConfigCategory], [IsDeleted], [Deleted_Token]) VALUES (100000, N'Consultant', N'Consultant', 100008, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IdRoleConfigCategory], [IsDeleted], [Deleted_Token]) VALUES (100001, N'Manager   ', N'Manager   ', 100008, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IdRoleConfigCategory], [IsDeleted], [Deleted_Token]) VALUES (100002, N'Responsable RH', N'Responsable RH', 100008, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IdRoleConfigCategory], [IsDeleted], [Deleted_Token]) VALUES (100003, N'Responsable PAY', N'Responsable PAY', 100008, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IdRoleConfigCategory], [IsDeleted], [Deleted_Token]) VALUES (100004, N'Liste Article  ', N'Liste Article  ', 11111, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IdRoleConfigCategory], [IsDeleted], [Deleted_Token]) VALUES (100005, N'Historique Achat  ', N'Historique Achat  ', 22222, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IdRoleConfigCategory], [IsDeleted], [Deleted_Token]) VALUES (100006, N'Session de facturation  ', N'Session de facturation  ', 33333, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IdRoleConfigCategory], [IsDeleted], [Deleted_Token]) VALUES (100007, N'Contrat de prestation  ', N'Contrat de prestation  ', 33333, 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF




ALTER TABLE [ERPSettings].[FunctionalityConfig]
    ADD CONSTRAINT [DF_FonctionalityConfig_IdFunctionality] DEFAULT (newid()) FOR [IdFunctionality];
ALTER TABLE [ERPSettings].[FunctionalityConfig] WITH NOCHECK
    ADD CONSTRAINT [FK_FonctionalityConfig_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality]);
ALTER TABLE [ERPSettings].[FunctionalityConfig] WITH NOCHECK
    ADD CONSTRAINT [FK_FonctionalityConfig_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id]);
ALTER TABLE [ERPSettings].[ModuleConfig] WITH NOCHECK
    ADD CONSTRAINT [FK_ModuleConfig_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule]);
ALTER TABLE [ERPSettings].[ModuleConfig] WITH NOCHECK
    ADD CONSTRAINT [FK_ModuleConfig_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id]);
ALTER TABLE [ERPSettings].[RoleConfigByRole] WITH NOCHECK
    ADD CONSTRAINT [FK_RoleConfigRole_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id]);
COMMIT TRANSACTION


-- Roles && RoleConfig Super Admin

BEGIN TRANSACTION


ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [FK_Information_RoleInfo]
ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [FK_Role_RoleInfo]

ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]

ALTER TABLE [ERPSettings].[ModuleConfig] DROP CONSTRAINT [FK_ModuleConfig_Module]
ALTER TABLE [ERPSettings].[ModuleConfig] DROP CONSTRAINT [FK_ModuleConfig_RoleConfig]
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_Functionality]
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_RoleConfig]
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [DF_FonctionalityConfig_IdFunctionality]

DELETE FROM [ERPSettings].[UserRole] WHERE [ERPSettings].[UserRole].[IdRole] = 90000
DELETE FROM [ERPSettings].[Role] WHERE [ERPSettings].[Role].[Id] = 90000
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 90000

SET IDENTITY_INSERT [ERPSettings].[Role] ON
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (90000, N'SuperAdmin', N'SuperAdmin', 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[Role] OFF


SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IdRoleConfigCategory], [IsDeleted], [Deleted_Token]) VALUES (90000, N'SuperAdmin   ', N'SuperAdmin   ', 100099, 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF



ALTER TABLE [ERPSettings].[RoleInfo]
    ADD CONSTRAINT [FK_Information_RoleInfo] FOREIGN KEY ([IdInformation]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[RoleInfo]
    ADD CONSTRAINT [FK_Role_RoleInfo] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[FunctionalityConfig]
    ADD CONSTRAINT [DF_FonctionalityConfig_IdFunctionality] DEFAULT (newid()) FOR [IdFunctionality];
ALTER TABLE [ERPSettings].[FunctionalityConfig] WITH NOCHECK
    ADD CONSTRAINT [FK_FonctionalityConfig_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality]);
ALTER TABLE [ERPSettings].[FunctionalityConfig] WITH NOCHECK
    ADD CONSTRAINT [FK_FonctionalityConfig_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id]);
ALTER TABLE [ERPSettings].[ModuleConfig] WITH NOCHECK
    ADD CONSTRAINT [FK_ModuleConfig_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule]);
ALTER TABLE [ERPSettings].[ModuleConfig] WITH NOCHECK
    ADD CONSTRAINT [FK_ModuleConfig_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id]);

COMMIT TRANSACTION


BEGIN TRANSACTION

DELETE FROM [ERPSettings].[RoleConfigByRole]

INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (11111, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (22222, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (33333, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (44444, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (77777, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (88888, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100004, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100005, 1, 1, 0, NULL)

INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (11111, 11111, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (22222, 22222, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (33333, 33333, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (44444, 44444, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (77777, 77777, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (88888, 88888, 1, 0, NULL)

INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100000, 100000, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100002, 100001, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100003, 100002, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100004, 100003, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100006, 100005, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100005, 100004, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100007, 100006, 1, 0, NULL)
																															  

INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (90000, 90000, 1, 0, NULL)

COMMIT TRANSACTION