
-- 23/07/2020 Ahmed
--production 
SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] ON
insert into ERPSettings.RoleConfigCategory ([Id], [Code],[Label],[TranslationCode],[IsDeleted],[TransactionUserId],[Deleted_Token]) values 
(100404, N'Production',N'Production',N'Manufacturing',0,null,null)
SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] OFF
 SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(101101,N'Manufacturing_Config',N'Gestion de production',0,null, 100404)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-337b4a3c8321', N'Production_Config', 4, N'Production', N'Manufacturing', NULL, NULL, NULL, NULL, N'/Manufacturing', 0, N'Production_Config')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101101, N'fd671f2f-5b91-4de3-9a07-337b4a3c8321', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-14564645642D',N'Manufacturing',NULL, 12,N'Manufacturing',N'Manufacturing',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-14564645642D', 101101, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-817b4a3c1234', N'fd671f2f-5b91-4de3-9a07-337b4a3c8321', N'51BF3865-133E-4E97-9F99-14564645642D')


-- production settings 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(101103,N'Manufacturing_Settings',N'Paramétrage de production',0,null, 77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-337b4a3c3652', N'Manufacturing_Settings_func', 4, N'Production', N'Manufacturing', NULL, NULL, NULL, NULL, N'/Manufacturing', 0, N'Production_Config_func')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101103, N'fd671f2f-5b91-4de3-9a07-337b4a3c3652', 1)

INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-14564688632D',N'Manufacturing',NULL, 12,N'Production',N'Manufacturing',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-14564688632D', 101103, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-817b4a3c8983', N'fd671f2f-5b91-4de3-9a07-337b4a3c3652', N'51BF3865-133E-4E97-9F99-14564688632D')

--ecommerce 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(101102,N'Ecommerce_Config',N'Gestion E-commerce',0,null, 100007)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-337b4a3c5721', N'Ecommerce', 4, N'Ecommerce', N'Ecommerce', NULL, NULL, NULL, NULL, N'/Ecommerce', 0, N'Ecommerce')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101102, N'fd671f2f-5b91-4de3-9a07-337b4a3c5721', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-14564687942D',N'Ecommerce',NULL, 12,N'Ecommerce',N'Ecommerce',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-14564687942D', 101102, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-817b4a3c8965', N'fd671f2f-5b91-4de3-9a07-337b4a3c5721', N'51BF3865-133E-4E97-9F99-14564687942D')


--24/07/2020 Ahmed
-- Supp document for purchase 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(102101,N'Delete_Document_Purchase',N'Supprimer un document',0,null, 11111)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd111f2f-5b91-4de3-9a07-337b4a3c3652', N'Delete-Document_Purchase', 4, N'Supprimer un document', N'Selete document', NULL, NULL, NULL, NULL, N'/Document', 0, N'Delete-Document_Purchase')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 102101, N'fd111f2f-5b91-4de3-9a07-337b4a3c3652', 1)


-- Supp document for sales 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(102102,N'Delete_Document_sales',N'Supprimer un document',0,null, 33333)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd331f2f-5b91-4de3-9a07-337b4a3c3652', N'Delete-Document_Sales', 4, N'Supprimer un document', N'Delete document', NULL, NULL, NULL, NULL, N'/Document', 0, N'Delete-Document_Sales')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 102102, N'fd331f2f-5b91-4de3-9a07-337b4a3c3652', 1)


-- Supp document for Stock correction 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(102103,N'Delete_Document_stock',N'Supprimer un document',0,null, 100100)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3652', N'Delete-Document_Stock', 4, N'Supprimer un document', N'Delete document', NULL, NULL, NULL, NULL, N'/Document', 0, N'Delete-Document_Stock')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 102103, N'fd101f2f-5b91-4de3-9a07-337b4a3c3652', 1)