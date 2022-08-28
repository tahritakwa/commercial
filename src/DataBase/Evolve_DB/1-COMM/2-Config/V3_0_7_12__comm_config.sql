INSERT INTO [Inventory].[StockDocumentType] ([CodeType], [Type], [StockOperation], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (N'TShSt', N'TShSt', N'T', N'TransferShelfStorage', 0, 0, NULL)

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_RoleConfig]
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_Functionality]
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (104150, N'fd101f2f-5b91-4de3-9a07-337b4a3c5151', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (104150, N'fd101f2f-5b91-4de3-9a07-337b4a3c5152', 1)

ALTER TABLE [ERPSettings].[FunctionalityConfig]
    WITH NOCHECK ADD CONSTRAINT [FK_FonctionalityConfig_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
ALTER TABLE [ERPSettings].[FunctionalityConfig]
    WITH NOCHECK ADD CONSTRAINT [FK_FonctionalityConfig_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
COMMIT TRANSACTION


-- add storage transfer codifaction
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (83, 137, N'TypeStockDocument', N'TShSt', 400)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (400, N'CodeStockDocument-TRC', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (401, N'CaractereTD', 1, NULL, NULL, N'TRC', 400, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (402, N'Annee', 2, NULL, N'string', N'21', 400, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (403, N'Caractere/', 3, NULL, NULL, N'/', 400, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (404, N'compteurTM', 4, NULL, NULL, NULL, 400, 1, 1, N'00000000', 8)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
COMMIT TRANSACTION