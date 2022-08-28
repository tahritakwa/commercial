---- Nihel
BEGIN TRANSACTION
UPDATE [ERPSettings].[EntityCodification] SET [Value]=N'INV' WHERE [Id]=13
GO
COMMIT TRANSACTION

---- Update Inventory StockDocumentType
BEGIN TRANSACTION
DELETE FROM [Inventory].[StockDocumentType] WHERE [CodeType]=N'I'
GO
INSERT INTO [Inventory].[StockDocumentType] ([CodeType], [Type], [StockOperation], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (N'INV', N'INV', N'INV', N'Inventory', 0, 0, NULL)
COMMIT TRANSACTION

---- Yasmine
BEGIN TRANSACTION
GO
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'58784307-6eaa-4132-bb4f-1439cc7ba256', N'DELIVER-BE', 15, N'DELIVER-BE', N'DELIVER-BE', N'DELIVER-BE', N'DELIVER-BE', N'DELIVER-BE', N'DELIVER-BE', N'/sales/deliverySales/deliver', 0, N'DELIVER-BE')

COMMIT TRANSACTION

--Yasmine: Create role SalesDelivery_Deliver

BEGIN TRANSACTION
GO
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100166, N'SalesDelivery_Deliver', N'Livraison Des Ventes', 0, NULL, 33333)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

INSERT INTO [ERPSettings].[RoleConfigByRole] ( [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100166, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ( [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100166, 33333, 1, 0, NULL)

INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES (N'D438FBAD-7305-4DAD-AB44-A4FB84318A83', 100166, 1)

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100166, N'58784307-6eaa-4132-bb4f-1439cc7ba256', 1)

COMMIT TRANSACTION 



--- Bachir delete reserved doc line

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100061, N'DeleteReservedDocumentLine_Config', N'Suppression Ligne de document reservée', 0, NULL, 33333)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
---- Nihel: purchase item

BEGIN TRANSACTION
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'04c4ae31-23ca-4cf1-8057-c596d605ff56', N'LIST-ITEMPURCHASE', 4, N'LIST-ITEMPURCHASE', N'LIST-ITEMPURCHASE', NULL, NULL, NULL, NULL, N'/sales/reporting/control', 1, N'LIST-ITEMPURCHASE')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'06581a70-999b-4a32-afc9-a700adba42cd', N'04c4ae31-23ca-4cf1-8057-c596d605ff56', N'817d920f-48ef-4aa2-865a-cc367c37fb3b')
COMMIT TRANSACTION



BEGIN TRANSACTION

ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_Role]
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_RoleConfig]

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100062, N'PurchaseItem_Config', N'Article Achat', 0, NULL, 11111)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100062, 1) 
-- PURCHASE ITEM
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100062, N'04c4ae31-23ca-4cf1-8057-c596d605ff56', 1)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100062, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100062, 11111, 1, 0, NULL) 

ALTER TABLE [ERPSettings].[RoleConfigByRole]
    ADD CONSTRAINT [FK_RoleConfigRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[RoleConfigByRole]
    WITH NOCHECK ADD CONSTRAINT [FK_RoleConfigRole_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])

 

COMMIT TRANSACTION   
----- Marwa Functionnalities balanced line -----
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c6e123fe-503b-4694-85dc-528da3614ddf', N'Balanced-Line', 4, N'Line reliquats', N'BalancedLine', NULL, NULL, NULL, NULL, N'purchase/purchasebalance', 1, N'LIST-BALANCED_LINE')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b2045dc2-0f53-4825-ade2-b0472945117e', N'c6e123fe-503b-4694-85dc-528da3614ddf', N'817d920f-48ef-4aa2-865a-cc367c37fb3b')
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_Functionality]
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_RoleConfig]
SET IDENTITY_INSERT [ERPSettings].[FunctionalityConfig] ON
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1793, 11111, N'c6e123fe-503b-4694-85dc-528da3614ddf', 1)
SET IDENTITY_INSERT [ERPSettings].[FunctionalityConfig] OFF
ALTER TABLE [ERPSettings].[FunctionalityConfig]
    WITH NOCHECK ADD CONSTRAINT [FK_FonctionalityConfig_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionalityConfig]
    WITH NOCHECK ADD CONSTRAINT [FK_FonctionalityConfig_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
COMMIT TRANSACTION


----- Bachir Update Functionnalities -----
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]


UPDATE [ERPSettings].[Functionality] SET [FunctionalityName] = N'DELETE-RESERVEDDOCUMENTLINE_SA', [ApiRole] = N'DELETE-RESERVEDDOCUMENTLINE_SA' WHERE [IdFunctionality] = N'0911caa7-8243-422b-b0d2-6e719a304f5e'
UPDATE [ERPSettings].[Functionality] SET [FunctionalityName] = N'DELETE-DOCUMENTLINE_SA', [ApiRole] = N'DELETE-DOCUMENTLINE_SA' WHERE [IdFunctionality] = N'385e6ac2-f2b0-47aa-a2ba-edea5d6093c5'



ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION




---Fatma : add negotiation role
BEGIN TRANSACTION

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class],
 [InMenuList]) VALUES (N'937d9bd7-2975-4d4f-a063-ed11d7288dd5', N'DocumentLineNegotiationOptions', N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 15, N'Négotiation du prix', N'Price negotiation', N'Price negotiation', N'Price negotiation', N'Price negotiation', NULL, NULL, 1)


INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES],
 [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ca384b0c-2acc-4b8c-ae27-0546a6c13329', N'DocumentLineNegotiationOptions-UPDATE', 2, N'DocumentLineNegotiationOptions-UPDATE', N'DocumentLineNegotiationOptions-UPDATE', NULL, NULL, NULL, NULL, N'/purchase', 1, N'UPDATE-DOCUMENTLINENEGOTIATIONOPTIONS')


INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'17f20a22-e848-4420-b0f0-8403e6bd8a0a', N'ca384b0c-2acc-4b8c-ae27-0546a6c13329', N'937d9bd7-2975-4d4f-a063-ed11d7288dd5')

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101040, N'UPDATE-DOCUMENTLINENEGOTIATIONOPTIONS             ', N'Negotiation  du prix                              ', 0, NULL, 11111)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

INSERT INTO [ERPSettings].[RoleConfigByRole] ( [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (101040, 11111, 1, 0, NULL)

INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES (N'937d9bd7-2975-4d4f-a063-ed11d7288dd5', 101040, 1)

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) 
VALUES (101040, N'ca384b0c-2acc-4b8c-ae27-0546a6c13329', 1)

COMMIT TRANSACTION 

-----Marwa update document type ---
BEGIN TRANSACTION
UPDATE [Sales].[DocumentType] SET [Label]='Facture achat' , [Description]='Facture achat' WHERE [CodeType]=N'FO-PU'

COMMIT TRANSACTION