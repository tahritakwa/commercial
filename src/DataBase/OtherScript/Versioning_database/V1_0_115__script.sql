-- 07/09/2020 : Ahmed  
--Cancel Order
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103111,N'Cancel_Order',N'Annuler Commande',0,null, 33333)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3200', N'Cancel Order', 4, N'Annuler Commande', N'Cancel Order', NULL, NULL, NULL, NULL, N'/Sales/Order', 0, N'Cancel-Order')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103111, N'fd101f2f-5b91-4de3-9a07-337b4a3c3200', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'D438FBAD-7305-4DAD-AB44-A4FB84318A83', 103111, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7200', N'fd101f2f-5b91-4de3-9a07-337b4a3c3200', N'D438FBAD-7305-4DAD-AB44-A4FB84318A83')

--08/09/2020 : Ahmed 
-- Currency
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103112,N'Currency',N'Devise',0,null, 77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3201', N'Currency', 4, N'Devise', N'Currency', NULL, NULL, NULL, NULL, N'/Currency', 0, N'Currency')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103112, N'fd101f2f-5b91-4de3-9a07-337b4a3c3201', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227201D',N'Currency',NULL, 12,N'Devise',N'Currency',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227201D', 103112, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7201', N'fd101f2f-5b91-4de3-9a07-337b4a3c3201', N'51BF3865-133E-4E97-9F99-10562227201D')

--Prices
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103113,N'Prices',N'Tarifs',0,null, 77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3202', N'Prices', 4, N'Tarifs', N'Prices', NULL, NULL, NULL, NULL, N'/Prices', 0, N'Prices')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103113, N'fd101f2f-5b91-4de3-9a07-337b4a3c3202', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227202D',N'Prices',NULL, 12,N'Tarifs',N'Prices',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227202D', 103113, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7202', N'fd101f2f-5b91-4de3-9a07-337b4a3c3202', N'51BF3865-133E-4E97-9F99-10562227202D')

-- Import Achat
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103114,N'Import_Document',N'Importation document',0,null, 11111)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3203', N'Import Document', 4, N'Importation document', N'Import document', NULL, NULL, NULL, NULL, N'/Purchase', 0, N'Import-Document')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103114, N'fd101f2f-5b91-4de3-9a07-337b4a3c3203', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'817D920F-48EF-4AA2-865A-CC367C37FB3B', 103114, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7203', N'fd101f2f-5b91-4de3-9a07-337b4a3c3203', N'817D920F-48EF-4AA2-865A-CC367C37FB3B')

-- Import vente 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103115,N'Import_Document_SA',N'Importation document',0,null, 33333)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3204', N'Import Document sales', 4, N'Importation document vente', N'Import document sales', NULL, NULL, NULL, NULL, N'/Sales', 0, N'Import-Document-SA')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103115, N'fd101f2f-5b91-4de3-9a07-337b4a3c3204', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'D438FBAD-7305-4DAD-AB44-A4FB84318A83', 103115, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7204', N'fd101f2f-5b91-4de3-9a07-337b4a3c3204', N'D438FBAD-7305-4DAD-AB44-A4FB84318A83')


--Client
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103116,N'Client_Treasury',N'Client',0,null, 100009)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3205', N'Client for Treasury', 4, N'Client', N'Client', NULL, NULL, NULL, NULL, N'/Treasury', 0, N'Client-Treasury')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103116, N'fd101f2f-5b91-4de3-9a07-337b4a3c3205', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'87BEB2E4-EFEB-4341-B96B-6E6BEC8A308A', 103116, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7205', N'fd101f2f-5b91-4de3-9a07-337b4a3c3205', N'87BEB2E4-EFEB-4341-B96B-6E6BEC8A308A')

-- FRS
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103117,N'Tier_Treasury',N'Fournisseur',0,null, 100009)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3206', N'Tier for Treasury', 4, N'Fournisseur', N'Tier', NULL, NULL, NULL, NULL, N'/Treasury', 0, N'Tier-Treasury')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103117, N'fd101f2f-5b91-4de3-9a07-337b4a3c3206', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'87BEB2E4-EFEB-4341-B96B-6E6BEC8A308A', 103117, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7206', N'fd101f2f-5b91-4de3-9a07-337b4a3c3206', N'87BEB2E4-EFEB-4341-B96B-6E6BEC8A308A')


--Caisses
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103118,N'Cash_Register_Treasury',N'Caisses',0,null, 100009)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3207', N'Cash Register for Treasury', 4, N'Caisses', N'Cash Register', NULL, NULL, NULL, NULL, N'/Treasury', 0, N'Cash-Register-Treasury')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103118, N'fd101f2f-5b91-4de3-9a07-337b4a3c3207', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'87BEB2E4-EFEB-4341-B96B-6E6BEC8A308A', 103118, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7207', N'fd101f2f-5b91-4de3-9a07-337b4a3c3207', N'87BEB2E4-EFEB-4341-B96B-6E6BEC8A308A')


--Bank
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103119,N'Bank_Treasury',N'Banque',0,null, 100009)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3208', N'Bank for Treasury', 4, N'Banque', N'Bank', NULL, NULL, NULL, NULL, N'/Treasury', 0, N'Bank-Treasury')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103119, N'fd101f2f-5b91-4de3-9a07-337b4a3c3208', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'87BEB2E4-EFEB-4341-B96B-6E6BEC8A308A', 103119, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7208', N'fd101f2f-5b91-4de3-9a07-337b4a3c3208', N'87BEB2E4-EFEB-4341-B96B-6E6BEC8A308A')

--Outstanding Client 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103123,N'Outstanding_client_treasury',N'Encours Client',0,null, 100009)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3212', N'Outstanding client', 4, N'Encours client', N'Outstanding client', NULL, NULL, NULL, NULL, N'/Treasury', 0, N'Outstanding-Client-Treasury')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103123, N'fd101f2f-5b91-4de3-9a07-337b4a3c3212', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'87BEB2E4-EFEB-4341-B96B-6E6BEC8A308A', 103123, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7212', N'fd101f2f-5b91-4de3-9a07-337b4a3c3212', N'87BEB2E4-EFEB-4341-B96B-6E6BEC8A308A')

--Outstanding Tier 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103124,N'Outstanding_tier_treasury',N'Encours Fournisseur',0,null, 100009)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3213', N'Outstanding tier', 4, N'Encours fournisseur', N'Outstanding tier', NULL, NULL, NULL, NULL, N'/Treasury', 0, N'Outstanding-Tier-Treasury')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103124, N'fd101f2f-5b91-4de3-9a07-337b4a3c3213', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'87BEB2E4-EFEB-4341-B96B-6E6BEC8A308A', 103124, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7213', N'fd101f2f-5b91-4de3-9a07-337b4a3c3213', N'87BEB2E4-EFEB-4341-B96B-6E6BEC8A308A')


--Validate stock movement
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103120,N'Validate_Stock_Movement',N'Validation mouvement de stock ',0,null, 22222)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3209', N'Validate stock movement', 4, N'Validation mouvement de stock', N'Validate stock movement', NULL, NULL, NULL, NULL, N'/Stock', 0, N'Validate-stock-movement')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103120, N'fd101f2f-5b91-4de3-9a07-337b4a3c3209', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'2193DDF9-9631-4AAF-BB15-5F95FC25E44F', 103120, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7209', N'fd101f2f-5b91-4de3-9a07-337b4a3c3209', N'2193DDF9-9631-4AAF-BB15-5F95FC25E44F')


--transfer stock movement
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103121,N'Transfer_Stock_Movement',N'Transférer mouvement de stock ',0,null, 22222)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3210', N'transfer stock movement', 4, N'transférer mouvement de stock', N'transfer stock movement', NULL, NULL, NULL, NULL, N'/Stock', 0, N'Transfer-stock-movement')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103121, N'fd101f2f-5b91-4de3-9a07-337b4a3c3210', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'2193DDF9-9631-4AAF-BB15-5F95FC25E44F', 103121, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7210', N'fd101f2f-5b91-4de3-9a07-337b4a3c3210', N'2193DDF9-9631-4AAF-BB15-5F95FC25E44F')

-- Receive stock movement
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103122,N'Receive_Stock_Movement',N'Réceptionner mouvement de stock ',0,null, 22222)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3211', N'Receive stock movement', 4, N'réceptionner mouvement de stock', N'Receive stock movement', NULL, NULL, NULL, NULL, N'/Stock', 0, N'Receive-stock-movement')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103122, N'fd101f2f-5b91-4de3-9a07-337b4a3c3211', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'2193DDF9-9631-4AAF-BB15-5F95FC25E44F', 103122, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7211', N'fd101f2f-5b91-4de3-9a07-337b4a3c3211', N'2193DDF9-9631-4AAF-BB15-5F95FC25E44F')

-- 09/09/2020 : Ahmed
update ERPSettings.RoleConfig set IsDeleted=1 where Id = 100057

---10/09/2020 : Amine : Recrutement

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103125, N'Recrutement_Request                               ', N'Demande                                           ', 0, NULL, 100302)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103126, N'Recrutement_Offer                                 ', N'Offre                                             ', 0, NULL, 100302)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103127, N'Candidates                                        ', N'Candidats                                         ', 0, NULL, 100302)
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103128, N'Recruitment_config                                ', N'Recruitment                                       ', 0, NULL, 100302)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'cf181131-0c18-4765-a227-1ce7eb5fc6cb', N'RecrutementRequest', 4, N'RecrutementRequest', N'RecrutementRequest', NULL, NULL, NULL, NULL, N'/RecrutementRequest', 0, N'RecrutementRequest')

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103125, N'cf181131-0c18-4765-a227-1ce7eb5fc6cb', 1)

INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'a339ba07-b6f7-4da3-ba28-447a15271b08',N'RecrutementRequest',NULL, 12,N'RecrutementRequest',N'RecrutementRequest',NULL,NULL,NULL,NULL,NULL,1)

INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'a339ba07-b6f7-4da3-ba28-447a15271b08', 103125, 1)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'69ff14cb-cf9c-420f-883f-640723098d6c', N'cf181131-0c18-4765-a227-1ce7eb5fc6cb', N'a339ba07-b6f7-4da3-ba28-447a15271b08')

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'c1eb45b6-7253-4cdb-82a9-da1bdc358a56', N'RecrutementOffer', 4, N'RecrutementOffer', N'RecrutementOffer', NULL, NULL, NULL, NULL, N'/RecrutementOffer', 0, N'RecrutementOffer')

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103126, N'c1eb45b6-7253-4cdb-82a9-da1bdc358a56', 1)

INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'103bca79-07c4-471b-9381-5d4f7f64e27f',N'RecrutementOffer',NULL, 12,N'RecrutementOffer',N'RecrutementOffer',NULL,NULL,NULL,NULL,NULL,1)

INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'103bca79-07c4-471b-9381-5d4f7f64e27f', 103126, 1)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'952a6bd4-50c2-4a77-8cf1-5ad6f4089329', N'c1eb45b6-7253-4cdb-82a9-da1bdc358a56', N'103bca79-07c4-471b-9381-5d4f7f64e27f')

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'07d389ff-9eab-4f08-9c39-fe29a5005033', N'Candidates', 4, N'Candidates', N'Candidates', NULL, NULL, NULL, NULL, N'/Candidates', 0, N'Candidates')

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103127, N'07d389ff-9eab-4f08-9c39-fe29a5005033', 1)

INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'026acaf2-9828-4fb9-9abe-0ac5588e5446',N'Candidates',NULL, 12,N'Candidates',N'Candidates',NULL,NULL,NULL,NULL,NULL,1)

INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'026acaf2-9828-4fb9-9abe-0ac5588e5446', 103127, 1)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'43e08a84-b25d-4142-8217-34c1dc5c422c', N'07d389ff-9eab-4f08-9c39-fe29a5005033', N'026acaf2-9828-4fb9-9abe-0ac5588e5446')


INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'23ecab55-eab6-49d7-a2f7-8fbeb7305436', N'Recruitment', 4, N'Recruitment', N'Recruitment', NULL, NULL, NULL, NULL, N'/Recruitment', 0, N'Recruitment')

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103128, N'23ecab55-eab6-49d7-a2f7-8fbeb7305436', 1)

INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'bc4b504c-9397-4f65-92bd-fc556e30943f',N'Recruitment',NULL, 12,N'Recruitment',N'Recruitment',NULL,NULL,NULL,NULL,NULL,1)

INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'bc4b504c-9397-4f65-92bd-fc556e30943f', 103128, 1)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'914fc584-9c1c-44fa-9a19-6d29cbaae64c', N'23ecab55-eab6-49d7-a2f7-8fbeb7305436', N'bc4b504c-9397-4f65-92bd-fc556e30943f')


-- chedi : add tier creationDate 11-09-2020
ALTER TABLE [Sales].[Tiers]
    ADD [CreationDate] DATE CONSTRAINT [DF_Tiers_CreationDate] DEFAULT (getdate()) NULL;

--- Donia Update description column length and add contract advantages 11/09/2020
ALTER TABLE [Payroll].[Contract]
    ADD [ThirteenthMonthBonus] BIT        NULL,
        [MealVoucher]          FLOAT (53) NULL,
        [AvailableCar]         BIT        NULL,
        [AvailableHouse]       BIT        NULL,
        [CommissionType]       INT        NULL,
        [CommissionValue]      FLOAT (53) NULL;
ALTER TABLE [RH].[Advantages] ALTER COLUMN [Description] NVARCHAR (MAX) NULL;
ALTER TABLE [RH].[Offer]
    ADD [MealVoucher]     FLOAT (53) NULL,
        [AvailableCar]    BIT        NULL,
        [AvailableHouse]  BIT        NULL,
        [CommissionType]  INT        NULL,
        [CommissionValue] FLOAT (53) NULL;
CREATE TABLE [Payroll].[ContractAdvantage] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdContract]        INT            NOT NULL,
    [Description]       NVARCHAR (MAX) NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_ContractAdvantage] PRIMARY KEY CLUSTERED ([Id] ASC)
);
ALTER TABLE [Payroll].[ContractAdvantage] WITH NOCHECK
    ADD CONSTRAINT [FK_ContractAdvantage_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]) ON DELETE CASCADE;
ALTER TABLE [Payroll].[ContractAdvantage] WITH CHECK CHECK CONSTRAINT [FK_ContractAdvantage_Contract];

-- Molka : Add IdBank  in Nature 09-09-2020
ALTER TABLE [Inventory].[Nature]
ADD [UrlPicture] NVARCHAR (255) NULL;


-- Narcisse : Add status column defaut value in employee 15-09-2020

ALTER TABLE [Payroll].[Employee] DROP COLUMN [Status]

ALTER TABLE [Payroll].[Employee] ADD [Status] INT CONSTRAINT [DF_Employee_Status] DEFAULT ((1)) NOT NULL;

-- Molka : Add [UrlPicture]  in Family and ProductItem 16-09-2020

ALTER TABLE [Inventory].[Family]
ADD [UrlPicture] NVARCHAR (255) NULL;

ALTER TABLE [Inventory].[ProductItem]
ADD [UrlPicture] NVARCHAR (255) NULL;


-- Imen chaaben: changing company WithholdingTax
ALTER TABLE Shared.Company DROP CONSTRAINT DF_Company_WithholingTaxPercentage;
ALTER TABLE Shared.Company DROP COLUMN WithholingTaxPercentage;
ALTER TABLE Shared.Company ADD WithholdingTax BIT NOT NULL DEFAULT 1;

	
	




--17/09/2020 --Amine ATTENDANCE List with modification Role

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103129, N'Access_Modif_Paie', N'List présence avec modification', 0, NULL, 100300)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'74bf3653-7c42-48d7-8c76-0710c44c5189', N'AccessModifPaie', 4, N'AccessModifPaie', N'AccessModifPaie', NULL, NULL, NULL, NULL, N'/AccessModifPaie', 0, N'AccessModifPaie')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103129, N'74bf3653-7c42-48d7-8c76-0710c44c5189', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'3c84c73b-80f7-4441-b7dc-c3a6768b49e5',N'AccessModifPaie',NULL, 12,N'AccessModifPaie',N'AccessModifPaie',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'3c84c73b-80f7-4441-b7dc-c3a6768b49e5', 103129, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'877e9435-941b-4178-b425-0c4082f42276', N'74bf3653-7c42-48d7-8c76-0710c44c5189', N'3c84c73b-80f7-4441-b7dc-c3a6768b49e5')
-- Molka : Add [UrlPicture]  in Family 17-09-2020
ALTER TABLE [Inventory].[VehicleBrand]
ADD [UrlPicture] NVARCHAR (255) NULL
Go

--18/09/2020 : Ahmed ==> add column ProvInventory to Item Table
Alter Table [Inventory].[Item] 
	ADD [ProvInventory] BIT NOT NULL DEFAULT 0;

-- Molka : Add [UrlPicture]  in SubFamily , ModelOfItem and submodel 21-09-2020
ALTER TABLE [Inventory].[SubFamily]
ADD [UrlPicture] NVARCHAR (255) NULL
Go
ALTER TABLE [Inventory].[ModelOfItem]
ADD [UrlPicture] NVARCHAR (255) NULL
Go
ALTER TABLE [Inventory].[SubModel]
ADD [UrlPicture] NVARCHAR (255) NULL
Go



--- Add Role Gestion Garage 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103130,N'Garage_Config',N'Paramétrage garage',0,null, 77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3601', N'garageConfig', 4, N'paramétrage garage', N'garage config', NULL, NULL, NULL, NULL, N'/Garage', 0, N'garage-Config')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103130, N'fd101f2f-5b91-4de3-9a07-337b4a3c3601', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227601D',N'Garage',NULL, 12,N'garage',N'Garage',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227601D', 103130, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7601', N'fd101f2f-5b91-4de3-9a07-337b4a3c3601', N'51BF3865-133E-4E97-9F99-10562227601D')

SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] ON
insert into ERPSettings.RoleConfigCategory([Id],[Code],[Label],[TranslationCode] ,[IsDeleted],[TransactionUserId],[Deleted_Token]) values
(100405, N'Garage',N'Garage',N'Garage',0,null,null)
SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] OFF

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(103131,N'Gestion_Garage',N'Gestion Garage',0,null, 100405)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c3602', N'Garage', 4, N'Garage', N'Garage', NULL, NULL, NULL, NULL, N'/Garage', 0, N'Garage')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103131, N'fd101f2f-5b91-4de3-9a07-337b4a3c3602', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227602D',N'Gestion Garage',NULL, 12,N'gestion garage',N'gestion Garage',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227602D', 103131, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7602', N'fd101f2f-5b91-4de3-9a07-337b4a3c3602', N'51BF3865-133E-4E97-9F99-10562227602D')

--23/09/2020 --Amine Organigramme Role
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103132, N'Organigramme_Config', N'Organigramme', 0, NULL, 100401)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'81da3096-5ee0-43df-8561-79df89b346cf', N'Organigramme', 4, N'Organigramme', N'Organigramme', NULL, NULL, NULL, NULL, N'/payroll/employee/organizationChart', 0, N'Organigramme')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103132, N'81da3096-5ee0-43df-8561-79df89b346cf', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'a6acf5d2-8e3d-402c-9f61-72e52721cf6b',N'Organigramme',NULL, 12,N'Organigramme',N'Organigramme',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'a6acf5d2-8e3d-402c-9f61-72e52721cf6b', 103132, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'081728ec-0952-4fad-8b18-657f39ae8b1b', N'81da3096-5ee0-43df-8561-79df89b346cf', N'a6acf5d2-8e3d-402c-9f61-72e52721cf6b')

--- kossi delete extrait bancaire in paymentMethod
UPDATE  [Payment].[Settlement] SET IdPaymentMethod = (SELECT TOP(1) Id FROM [Payment].[PaymentMethod] WHERE MethodName like '%Espèce%') 
		WHERE IdPaymentMethod IN  (SELECT  Id FROM [Payment].[PaymentMethod] WHERE MethodName like '%Extrait bancaire%') ;

DELETE FROM [Payment].[PaymentMethod] WHERE MethodName like '%Extrait bancaire%';
 
-- 24/09/2020 : Ahmed
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig],[IdFunctionality],[IsActive]) values 
(100018,N'ED89FCB1-6CBA-4A58-AC13-1DA7B1E897C5',1)

--- Donia add offer bonuses to offer 28/09/2020
CREATE TABLE [RH].[OfferBonus] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdOffer]           INT            NOT NULL,
    [IdBonus]           INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [Value]             FLOAT (53)     NULL,
    [ValidityStartDate] DATE           NOT NULL,
    [ValidityEndDate]   DATE           NULL,
    CONSTRAINT [PK_OfferBonus] PRIMARY KEY CLUSTERED ([Id] ASC)
);
ALTER TABLE [RH].[OfferBonus] WITH NOCHECK
    ADD CONSTRAINT [FK_OfferBonus_Offer] FOREIGN KEY ([IdOffer]) REFERENCES [RH].[Offer] ([Id]) ON DELETE CASCADE;
ALTER TABLE [RH].[OfferBonus] WITH NOCHECK
    ADD CONSTRAINT [FK_OfferBonus_Bonus] FOREIGN KEY ([IdBonus]) REFERENCES [Payroll].[Bonus] ([Id]);
ALTER TABLE [RH].[OfferBonus] WITH CHECK CHECK CONSTRAINT [FK_OfferBonus_Offer];
ALTER TABLE [RH].[OfferBonus] WITH CHECK CHECK CONSTRAINT [FK_OfferBonus_Bonus];
 ----Imen add canceled status 
SET IDENTITY_INSERT [Payment].[PaymentStatus] ON
INSERT INTO [Payment].[PaymentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (7, N'Canceled', N'decaissé', 0, 0, NULL)
SET IDENTITY_INSERT [Payment].[PaymentStatus] OFF
ALTER TABLE [RH].[OfferBonus] WITH CHECK CHECK CONSTRAINT [FK_OfferBonus_Bonus];

--- 25/09/2020 : Amine ==> Add status column defaut value in base salary
ALTER TABLE [Payroll].[BaseSalary]
ADD [State] int null
--- 25/09/2020 : Amine ==> Add status column defaut value in contract bonus
ALTER TABLE [Payroll].[ContractBonus]
ADD [State] int null
--- 25/09/2020 : Amine ==> Add status column defaut value in contract BenefitInKind
ALTER TABLE [Payroll].[ContractBenefitInKind]
ADD [State] int null

--28/09/2020: houssem add codification 

UPDATE [ERPSettings].[Codification] SET [Name]=N'CodeFCSales' WHERE [Id]=280
UPDATE [ERPSettings].[Codification] SET [InitValue]=N'IS' WHERE [Id]=281
UPDATE [ERPSettings].[EntityCodification] SET [Property]=N'DocumentTypeCode', [Value]=N'I-SA' WHERE [Id]=57
GO

SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (379, N'CodeFCAsset', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (380, N'CodeFCPurchase', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (381, N'CodeFCPurchaseAsset', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (382, N'CaractereFC', 1, NULL, NULL, N'AS', 379, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (383, N'AnneeFC', 2, NULL, NULL, N'20', 379, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (384, N'Caractere-', 3, NULL, NULL, N'-', 379, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (385, N'compteur FC', 4, NULL, NULL, NULL, 379, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (386, N'CaractereFC', 1, NULL, NULL, N'IP', 380, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (387, N'AnneeFC', 2, NULL, NULL, N'20', 380, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (388, N'Caractere-', 3, NULL, NULL, N'-', 380, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (389, N'compteur FC', 4, NULL, NULL, NULL, 380, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (390, N'CaractereFC', 1, NULL, NULL, N'AP', 381, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (391, N'AnneeFC', 2, NULL, NULL, N'20', 381, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (392, N'Caractere-', 3, NULL, NULL, N'-', 381, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (393, N'compteur FC', 4, NULL, NULL, NULL, 381, 1, 1, N'00000000', 8)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF

SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (80, 313, N'DocumentTypeCode', N'IA-SA', 379)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (81, 313, N'DocumentTypeCode', N'I-PU', 380)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (82, 313, N'DocumentTypeCode', N'A-PU', 381)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
GO
SET IDENTITY_INSERT [Payment].[PaymentStatus] OFF

--- 30/09/2020 Ahmed 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101041, N'FE8641A3-25AC-467C-9E45-7BB77B77E51F', 1)
GO

-- chedi : add bank agencies, contacts and phones 01/10/2020 17:30
CREATE TABLE [Shared].[BankAgency] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            CONSTRAINT [DF_BankAgency_TransactionUserId] DEFAULT ((0)) NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [Label]             NVARCHAR (50)  NULL,
    [IdBank]            INT            NULL,
    CONSTRAINT [PK_BankAgency] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_BankAgency_Bank] FOREIGN KEY ([IdBank]) REFERENCES [Shared].[Bank] ([Id])
);
GO


GO
ALTER TABLE [Shared].[Bank]
    ADD [IdPhone] INT NULL;


GO
ALTER TABLE [Shared].[Contact] DROP COLUMN [IdBank];

GO
ALTER TABLE [Shared].[Contact]
    ADD [IdAgency] INT NULL;

	
GO
ALTER TABLE [Shared].[Bank] WITH NOCHECK
    ADD CONSTRAINT [FK_Bank_Phone] FOREIGN KEY ([IdPhone]) REFERENCES [Shared].[Phone] ([Id]);


GO
ALTER TABLE [Shared].[Contact] WITH NOCHECK
    ADD CONSTRAINT [FK_Contact_BankAgency] FOREIGN KEY ([IdAgency]) REFERENCES [Shared].[BankAgency] ([Id]);





---Marwa change CreateAssociatedDocument for purchase invoice---
update Sales.DocumentType set CreateAssociatedDocument=1 where CodeType='I-PU'

--- Donia add SessionLoanInstallment 02/10/2020
CREATE TABLE [Payroll].[SessionLoanInstallment] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdSession]         INT            NOT NULL,
    [IdLoanInstallment] INT            NOT NULL,
    [IdContract]        INT            NOT NULL,
    [Value]             FLOAT (53)     NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_SessionLoanInstallment] PRIMARY KEY CLUSTERED ([Id] ASC)
);
ALTER TABLE [Payroll].[SessionLoanInstallment] WITH NOCHECK
    ADD CONSTRAINT [FK_SessionLoan_Session] FOREIGN KEY ([IdSession]) REFERENCES [Payroll].[Session] ([Id]) ON DELETE CASCADE;

ALTER TABLE [Payroll].[SessionLoanInstallment] WITH NOCHECK
    ADD CONSTRAINT [FK_SessionLoan_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]);
ALTER TABLE [Payroll].[SessionLoanInstallment] WITH NOCHECK
    ADD CONSTRAINT [FK_SessionLoan_LoanInstallment] FOREIGN KEY ([IdLoanInstallment]) REFERENCES [Payroll].[LoanInstallment] ([Id]);
ALTER TABLE [Payroll].[SessionLoanInstallment] WITH CHECK CHECK CONSTRAINT [FK_SessionLoan_Session];
ALTER TABLE [Payroll].[SessionLoanInstallment] WITH CHECK CHECK CONSTRAINT [FK_SessionLoan_Contract];
ALTER TABLE [Payroll].[SessionLoanInstallment] WITH CHECK CHECK CONSTRAINT [FK_SessionLoan_LoanInstallment];

ALTER TABLE [Payroll].[PayslipDetails] DROP CONSTRAINT [FK_PayslipDetails_Loan];
ALTER TABLE [Payroll].[PayslipDetails] DROP COLUMN [IdLoan];
ALTER TABLE [Payroll].[PayslipDetails] ADD [IdLoanInstallment] INT NULL;
ALTER TABLE [Payroll].[PayslipDetails] WITH NOCHECK
    ADD CONSTRAINT [FK_PayslipDetails_LoanInstallment] FOREIGN KEY ([IdLoanInstallment]) REFERENCES [Payroll].[LoanInstallment] ([Id]);
ALTER TABLE [Payroll].[PayslipDetails] WITH CHECK CHECK CONSTRAINT [FK_PayslipDetails_LoanInstallment];


-- Narcisse: Delete BillingSession StartDate and EndDate
ALTER TABLE [Sales].[BillingSession] DROP COLUMN [EndDate], COLUMN [StartDate];

--- Donia add endtime to interview 13/10/2020
ALTER TABLE [RH].[Interview] ADD [EndTime]  TIME (7) DEFAULT '00:00:00' NOT NULL;

--- Donia add AutomaticCandidateMailSending to company 16/10/2020
ALTER TABLE [Shared].[Company] ADD [AutomaticCandidateMailSending] BIT DEFAULT 0 NOT NULL;

	
	


-- Mohamed BOUZIDI : Price new shema

ALTER TABLE [Inventory].[Item]	DROP	CONSTRAINT [FK_Item_DiscountGroupItem] 
ALTER TABLE [Inventory].[Item]	DROP	COLUMN [IdDiscountGroupItem]

ALTER TABLE [Sales].[Tiers]		DROP	CONSTRAINT [FK_Tiers_DiscountGroupTiers]
ALTER TABLE [Sales].[Tiers]		DROP	COLUMN [IdDiscountGroupTiers]

ALTER TABLE [Sales].[Prices]	DROP	CONSTRAINT [FK_Prices_DiscountGroupItem], 
										CONSTRAINT [FK_Prices_DiscountGroupTiers],
										CONSTRAINT [FK_Prices_Item], 
										CONSTRAINT [FK_Prices_Tiers],
										CONSTRAINT [FK_Prices_ContractServiceType],
										CONSTRAINT [DF_Prices_IsUsed],
										CONSTRAINT [DF_Prices_IsExclusif];
ALTER TABLE [Sales].[Prices]	DROP	COLUMN [IdDiscountGroupItem],
										COLUMN [IdDiscountGroupTiers],
										COLUMN [IdItem],
										COLUMN [IdTiers],
										COLUMN [IdContractServiceType],
										COLUMN [IsUsed],
										COLUMN [IsExclusive],										
										COLUMN [IdTypePrices],  
										COLUMN [StartDate],
										COLUMN [EndDate],
										COLUMN [MinQuantity],
										COLUMN [MaxQuantity],
										COLUMN [TypeValue],
										COLUMN [PricesValue],
										COLUMN [Observations],
										COLUMN [OrderDiscount],
										COLUMN [BonusTypeValue],
										COLUMN [BonusValue],
										COLUMN [BonusPercentage];

DROP TABLE [Inventory].[DiscountGroupItem]
DROP TABLE [Sales].[DiscountGroupTiers]
DROP TABLE [Sales].[ContractServiceType]

CREATE TABLE [Sales].[PriceDetail] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdPrices]          INT            NOT NULL,
    [StartDateTime]     DATETIME       NOT NULL,
    [EndDateTime]       DATETIME       NOT NULL,
    [Percentage]        FLOAT (53)     NULL,
    [ReducedValue]      FLOAT (53)     NULL,
    [SpecialPrice]      FLOAT (53)     NULL,
    [MinimumQuantity]   FLOAT (53)     NULL,
    [MaximumQuantity]   FLOAT (53)     NULL,
    [TotalPrices]       FLOAT (53)     NULL,
    [SaledItemsNumber]  FLOAT (53)     NULL,
    [GiftedItemsNumber] FLOAT (53)     NULL,
    [TypeOfPriceDetail] INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            CONSTRAINT [DF_PriceDetail_TransactionUserId] DEFAULT ((0)) NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_PriceDetail] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_PriceDetail_Prices] FOREIGN KEY ([IdPrices]) REFERENCES [Sales].[Prices] ([Id]) ON DELETE CASCADE
);
GO



CREATE TABLE [Inventory].[ItemPrices] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdItem]            INT            NOT NULL,
    [IdPrices]          INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            CONSTRAINT [DF_ItemPrices_TransactionUserId] DEFAULT ((0)) NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_ItemPrices] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_ItemPrices_ItemPrices] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_ItemPrices_Prices] FOREIGN KEY ([IdPrices]) REFERENCES [Sales].[Prices] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [IX_ItemPrices] UNIQUE NONCLUSTERED ([IdItem] ASC, [IdPrices] ASC, [Deleted_Token] ASC)
);
GO


CREATE TABLE [Sales].[TiersPrices] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdTiers]           INT            NOT NULL,
    [IdPrices]          INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            CONSTRAINT [DF_TiersPrices_TransactionUserId] DEFAULT ((0)) NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_TiersPrices] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_TiersPrices_Prices] FOREIGN KEY ([IdPrices]) REFERENCES [Sales].[Prices] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_TiersPrices_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [IX_TiersPrices] UNIQUE NONCLUSTERED ([IdPrices] ASC, [IdTiers] ASC, [Deleted_Token] ASC)
);
GO
-- Molka : drop [IdCity] and [IdCountry]  from [Shared].[Office] 28-09-2020

ALTER TABLE [Shared].[Office] ADD [Twitter] NVARCHAR (255) NULL
ALTER TABLE [Shared].[Office] ADD [Email] NVARCHAR (255) NULL
ALTER TABLE [Shared].[Office] ADD [Fax] NVARCHAR (255) NULL
Go