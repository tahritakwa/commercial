--26/01/2021 --Amine Contract typ Role

SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103146, N'Setting_Contract_Type', N' Paramétrage de type de contract', 0, NULL, 77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'c4331d13-11be-42a4-8dd6-bb65b37fa475', N'SettingContractType', 4, N'SettingContractType', N'SettingContractType', NULL, NULL, NULL, NULL, N'/SettingContractType', 0, N'SettingContractType')


INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103146, N'c4331d13-11be-42a4-8dd6-bb65b37fa475', 1)


INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'6164ae06-cdc1-4490-aa2f-3817c9f492c8',N'SettingContractType',NULL, 12,N'SettingContractType',N'SettingContractType',NULL,NULL,NULL,NULL,NULL,1)


INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'6164ae06-cdc1-4490-aa2f-3817c9f492c8', 103146, 1)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'5faf4707-3691-4531-8730-4bb39e08975e', N'c4331d13-11be-42a4-8dd6-bb65b37fa475', N'6164ae06-cdc1-4490-aa2f-3817c9f492c8')

--- Amine : Exit employee role 01/02/2021
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103147, N'Exit_employee', N' Sortie employé', 0, NULL, 100401)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'4374185b-285d-4a12-8758-747b1f2644af', N'ExitEmployee', 4, N'ExitEmployee', N'ExitEmployee', NULL, NULL, NULL, NULL, N'/ExitEmployee', 0, N'ExitEmployee')


INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103147, N'4374185b-285d-4a12-8758-747b1f2644af', 1)


INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'6dd774a1-dda9-4d0d-a99e-fbce5ce692c1',N'ExitEmployee',NULL, 12,N'ExitEmployee',N'ExitEmployee',NULL,NULL,NULL,NULL,NULL,1)


INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'6dd774a1-dda9-4d0d-a99e-fbce5ce692c1', 103147, 1)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'2bbda27d-5c50-4019-92f2-46739268a12e', N'4374185b-285d-4a12-8758-747b1f2644af', N'6dd774a1-dda9-4d0d-a99e-fbce5ce692c1')