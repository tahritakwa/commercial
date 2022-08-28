-- Bachir: Update Roles Delete Super Admin Functionnalities from other roles

BEGIN TRANSACTION

DELETE FROM [ERPSettings].[FunctionalityConfig]
WHERE [ERPSettings].[FunctionalityConfig].[IdFunctionality] = 'be512744-b639-4f8a-ab84-e7f568ff5289' 
AND [ERPSettings].[FunctionalityConfig].[IdRoleConfig] <> 90000


DELETE FROM [ERPSettings].[FunctionalityConfig]
WHERE [ERPSettings].[FunctionalityConfig].[IdFunctionality] = '9f4c47d5-c617-4f8e-a87b-8b27ee48cf6e' 
AND [ERPSettings].[FunctionalityConfig].[IdRoleConfig] <> 90000

DELETE FROM [ERPSettings].[FunctionalityConfig]
WHERE [ERPSettings].[FunctionalityConfig].[IdFunctionality] = 'EE642289-11EB-4BF4-96D7-D29CF86F8AF5' 
AND [ERPSettings].[FunctionalityConfig].[IdRoleConfig] <> 90000


DELETE FROM [ERPSettings].[FunctionalityConfig]
WHERE [ERPSettings].[FunctionalityConfig].[IdFunctionality] = '4c727392-f0f3-4ea7-893d-123648e831cf' 
AND [ERPSettings].[FunctionalityConfig].[IdRoleConfig] <> 90000

DELETE FROM [ERPSettings].[FunctionalityConfig]
WHERE [ERPSettings].[FunctionalityConfig].[IdFunctionality] = '7b1e7ccb-fd1e-4271-b7b3-5f8d5efb5cec' 
AND [ERPSettings].[FunctionalityConfig].[IdRoleConfig] <> 90000

DELETE FROM [ERPSettings].[FunctionalityConfig]
WHERE [ERPSettings].[FunctionalityConfig].[IdFunctionality] = 'a6204969-3848-412d-80e1-c596eb740f36' 
AND [ERPSettings].[FunctionalityConfig].[IdRoleConfig] <> 90000

DELETE FROM [ERPSettings].[FunctionalityConfig]
WHERE [ERPSettings].[FunctionalityConfig].[IdFunctionality] = 'a291e34e-5db0-4835-bad7-f88cc7d5d3aa' 
AND [ERPSettings].[FunctionalityConfig].[IdRoleConfig] <> 90000

DELETE FROM [ERPSettings].[FunctionalityConfig]
WHERE [ERPSettings].[FunctionalityConfig].[IdFunctionality] = 'ae99aa0c-146f-4b4f-81d2-a95fb077a367' 
AND [ERPSettings].[FunctionalityConfig].[IdRoleConfig] <> 90000

DELETE FROM [ERPSettings].[FunctionalityConfig]
WHERE [ERPSettings].[FunctionalityConfig].[IdFunctionality] = 'd482c274-39ec-4dad-a850-fc692fb38c62' 
AND [ERPSettings].[FunctionalityConfig].[IdRoleConfig] <> 90000

DELETE FROM [ERPSettings].[FunctionalityConfig]
WHERE [ERPSettings].[FunctionalityConfig].[IdFunctionality] = 'fd671f2f-5b90-4de3-9a07-19ab4a3c8466' 
AND [ERPSettings].[FunctionalityConfig].[IdRoleConfig] <> 90000

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
DELETE FROM [ERPSettings].[FunctionalityConfig]  WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 90000
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 90000


-- Functionalities Config of Role SuperAdmin
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdFunctionality],[IdRoleConfig])
SELECT DISTINCT x.IdFunctionality,90000
FROM [ERPSettings].[Functionality] as x

-- Modules Config of Role SuperAdmin
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig])
SELECT DISTINCT x.IdModule,90000
FROM [ERPSettings].[Module] as x


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
