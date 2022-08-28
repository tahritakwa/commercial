BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
GO
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (300, N'CodeRecruitmentRequest', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (301, N'CaractereRR', 1, NULL, NULL, N'RR-', 300, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (302, N'Annee', 2, N'return (DateTime.Now.Year.ToString());', N'string', NULL, 300, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (303, N'Caractere-', 3, NULL, NULL, N'-', 300, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (304, N'compteurRecruitmentRequest', 4, NULL, NULL, NULL, 300, 1, 1, N'0000', 4)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (305, N'CodeRecruitmentRequest-Approved', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (306, N'CaractereRA', 1, NULL, NULL, N'RA', 305, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (307, N'Annee', 2, N'return (DateTime.Now.Year.ToString().Substring(2,2));', N'string', NULL, 305, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (308, N'Caractere-', 3, NULL, NULL, N'-', 305, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (309, N'compteurRecruitmentRequest', 4, NULL, NULL, NULL, 305, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (310, N'CodeRecruitmentOffer', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (311, N'CaractereRO', 1, NULL, NULL, N'RO-', 310, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (312, N'Annee', 2, N'return (DateTime.Now.Year.ToString());', N'string', NULL, 310, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (313, N'Caractere-', 3, NULL, NULL, N'-', 310, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (314, N'compteurRecruitmentOffer', 4, NULL, NULL, NULL, 310, 1, 1, N'0000', 4)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (315, N'CodeRecruitmentOffer-Published', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (316, N'CaractereOA', 1, NULL, NULL, N'OA', 315, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (317, N'Annee', 2, N'return (DateTime.Now.Year.ToString().Substring(2,2));', N'string', NULL, 315, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (318, N'Caractere-', 3, NULL, NULL, N'-', 315, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (319, N'compteurRecruitmentOffer', 4, NULL, NULL, NULL, 315, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (320, N'CodeRecruitment', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (321, N'CaractereRE', 1, NULL, NULL, N'RE-', 320, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (322, N'Annee', 2, N'return (DateTime.Now.Year.ToString());', N'string', NULL, 320, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (323, N'Caractere-', 3, NULL, NULL, N'-', 320, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (324, N'compteurRecruitment', 4, NULL, NULL, NULL, 320, 1, 1, N'0005', 4)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (61, 397, N'RecruitmentTypeCode', N'RR', 300)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (62, 397, N'RecruitmentTypeCode', N'A-RR', 305)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (63, 397, N'RecruitmentTypeCode', N'RO', 310)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (64, 397, N'RecruitmentTypeCode', N'A-RO', 315)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (65, 397, N'RecruitmentTypeCode', N'RE', 320)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (396, N'RH', N'TimesheetRequest', N'TimesheetRequest', NULL, 0, N'TimesheetRequest', N'TimesheetRequest', N'TimesheetRequest', N'TimesheetRequest', N'TimesheetRequest', N'TimesheetRequest', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (397, N'RH', N'Recruitment', N'Recruitment', NULL, 0, N'Recruitment', N'Recruitment', N'Recruitment', N'Recruitment', N'Recruitment', N'Recruitment', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (400, N'Payroll', N'EmployeeExit', N'EmployeeExit', NULL, 0, N'EmployeeExit', N'EmployeeExit', N'EmployeeExit', N'EmployeeExitt', N'EmployeeExit', N'EmployeeExit', NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
COMMIT TRANSACTION


GO
SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (401, N'Payroll', N'TransferOrder', N'TransferOrder', NULL, 0, N'TransferOrder', N'TransferOrder', N'TransferOrder', N'TransferOrder', N'TransferOrder', N'TransferOrder', NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (325, N'TransferOrdreCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (326, N'CaractereTO', 1, NULL, NULL, N'TO', 325, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (327, N'Caractere-', 3, NULL, NULL, N'-', 325, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (328, N'compteurTransfertOdre', 6, NULL, NULL, NULL, 325, 1, 1, N'0007', 4)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (330, N'Annee', 2, N'return (DateTime.Now.Year.ToString().Substring(2,2));', N'string', NULL, 325, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (331, N'Mois', 4, N'return (DateTime.Now.Month.ToString("d2"));', N'string', NULL, 325, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (332, N'Caractere-', 5, NULL, NULL, N'-', 325, 0, NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (66, 401, NULL, NULL, 325)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF





BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
GO
SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (402, N'Payroll', N'Session', N'Session', NULL, 0, N'Session', N'Session', N'Session', N'Session', N'Session', N'Session', NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (67, 402, NULL, NULL, 333)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (333, N'PayslipSessionCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (334, N'CaracterePS', 1, NULL, NULL, N'PS', 333, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (335, N'Year', 2, N'return (DateTime.Now.Year.ToString().Substring(2,2));', N'string', NULL, 333, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (336, N'Caractere-', 3, NULL, NULL, N'-', 333, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (337, N'Month', 4, N'return (DateTime.Now.Month.ToString("d2"));', N'string', NULL, 333, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (338, N'Caractere-', 5, NULL, NULL, N'-', 333, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (339, N'CounterPayslipSession', 6, NULL, NULL, NULL, 333, 1, 1, N'0001', 4)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
COMMIT TRANSACTION


BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
GO
SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (403, N'Payroll', N'CnssDeclaration', N'CnssDeclaration', NULL, 0, N'CnssDeclaration', N'CnssDeclaration', N'CnssDeclaration', N'CnssDeclaration', N'CnssDeclaration', N'CnssDeclaration', NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (68, 403, NULL, NULL, 340)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (340, N'CnssDeclarationCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (341, N'CaractereCD', 1, NULL, NULL, N'CD', 340, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (342, N'Year', 2, N'return (DateTime.Now.Year.ToString().Substring(2,2));', N'string', NULL, 340, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (343, N'Caractere-', 3, NULL, NULL, N'-', 340, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (344, N'Month', 4, N'return (DateTime.Now.Month.ToString("d2"));', N'string', NULL, 340, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (345, N'Caractere-', 5, NULL, NULL, N'-', 340, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (346, N'CounterCnssDeclaration', 6, NULL, NULL, NULL, 340, 1, 1, N'0003', 4)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
COMMIT TRANSACTION

--- Donia add billing session codification 30/07/2020
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
GO
SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (406, N'Sales', N'BillingSession', N'BillingSession', NULL, 0, N'BillingSession', N'BillingSession', N'BillingSession', N'BillingSession', N'BillingSession', N'BillingSession', NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (69, 406, NULL, NULL, 347)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (347, N'BillingSessionCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (348, N'CaractereBS', 1, NULL, NULL, N'BS', 347, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (349, N'Year', 2, N'return (DateTime.Now.Year.ToString().Substring(2,2));', N'string', NULL, 347, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (350, N'Caractere-', 3, NULL, NULL, N'-', 347, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (351, N'Month', 4, N'return (DateTime.Now.Month.ToString("d2"));', N'string', NULL, 347, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (352, N'Caractere-', 5, NULL, NULL, N'-', 347, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (353, N'CounterBillingSession', 6, NULL, NULL, NULL, 347, 1, 1, N'0003', 4)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
COMMIT TRANSACTION




BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
GO
SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (407, N'Payroll', N'SourceDeductionSession', N'SourceDeductionSession', NULL, 0, N'SourceDeductionSession', N'SourceDeductionSession', N'SourceDeductionSession', N'SourceDeductionSession', N'SourceDeductionSession', N'SourceDeductionSession', NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (72, 407, NULL, NULL, 359)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (359, N'SourceDeductionSessionCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (360, N'CaractereSD', 1, NULL, NULL, N'SD', 359, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (361, N'Annee', 2, N'return (DateTime.Now.Year.ToString().Substring(2,2));', N'string', NULL, 359, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (362, N'Caractere-', 3, NULL, NULL, N'-', 359, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (363, N'compteurSourceDeduction', 4, NULL, NULL, NULL, 359, 1, 1, N'0000', 4)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
COMMIT TRANSACTION

UPDATE [ERPSettings].[Entity] SET [EntityName]=N'TimeSheet', [TableName]=N'TimeSheet', [Fr]=N'TimeSheet', [Ar]=N'TimeSheet', [En]=N'TimeSheet', [De]=N'TimeSheet', [Ch]=N'TimeSheet', [Es]=N'TimeSheet' WHERE [Id]=396



INSERT INTO [ERPSettings].[ReportTemplate] ([TemplateNameFr],[TemplateNameEn],[ReportCode],[ReportName]) VALUES ('genericDocumentReport_fr','genericDocumentReport_en','O-SA','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([TemplateNameFr],[TemplateNameEn],[ReportCode],[ReportName]) VALUES ('genericDocumentReport_fr','genericDocumentReport_en','O-PU','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([TemplateNameFr],[TemplateNameEn],[ReportCode],[ReportName]) VALUES ('genericDocumentReport_fr','genericDocumentReport_en','D-SA','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([TemplateNameFr],[TemplateNameEn],[ReportCode],[ReportName]) VALUES ('purchasedeliveryreport_fr','purchasedeliveryreport_en','D-PU','purchasedeliveryreport')
INSERT INTO [ERPSettings].[ReportTemplate] ([TemplateNameFr],[TemplateNameEn],[ReportCode],[ReportName]) VALUES ('genericDocumentReport_fr','genericDocumentReport_en','I-SA','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([TemplateNameFr],[TemplateNameEn],[ReportCode],[ReportName]) VALUES ('genericDocumentReport_fr','genericDocumentReport_en','I-PU','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([TemplateNameFr],[TemplateNameEn],[ReportCode],[ReportName]) VALUES ('genericDocumentReport_fr','genericDocumentReport_en','Q-SA','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([TemplateNameFr],[TemplateNameEn],[ReportCode],[ReportName]) VALUES ('genericDocumentReport_fr','genericDocumentReport_en','Q-PU','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([TemplateNameFr],[TemplateNameEn],[ReportCode],[ReportName]) VALUES ('genericDocumentReport_fr','genericDocumentReport_en','A-SA','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([TemplateNameFr],[TemplateNameEn],[ReportCode],[ReportName]) VALUES ('genericDocumentReport_fr','genericDocumentReport_en','A-PU','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([TemplateNameFr],[TemplateNameEn],[ReportCode],[ReportName]) VALUES ('genericDocumentReport_fr','genericDocumentReport_en','RQ-PU','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([TemplateNameFr],[TemplateNameEn],[ReportCode],[ReportName]) VALUES ('genericDocumentReport_fr','genericDocumentReport_en','B-PU','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([TemplateNameFr],[TemplateNameEn],[ReportCode],[ReportName]) VALUES ('genericDocumentReport_fr','genericDocumentReport_en','FO-PU','genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([TemplateNameFr],[TemplateNameEn],[ReportCode],[ReportName]) VALUES ('report_be_bs_fr','report_be_bs_en','BE-PU','report_be_bs')
INSERT INTO [ERPSettings].[ReportTemplate] ([TemplateNameFr],[TemplateNameEn],[ReportCode],[ReportName]) VALUES ('report_be_bs_fr','report_be_bs_en','BS-SA','report_be_bs')
INSERT INTO [ERPSettings].[ReportTemplate] ([TemplateNameFr],[TemplateNameEn],[ReportCode],[ReportName]) VALUES ('genericDocumentReport_fr','genericDocumentReport_en','IA-SA','genericDocumentReport')


UPDATE [Payment].[PaymentStatus] SET [Code]=N'Settled', [Label]=N'Réglé' WHERE [Id]=1
UPDATE [Payment].[PaymentStatus] SET [Code]=N'RemittanceSlip', [Label]=N'Bordereau' WHERE [Id]=2
UPDATE [Payment].[PaymentStatus] SET [Code]=N'Issued', [Label]=N'Emis' WHERE [Id]=3



--SET IDENTITY_INSERT [Payroll].[DocumentRequestType] ON
--INSERT INTO [Payroll].[DocumentRequestType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'bulletin de paie ', N'bulletin de paie ', 0, 0, NULL)
--INSERT INTO [Payroll].[DocumentRequestType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Attestation de travail', N'Attestation de travail', 0, 0, NULL)
--SET IDENTITY_INSERT [Payroll].[DocumentRequestType] OFF





--SET IDENTITY_INSERT [Payroll].[Job] ON
--INSERT INTO [Payroll].[Job] ([Id], [Designation], [IsDeleted], [TransactionUserId], [Deleted_Token], [FunctionSheet], [IdUpperJob]) VALUES (1, N'Développeur .NET Core', 0, 0, NULL, NULL, NULL)
--INSERT INTO [Payroll].[Job] ([Id], [Designation], [IsDeleted], [TransactionUserId], [Deleted_Token], [FunctionSheet], [IdUpperJob]) VALUES (3, N'Testeur', 0, 0, NULL, NULL, NULL)
--INSERT INTO [Payroll].[Job] ([Id], [Designation], [IsDeleted], [TransactionUserId], [Deleted_Token], [FunctionSheet], [IdUpperJob]) VALUES (1003, N'Consultant', 0, 0, NULL, NULL, NULL)
--INSERT INTO [Payroll].[Job] ([Id], [Designation], [IsDeleted], [TransactionUserId], [Deleted_Token], [FunctionSheet], [IdUpperJob]) VALUES (1004, N'Ingenieur', 0, 0, NULL, NULL, NULL)
--SET IDENTITY_INSERT [Payroll].[Job] OFF


--BEGIN TRANSACTION
--ALTER TABLE [Payroll].[Skills] DROP CONSTRAINT [FK_Family_Skills]
--SET IDENTITY_INSERT [Payroll].[Skills] ON
--INSERT INTO [Payroll].[Skills] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Code], [Description], [Id_Family]) VALUES (1, N'Angular', 0, 0, NULL, N'SK00000014', N'Angular', NULL)
--INSERT INTO [Payroll].[Skills] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Code], [Description], [Id_Family]) VALUES (2, N'Java', 0, 0, NULL, N'SK00000015', N'Java', NULL)
--INSERT INTO [Payroll].[Skills] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Code], [Description], [Id_Family]) VALUES (3, N'PHP', 0, 0, NULL, N'SK00000016', N'PHP', NULL)
--INSERT INTO [Payroll].[Skills] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Code], [Description], [Id_Family]) VALUES (4, N'Python', 0, 0, NULL, N'SK00000017', N'Python', NULL)
--INSERT INTO [Payroll].[Skills] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Code], [Description], [Id_Family]) VALUES (5, N'.Net core', 0, 0, NULL, N'SK00000018', N'.Net core', NULL)
--INSERT INTO [Payroll].[Skills] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Code], [Description], [Id_Family]) VALUES (6, N'Expert', 0, 0, NULL, N'SK00000019', N'Expert', NULL)
--SET IDENTITY_INSERT [Payroll].[Skills] OFF
--ALTER TABLE [Payroll].[Skills]
--    ADD CONSTRAINT [FK_Family_Skills] FOREIGN KEY ([Id_Family]) REFERENCES [Payroll].[SkillsFamily] ([Id])
--COMMIT TRANSACTION






--SET IDENTITY_INSERT [Payroll].[ParentType] ON
--INSERT INTO [Payroll].[ParentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Fils', 0, NULL, NULL)
--INSERT INTO [Payroll].[ParentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Fille', 0, NULL, NULL)
--INSERT INTO [Payroll].[ParentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Père', 0, NULL, NULL)
--INSERT INTO [Payroll].[ParentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'Mère', 0, NULL, NULL)
--INSERT INTO [Payroll].[ParentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'Grand-père', 0, NULL, NULL)
--INSERT INTO [Payroll].[ParentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (6, N'Grand-mère', 0, NULL, NULL)
--INSERT INTO [Payroll].[ParentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (7, N'Cousin', 0, NULL, NULL)
--INSERT INTO [Payroll].[ParentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (8, N'Neuveux', 0, NULL, NULL)
--SET IDENTITY_INSERT [Payroll].[ParentType] OFF


--SET IDENTITY_INSERT [Payroll].[QualificationType] ON
--INSERT INTO [Payroll].[QualificationType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Licence', N'Licence', 0, 0, NULL)
--INSERT INTO [Payroll].[QualificationType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Maîtrise', N'Maîtrise', 0, 0, NULL)
--INSERT INTO [Payroll].[QualificationType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Master', N'Master', 0, 0, NULL)
--INSERT INTO [Payroll].[QualificationType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'Ingénieur', N'Ingénieur', 0, 0, NULL)
--INSERT INTO [Payroll].[QualificationType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'PhD', N'PhD', 0, 0, NULL)
--SET IDENTITY_INSERT [Payroll].[QualificationType] OFF


--SET IDENTITY_INSERT [Payroll].[RuleUniqueReference] ON
--INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (74, N'BASE', 1, 0, 0, NULL)
--INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (75, N'BRUT', 1, 0, 0, NULL)
--INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (76, N'NET', 1, 0, 0, NULL)
--INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (77, N'NETAPAYER', 1, 0, 0, NULL)
--INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (80, N'BRUTIMPOSABLEANNUEL', 2, 0, 0, NULL)
--INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (81, N'CNSS', 1, 0, 0, NULL)
--INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (82, N'IRPP', 1, 0, 0, NULL)
--INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (83, N'CSS', 1, 0, 0, NULL)
--INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (86, N'NEnfant', 2, 0, 0, NULL)
--INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (87, N'FRAISREELS', 2, 0, 0, NULL)
--INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (88, N'NETANNUEL', 2, 0, 0, NULL)
--INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (89, N'NChefFamille', 2, 0, 0, NULL)
--INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (91, N'CreditHabitation', 2, 0, 0, NULL)
--INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (93, N'NBEnfantNonBoursier', 2, 0, 0, NULL)
--INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (94, N'NBEnfantHandicape', 2, 0, 0, NULL)
--INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (96, N'BASEIMPOSABLEANNUEL', 2, 0, 0, NULL)
--INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (97, N'PARENTACHARGE', 2, 0, 0, NULL)
--INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (98, N'BASECALCULPARENTACHARGE', 2, 0, 0, NULL)
--INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (99, N'SMIG', 2, 0, 0, NULL)
--SET IDENTITY_INSERT [Payroll].[RuleUniqueReference] OFF


GO



--BEGIN TRANSACTION
--ALTER TABLE [RH].[Formation] DROP CONSTRAINT [FK_Formation_FormationType]
--SET IDENTITY_INSERT [RH].[Formation] ON
--INSERT INTO [RH].[Formation] ([Id], [Label], [Description], [TransactionUserId], [IsDeleted], [Deleted_Token], [IdFormationType]) VALUES (1, N'Java', N'Maitriser java', NULL, 0, NULL, 1)
--INSERT INTO [RH].[Formation] ([Id], [Label], [Description], [TransactionUserId], [IsDeleted], [Deleted_Token], [IdFormationType]) VALUES (2, N'C#', N'Maitriser C#', NULL, 0, NULL, 1)
--INSERT INTO [RH].[Formation] ([Id], [Label], [Description], [TransactionUserId], [IsDeleted], [Deleted_Token], [IdFormationType]) VALUES (3, N'PHP', N'Maitriser PHP', NULL, 0, NULL, 1)
--INSERT INTO [RH].[Formation] ([Id], [Label], [Description], [TransactionUserId], [IsDeleted], [Deleted_Token], [IdFormationType]) VALUES (4, N'BI', N'Maitriser BI', NULL, 0, NULL, 1)
--SET IDENTITY_INSERT [RH].[Formation] OFF
--SET IDENTITY_INSERT [RH].[EvaluationCriteriaTheme] ON
--INSERT INTO [RH].[EvaluationCriteriaTheme] ([Id], [Label], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (2, N'COMMUNICATION', NULL, 0, NULL)
--INSERT INTO [RH].[EvaluationCriteriaTheme] ([Id], [Label], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (3, N'FIRST_IMPRESSION', NULL, 0, NULL)
--INSERT INTO [RH].[EvaluationCriteriaTheme] ([Id], [Label], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (4, N'COMPANY_APPROACH', NULL, 0, NULL)
--INSERT INTO [RH].[EvaluationCriteriaTheme] ([Id], [Label], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (5, N'BEHAVIOR', NULL, 0, NULL)
--SET IDENTITY_INSERT [RH].[EvaluationCriteriaTheme] OFF
--SET IDENTITY_INSERT [RH].[FormationType] ON
--INSERT INTO [RH].[FormationType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Technique', N'Technique', 0, 0, NULL)
--SET IDENTITY_INSERT [RH].[FormationType] OFF
--ALTER TABLE [RH].[Formation]
--    ADD CONSTRAINT [FK_Formation_FormationType] FOREIGN KEY ([IdFormationType]) REFERENCES [RH].[FormationType] ([Id])
--COMMIT TRANSACTION





--BEGIN TRANSACTION
--ALTER TABLE [RH].[Project] DROP CONSTRAINT [FK_Project_Tiers]
--ALTER TABLE [RH].[Project] DROP CONSTRAINT [FK_Project_Contact]
--ALTER TABLE [RH].[Project] DROP CONSTRAINT [FK_Project_Currency]
--ALTER TABLE [RH].[Project] DROP CONSTRAINT [FK_Project_Taxe]
--ALTER TABLE [RH].[Project] DROP CONSTRAINT [FK_Project_SettlementMode]
--SET IDENTITY_INSERT [RH].[Project] ON
--INSERT INTO [RH].[Project] ([Id], [Name], [IsDeleted], [TransactionUserId], [Deleted_Token], [StartDate], [ExpectedEndDate], [ProjectType], [IdTaxe], [AverageDailyRate], [IdTiers], [IdSettlementMode], [Default], [IdContact], [IdCurrency]) VALUES (1, N'Auto formation', 0, 0, NULL, '20100101', '21000101', 1, NULL, 1, NULL, NULL, 1, NULL, NULL)
--INSERT INTO [RH].[Project] ([Id], [Name], [IsDeleted], [TransactionUserId], [Deleted_Token], [StartDate], [ExpectedEndDate], [ProjectType], [IdTaxe], [AverageDailyRate], [IdTiers], [IdSettlementMode], [Default], [IdContact], [IdCurrency]) VALUES (2, N'Inter contrat', 0, 0, NULL, '20100101', '21000101', 1, NULL, 1, NULL, NULL, 1, NULL, NULL)
--INSERT INTO [RH].[Project] ([Id], [Name], [IsDeleted], [TransactionUserId], [Deleted_Token], [StartDate], [ExpectedEndDate], [ProjectType], [IdTaxe], [AverageDailyRate], [IdTiers], [IdSettlementMode], [Default], [IdContact], [IdCurrency]) VALUES (3, N'Pause', 0, 0, NULL, '20100101', '21000101', 1, NULL, 1, NULL, NULL, 1, NULL, NULL)
--INSERT INTO [RH].[Project] ([Id], [Name], [IsDeleted], [TransactionUserId], [Deleted_Token], [StartDate], [ExpectedEndDate], [ProjectType], [IdTaxe], [AverageDailyRate], [IdTiers], [IdSettlementMode], [Default], [IdContact], [IdCurrency]) VALUES (4, N'Projet en interne', 0, 0, NULL, '20100101', '21000101', 1, NULL, 1, NULL, NULL, 1, NULL, NULL)
--SET IDENTITY_INSERT [RH].[Project] OFF
--ALTER TABLE [RH].[Project]
--    ADD CONSTRAINT [FK_Project_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
--ALTER TABLE [RH].[Project]
--    ADD CONSTRAINT [FK_Project_Contact] FOREIGN KEY ([IdContact]) REFERENCES [Shared].[Contact] ([Id])
--ALTER TABLE [RH].[Project]
--    ADD CONSTRAINT [FK_Project_Currency] FOREIGN KEY ([IdCurrency]) REFERENCES [Administration].[Currency] ([Id])
--ALTER TABLE [RH].[Project]
--    ADD CONSTRAINT [FK_Project_Taxe] FOREIGN KEY ([IdTaxe]) REFERENCES [Shared].[Taxe] ([Id])
--ALTER TABLE [RH].[Project]
--    ADD CONSTRAINT [FK_Project_SettlementMode] FOREIGN KEY ([IdSettlementMode]) REFERENCES [Sales].[SettlementMode] ([Id])
--COMMIT TRANSACTION



--BEGIN TRANSACTION
--SET IDENTITY_INSERT [Sales].[DocumentStatus] ON
--INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (14, N'Ecommerce', N'Ecommerce', 0, 0, NULL)
--SET IDENTITY_INSERT [Sales].[DocumentStatus] OFF
--COMMIT TRANSACTION





BEGIN TRANSACTION
UPDATE [Inventory].[Nature] SET [Code]=N'Ristourne', [Label]=N'Ristourne' WHERE [Id]=4
COMMIT TRANSACTION



BEGIN TRANSACTION
ALTER TABLE [Sales].[DocumentType] DROP CONSTRAINT [FK_DocumentType_DocumentType]
UPDATE [Sales].[DocumentType] SET [Label]=N'Facture achat', [Description]=N'Facture achat', [LabelEn]=N'Purchase invoice' WHERE [CodeType]=N'FO-PU'
UPDATE [Sales].[DocumentType] SET [Label]=N'Facture', [CreateAssociatedDocument]=0, [LabelEn]=N'Invoice' WHERE [CodeType]=N'I-PU'
UPDATE [Sales].[DocumentType] SET [Label]=N'Facture', [LabelEn]=N'Invoice' WHERE [CodeType]=N'I-SA'
UPDATE [Sales].[DocumentType] SET [Label]=N'Bon de commande', [Description]=N'Bon de commande  achat', [LabelEn]=N'Order' WHERE [CodeType]=N'O-PU'
UPDATE [Sales].[DocumentType] SET [Label]=N'Bon de commande', [Description]=N'Bon de commande vente', [LabelEn]=N'Order' WHERE [CodeType]=N'O-SA'
ALTER TABLE [Sales].[DocumentType]
    ADD CONSTRAINT [FK_DocumentType_DocumentType] FOREIGN KEY ([DefaultCodeDocumentTypeAssociated]) REFERENCES [Sales].[DocumentType] ([CodeType])
COMMIT TRANSACTION


SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (375, N'CodeTeam', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (377, N'CaractereT-for team', 1, NULL, NULL, N'T-', 375, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (378, N'counterTeams', 2, NULL, NULL, NULL, 375, 1, 1, N'10003', 5)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF

SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (79, 368, N'CodeTeam', N'CT', 375)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF

--houssem: Add Codification finacement commitement
update  ERPSettings.EntityCodification set Property=NULL where [IdEntity] =313


-- Narcisse: Update NETTANNUEL RULE 28/08/2020 


ALTER TABLE [Payroll].[VariableValidityPeriod] DROP CONSTRAINT [FK_VariableValidityPeriod_Variable]
UPDATE [Payroll].[VariableValidityPeriod] SET [Formule]=N'Si (BRUTIMPOSABLEANNUEL > FRAISREELS)
	Alors BRUTIMPOSABLEANNUEL - FRAISREELS
Sinon 0
Finsi' WHERE [Id]=23
ALTER TABLE [Payroll].[VariableValidityPeriod]
    WITH NOCHECK ADD CONSTRAINT [FK_VariableValidityPeriod_Variable] FOREIGN KEY ([IdVariable]) REFERENCES [Payroll].[Variable] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE

--Amine : declaration CNSS and Historique de paie
 UPDATE [ERPSettings].[RoleConfig] set Code = 'Declaration_Cnss' where Id = 101013
 UPDATE [ERPSettings].[RoleConfig] set Code = 'PayrollHistory_config' where Id = 101104

  -- Narcisse: Add validate and refuse permission to loan config and pay config 01/09/2020

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103108, N'502bc6d4-8e23-4a32-930c-f5b3b49bee09', 1)

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 100003, N'502bc6d4-8e23-4a32-930c-f5b3b49bee09', 1)


INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103108, N'3f937828-c86b-454b-a6f3-9db6bca39bb6', 1)

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 100003, N'3f937828-c86b-454b-a6f3-9db6bca39bb6', 1)


---Rabeb: modify Information Fr and En message: 03/09/2020

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a ajouté un commentaire pour la demande de note de frais {CODE}' WHERE [IdInfo]=1000501078
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a ajouté demande de note de frais {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501082
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a modifié la demande de note de frais {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501085
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a validé la demande de note de frais {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501088
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a refusé la demande de note de frais {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501091
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a supprimé une demande de note de frais {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501095
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
COMMIT TRANSACTION

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
UPDATE [ERPSettings].[Information] SET [EN]=N'{DOC_CREATOR} added a comment for the expense report request {CODE}' WHERE [IdInfo]=1000501078
UPDATE [ERPSettings].[Information] SET [EN]=N'{DOC_CREATOR} added a new expense report {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501082
UPDATE [ERPSettings].[Information] SET [EN]=N'{DOC_CREATOR} updated the expense report {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501085
UPDATE [ERPSettings].[Information] SET [EN]=N'{DOC_CREATOR} validated the expense report {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501088
UPDATE [ERPSettings].[Information] SET [EN]=N'{DOC_CREATOR} refused the expense report {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501091
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
COMMIT TRANSACTION
 

 --03/09/2020 : Ahmed 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 100018, N'2619EDD7-D221-43D7-832B-C1C761DF8AC8', 1)

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


-- 24/09/2020 : Ahmed

INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig],[IdFunctionality],[IsActive]) values 
(100018,N'ED89FCB1-6CBA-4A58-AC13-1DA7B1E897C5',1)

----Imen add canceled status 
SET IDENTITY_INSERT [Payment].[PaymentStatus] ON
INSERT INTO [Payment].[PaymentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (7, N'Canceled', N'decaissé', 0, 0, NULL)
SET IDENTITY_INSERT [Payment].[PaymentStatus] OFF

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


---Marwa change CreateAssociatedDocument for purchase invoice---
update Sales.DocumentType set CreateAssociatedDocument=1 where CodeType='I-PU'

--- 30/09/2020 Ahmed 
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101041, N'FE8641A3-25AC-467C-9E45-7BB77B77E51F', 1)

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
UPDATE [ERPSettings].[Codification] SET [InitValue]=N'AF-R' WHERE [Id]=291
UPDATE [ERPSettings].[Codification] SET [InitValue]=N'A-AF-R' WHERE [Id]=296
UPDATE [ERPSettings].[Codification] SET [InitValue]=N'/' WHERE [Id]=298
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
COMMIT TRANSACTION


BEGIN TRANSACTION
update ERPSettings.Codification set LastCounterValue = 00000000 where id = 26
COMMIT TRANSACTION
BEGIN TRANSACTION
update [Inventory].[Item] set [IdUnitStock] =2 ,[IdUnitSales]=2 where IdNature=2
update Sales.DocumentLine set IdMeasureUnit=2 where Id in (select Id from Sales.DocumentLine where IdItem in (select Id from Inventory.Item where
                                Id in (select IdItem from Sales.DocumentLine where IsDeleted = 0 and IdMeasureUnit IS NULL)
                                and IdNature in (select Id from Inventory.Nature where IsStockManaged =1)))
COMMIT TRANSACTION


 