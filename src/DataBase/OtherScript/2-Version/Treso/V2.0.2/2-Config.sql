BEGIN TRANSACTION
SET IDENTITY_INSERT [Payment].[WithholdingTax] ON
INSERT INTO [Payment].[WithholdingTax] ([Id], [Code], [Designation], [Percentage], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Honoraire', N'Honoraire (5%)', 5, 0, NULL, NULL)
INSERT INTO [Payment].[WithholdingTax] ([Id], [Code], [Designation], [Percentage], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Honoraires commissions loyers et redevances', N'Honoraires commissions loyers et redevances (15%)', 15, 0, NULL, NULL)
INSERT INTO [Payment].[WithholdingTax] ([Id], [Code], [Designation], [Percentage], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Retenue sur montant > 1000 DT', N'Retenue sur montant > 1000 DT (15%)', 15, 0, NULL, NULL)
INSERT INTO [Payment].[WithholdingTax] ([Id], [Code], [Designation], [Percentage], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'Retenues des capitaux mobiliers ', N'Retenues des capitaux mobiliers (20%)', 20, 0, NULL, NULL)
INSERT INTO [Payment].[WithholdingTax] ([Id], [Code], [Designation], [Percentage], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'Montant exononéré des retenues ', N'Montant exononéré des retenues (0%)', 0, 0, NULL, NULL)
SET IDENTITY_INSERT [Payment].[WithholdingTax] OFF
COMMIT TRANSACTION