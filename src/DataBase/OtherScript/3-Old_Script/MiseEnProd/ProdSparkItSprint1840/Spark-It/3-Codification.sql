SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (90, N'CodeActive', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (91, N'Prefixe-Actif', 1, NULL, NULL, N'AC-', 90, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (92, N'Counter-Active', 2, NULL, NULL, NULL, 90, 1, 1, N'0000', 4)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF

SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (20, 359, NULL, NULL, 90)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF


SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (93, N'CodePurchaseRequest', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (94, N'CaractereF', 1, NULL, NULL, N'RQ-', 93, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (95, N'Annee', 2, N'return (DateTime.Now.Year.ToString());', N'string', NULL, 93, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (96, N'Caractere/', 3, NULL, NULL, N'-', 93, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (97, N'compteurPurchaseRequest', 4, NULL, NULL, NULL, 93, 1, 1, N'00000000', 8)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF

SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (21, 87, N'DocumentTypeCode', N'RQ-PU', 93)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF

--- Marwa : Change Label and description of documentType data ----
BEGIN TRANSACTION
UPDATE [Sales].[DocumentType] SET [Label]=N'Facture d''achat' WHERE [CodeType]=N'I-PU'
UPDATE [Sales].[DocumentType] SET [Label]=N'Facture de vente' WHERE [CodeType]=N'I-SA'
UPDATE [Sales].[DocumentType] SET [Label]=N'Bon de commande vente' WHERE [CodeType]=N'O-SA'
UPDATE [Sales].[DocumentType] SET [Label]=N'Demande de prix', [Description]=N'Demande de prix' WHERE [CodeType]=N'Q-PU'
COMMIT TRANSACTION 
---Marwa : Add documentStatus and Add Document Type (Demande d'achat) ---- 
BEGIN TRANSACTION
SET IDENTITY_INSERT [Sales].[DocumentStatus] ON
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'Refusé', N'Refusé', 0, 0, NULL)
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'ACommander', N'ACommander', 0, 0, NULL)
SET IDENTITY_INSERT [Sales].[DocumentStatus] OFF
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [TypeDocument_int_1], [TypeDocument_int_2], [TypeDocument_int_3], [TypeDocument_int_4], [TypeDocument_int_5], [TypeDocument_int_6], [TypeDocument_int_7], [TypeDocument_int_8], [TypeDocument_int_9], [TypeDocument_int_10], [TypeDocument_bit_1], [TypeDocument_bit_2], [TypeDocument_bit_3], [TypeDocument_bit_4], [TypeDocument_bit_5], [TypeDocument_bit_6], [TypeDocument_bit_7], [TypeDocument_bit_8], [TypeDocument_bit_9], [TypeDocument_bit_10], [TypeDocument_float_1], [TypeDocument_float_2], [TypeDocument_float_3], [TypeDocument_float_4], [TypeDocument_float_5], [TypeDocument_float_6], [TypeDocument_float_7], [TypeDocument_float_8], [TypeDocument_float_9], [TypeDocument_float_10], [TypeDocument_varchar_1], [TypeDocument_varchar_2], [TypeDocument_varchar_3], [TypeDocument_varchar_4], [TypeDocument_varchar_5], [TypeDocument_varchar_6], [TypeDocument_varchar_7], [TypeDocument_varchar_8], [TypeDocument_varchar_9], [TypeDocument_varchar_10], [TypeDocument_date_1], [TypeDocument_date_2], [TypeDocument_date_3], [TypeDocument_date_4], [TypeDocument_date_5], [TypeDocument_date_6], [TypeDocument_date_7], [TypeDocument_date_8], [TypeDocument_date_9], [TypeDocument_date_10], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected], [FinancialCommitmentDirection], [IsActiveGeneration]) VALUES (N'RQ-PU', N'RQ-PU', N'Demande d''achat', N'Demande d''achat', N'O-PU', 0, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0)
COMMIT TRANSACTION
--- Marwa : Change Label and description of documentType data ----
BEGIN TRANSACTION
UPDATE [Sales].[DocumentType] SET [Label]=N'Facture d''achat' WHERE [CodeType]=N'I-PU'
UPDATE [Sales].[DocumentType] SET [Label]=N'Facture de vente' WHERE [CodeType]=N'I-SA'
UPDATE [Sales].[DocumentType] SET [Label]=N'Bon de commande vente' WHERE [CodeType]=N'O-SA'
UPDATE [Sales].[DocumentType] SET [Label]=N'Demande de prix', [Description]=N'Demande de prix' WHERE [CodeType]=N'Q-PU'
COMMIT TRANSACTION 

---- Nihel: Activate active generation 
BEGIN TRANSACTION
UPDATE [Sales].[DocumentType] SET [IsActiveGeneration]=1 WHERE [CodeType]=N'I-PU'
COMMIT TRANSACTION

BEGIN TRANSACTION
INSERT INTO [Sales].[DocumentTypeRelation] ([CodeDocumentType], [CodeDocumentTypeAssociated]) VALUES (N'A-SA', N'I-SA')
COMMIT TRANSACTION







