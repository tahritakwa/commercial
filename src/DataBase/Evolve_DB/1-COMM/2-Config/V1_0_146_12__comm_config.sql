--03/12/2020 Ahmed
--user
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES 
(104158, N'UserSettings', N'Utilisateur', 0, NULL, 77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'f98575ba-890d-47c1-a3e8-4c28c9cdb258', N'UserSettings', 4, N'Utilisateur', N'user', NULL, NULL, NULL, NULL, N'/User', 0, N'User-Settings')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 104158, N'f98575ba-890d-47c1-a3e8-4c28c9cdb258', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'fd671f2f-5b90-4de3-9a07-177b4a3c8477', 104158, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'20b1954b-7565-421d-ae3e-eaae19258b9c', N'f98575ba-890d-47c1-a3e8-4c28c9cdb258', N'fd671f2f-5b90-4de3-9a07-177b4a3c8477')

--userGroup 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES 
(104159, N'UserGroupSettings', N'Utilisateur du groupe', 0, NULL, 77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'f98575ba-890d-47c1-a3e8-4c28c9cdb259', N'UserGroupSettings', 4, N'Utilisateur du groupe', N'user group', NULL, NULL, NULL, NULL, N'/UserGroup', 0, N'User-Group-Settings')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 104159, N'f98575ba-890d-47c1-a3e8-4c28c9cdb259', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'fd671f2f-5b90-4de3-9a07-177b4a3c8477', 104159, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'20b1954b-7565-421d-ae3e-eaae19259b9c', N'f98575ba-890d-47c1-a3e8-4c28c9cdb259', N'fd671f2f-5b90-4de3-9a07-177b4a3c8477')

--role
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES 
(104160, N'roleSettings', N'Rôles', 0, NULL, 77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'f98575ba-890d-47c1-a3e8-4c28c9cdb260', N'roleSettings', 4, N'Rôle', N'Role', NULL, NULL, NULL, NULL, N'/Role', 0, N'Role-Settings')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 104160, N'f98575ba-890d-47c1-a3e8-4c28c9cdb260', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'fd671f2f-5b90-4de3-9a07-177b4a3c8477', 104160, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'20b1954b-7565-421d-ae3e-eaae19260b9c', N'f98575ba-890d-47c1-a3e8-4c28c9cdb260', N'fd671f2f-5b90-4de3-9a07-177b4a3c8477')

insert into [ERPSettings].[RoleConfigByRole] ([IdRoleConfig],[IdRole],[IsActive],[IsVisible],[TransactionUserId]) values (104160,1,1,0,null)
