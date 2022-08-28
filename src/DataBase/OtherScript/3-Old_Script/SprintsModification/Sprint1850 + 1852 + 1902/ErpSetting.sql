
-- Mohamed BOUZIDI : Team Functionnality

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
ALTER TABLE [ERPSettings].[FormComponent] DROP CONSTRAINT [FK_FormComponent_Component]
ALTER TABLE [ERPSettings].[FormComponent] DROP CONSTRAINT [FK_FormComponent_ServiceParameters]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'39aa31cd-4781-402d-a3ff-3c142a22d932', N'Team-LIST', 4, N'Liste equipes', N'Team list', N'Team list', N'Team list', N'Team list', N'Team list', N'/payroll/team/list', 0, N'LIST-Team')

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'39aa31cd-4781-402d-a3ff-3c142a22d932', 1, 1, 1, NULL)


INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'52370bb4-ec37-4301-b88a-4eafb5b8bbc1', 1, 1)

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'52370bb4-ec37-4301-b88a-4eafb5b8bbc1', N'Team', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 20, N'Equipe', N'Team', N'Team', N'Team', N'Team', N'Team', N'icon-note', 0)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'416a1dc6-3c56-48d2-a4f0-2b119548e531', N'39aa31cd-4781-402d-a3ff-3c142a22d932', N'52370bb4-ec37-4301-b88a-4eafb5b8bbc1')
SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (368, N'Payroll', N'Team', N'Team', NULL, 0, N'Team', N'Equipe', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[FormComponent]
    ADD CONSTRAINT [FK_FormComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[FormComponent]
    ADD CONSTRAINT [FK_FormComponent_ServiceParameters] FOREIGN KEY ([IdServiceParameter]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION

-- Narcisse: ERPSettings role CNSS

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'195ff984-63bb-42ff-a9af-963e7661ec63', N'Cnss-UPDATE', 2, N'Modifier CNSS', N'Update CNSS', N'Update CNSS', N'Update CNSS', N'Update CNSS', N'Update CNSS', N'/payroll/cnss/update', 0, N'UPDATE-Cnss')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'537a93c1-9b68-42cb-9a0e-c8b253dbafa2', N'Cnss-ADD', 1, N'Ajouter CNSS', N'Add CNSS', N'Add CNSS', N'Add CNSS', N'Add CNSS', N'Add CNSS', N'/payroll/cnss/add', 0, N'ADD-Cnss')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'cb1c069e-5af0-4e65-b77c-97e1fb15779c', N'Cnss-DELETE', 3, N'Supprimer CNSS', N'Delete CNSS', N'Delete CNSS', N'Delete CNSS', N'Delete CNSS', N'Delete CNSS', N'/payroll/cnss/delete', 0, N'DELETE-Cnss')

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'05e66fa8-2cfe-4663-a30d-13454e8fbd5b', N'Cnss', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 20, N'Cnss', N'Cnss', N'Cnss', N'Cnss', N'Cnss', N'Cnss', N'icon-note', 0)

INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'05e66fa8-2cfe-4663-a30d-13454e8fbd5b', 1, 1)


INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'537a93c1-9b68-42cb-9a0e-c8b253dbafa2', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'195ff984-63bb-42ff-a9af-963e7661ec63', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'cb1c069e-5af0-4e65-b77c-97e1fb15779c', 1, 1, 1, NULL)



INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'1132ac85-b676-48e4-9808-3921596942a7', N'cb1c069e-5af0-4e65-b77c-97e1fb15779c', N'05e66fa8-2cfe-4663-a30d-13454e8fbd5b')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'16172f9a-f8a1-44ee-a76c-a5673271ac3e', N'195ff984-63bb-42ff-a9af-963e7661ec63', N'dca0e118-de89-4b9d-a25b-08964a3856b9')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b4bc9aa3-2492-4dd9-bc2f-095b238f8663', N'537a93c1-9b68-42cb-9a0e-c8b253dbafa2', N'dca0e118-de89-4b9d-a25b-08964a3856b9')

ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION


--Mohamed BOUZIDI : Team List Add Update
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'33fc3fb8-f12b-40af-acfa-be21fddbd790', N'Team-ADD', 1, N'Ajouter équipe', N'Add team', N'Add team', N'Add team', N'Add team', N'Add team', N'/payroll/team/add', 0, N'ADD-Team')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'41eabde8-52de-4c93-895e-afdd95ada7dd', N'Team-DELETE', 3, N'Supprimer équipe', N'DELETE Team', N'DELETE Team', N'DELETE Team', N'DELETE Team', N'DELETE Team', N'/payroll/team/delete', 0, N'DELETE-Team')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'5472cf06-def0-4062-95df-6c6abb535288', N'Team-UPDATE', 2, N'MAJ équipe', N'UPDATE Team', N'UPDATE Team', N'UPDATE Team', N'UPDATE Team', N'UPDATE Team', N'/payroll/team/update', 0, N'UPDATE-Team')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'246f2a5f-fa06-4a60-95d7-21e96c750387', N'33fc3fb8-f12b-40af-acfa-be21fddbd790', N'52370bb4-ec37-4301-b88a-4eafb5b8bbc1')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'2c506725-8633-481c-9c66-d7ce4cbddef9', N'5472cf06-def0-4062-95df-6c6abb535288', N'52370bb4-ec37-4301-b88a-4eafb5b8bbc1')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e4d126f8-829e-4322-948d-28c1d567bf94', N'41eabde8-52de-4c93-895e-afdd95ada7dd', N'52370bb4-ec37-4301-b88a-4eafb5b8bbc1')

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'33fc3fb8-f12b-40af-acfa-be21fddbd790', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'5472cf06-def0-4062-95df-6c6abb535288', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'41eabde8-52de-4c93-895e-afdd95ada7dd', 1, 1, 1, NULL)

ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION
--Price functionnalitys ADD and UPDATE    
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
 
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'2024b4f0-2771-4431-a8af-d7264b28d962', N'Prices-ADD', 1, N'ADD-Prices', N'ADD-Prices', NULL, NULL, NULL, NULL, N'/sales/prices/add', 0, N'ADD-Prices')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ecf86452-0e62-445c-b370-0e7ca708212b', N'Prices-UPDATE', 2, N'UPDATE-Prices', N'UPDATE-Prices', NULL, NULL, NULL, NULL, N'/sales/prices/update', 0, N'UPDATE-Prices')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'bb697b64-1c96-4654-ae7a-0713b10816af', N'2024b4f0-2771-4431-a8af-d7264b28d962', N'3545d556-108a-4d68-9c99-afc572ba34df')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f7e33501-de0b-4d70-bb05-bf15d0104809', N'ecf86452-0e62-445c-b370-0e7ca708212b', N'3545d556-108a-4d68-9c99-afc572ba34df')
 
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'ecf86452-0e62-445c-b370-0e7ca708212b', 1, 1, 1, NULL)
 
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'2024b4f0-2771-4431-a8af-d7264b28d962', 1, 1, 1, NULL)
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
 
COMMIT TRANSACTION

--- Marwa add information of purchase request comment ----
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
SET IDENTITY_INSERT [ERPSettings].[Information] ON
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501069, N'bb95f2a9-8ee5-415e-8b24-2447e6ba4dcb', N'/purchase/purchaserequest/show', N'{CREATOR} a ajouté un commentaire pour la demande d''achat {CODE}', N'{CREATOR} added a comment for the purchase request {CODE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_COMMENT_PURCHASE_REQUEST_SHOW', N'ADD_COMMENT_PURCHASE_REQUEST_SHOW')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501070, N'bb95f2a9-8ee5-415e-8b24-2447e6ba4dcb', N'/purchase/purchaserequest/edit', N'{CREATOR} a ajouté un commentaire pour la demande d''achat {CODE}', N'{CREATOR} added a comment for the purchase request {CODE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_COMMENT_PURCHASE_REQUEST_UPDATE', N'ADD_COMMENT_PURCHASE_REQUEST_UPDATE')
SET IDENTITY_INSERT [ERPSettings].[Information] OFF
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
COMMIT TRANSACTION

--- Marwa update apiRole of functionnality update-country ---

UPDATE [ERPSettings].[Functionality] SET [ApiRole]=N'UPDATE-Country' WHERE [IdFunctionality]=N'e5a6ccba-20d6-47db-b131-9c564f67a361'

--- Narcisse : Add Transfer Order and transfer order details functionnality

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'226744c0-2184-4c6c-aed7-4ef91d60aff6', N'TransferOrderDetails-LIST', 4, N'Lister details ordre de virement', N'List transfer order details', N'List transfer order details', N'List transfer order details', N'List transfer order details', N'List transfer order details', N'/payroll/transferorderdetails/list', 0, N'LIST-TransferOrderDetails')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'387aa8a0-35f2-4c32-8806-ece5fa6c7f60', N'TransferOrder-DELETE', 3, N'Supprimer ordre de virement', N'Delete transfer order', N'Delete transfer order', N'Delete transfer order', N'Delete transfer order', N'Delete transfer order', N'/payroll/transferorder/delete', 0, N'DELETE-TransferOrder')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'4e57b151-f2c9-40ff-b59d-9158fd33d899', N'TransferOrder-Print', 9, N'Télecharger ordre de virement', N'Print transfer order', N'Print transfer order', N'Print transfer order', N'Print transfer order', N'Print transfer order', N'/payroll/transferorder/print', 0, N'PRINT-TransferOrder')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'77d4dce7-5208-4995-9ac2-5bfb49f3bc94', N'TransferOrder-UPDATE', 2, N'Modifier ordre de virement', N'Update transfer order', N'Update transfer order', N'Update transfer order', N'Update transfer order', N'Update transfer order', N'/payroll/transferorder/update', 0, N'UPDATE-TransferOrder')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a1aab54d-bf1b-488d-b1f0-2435306d77fa', N'TransferOrderDetails-UPDATE', 2, N'Modifier details ordre de virement', N'Update transfer order details', N'Update transfer order details', N'Update transfer order details', N'Update transfer order details', N'Update transfer order details', N'/payroll/transferorderdetails/update', 0, N'UPDATE-TransferOrderDetails')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'af2dfe18-6a90-406b-891d-6308772f1223', N'TransferOrder-LIST', 4, N'Lister les ordres de virement', N'List transfer order', N'List transfer order', N'List transfer order', N'List transfer order', N'List transfer order', N'/payroll/transferorder/list', 0, N'LIST-TransferOrder')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b5e41cce-5aca-4c1f-99c8-5a46f38bc83e', N'TransferOrderDetails-DELETE', 3, N'Supprimer details ordre de virement', N'Delete transfer order details', N'Delete transfer order details', N'Delete transfer order details', N'Delete transfer order details', N'Delete transfer order details', N'/payroll/transferorderdetails/delete', 0, N'DELETE-TransferOrderDetails')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b7128c74-3b1a-47c4-851d-c211baa1fb0e', N'TransferOrderDetails-ADD', 1, N'Ajouter details ordre de virement', N'Add transfer order details', N'Add transfer order details', N'Add transfer order details', N'Add transfer order details', N'Add transfer order details', N'/payroll/transferorderdetails/add', 0, N'ADD-TransferOrderDetails')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'c1be620f-636b-413f-b857-dab1d1fff0ac', N'TransferOrder-ADD', 1, N'Ajouter ordre de virement', N'Add transfer order', N'Add transfer order', N'Add transfer order', N'Add transfer order', N'Add transfer order', N'/payroll/transferorder/add', 0, N'ADD-TransferOrder')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'dac6e0f0-46e0-4a0e-be85-f4f4a4a02b25', N'TransferOrderDetails-Show', 15, N'Visualiser transfer order details', N'Show transfer order details ', N'Show transfer order details ', N'Show transfer order details ', N'Show transfer order details ', N'Show transfer order details ', N'/payroll/transferorderdetails/show', 0, N'Show-TransferOrderDetails')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'f23a0afe-4f7e-49b7-936f-5c64c2f93f72', N'TransferOrder-Show', 15, N'Visualiser ordre de virement', N'List transfer order', N'List transfer order', N'List transfer order', N'List transfer order', N'List transfer order', N'/payroll/transferorder/show', 0, N'SHOW-TransferOrder')

INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'5b998e60-fe89-4578-83bf-9471bdec317d', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'8655e017-b3e2-49bd-8a4a-c84d3abed569', 1, 1)

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'5b998e60-fe89-4578-83bf-9471bdec317d', N'TransferOrder', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 22, N'Ordre de virement', N'Transfer order', N'TransferOrder', N'TransferOrder', N'TransferOrder', N'TransferOrder', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'8655e017-b3e2-49bd-8a4a-c84d3abed569', N'TransferOrderDetails', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 23, N'Details d''ordre de virement', N'Transfer order details', N'Transfer order details', N'Transfer order details', N'Transfer order details', N'Transfer order details', N'icon-note', 0)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'0ea91e33-c291-4c4e-a652-d07c270494cf', N'77d4dce7-5208-4995-9ac2-5bfb49f3bc94', N'5b998e60-fe89-4578-83bf-9471bdec317d')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'5c612250-1400-42f2-b06d-ba00e6451445', N'dac6e0f0-46e0-4a0e-be85-f4f4a4a02b25', N'8655e017-b3e2-49bd-8a4a-c84d3abed569')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'6c1fab75-7171-4190-9c45-c7db79f1149e', N'b7128c74-3b1a-47c4-851d-c211baa1fb0e', N'8655e017-b3e2-49bd-8a4a-c84d3abed569')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'6ccbbf8e-3870-464e-9f3e-92e9977c8421', N'f23a0afe-4f7e-49b7-936f-5c64c2f93f72', N'5b998e60-fe89-4578-83bf-9471bdec317d')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'7114ca4c-4b6b-4a65-8be3-fcb02c096cea', N'b5e41cce-5aca-4c1f-99c8-5a46f38bc83e', N'8655e017-b3e2-49bd-8a4a-c84d3abed569')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b6acdbc2-cc8a-43f0-9a61-d4dfa5212ef0', N'af2dfe18-6a90-406b-891d-6308772f1223', N'5b998e60-fe89-4578-83bf-9471bdec317d')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'bcb99010-528b-4bcc-a60f-ccb76fa9ba33', N'4e57b151-f2c9-40ff-b59d-9158fd33d899', N'5b998e60-fe89-4578-83bf-9471bdec317d')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c62dab4d-813b-419e-9cf9-eafbc99e32af', N'387aa8a0-35f2-4c32-8806-ece5fa6c7f60', N'5b998e60-fe89-4578-83bf-9471bdec317d')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'd666732c-bba2-4591-9b76-adc3603ff5c1', N'226744c0-2184-4c6c-aed7-4ef91d60aff6', N'8655e017-b3e2-49bd-8a4a-c84d3abed569')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'dfa5ba89-0992-4dcb-bf8c-97771f9309a6', N'a1aab54d-bf1b-488d-b1f0-2435306d77fa', N'8655e017-b3e2-49bd-8a4a-c84d3abed569')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ea79e259-7f86-4bc1-984c-55625eb42fd6', N'c1be620f-636b-413f-b857-dab1d1fff0ac', N'5b998e60-fe89-4578-83bf-9471bdec317d')

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'c1be620f-636b-413f-b857-dab1d1fff0ac', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'77d4dce7-5208-4995-9ac2-5bfb49f3bc94', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'387aa8a0-35f2-4c32-8806-ece5fa6c7f60', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'af2dfe18-6a90-406b-891d-6308772f1223', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'f23a0afe-4f7e-49b7-936f-5c64c2f93f72', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'b7128c74-3b1a-47c4-851d-c211baa1fb0e', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'a1aab54d-bf1b-488d-b1f0-2435306d77fa', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'b5e41cce-5aca-4c1f-99c8-5a46f38bc83e', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'226744c0-2184-4c6c-aed7-4ef91d60aff6', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'dac6e0f0-46e0-4a0e-be85-f4f4a4a02b25', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'4e57b151-f2c9-40ff-b59d-9158fd33d899', 1, 1, 1, NULL)

ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION

-- Imen Chaaben : PriceRequest, PriceRequestDetail et TiersPriceRequest Roles


BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
UPDATE [ERPSettings].[Module] SET [FR]=N'Devis achat', [EN]=N'purchase quotation' WHERE [IdModule]=N'22327ce7-b81c-4c0f-ac75-b1c4ced325c1'

INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1a5ad493-2aa3-4b33-9f27-810da7376dbe', N'ADD-TiersPriceRequest', 1, N'ADD-TiersPriceRequest', N'ADD-TiersPriceRequest', N'ADD-TiersPriceRequest', N'ADD-TiersPriceRequest', N'ADD-TiersPriceRequest', N'ADD-TiersPriceRequest', N'/sales/tierspricerequest/add', 0, N'ADD-TiersPriceRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1db4fb60-19a8-410d-9b19-f8448d480dc7', N'PriceRequest-LIST', 4, N'LIST-PriceRequest', N'LIST-PriceRequest', N'LIST-PriceRequest', N'LIST-PriceRequest', N'LIST-PriceRequest', N'LIST-PriceRequest', N'/sales/pricerequest/list', 0, N'LIST-PriceRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1fbc4b46-46d4-4e3c-afd6-e007dcef5205', N'PriceRequest-ADD', 1, N'ADD-PriceRequest', N'ADD-PriceRequest', N'ADD-PriceRequest', N'ADD-PriceRequest', N'ADD-PriceRequest', N'ADD-PriceRequest', N'/sales/pricerequest/add', 0, N'ADD-PriceRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'22286879-b923-4b86-b2e3-8e9d973c9f6f', N'LIST-TiersPriceRequest', 4, N'LIST-TiersPriceRequest', N'LIST-TiersPriceRequest', N'LIST-TiersPriceRequest', N'LIST-TiersPriceRequest', N'LIST-TiersPriceRequest', N'LIST-TiersPriceRequest', N'/sales/tierspricerequest/list', 1, N'LIST-TiersPriceRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'54a5eb28-f2b7-460b-a21c-4a552dfc6d4d', N'UPDATE-TiersPriceRequest', 2, N'UPDATE-TiersPriceRequest', N'UPDATE-TiersPriceRequest', N'UPDATE-TiersPriceRequest', N'UPDATE-TiersPriceRequest', N'UPDATE-TiersPriceRequest', N'UPDATE-TiersPriceRequest', N'/sales/tierspricerequest/update', 0, N'UPDATE-TiersPriceRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'58a85ed9-603e-48f7-b7a3-2c1a83f7323e', N'UPDATE-PriceRequestDetail', 2, N'UPDATE-PriceRequestDetail', N'UPDATE-PriceRequestDetail', N'UPDATE-PriceRequestDetail', N'UPDATE-PriceRequestDetail', N'UPDATE-PriceRequestDetail', N'UPDATE-PriceRequestDetail', N'/sales/pricerequestdetail/update', 1, N'UPDATE-PriceRequestDetail')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6c341a75-8c0d-4b12-94a2-a524b09f83bb', N'ADD-PriceRequestDetail', 1, N'ADD-PriceRequestDetail', N'ADD-PriceRequestDetail', N'ADD-PriceRequestDetail', N'ADD-PriceRequestDetail', N'ADD-PriceRequestDetail', N'ADD-PriceRequestDetail', N'/sales/pricerequestdetail/add', 1, N'ADD-PriceRequestDetail')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'6e178c65-ab35-4fce-aa3f-0e148987dab9', N'DELETE-TiersPriceRequest', 3, N'DELETE-TiersPriceRequest', N'DELETE-TiersPriceRequest', N'DELETE-TiersPriceRequest', N'DELETE-TiersPriceRequest', N'DELETE-TiersPriceRequest', N'DELETE-TiersPriceRequest', N'/sales/tierspricerequest/delete', 0, N'DELETE-TiersPriceRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'8cae7fb4-1f9a-4add-ab1e-a466c2cbd702', N'PriceRequest-UPDATE', 2, N'UPDATE-PriceRequest', N'UPDATE-PriceRequest', N'UPDATE-PriceRequest', N'UPDATE-PriceRequest', N'UPDATE-PriceRequest', N'UPDATE-PriceRequest', N'/sales/pricerequest/update', 0, N'UPDATE-PriceRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'946982d0-e0c4-4c58-8959-c1731f793163', N'SHOW-PriceRequestDetail', 15, N'SHOW-PriceRequestDetail', N'SHOW-PriceRequestDetail', N'SHOW-PriceRequestDetail', N'SHOW-PriceRequestDetail', N'SHOW-PriceRequestDetail', N'SHOW-PriceRequestDetail', N'/sales/pricerequestdetail/show', 1, N'SHOW-PriceRequestDetail')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'a8158cb8-7a34-4267-9e33-1b138b6fea2f', N'SHOW-PriceRequest', 15, N'Show-PriceRequest', N'Show-PriceRequest', N'Show-PriceRequest', N'Show-PriceRequest', N'Show-PriceRequest', N'Show-PriceRequest', N'/sales/pricerequest/show', 0, N'SHOW-PriceRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'b2faf601-15d4-4282-bac4-7214dc4a23f9', N'DELETE-PriceRequestDetail', 3, N'DELETE-PriceRequestDetail', N'DELETE-PriceRequestDetail', N'DELETE-PriceRequestDetail', N'DELETE-PriceRequestDetail', N'DELETE-PriceRequestDetail', N'DELETE-PriceRequestDetail', N'/sales/pricerequestdetail/delete', 1, N'DELETE-PriceRequestDetail')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'ca1e2ec0-efe1-4605-afe5-fda2721325b4', N'LIST-PriceRequestDetail', 4, N'LIST-PriceRequestDetail', N'LIST-PriceRequestDetail', N'LIST-PriceRequestDetail', N'LIST-PriceRequestDetail', N'LIST-PriceRequestDetail', N'LIST-PriceRequestDetail', N'/sales/pricerequestdetail/list', 1, N'LIST-PriceRequestDetail')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'd617ff97-654e-4788-add5-c28e90abe680', N'SHOW-TiersPriceRequest', 15, N'SHOW-TiersPriceRequest', N'SHOW-TiersPriceRequest', N'SHOW-TiersPriceRequest', N'SHOW-TiersPriceRequest', N'SHOW-TiersPriceRequest', N'SHOW-TiersPriceRequest', N'/sales/tierspricerequest/show', 1, N'SHOW-TiersPriceRequest')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'fc8a73be-4987-4cd7-b980-39e5b658f2aa', N'PriceRequest-DELETE', 3, N'DELETE-PriceRequest', N'DELETE-PriceRequest', N'DELETE-PriceRequest', N'DELETE-PriceRequest', N'DELETE-PriceRequest', N'DELETE-PriceRequest', N'/sales/pricerequest/delete', 0, N'DELETE-PriceRequest')

INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'87b84a91-98fd-49f1-80f3-04630d73ed79', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'd407d85f-428f-42d2-9a7c-e7812f23fbc9', 1, 1)
INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'9ca06367-ad8b-4aa1-8994-316241dcd5de', 1, 1)

INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'87b84a91-98fd-49f1-80f3-04630d73ed79', N'PriceRequest', N'd438fbad-7305-4dad-ab44-a4fb84318a83', 10, N'PurchasePriceRequest', N'PurchasePriceRequest', N'PurchasePriseRequest', N'PurchasePriseRequest', N'PurchasePriseRequest', N'PurchasePriseRequest', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'9ca06367-ad8b-4aa1-8994-316241dcd5de', N'TiersPriceRequest', N'd438fbad-7305-4dad-ab44-a4fb84318a83', 12, N'PurchaseTiersPriceRequest', N'PurchaseTiersPriceRequest', N'PurchaseTiersPriceRequest', N'PurchaseTiersPriceRequest', N'PurchaseTiersPriceRequest', N'PurchaseTiersPriceRequest', N'icon-note', 0)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'd407d85f-428f-42d2-9a7c-e7812f23fbc9', N'PriceRequestDetail', N'd438fbad-7305-4dad-ab44-a4fb84318a83', 11, N'PurchasePriceRequestDetail', N'PurchasePriceRequestDetail', N'PurchasePriceRequestDetail', N'PurchasePriceRequestDetail', N'PurchasePriceRequestDetail', N'PurchasePriceRequestDetail', N'icon-note', 0)

INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'20638f28-6045-4d44-941f-14f0d50a9f68', N'54a5eb28-f2b7-460b-a21c-4a552dfc6d4d', N'9ca06367-ad8b-4aa1-8994-316241dcd5de')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'357369c3-30ff-42a4-8f95-40555568b201', N'1a5ad493-2aa3-4b33-9f27-810da7376dbe', N'9ca06367-ad8b-4aa1-8994-316241dcd5de')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'35c37194-c516-48b7-82c1-4de636b22c86', N'fc8a73be-4987-4cd7-b980-39e5b658f2aa', N'87b84a91-98fd-49f1-80f3-04630d73ed79')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'49f55ffd-902e-4307-98ce-65d50de5cc78', N'1db4fb60-19a8-410d-9b19-f8448d480dc7', N'87b84a91-98fd-49f1-80f3-04630d73ed79')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'521071ff-6477-4072-ba81-acb699ec7e70', N'22286879-b923-4b86-b2e3-8e9d973c9f6f', N'9ca06367-ad8b-4aa1-8994-316241dcd5de')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'5516550b-c19c-4910-b627-45b49ee72682', N'58a85ed9-603e-48f7-b7a3-2c1a83f7323e', N'd407d85f-428f-42d2-9a7c-e7812f23fbc9')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'5bb2b4d3-9d76-4b32-beb6-1ca9a27b44b0', N'6e178c65-ab35-4fce-aa3f-0e148987dab9', N'9ca06367-ad8b-4aa1-8994-316241dcd5de')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'720c3066-48d7-4d0b-a40a-44b410dd43c5', N'ca1e2ec0-efe1-4605-afe5-fda2721325b4', N'd407d85f-428f-42d2-9a7c-e7812f23fbc9')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'78384f10-2b4a-4e01-8d94-5fcd315bcf0a', N'a8158cb8-7a34-4267-9e33-1b138b6fea2f', N'87b84a91-98fd-49f1-80f3-04630d73ed79')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'ba15318f-ffaa-414b-81fc-37a4072b8bd9', N'd617ff97-654e-4788-add5-c28e90abe680', N'9ca06367-ad8b-4aa1-8994-316241dcd5de')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c3c39da0-feb2-40ad-ba52-d34ec63642b1', N'8cae7fb4-1f9a-4add-ab1e-a466c2cbd702', N'87b84a91-98fd-49f1-80f3-04630d73ed79')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'db0740c0-7823-4311-ac74-dfdee169131b', N'6c341a75-8c0d-4b12-94a2-a524b09f83bb', N'd407d85f-428f-42d2-9a7c-e7812f23fbc9')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'def883fc-2a25-4e34-97c6-575929c335b2', N'1fbc4b46-46d4-4e3c-afd6-e007dcef5205', N'87b84a91-98fd-49f1-80f3-04630d73ed79')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e59996c4-b475-4ff2-b116-9f8c5cef56e9', N'b2faf601-15d4-4282-bac4-7214dc4a23f9', N'd407d85f-428f-42d2-9a7c-e7812f23fbc9')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'e67c9475-c855-4bec-9ab7-c41f708786b8', N'946982d0-e0c4-4c58-8959-c1731f793163', N'd407d85f-428f-42d2-9a7c-e7812f23fbc9')
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (117, N'PriceRequestCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (118, N'CaracterePR', 1, NULL, NULL, N'PR', 117, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (119, N'Annee', 2, N'return (DateTime.Now.Year.ToString().Substring(2,2));', N'string', NULL, 117, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (120, N'Caractere/', 3, NULL, NULL, N'/', 117, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (121, N'compteurPurchaseRequest', 4, NULL, NULL, NULL, 117, 1, 1, N'00000002', 8)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (27, 369, NULL, NULL, 117)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'1fbc4b46-46d4-4e3c-afd6-e007dcef5205', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'8cae7fb4-1f9a-4add-ab1e-a466c2cbd702', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'1db4fb60-19a8-410d-9b19-f8448d480dc7', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'fc8a73be-4987-4cd7-b980-39e5b658f2aa', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'a8158cb8-7a34-4267-9e33-1b138b6fea2f', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'1a5ad493-2aa3-4b33-9f27-810da7376dbe', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'54a5eb28-f2b7-460b-a21c-4a552dfc6d4d', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'6e178c65-ab35-4fce-aa3f-0e148987dab9', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'22286879-b923-4b86-b2e3-8e9d973c9f6f', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'd617ff97-654e-4788-add5-c28e90abe680', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'6c341a75-8c0d-4b12-94a2-a524b09f83bb', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'58a85ed9-603e-48f7-b7a3-2c1a83f7323e', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'b2faf601-15d4-4282-bac4-7214dc4a23f9', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'ca1e2ec0-efe1-4605-afe5-fda2721325b4', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'946982d0-e0c4-4c58-8959-c1731f793163', 1, 1, 1, NULL)

SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (369, N'Sales', N'PriceRequest', N'PriceRequest', NULL, 0, N'PriceRequest', N'PriceRequest', N'PriceRequest', N'PriceRequest', N'PriceRequest', N'PriceRequest', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (373, N'Sales', N'PriceRequestDetail', N'PriceRequestDetail', NULL, 0, N'PriceRequestDetail', N'PriceRequestDetail', N'PriceRequestDetail', N'PriceRequestDetail', N'PriceRequestDetail', N'PriceRequestDetail', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (374, N'Sales', N'TiersPriceRequest', N'TiersPriceRequest', NULL, 0, N'TiersPriceRequest', N'TiersPriceRequest', N'TiersPriceRequest', N'TiersPriceRequest', N'TiersPriceRequest', N'TiersPriceRequest', NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION



BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'299729a5-d7ed-4f30-a13c-1960d7374507', N'Stock-DELETE', 3, N'Supprimer document de stock', N'Delete stock document', NULL, NULL, NULL, NULL, N'/stock/delete', 0, N'DELETE-StockDocument')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'92c5486b-f76f-4253-be9a-f679b5aaf461', N'StockDocument-DELETE', 3, NULL, NULL, NULL, NULL, NULL, NULL, N'/divers/diversfunctionalities/delete', 0, N'DELETE-StockDocument')
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'edb8d08c-ea9a-4d55-be32-c69ce4ccae07', N'Stock-LIST', 4, N'Liste document de stock', N'List of stock document', NULL, NULL, NULL, NULL, N'/stock/list', 0, N'LIST-StockDocument')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'b974286f-3ff0-42a7-a9ac-c53647f592e5', N'92c5486b-f76f-4253-be9a-f679b5aaf461', N'f40650cb-aa58-48a8-a4df-9744e6b81698')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c643d7e7-26d3-452a-913f-76e4d88a881f', N'299729a5-d7ed-4f30-a13c-1960d7374507', N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'f8f6124e-8c76-4d57-b453-c7914bfa2f07', N'edb8d08c-ea9a-4d55-be32-c69ce4ccae07', N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f')

INSERT INTO [ERPSettings].[FunctionalityByRole] ( [IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'edb8d08c-ea9a-4d55-be32-c69ce4ccae07', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'299729a5-d7ed-4f30-a13c-1960d7374507', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'92c5486b-f76f-4253-be9a-f679b5aaf461', 1, 1, 1, NULL)

ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES (N'1cdd12ee-254f-4cae-9299-129c1c9651d8', N'StockDocument-LIST', 4, NULL, NULL, NULL, NULL, NULL, NULL, N'/divers/diversfunctionalities/list', 0, N'LIST-StockDocument')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'70b60bdf-10b6-48fe-8cd9-c42aacfd28bb', N'1cdd12ee-254f-4cae-9299-129c1c9651d8', N'f40650cb-aa58-48a8-a4df-9744e6b81698')

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'1cdd12ee-254f-4cae-9299-129c1c9651d8', 1, 1, 1, NULL)

ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION


BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
SET IDENTITY_INSERT [ERPSettings].[Information] ON
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501071, N'baca0b66-1cfd-469f-8eed-5442857d76b5', N'/stock/transfermovement/show', N'Le mouvement de transfert  {CODE} a été transféré', N'The transfer movement {CODE} has been transferred', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, 1000500011, N'NOTIFICATION_TRANSFERT_TRANSFER_MVT', N'INVENTORY_TRANSFER_MVT_TRANSFERT')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501072, N'baca0b66-1cfd-469f-8eed-5442857d76b5', N'/stock/transfermovement/show', N'Le mouvement de transfert  {CODE} a été reçu', N'The transfer movement {CODE} has been received', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, 1000500011, N'NOTIFICATION_RECEIVE_TRANSFER_MVT', N'INVENTORY_TRANSFER_MVT_RECEIVE')
SET IDENTITY_INSERT [ERPSettings].[Information] OFF
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
COMMIT TRANSACTION

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
UPDATE [ERPSettings].[Information] SET [URL]=N'/stock/stockDocuments/transfertMovement/show' WHERE [IdInfo]=1000500011
UPDATE [ERPSettings].[Information] SET [URL]=N'/stock/stockDocuments/transfertMovement/show' WHERE [IdInfo]=1000500052
UPDATE [ERPSettings].[Information] SET [URL]=N'/stock/stockDocuments/transfertMovement/show' WHERE [IdInfo]=1000501071
UPDATE [ERPSettings].[Information] SET [URL]=N'/stock/stockDocuments/transfertMovement/show' WHERE [IdInfo]=1000501072
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
COMMIT TRANSACTION
--- Imen Chaaben: Fixing Client Codification 
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
UPDATE [ERPSettings].[Codification] SET [Rank]=2 WHERE [Id]=36
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
COMMIT TRANSACTION