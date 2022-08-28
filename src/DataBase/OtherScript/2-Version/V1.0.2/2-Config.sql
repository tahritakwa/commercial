------------------Ahmed

--*******************Paramétrage de vente*****************
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fd671f2f-5b90-4de3-9a07-157b4a3c8466', N'Sales settings', 15, N'Paramétrage de vente', N'Sales settings', NULL, NULL, NULL, NULL, N'/sales', 0, N'Sales settings')

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'fd671f2f-5b90-4de3-9a07-157b4a3c8477', N'Paramétrage de vente', NULL, 1, N'Paramétrage de vente', N'Sales settings',null, null, null, null, null, 1)

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (70002, N'Sales_Settings', N'Paramétrage de vente', 0, NULL,77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'fd671f2f-5b90-4de3-9a07-157b4a3c8477', 70002, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-157b4a3c8499', N'fd671f2f-5b90-4de3-9a07-157b4a3c8466', N'fd671f2f-5b90-4de3-9a07-157b4a3c8477')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 70002, N'fd671f2f-5b90-4de3-9a07-157b4a3c8466', 1)

--*******************Paramétrage de stock*****************
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fd671f2f-5b90-4de3-9a07-167b4a3c8466', N'Stock settings', 15, N'Paramétres de stock', N'Stock settings', NULL, NULL, NULL, NULL, N'/stock', 0, N'Stock settings')

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'fd671f2f-5b90-4de3-9a07-167b4a3c8477', N'Paramétres de stock', NULL, 1, N'Paramétres de stock', N'Stock settings',null, null, null, null, null, 1)

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (70003, N'Stock_Settings', N'Paramétres de stock', 0, NULL,77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'fd671f2f-5b90-4de3-9a07-167b4a3c8477', 70003, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-167b4a3c8499', N'fd671f2f-5b90-4de3-9a07-167b4a3c8466', N'fd671f2f-5b90-4de3-9a07-167b4a3c8477')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 70003, N'fd671f2f-5b90-4de3-9a07-167b4a3c8466', 1)

--*******************Paramétrage d'achat*****************
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fd671f2f-5b90-4de3-9a07-177b4a3c8466', N'Purchase settings', 15, N'Paramétrage achat', N'Purchase settings', NULL, NULL, NULL, NULL, N'/Purchase', 0, N'Purchase settings')

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'fd671f2f-5b90-4de3-9a07-177b4a3c8477', N'Paramétrage achat', NULL, 1, N'Paramétrage achat', N'Purchase settings',null, null, null, null, null, 1)

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (70004, N'Purchase_Settings', N'Paramétrage achat', 0, NULL,77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'fd671f2f-5b90-4de3-9a07-177b4a3c8477', 70004, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-177b4a3c8499', N'fd671f2f-5b90-4de3-9a07-177b4a3c8466', N'fd671f2f-5b90-4de3-9a07-177b4a3c8477')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 70004, N'fd671f2f-5b90-4de3-9a07-177b4a3c8466', 1)

--*******************Paramétres B2B*****************
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fd671f2f-5b90-4de3-9a07-187b4a3c8466', N'B2B settings', 15, N'Paramétres B2B', N'B2B settings', NULL, NULL, NULL, NULL, N'/B2B', 0, N'B2B settings')

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'fd671f2f-5b90-4de3-9a07-187b4a3c8477', N'Paramétres B2B', NULL, 1, N'Paramétres B2B', N'B2B settings',null, null, null, null, null, 1)

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (70005, N'B2B_Settings', N'Paramétres B2B', 0, NULL,77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'fd671f2f-5b90-4de3-9a07-187b4a3c8477', 70005, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-187b4a3c8499', N'fd671f2f-5b90-4de3-9a07-187b4a3c8466', N'fd671f2f-5b90-4de3-9a07-187b4a3c8477')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 70005, N'fd671f2f-5b90-4de3-9a07-187b4a3c8466', 1)

--*******************paramétrage de comptabilité *****************
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fd671f2f-5b90-4de3-9a07-197b4a3c8466', N'Accounting settings', 15, N'Paramétrage de comptabilité', N'Accounting settings', NULL, NULL, NULL, NULL, N'/Accounting', 0, N'Accounting settings')

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'fd671f2f-5b90-4de3-9a07-197b4a3c8477', N'Paramétrage de comptabilité', NULL, 1, N'Paramétrage de comptabilité', N'Accounting settings',null, null, null, null, null, 1)

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (70006, N'Accounting_Settings', N'Paramétrage de comptabilité', 0, NULL,77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'fd671f2f-5b90-4de3-9a07-197b4a3c8477', 70006, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-197b4a3c8499', N'fd671f2f-5b90-4de3-9a07-197b4a3c8466', N'fd671f2f-5b90-4de3-9a07-197b4a3c8477')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 70006, N'fd671f2f-5b90-4de3-9a07-197b4a3c8466', 1)

--*******************Paramétres E-commerce*****************
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fd671f2f-5b90-4de3-9a07-207b4a3c8466', N'Ecommerce settings', 15, N'Paramétres E-commerce', N'Ecommerce settings', NULL, NULL, NULL, NULL, N'/Ecommerce', 0, N'Ecommerce settings')

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'fd671f2f-5b90-4de3-9a07-207b4a3c8477', N'Paramétres E-commerce', NULL, 1, N'Paramétres E-commerce', N'Ecommerce settings',null, null, null, null, null, 1)

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (70007, N'Ecommerce_Settings', N'Paramétres E-commerce', 0, NULL,77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'fd671f2f-5b90-4de3-9a07-207b4a3c8477', 70007, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-207b4a3c8499', N'fd671f2f-5b90-4de3-9a07-207b4a3c8466', N'fd671f2f-5b90-4de3-9a07-207b4a3c8477')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 70007, N'fd671f2f-5b90-4de3-9a07-207b4a3c8466', 1)






--Fatma role and codification  financial asset
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'158b2316-1cab-48fd-b92a-dac77181ee4a', N'DELETE-SalesFinancialAsset', 3, N'Supprimer avoir financier', N'Delete financial asset', NULL, NULL, NULL, NULL, NULL, 0, N'DELETE-SalesFinancialAsset')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'3c3d8f37-e0f0-4131-a2d8-6c8d62fa9930', N'LIST-SalesFinancialAsset', 4, N'List des  avoir financier', N'Financial asset list', NULL, NULL, NULL, NULL, NULL, 0, N'LIST-SalesFinancialAsset')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'40e67972-49d3-42e1-88fd-c6a29897b5fc', N'ADD-SalesFinancialAsset', 1, N'Ajouter avoir financier', N'Add financial asset', NULL, NULL, NULL, NULL, NULL, 0, N'ADD-SalesFinancialAsset')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4108b9d2-28a8-4bd8-afe2-140caab5d23c', N'UPDATE-SalesFinancialAsset', 2, N'Modifier avoir financier', N'update  financial asset', NULL, NULL, NULL, NULL, NULL, 0, N'UPDATE-SalesFinancialAsset')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6af76bf9-7130-4d42-9790-b69a1c22a145', N'VALIDATE-SalesFinancialAsset', 8, N'Valider  avoir financier', N'Validate financial asset', NULL, NULL, NULL, NULL, NULL, 0, N'VALIDATE-SalesFinancialAsset')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a934907b-f09c-45ab-872b-754abe5d3059', N'PRINT-SalesFinancialAsset', 8, N'Imprimer  avoir financier', N'Print financial asset', NULL, NULL, NULL, NULL, NULL, 0, N'PRINT-SalesFinancialAsset')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fa334f3d-e0d6-472b-aaac-7d6a5276eda4', N'SHOW-SalesFinancialAsset', 15, N'Afficher  avoir financier', N'Show financial asset', NULL, NULL, NULL, NULL, NULL, 0, N'SHOW-SalesFinancialAsset')
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101041, N'SalesFinancialAsset_Config                        ', N'Avoir financier                                   ', 0, NULL, 33333)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'395a6f40-5c50-425d-9ce9-22b091c50e7f', N'4108b9d2-28a8-4bd8-afe2-140caab5d23c', N'a7168571-d1dd-4de1-8bb4-bd9d1816bab0')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'5e0c22fd-6334-4bba-9cb9-a36ee347ca1d', N'3c3d8f37-e0f0-4131-a2d8-6c8d62fa9930', N'a7168571-d1dd-4de1-8bb4-bd9d1816bab0')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'6b715c3b-79a5-44b0-9174-66b46ebcb9c5', N'6af76bf9-7130-4d42-9790-b69a1c22a145', N'a7168571-d1dd-4de1-8bb4-bd9d1816bab0')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'a3fca231-bcf9-4740-b61c-01b1642973e1', N'fa334f3d-e0d6-472b-aaac-7d6a5276eda4', N'a7168571-d1dd-4de1-8bb4-bd9d1816bab0')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'acb18b4f-f274-455e-b224-dad749dc9370', N'a934907b-f09c-45ab-872b-754abe5d3059', N'a7168571-d1dd-4de1-8bb4-bd9d1816bab0')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c7a57023-1697-4271-8946-8f47cb63d3ae', N'158b2316-1cab-48fd-b92a-dac77181ee4a', N'a7168571-d1dd-4de1-8bb4-bd9d1816bab0')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ec0cb97b-03b8-4029-a0ef-9e714fb1e516', N'40e67972-49d3-42e1-88fd-c6a29897b5fc', N'a7168571-d1dd-4de1-8bb4-bd9d1816bab0')
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (290, N'InvoiceFinancialRestaurn', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (291, N'InvoiceFinancialRestaurCode', 1, NULL, NULL, N'AF-R', 290, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (292, N'InvoiceFinancialRestaurnAnnee', 2, NULL, NULL, N'20', 290, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (293, N'InvoiceFinancialRestaurnCaratere', 3, NULL, NULL, N'/', 290, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (294, N'InvoiceFinancialRestaurnCompteur', 4, NULL, NULL, NULL, 290, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (295, N'InvoiceFinancialRestaurnValid', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (296, N'InvoiceFinancialRestaurCodeValid', 1, NULL, NULL, N'A-AF-R', 295, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (297, N'InvoiceFinancialRestaurnAnneeValid', 2, NULL, NULL, N'20', 295, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (298, N'InvoiceFinancialRestaurnCaratereValid', 3, NULL, NULL, N'/', 295, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (299, N'InvoiceFinancialRestaurnCompteurValid', 4, NULL, NULL, NULL, 295, 1, 1, N'00000000', 8)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (59, 87, N'DocumentTypeCode', N'AF-R', 290)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (60, 87, N'DocumentTypeCode', N'A-AF-R', 295)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'a7168571-d1dd-4de1-8bb4-bd9d1816bab0', N'SalesFinancialAsset', N'd438fbad-7305-4dad-ab44-a4fb84318a83', 16, N'Avoir financier', N'Financial asset', N'Avoir financier', N'Avoir financier', N'Avoir financier', N'Avoir financier', NULL, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES (N'a7168571-d1dd-4de1-8bb4-bd9d1816bab0', 101041, 1)

INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101041, N'40e67972-49d3-42e1-88fd-c6a29897b5fc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101041, N'158b2316-1cab-48fd-b92a-dac77181ee4a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101041, N'3c3d8f37-e0f0-4131-a2d8-6c8d62fa9930', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES  (101041, N'a934907b-f09c-45ab-872b-754abe5d3059', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101041, N'fa334f3d-e0d6-472b-aaac-7d6a5276eda4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101041, N'4108b9d2-28a8-4bd8-afe2-140caab5d23c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101041, N'6af76bf9-7130-4d42-9790-b69a1c22a145', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101041, N'40e67972-49d3-42e1-88fd-c6a29897b5fc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101041, N'158b2316-1cab-48fd-b92a-dac77181ee4a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101041, N'3c3d8f37-e0f0-4131-a2d8-6c8d62fa9930', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101041, N'a934907b-f09c-45ab-872b-754abe5d3059', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101041, N'fa334f3d-e0d6-472b-aaac-7d6a5276eda4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101041, N'4108b9d2-28a8-4bd8-afe2-140caab5d23c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101041, N'6af76bf9-7130-4d42-9790-b69a1c22a145', 1)
SET IDENTITY_INSERT [Inventory].[Nature] ON
INSERT INTO [Inventory].[Nature] ([Id], [Code], [Label], [IsStockManaged], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'Ristourne', N'Ristourne', 0, 0, 0, NULL)
SET IDENTITY_INSERT [Inventory].[Nature] OFF
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
COMMIT TRANSACTION

--Ahmed add Delete Document Line Role for Purchase 

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fd671f2f-5b90-4de3-9a07-247b4a3c8466', N'DELETE-DOCUMENTLINE_PU', 4, N'Supression ligne de document achat', N'Delete document ligne purchase', NULL, NULL, NULL, NULL, N'/Purchase/Delete', 0, N'DELETE-DOCUMENTLINE_PU')

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101042, N'DeleteDocumentLinePurchase_Config', N'Suppression Ligne de Document', 0, NULL,11111)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'817D920F-48EF-4AA2-865A-CC367C37FB3B', 101042, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-247b4a3c8499', N'fd671f2f-5b90-4de3-9a07-247b4a3c8466', N'817D920F-48EF-4AA2-865A-CC367C37FB3B')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101042, N'fd671f2f-5b90-4de3-9a07-247b4a3c8466', 1)

--19/05/2020 16h Ahmed add Delete multiple Document Lines Role for Purchase 
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fd671f2f-5b90-4de3-9a07-607b4a3c8466', N'DELETE-MULTIPLEDOCUMENTLINES_PU', 4, N'Supression Plusieurs lignes de document achat', N'Delete multiple document lignes purchase', NULL, NULL, NULL, NULL, N'/Purchase/DeleteMultiple', 0, N'DELETE-MULTIPLEDOCUMENTLINES_PU')
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101043, N'DeleteMultipleDocumentLinesPurchase_Config', N'Suppression Plusieurs Lignes de Document', 0, NULL,11111)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'817D920F-48EF-4AA2-865A-CC367C37FB3B', 101043, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-607b4a3c8499', N'fd671f2f-5b90-4de3-9a07-607b4a3c8466', N'817D920F-48EF-4AA2-865A-CC367C37FB3B')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101043, N'fd671f2f-5b90-4de3-9a07-607b4a3c8466', 1)

--19/05/2020 16h Ahmed add Delete multiple Document Lines Role for Sales 
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fd671f2f-5b90-4de3-9a07-617b4a3c8466', N'DELETE-MULTIPLEDOCUMENTLINES_SA', 4, N'Supression Plusieurs lignes de document vente', N'Delete multiple document lignes sale', NULL, NULL, NULL, NULL, N'/Purchase/DeleteMultiple', 0, N'DELETE-MULTIPLEDOCUMENTLINES_SA')
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101044, N'DeleteMultipleDocumentLinesSale_Config', N'Suppression Plusieurs Lignes de Document', 0, NULL,33333)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'D438FBAD-7305-4DAD-AB44-A4FB84318A83', 101044, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-617b4a3c8499', N'fd671f2f-5b90-4de3-9a07-617b4a3c8466', N'D438FBAD-7305-4DAD-AB44-A4FB84318A83')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101044, N'fd671f2f-5b90-4de3-9a07-617b4a3c8466', 1)


--22/05/2020 12h Ahmed ---------------------
BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=1 WHERE [Id] = 22222
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=1 WHERE [Id] = 33333
GO
COMMIT TRANSACTION

-- Add SalesDelivery_Deliver role
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

--- 04-06-2020 : Marwa : update codification financial asset---
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
UPDATE [ERPSettings].[Codification] SET [InitValue]=N'AF' WHERE [Id]=291
UPDATE [ERPSettings].[Codification] SET [InitValue]=N'AF' WHERE [Id]=296
UPDATE [ERPSettings].[Codification] SET [InitValue]=N'-' WHERE [Id]=298
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
COMMIT TRANSACTION 

--Ahmed 05/06/2020

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Modification Avoir Validé' WHERE [Id] = 100044
GO
COMMIT TRANSACTION


BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Modification Facture Validée' WHERE [Id] = 100045
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Modification Commande Validée' WHERE [Id] = 100046
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Modification Facture Achat Validée' WHERE [Id] = 100047
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Modification Devis Validé' WHERE [Id] = 100048
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=1 WHERE [Id] = 11111
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IdRoleConfigCategory]=11111 WHERE [Id] = 88888
GO
COMMIT TRANSACTION


BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfigCategory] SET [IsDeleted]=1 WHERE [Id] = 88888
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Modification BS Validé' WHERE [Id] = 100041
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Modification BE Validé' WHERE [Id] = 100042
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfigCategory] SET [IsDeleted]=1 WHERE [Id] = 100099
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Modification Prix Article' WHERE [Id] = 100055
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Affichage Encours Client' WHERE [Id] = 100056
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=1 WHERE [Id] = 100006
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IdRoleConfigCategory]=100100 WHERE [Id] = 100041
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IdRoleConfigCategory]=100100 WHERE [Id] = 100042
GO
COMMIT TRANSACTION


INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fd671f2f-5b90-4de3-9a07-817b4a3c8466', N'VALIDATE-INVENTORY ', 4, N'Validation Inventaire', N'validate inventory', NULL, NULL, NULL, NULL, N'/Stock/Inventory', 0, N'VALIDATE-INVENTORY ')
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101081, N'Validate-Inventory', N'Valisation Inventaire', 0, NULL,22222)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'ff007474-a447-4c92-8f6a-265d5c08ff10', 101081, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-817b4a3c8499', N'fd671f2f-5b90-4de3-9a07-817b4a3c8466', N'ff007474-a447-4c92-8f6a-265d5c08ff10')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101081, N'fd671f2f-5b90-4de3-9a07-817b4a3c8466', 1)


BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=1 WHERE [Id] = 100043
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=1 WHERE [Id] = 100044
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=1 WHERE [Id] = 100045
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=1 WHERE [Id] = 100048
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=1 WHERE [Id] = 100049
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=1 WHERE [Id] = 100051
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=1 WHERE [Id] = 100037
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Facture Achat' WHERE [Id] = 100030
GO
COMMIT TRANSACTION

-- 09/06/2020 Ahmed 
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole])
VALUES (N'fd671f2f-5b90-4de3-9a07-917b4a3c8466', N'VALIDATE-BALANCED_LINE', 4, N'Validation Reliquats', N'Validate Remainings',
NULL, NULL, NULL, NULL, N'/Stock/Remainings', 0, N'VALIDATE-BALANCED_LINE')

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole])
VALUES (N'fd671f2f-5b90-4de3-9a07-927b4a3c8466', N'LIST-BALANCED_LINE', 4, N'Liste des Reliquats', N'Remainings List',
NULL, NULL, NULL, NULL, N'/Stock/Remainings', 0, N'LIST-BALANCED_LINE')

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole])
VALUES (N'fd671f2f-5b90-4de3-9a07-937b4a3c8466', N'ADD-BALANCED_LINE', 4, N'Ajouter Reliquats', N'Add Remainings',
NULL, NULL, NULL, NULL, N'/Stock/Remainings', 0, N'ADD-BALANCED_LINE')

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole])
VALUES (N'fd671f2f-5b90-4de3-9a07-947b4a3c8466', N'UPDATE-BALANCED_LINE', 4, N'Modifier Reliquats', N'Update Remainings',
NULL, NULL, NULL, NULL, N'/Stock/Remainings', 0, N'UPDATE-BALANCED_LINE')

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole])
VALUES (N'fd671f2f-5b90-4de3-9a07-957b4a3c8466', N'DELETE-BALANCED_LINE', 4, N'Supprimer Reliquats', N'Delete Remainings',
NULL, NULL, NULL, NULL, N'/Stock/Remainings', 0, N'DELETE-BALANCED_LINE')

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole])
VALUES (N'fd671f2f-5b90-4de3-9a07-967b4a3c8466', N'SHOW-BALANCED_LINE', 4, N'Afficher Reliquats', N'Show Remainings',
NULL, NULL, NULL, NULL, N'/Stock/Remainings', 0, N'SHOW-BALANCED_LINE')

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole])
VALUES (N'fd671f2f-5b90-4de3-9a07-977b4a3c8466', N'PRINT-BALANCED_LINE', 4, N'Imprimer Reliquats', N'Print Remainings',
NULL, NULL, NULL, NULL, N'/Stock/Remainings', 0, N'PRINT-BALANCED_LINE')

INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F81-14564644742D',N'Reliquats',N'817D920F-48EF-4AA2-865A-CC367C37FB3B', 12,	N'Reliquats',N'Remainings',	NULL,	NULL,	NULL,	NULL,	NULL,	1)




SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (101091, N'BALANCED_LINE', N'Reliquats', 0, NULL,11111)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'51BF3865-133E-4E97-9F81-14564644742D', 101091, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-917b4a3c8499', N'fd671f2f-5b90-4de3-9a07-917b4a3c8466', N'51BF3865-133E-4E97-9F81-14564644742D')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-927b4a3c8499', N'fd671f2f-5b90-4de3-9a07-927b4a3c8466', N'51BF3865-133E-4E97-9F81-14564644742D')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-937b4a3c8499', N'fd671f2f-5b90-4de3-9a07-937b4a3c8466', N'51BF3865-133E-4E97-9F81-14564644742D')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-947b4a3c8499', N'fd671f2f-5b90-4de3-9a07-947b4a3c8466', N'51BF3865-133E-4E97-9F81-14564644742D')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-957b4a3c8499', N'fd671f2f-5b90-4de3-9a07-957b4a3c8466', N'51BF3865-133E-4E97-9F81-14564644742D')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-967b4a3c8499', N'fd671f2f-5b90-4de3-9a07-967b4a3c8466', N'51BF3865-133E-4E97-9F81-14564644742D')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b90-4de3-9a07-977b4a3c8499', N'fd671f2f-5b90-4de3-9a07-977b4a3c8466', N'51BF3865-133E-4E97-9F81-14564644742D')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101091, N'fd671f2f-5b90-4de3-9a07-917b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101091, N'fd671f2f-5b90-4de3-9a07-927b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101091, N'fd671f2f-5b90-4de3-9a07-937b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101091, N'fd671f2f-5b90-4de3-9a07-947b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101091, N'fd671f2f-5b90-4de3-9a07-957b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101091, N'fd671f2f-5b90-4de3-9a07-967b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 101091, N'fd671f2f-5b90-4de3-9a07-977b4a3c8466', 1)


INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 100032, N'2619EDD7-D221-43D7-832B-C1C761DF8AC8', 1)

--10/06/2020 Ahmed 

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=1 WHERE [Id] = 100046
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=1 WHERE [Id] = 100047
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=1 WHERE [Id] = 100042
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Validation Inventaire' WHERE [Id] = 101081
GO
COMMIT TRANSACTION 


BEGIN TRANSACTION
update [ERPSettings].[Module] set [ModuleName]=N'BALANCED_LINE' where [IdModule]='51BF3865-133E-4E97-9F81-14564644742D'
update [ERPSettings].[Module] set [EN]=N'BALANCED_LINE' where [IdModule]='51BF3865-133E-4E97-9F81-14564644742D'
update [ERPSettings].[Module] set [FR]=N'BALANCED_LINE' where [IdModule]='51BF3865-133E-4E97-9F81-14564644742D'
GO
COMMIT TRANSACTION 

---11/10/2020 Ahmed
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fd671f2f-5b91-4de3-9a07-817b4a3c8466', N'OF-CONFIRMATION-INVOICE', 4, N'Of Confirmation Invoice', N'Dévalidation Facture', NULL, NULL, NULL, NULL, N'/Stock/Innvoice', 0, N'OF-CONFIRMATION-INVOICE')
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (10155, N'OF-CONFIRMATION-INVOICE', N'Dévalidation Facture', 0, NULL,33333)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 10155, N'fd671f2f-5b91-4de3-9a07-817b4a3c8466', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-14564644742D',N'Reliquats',N'D438FBAD-7305-4DAD-AB44-A4FB84318A83', 12,	N'Facture',N'Invoice',	NULL,	NULL,	NULL,	NULL,	NULL,	1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'51BF3865-133E-4E97-9F99-14564644742D', 10155, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'fd671f2f-5b91-4de3-9a07-817b4a3c8499', N'fd671f2f-5b91-4de3-9a07-817b4a3c8466', N'51BF3865-133E-4E97-9F99-14564644742D')


BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=1 WHERE [Id] = 100039
GO
COMMIT TRANSACTION


-- chedi : 15/06/2020: add ecommerce missing roles

 BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_Role]
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_RoleConfig]
ALTER TABLE [ERPSettings].[ModuleConfig] DROP CONSTRAINT [FK_ModuleConfig_Module]
ALTER TABLE [ERPSettings].[ModuleConfig] DROP CONSTRAINT [FK_ModuleConfig_RoleConfig]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[RoleConfig] DROP CONSTRAINT [FK_RoleConfigCategory_RoleConfig]
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_Functionality]
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_RoleConfig]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
DELETE FROM [ERPSettings].[RoleConfig] WHERE [Id]=100166
UPDATE [ERPSettings].[ModuleConfig] SET [IdModule]=N'44afb7e5-da23-4d49-acbd-26ce2f879149', [IdRoleConfig]=100007 WHERE [Id]=821
UPDATE [ERPSettings].[FunctionalityConfig] SET [IdRoleConfig]=100007, [IdFunctionality]=N'28a68f7b-e21a-410c-9333-31a7099cb403' WHERE [Id]=3946
SET IDENTITY_INSERT [ERPSettings].[Role] ON
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (100007, N'Ecommerce', N'Ecommerce', 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[Role] OFF
SET IDENTITY_INSERT [ERPSettings].[FunctionalityConfig] ON
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3947, 100007, N'358c397e-b548-476c-90c5-45d183606b6f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3948, 100007, N'37a20e5c-61ce-4cbf-b8a4-f7dd46466e41', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3949, 100007, N'59c49df5-3cca-40f0-8d86-9e3b3a75ccb6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3950, 100007, N'6c2670b6-dcdd-4410-b436-b474aea8dd63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3951, 100007, N'997b0595-b07b-49ee-9999-51ad34cd289a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3952, 100007, N'a25f3c15-f35b-420c-b2bd-9e0d598ac1d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3953, 100007, N'bc9aadee-54a5-4a39-be6a-de9744f62b98', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3954, 100007, N'cc0ca036-935a-4e15-929b-aaa07f5397a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3955, 100007, N'cf772fad-7794-45e2-ab82-9dfc61db06cf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3956, 100007, N'd0585140-fdf7-4d2b-886d-01d8141c1acf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3957, 100007, N'ed8409db-eeed-4915-9b3b-a650f0eb3aea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3958, 100007, N'ee0d7ab2-b1af-4e42-854c-7bc2ef8749aa', 1)
SET IDENTITY_INSERT [ERPSettings].[FunctionalityConfig] OFF
SET IDENTITY_INSERT [ERPSettings].[ModuleConfig] ON
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (822, N'95c1b8df-b925-431b-8615-57c7668d5886', 100007, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (823, N'aad112b6-39de-4fc0-94fd-f9ae3f480ce1', 100007, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (824, N'f8fd4e4e-6e87-4a12-965a-87dc9dd6a988', 100007, 1)
SET IDENTITY_INSERT [ERPSettings].[ModuleConfig] OFF
SET IDENTITY_INSERT [ERPSettings].[RoleConfigByRole] ON
INSERT INTO [ERPSettings].[RoleConfigByRole] ([Id], [IdRoleConfig], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (459, 100007, 100007, 1, 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[RoleConfigByRole] OFF
ALTER TABLE [ERPSettings].[RoleConfigByRole]
    ADD CONSTRAINT [FK_RoleConfigRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[RoleConfigByRole]
    ADD CONSTRAINT [FK_RoleConfigRole_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
ALTER TABLE [ERPSettings].[ModuleConfig]
    ADD CONSTRAINT [FK_ModuleConfig_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleConfig]
    ADD CONSTRAINT [FK_ModuleConfig_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[RoleConfig]
    ADD CONSTRAINT [FK_RoleConfigCategory_RoleConfig] FOREIGN KEY ([IdRoleConfigCategory]) REFERENCES [ERPSettings].[RoleConfigCategory] ([Id])
ALTER TABLE [ERPSettings].[FunctionalityConfig]
    ADD CONSTRAINT [FK_FonctionalityConfig_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionalityConfig]
    ADD CONSTRAINT [FK_FonctionalityConfig_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION

--17/06/2020 Ahmed
BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [Code]= N'DevisConfig' WHERE [Id] =100011
GO
COMMIT TRANSACTION

-- 19/06/2020 Ahmed
--Purchase invoice 
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'BC471D71-863E-47A0-95F4-C2E1595C2BD9', 100029, 1)
--Purchase final order
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'8786AC1B-297A-410C-8F2A-4FA850ECDBBA', 100030, 1)
--Purchase asset
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'0AA2ABAA-8057-4BD3-8A64-D6C16552AAF6', 100028, 1)


--22/06/2020 Ahmed
BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [Code]=N'ListeArticle_Config' WHERE [Id] = 100012
GO
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=1 WHERE [Id] = 100004
GO
COMMIT TRANSACTION




