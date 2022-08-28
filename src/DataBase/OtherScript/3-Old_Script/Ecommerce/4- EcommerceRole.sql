BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_Functionality]
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_RoleConfig]
ALTER TABLE [ERPSettings].[RoleConfig] DROP CONSTRAINT [FK_RoleConfigCategory_RoleConfig]
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_Role]
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_RoleConfig]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[ModuleConfig] DROP CONSTRAINT [FK_ModuleConfig_Module]
ALTER TABLE [ERPSettings].[ModuleConfig] DROP CONSTRAINT [FK_ModuleConfig_RoleConfig]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'44afb7e5-da23-4d49-acbd-26ce2f879149', N'Ecommerce', NULL, 1, N'Ecommerce', N'Ecommerce', N'Ecommerce', N'Ecommerce', N'Ecommerce', N'Ecommerce', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'95c1b8df-b925-431b-8615-57c7668d5886', N'EcommerceItem', N'44afb7e5-da23-4d49-acbd-26ce2f879149', 2, N'EcommerceItem', N'EcommerceItem', N'EcommerceItem', N'EcommerceItem', N'EcommerceItem', N'EcommerceItem', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'aad112b6-39de-4fc0-94fd-f9ae3f480ce1', N'EcommerceTiers', N'44afb7e5-da23-4d49-acbd-26ce2f879149', 2, N'EcommerceTiers', N'EcommerceTiers', N'EcommerceTiers', N'EcommerceTiers', N'EcommerceTiers', N'EcommerceTiers', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'f8fd4e4e-6e87-4a12-965a-87dc9dd6a988', N'EcommerceMovement', N'44afb7e5-da23-4d49-acbd-26ce2f879149', 2, N'EcommerceMovement', N'EcommerceMovement', N'EcommerceMovement', N'EcommerceMovement', N'EcommerceMovement', N'EcommerceMovement', N'icon-note', 0)

INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'44afb7e5-da23-4d49-acbd-26ce2f879149', 100007, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'95c1b8df-b925-431b-8615-57c7668d5886', 100007, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'aad112b6-39de-4fc0-94fd-f9ae3f480ce1', 100007, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'f8fd4e4e-6e87-4a12-965a-87dc9dd6a988', 100007, 1)

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'28a68f7b-e21a-410c-9333-31a7099cb403', N'StockMovementLineEcomm-ADD', 1, N'ADD-StockMovementLineEcomm', N'ADD-StockMovementLineEcomm', N'ADD-StockMovementLineEcomm', N'ADD-StockMovementLineEcomm', N'ADD-StockMovementLineEcomm', N'ADD-StockMovementLineEcomm', N'/ecommerce/add', 0, N'ADD-StockMovementLineEcomm')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'358c397e-b548-476c-90c5-45d183606b6f', N'TiersEcomm-UPDATE', 2, N'UPDATE-TiersEcomm', N'UPDATE-TiersEcomm', N'UPDATE-TiersEcomm', N'UPDATE-TiersEcomm', N'UPDATE-TiersEcomm', N'UPDATE-TiersEcomm', N'/ecommerce/update', 0, N'UPDATE-TiersEcomm')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'37a20e5c-61ce-4cbf-b8a4-f7dd46466e41', N'ItemEcomm-UPDATE', 2, N'UPDATE-ItemEcomm', N'UPDATE-ItemEcomm', N'UPDATE-ItemEcomm', N'UPDATE-ItemEcomm', N'UPDATE-ItemEcomm', N'UPDATE-ItemEcomm', N'/ecommerce/update', 0, N'UPDATE-ItemEcomm')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'59c49df5-3cca-40f0-8d86-9e3b3a75ccb6', N'StockMovementLineEcomm-LIST', 4, N'LIST-StockMovementLineEcomm', N'LIST-StockMovementLineEcomm', N'LIST-StockMovementLineEcomm', N'LIST-StockMovementLineEcomm', N'LIST-StockMovementLineEcomm', N'LIST-StockMovementLineEcomm', N'/ecommerce/list', 0, N'LIST-StockMovementLineEcomm')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6c2670b6-dcdd-4410-b436-b474aea8dd63', N'Ecommerce-SHOW', 15, N'SHOW-StockMovementEcomm', N'SHOW-StockMovementEcomm', N'SHOW-StockMovementEcomm', N'SHOW-StockMovementEcomm', N'SHOW-StockMovementEcomm', N'SHOW-StockMovementEcomm', N'/ecommerce/show', 0, N'SHOW-StockMovementEcomm')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'997b0595-b07b-49ee-9999-51ad34cd289a', N'StockMovementLineEcomm-SHOW', 15, N'SHOW-StockMovementLineEcomm', N'SHOW-StockMovementLineEcomm', N'SHOW-StockMovementLineEcomm', N'SHOW-StockMovementLineEcomm', N'SHOW-StockMovementLineEcomm', N'SHOW-StockMovementLineEcomm', N'/ecommerce/show', 0, N'SHOW-StockMovementLineEcomm')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a25f3c15-f35b-420c-b2bd-9e0d598ac1d0', N'StockMovementLineEcomm-UPDATE', 2, N'UPDATE-StockMovementLineEcomm', N'UPDATE-StockMovementLineEcomm', N'UPDATE-StockMovementLineEcomm', N'UPDATE-StockMovementLineEcomm', N'UPDATE-StockMovementLineEcomm', N'UPDATE-StockMovementLineEcomm', N'/ecommerce/update', 0, N'UPDATE-StockMovementLineEcomm')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'bc9aadee-54a5-4a39-be6a-de9744f62b98', N'TiersEcomm-SHOW', 15, N'SHOW-TiersEcomm', N'SHOW-TiersEcomm', N'SHOW-TiersEcomm', N'SHOW-TiersEcomm', N'SHOW-TiersEcomm', N'SHOW-TiersEcomm', N'/ecommerce/show', 1, N'SHOW-TiersEcomm')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'cc0ca036-935a-4e15-929b-aaa07f5397a9', N'StockMovementEcomm-LIST', 4, N'LIST-StockMovementEcomm', N'LIST-StockMovementEcomm', N'LIST-StockMovementEcomm', N'LIST-StockMovementEcomm', N'LIST-StockMovementEcomm', N'LIST-StockMovementEcomm', N'/ecommerce/list', 0, N'LIST-StockMovementEcomm')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'cf772fad-7794-45e2-ab82-9dfc61db06cf', N'StockMovementEcomm-ADD', 1, N'ADD-StockMovementEcomm', N'ADD-StockMovementEcomm', N'ADD-StockMovementEcomm', N'ADD-StockMovementEcomm', N'ADD-StockMovementEcomm', N'ADD-StockMovementEcomm', N'/ecommerce/add', 0, N'ADD-StockMovementEcomm')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'd0585140-fdf7-4d2b-886d-01d8141c1acf', N'StockMovementEcomm-UPDATE', 2, N'UPDATE-StockMovementEcomm', N'UPDATE-StockMovementEcomm', N'UPDATE-StockMovementEcomm', N'UPDATE-StockMovementEcomm', N'UPDATE-StockMovementEcomm', N'UPDATE-StockMovementEcomm', N'/ecommerce/update', 0, N'UPDATE-StockMovementEcomm')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ed8409db-eeed-4915-9b3b-a650f0eb3aea', N'ItemEcomm-LIST', 4, N'LIST-ItemEcomm', N'LIST-ItemEcomm', N'LIST-ItemEcomm', N'LIST-ItemEcomm', N'LIST-ItemEcomm', N'LIST-ItemEcomm', N'/ecommerce/list', 0, N'LIST-ItemEcomm')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ee0d7ab2-b1af-4e42-854c-7bc2ef8749aa', N'TiersEcomm-LIST', 4, N'LIST-TiersEcomm', N'LIST-TiersEcomm', N'LIST-TiersEcomm', N'LIST-TiersEcomm', N'LIST-TiersEcomm', N'LIST-TiersEcomm', N'/ecommerce/list', 0, N'LIST-TiersEcomm')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'20373505-2115-42a7-b64e-bfde670472a4', N'6c2670b6-dcdd-4410-b436-b474aea8dd63', N'44afb7e5-da23-4d49-acbd-26ce2f879149')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'2973ecdd-07c5-4583-b14b-30e25652acc2', N'28a68f7b-e21a-410c-9333-31a7099cb403', N'f8fd4e4e-6e87-4a12-965a-87dc9dd6a988')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'29ceb474-1eaf-4de3-a6d9-1e48a7ca669b', N'cc0ca036-935a-4e15-929b-aaa07f5397a9', N'f8fd4e4e-6e87-4a12-965a-87dc9dd6a988')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'29db104e-d48a-48e8-8a30-c58adae7f8b5', N'cf772fad-7794-45e2-ab82-9dfc61db06cf', N'f8fd4e4e-6e87-4a12-965a-87dc9dd6a988')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'3350e0ec-cdaf-44b0-aafc-6f9d09749e56', N'358c397e-b548-476c-90c5-45d183606b6f', N'aad112b6-39de-4fc0-94fd-f9ae3f480ce1')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'49fe1b12-ab9b-405b-92c3-2587d1bdaec6', N'bc9aadee-54a5-4a39-be6a-de9744f62b98', N'aad112b6-39de-4fc0-94fd-f9ae3f480ce1')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'654de4b3-ccf2-412b-a1e1-987137b6aaa4', N'ed8409db-eeed-4915-9b3b-a650f0eb3aea', N'95c1b8df-b925-431b-8615-57c7668d5886')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'cb7a51fb-e804-449e-b2f9-24d5bb9106bc', N'd0585140-fdf7-4d2b-886d-01d8141c1acf', N'f8fd4e4e-6e87-4a12-965a-87dc9dd6a988')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e1466f24-5e46-4404-aead-a51f6b69312b', N'a25f3c15-f35b-420c-b2bd-9e0d598ac1d0', N'f8fd4e4e-6e87-4a12-965a-87dc9dd6a988')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e5fce489-62a5-4ff9-88d5-bd2902e90eb2', N'37a20e5c-61ce-4cbf-b8a4-f7dd46466e41', N'95c1b8df-b925-431b-8615-57c7668d5886')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'eb7dc32d-016a-45cd-92c2-a9d2b868bc98', N'59c49df5-3cca-40f0-8d86-9e3b3a75ccb6', N'f8fd4e4e-6e87-4a12-965a-87dc9dd6a988')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f6b250f6-ba0c-4295-9a4e-ccb82e743b6d', N'997b0595-b07b-49ee-9999-51ad34cd289a', N'f8fd4e4e-6e87-4a12-965a-87dc9dd6a988')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f8d6137e-2127-427b-89c5-b19894b8bfdc', N'ee0d7ab2-b1af-4e42-854c-7bc2ef8749aa', N'aad112b6-39de-4fc0-94fd-f9ae3f480ce1')
SET IDENTITY_INSERT [ERPSettings].[Role] ON
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (100007, N'Ecommerce', N'Ecommerce', 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[Role] OFF


INSERT INTO [ERPSettings].[RoleConfigByRole] ( [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( 100007, 100007, 1, 0, NULL)


SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] ON
INSERT INTO [ERPSettings].[RoleConfigCategory] ([Id], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (100007, N'ECOMMERCE', N'Ecommerce', N'Ecommerce', 0, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] OFF
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100007, N'Ecommerce                                         ', N'Ecommerce                                         ', 0, NULL, 100007)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF


INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 100007, N'28a68f7b-e21a-410c-9333-31a7099cb403', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 100007, N'358c397e-b548-476c-90c5-45d183606b6f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 100007, N'37a20e5c-61ce-4cbf-b8a4-f7dd46466e41', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 100007, N'59c49df5-3cca-40f0-8d86-9e3b3a75ccb6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 100007, N'6c2670b6-dcdd-4410-b436-b474aea8dd63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 100007, N'997b0595-b07b-49ee-9999-51ad34cd289a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 100007, N'a25f3c15-f35b-420c-b2bd-9e0d598ac1d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 100007, N'bc9aadee-54a5-4a39-be6a-de9744f62b98', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 100007, N'cc0ca036-935a-4e15-929b-aaa07f5397a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 100007, N'cf772fad-7794-45e2-ab82-9dfc61db06cf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 100007, N'd0585140-fdf7-4d2b-886d-01d8141c1acf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 100007, N'ed8409db-eeed-4915-9b3b-a650f0eb3aea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 100007, N'ee0d7ab2-b1af-4e42-854c-7bc2ef8749aa', 1)


ALTER TABLE [ERPSettings].[FunctionalityConfig]
    WITH NOCHECK ADD CONSTRAINT [FK_FonctionalityConfig_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionalityConfig]
    WITH NOCHECK ADD CONSTRAINT [FK_FonctionalityConfig_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
ALTER TABLE [ERPSettings].[RoleConfig]
    WITH NOCHECK ADD CONSTRAINT [FK_RoleConfigCategory_RoleConfig] FOREIGN KEY ([IdRoleConfigCategory]) REFERENCES [ERPSettings].[RoleConfigCategory] ([Id])
ALTER TABLE [ERPSettings].[RoleConfigByRole]
    ADD CONSTRAINT [FK_RoleConfigRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[RoleConfigByRole]
    WITH NOCHECK ADD CONSTRAINT [FK_RoleConfigRole_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[ModuleConfig]
    WITH NOCHECK ADD CONSTRAINT [FK_ModuleConfig_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleConfig]
    WITH NOCHECK ADD CONSTRAINT [FK_ModuleConfig_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
COMMIT TRANSACTION
