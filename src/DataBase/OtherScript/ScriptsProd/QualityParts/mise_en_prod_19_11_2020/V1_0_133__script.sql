--04/11/2020 : Ahmed 
--rayons et casiers
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(104136,N'shelfStorage-Config',N'Rayons et casiers',0,null, 22222)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-136b4a3c3201', N'ShelfAndStorage', 4, N'rayon et casier', N'Shelf and storage', NULL, NULL, NULL, NULL, N'/Stock', 0, N'Shelf_storage')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 104136, N'fd101f2f-5b91-4de3-9a07-136b4a3c3201', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'2193DDF9-9631-4AAF-BB15-5F95FC25E44F', 104136, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-136b4a3c7201', N'fd101f2f-5b91-4de3-9a07-136b4a3c3201', N'2193DDF9-9631-4AAF-BB15-5F95FC25E44F')

--facturation a terme
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(104137,N'TermBilling-config',N'Facturation à terme',0,null, 33333)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-137b4a3c3201', N'TermBilling', 4, N'Facturation à terme', N'term billing', NULL, NULL, NULL, NULL, N'/Sales', 0, N'Term_Billing')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 104137, N'fd101f2f-5b91-4de3-9a07-137b4a3c3201', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'D438FBAD-7305-4DAD-AB44-A4FB84318A83', 104137, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-137b4a3c7201', N'fd101f2f-5b91-4de3-9a07-137b4a3c3201', N'D438FBAD-7305-4DAD-AB44-A4FB84318A83')

--client état de créance 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(104138,N'ReceivablesState-Client',N'Etat de créance client',0,null, 100009)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-138b4a3c3201', N'ReceivablesState-client', 4, N'etat de créance client', N'Receivables State client', NULL, NULL, NULL, NULL, N'/tréso', 0, N'ReceivablesState_Client')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 104138, N'fd101f2f-5b91-4de3-9a07-138b4a3c3201', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'87BEB2E4-EFEB-4341-B96B-6E6BEC8A308A', 104138, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-138b4a3c7201', N'fd101f2f-5b91-4de3-9a07-138b4a3c3201', N'87BEB2E4-EFEB-4341-B96B-6E6BEC8A308A')

--FRS état de créance 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(104139,N'ReceivablesState-FRS',N'Etat de créance fournisseur',0,null, 100009)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-139b4a3c3201', N'ReceivablesState-frs', 4, N'etat de créance frs', N'Receivables State supplier', NULL, NULL, NULL, NULL, N'/tréso', 0, N'ReceivablesState_FRS')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 104139, N'fd101f2f-5b91-4de3-9a07-139b4a3c3201', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'87BEB2E4-EFEB-4341-B96B-6E6BEC8A308A', 104139, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-139b4a3c7201', N'fd101f2f-5b91-4de3-9a07-139b4a3c3201', N'87BEB2E4-EFEB-4341-B96B-6E6BEC8A308A')

-- 10/11/2020 : Narcisse: Stabilisation solde de compte conge 	
GO
ALTER TABLE [Payroll].[ExitEmployeeLeaveLine] ALTER COLUMN [AcquiredParMonth] INT NOT NULL;

ALTER TABLE [Payroll].[ExitEmployeeLeaveLine] ALTER COLUMN [DayTakenPerMonth] NVARCHAR (MAX) NOT NULL;

ALTER TABLE [Payroll].[ExitEmployeeLeaveLine] ALTER COLUMN [Month] DATE NOT NULL;

ALTER TABLE [Payroll].[ExitEmployeeLeaveLine] ALTER COLUMN [TotalTakenPerMonth] FLOAT (53) NOT NULL;


GO
ALTER TABLE [Payroll].[ExitEmployeeLeaveLine]
    ADD [CumulativeTaken]    FLOAT (53) NOT NULL,
        [CumulativeAcquired] FLOAT (53) NOT NULL,
        [BalancePerMonth] FLOAT (53) NOT NULL;