BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[ModuleConfig] DROP CONSTRAINT [FK_ModuleConfig_Module]
ALTER TABLE [ERPSettings].[ModuleConfig] DROP CONSTRAINT [FK_ModuleConfig_RoleConfig]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[RoleConfig] DROP CONSTRAINT [FK_RoleConfigCategory_RoleConfig]
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (104150, N'RC_movement', N'Mouvement de RC', 0, NULL, 22222)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fd101f2f-5b91-4de3-9a07-337b4a3c5150', N'rc movement', 4, N'mouvement de rc', N'rc movement', NULL, NULL, NULL, NULL, N'/Stock', 0, N'RC_movement')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fd101f2f-5b91-4de3-9a07-337b4a3c5151', N'ADD-TransferShelfStorage', 4, N'ADD Transfer Shelf Storage', N'ADD Transfer Shel fStorage', NULL, NULL, NULL, NULL, N'/Stock', 0, N'ADD-TransferShelfStorage')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fd101f2f-5b91-4de3-9a07-337b4a3c5152', N'LIST-TransferShelfStorage', 4, N'List Transfer Shelf Storage', N'List Transfer Shelf Storage', NULL, NULL, NULL, NULL, N'/Stock', 0, N'LIST-TransferShelfStorage')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 104150, N'fd101f2f-5b91-4de3-9a07-337b4a3c5150', 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b91-4de3-9a07-810b4a3c7153', N'fd101f2f-5b91-4de3-9a07-337b4a3c5150', N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f')

ALTER TABLE [ERPSettings].[ModuleConfig]
    ADD CONSTRAINT [FK_ModuleConfig_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleConfig]
    ADD CONSTRAINT [FK_ModuleConfig_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[RoleConfig]
    ADD CONSTRAINT [FK_RoleConfigCategory_RoleConfig] FOREIGN KEY ([IdRoleConfigCategory]) REFERENCES [ERPSettings].[RoleConfigCategory] ([Id])
COMMIT TRANSACTION
