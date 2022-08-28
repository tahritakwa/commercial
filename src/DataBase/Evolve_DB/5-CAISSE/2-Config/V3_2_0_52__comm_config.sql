--- Youssef maaloul: add SessionCash codification  28/07/2021
BEGIN TRANSACTION
SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema],[EntityName],[TableName],[TransactionUserId],[IsDeleted],[Fr],[Ar],[En],[De],[Ch],[Es],[IsReference],[IdRelatedEntity],[Deleted_Token]) VALUES (410,N'Payment',N'SessionCash',N'SessionCash' ,NULL,0,N'SessionCash',N'SessionCash',N'SessionCash',N'SessionCash',N'SessionCash',N'SessionCash',NULL,NULL,NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF

SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name],[Rank],[Path],[Format],[InitValue],[IdCodificationParent],[IsCounter],[Step],[LastCounterValue],[CounterLength]) VALUES (411,N'CodeSessionCash',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name],[Rank],[Path],[Format],[InitValue],[IdCodificationParent],[IsCounter],[Step],[LastCounterValue],[CounterLength]) VALUES (412,N'CaractereS',1,NULL,NULL,N'S',411,0,NULL,NULL,NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name],[Rank],[Path],[Format],[InitValue],[IdCodificationParent],[IsCounter],[Step],[LastCounterValue],[CounterLength]) VALUES (413,N'CompteurSessionCash',2,NULL,NULL,NULL,411,1,1,N'00000',5)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF

SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (85,410, NULL, NULL, 411)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF	
COMMIT TRANSACTION

--- Imen chaaben : add cash codification 02/08/2021
BEGIN TRANSACTION
SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (411, N'Payment', N'CashRegister', N'CashRegister', NULL, 0, N'CashRegister', N'CashRegister', N'CashRegister', N'CashRegister', N'CashRegister', N'CashRegister', NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF

SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (414, N'CodeCashRegister', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (415, N'CaractereCC-for central', 1, NULL, NULL, N'CC-', 414, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (416, N'counterCentralCashRegister', 2, NULL, NULL, NULL, 414, 1, 1, N'00000001', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (417, N'CodeCashRegister', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (418, N'CaractereCP-for principal', 1, NULL, NULL, N'CP-', 417, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (419, N'counterPrincipalCashRegister', 2, NULL, NULL, NULL, 417, 1, 1, N'00000001', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (420, N'CodeCashRegister', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (421, N'CaracterR- for receive', 1, NULL, NULL, N'CR-', 420, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (422, N'counterReceivePrincipalCashRegister', 2, NULL, NULL, NULL, 420, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (423, N'CodeCashRegister', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (424, N'CaracterE- for expense', 1, NULL, NULL, N'CE-', 423, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (425, N'counterExpenceCashRegister', 2, NULL, NULL, NULL, 423, 1, 1, N'00000000', 8)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF

SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (86, 411, N'Type', N'1', 414)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (87, 411, N'Type', N'2', 417)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (88, 411, N'Type', N'3', 423)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (89, 411, N'Type', N'4', 420)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
COMMIT TRANSACTION

--- Youssef maaloul: add central cash  03/09/2021
BEGIN TRANSACTION
SET IDENTITY_INSERT [Payment].[CashRegister] ON
INSERT INTO [Payment].[CashRegister]([Id], [Code],[Name],[Type],[Address],[IdResponsible],[IsDeleted],[TransactionUserId],[Deleted_Token],[IdParentCash],[IdCity],[IdCountry],[Status],[IdWarehouse]) VALUES (1, 'CC-00000002','Centrale' ,1 ,null ,2 ,0 ,0 ,null ,null ,null ,235 ,2 ,
(Select [Id] from [Inventory].[Warehouse] where IsCentral = 1))
SET IDENTITY_INSERT [Payment].[CashRegister] OFF
COMMIT TRANSACTION