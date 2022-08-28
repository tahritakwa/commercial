/*
This script was created by Visual Studio on 19/12/2019 at 15:52.
Run this script on ..MasterGuidRoleFix (SPARKIT\bdiop) to make it the same as 192.168.1.182.StarkERP (sa).
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

ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_Functionality]
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_RoleConfig]
ALTER TABLE [ERPSettings].[UserRole] DROP CONSTRAINT [FK_UserRole_Role]
ALTER TABLE [ERPSettings].[UserRole] DROP CONSTRAINT [FK_UserRole_User]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_Role]
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_RoleConfig]
ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [FK_Information_RoleInfo]
ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [FK_Role_RoleInfo]
ALTER TABLE [ERPSettings].[ModuleConfig] DROP CONSTRAINT [FK_ModuleConfig_Module]
ALTER TABLE [ERPSettings].[ModuleConfig] DROP CONSTRAINT [FK_ModuleConfig_RoleConfig]
ALTER TABLE [ERPSettings].[RoleConfig] DROP CONSTRAINT [FK_RoleConfigCategory_RoleConfig]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]


DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100011
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100012
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100013
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100014
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100015
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100016
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100017
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100018
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100019
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100020
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100021
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100022
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100023
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100024
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100025
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100026
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100027
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100028
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100029
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100030
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100031
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100032
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100033
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100034
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100036
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100037
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100038
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100039
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100041
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100042
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100043
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100044
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100045
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100046
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100047
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100048
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100049
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100051
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100052
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100053
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100054
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100055
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100056
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100057
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100058
--DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 11111
--DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 22222
--DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 33333
--DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100006

DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100011
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100012
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100013
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100014
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100015
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100016
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100017
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100018
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100019
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100020
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100021
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100022
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100023
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100024
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100025
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100026
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100027
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100028
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100029
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100030
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100031
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100032
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100033
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100034
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100036
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100037
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100038
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100039
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100041
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100042
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100043
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100044
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100045
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100046
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100047
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100048
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100049
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100051
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100052
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100053
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100054
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100055
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100056
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100057
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100058
--DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 11111
--DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 22222
--DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 33333
--DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100006

DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100011
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100012
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100013
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100014
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100015
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100016
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100017
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100018
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100019
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100020
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100021
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100022
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100023
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100024
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100025
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100026
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100027
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100028
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100029
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100030
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100031
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100032
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100033
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100034
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100036
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100037
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100038
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100039
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100041
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100042
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100043
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100044
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100045
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100046
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100047
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100048
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100049
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100051
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100052
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100053
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100054
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100055
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100056
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100057
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100058
--DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 11111
--DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 22222
--DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 33333
--DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100006

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100011, N'Devis', N'Devis', 0, NULL, 33333)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100012, N'Item_Config', N'Article', 0, NULL, 22222)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100013, N'Warehouse_Config', N'Depot', 0, NULL, 22222)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100014, N'Inventory_Config', N'Inventaire', 0, NULL, 22222)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100015, N'StockMovement_Config', N'Mouvement de stock', 0, NULL, 22222)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100016, N'Supplier_Config', N'Fournisseur', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100017, N'PurchaseRequest_Config', N'Demande dachat', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100018, N'PriceRequest_Config', N'Demande de prix', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100019, N'OrderProject_Config', N'Réapprovisionnement', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100020, N'BE_Config', N'Bon dentrée', 0, NULL, 100100)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100021, N'BS_Config', N'Bon de sortie', 0, NULL, 100100)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100022, N'Active_Config', N'Active', 0, NULL, 44444)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100023, N'PurchaseOrder_Config', N'Commande', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100024, N'BL_Config', N'Bon de livrairon', 0, NULL, 33333)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100025, N'Facture_config', N'Facture', 0, NULL, 33333)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100026, N'Avoir_Config', N'Avoir', 0, NULL, 33333)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100027, N'Commande_Config', N'Commande', 0, NULL, 33333)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100028, N'PurchaseAsset_Config', N'Avoir', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100029, N'PurchaseInvoice_Config', N'Facture', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100030, N'PurchaseFinalOrder_Config', N'Commande Finale', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100031, N'PurchaseDelivery_Config', N'Bon de reception', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100032, N'PurchaseQuotation_Config', N'Devis', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100033, N'Client_Config', N'Client', 0, NULL, 33333)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100034, N'SearchItem_Config', N'Recherche Articles', 0, NULL, 33333)


--INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100035, N'SearchItem_Config', N'Recherche Articles', 0, NULL, 33333)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100036, N'SalesAsset_SaUpdate_Config', N'Modification Avoir Validé', 0, NULL, 33333)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100037, N'SalesInvoice_SaUpdate_Config', N'Modification Facture Validée', 0, NULL, 33333)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100038, N'SalesOrder_SaUpdate_Config', N'Modification Commande Validée', 0, NULL, 33333)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100039, N'SalesQuotation_SaUpdate_Config', N'Modification Devis Validé', 0, NULL, 33333)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100041, N'BS_SaUpdate_Config', N'Modification BS - SA', 0, NULL, 22222)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100042, N'BE_SaUpdate_Config', N'Modification BE - SA', 0, NULL, 22222)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100043, N'PurchaseDelivery_SaUpdate_Config', N'Modification Bon de reception Validé', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100044, N'PurchaseAsset_SaUpdate_Config', N'Modification Avoir Achat Validé', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100045, N'PurchaseInvoice_SaUpdate_Config', N'Modification Facture Achat Validé', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100046, N'PurchaseOrder_SaUpdate_Config', N'Modification Commande Achat Validé', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100047, N'PurchaseFinalOrder_SaUpdate_Config', N'Modification Commande Final Achat Validé', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100048, N'PurchaseQuotation_SaUpdate_Config', N'Modification Devis Achat Validé', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100049, N'PurchaseBudget_SaUpdate_Config', N'Modification Demande Achat Validé', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100051, N'PurchaseRequest_SaUpdate_Config', N'Modification Demande Achat Validé', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100052, N'PurchaseDelivery_SaPrint_Config', N'Impression Bon de reception ', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100053, N'PurchaseDelivery_SaValidate_Config', N'Validation Bon de reception ', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100054, N'PurchaseDeliveryPrice_SaList_Config', N'Affichage Prix de revient ', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100055, N'ItemPrice_SaUpdate_Config', N'Modification Prix Article - SA', 0, NULL, 22222)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100056, N'EncoursClient_SaList_Config', N'Affichage Encours Client - SA', 0, NULL, 33333)





SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF


INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'd438fbad-7305-4dad-ab44-a4fb84318a83', 100011, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'e30959c4-61bb-457e-b44e-271c04a9e49d', 100011, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'e0367d41-2d4b-4f85-9e7a-244803c29221', 100011, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100011, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100011, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 100012, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 100012, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100012, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100012, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 100013, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'610782eb-cc27-4bde-b2be-b86878fecbdd', 100013, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100013, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100013, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 100014, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'ff007474-a447-4c92-8f6a-265d5c08ff10', 100014, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100014, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100014, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 100015, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'27d0eb9e-0653-459f-a06f-d2e3c6ad8a9b', 100015, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100015, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100015, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100016, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'9b03405e-cb73-4c79-949e-9cd216ece4c4', 100016, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100016, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100016, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100017, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'fdc3ed27-ac8a-4256-a340-ce96961358d6', 100017, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100017, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100017, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'd438fbad-7305-4dad-ab44-a4fb84318a83', 100018, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'87b84a91-98fd-49f1-80f3-04630d73ed79', 100018, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100019, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'1b8c288b-6fb4-4816-964b-ce7b89339db9', 100019, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'ae4ae5f7-280b-4a93-9330-96033bfa303a', 100022, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'159000fc-7090-48c5-bcc2-8e8cb688e8a9', 100022, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'fa2ef934-cf6b-44e6-a15d-08f924a6d903', 100022, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'9ccf8314-260b-4550-80c8-ff4969eede46', 100021, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'1ad10d89-f0bc-415d-9979-a535cf29429f', 100021, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'9ccf8314-260b-4550-80c8-ff4969eede46', 100020, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'3b276df5-4e7f-4659-905f-55192a9489c3', 100020, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100023, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'55dd99c2-f37c-4a1b-b8cf-1e44423f3018', 100023, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'361806f0-f88e-4b5e-bda6-68c34fb1faea', 100027, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100027, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'e0367d41-2d4b-4f85-9e7a-244803c29221', 100027, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'd438fbad-7305-4dad-ab44-a4fb84318a83', 100027, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100027, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'3fbbf8c3-1ed2-445e-b6e9-752c10eb49c9', 100026, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100026, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'e0367d41-2d4b-4f85-9e7a-244803c29221', 100026, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'd438fbad-7305-4dad-ab44-a4fb84318a83', 100026, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100026, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'e55c8fd9-ac89-4986-9291-afe0d5c02490', 100025, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100025, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'e0367d41-2d4b-4f85-9e7a-244803c29221', 100025, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'd438fbad-7305-4dad-ab44-a4fb84318a83', 100025, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100025, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'783fe0a6-0d38-43a3-8b41-42039da2ed3f', 100024, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100024, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'e0367d41-2d4b-4f85-9e7a-244803c29221', 100024, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'd438fbad-7305-4dad-ab44-a4fb84318a83', 100024, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100024, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100028, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'fdc3ed27-ac8a-4256-a340-ce96961358d6', 100028, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100028, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100028, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100029, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'fdc3ed27-ac8a-4256-a340-ce96961358d6', 100029, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100029, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100029, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100030, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'fdc3ed27-ac8a-4256-a340-ce96961358d6', 100030, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100030, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100030, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100031, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'fdc3ed27-ac8a-4256-a340-ce96961358d6', 100031, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100031, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100031, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100032, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100032, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100032, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'22327CE7-B81C-4C0F-AC75-B1C4CED325C1', 100032, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'D438FBAD-7305-4DAD-AB44-A4FB84318A83', 100033, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'E30959C4-61BB-457E-B44E-271C04A9E49D', 100033, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100033, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100033, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'05462ee4-4426-45de-9386-6a61473b725d', 100034, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'2193DDF9-9631-4AAF-BB15-5F95FC25E44F', 100034, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'0934B53E-48DD-4693-BCA2-F6A5CE39B359', 100034, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'D438FBAD-7305-4DAD-AB44-A4FB84318A83', 100034, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100034, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100034, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'8A2E43C4-0113-4BA0-92AB-3FBD79867C3A', 100025, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'93EF9743-1CE5-4BA0-9DFF-4AA13AF4B01F', 100025, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'964167CB-03F3-4CDB-9B52-87564F6DDA2F', 100025, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'D1F0441A-A83F-414A-A106-9539A26A58EF', 100025, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'8A2E43C4-0113-4BA0-92AB-3FBD79867C3A', 100029, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'93EF9743-1CE5-4BA0-9DFF-4AA13AF4B01F', 100029, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'964167CB-03F3-4CDB-9B52-87564F6DDA2F', 100029, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'D1F0441A-A83F-414A-A106-9539A26A58EF', 100029, 1)


INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'3FBBF8C3-1ED2-445E-B6E9-752C10EB49C9', 100036, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'E55C8FD9-AC89-4986-9291-AFE0D5C02490', 100037, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'361806F0-F88E-4B5E-BDA6-68C34FB1FAEA', 100038, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'E0367D41-2D4B-4F85-9E7A-244803C29221', 100039, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'1AD10D89-F0BC-415D-9979-A535CF29429F', 100041, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'3B276DF5-4E7F-4659-905F-55192A9489C3', 100042, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'A0092569-9901-4FEA-96E1-4CD96EA0EAED', 100043, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'0AA2ABAA-8057-4BD3-8A64-D6C16552AAF6', 100044, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'BC471D71-863E-47A0-95F4-C2E1595C2BD9', 100045, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'55DD99C2-F37C-4A1B-B8CF-1E44423F3018', 100046, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'8786AC1B-297A-410C-8F2A-4FA850ECDBBA', 100047, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'22327CE7-B81C-4C0F-AC75-B1C4CED325C1', 100048, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'1B8C288B-6FB4-4816-964B-CE7B89339DB9', 100049, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'FDC3ED27-AC8A-4256-A340-CE96961358D6', 100051, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'A0092569-9901-4FEA-96E1-4CD96EA0EAED', 100052, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'A0092569-9901-4FEA-96E1-4CD96EA0EAED', 100053, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'A0092569-9901-4FEA-96E1-4CD96EA0EAED', 100054, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'0934B53E-48DD-4693-BCA2-F6A5CE39B359', 100055, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'05462EE4-4426-45DE-9386-6A61473B725D', 100056, 1) 


INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100011, N'4095f424-c8be-4707-9e22-5cdcb62a3eba', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100011, N'5281d288-b1b4-4e3e-9a00-5d5ab4437019', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100011, N'44b001e5-5208-4cd9-ab76-7d7b19cef3d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100011, N'baaaea28-f16e-43d5-a4b5-a816cbcb1262', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100011, N'5f410902-9c3b-47db-b648-e154b97b09d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100011, N'CCD9F13B-0921-4758-9E91-7A2DB2D9E1FB', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100011, N'18FBB831-3560-4576-A594-6F16DDD1DF05', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100011, N'CCD9F13B-0921-4758-9E91-7A2DB2D9E1FB', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100011, N'3E152B0F-DC4C-4416-8352-8569E8343FE9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100012, N'2806f1cd-9742-4811-aff4-1ba3268ca6e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100012, N'd006adea-6c46-421a-96d6-2c90fc2b5679', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100012, N'4d5682dc-047a-4c47-8de1-b57cdd620cb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100012, N'a9f6e6f8-a198-4009-9d3f-bbf255f240e3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100012, N'edb77114-1960-4772-88a3-e32307dcf0a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100013, N'a3ea8642-aa44-45f4-9b53-060b114819e5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100013, N'b3779102-6613-4722-b1dc-1dee85ba2064', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100013, N'd10a78e3-74fd-42c0-84b5-540cca3bbb1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100013, N'2b24a538-6ada-4cf2-8c38-69a13782bef4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100013, N'248be8c8-6ac0-4f40-a72d-ee946afba9af', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100014, N'c0916b52-e9a6-40a6-a00a-02c8aa4522c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100014, N'933e29fd-f6fb-4317-b0c7-5cbb7655a06e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100014, N'dbf5545e-ab61-438b-8a50-606995d1f30b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100014, N'3e9cb15d-18a0-4f6b-81b8-8350b97f2d92', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100014, N'26106a36-d4fa-4b25-8437-9355039afbd2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100014, N'ac90f3e3-6a01-4868-be25-bffe6d93ac8e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100014, N'63a7471e-ccea-4422-bc2b-c1acbf9066b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100014, N'30fd5982-45d0-485c-a969-c672f21b7358', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100014, N'6ff78f47-541e-4bab-a71c-f0350adb3543', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100015, N'07d35985-0229-40c3-aaed-0fce364b33c1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100015, N'baca0b66-1cfd-469f-8eed-5442857d76b5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100015, N'34a0f7d3-7f88-4de8-8c29-a1827670a940', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100015, N'8afd823d-0311-48c0-b4e0-a2c90e1b48f4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100015, N'78cd9a43-83e5-4e17-971f-c7fb05de9bcf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100015, N'621fe63b-cf18-454b-8404-e8bec47154b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100016, N'06048d73-4dd8-42e1-b095-806c636ff9f0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100016, N'7bf06c1a-3e9b-4aa8-9b2e-8a4f81cd367c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100016, N'ba03a869-330e-4ef3-b2b0-a8fcf466bb2e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100016, N'bd4359bf-c1d2-4e70-87b8-e4c77839b2ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100017, N'9e222535-8111-4ded-b5c0-2de91ae52e92', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100017, N'66754c61-6ecd-44cf-9ae4-543635e0d460', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100017, N'4f87e0bd-8e17-4956-a3bf-5bbe6f75221c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100017, N'45eccc6e-6a8e-4a00-aee1-b046e94f7b68', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100017, N'f9e4c5cf-70e0-4881-b8e0-fc4de96afd82', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100018, N'a8158cb8-7a34-4267-9e33-1b138b6fea2f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100018, N'fc8a73be-4987-4cd7-b980-39e5b658f2aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100018, N'8cae7fb4-1f9a-4add-ab1e-a466c2cbd702', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100018, N'1fbc4b46-46d4-4e3c-afd6-e007dcef5205', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100018, N'1db4fb60-19a8-410d-9b19-f8448d480dc7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100019, N'ed89fcb1-6cba-4a58-ac13-1da7b1e897c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100019, N'288e8c5c-d015-4000-a5f8-2c2aac406922', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100019, N'b0503a12-05ee-4c0b-aeff-a90cbd09962c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100019, N'2619edd7-d221-43d7-832b-c1c761df8ac8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100022, N'd676cd58-7d69-4eec-b6f9-0cb34391d9f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100022, N'3798b3ec-5f8c-4aab-9109-1d92a0b557c1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100022, N'0d84d845-7b4d-4c1f-bd29-29f870cbcf50', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100022, N'6755075e-2096-45d5-9b09-48c50d51660f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100022, N'c6ccb699-182c-4ec6-8f40-4a61032b78a8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100022, N'b00708a6-8e38-4cbd-9bd1-5d6cb382cf35', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100022, N'2ed16d00-54cf-40d9-a6ae-8ee4d26f9a32', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100022, N'eca3ffb8-c1fb-4212-a543-a04e9e396784', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100022, N'9454ba64-87ca-4ffd-b497-bb8e5eea8639', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100022, N'e59dbc98-5393-4fc4-8996-c05fe4852558', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100022, N'dcf849b9-583f-4a23-b2c0-d3298ea74865', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100022, N'2f7a31cf-6236-4eb4-b1d1-ee065980741a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100021, N'009e783c-f124-4501-b596-1b2789d14e4e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100021, N'c33f0629-2e33-47f0-9516-4770622c474e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100021, N'ad7fa573-0990-40ed-8995-50405cb9b110', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100021, N'17851920-0697-4d72-a2ef-8bbef73d733e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100021, N'85305898-2b4a-4d27-a392-d48415f0184a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100021, N'35b9c1dd-a489-46b2-82b1-dbbe1a60ba46', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100020, N'29b225b7-6a86-4d17-aa32-f158cd0c43d5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100020, N'9176e90e-ea64-4a51-8868-c845a1b8cacb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100020, N'4ce18dc6-6f90-4f2c-980f-434c58a376b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100020, N'52755d07-ac8b-47c0-8c6f-78419ece74c9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100020, N'91f6af0a-3880-47e9-a91c-99a2e6b9aa74', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100020, N'cfe2d3c0-a510-463b-8d36-af09931373bf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100023, N'746ae716-0bd2-46e7-b7ef-35f1f5f7fb15', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100023, N'dd748a92-303d-45fa-82c5-cb6697329f29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100023, N'30ed6b09-268f-4e07-9bdf-d003d7d32502', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100023, N'46e960cd-92c8-4657-b8f1-e066ed8005ff', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100027, N'5281d288-b1b4-4e3e-9a00-5d5ab4437019', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100027, N'97dc1c97-a947-4171-95be-59fa23ac90dc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100027, N'd473bcce-1332-47fb-95a0-1bf7b479b5ae', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100027, N'45071ef7-21bd-483b-9b88-9711dcab397f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100027, N'baaaea28-f16e-43d5-a4b5-a816cbcb1262', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100027, N'cf7c8c64-b8cf-41c0-8bb3-f65ac73c0147', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100027, N'9e2459c1-6e9b-4ff2-ab99-7d8c83dbfae8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100027, N'5f410902-9c3b-47db-b648-e154b97b09d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100027, N'44b001e5-5208-4cd9-ab76-7d7b19cef3d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100027, N'16cc4069-dc25-49d7-b272-dcfc28549301', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100026, N'9e2459c1-6e9b-4ff2-ab99-7d8c83dbfae8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100026, N'44b001e5-5208-4cd9-ab76-7d7b19cef3d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100026, N'5281d288-b1b4-4e3e-9a00-5d5ab4437019', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100026, N'a359eaa9-7f55-4f64-aaa7-bcb07115cfc3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100026, N'0cca5b44-467a-4807-a0e0-d583c693d776', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100026, N'1428c6ec-25d9-477d-ab4e-efae61b2377d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100026, N'baaaea28-f16e-43d5-a4b5-a816cbcb1262', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100026, N'017a0e7d-7829-4326-bdb7-e285e7aae9bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100026, N'45071ef7-21bd-483b-9b88-9711dcab397f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100026, N'5f410902-9c3b-47db-b648-e154b97b09d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'5281d288-b1b4-4e3e-9a00-5d5ab4437019', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'5d007fd4-976f-4f44-b580-50a2afe0815f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'a35adf1d-f4f6-494f-975a-0492fffa70db', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'45071ef7-21bd-483b-9b88-9711dcab397f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'baaaea28-f16e-43d5-a4b5-a816cbcb1262', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'c6e0724d-fc34-4235-b0fd-f5098312de8d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'9e2459c1-6e9b-4ff2-ab99-7d8c83dbfae8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'5f410902-9c3b-47db-b648-e154b97b09d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'44b001e5-5208-4cd9-ab76-7d7b19cef3d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'86ef34f3-b62f-4d0a-a673-bfecd5a8730e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100024, N'8e3189a1-c37a-4004-86bd-6c8189a9b764', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100024, N'5281d288-b1b4-4e3e-9a00-5d5ab4437019', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100024, N'5c6b6ad9-1b90-4d2b-b36e-2ba2cf5075fc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100024, N'45071ef7-21bd-483b-9b88-9711dcab397f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100024, N'baaaea28-f16e-43d5-a4b5-a816cbcb1262', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100024, N'0cee8cd0-1ebf-48fc-a517-ea387ea80b9f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100024, N'9e2459c1-6e9b-4ff2-ab99-7d8c83dbfae8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100024, N'5f410902-9c3b-47db-b648-e154b97b09d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100024, N'44b001e5-5208-4cd9-ab76-7d7b19cef3d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100024, N'2e40ab73-0553-47b0-9eb5-d9eb534e05b1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100017, N'4724AC7E-70B1-458F-ACF9-A8629521FAA3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100023, N'888C5233-B854-478E-B3E6-860EB288A09C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100024, N'2755658F-CB5E-41E9-8298-C97721BDBA77', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'603BEED9-C3C3-46E1-8560-19706553C33C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100026, N'CD9D2C5F-6E4A-4F72-8B9B-592CE681BB0D', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100027, N'CC05F689-5A26-4084-957F-468FFA646D39', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100028, N'84306D93-5BF1-4D7C-A6EC-081F9E38B4B3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100028, N'88888A3E-9ECB-43D6-9FCE-099336B2A534', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100028, N'33DC2049-6B77-4753-B6AA-6C3A9BA81A30', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100028, N'860DB2D3-2007-4FE3-A622-96EFAEA97956', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100028, N'B7E30A6E-02BB-4B23-8762-A0121459BF94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100028, N'C72D3E91-40D8-4E04-B9CB-B0E1E733D11F', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100028, N'53D212DD-B678-4888-9208-B66FA0042FF2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100028, N'A97AFFBE-B4DA-40F6-8055-F493CEF4D9E5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'04FF068E-70BF-43EB-AB00-1C8A7FCFD98E', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'86DE038F-E73A-4CF8-9D0C-3C488130396E', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'85E9BAB0-C315-45B8-8922-51FAEB4A7A9C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'7AE52D61-2E8F-40C1-9B16-55A1B016A286', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'DF22E2E1-73DF-459B-826B-630BF62E8394', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'B8AFA156-3522-420C-9118-C7FCE2208FCB', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'02268EC7-C879-47B8-B174-DE3C359EFF7A', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'3761B8FD-6B23-4D86-81DE-EB6DE7891A5A', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100030, N'B8D98F19-8E6B-4AD2-BE55-09496026A374', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100030, N'2373A969-C468-4C48-B26B-371641253486', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100030, N'1D587003-8ABD-4E4C-A096-5FA386FEB25E', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100030, N'EBE5D62C-129D-42A3-8097-809CD113944F', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100030, N'2A12CF61-2FDA-48D3-A5A2-850BF0DEE8A3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100030, N'CC9E11CB-CE75-4B13-9453-87DE0759B42A', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100031, N'3FDFFF1B-D420-4EF3-82D5-114965A4BBB3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100031, N'E836FF6B-6648-40F2-A2DC-1C160027EF4D', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100031, N'71C72458-D0D0-473F-90EE-3BBDCE5BEDD9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100031, N'A4B6168D-3589-4DFA-8A92-523AC1D03D99', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100031, N'0C2413E5-E633-4D8F-94F8-56574ED1CC05', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100031, N'896B337D-445B-453A-B6CE-5A64BF11B65D', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100031, N'30D722CE-E903-4FBB-A047-B3E6F50A5D60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100031, N'4FFCB62C-E083-4E8D-84F1-C5CB0BA0E182', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100032, N'7EF88A1E-AA1D-4253-AA3A-2A6D83DC4DB9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100032, N'1DC84C88-352F-488C-A927-58032F88A3F4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100032, N'AEB6253E-2532-4873-B8DF-9AC559908658', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100032, N'646A1DA2-F25A-4782-8430-A7C7E8762DA3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100032, N'D04BDD1C-7BA9-4552-A50C-A8C30EC313F2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100032, N'F8466FF9-612F-4FE3-8A38-F460CA9AD05F', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100027, N'14435987-A010-4981-AA0F-80D1E4498D4F', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100027, N'C2F64A4D-0314-4F9C-BC62-871E1CB9A15E', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100027, N'A30379D3-1C9C-4716-A4C4-A7DA7C2D59D2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100024, N'520AF6C2-5F31-488A-8970-0A390B7C9C34', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100024, N'C8AE1043-E193-410F-A0CE-51A673B812E0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100024, N'21C8A894-F7D6-4747-BBC4-C2B21E733568', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'723EF204-7DD0-4A0D-9D5C-0FE82ECAA8E2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'51897E01-9B8A-473A-B20B-4D1B5F572D87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'B7272BCB-3B40-455B-93AA-5EBFA077CF5C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100026, N'E7481CAE-21D5-4239-BA7A-60EAD03573C3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100026, N'80F4E203-94E3-400B-A7E7-6C08A7E132E9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100026, N'E71CF7C7-AC92-4F60-88A4-C2EA3CD6A48A', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100033, N'89E4F583-900B-43EC-AB63-34E838F35A81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100033, N'B6D86E76-3EF6-48F6-873B-4CDF3875BF29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100033, N'7EFD7FBB-8AB1-4046-8267-753DB514C23B', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100033, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100033, N'090A15EF-8766-435C-89A4-78AA54FDA44D', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100033, N'441C0141-35FF-4233-9945-E797233F4FA4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100034, N'd84dd72d-7b49-42a8-8c05-f7ac1b89e292', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100034, N'f67dc3da-3462-4d05-89a6-26fa0ea757ef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100034, N'26fcb95c-1250-489d-ac10-ac96a29d9696', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100034, N'1b7b3a4e-0bc7-46a2-8b5d-bec399467208', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100034, N'b24a6a98-4873-4078-9980-893bc95f12ee', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100034, N'07c9865f-1fc0-4d43-81cc-2c7e38654e51', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100011, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100012, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100013, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100014, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100015, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100016, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100017, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100018, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100019, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100020, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100021, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100022, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100023, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100024, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100026, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100027, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100028, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100030, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100031, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100032, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100034, N'532B7B55-C3D5-47CA-988D-7B7E6A3FC219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'49DCD5DA-3149-42B7-9861-CAB2AA575B63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'681C3F06-93EC-4D82-928A-21425D6DBB91', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'87DDBE2E-D742-4DD7-816C-D4D1C9287CCC', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'F1E36CC2-8A6B-4B08-80ED-465EBECA3DE3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'B6875160-0302-4D15-9BD9-3431E21AEB24', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'93481ABC-8BC8-4B26-B02B-D2EB935903D6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'45B5E4AC-25C1-42A7-963D-2491B4D13ECE', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'B22348A4-A36E-4D01-B2E7-578697D4A8E9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'0B2784FB-2158-461F-A83C-08B221CEA5C7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'42DA2EBE-FB35-439A-92C5-F404C3E0A12D', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'9FF9F2D1-8AF0-4FAC-A111-9ACF84207453', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'D5556E17-27AD-44A0-B80D-2FD734A4C2F7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'B6D86E76-3EF6-48F6-873B-4CDF3875BF29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'65E27BCE-38E0-4497-B95A-39024DB06652', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'1C969E3F-5FB9-42C1-8A39-8C84122ADED1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'B9875A52-3204-4D50-8C95-08B7018586EA', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'F259CE28-7DAD-46F1-ADF2-24E6436D79FA', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'207733D4-37A4-4B04-A973-27FCDE23CC61', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'EB8E51F1-2239-43C2-B606-3547A0F96EE7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'3B3AF5F0-6E91-4CDE-A99F-427A96B8DB60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'4D5CB5DC-09EA-494D-BC19-6625F98E98C7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'8B5E351F-1067-4EEB-AC41-9151079DE165', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'1A33A525-BC0D-4974-A271-9779BA13B699', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'44142E0E-7505-4961-9402-9A89FBB12CA7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'C6E5F364-F6EA-4E98-AD9C-D508CB27BC02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'6FF63D84-12C2-4D82-9CE1-E7E09EC5B341', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'18FACDE4-8D07-47DB-B7BE-EC800B01751B', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'6A74F264-0C50-4201-8772-F71229BBF01C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'49DCD5DA-3149-42B7-9861-CAB2AA575B63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'681C3F06-93EC-4D82-928A-21425D6DBB91', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'87DDBE2E-D742-4DD7-816C-D4D1C9287CCC', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'F1E36CC2-8A6B-4B08-80ED-465EBECA3DE3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'B6875160-0302-4D15-9BD9-3431E21AEB24', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'93481ABC-8BC8-4B26-B02B-D2EB935903D6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'45B5E4AC-25C1-42A7-963D-2491B4D13ECE', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'B22348A4-A36E-4D01-B2E7-578697D4A8E9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'0B2784FB-2158-461F-A83C-08B221CEA5C7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'42DA2EBE-FB35-439A-92C5-F404C3E0A12D', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'9FF9F2D1-8AF0-4FAC-A111-9ACF84207453', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'D5556E17-27AD-44A0-B80D-2FD734A4C2F7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'B6D86E76-3EF6-48F6-873B-4CDF3875BF29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'65E27BCE-38E0-4497-B95A-39024DB06652', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'1C969E3F-5FB9-42C1-8A39-8C84122ADED1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'B9875A52-3204-4D50-8C95-08B7018586EA', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'F259CE28-7DAD-46F1-ADF2-24E6436D79FA', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'207733D4-37A4-4B04-A973-27FCDE23CC61', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'EB8E51F1-2239-43C2-B606-3547A0F96EE7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'3B3AF5F0-6E91-4CDE-A99F-427A96B8DB60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'4D5CB5DC-09EA-494D-BC19-6625F98E98C7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'8B5E351F-1067-4EEB-AC41-9151079DE165', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'1A33A525-BC0D-4974-A271-9779BA13B699', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'44142E0E-7505-4961-9402-9A89FBB12CA7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'C6E5F364-F6EA-4E98-AD9C-D508CB27BC02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'6FF63D84-12C2-4D82-9CE1-E7E09EC5B341', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'18FACDE4-8D07-47DB-B7BE-EC800B01751B', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'6A74F264-0C50-4201-8772-F71229BBF01C', 1)

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100011, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100012, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100013, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100014, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100015, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100016, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100017, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100018, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100019, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100020, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100021, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100022, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100023, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100024, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100026, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100027, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100028, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100030, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100031, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100032, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100034, N'4046572A-AB91-4548-BCFC-7747EB7DF41C', 1)

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100036, N'60510b13-e60f-4802-a0df-2f96e3ddd31b', 1) 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100037, N'ff7e3955-bea4-4ff8-8d54-b50c358a6b64', 1) 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100038, N'03bd4fe6-a503-47b4-b67f-9fb1efc1b11d', 1) 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100039, N'2f70b149-321e-48cd-8c01-daa0125bc7e5', 1) 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100041, N'd6deb272-9e33-430e-bebd-77b8d131d624', 1) 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100042, N'71cd9d72-3dfb-4577-a350-99a2cf36b146', 1) 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100043, N'1de55d52-1dcd-44ec-9938-54edb726274f', 1) 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100044, N'5b45e026-a699-4bd6-8b72-7e6eb93a7976', 1) 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100045, N'9872c5e7-c954-465d-ae44-5b5f25acbe6c', 1) 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100046, N'885a848d-b8d2-4811-9013-373a5e539183', 1) 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100047, N'c48591bf-ac03-4d47-9a86-dc0824a1e7aa', 1) 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100048, N'c2c8274f-d78a-49ce-9fc4-a654fd6fb200', 1) 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100049, N'78a46c87-7a2d-4afc-98a8-c73ed2510f31', 1) 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100051, N'7d3e9af7-c97e-41f3-bbe0-1f7f763460cd', 1) 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100052, N'c8d2a578-8893-4567-adb0-5a7aa636e6ac', 1) 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100053, N'afb5a8fb-744f-4525-b799-707c3d070763', 1) 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100054, N'147118cf-5dcf-4aa8-8577-1f28a610ca4a', 1) 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100055, N'127a7f62-1605-44be-b6a0-113d76e8d172', 1) 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100056, N'c822c8ea-b523-4f7e-b501-5835bb798a7e', 1)



INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100011, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100012, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100013, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100014, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100015, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100016, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100017, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100018, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100019, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100020, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100021, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100022, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100023, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100024, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100025, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100026, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100027, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100028, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100029, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100030, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100031, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100032, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100033, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100034, 1, 1, 0, NULL)


INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100036, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100037, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100038, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100039, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100041, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100042, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100043, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100044, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100045, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100046, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100047, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100048, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100049, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100051, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100052, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100053, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100054, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100055, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100056, 1, 1, 0, NULL) 


ALTER TABLE [ERPSettings].[UserRole]
    ADD CONSTRAINT [FK_UserRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[UserRole]
    ADD CONSTRAINT [FK_UserRole_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[RoleConfigByRole]
    ADD CONSTRAINT [FK_RoleConfigRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[RoleConfigByRole]
    WITH NOCHECK ADD CONSTRAINT [FK_RoleConfigRole_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
ALTER TABLE [ERPSettings].[RoleInfo]
    ADD CONSTRAINT [FK_Information_RoleInfo] FOREIGN KEY ([IdInformation]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[RoleInfo]
    ADD CONSTRAINT [FK_Role_RoleInfo] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id])
ALTER TABLE [ERPSettings].[ModuleConfig]
    WITH NOCHECK ADD CONSTRAINT [FK_ModuleConfig_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleConfig]
    WITH NOCHECK ADD CONSTRAINT [FK_ModuleConfig_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
ALTER TABLE [ERPSettings].[RoleConfig]
    WITH NOCHECK ADD CONSTRAINT [FK_RoleConfigCategory_RoleConfig] FOREIGN KEY ([IdRoleConfigCategory]) REFERENCES [ERPSettings].[RoleConfigCategory] ([Id])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[FunctionalityConfig]
    WITH NOCHECK ADD CONSTRAINT [FK_FonctionalityConfig_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionalityConfig]
    WITH NOCHECK ADD CONSTRAINT [FK_FonctionalityConfig_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
COMMIT TRANSACTION

---- Bachir Treasury ---

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_Role]
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_RoleConfig]


SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100057, N'Treasury_Config', N'Trésorerie', 0, NULL, 100009)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

INSERT INTO [ERPSettings].[RoleConfigByRole] ( [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100057, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ( [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100057, 100009, 1, 0, NULL)


INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES (N'87beb2e4-efeb-4341-b96b-6e6bec8a308a', 100057, 1)


INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100057, N'8c6a2182-38d3-4782-b68c-41ffa5328b95', 1)


ALTER TABLE [ERPSettings].[RoleConfigByRole]
    ADD CONSTRAINT [FK_RoleConfigRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE

ALTER TABLE [ERPSettings].[RoleConfigByRole]
    WITH NOCHECK ADD CONSTRAINT [FK_RoleConfigRole_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
COMMIT TRANSACTION	


---- Bachir Etat de Controle ---

BEGIN TRANSACTION

ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_Role]
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_RoleConfig]


SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100058, N'DocumentControl_Config', N'Etat de Controle', 0, NULL, 33333)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

INSERT INTO [ERPSettings].[RoleConfigByRole] ( [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100058, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ( [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100058, 33333, 1, 0, NULL)

INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES (N'0271afdd-63e8-4b4c-884f-960dcb719c7c', 100058, 1)

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100058, N'9df9abd1-7ec7-4809-a1ee-f2f817aab699', 1)

ALTER TABLE [ERPSettings].[RoleConfigByRole]
    ADD CONSTRAINT [FK_RoleConfigRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[RoleConfigByRole]
    WITH NOCHECK ADD CONSTRAINT [FK_RoleConfigRole_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])

COMMIT TRANSACTION	



---- Bachir Sales Delivery Update Sa ---

BEGIN TRANSACTION

ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_Role]
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_RoleConfig]

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100059, N'SalesDelivery_SaUpdate_Config', N'Modification BL Validé', 0, NULL, 33333)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF


INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'D438FBAD-7305-4DAD-AB44-A4FB84318A83', 100059, 1) 

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100059, N'BE512744-B639-4F8A-AB84-E7F568FF5289', 1)

INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100059, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100059, 33333, 1, 0, NULL) 


ALTER TABLE [ERPSettings].[RoleConfigByRole]
    ADD CONSTRAINT [FK_RoleConfigRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[RoleConfigByRole]
    WITH NOCHECK ADD CONSTRAINT [FK_RoleConfigRole_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])

COMMIT TRANSACTION    


---- Bachir Role Fix  ---

BEGIN TRANSACTION

ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_Role]
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_RoleConfig]

DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 100019
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 100019
DELETE FROM [ERPSettings].[RoleConfig] WHERE [ERPSettings].[RoleConfig].[Id] = 100019

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100060, N'OrderProject_Config', N'Réapprovisionnement', 0, NULL, 11111)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101038, N'DeleteReservedDocumentLine_Config', N'Suppression Ligne de document reservée', 0, NULL, 33333)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101039, N'DeleteDocumentLine_Config', N'Suppression Ligne de document ', 0, NULL, 33333)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF


INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'5c413b36-8269-447a-a462-210e9f0fd93b', 100060, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'817D920F-48EF-4AA2-865A-CC367C37FB3B', 100060, 1) 


INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'D438FBAD-7305-4DAD-AB44-A4FB84318A83', 101038, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'783FE0A6-0D38-43A3-8B41-42039DA2ED3F', 101038, 1) 

INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'D438FBAD-7305-4DAD-AB44-A4FB84318A83', 101039, 1) 
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'783FE0A6-0D38-43A3-8B41-42039DA2ED3F', 101039, 1) 


-- Reappro
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100060, N'a8957afa-099e-477c-88aa-2c36d681d3b1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100060, N'1bd6407a-fda2-4f93-8992-528d4157473d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100060, N'bdb8a6cc-a897-424d-bb75-6b0fc5081eef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100060, N'cd974dc6-f465-4948-98dc-8c3a42bb811d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100060, N'83072c68-ad3e-48eb-a09b-2be13af8249c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100060, N'442be8ba-8e8c-4866-91d3-4e8e4120d539', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100060, N'3eab3215-4b8b-4e68-ba02-d0e7d5b702da', 1)


-- Fournisseur
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100016, N'DB71CF78-8417-4FC0-AABF-4B955796D9A2', 1)


-- Search ITEM
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100034, N'D84DD72D-7B49-42A8-8C05-F7AC1B89E292', 1)

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (11111, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (33333, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100011, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100017, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100020, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100021, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100023, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100024, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100025, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100026, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100027, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100028, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100029, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100030, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100031, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100032, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)


--- DELETE LINE ---
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (101038, N'0911caa7-8243-422b-b0d2-6e719a304f5e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (101039, N'385e6ac2-f2b0-47aa-a2ba-edea5d6093c5', 1)

UPDATE [ERPSettings].[RoleConfig] SET [ERPSettings].[RoleConfig].[RoleName] = 'Réclamations' WHERE [ERPSettings].[RoleConfig].[Id] = 88888
UPDATE [ERPSettings].[RoleConfig] SET [ERPSettings].[RoleConfig].[RoleName] = 'Réglages' WHERE [ERPSettings].[RoleConfig].[Id] = 77777
UPDATE [ERPSettings].[RoleConfigCategory] SET [ERPSettings].[RoleConfigCategory].[Label] = 'Réglages' WHERE [ERPSettings].[RoleConfigCategory].[Id] = 77777


INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100060, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100060, 11111, 1, 0, NULL) 

INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (101038, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (101038, 33333, 1, 0, NULL)

INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (101039, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (101039, 33333, 1, 0, NULL)




ALTER TABLE [ERPSettings].[RoleConfigByRole]
    ADD CONSTRAINT [FK_RoleConfigRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[RoleConfigByRole]
    WITH NOCHECK ADD CONSTRAINT [FK_RoleConfigRole_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])

COMMIT TRANSACTION   

--Yasmine: Create role SalesDelivery_Deliver

BEGIN TRANSACTION

 

ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_Role]
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_RoleConfig]

 


SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100166, N'SalesDelivery_Deliver', N'Livraison Des Ventes', 0, NULL, 33333)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

 

INSERT INTO [ERPSettings].[RoleConfigByRole] ( [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100166, 1, 1, 0, NULL)
INSERT INTO [ERPSettings].[RoleConfigByRole] ( [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100166, 33333, 1, 0, NULL)

 

INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES (N'D438FBAD-7305-4DAD-AB44-A4FB84318A83', 100166, 1)

 

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100166, N'58784307-6eaa-4132-bb4f-1439cc7ba256', 1)

 ALTER TABLE [ERPSettings].[RoleConfigByRole]
    ADD CONSTRAINT [FK_RoleConfigRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE

ALTER TABLE [ERPSettings].[RoleConfigByRole]
    WITH NOCHECK ADD CONSTRAINT [FK_RoleConfigRole_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
	
	COMMIT TRANSACTION 
	
---- Nihel: purchase item

BEGIN TRANSACTION

ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_Role]
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_RoleConfig]

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (100061, N'PurchaseItem_Config', N'Article Achat', 0, NULL, 11111)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig], [IsActive]) VALUES (N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100061, 1) 
-- PURCHASE ITEM
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100061, N'04c4ae31-23ca-4cf1-8057-c596d605ff56', 1)
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100061, 1, 1, 0, NULL) 
INSERT INTO [ERPSettings].[RoleConfigByRole] ([IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (100061, 11111, 1, 0, NULL) 

ALTER TABLE [ERPSettings].[RoleConfigByRole]
    ADD CONSTRAINT [FK_RoleConfigRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[RoleConfigByRole]
    WITH NOCHECK ADD CONSTRAINT [FK_RoleConfigRole_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])

 

COMMIT TRANSACTION   


--fatma : add negotiation role
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