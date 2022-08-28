/*
This script was created by Visual Studio on 26/04/2018 at 15:49.
Run this script on ..ErpSettingVide (dev) to make it the same as ..ErpSetting (dev).
This script performs its actions in the following order:
1. Disable foreign-key constraints.
2. Perform DELETE commands. 
3. Perform UPDATE commands.
4. Perform INSERT commands.
5. Re-enable foreign-key constraints.
Please back up your target database before running this script.
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET XACT_ABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
/*Pointer used for text / image updates. This might not be needed, but is declared here just in case*/
DECLARE @pv binary(16)
BEGIN TRANSACTION
ALTER TABLE [Inventory].[Warehouse] DROP CONSTRAINT [FK_Warehouse_Employee]
ALTER TABLE [Inventory].[Warehouse] DROP CONSTRAINT [FK_Warehouse_Warehouse]
ALTER TABLE [Sales].[DetailsSettlementMode] DROP CONSTRAINT [FK_DetailsSettlementMode_SettlementType]
ALTER TABLE [Sales].[DetailsSettlementMode] DROP CONSTRAINT [FK_DetailsSettlementMode_PaymentMethod]
ALTER TABLE [Sales].[DetailsSettlementMode] DROP CONSTRAINT [FK_DetailsSettlementMode_SettlementMode]
ALTER TABLE [Payment].[PaymentMethod] DROP CONSTRAINT [FK_PayementMethod_PayementType]
SET IDENTITY_INSERT [Payment].[PaymentMethod] ON
INSERT INTO [Payment].[PaymentMethod] ([Id], [Code], [MethodName], [Description], [AuthorizedForExpenses], [AuthorizedForRecipes], [Immediate], [IsDeleted], [TransactionUserId], [IdPaymentType], [PaymentMethod_int_1], [PaymentMethod_int_2], [PaymentMethod_int_3], [PaymentMethod_int_4], [PaymentMethod_int_5], [PaymentMethod_int_6], [PaymentMethod_int_7], [PaymentMethod_int_8], [PaymentMethod_int_9], [PaymentMethod_int_10], [PaymentMethod_bit_1], [PaymentMethod_bit_2], [PaymentMethod_bit_3], [PaymentMethod_bit_4], [PaymentMethod_bit_5], [PaymentMethod_bit_6], [PaymentMethod_bit_7], [PaymentMethod_bit_8], [PaymentMethod_bit_9], [PaymentMethod_bit_10], [PaymentMethod_float_1], [PaymentMethod_float_2], [PaymentMethod_float_3], [PaymentMethod_float_4], [PaymentMethod_float_5], [PaymentMethod_float_6], [PaymentMethod_float_7], [PaymentMethod_float_8], [PaymentMethod_float_9], [PaymentMethod_float_10], [PaymentMethod_varchar_1], [PaymentMethod_varchar_2], [PaymentMethod_varchar_3], [PaymentMethod_varchar_4], [PaymentMethod_varchar_5], [PaymentMethod_varchar_6], [PaymentMethod_varchar_7], [PaymentMethod_varchar_8], [PaymentMethod_varchar_9], [PaymentMethod_varchar_10], [PaymentMethod_date_1], [PaymentMethod_date_2], [PaymentMethod_date_3], [PaymentMethod_date_4], [PaymentMethod_date_5], [PaymentMethod_date_6], [PaymentMethod_date_7], [PaymentMethod_date_8], [PaymentMethod_date_9], [PaymentMethod_date_10], [Deleted_Token], [Fr], [En]) VALUES (1, N'VIR', N'Virement', NULL, 1, 1, 1, 0, 0, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [Payment].[PaymentMethod] ([Id], [Code], [MethodName], [Description], [AuthorizedForExpenses], [AuthorizedForRecipes], [Immediate], [IsDeleted], [TransactionUserId], [IdPaymentType], [PaymentMethod_int_1], [PaymentMethod_int_2], [PaymentMethod_int_3], [PaymentMethod_int_4], [PaymentMethod_int_5], [PaymentMethod_int_6], [PaymentMethod_int_7], [PaymentMethod_int_8], [PaymentMethod_int_9], [PaymentMethod_int_10], [PaymentMethod_bit_1], [PaymentMethod_bit_2], [PaymentMethod_bit_3], [PaymentMethod_bit_4], [PaymentMethod_bit_5], [PaymentMethod_bit_6], [PaymentMethod_bit_7], [PaymentMethod_bit_8], [PaymentMethod_bit_9], [PaymentMethod_bit_10], [PaymentMethod_float_1], [PaymentMethod_float_2], [PaymentMethod_float_3], [PaymentMethod_float_4], [PaymentMethod_float_5], [PaymentMethod_float_6], [PaymentMethod_float_7], [PaymentMethod_float_8], [PaymentMethod_float_9], [PaymentMethod_float_10], [PaymentMethod_varchar_1], [PaymentMethod_varchar_2], [PaymentMethod_varchar_3], [PaymentMethod_varchar_4], [PaymentMethod_varchar_5], [PaymentMethod_varchar_6], [PaymentMethod_varchar_7], [PaymentMethod_varchar_8], [PaymentMethod_varchar_9], [PaymentMethod_varchar_10], [PaymentMethod_date_1], [PaymentMethod_date_2], [PaymentMethod_date_3], [PaymentMethod_date_4], [PaymentMethod_date_5], [PaymentMethod_date_6], [PaymentMethod_date_7], [PaymentMethod_date_8], [PaymentMethod_date_9], [PaymentMethod_date_10], [Deleted_Token], [Fr], [En]) VALUES (2, N'ESP', N'Espèce', NULL, 1, 1, 1, 0, 0, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [Payment].[PaymentMethod] ([Id], [Code], [MethodName], [Description], [AuthorizedForExpenses], [AuthorizedForRecipes], [Immediate], [IsDeleted], [TransactionUserId], [IdPaymentType], [PaymentMethod_int_1], [PaymentMethod_int_2], [PaymentMethod_int_3], [PaymentMethod_int_4], [PaymentMethod_int_5], [PaymentMethod_int_6], [PaymentMethod_int_7], [PaymentMethod_int_8], [PaymentMethod_int_9], [PaymentMethod_int_10], [PaymentMethod_bit_1], [PaymentMethod_bit_2], [PaymentMethod_bit_3], [PaymentMethod_bit_4], [PaymentMethod_bit_5], [PaymentMethod_bit_6], [PaymentMethod_bit_7], [PaymentMethod_bit_8], [PaymentMethod_bit_9], [PaymentMethod_bit_10], [PaymentMethod_float_1], [PaymentMethod_float_2], [PaymentMethod_float_3], [PaymentMethod_float_4], [PaymentMethod_float_5], [PaymentMethod_float_6], [PaymentMethod_float_7], [PaymentMethod_float_8], [PaymentMethod_float_9], [PaymentMethod_float_10], [PaymentMethod_varchar_1], [PaymentMethod_varchar_2], [PaymentMethod_varchar_3], [PaymentMethod_varchar_4], [PaymentMethod_varchar_5], [PaymentMethod_varchar_6], [PaymentMethod_varchar_7], [PaymentMethod_varchar_8], [PaymentMethod_varchar_9], [PaymentMethod_varchar_10], [PaymentMethod_date_1], [PaymentMethod_date_2], [PaymentMethod_date_3], [PaymentMethod_date_4], [PaymentMethod_date_5], [PaymentMethod_date_6], [PaymentMethod_date_7], [PaymentMethod_date_8], [PaymentMethod_date_9], [PaymentMethod_date_10], [Deleted_Token], [Fr], [En]) VALUES (3, N'CB', N'Carte bancaire', NULL, 1, 1, 1, 0, 0, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [Payment].[PaymentMethod] ([Id], [Code], [MethodName], [Description], [AuthorizedForExpenses], [AuthorizedForRecipes], [Immediate], [IsDeleted], [TransactionUserId], [IdPaymentType], [PaymentMethod_int_1], [PaymentMethod_int_2], [PaymentMethod_int_3], [PaymentMethod_int_4], [PaymentMethod_int_5], [PaymentMethod_int_6], [PaymentMethod_int_7], [PaymentMethod_int_8], [PaymentMethod_int_9], [PaymentMethod_int_10], [PaymentMethod_bit_1], [PaymentMethod_bit_2], [PaymentMethod_bit_3], [PaymentMethod_bit_4], [PaymentMethod_bit_5], [PaymentMethod_bit_6], [PaymentMethod_bit_7], [PaymentMethod_bit_8], [PaymentMethod_bit_9], [PaymentMethod_bit_10], [PaymentMethod_float_1], [PaymentMethod_float_2], [PaymentMethod_float_3], [PaymentMethod_float_4], [PaymentMethod_float_5], [PaymentMethod_float_6], [PaymentMethod_float_7], [PaymentMethod_float_8], [PaymentMethod_float_9], [PaymentMethod_float_10], [PaymentMethod_varchar_1], [PaymentMethod_varchar_2], [PaymentMethod_varchar_3], [PaymentMethod_varchar_4], [PaymentMethod_varchar_5], [PaymentMethod_varchar_6], [PaymentMethod_varchar_7], [PaymentMethod_varchar_8], [PaymentMethod_varchar_9], [PaymentMethod_varchar_10], [PaymentMethod_date_1], [PaymentMethod_date_2], [PaymentMethod_date_3], [PaymentMethod_date_4], [PaymentMethod_date_5], [PaymentMethod_date_6], [PaymentMethod_date_7], [PaymentMethod_date_8], [PaymentMethod_date_9], [PaymentMethod_date_10], [Deleted_Token], [Fr], [En]) VALUES (4, N'CHQ', N'Chèque', NULL, 1, 1, 1, 0, 0, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [Payment].[PaymentMethod] ([Id], [Code], [MethodName], [Description], [AuthorizedForExpenses], [AuthorizedForRecipes], [Immediate], [IsDeleted], [TransactionUserId], [IdPaymentType], [PaymentMethod_int_1], [PaymentMethod_int_2], [PaymentMethod_int_3], [PaymentMethod_int_4], [PaymentMethod_int_5], [PaymentMethod_int_6], [PaymentMethod_int_7], [PaymentMethod_int_8], [PaymentMethod_int_9], [PaymentMethod_int_10], [PaymentMethod_bit_1], [PaymentMethod_bit_2], [PaymentMethod_bit_3], [PaymentMethod_bit_4], [PaymentMethod_bit_5], [PaymentMethod_bit_6], [PaymentMethod_bit_7], [PaymentMethod_bit_8], [PaymentMethod_bit_9], [PaymentMethod_bit_10], [PaymentMethod_float_1], [PaymentMethod_float_2], [PaymentMethod_float_3], [PaymentMethod_float_4], [PaymentMethod_float_5], [PaymentMethod_float_6], [PaymentMethod_float_7], [PaymentMethod_float_8], [PaymentMethod_float_9], [PaymentMethod_float_10], [PaymentMethod_varchar_1], [PaymentMethod_varchar_2], [PaymentMethod_varchar_3], [PaymentMethod_varchar_4], [PaymentMethod_varchar_5], [PaymentMethod_varchar_6], [PaymentMethod_varchar_7], [PaymentMethod_varchar_8], [PaymentMethod_varchar_9], [PaymentMethod_varchar_10], [PaymentMethod_date_1], [PaymentMethod_date_2], [PaymentMethod_date_3], [PaymentMethod_date_4], [PaymentMethod_date_5], [PaymentMethod_date_6], [PaymentMethod_date_7], [PaymentMethod_date_8], [PaymentMethod_date_9], [PaymentMethod_date_10], [Deleted_Token], [Fr], [En]) VALUES (5, N'TRT', N'Traite', NULL, 1, 1, 1, 0, 0, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [Payment].[PaymentMethod] OFF
SET IDENTITY_INSERT [Sales].[SettlementMode] ON
INSERT INTO [Sales].[SettlementMode] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Comptant', N'Comptant', 0, 0, NULL)
SET IDENTITY_INSERT [Sales].[SettlementMode] OFF
SET IDENTITY_INSERT [Sales].[DetailsSettlementMode] ON
INSERT INTO [Sales].[DetailsSettlementMode] ([Id], [IdSettlementMode], [IdSettlementType], [IdPaymentMethod], [Percentage], [NumberDays], [SettlementDay], [IsDeleted], [TransactionUserId], [Deleted_Token], [CompletePrinting]) VALUES (1, 1, 2, 1, 100, NULL, NULL, 0, 0, NULL, N'')
SET IDENTITY_INSERT [Sales].[DetailsSettlementMode] OFF
SET IDENTITY_INSERT [Inventory].[Warehouse] ON
INSERT INTO [Inventory].[Warehouse] ([Id], [WarehouseCode], [WarehouseName], [WarehouseAdresse], [IsDeleted], [TransactionUserId], [IdWarehouseParent], [Deleted_Token], [IsCentral], [IsWarehouse], [IdResponsable]) VALUES (1, N'0002', N'Dépôt 1', N'Dépôt 1', 0, 0, 7, NULL, 0, 1, NULL)
INSERT INTO [Inventory].[Warehouse] ([Id], [WarehouseCode], [WarehouseName], [WarehouseAdresse], [IsDeleted], [TransactionUserId], [IdWarehouseParent], [Deleted_Token], [IsCentral], [IsWarehouse], [IdResponsable]) VALUES (3, N'0001', N'Dépôt 2', N'Dépôt 2', 0, 0, 7, NULL, 0, 1, NULL)
INSERT INTO [Inventory].[Warehouse] ([Id], [WarehouseCode], [WarehouseName], [WarehouseAdresse], [IsDeleted], [TransactionUserId], [IdWarehouseParent], [Deleted_Token], [IsCentral], [IsWarehouse], [IdResponsable]) VALUES (5, N'0003', N'Dépôt 3', N'Dépôt 3', 0, 0, 7, NULL, 0, 1, NULL)
INSERT INTO [Inventory].[Warehouse] ([Id], [WarehouseCode], [WarehouseName], [WarehouseAdresse], [IsDeleted], [TransactionUserId], [IdWarehouseParent], [Deleted_Token], [IsCentral], [IsWarehouse], [IdResponsable]) VALUES (6, N'0004', N'Dépôt 4', N'Dépôt 4', 0, 0, 8, NULL, 0, 1, NULL)
INSERT INTO [Inventory].[Warehouse] ([Id], [WarehouseCode], [WarehouseName], [WarehouseAdresse], [IsDeleted], [TransactionUserId], [IdWarehouseParent], [Deleted_Token], [IsCentral], [IsWarehouse], [IdResponsable]) VALUES (7, N'0005', N'Central', N'Central', 0, 0, NULL, NULL, 1, 0, NULL)
INSERT INTO [Inventory].[Warehouse] ([Id], [WarehouseCode], [WarehouseName], [WarehouseAdresse], [IsDeleted], [TransactionUserId], [IdWarehouseParent], [Deleted_Token], [IsCentral], [IsWarehouse], [IdResponsable]) VALUES (8, N'0006', N'Sfax', N'Sfax', 0, 0, 7, NULL, 0, 0, NULL)
INSERT INTO [Inventory].[Warehouse] ([Id], [WarehouseCode], [WarehouseName], [WarehouseAdresse], [IsDeleted], [TransactionUserId], [IdWarehouseParent], [Deleted_Token], [IsCentral], [IsWarehouse], [IdResponsable]) VALUES (9, N'0007', N'Dépôt 5', N'Dépôt 5', 0, 0, 8, NULL, 0, 1, NULL)
INSERT INTO [Inventory].[Warehouse] ([Id], [WarehouseCode], [WarehouseName], [WarehouseAdresse], [IsDeleted], [TransactionUserId], [IdWarehouseParent], [Deleted_Token], [IsCentral], [IsWarehouse], [IdResponsable]) VALUES (13, N'0008', N'Chihia', N'Chihia', 0, 0, 8, NULL, 0, 0, NULL)
INSERT INTO [Inventory].[Warehouse] ([Id], [WarehouseCode], [WarehouseName], [WarehouseAdresse], [IsDeleted], [TransactionUserId], [IdWarehouseParent], [Deleted_Token], [IsCentral], [IsWarehouse], [IdResponsable]) VALUES (14, N'0009', N'Dépôt 6', N'Dépôt 6', 0, 0, 13, NULL, 0, 1, NULL)
INSERT INTO [Inventory].[Warehouse] ([Id], [WarehouseCode], [WarehouseName], [WarehouseAdresse], [IsDeleted], [TransactionUserId], [IdWarehouseParent], [Deleted_Token], [IsCentral], [IsWarehouse], [IdResponsable]) VALUES (15, N'0010', N'Asgard', N'Asgard', 0, 0, 7, NULL, 0, 0, NULL)
INSERT INTO [Inventory].[Warehouse] ([Id], [WarehouseCode], [WarehouseName], [WarehouseAdresse], [IsDeleted], [TransactionUserId], [IdWarehouseParent], [Deleted_Token], [IsCentral], [IsWarehouse], [IdResponsable]) VALUES (16, N'0011', N'Dépôt 7', N'Dépôt 7', 0, 0, 15, NULL, 0, 1, NULL)
INSERT INTO [Inventory].[Warehouse] ([Id], [WarehouseCode], [WarehouseName], [WarehouseAdresse], [IsDeleted], [TransactionUserId], [IdWarehouseParent], [Deleted_Token], [IsCentral], [IsWarehouse], [IdResponsable]) VALUES (17, N'0012', N'Dépôt 8', N'Dépôt 8', 0, 0, 15, NULL, 0, 1, NULL)
SET IDENTITY_INSERT [Inventory].[Warehouse] OFF
SET IDENTITY_INSERT [Inventory].[Nature] ON
INSERT INTO [Inventory].[Nature] ([Id], [Code], [Label], [IsStockManaged], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Expense', N'Expense', 0, 0, 0, NULL)
SET IDENTITY_INSERT [Inventory].[Nature] OFF
SET IDENTITY_INSERT [Inventory].[MeasureUnit] ON
INSERT INTO [Inventory].[MeasureUnit] ([Id], [MeasureUnitCode], [Label], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Kg', N'Kg', N'Kg', 0, 0, NULL)
INSERT INTO [Inventory].[MeasureUnit] ([Id], [MeasureUnitCode], [Label], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Pce', N'Pce', N'PCE', 0, 0, NULL)
SET IDENTITY_INSERT [Inventory].[MeasureUnit] OFF
ALTER TABLE [Inventory].[Warehouse]
    ADD CONSTRAINT [FK_Warehouse_Employee] FOREIGN KEY ([IdResponsable]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Inventory].[Warehouse]
    ADD CONSTRAINT [FK_Warehouse_Warehouse] FOREIGN KEY ([IdWarehouseParent]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [Sales].[DetailsSettlementMode]
    ADD CONSTRAINT [FK_DetailsSettlementMode_SettlementType] FOREIGN KEY ([IdSettlementType]) REFERENCES [Sales].[SettlementType] ([Id]) ON DELETE SET NULL
ALTER TABLE [Sales].[DetailsSettlementMode]
    ADD CONSTRAINT [FK_DetailsSettlementMode_PaymentMethod] FOREIGN KEY ([IdPaymentMethod]) REFERENCES [Payment].[PaymentMethod] ([Id]) ON DELETE SET NULL
ALTER TABLE [Sales].[DetailsSettlementMode]
    ADD CONSTRAINT [FK_DetailsSettlementMode_SettlementMode] FOREIGN KEY ([IdSettlementMode]) REFERENCES [Sales].[SettlementMode] ([Id]) ON DELETE SET NULL
ALTER TABLE [Payment].[PaymentMethod]
    ADD CONSTRAINT [FK_PayementMethod_PayementType] FOREIGN KEY ([IdPaymentType]) REFERENCES [Payment].[PaymentType] ([Id])
COMMIT TRANSACTION

----- Users + roles
BEGIN TRANSACTION
SET IDENTITY_INSERT [ERPSettings].[User] ON
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent]) VALUES (3, N'Marwa', N'Ksentini', NULL, N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, NULL, NULL, NULL, N'mksentini@spark-it.fr', NULL, NULL, 0, 0, NULL, NULL)
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent]) VALUES (4, N'Houssem', N'Regaieg', NULL, N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, NULL, NULL, NULL, N'hregaieg@spark-it.fr', NULL, NULL, 0, 0, NULL, 3)
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent]) VALUES (5, N'Nihel', N'Ksontini', NULL, N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, NULL, NULL, NULL, N'nksontini@spark-it.fr', NULL, NULL, 0, 0, NULL, 3)
SET IDENTITY_INSERT [ERPSettings].[User] OFF
SET IDENTITY_INSERT [ERPSettings].[Role] ON
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (2, N'Manager', N'Manager', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (3, N'Responsable', N'Responsable', 0, NULL)
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (4, N'RESP-ACHAT', N'RESP-ACHAT', 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[Role] OFF
SET IDENTITY_INSERT [ERPSettings].[UserRole] ON
INSERT INTO [ERPSettings].[UserRole] ([Id], [IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (2, 3, 2, 0, 0, NULL)
INSERT INTO [ERPSettings].[UserRole] ([Id], [IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (3, 2, 3, 0, 0, NULL)
INSERT INTO [ERPSettings].[UserRole] ([Id], [IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (4, 3, 4, 0, 0, NULL)
INSERT INTO [ERPSettings].[UserRole] ([Id], [IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (5, 4, 5, 0, 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[UserRole] OFF
COMMIT TRANSACTION

----Marwa : Correction des Bogues----
BEGIN TRANSACTION
ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_ContributionRegister]
ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_RuleUniqueReference]
UPDATE [Payroll].[SalaryRule] SET [Name]=N'SALAIRE IMPOSABLE', [Description]=N'SALAIRE IMPOSABLE' WHERE [Id]=76
UPDATE [Payroll].[SalaryRule] SET [Name]=N'Retenue CNSS', [Description]=N'Retenue CNSS' WHERE [Id]=78
UPDATE [Payroll].[SalaryRule] SET [Name]=N'Retenue IRPP', [Description]=N'Retenue IRPP' WHERE [Id]=89
UPDATE [Payroll].[SalaryRule] SET [Description]=N'Contribution sociale solidaire ' WHERE [Id]=90
ALTER TABLE [Payroll].[SalaryRule]
    ADD CONSTRAINT [FK_SalaryRule_ContributionRegister] FOREIGN KEY ([IdContributionRegister]) REFERENCES [Payroll].[ContributionRegister] ([Id])
ALTER TABLE [Payroll].[SalaryRule]
    ADD CONSTRAINT [FK_SalaryRule_RuleUniqueReference] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
COMMIT TRANSACTION

-- Narcisse : Payroll data 

BEGIN TRANSACTION
ALTER TABLE [Payroll].[Variable] DROP CONSTRAINT [FK_Variable_RuleUnique]
ALTER TABLE [Payroll].[EmployeeSkills] DROP CONSTRAINT [FK_EmployeeSkills_Skills]
ALTER TABLE [Payroll].[EmployeeSkills] DROP CONSTRAINT [FK_EmployeeSkills_Employee]
ALTER TABLE [Payroll].[ConsultantsCustomerContract] DROP CONSTRAINT [FK_ConsultantsCustomerContract_Employee]
ALTER TABLE [Payroll].[ConsultantsCustomerContract] DROP CONSTRAINT [FK_ConsultantsCustomerContract_Prices]
ALTER TABLE [Payroll].[CommercialsCustomerContract] DROP CONSTRAINT [FK_CommercialsCustomerContract_Employee]
ALTER TABLE [Payroll].[CommercialsCustomerContract] DROP CONSTRAINT [FK_CommercialsCustomerContract_Prices]
ALTER TABLE [Payroll].[BaseSalary] DROP CONSTRAINT [FK_BaseSalary_Contract]
ALTER TABLE [Payroll].[ContractBonus] DROP CONSTRAINT [FK_Contract_Bonus_Contract]
ALTER TABLE [Payroll].[ContractBonus] DROP CONSTRAINT [FK_Contract_Bonus_Bonus]
ALTER TABLE [Payroll].[ConstantRateValidityPeriod] DROP CONSTRAINT [FK_ConstantRate_ValidityPeriod]
ALTER TABLE [Payroll].[ConstantRate] DROP CONSTRAINT [FK_ConstantRate_RuleUniqueReference]
ALTER TABLE [Payroll].[BonusValidityPeriod] DROP CONSTRAINT [FK_ContractBonusValidityPeriod_Bonus]
ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_RuleUniqueReference]
ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_ContributionRegister]
ALTER TABLE [Payroll].[SalaryStructureSalaryRule] DROP CONSTRAINT [FK_SalaryStructureRule_Rule]
ALTER TABLE [Payroll].[SalaryStructureSalaryRule] DROP CONSTRAINT [FK_SalaryStructureRule_Structure]
ALTER TABLE [Payroll].[SalaryStructure] DROP CONSTRAINT [FK_SalaryStructure_SalaryStructureParent]
ALTER TABLE [Payroll].[ConstantValueValidityPeriod] DROP CONSTRAINT [FK_ConstantValueValidityPeriod_ConstantValue]
ALTER TABLE [Payroll].[ConstantValue] DROP CONSTRAINT [FK_ConstantValue_RuleUniqueReference]
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_Employee]
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_SalaryStructure]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_City]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Country]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Grade]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Team]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_UpperHierarchy]


SET IDENTITY_INSERT [Payroll].[Employee] ON
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (1, 2, N'Fatma', N'ABDELHEDI', N'fabdelhedi@spark-it.fr', N'100', N'.', N'', N'', N'', NULL, 16, 84, N'3011', N'', N'(+216)  74 123 456', NULL, '19700101', N'', N'', NULL, N'', N'S0123456', 0, 0, 0, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (2, 1, N'Wael', N'BEN AMAR', N'wbenamar@spark-it.fr', N'101', N'Route Mahdia Saquiet Eddeyer Klm 7,5', N'', N'', N'', NULL, 16, 84, N'3011', N'(+216)   54 177 945', N'(+216)   762813239', NULL, '19900129', N'', N'', NULL, N'', N'16899898-02', 0, 0, 0, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (3, 1, N'Hamdi', N'AFRIT', N'hafrit@spark-it.fr', N'102', N'Rue Chneni résidence Yamama bloc 3 Apprt 01, 2074 Mourouj 5', N'', N'', N'', NULL, 16, 84, N'1000', N'(+216)  23 043 703', N'(+216)   785035759', NULL, '19850220', N'', N'', N'', N'', N'16709465-06', 0, 0, 0, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (4, 1, N'Jihed', N'HAJ ALI', N'jhajali@spark-it.fr', N'103', N'Route de Gabes, km8, cité El Moez, N°568, Sfax', N'', N'', N'', NULL, 16, 84, N'1000', N'(+216)  26 078 111', N'(+216)  75 1986831', NULL, '19910412', N'', N'', N'', N'', N'17016071-01', 0, 0, 0, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (5, 1, N'Foued', N'TOMZINI', N'ftomzini@spark-it.fr', N'104', N'111 Rue Lamartine 78500 SARTROUVILLE', N'', N'', N'', N'', 16, 84, N'1000', N'(+216)  29 404 967', N'783824455', N'', '19840321', N'', N'', N'', N'', N'1,84E+14', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (6, 1, N'Hammadi', N'CHAABANI', N'hchaabani@spark-it.fr', N'105', N'12 Avenue Général de Gaulle BA A1 A1002, 95100 Argenteuil', N'', N'', N'', N'', 16, 84, N'1000', N'(+216)  50 825 615', N'758556916', N'', '19880518', N'', N'', N'', N'', N'0', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (7, 1, N'Mohamed', N'MZID', N'mmzid@spark-it.fr', N'106', N'.', N'', N'', N'', N'', 16, 84, N'1000', N'(+33 ) 610772553', N'21658123625', N'', '19820920', N'', N'', N'', N'', N'12345678', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (8, 1, N'Narcisse', N'GAGOBA', N'ngagoba@spark-it.fr', N'107', N'Tunisie', N'Sfax', N'Mharza', N'52516661', NULL, 16, 84, N'2910', N'52516661', N'52516661', NULL, '19931029', N'Lomé', N'ngagoba', NULL, NULL, N'BK4692', NULL, 0, 0, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, 1, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (10, 1, N'Anis', N'JRIBI', N'ajribi@spark-it.fr', N'109', N'Avenue Rached N°236 , Gremda , Sfax', N'', N'', N'', N'', 16, 84, N'1000', N'(+216)  40 836 050', N'603152762', N'', '19920118', N'', N'', N'', N'', N'17015466-06', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (11, 1, N'Mohamed', N'KHARRAT', N'mkharrat@spark-it.fr', N'110', N'8 Avenue Hedi Chaker, rue 2 , El Ain , Sfax', N'', N'', N'', N'', 16, 84, N'1000', N'(+216)  55 634 238', N'785429158', N'', '19830228', N'', N'', N'', N'', N'16639692-00', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (12, 1, N'Mokhtar', N'GHOZZI', N'mghozzi@spark-it.fr', N'111', N'1 Avenue Bourguiba , rue Aboubaker Seddik , El Ain , Sfax', N'', N'', N'', N'', 16, 84, N'1000', N'(+216)  96 431 031', N'685854511', N'', '19890112', N'', N'', N'', N'', N'16880087-03', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (13, 1, N'Abdellatif', N'ELLOUZE', N'aellouze@spark-it.fr', N'112', N'Avenue Fatimiin N°70 , Gremda , Sfax', N'', N'', N'', N'', 16, 84, N'1000', N'(+216)  54 263 435', N'622420293', N'', '19850314', N'', N'', N'', N'', N'16696613-06', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (14, 1, N'Brahim', N'MAHJOUB', N'bmahjoub@spark-it.fr', N'113', N'Fatenassa Souk Lahad, kebili', N'', N'', N'', N'', 16, 84, N'1000', N'(+216)  94 097 376', N'617318206', N'', '19890506', N'', N'', N'', N'', N'16903395-00', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (15, 1, N'Jaber', N'NASRI', N'jnasri@spark-it.fr', N'114', N'Ain Jaloula Kairouan', N'', N'', N'', N'', 16, 84, N'1000', N'(+216)  54 192 459', N'626667599', N'', '19880430', N'', N'', N'', N'', N'17016191-06', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (16, 1, N'Ibrahim', N'BEN MUSTAPHA', N'ibenmustapha@spark-it.fr', N'115', N'Avenue Narcisse Kalaate Al Andalos Ariana', N'', N'', N'', N'', 16, 84, N'1000', N'(+216)  21 601 004', N'634120591', N'', '19890703', N'', N'', N'', N'', N'16778786-03', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (17, 1, N'Ibrahim', N'SALAH', N'bsalah@spark-it.fr', N'116', N'kliaa souk lahad, Kebili', N'', N'', N'', N'', 16, 84, N'1000', N'(+216)  22 450 374', N'753381675', N'', '19901123', N'', N'', N'', N'', N'17016413-08', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (18, 1, N'Mohamed', N'OMRI', N'momri@spark-it.fr', N'117', N'Cité Fraijia Sidi Bouzid', N'', N'', N'', N'', 16, 84, N'1000', N'(+216)  21 597 180', N'671850154', N'', '19910106', N'', N'', N'', N'', N'17017102-02', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (19, 1, N'Sleh Eddine', N'ABD ELKEFI', N'sabdelkefi@spark-it.fr', N'118', N'Route Elain Km 1.5 Zanket Kriaa Sfax', N'', N'', N'', N'', 16, 84, N'1000', N'(+216)  50 357 669', N'634278540', N'', '19910704', N'', N'', N'', N'', N'17017012-01', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (20, 1, N'Amin', N'AROUS', N'aarous@spark-it.fr', N'119', N'6 Rue Elma Route Rawad Ariana Chameliya, Ariana', N'', N'', N'', N'', 16, 84, N'1000', N'(+216)  54 723 619', N'758919829', N'', '19840118', N'', N'', N'', N'', N'16462889-00', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (21, 1, N'Belgacem', N'MUSTAPHA', N'bmustapha@spark-it.fr', N'120', N'5 rue Pasteur, 94220 Charenton le Pont', N'', N'', N'', N'', 16, 84, N'1000', N'(+216)  75 540 213', NULL, N'', '19840523', N'', N'', N'', N'', N'1,84E+14', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (22, 1, N'Hassen', N'MEKKI', N'hmekki@spark-it.fr', N'121', N'18 avenue Montesquieu 93190 Livry Gargan', N'', N'', N'', N'', 16, 84, N'1000', N'(+216)  92 930 274', N'753398389', N'', '19831127', N'', N'', N'', N'', N'7,19E+14', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (23, 1, N'Abdelmalek', N'TROUDI', N'amtroudi@spark-it.fr', N'122', N'50 rue des vignes 92000 Nanterre', N'', N'', N'', N'', 16, 84, N'1000', N'(+216)  615817260', NULL, N'', '19870829', N'', N'', N'', N'', N'1,87E+14', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (24, 1, N'Abdessatar', N'BOUCHELLIGA', N'abouchelliga@spark-it.fr', N'124', N'.', N'', N'', N'', N'', 16, 84, N'1000', N'0', N'0', N'', '19900101', N'', N'', N'', N'', N'A00000000', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (25, 1, N'Ahmed', N'CHEBBI', N'achebbi@spark-it.fr', N'125', N'.', N'', N'', N'', N'', 16, 84, N'1000', N'0', N'0', N'', '19900101', N'', N'', N'', N'', N'0', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (26, 1, N'Boubker', N'ECHIEB', N'bechieb@spark-it.fr', N'126', N'.', N'', N'', N'', N'', 16, 84, N'1000', N'(+216)  53 679 057', N'0', N'', '19900101', N'', N'', N'', N'', N'0', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (27, 1, N'Hassana', N'DIALLO', N'hdiallo@spark-it.fr', N'127', N'.', N'', N'', N'', N'', 16, 84, N'1000', N'0', N'0', N'', '19900101', N'', N'', N'', N'', N'0', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (28, 1, N'Douraid', N'TLILI', N'dtlili@spark-it.fr', N'128', N'.', N'', N'', N'', N'', 16, 84, N'1000', N'0', N'0', N'', '19900101', N'', N'', N'', N'', N'0', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (29, 2, N'Ghada', N'GHRIBI', N'gghribi@spark-it.fr', N'129', N'.', N'', N'', N'', N'', 16, 84, N'1000', N'0', N'0', N'', '19900101', N'', N'', N'', N'', N'0', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (30, 1, N'Haitham', N'ABID', N'habid@spark-it.fr', N'130', N'.', N'', N'', N'', N'', 16, 84, N'1000', N'0', N'0', N'', '19900101', N'', N'', N'', N'', N'0', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (31, 1, N'Hamdy', N'SDIRI', N'hsdiri@spark-it.fr', N'131', N'.', N'', N'', N'', N'', 16, 84, N'1000', N'0', N'0', N'', '19901231', N'', N'', N'', N'', N'0', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (32, 1, N'Houssem', N'REGAIEG', N'hregaieg@spark-it.fr', N'132', N'.', N'', N'', N'', N'', 16, 84, N'1000', N'(+216)  20 989 360', N'0', N'', '19900101', N'', N'', N'', N'', N'0', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (33, 1, N'Karim', N'SOUISSI', N'ksouissi@spark-it.fr', N'133', N'.', N'', N'', N'', N'', 16, 84, N'1000', N'0', N'0', N'', '19900101', N'', N'', N'', N'', N'0', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (34, 1, N'Mohamed Ali', N'BRADAI', N'mabradai@spark-it.fr', N'134', N'.', N'', N'', N'', N'', 16, 84, N'1000', N'0', N'0', N'', '19900101', N'', N'', N'', N'', N'0', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (35, 1, N'Melek', N'BENABDALLAH', N'mbenabdallah@spark-it.fr', N'135', N'.', N'', N'', N'', N'', 16, 84, N'1000', N'0', N'0', N'', '19900101', N'', N'', N'', N'', N'0', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (36, 2, N'Marwa', N'KSENTINI', N'mksentini@spark-it.fr', N'136', N'.', N'', N'', N'', N'', 16, 84, N'1000', N'0', N'0', N'', '19900101', N'', N'', N'', N'', N'0', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (37, 2, N'Imen', N'EZZINE', N'iezzine@spark-it.fr', N'137', N'.', N'', N'', N'', N'', 16, 84, N'1000', N'0', N'0', N'', '20200110', N'', N'', N'', N'', N'0', 0, 0, 1, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (39, 1, N'Mohamed', N'BOUZIDI', N'mbouzidi@spark-it.fr', N'138', N'Route tunis km4', NULL, NULL, NULL, NULL, 16, 84, N'2003', NULL, N'(+216)508421080000', NULL, '19900722', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
INSERT INTO [Payroll].[Employee] ([Id], [Sex], [FirstName], [LastName], [Email], [Matricule], [AddressLine1], [AddressLine2], [AddressLine3], [AddressLine4], [AddressLine5], [IdCountry], [IdCity], [ZipCode], [PersonalPhone], [ProfessionalPhone], [Picture], [BirthDate], [BirthPlace], [PseudoSkype], [Facebook], [Linkedin], [SocialSecurityNumber], [ChildrenNumber], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdGrade], [IdTeam], [IdUpperHierarchy], [WorkingLicenseNumber], [HiringDate], [Category], [CIN], [FamilyLeader], [Echelon]) VALUES (42, 2, N'Imen', N'chaaben', N'ichaaben@spark-it.fr', N'139', N'', NULL, NULL, NULL, NULL, 16, 84, N'2003', NULL, N'(+216)508421080000', NULL, '19900722', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 1, NULL, NULL, NULL, '20181023', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[Employee] OFF

--update Matricule Codefication 

update [ERPSettings].[Codification] set LastCounterValue='139' where Id =99 

BEGIN TRANSACTION
SET IDENTITY_INSERT [Payroll].[Cnss] ON
INSERT INTO [Payroll].[Cnss] ([Id], [Label], [EmployerRate], [SalaryRate], [WorkAccidentQuota], [OperatingCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'NORMAL', 16.21, 9.18, 10, N'XXXXO', 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[Cnss] OFF
COMMIT TRANSACTION

SET IDENTITY_INSERT [Payroll].[Contract] ON
INSERT INTO [Payroll].[Contract] ([Id], [ContractReference], [StartDate], [EndDate], [WorkingTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdEmployee],  [IdSalaryStructure], [IdCnss]) VALUES (1, N'Contract-001', '20180101', NULL, 40, 0, NULL, NULL, 8, 5,1)
INSERT INTO [Payroll].[Contract] ([Id], [ContractReference], [StartDate], [EndDate], [WorkingTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdEmployee],  [IdSalaryStructure], [IdCnss]) VALUES (4, N'Contract-002', '20180101', NULL, 40, 0, NULL, NULL, 1, 5,1)
INSERT INTO [Payroll].[Contract] ([Id], [ContractReference], [StartDate], [EndDate], [WorkingTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdEmployee],  [IdSalaryStructure], [IdCnss]) VALUES (7, N'Contract-003', '20180101', NULL, 32, 0, NULL, NULL, 4,  5,1)
INSERT INTO [Payroll].[Contract] ([Id], [ContractReference], [StartDate], [EndDate], [WorkingTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdEmployee],  [IdSalaryStructure], [IdCnss]) VALUES (8, N'Contract-004', '20180101', NULL, 24, 0, NULL, NULL, 11, 5,1)
INSERT INTO [Payroll].[Contract] ([Id], [ContractReference], [StartDate], [EndDate], [WorkingTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdEmployee],  [IdSalaryStructure], [IdCnss]) VALUES (9, N'Contract-005', '20180101', NULL, 40, 0, NULL, NULL, 4, 5,1)
INSERT INTO [Payroll].[Contract] ([Id], [ContractReference], [StartDate], [EndDate], [WorkingTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdEmployee],  [IdSalaryStructure], [IdCnss]) VALUES (10, N'Contract-006', '20180101', NULL, 40, 0, NULL, NULL, 10, 8,1)
INSERT INTO [Payroll].[Contract] ([Id], [ContractReference], [StartDate], [EndDate], [WorkingTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdEmployee],  [IdSalaryStructure], [IdCnss]) VALUES (11, N'Contract-007', '20180101', NULL, 20, 0, NULL, NULL, 13, 9,1)
INSERT INTO [Payroll].[Contract] ([Id], [ContractReference], [StartDate], [EndDate], [WorkingTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdEmployee],  [IdSalaryStructure], [IdCnss]) VALUES (12, N'Contract-008', '20180101', NULL, 25, 0, NULL, NULL, 13, 7,1)
INSERT INTO [Payroll].[Contract] ([Id], [ContractReference], [StartDate], [EndDate], [WorkingTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdEmployee],  [IdSalaryStructure], [IdCnss]) VALUES (15, N'Contract-0011', '20181104', NULL, NULL, 0, 0, NULL, 42, 5,1)
SET IDENTITY_INSERT [Payroll].[Contract] OFF
--- change codification of contract ---
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
UPDATE [ERPSettings].[Codification] SET [LastCounterValue]=N'0011' WHERE [Id]=106
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
COMMIT TRANSACTION


SET IDENTITY_INSERT [Payroll].[RuleUniqueReference] ON
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (74, N'BASE', 1, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (75, N'BRUT', 1, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (76, N'NET', 1, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (77, N'NETAPAYER', 1, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (78, N'TRANSPORT', 3, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (79, N'CNSS', 4, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (80, N'BRUTIMPOSABLEANNUEL', 2, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (81, N'CNSSRule', 1, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (82, N'IRPPRule', 1, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (83, N'CONTRIBUTION', 1, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (84, N'PRESENCE', 3, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (86, N'NEnfant', 2, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (87, N'FRAISREELS', 2, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (88, N'NETANNUEL', 2, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (89, N'NChefFamille', 2, 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[RuleUniqueReference] OFF
SET IDENTITY_INSERT [Payroll].[ConstantValue] ON
INSERT INTO [Payroll].[ConstantValue] ([Id], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference]) VALUES (18, N'Contante ralative aux primes de transport', 0, 0, NULL, 78)
INSERT INTO [Payroll].[ConstantValue] ([Id], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference]) VALUES (19, N'Constante relative à la prime de présence', 0, 0, NULL, 84)
SET IDENTITY_INSERT [Payroll].[ConstantValue] OFF
SET IDENTITY_INSERT [Payroll].[ConstantValueValidityPeriod] ON
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (87, '20180601', 60.194, 18, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (88, '20180701', 60.194, 18, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (89, '20180801', 60.194, 18, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (90, '20180901', 60.194, 18, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (91, '20181001', 60.194, 18, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (92, '20181101', 60.194, 18, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (93, '20181201', 60.194, 18, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (95, '20180301', 11.325, 19, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (96, '20180401', 11.325, 19, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (97, '20180501', 11.325, 19, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (98, '20180601', 11.325, 19, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (99, '20180701', 11.325, 19, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (100, '20180801', 11.325, 19, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (101, '20180901', 11.325, 19, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (102, '20181001', 11.325, 19, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (103, '20181101', 11.325, 19, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (104, '20181201', 11.325, 19, 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[ConstantValueValidityPeriod] OFF
SET IDENTITY_INSERT [Payroll].[SalaryStructure] ON
INSERT INTO [Payroll].[SalaryStructure] ([Id], [SalaryStructureReference], [Name], [Order], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdParent]) VALUES (4, N'ROOT', N'Structure salariale racine', 0, 0, NULL, NULL, NULL)
INSERT INTO [Payroll].[SalaryStructure] ([Id], [SalaryStructureReference], [Name], [Order], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdParent]) VALUES (5, N'CDI', N'Contrat à durée déterminée payée sur 12 mois', 1, 0, 0, NULL, 4)
INSERT INTO [Payroll].[SalaryStructure] ([Id], [SalaryStructureReference], [Name], [Order], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdParent]) VALUES (7, N'SIVP', N'stage d''initiation à la vie professionnelle', 1, 0, 0, NULL, 4)
INSERT INTO [Payroll].[SalaryStructure] ([Id], [SalaryStructureReference], [Name], [Order], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdParent]) VALUES (8, N'STAGIAIRE', N'Structure destinée aux stagiaires', 1, 0, 0, NULL, 4)
INSERT INTO [Payroll].[SalaryStructure] ([Id], [SalaryStructureReference], [Name], [Order], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdParent]) VALUES (9, N'CDD', N'Contrat à durée déterminée', 1, 0, 0, NULL, 4)
SET IDENTITY_INSERT [Payroll].[SalaryStructure] OFF
SET IDENTITY_INSERT [Payroll].[SalaryStructureSalaryRule] ON
INSERT INTO [Payroll].[SalaryStructureSalaryRule] ([Id], [IdStructure], [IdRule], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (58, 4, 74, 0, NULL, NULL)
INSERT INTO [Payroll].[SalaryStructureSalaryRule] ([Id], [IdStructure], [IdRule], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (59, 4, 75, 0, NULL, NULL)
INSERT INTO [Payroll].[SalaryStructureSalaryRule] ([Id], [IdStructure], [IdRule], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (60, 4, 76, 0, NULL, NULL)
INSERT INTO [Payroll].[SalaryStructureSalaryRule] ([Id], [IdStructure], [IdRule], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (61, 4, 77, 0, NULL, NULL)
INSERT INTO [Payroll].[SalaryStructureSalaryRule] ([Id], [IdStructure], [IdRule], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (62, 5, 78, 0, NULL, NULL)
INSERT INTO [Payroll].[SalaryStructureSalaryRule] ([Id], [IdStructure], [IdRule], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (63, 5, 89, 0, NULL, NULL)
INSERT INTO [Payroll].[SalaryStructureSalaryRule] ([Id], [IdStructure], [IdRule], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (64, 5, 90, 0, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[SalaryStructureSalaryRule] OFF
SET IDENTITY_INSERT [Payroll].[SalaryRule] ON
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [rule], [RuleType], [AppearsOnPaySlip], [Applicability], [RuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference], [DependNumberDaysWorked], [UsedinNewsPaper]) VALUES (74, N'SALAIRE DE BASE', N'SALAIRE DE BASE', 0, NULL, 1, 1, 0, 1, 0, 0, NULL, NULL, 74, 1, 1)
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [rule], [RuleType], [AppearsOnPaySlip], [Applicability], [RuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference], [DependNumberDaysWorked], [UsedinNewsPaper]) VALUES (75, N'SALAIRE BRUT', N'SALAIRE BRUT', 0, NULL, 1, 1, 1, 1, 0, 0, NULL, NULL, 75, 0, 1)
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [rule], [RuleType], [AppearsOnPaySlip], [Applicability], [RuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference], [DependNumberDaysWorked], [UsedinNewsPaper]) VALUES (76, N'SALAIRE IMPOSABLE', N'SALAIRE IMPOSABLE', 0, NULL, 1, 1, 2, 1, 0, 0, NULL, NULL, 76, 0, 1)
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [rule], [RuleType], [AppearsOnPaySlip], [Applicability], [RuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference], [DependNumberDaysWorked], [UsedinNewsPaper]) VALUES (77, N'SALAIRE NET A PAYER', N'SALAIRE NET A PAYER', 0, NULL, 1, 1, 3, 1, 0, 0, NULL, NULL, 77, 0, 1)
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [rule], [RuleType], [AppearsOnPaySlip], [Applicability], [RuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference], [DependNumberDaysWorked], [UsedinNewsPaper]) VALUES (78, N'Retenue CNSS', N'Retenue CNSS', 1, N'Cnss.SalaryRate*BRUT/100', 2, 1, 1, 1, 0, 0, NULL, NULL, 81, 0, 1)
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [rule], [RuleType], [AppearsOnPaySlip], [Applicability], [RuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference], [DependNumberDaysWorked], [UsedinNewsPaper]) VALUES (89, N'Retenue IRPP', N'Retenue IRPP', 2, N'si (NETANNUEL> 50000) 
       Alors ((NETANNUEL-50000)*35/100 + 50000*26,20/100)/12
sinon 
          si (NETANNUEL> 30000) 
                  Alors ((NETANNUEL-30000)*32/100 + 6700)/12
          sinon 
                    si (NETANNUEL> 20000) 
                             Alors ((NETANNUEL-20000)*28/100 + 20000*19,5/100)/12
                     sinon 
                               si (NETANNUEL> 5000) Alors ((NETANNUEL-5000)*26/100)/12
                               sinon 0
                                finsi 
                     finsi 
           finsi 
finsi', 2, 1, 2, 1, 0, 0, NULL, NULL, 82, 0, 1)
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [rule], [RuleType], [AppearsOnPaySlip], [Applicability], [RuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference], [DependNumberDaysWorked], [UsedinNewsPaper]) VALUES (90, N'Contribution sociale solidaire ', N'Contribution sociale solidaire ', 3, N'NETANNUEL/12*0,01', 2, 1, 2, 1, 0, 0, NULL, NULL, 83, 0, 1)
SET IDENTITY_INSERT [Payroll].[SalaryRule] OFF
SET IDENTITY_INSERT [Payroll].[Bonus] ON
INSERT INTO [Payroll].[Bonus] ([Id], [Code], [Name], [Description], [IsFixe], [IdCnss], [IsTaxable], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'TRANSPORT', N'Prime de transport', N'Prime de transporty ', 1, 1, 1, 0, NULL, NULL)
INSERT INTO [Payroll].[Bonus] ([Id], [Code], [Name], [Description], [IsFixe], [IdCnss], [IsTaxable], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'PRESENCE', N'Prime de présence', N'Prime de présence', 1, 1, 1, 0, NULL, NULL)
INSERT INTO [Payroll].[Bonus] ([Id], [Code], [Name], [Description], [IsFixe], [IdCnss], [IsTaxable], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Prime de l''Aîd', N'Prime de l''Aîd', N'Prime de l''Aîd', 0, 1, 1, 0, NULL, NULL)
INSERT INTO [Payroll].[Bonus] ([Id], [Code], [Name], [Description], [IsFixe], [IdCnss], [IsTaxable], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'Prime exceptionnelle', N'Prime exceptionnelle', N'Prime exceptionnelle', 0, 1, 0, 0, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[Bonus] OFF
SET IDENTITY_INSERT [Payroll].[BonusValidityPeriod] ON
INSERT INTO [Payroll].[BonusValidityPeriod] ([Id], [Value], [StartDate], [IdBonus], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (18, 84, '20180101', 1, 0, NULL, NULL)
INSERT INTO [Payroll].[BonusValidityPeriod] ([Id], [Value], [StartDate], [IdBonus], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (19, 16, '20180101', 2, 0, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[BonusValidityPeriod] OFF
SET IDENTITY_INSERT [Payroll].[ConstantRate] ON
INSERT INTO [Payroll].[ConstantRate] ([Id], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference]) VALUES (13, N'Caisse Nationale de Sécurité Sociale', 0, 0, NULL, 79)
SET IDENTITY_INSERT [Payroll].[ConstantRate] OFF
SET IDENTITY_INSERT [Payroll].[ConstantRateValidityPeriod] ON
INSERT INTO [Payroll].[ConstantRateValidityPeriod] ([Id], [Date], [SalaryRate], [EmployerRate], [IdConstantRate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (57, '20180401', 0.0918, 0.1657, 13, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantRateValidityPeriod] ([Id], [Date], [SalaryRate], [EmployerRate], [IdConstantRate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (66, '20180801', 0.0918, 0.1657, 13, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantRateValidityPeriod] ([Id], [Date], [SalaryRate], [EmployerRate], [IdConstantRate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (67, '20180901', 0.0918, 0.1657, 13, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantRateValidityPeriod] ([Id], [Date], [SalaryRate], [EmployerRate], [IdConstantRate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (68, '20181001', 0.0918, 0.1657, 13, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantRateValidityPeriod] ([Id], [Date], [SalaryRate], [EmployerRate], [IdConstantRate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (69, '20181101', 0.0918, 0.1657, 13, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantRateValidityPeriod] ([Id], [Date], [SalaryRate], [EmployerRate], [IdConstantRate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (70, '20181201', 0.0918, 0.1657, 13, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantRateValidityPeriod] ([Id], [Date], [SalaryRate], [EmployerRate], [IdConstantRate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (71, '20180701', 0.0918, 0.1657, 13, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantRateValidityPeriod] ([Id], [Date], [SalaryRate], [EmployerRate], [IdConstantRate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (72, '20180601', 0.0918, 0.1657, 13, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantRateValidityPeriod] ([Id], [Date], [SalaryRate], [EmployerRate], [IdConstantRate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (73, '20180501', 0.0918, 0.1657, 13, 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[ConstantRateValidityPeriod] OFF
SET IDENTITY_INSERT [Payroll].[ContractBonus] ON
INSERT INTO [Payroll].[ContractBonus] ([Id], [IdBonus], [IdContract], [Value], [ValidityStartDate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, 1, 1, 200, '20181001', 0, NULL, NULL)
INSERT INTO [Payroll].[ContractBonus] ([Id], [IdBonus], [IdContract], [Value], [ValidityStartDate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, 2, 1, NULL, '20181001', 0, NULL, NULL)
INSERT INTO [Payroll].[ContractBonus] ([Id], [IdBonus], [IdContract], [Value], [ValidityStartDate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, 1, 4, NULL, '20181001', 0, NULL, NULL)
INSERT INTO [Payroll].[ContractBonus] ([Id], [IdBonus], [IdContract], [Value], [ValidityStartDate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, 2, 4, NULL, '20181001', 0, NULL, NULL)
INSERT INTO [Payroll].[ContractBonus] ([Id], [IdBonus], [IdContract], [Value], [ValidityStartDate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, 1, 7, NULL, '20181001', 0, NULL, NULL)
INSERT INTO [Payroll].[ContractBonus] ([Id], [IdBonus], [IdContract], [Value], [ValidityStartDate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (6, 2, 7, NULL, '20181001', 0, NULL, NULL)
INSERT INTO [Payroll].[ContractBonus] ([Id], [IdBonus], [IdContract], [Value], [ValidityStartDate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (7, 1, 8, NULL, '20181001', 0, NULL, NULL)
INSERT INTO [Payroll].[ContractBonus] ([Id], [IdBonus], [IdContract], [Value], [ValidityStartDate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (8, 2, 8, NULL, '20181001', 0, NULL, NULL)
INSERT INTO [Payroll].[ContractBonus] ([Id], [IdBonus], [IdContract], [Value], [ValidityStartDate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (9, 1, 9, NULL, '20181001', 0, NULL, NULL)
INSERT INTO [Payroll].[ContractBonus] ([Id], [IdBonus], [IdContract], [Value], [ValidityStartDate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (10, 2, 9, NULL, '20181001', 0, NULL, NULL)
INSERT INTO [Payroll].[ContractBonus] ([Id], [IdBonus], [IdContract], [Value], [ValidityStartDate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (11, 1, 10, NULL, '20181001', 0, NULL, NULL)
INSERT INTO [Payroll].[ContractBonus] ([Id], [IdBonus], [IdContract], [Value], [ValidityStartDate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (12, 2, 10, NULL, '20181001', 0, NULL, NULL)
INSERT INTO [Payroll].[ContractBonus] ([Id], [IdBonus], [IdContract], [Value], [ValidityStartDate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (13, 1, 11, NULL, '20181001', 0, NULL, NULL)
INSERT INTO [Payroll].[ContractBonus] ([Id], [IdBonus], [IdContract], [Value], [ValidityStartDate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (14, 2, 11, NULL, '20181001', 0, NULL, NULL)
INSERT INTO [Payroll].[ContractBonus] ([Id], [IdBonus], [IdContract], [Value], [ValidityStartDate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (15, 1, 12, NULL, '20181001', 0, NULL, NULL)
INSERT INTO [Payroll].[ContractBonus] ([Id], [IdBonus], [IdContract], [Value], [ValidityStartDate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (16, 2, 12, NULL, '20181001', 0, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[ContractBonus] OFF
SET IDENTITY_INSERT [Payroll].[TypeIdentityPieces] ON
INSERT INTO [Payroll].[TypeIdentityPieces] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'CIN', N'Carte d''identité nationale', 0, 0, NULL)
INSERT INTO [Payroll].[TypeIdentityPieces] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'PASSEPORT', N'Passeport', 0, 0, NULL)
INSERT INTO [Payroll].[TypeIdentityPieces] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'PERMIS', N'Permis de conduire', 0, 0, NULL)
INSERT INTO [Payroll].[TypeIdentityPieces] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'Autre', N'Autre types de pièce d''identité', 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[TypeIdentityPieces] OFF
SET IDENTITY_INSERT [Payroll].[BaseSalary] ON
INSERT INTO [Payroll].[BaseSalary] ([Id], [IdContract], [IsDeleted], [TransactionUserId], [Deleted_Token], [Value], [StartDate]) VALUES (1, 1, 0, NULL, NULL, 2500, '20180101')
INSERT INTO [Payroll].[BaseSalary] ([Id], [IdContract], [IsDeleted], [TransactionUserId], [Deleted_Token], [Value], [StartDate]) VALUES (2, 4, 0, NULL, NULL, 1200, '20180101')
INSERT INTO [Payroll].[BaseSalary] ([Id], [IdContract], [IsDeleted], [TransactionUserId], [Deleted_Token], [Value], [StartDate]) VALUES (3, 7, 0, NULL, NULL, 5000, '20180101')
INSERT INTO [Payroll].[BaseSalary] ([Id], [IdContract], [IsDeleted], [TransactionUserId], [Deleted_Token], [Value], [StartDate]) VALUES (4, 8, 0, NULL, NULL, 400, '20180101')
INSERT INTO [Payroll].[BaseSalary] ([Id], [IdContract], [IsDeleted], [TransactionUserId], [Deleted_Token], [Value], [StartDate]) VALUES (5, 9, 0, NULL, NULL, 7000, '20180101')
INSERT INTO [Payroll].[BaseSalary] ([Id], [IdContract], [IsDeleted], [TransactionUserId], [Deleted_Token], [Value], [StartDate]) VALUES (6, 10, 0, NULL, NULL, 100, '20180101')
INSERT INTO [Payroll].[BaseSalary] ([Id], [IdContract], [IsDeleted], [TransactionUserId], [Deleted_Token], [Value], [StartDate]) VALUES (7, 11, 0, NULL, NULL, 1800, '20180101')
INSERT INTO [Payroll].[BaseSalary] ([Id], [IdContract], [IsDeleted], [TransactionUserId], [Deleted_Token], [Value], [StartDate]) VALUES (8, 12, 0, NULL, NULL, 3300, '20180101')
INSERT INTO [Payroll].[BaseSalary] ([Id], [IdContract], [IsDeleted], [TransactionUserId], [Deleted_Token], [Value], [StartDate]) VALUES (13, 15, 0, NULL, NULL, 1200, '20180101')
SET IDENTITY_INSERT [Payroll].[BaseSalary] OFF
SET IDENTITY_INSERT [Payroll].[Variable] ON
INSERT INTO [Payroll].[Variable] ([Id], [Description], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference]) VALUES (9, N'Le salaire brut imposable annuel', N'(BASE + PRIME_IMPOSABLE - CNSS)*12- NEnfant - NChefFamille', 0, 0, NULL, 80)
INSERT INTO [Payroll].[Variable] ([Id], [Description], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference]) VALUES (12, N'Variable contenant la réduction sur le nombre d''enfants', N'Si (Employee.ChildrenNumber = 1)
       Alors 90
Sinon Si (Employee.ChildrenNumber = 2)
                     Alors 90+75
           Sinon Si (Employee.ChildrenNumber = 3)
                              Alors 90+75+60
                      Sinon Si (Employee.ChildrenNumber >= 4)
                                        Alors 90+75+60+45
                                 Sinon 0
                                 Finsi
                      Finsi
            Finsi
Finsi', 0, 0, NULL, 86)
INSERT INTO [Payroll].[Variable] ([Id], [Description], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference]) VALUES (13, N'NETANNUEL', N'BRUTIMPOSABLEANNUEL - FRAISREELS', 0, 0, NULL, 88)
INSERT INTO [Payroll].[Variable] ([Id], [Description], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference]) VALUES (14, N'VARIABLE CONTENANT LES FRAIS  REELS ', N'Si (BRUTIMPOSABLEANNUEL > 20000)
	Alors 2000
Sinon BRUTIMPOSABLEANNUEL/10
Finsi', 0, 0, NULL, 87)
INSERT INTO [Payroll].[Variable] ([Id], [Description], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference]) VALUES (16, N'Variable contenant la réduction si l''employé est père de famille', N'Si (Employee.FamilyLeader)
	Alors 150
Sinon 0
Finsi', 0, 0, NULL, 89)
SET IDENTITY_INSERT [Payroll].[Variable] OFF
SET IDENTITY_INSERT [Payroll].[ContractType] ON
INSERT INTO [Payroll].[ContractType] ([Id], [ContractTypeReference], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [Fr], [En]) VALUES (1, N'TempPlein', N'Contrat à temp plein', 0, NULL, NULL, N'Temp plein', N'Full time')
SET IDENTITY_INSERT [Payroll].[ContractType] OFF
SET IDENTITY_INSERT [Payroll].[MaritalStatus] ON
INSERT INTO [Payroll].[MaritalStatus] ([Id], [label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Célibataire                                                                                                                                                                                                                                                    ', 0, NULL, NULL)
INSERT INTO [Payroll].[MaritalStatus] ([Id], [label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Marié                                                                                                                                                                                                                                                          ', 0, NULL, NULL)
INSERT INTO [Payroll].[MaritalStatus] ([Id], [label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Divorcé                                                                                                                                                                                                                                                        ', 0, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[MaritalStatus] OFF

SET IDENTITY_INSERT [Payroll].[Job] ON
INSERT INTO [Payroll].[Job] ([Id], [Designation], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Développeur .NET Core', 0, 0, NULL)
INSERT INTO [Payroll].[Job] ([Id], [Designation], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Testeur', 0, 0, NULL)
INSERT INTO [Payroll].[Job] ([Id], [Designation], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1003, N'Consultant', 0, 0, NULL)
INSERT INTO [Payroll].[Job] ([Id], [Designation], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1004, N'Ingenieur', 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[Job] OFF

SET IDENTITY_INSERT [Payroll].[IdentityPieces] ON
INSERT INTO [Payroll].[IdentityPieces] ([Id], [IdEmployee], [PieceNumber], [CreationDate], [CreationPlace], [ExpirationDate], [IdTypeIdentityPieces], [IsDeleted], [TransactionUserId], [Deleted_Token], [Current]) VALUES (2, 8, N'EB093132', '20170825', N'Lomé-TOGO', '20220825', 3, 0, 0, NULL, 1)
SET IDENTITY_INSERT [Payroll].[IdentityPieces] OFF
SET IDENTITY_INSERT [Payroll].[Grade] ON
INSERT INTO [Payroll].[Grade] ([Id], [Designation], [IsDeleted], [TransactionUserId], [Deleted_Token], [Description]) VALUES (1, N'Ingénieur ', 0, 0, NULL, NULL)
INSERT INTO [Payroll].[Grade] ([Id], [Designation], [IsDeleted], [TransactionUserId], [Deleted_Token], [Description]) VALUES (2, N'Docteur   ', 0, 0, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[Grade] OFF
SET IDENTITY_INSERT [Payroll].[ParentType] ON
INSERT INTO [Payroll].[ParentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Fils', 0, NULL, NULL)
INSERT INTO [Payroll].[ParentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Fille', 0, NULL, NULL)
INSERT INTO [Payroll].[ParentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Père', 0, NULL, NULL)
INSERT INTO [Payroll].[ParentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'Mère', 0, NULL, NULL)
INSERT INTO [Payroll].[ParentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'Grand-père', 0, NULL, NULL)
INSERT INTO [Payroll].[ParentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (6, N'Grand-mère', 0, NULL, NULL)
INSERT INTO [Payroll].[ParentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (7, N'Cousin', 0, NULL, NULL)
INSERT INTO [Payroll].[ParentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (8, N'Neuveux', 0, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[ParentType] OFF

ALTER TABLE [Payroll].[Variable]
    ADD CONSTRAINT [FK_Variable_RuleUnique] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
ALTER TABLE [Payroll].[EmployeeSkills]
    ADD CONSTRAINT [FK_EmployeeSkills_Skills] FOREIGN KEY ([IdSkills]) REFERENCES [Payroll].[Skills] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payroll].[EmployeeSkills]
    ADD CONSTRAINT [FK_EmployeeSkills_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payroll].[ConsultantsCustomerContract]
    ADD CONSTRAINT [FK_ConsultantsCustomerContract_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Payroll].[ConsultantsCustomerContract]
    ADD CONSTRAINT [FK_ConsultantsCustomerContract_Prices] FOREIGN KEY ([IdPrices]) REFERENCES [Sales].[Prices] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payroll].[CommercialsCustomerContract]
    ADD CONSTRAINT [FK_CommercialsCustomerContract_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Payroll].[CommercialsCustomerContract]
    ADD CONSTRAINT [FK_CommercialsCustomerContract_Prices] FOREIGN KEY ([IdPrices]) REFERENCES [Sales].[Prices] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payroll].[BaseSalary]
    ADD CONSTRAINT [FK_BaseSalary_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payroll].[ContractBonus]
    ADD CONSTRAINT [FK_Contract_Bonus_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [Payroll].[ContractBonus]
    ADD CONSTRAINT [FK_Contract_Bonus_Bonus] FOREIGN KEY ([IdBonus]) REFERENCES [Payroll].[Bonus] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [Payroll].[ConstantRateValidityPeriod]
    ADD CONSTRAINT [FK_ConstantRate_ValidityPeriod] FOREIGN KEY ([IdConstantRate]) REFERENCES [Payroll].[ConstantRate] ([Id])
ALTER TABLE [Payroll].[ConstantRate]
    ADD CONSTRAINT [FK_ConstantRate_RuleUniqueReference] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
ALTER TABLE [Payroll].[BonusValidityPeriod]
    ADD CONSTRAINT [FK_ContractBonusValidityPeriod_Bonus] FOREIGN KEY ([IdBonus]) REFERENCES [Payroll].[Bonus] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payroll].[SalaryRule]
    ADD CONSTRAINT [FK_SalaryRule_RuleUniqueReference] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
ALTER TABLE [Payroll].[SalaryRule]
    ADD CONSTRAINT [FK_SalaryRule_ContributionRegister] FOREIGN KEY ([IdContributionRegister]) REFERENCES [Payroll].[ContributionRegister] ([Id])
ALTER TABLE [Payroll].[SalaryStructureSalaryRule]
    ADD CONSTRAINT [FK_SalaryStructureRule_Rule] FOREIGN KEY ([IdRule]) REFERENCES [Payroll].[SalaryRule] ([Id])
ALTER TABLE [Payroll].[SalaryStructureSalaryRule]
    ADD CONSTRAINT [FK_SalaryStructureRule_Structure] FOREIGN KEY ([IdStructure]) REFERENCES [Payroll].[SalaryStructure] ([Id])
ALTER TABLE [Payroll].[SalaryStructure]
    ADD CONSTRAINT [FK_SalaryStructure_SalaryStructureParent] FOREIGN KEY ([IdParent]) REFERENCES [Payroll].[SalaryStructure] ([Id])
ALTER TABLE [Payroll].[ConstantValueValidityPeriod]
    ADD CONSTRAINT [FK_ConstantValueValidityPeriod_ConstantValue] FOREIGN KEY ([IdConstantValue]) REFERENCES [Payroll].[ConstantValue] ([Id])
ALTER TABLE [Payroll].[ConstantValue]
    ADD CONSTRAINT [FK_ConstantValue_RuleUniqueReference] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
ALTER TABLE [Payroll].[Contract]
    ADD CONSTRAINT [FK_Contract_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payroll].[Contract]
    ADD CONSTRAINT [FK_Contract_SalaryStructure] FOREIGN KEY ([IdSalaryStructure]) REFERENCES [Payroll].[SalaryStructure] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id])
ALTER TABLE [Payroll].[Employee]
    WITH NOCHECK ADD CONSTRAINT [FK_Employee_Grade] FOREIGN KEY ([IdGrade]) REFERENCES [Payroll].[Grade] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Team] FOREIGN KEY ([IdTeam]) REFERENCES [Payroll].[Team] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_UpperHierarchy] FOREIGN KEY ([IdUpperHierarchy]) REFERENCES [Payroll].[Employee] ([Id])
COMMIT TRANSACTION

--houssem add &&  update regle 
BEGIN TRANSACTION
UPDATE [Payroll].[Variable] SET [Formule]=N'(BASE + PRIME_IMPOSABLE - CNSS)*12- NEnfant - NChefFamille-CreditHabitation-NBEnfantNonBoursier-NBEnfantHandicape' WHERE [Id]=9
UPDATE [Payroll].[SalaryRule] SET [rule]=N'si(Employee.IsForeign)
	Alors (NETANNUEL *30/100/12)
	sinon
		si (NETANNUEL> 50000) 
			Alors ((NETANNUEL-50000)*35/100 + 50000*26,20/100)/12
		sinon 
          si (NETANNUEL> 30000) 
                  Alors ((NETANNUEL-30000)*32/100 + 6700)/12
			sinon 
                    si (NETANNUEL> 20000) 
                             Alors ((NETANNUEL-20000)*28/100 + 20000*19,5/100)/12
                     sinon 
                               si (NETANNUEL> 5000) Alors ((NETANNUEL-5000)*26/100)/12
                               sinon 0
                                finsi 
                     finsi 
			finsi 
		finsi
	finsi' WHERE [Id]=89
SET IDENTITY_INSERT [Payroll].[RuleUniqueReference] ON
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (91, N'CreditHabitation', 2, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (93, N'NBEnfantNonBoursier', 2, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (94, N'NBEnfantHandicape', 2, 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[RuleUniqueReference] OFF

SET IDENTITY_INSERT [Payroll].[Variable] ON
INSERT INTO [Payroll].[Variable] ([Id], [Description], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference]) VALUES (21, N'Varibale contenantt Credit d''habitaion', N'Employee.HomeLoan', 0, 0, NULL, 91)
INSERT INTO [Payroll].[Variable] ([Id], [Description], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference]) VALUES (22, N'Varibale contenant  nomber d''enfant non boursier', N'Employee.ChildrenNoScholar*150', 0, 0, NULL, 93)
INSERT INTO [Payroll].[Variable] ([Id], [Description], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference]) VALUES (23, N'Varibale contenant  nomber d''enfant handicapé', N'Employee.ChildrenDisabled*200', 0, 0, NULL, 94)
SET IDENTITY_INSERT [Payroll].[Variable] OFF 
COMMIT TRANSACTION


-- Imen CHAABEN : Update Rule unique reference for payroll resume

BEGIN TRANSACTION
UPDATE [Payroll].[RuleUniqueReference] SET [Reference]=N'CNSS_CT' WHERE [Id]=79
UPDATE [Payroll].[RuleUniqueReference] SET [Reference]=N'CNSS' WHERE [Id]=81
UPDATE [Payroll].[RuleUniqueReference] SET [Reference]=N'IRPP' WHERE [Id]=82
UPDATE [Payroll].[RuleUniqueReference] SET [Reference]=N'CSS' WHERE [Id]=83
COMMIT TRANSACTION

-- Narcisse : Add rule and variable for dependent parent

BEGIN TRANSACTION
ALTER TABLE [Payroll].[Variable] DROP CONSTRAINT [FK_Variable_RuleUnique]
ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_RuleUniqueReference]
ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_ContributionRegister]
UPDATE [Payroll].[Variable] SET [Formule]=N'BASEIMPOSABLEANNUEL- NEnfant - NChefFamille-CreditHabitation-NBEnfantNonBoursier-NBEnfantHandicape' WHERE [Id]=9
UPDATE [Payroll].[SalaryRule] SET [rule]=N'Cnss.SalaryRate*(BRUT + PRIME_COTISABLE)/100' WHERE [Id]=78
SET IDENTITY_INSERT [Payroll].[RuleUniqueReference] ON
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (96, N'BASEIMPOSABLEANNUEL', 2, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (97, N'PARENTACHARGE', 2, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (98, N'BASECALCULPARENTACHARGE', 2, 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[RuleUniqueReference] OFF
SET IDENTITY_INSERT [Payroll].[Variable] ON
INSERT INTO [Payroll].[Variable] ([Id], [Description], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference]) VALUES (29, N'base de calcul du brut imposable annuel', N'(BASE + PRIME_IMPOSABLE - CNSS)*12', 0, 0, NULL, 96)
INSERT INTO [Payroll].[Variable] ([Id], [Description], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference]) VALUES (31, N'Base de calcul de la réduction proportionnellement au nombre de parent', N'BASEIMPOSABLEANNUEL * 5 / 100', 0, 0, NULL, 98)
INSERT INTO [Payroll].[Variable] ([Id], [Description], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference]) VALUES (32, N'Réduction du parent à charge', N'Si (BASECALCULPARENTACHARGE > 150) 
	Alors Employee.DependentParent * 150
Sinon BASECALCULPARENTACHARGE * Employee.DependentParent
Finsi', 0, 0, NULL, 97)
SET IDENTITY_INSERT [Payroll].[Variable] OFF
ALTER TABLE [Payroll].[Variable]
    ADD CONSTRAINT [FK_Variable_RuleUnique] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
ALTER TABLE [Payroll].[SalaryRule]
    ADD CONSTRAINT [FK_SalaryRule_RuleUniqueReference] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
ALTER TABLE [Payroll].[SalaryRule]
    ADD CONSTRAINT [FK_SalaryRule_ContributionRegister] FOREIGN KEY ([IdContributionRegister]) REFERENCES [Payroll].[ContributionRegister] ([Id])
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [Payroll].[Variable] SET [Formule]=N'BASEIMPOSABLEANNUEL- NEnfant - NChefFamille-CreditHabitation-NBEnfantNonBoursier-NBEnfantHandicape-PARENTACHARGE' WHERE [Id]=9
UPDATE [Payroll].[Variable] SET [Formule]=N'Employee.ChildrenNoScholar*1000' WHERE [Id]=22
UPDATE [Payroll].[Variable] SET [Formule]=N'Employee.ChildrenDisabled*2000' WHERE [Id]=23
UPDATE [Payroll].[SalaryRule] SET [rule]=N'Cnss.SalaryRate*(BASE + PRIME_COTISABLE)/100' WHERE [Id]=78
COMMIT TRANSACTION


-- Mohamed BOUZIDI test data

BEGIN TRANSACTION
ALTER TABLE [Payroll].[Team] DROP CONSTRAINT [FK_Team_Department]
ALTER TABLE [Payroll].[Team] DROP CONSTRAINT [FK_Team_Employee]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_City]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Country]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Grade]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Team]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_UpperHierarchy]

SET IDENTITY_INSERT [Payroll].[Team] ON
INSERT INTO [Payroll].[Team] ([Id], [TeamCode], [Name], [CreationDate], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdDepartment], [IdManager]) VALUES (1, NULL, N'STARK', '20181207', 0, 0, NULL, NULL, 32)
INSERT INTO [Payroll].[Team] ([Id], [TeamCode], [Name], [CreationDate], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdDepartment], [IdManager]) VALUES (2, NULL, N'ADMIN', '20181207', 0, 0, NULL, NULL, 7)
INSERT INTO [Payroll].[Team] ([Id], [TeamCode], [Name], [CreationDate], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdDepartment], [IdManager]) VALUES (3, NULL, N'JAVA', '20181207', 0, 0, NULL, NULL, 39)
SET IDENTITY_INSERT [Payroll].[Team] OFF

UPDATE [Payroll].[Employee] SET [IdTeam]=1 WHERE [Id]=1
UPDATE [Payroll].[Employee] SET [IdTeam]=3 WHERE [Id]=2
UPDATE [Payroll].[Employee] SET [IdTeam]=3 WHERE [Id]=3
UPDATE [Payroll].[Employee] SET [IdTeam]=3 WHERE [Id]=4
UPDATE [Payroll].[Employee] SET [IdTeam]=3 WHERE [Id]=5
UPDATE [Payroll].[Employee] SET [IdTeam]=3 WHERE [Id]=6
UPDATE [Payroll].[Employee] SET [IdTeam]=3 WHERE [Id]=7
UPDATE [Payroll].[Employee] SET [IdTeam]=1 WHERE [Id]=8
UPDATE [Payroll].[Employee] SET [IdTeam]=3 WHERE [Id]=10
UPDATE [Payroll].[Employee] SET [IdTeam]=2 WHERE [Id]=11
UPDATE [Payroll].[Employee] SET [IdTeam]=2 WHERE [Id]=12
UPDATE [Payroll].[Employee] SET [IdTeam]=2 WHERE [Id]=13
UPDATE [Payroll].[Employee] SET [IdTeam]=2 WHERE [Id]=14
UPDATE [Payroll].[Employee] SET [IdTeam]=2 WHERE [Id]=15
UPDATE [Payroll].[Employee] SET [IdTeam]=1 WHERE [Id]=39
UPDATE [Payroll].[Employee] SET [IdTeam]=1 WHERE [Id]=42

ALTER TABLE [Payroll].[Team]
    WITH NOCHECK ADD CONSTRAINT [FK_Team_Department] FOREIGN KEY ([IdDepartment]) REFERENCES [Payroll].[Department] ([Id])
ALTER TABLE [Payroll].[Team]
    WITH NOCHECK ADD CONSTRAINT [FK_Team_Employee] FOREIGN KEY ([IdManager]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id])
ALTER TABLE [Payroll].[Employee]
    WITH NOCHECK ADD CONSTRAINT [FK_Employee_Grade] FOREIGN KEY ([IdGrade]) REFERENCES [Payroll].[Grade] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Team] FOREIGN KEY ([IdTeam]) REFERENCES [Payroll].[Team] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_UpperHierarchy] FOREIGN KEY ([IdUpperHierarchy]) REFERENCES [Payroll].[Employee] ([Id])
COMMIT TRANSACTION

-- Narcisse : Add DIGNITE cnss type and update the salary rule of Cnss

BEGIN TRANSACTION
ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_RuleUniqueReference]
ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_ContributionRegister]
UPDATE [Payroll].[SalaryRule] SET [rule]=N'BASE * Cnss.SalaryRate/100 + PRIME_COTISABLE' WHERE [Id]=78
SET IDENTITY_INSERT [Payroll].[Cnss] ON
INSERT INTO [Payroll].[Cnss] ([Id], [Label], [EmployerRate], [SalaryRate], [WorkAccidentQuota], [OperatingCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'DIGNITE', 16.21, 0, 10, N'XXXXD', 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[Cnss] OFF
ALTER TABLE [Payroll].[SalaryRule]
    ADD CONSTRAINT [FK_SalaryRule_RuleUniqueReference] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
ALTER TABLE [Payroll].[SalaryRule]
    ADD CONSTRAINT [FK_SalaryRule_ContributionRegister] FOREIGN KEY ([IdContributionRegister]) REFERENCES [Payroll].[ContributionRegister] ([Id])
COMMIT TRANSACTION

-- Narcisse : Add sodexo bonus and cnss and dignite bonus

BEGIN TRANSACTION
ALTER TABLE [Payroll].[Bonus] DROP CONSTRAINT [FK_Bonus_Cnss]
SET IDENTITY_INSERT [Payroll].[Cnss] ON
INSERT INTO [Payroll].[Cnss] ([Id], [Label], [EmployerRate], [SalaryRate], [WorkAccidentQuota], [OperatingCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'SODEXO', 0, 5, 0, N'XXXXS', 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[Cnss] OFF
SET IDENTITY_INSERT [Payroll].[Bonus] ON
INSERT INTO [Payroll].[Bonus] ([Id], [Code], [Name], [Description], [IsFixe], [IsTaxable], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdCnss]) VALUES (5, N'102', N'PRIME DIGNITE', N'Prime de dignité', 1, 1, 0, 0, NULL, 2)
INSERT INTO [Payroll].[Bonus] ([Id], [Code], [Name], [Description], [IsFixe], [IsTaxable], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdCnss]) VALUES (6, N'103', N'Prime sodexo', N'Prime sodexo', 0, 0, 0, 0, NULL, 3)
SET IDENTITY_INSERT [Payroll].[Bonus] OFF
ALTER TABLE [Payroll].[Bonus]
    ADD CONSTRAINT [FK_Bonus_Cnss] FOREIGN KEY ([IdCnss]) REFERENCES [Payroll].[Cnss] ([Id])
COMMIT TRANSACTION

-- Narcisse : Update payroll data

BEGIN TRANSACTION
ALTER TABLE [Payroll].[ConstantValueValidityPeriod] DROP CONSTRAINT [FK_ConstantValueValidityPeriod_ConstantValue]
ALTER TABLE [Payroll].[ConstantValue] DROP CONSTRAINT [FK_ConstantValue_RuleUniqueReference]
ALTER TABLE [Payroll].[ConstantRateValidityPeriod] DROP CONSTRAINT [FK_ConstantRate_ValidityPeriod]
ALTER TABLE [Payroll].[ConstantRate] DROP CONSTRAINT [FK_ConstantRate_RuleUniqueReference]
ALTER TABLE [Payroll].[Variable] DROP CONSTRAINT [FK_Variable_RuleUnique]
DELETE FROM [Payroll].[ConstantValueValidityPeriod] WHERE [Id]=87
DELETE FROM [Payroll].[ConstantValueValidityPeriod] WHERE [Id]=88
DELETE FROM [Payroll].[ConstantValueValidityPeriod] WHERE [Id]=89
DELETE FROM [Payroll].[ConstantValueValidityPeriod] WHERE [Id]=90
DELETE FROM [Payroll].[ConstantValueValidityPeriod] WHERE [Id]=91
DELETE FROM [Payroll].[ConstantValueValidityPeriod] WHERE [Id]=92
DELETE FROM [Payroll].[ConstantValueValidityPeriod] WHERE [Id]=93
DELETE FROM [Payroll].[ConstantValueValidityPeriod] WHERE [Id]=95
DELETE FROM [Payroll].[ConstantValueValidityPeriod] WHERE [Id]=96
DELETE FROM [Payroll].[ConstantValueValidityPeriod] WHERE [Id]=97
DELETE FROM [Payroll].[ConstantValueValidityPeriod] WHERE [Id]=98
DELETE FROM [Payroll].[ConstantValueValidityPeriod] WHERE [Id]=99
DELETE FROM [Payroll].[ConstantValueValidityPeriod] WHERE [Id]=100
DELETE FROM [Payroll].[ConstantValueValidityPeriod] WHERE [Id]=101
DELETE FROM [Payroll].[ConstantValueValidityPeriod] WHERE [Id]=102
DELETE FROM [Payroll].[ConstantValueValidityPeriod] WHERE [Id]=103
DELETE FROM [Payroll].[ConstantValueValidityPeriod] WHERE [Id]=104
DELETE FROM [Payroll].[ConstantValue] WHERE [Id]=18
DELETE FROM [Payroll].[ConstantValue] WHERE [Id]=19
DELETE FROM [Payroll].[ConstantRateValidityPeriod] WHERE [Id]=57
DELETE FROM [Payroll].[ConstantRateValidityPeriod] WHERE [Id]=66
DELETE FROM [Payroll].[ConstantRateValidityPeriod] WHERE [Id]=67
DELETE FROM [Payroll].[ConstantRateValidityPeriod] WHERE [Id]=68
DELETE FROM [Payroll].[ConstantRateValidityPeriod] WHERE [Id]=69
DELETE FROM [Payroll].[ConstantRateValidityPeriod] WHERE [Id]=70
DELETE FROM [Payroll].[ConstantRateValidityPeriod] WHERE [Id]=71
DELETE FROM [Payroll].[ConstantRateValidityPeriod] WHERE [Id]=72
DELETE FROM [Payroll].[ConstantRateValidityPeriod] WHERE [Id]=73
DELETE FROM [Payroll].[ConstantRate] WHERE [Id]=13
DELETE FROM [Payroll].[RuleUniqueReference] WHERE [Id]=78
DELETE FROM [Payroll].[RuleUniqueReference] WHERE [Id]=79
DELETE FROM [Payroll].[RuleUniqueReference] WHERE [Id]=84
UPDATE [Payroll].[Variable] SET [Description]=N'Brut imposable annuel' WHERE [Id]=9
UPDATE [Payroll].[Variable] SET [Description]=N'Réduction sur le nombre d''enfants' WHERE [Id]=12
UPDATE [Payroll].[Variable] SET [Description]=N'Net annuel' WHERE [Id]=13
UPDATE [Payroll].[Variable] SET [Description]=N'Les frais réels' WHERE [Id]=14
UPDATE [Payroll].[Variable] SET [Description]=N'Réduction si père de famille' WHERE [Id]=16
UPDATE [Payroll].[Variable] SET [Description]=N'Varibale du credit d''habitaion' WHERE [Id]=21
UPDATE [Payroll].[Variable] SET [Description]=N'Varibale du nombre d''enfant non boursier' WHERE [Id]=22
UPDATE [Payroll].[Variable] SET [Description]=N'Varibale du nombre d''enfant handicapé' WHERE [Id]=23
UPDATE [Payroll].[Variable] SET [Description]=N'Base imposable annuel' WHERE [Id]=29
UPDATE [Payroll].[Variable] SET [Description]=N'Base de calcul de la réduction par rapport au nombre de parent' WHERE [Id]=31
UPDATE [Payroll].[Variable] SET [Description]=N'Réduction sur le nombre de parent à charge' WHERE [Id]=32
ALTER TABLE [Payroll].[ConstantValueValidityPeriod]
    ADD CONSTRAINT [FK_ConstantValueValidityPeriod_ConstantValue] FOREIGN KEY ([IdConstantValue]) REFERENCES [Payroll].[ConstantValue] ([Id])
ALTER TABLE [Payroll].[ConstantValue]
    ADD CONSTRAINT [FK_ConstantValue_RuleUniqueReference] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
ALTER TABLE [Payroll].[ConstantRateValidityPeriod]
    ADD CONSTRAINT [FK_ConstantRate_ValidityPeriod] FOREIGN KEY ([IdConstantRate]) REFERENCES [Payroll].[ConstantRate] ([Id])
ALTER TABLE [Payroll].[ConstantRate]
    ADD CONSTRAINT [FK_ConstantRate_RuleUniqueReference] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
ALTER TABLE [Payroll].[Variable]
    ADD CONSTRAINT [FK_Variable_RuleUnique] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
COMMIT TRANSACTION

BEGIN TRANSACTION
ALTER TABLE [Payroll].[BonusValidityPeriod] DROP CONSTRAINT [FK_ContractBonusValidityPeriod_Bonus]
SET IDENTITY_INSERT [Payroll].[BonusValidityPeriod] ON
INSERT INTO [Payroll].[BonusValidityPeriod] ([Id], [Value], [StartDate], [IdBonus], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (20, 600, '20090101', 5, 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[BonusValidityPeriod] OFF
ALTER TABLE [Payroll].[BonusValidityPeriod]
    ADD CONSTRAINT [FK_ContractBonusValidityPeriod_Bonus] FOREIGN KEY ([IdBonus]) REFERENCES [Payroll].[Bonus] ([Id]) ON DELETE CASCADE
COMMIT TRANSACTION

-- Mohamed BOUZIDI delete the country (not iso) of id 16
BEGIN TRANSACTION
ALTER TABLE [Shared].[City] DROP CONSTRAINT [FK_City_Country]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_City]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Country]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Citizenship]
DELETE FROM [Shared].[Country] WHERE [Id]=16
UPDATE [Payroll].[Employee] SET [IdCountry]=235, [IdCitizenship]=235
UPDATE [Shared].[City] SET [IdCountry]=91 WHERE [Id]=84

ALTER TABLE [Shared].[City]
    ADD CONSTRAINT [FK_City_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id])
ALTER TABLE [Payroll].[Employee]
    WITH NOCHECK ADD CONSTRAINT [FK_Employee_Citizenship] FOREIGN KEY ([IdCitizenship]) REFERENCES [Shared].[Country] ([Id])
COMMIT TRANSACTION

--Mohamed BOUZIDI Delete PARIS from default employee city
UPDATE [Payroll].[Employee] SET [IdCity] = NULL

-- Narcisse : Salary structure without tax

BEGIN TRANSACTION
ALTER TABLE [Payroll].[SalaryStructureSalaryRule] DROP CONSTRAINT [FK_SalaryStructureRule_Rule]
ALTER TABLE [Payroll].[SalaryStructureSalaryRule] DROP CONSTRAINT [FK_SalaryStructureRule_Structure]
ALTER TABLE [Payroll].[SalaryStructure] DROP CONSTRAINT [FK_SalaryStructure_SalaryStructureParent]
UPDATE [Payroll].[SalaryStructure] SET [IdParent]=10 WHERE [Id]=7
UPDATE [Payroll].[SalaryStructure] SET [IdParent]=10 WHERE [Id]=8
SET IDENTITY_INSERT [Payroll].[SalaryStructure] ON
INSERT INTO [Payroll].[SalaryStructure] ([Id], [SalaryStructureReference], [Name], [Order], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdParent]) VALUES (10, N'ROOTWITHOUTTAX', N'Structure salariale racine sans impots', 0, 0, NULL, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[SalaryStructure] OFF
SET IDENTITY_INSERT [Payroll].[SalaryStructureSalaryRule] ON
INSERT INTO [Payroll].[SalaryStructureSalaryRule] ([Id], [IdStructure], [IdRule], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (65, 10, 74, 0, NULL, NULL)
INSERT INTO [Payroll].[SalaryStructureSalaryRule] ([Id], [IdStructure], [IdRule], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (66, 10, 75, 0, NULL, NULL)
INSERT INTO [Payroll].[SalaryStructureSalaryRule] ([Id], [IdStructure], [IdRule], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (68, 10, 77, 0, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[SalaryStructureSalaryRule] OFF
ALTER TABLE [Payroll].[SalaryStructureSalaryRule]
    ADD CONSTRAINT [FK_SalaryStructureRule_Rule] FOREIGN KEY ([IdRule]) REFERENCES [Payroll].[SalaryRule] ([Id])
ALTER TABLE [Payroll].[SalaryStructureSalaryRule]
    ADD CONSTRAINT [FK_SalaryStructureRule_Structure] FOREIGN KEY ([IdStructure]) REFERENCES [Payroll].[SalaryStructure] ([Id])
ALTER TABLE [Payroll].[SalaryStructure]
    ADD CONSTRAINT [FK_SalaryStructure_SalaryStructureParent] FOREIGN KEY ([IdParent]) REFERENCES [Payroll].[SalaryStructure] ([Id])
COMMIT TRANSACTION


-- Narcisse: 2019 new laws

BEGIN TRANSACTION

UPDATE [Payroll].[Variable] SET [Formule]=N'Employee.ChildrenNumber * 100' WHERE [Description] LIKE 'Réduction sur le nombre d''enfants'

UPDATE [Payroll].[Variable] SET [Formule]=N'Si (Employee.FamilyLeader)
    Alors 500
Sinon 0
Finsi' WHERE [Description] LIKE 'Réduction si père de famille'

COMMIT TRANSACTION

--- Marwa add warehouse ---
BEGIN TRANSACTION
UPDATE [Inventory].[Warehouse] SET [IdResponsable]=36 WHERE [Id]=1
UPDATE [Inventory].[Warehouse] SET [IdResponsable]=36 WHERE [Id]=5
UPDATE [Inventory].[Warehouse] SET [IdResponsable]=24 WHERE [Id]=6
UPDATE [Inventory].[Warehouse] SET [IdResponsable]=36 WHERE [Id]=13
UPDATE [Inventory].[Warehouse] SET [IdResponsable]=13 WHERE [Id]=14
COMMIT TRANSACTION

---- Imen add some data expenseReportDetailsType 
BEGIN TRANSACTION
SET IDENTITY_INSERT [Payroll].[ExpenseReportDetailsType] ON
INSERT INTO [Payroll].[ExpenseReportDetailsType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'HOTEL', N'Hotel', 0, NULL, NULL)
INSERT INTO [Payroll].[ExpenseReportDetailsType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'MEAL', N'Meal', 0, NULL, NULL)
INSERT INTO [Payroll].[ExpenseReportDetailsType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'TRANSPORT', N'Transport', 0, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[ExpenseReportDetailsType] OFF
COMMIT TRANSACTION

-- Narcisse: Update Variable based on employee number of childreen

ALTER TABLE [Payroll].[Variable] DROP CONSTRAINT [FK_Variable_RuleUnique]
UPDATE [Payroll].[Variable] SET [Formule]=N'Si (Employee.FamilyLeader)
    Alors Employee.ChildrenNumber * 100
Sinon 0
Finsi' WHERE [Description] LIKE 'Réduction sur le nombre d''enfants'
ALTER TABLE [Payroll].[Variable]
    ADD CONSTRAINT [FK_Variable_RuleUnique] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])

-- Rabeb : Update user connected with associate employee
 
UPDATE [ERPSettings].[User] SET [TransactionUserId]=0, [Lang]=N'fr', [IdEmployee]=7 WHERE [Id]=2
UPDATE [Payroll].[Employee] SET [Email]=N'demo@spark-it.fr' WHERE [Id]=7

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[User] DROP CONSTRAINT [FK_User_Employee]
ALTER TABLE [ERPSettings].[User] DROP CONSTRAINT [FK_User_User]
UPDATE [ERPSettings].[User] SET [IdEmployee]=36 WHERE [FirstName] LIKE 'Marwa'
UPDATE [ERPSettings].[User] SET [IdEmployee]=32 WHERE [FirstName] LIKE 'Houssem'
ALTER TABLE [ERPSettings].[User]
    ADD CONSTRAINT [FK_User_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [ERPSettings].[User]
    ADD CONSTRAINT [FK_User_User] FOREIGN KEY ([IdUserParent]) REFERENCES [ERPSettings].[User] ([Id])
COMMIT TRANSACTION


-- Mohamed BOUZIDI Recruitment DATA
BEGIN TRANSACTION

SET IDENTITY_INSERT [RH].[Candidate] ON 
INSERT [RH].[Candidate] ([Id], [Sex], [FirstName], [LastName], [Email], [CIN], [IsForeign], [IdEmployee], [IsDeleted], [TransactionUserId], [Deleted_Token], [LinkedIn]) VALUES (1, 1, N'Slim', N'SAHNOUN', N'sslim@live.fr', N'07765448', 0, NULL, 0, 0, NULL, NULL)
INSERT [RH].[Candidate] ([Id], [Sex], [FirstName], [LastName], [Email], [CIN], [IsForeign], [IdEmployee], [IsDeleted], [TransactionUserId], [Deleted_Token], [LinkedIn]) VALUES (2, 2, N'Kawthar', N'BEN MAHMOUD', N'bmkawthar@outlook.fr', N'07765448', 0, NULL, 0, 0, NULL, NULL)
INSERT [RH].[Candidate] ([Id], [Sex], [FirstName], [LastName], [Email], [CIN], [IsForeign], [IdEmployee], [IsDeleted], [TransactionUserId], [Deleted_Token], [LinkedIn]) VALUES (3, 1, N'Ahmad', N'HALIM', N'hahmad@gmail.com', N'07765448', 0, NULL, 0, 0, NULL, NULL)
SET IDENTITY_INSERT [RH].[Candidate] OFF

SET IDENTITY_INSERT [RH].[Recruitment] ON 
INSERT [RH].[Recruitment] ([Id], [YearOfExperience], [WorkingHoursPerDays], [Priority], [Description], [State], [CreationDate], [ClosingDate], [IdQualificationType], [IdJob], [IdEmployeeAuthor], [IdEmployeeValidator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (2, 2, 8, 3, N'Responsable qualité', 4, CAST(N'2019-04-02' AS Date), CAST(N'2019-04-30' AS Date), 1, 1, 1, 1, NULL, 0, NULL)
INSERT [RH].[Recruitment] ([Id], [YearOfExperience], [WorkingHoursPerDays], [Priority], [Description], [State], [CreationDate], [ClosingDate], [IdQualificationType], [IdJob], [IdEmployeeAuthor], [IdEmployeeValidator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (3, 2, 8, 4, N'Responsable marketing', 5, CAST(N'2019-04-02' AS Date), CAST(N'2019-04-30' AS Date), 1, 1, 1, 1, NULL, 0, NULL)
INSERT [RH].[Recruitment] ([Id], [YearOfExperience], [WorkingHoursPerDays], [Priority], [Description], [State], [CreationDate], [ClosingDate], [IdQualificationType], [IdJob], [IdEmployeeAuthor], [IdEmployeeValidator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (4, 2, 8, 1, N'Architecte .NET', 3, CAST(N'2019-04-02' AS Date), CAST(N'2019-04-30' AS Date), 1, 1, 1, 1, NULL, 0, NULL)
INSERT [RH].[Recruitment] ([Id], [YearOfExperience], [WorkingHoursPerDays], [Priority], [Description], [State], [CreationDate], [ClosingDate], [IdQualificationType], [IdJob], [IdEmployeeAuthor], [IdEmployeeValidator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (5, 2, 2, 4, N'asass', 2, CAST(N'2019-04-10' AS Date), NULL, 4, 3, 7, 7, 0, 0, NULL)
SET IDENTITY_INSERT [RH].[Recruitment] OFF

SET IDENTITY_INSERT [RH].[Candidacy] ON 
INSERT [RH].[Candidacy] ([Id], [State], [IdRecruitment], [IdCandidate], [TransactionUserId], [IsDeleted], [Deleted_Token], [CreationDate], [DepositDate]) VALUES (1, 4, 2, 1, NULL, 0, NULL, CAST(N'2019-04-09T14:43:43.370' AS DateTime), CAST(N'2019-04-01T15:00:00.000' AS DateTime))
INSERT [RH].[Candidacy] ([Id], [State], [IdRecruitment], [IdCandidate], [TransactionUserId], [IsDeleted], [Deleted_Token], [CreationDate], [DepositDate]) VALUES (2, 4, 2, 2, NULL, 0, NULL, CAST(N'2019-04-09T14:43:43.370' AS DateTime), CAST(N'2019-04-02T15:00:00.000' AS DateTime))
INSERT [RH].[Candidacy] ([Id], [State], [IdRecruitment], [IdCandidate], [TransactionUserId], [IsDeleted], [Deleted_Token], [CreationDate], [DepositDate]) VALUES (3, 4, 2, 3, NULL, 0, NULL, CAST(N'2019-04-09T14:43:43.370' AS DateTime), CAST(N'2019-04-03T15:00:00.000' AS DateTime))
INSERT [RH].[Candidacy] ([Id], [State], [IdRecruitment], [IdCandidate], [TransactionUserId], [IsDeleted], [Deleted_Token], [CreationDate], [DepositDate]) VALUES (4, 4, 3, 3, NULL, 0, NULL, CAST(N'2019-04-09T14:43:43.370' AS DateTime), CAST(N'2019-04-03T15:00:00.000' AS DateTime))
INSERT [RH].[Candidacy] ([Id], [State], [IdRecruitment], [IdCandidate], [TransactionUserId], [IsDeleted], [Deleted_Token], [CreationDate], [DepositDate]) VALUES (5, 4, 4, 3, NULL, 0, NULL, CAST(N'2019-04-09T14:43:43.370' AS DateTime), CAST(N'2019-04-03T15:00:00.000' AS DateTime))
SET IDENTITY_INSERT [RH].[Candidacy] OFF

SET IDENTITY_INSERT [RH].[Interview] ON 
INSERT [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (3, 10, CAST(N'2019-04-02T00:00:00.000' AS DateTime), CAST(N'2019-04-21T15:00:00.000' AS DateTime), N'remarques', 2, NULL, 1, 0, 0, NULL)
INSERT [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (4, 10, CAST(N'2019-04-02T00:00:00.000' AS DateTime), CAST(N'2019-04-08T16:00:00.000' AS DateTime), N'remarques', 1, NULL, 1, NULL, 0, NULL)
INSERT [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (5, 10, CAST(N'2019-04-02T00:00:00.000' AS DateTime), CAST(N'2019-04-12T17:00:00.000' AS DateTime), N'remarques', 1, NULL, 1, NULL, 0, NULL)
INSERT [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (6, 10, CAST(N'2019-04-02T00:00:00.000' AS DateTime), CAST(N'2019-04-12T13:00:00.000' AS DateTime), N'remarques', 1, NULL, 2, NULL, 0, NULL)
INSERT [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (7, 10, CAST(N'2019-04-02T00:00:00.000' AS DateTime), CAST(N'2019-04-12T15:00:00.000' AS DateTime), N'remarques', 1, NULL, 2, NULL, 0, NULL)
INSERT [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (8, 10, CAST(N'2019-04-02T00:00:00.000' AS DateTime), CAST(N'2019-04-20T10:00:00.000' AS DateTime), N'remarques', 1, NULL, 2, NULL, 0, NULL)
INSERT [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9, 10, CAST(N'2019-04-02T00:00:00.000' AS DateTime), CAST(N'2019-04-20T09:00:00.000' AS DateTime), N'remarques', 1, NULL, 2, NULL, 0, NULL)
INSERT [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (10, 10, CAST(N'2019-04-02T00:00:00.000' AS DateTime), CAST(N'2019-04-20T14:00:00.000' AS DateTime), N'remarques', 2, NULL, 2, 0, 0, NULL)
INSERT [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (11, 10, CAST(N'2019-04-02T00:00:00.000' AS DateTime), CAST(N'2019-04-26T10:00:00.000' AS DateTime), N'remarques', 2, NULL, 3, 0, 0, NULL)
INSERT [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (12, 10, CAST(N'2019-04-02T00:00:00.000' AS DateTime), CAST(N'2019-04-23T10:00:00.000' AS DateTime), N'remarques', 1, NULL, 3, NULL, 0, NULL)
INSERT [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (13, 10, CAST(N'2019-04-02T00:00:00.000' AS DateTime), CAST(N'2019-04-23T10:00:00.000' AS DateTime), N'remarques', 2, NULL, 3, 0, 0, NULL)
INSERT [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (14, 10, CAST(N'2019-04-02T00:00:00.000' AS DateTime), CAST(N'2019-04-29T13:00:00.000' AS DateTime), N'remarques', 3, NULL, 3, 0, 0, NULL)
INSERT [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (15, 10, CAST(N'2019-04-02T00:00:00.000' AS DateTime), CAST(N'2019-04-23T10:00:00.000' AS DateTime), N'remarques', 1, NULL, 4, NULL, 0, NULL)
INSERT [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (16, 10, CAST(N'2019-04-02T00:00:00.000' AS DateTime), CAST(N'2019-04-29T13:00:00.000' AS DateTime), N'remarques', 1, NULL, 4, NULL, 0, NULL)
INSERT [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (17, 10, CAST(N'2019-04-02T00:00:00.000' AS DateTime), CAST(N'2019-04-23T10:00:00.000' AS DateTime), N'remarques', 1, NULL, 4, NULL, 0, NULL)
INSERT [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (18, 10, CAST(N'2019-04-02T00:00:00.000' AS DateTime), CAST(N'2019-04-29T13:00:00.000' AS DateTime), N'remarques', 1, NULL, 4, NULL, 0, NULL)
SET IDENTITY_INSERT [RH].[Interview] OFF

SET IDENTITY_INSERT [RH].[InterviewMark] ON 
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (1, 15, 0, 2, 1, 3, 0, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (2, 15, 1, 2, 2, 3, 0, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (3, 15, 1, 2, 3, 3, 0, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (4, 15, 0, 1, 4, 4, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (5, 15, 1, 1, 5, 4, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (6, 15, 1, 1, 6, 5, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (7, 15, 1, 1, 7, 6, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (8, 15, 1, 1, 8, 6, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9, 15, 0, 1, 37, 6, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (10, 15, 0, 1, 10, 6, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (11, 15, 0, 1, 11, 7, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (12, 15, 1, 1, 12, 7, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (13, 15, 0, 1, 13, 7, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (14, 15, 1, 1, 14, 8, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (15, 15, 1, 1, 15, 8, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (16, 15, 1, 1, 16, 8, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (17, 15, 0, 1, 17, 8, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (18, 15, 0, 1, 18, 8, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (19, 15, 0, 1, 19, 9, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (20, 15, 1, 1, 20, 9, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (21, 15, 1, 1, 21, 9, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (22, 15, 1, 1, 22, 9, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (23, 15, 0, 1, 23, 9, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (24, 15, 1, 2, 24, 10, 0, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (25, 15, 1, 2, 25, 10, 0, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (26, 15, 0, 1, 26, 10, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (27, 15, 0, 1, 27, 10, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (28, 15, 0, 1, 28, 11, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (29, 15, 1, 2, 29, 11, 0, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (30, 15, 1, 1, 30, 12, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (31, 15, 1, 1, 31, 12, NULL, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (32, 15, 1, 2, 32, 13, 0, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (33, 15, 0, 2, 33, 13, 0, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (34, 15, 1, 2, 34, 14, 0, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (35, 15, 0, 2, 35, 14, 0, 0, NULL)
INSERT [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (36, 15, 0, 2, 36, 14, 0, 0, NULL)
SET IDENTITY_INSERT [RH].[InterviewMark] OFF

COMMIT TRANSACTION


---Kossi add some test data for recruitment jobskills
BEGIN TRANSACTION

SET IDENTITY_INSERT [Payroll].[Skills] ON
INSERT INTO [Payroll].[Skills] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Code], [Description], [Id_Family]) VALUES (1, N'Angular', 0, 0, NULL, N'SK00000014', N'Angular', NULL)
INSERT INTO [Payroll].[Skills] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Code], [Description], [Id_Family]) VALUES (2, N'Java', 0, 0, NULL, N'SK00000015', N'Java', NULL)
INSERT INTO [Payroll].[Skills] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Code], [Description], [Id_Family]) VALUES (3, N'PHP', 0, 0, NULL, N'SK00000016', N'PHP', NULL)
INSERT INTO [Payroll].[Skills] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Code], [Description], [Id_Family]) VALUES (4, N'Python', 0, 0, NULL, N'SK00000017', N'Python', NULL)
INSERT INTO [Payroll].[Skills] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Code], [Description], [Id_Family]) VALUES (5, N'.Net core', 0, 0, NULL, N'SK00000018', N'.Net core', NULL)
INSERT INTO [Payroll].[Skills] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Code], [Description], [Id_Family]) VALUES (6, N'Expert', 0, 0, NULL, N'SK00000019', N'Expert', NULL)
SET IDENTITY_INSERT [Payroll].[Skills] OFF
SET IDENTITY_INSERT [Payroll].[JobSkills] ON
INSERT INTO [Payroll].[JobSkills] ([Id], [IdJob], [IdSkill], [Rate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, 3, 6, 4, 0, 0, NULL)
INSERT INTO [Payroll].[JobSkills] ([Id], [IdJob], [IdSkill], [Rate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, 3, 5, 3, 0, 0, NULL)
INSERT INTO [Payroll].[JobSkills] ([Id], [IdJob], [IdSkill], [Rate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, 1004, 6, 4, 0, 0, NULL)
INSERT INTO [Payroll].[JobSkills] ([Id], [IdJob], [IdSkill], [Rate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, 1004, 5, 3, 0, 0, NULL)
INSERT INTO [Payroll].[JobSkills] ([Id], [IdJob], [IdSkill], [Rate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (7, 1, 1, 2, 0, 0, NULL)
INSERT INTO [Payroll].[JobSkills] ([Id], [IdJob], [IdSkill], [Rate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (8, 1, 2, 2, 0, 0, NULL)
INSERT INTO [Payroll].[JobSkills] ([Id], [IdJob], [IdSkill], [Rate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (9, 1, 5, 5, 0, 0, NULL)
INSERT INTO [Payroll].[JobSkills] ([Id], [IdJob], [IdSkill], [Rate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (10, 1, 4, 2, 0, 0, NULL)
INSERT INTO [Payroll].[JobSkills] ([Id], [IdJob], [IdSkill], [Rate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (11, 1, 3, 1, 0, 0, NULL)
INSERT INTO [Payroll].[JobSkills] ([Id], [IdJob], [IdSkill], [Rate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (12, 1003, 1, 4, 0, 0, NULL)
INSERT INTO [Payroll].[JobSkills] ([Id], [IdJob], [IdSkill], [Rate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (13, 1003, 4, 3, 0, 0, NULL)
INSERT INTO [Payroll].[JobSkills] ([Id], [IdJob], [IdSkill], [Rate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (14, 1003, 3, 3, 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[JobSkills] OFF

COMMIT TRANSACTION

-- Rabeb : Interview and evaluation note 

BEGIN TRANSACTION
SET IDENTITY_INSERT [RH].[Interview] ON
INSERT INTO [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token], [IdEmail]) VALUES (19, NULL, '20190429 10:58:35.740', '20190430 08:00:00.000', NULL, 4, NULL, 5, 0, 0, NULL, NULL)
INSERT INTO [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token], [IdEmail]) VALUES (20, NULL, '20190502 08:37:01.143', '20190502 04:04:00.000', NULL, 1, NULL, 4, 0, 0, NULL, NULL)
SET IDENTITY_INSERT [RH].[Interview] OFF
SET IDENTITY_INSERT [RH].[InterviewMark] ON
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (37, 0, 1, 2, 1, 19, 0, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (38, 0, 0, 2, 3, 19, 0, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (49, 0, 1, 1, 1, 20, 0, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (50, 0, 0, 1, 4, 20, 0, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (78, 0, 0, 1, 1, 7, 0, 0, NULL, 3, N'Motivé', N'timide', N'<p>expert en java</p>')
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (79, 0, 0, 1, 1, 4, 0, 0, NULL, 2, N'Motivé', N'timide', N'<p>expert en java</p>')
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (80, 0, 0, 1, 1, 5, 0, 0, NULL, 0, N'Motivé', N'timide', N'<p>expert en java</p>')
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (81, 0, 0, 1, 1, 6, 0, 0, NULL, 0, N'Motivé', N'timide', N'<p>expert en java</p>')
SET IDENTITY_INSERT [RH].[InterviewMark] OFF
SET IDENTITY_INSERT [RH].[EvaluationCriteriaTheme] ON
INSERT INTO [RH].[EvaluationCriteriaTheme] ([Id], [Label], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (2, N'COMMUNICATION', NULL, 0, NULL)
INSERT INTO [RH].[EvaluationCriteriaTheme] ([Id], [Label], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (3, N'FIRST_IMPRESSION', NULL, 0, NULL)
INSERT INTO [RH].[EvaluationCriteriaTheme] ([Id], [Label], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (4, N'COMPANY_APPROACH', NULL, 0, NULL)
INSERT INTO [RH].[EvaluationCriteriaTheme] ([Id], [Label], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (5, N'BEHAVIOR', NULL, 0, NULL)
SET IDENTITY_INSERT [RH].[EvaluationCriteriaTheme] OFF
SET IDENTITY_INSERT [RH].[EvaluationCriteria] ON
INSERT INTO [RH].[EvaluationCriteria] ([Id], [Label], [IdEvaluationCriteriaTheme], [Code], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (3, N'POLITENESS', 3, N'0', NULL, 0, NULL)
INSERT INTO [RH].[EvaluationCriteria] ([Id], [Label], [IdEvaluationCriteriaTheme], [Code], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (4, N'SMILE', 3, N'0', NULL, 0, NULL)
INSERT INTO [RH].[EvaluationCriteria] ([Id], [Label], [IdEvaluationCriteriaTheme], [Code], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (5, N'PRESENTATION', 3, N'0', NULL, 0, NULL)
INSERT INTO [RH].[EvaluationCriteria] ([Id], [Label], [IdEvaluationCriteriaTheme], [Code], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (7, N'PUNCTUALITY', 3, N'0', NULL, 0, NULL)
INSERT INTO [RH].[EvaluationCriteria] ([Id], [Label], [IdEvaluationCriteriaTheme], [Code], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (8, N'LISTENING_ABILITY', 2, N'0', NULL, 0, NULL)
INSERT INTO [RH].[EvaluationCriteria] ([Id], [Label], [IdEvaluationCriteriaTheme], [Code], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9, N'MOTIVATION', 2, N'0', NULL, 0, NULL)
INSERT INTO [RH].[EvaluationCriteria] ([Id], [Label], [IdEvaluationCriteriaTheme], [Code], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (10, N'POST_PRESENTATION', 4, N'0', NULL, 0, NULL)
INSERT INTO [RH].[EvaluationCriteria] ([Id], [Label], [IdEvaluationCriteriaTheme], [Code], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (11, N'COMPANY_KNOWLEDGE', 4, N'0', NULL, 0, NULL)
SET IDENTITY_INSERT [RH].[EvaluationCriteria] OFF
SET IDENTITY_INSERT [RH].[CriteriaMark] ON
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (4, 0, 8, 78, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (5, 0, 9, 78, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (6, 0, 3, 78, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (7, 0, 4, 78, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (8, 0, 5, 78, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9, 0, 7, 78, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (10, 0, 10, 78, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (11, 0, 11, 78, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (12, 0, 8, 79, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (13, 0, 9, 79, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (14, 0, 3, 79, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (15, 0, 4, 79, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (16, 0, 5, 79, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (17, 0, 7, 79, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (18, 0, 10, 79, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (19, 0, 11, 79, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (20, 0, 8, 80, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (21, 0, 9, 80, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (22, 0, 3, 80, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (23, 0, 4, 80, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (24, 0, 5, 80, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (25, 0, 7, 80, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (26, 0, 10, 80, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (27, 0, 11, 80, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (28, 0, 8, 81, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (29, 0, 9, 81, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (30, 0, 3, 81, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (31, 0, 4, 81, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (32, 0, 5, 81, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (33, 0, 7, 81, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (34, 0, 10, 81, 0, 0, NULL)
INSERT INTO [RH].[CriteriaMark] ([Id], [Mark], [IdEvaluationCriteria], [IdInterviewMark], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (35, 0, 11, 81, 0, 0, NULL)
SET IDENTITY_INSERT [RH].[CriteriaMark] OFF
COMMIT TRANSACTION

-- Imen chaaben user with admin role

BEGIN TRANSACTION

SET IDENTITY_INSERT [ERPSettings].[User] ON

INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee]) VALUES (6, N'Imen', N'Chaaben', NULL, N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, NULL, NULL, NULL, N'ichaaben@spark-it.fr', NULL, NULL, 0, 0, NULL, NULL, N'fr', 42)

SET IDENTITY_INSERT [ERPSettings].[User] OFF

SET IDENTITY_INSERT [ERPSettings].[UserRole] ON

INSERT INTO [ERPSettings].[UserRole] ([Id], [IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (6, 1, 6, 0, 0, NULL)

SET IDENTITY_INSERT [ERPSettings].[UserRole] OFF

COMMIT TRANSACTION

-- Mohamed BOUZIDI user with admin role

BEGIN TRANSACTION

SET IDENTITY_INSERT [ERPSettings].[User] ON

INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee]) VALUES (7, N'Mohamed', N'BOUZIDI', NULL, N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, NULL, NULL, NULL, N'mbouzidi@spark-it.fr', NULL, NULL, 0, 0, NULL, NULL, N'fr', 39)

SET IDENTITY_INSERT [ERPSettings].[User] OFF

SET IDENTITY_INSERT [ERPSettings].[UserRole] ON

INSERT INTO [ERPSettings].[UserRole] ([Id], [IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (7, 1, 7, 0, 0, NULL)

SET IDENTITY_INSERT [ERPSettings].[UserRole] OFF

COMMIT TRANSACTION
------Kossi add some test data for recruitment process

BEGIN TRANSACTION

SET IDENTITY_INSERT [RH].[Recruitment] ON
INSERT INTO [RH].[Recruitment] ([Id], [YearOfExperience], [WorkingHoursPerDays], [Priority], [Description], [State], [CreationDate], [ClosingDate], [IdQualificationType], [IdJob], [IdEmployeeAuthor], [IdEmployeeValidator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (6, 2, 2, 3, N'ddd', 7, '20190424', NULL, 3, 1, 7, 7, 0, 0, NULL)
SET IDENTITY_INSERT [RH].[Recruitment] OFF

SET IDENTITY_INSERT [RH].[Candidate] ON
INSERT INTO [RH].[Candidate] ([Id], [Sex], [FirstName], [LastName], [Email], [CIN], [IsForeign], [IdEmployee], [IsDeleted], [TransactionUserId], [Deleted_Token], [LinkedIn]) VALUES (4, 1, N'kossi', N'kossi', N'lpss@live.fr', N'', 0, NULL, 0, 0, NULL, N'')
INSERT INTO [RH].[Candidate] ([Id], [Sex], [FirstName], [LastName], [Email], [CIN], [IsForeign], [IdEmployee], [IsDeleted], [TransactionUserId], [Deleted_Token], [LinkedIn]) VALUES (5, 1, N'narcisse', N'narcisse', N'narcisse@live.fr', N'', 0, NULL, 0, 0, NULL, N'')
INSERT INTO [RH].[Candidate] ([Id], [Sex], [FirstName], [LastName], [Email], [CIN], [IsForeign], [IdEmployee], [IsDeleted], [TransactionUserId], [Deleted_Token], [LinkedIn]) VALUES (6, 2, N'donia', N'donia', N'donia@live.fr', N'', 0, NULL, 0, 0, NULL, N'')
INSERT INTO [RH].[Candidate] ([Id], [Sex], [FirstName], [LastName], [Email], [CIN], [IsForeign], [IdEmployee], [IsDeleted], [TransactionUserId], [Deleted_Token], [LinkedIn]) VALUES (7, 1, N'mhd', N'mhd', N'mhd@live.fr', N'', 0, NULL, 0, 0, NULL, N'')
SET IDENTITY_INSERT [RH].[Candidate] OFF

SET IDENTITY_INSERT [RH].[Candidacy] ON
INSERT INTO [RH].[Candidacy] ([Id], [State], [IdRecruitment], [IdCandidate], [TransactionUserId], [IsDeleted], [Deleted_Token], [CreationDate], [DepositDate]) VALUES (6, 6, 6, 4, 0, 0, NULL, '20190424 17:59:27.980', '20190426 00:00:00.000')
INSERT INTO [RH].[Candidacy] ([Id], [State], [IdRecruitment], [IdCandidate], [TransactionUserId], [IsDeleted], [Deleted_Token], [CreationDate], [DepositDate]) VALUES (7, 6, 6, 5, 0, 0, NULL, '20190424 17:59:34.817', '20190425 00:00:00.000')
INSERT INTO [RH].[Candidacy] ([Id], [State], [IdRecruitment], [IdCandidate], [TransactionUserId], [IsDeleted], [Deleted_Token], [CreationDate], [DepositDate]) VALUES (8, 6, 6, 6, 0, 0, NULL, '20190424 17:59:41.793', '20190425 00:00:00.000')
INSERT INTO [RH].[Candidacy] ([Id], [State], [IdRecruitment], [IdCandidate], [TransactionUserId], [IsDeleted], [Deleted_Token], [CreationDate], [DepositDate]) VALUES (9, 7, 6, 7, 0, 0, NULL, '20190424 17:59:47.550', '20190426 00:00:00.000')
SET IDENTITY_INSERT [RH].[Candidacy] OFF


INSERT INTO [RH].[InterviewType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'RH', N'RH', 0, 0, NULL)
INSERT INTO [RH].[InterviewType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Technique', N'Technique', 0, 0, NULL)
INSERT INTO [RH].[InterviewType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Fonctionnel', N'Fonctionnel', 0, 0, NULL)
INSERT INTO [RH].[InterviewType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'Psychotechnique', N'Psychotechnique', 0, 0, NULL)

SET IDENTITY_INSERT [RH].[Interview] ON
INSERT INTO [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token], [IdEmail]) VALUES (21, 15, '20190424 18:00:22.980', '20190424 08:08:00.000', NULL, 1, 1, 6, 0, 0, NULL, NULL)
INSERT INTO [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token], [IdEmail]) VALUES (22, 13, '20190424 18:00:45.027', '20190425 08:09:00.000', NULL, 1, 2, 7, 0, 0, NULL, NULL)
INSERT INTO [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token], [IdEmail]) VALUES (23, 12, '20190424 18:00:58.110', '20190425 08:02:00.000', NULL, 1, 3, 6, 0, 0, NULL, NULL)
INSERT INTO [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token], [IdEmail]) VALUES (24, 16, '20190424 18:01:11.273', '20190404 02:03:00.000', NULL, 1, 4, 7, 0, 0, NULL, NULL)
INSERT INTO [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token], [IdEmail]) VALUES (25, 12, '20190424 18:01:25.283', '20190426 06:06:00.000', NULL, 2, 1, 8, 0, 0, NULL, NULL)
INSERT INTO [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token], [IdEmail]) VALUES (26, 11, '20190424 18:01:40.643', '20190425 08:12:00.000', NULL, 1, 4, 9, 0, 0, NULL, NULL)
INSERT INTO [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token], [IdEmail]) VALUES (27, 10, '20190424 18:01:56.293', '20190418 09:06:00.000', NULL, 1, 2, 9, 0, 0, NULL, NULL)
INSERT INTO [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token], [IdEmail]) VALUES (28, 18, '20190424 18:02:12.130', '20190425 12:12:00.000', NULL, 1, 4, 8, 0, 0, NULL, NULL)
INSERT INTO [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token], [IdEmail]) VALUES (29, 15, '20190424 18:02:22.883', '20190419 04:12:00.000', NULL, 1, 1, 8, 0, 0, NULL, NULL)
INSERT INTO [RH].[Interview] ([Id], [AverageMark], [CreationDate], [InterviewDate], [Remarks], [Status], [IdInterviewType], [IdCandidacy], [TransactionUserId], [IsDeleted], [Deleted_Token], [IdEmail]) VALUES (30, 18, '20190424 18:02:37.937', '20190418 08:09:00.000', NULL, 1, 3, 6, 0, 0, NULL, NULL)
SET IDENTITY_INSERT [RH].[Interview] OFF

SET IDENTITY_INSERT [RH].[InterviewMark] ON
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (82, 15, 1, 1, 20, 29, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (83, 15, 1, 1, 21, 30, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (84, 15, 1, 1, 22, 27, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (85, 15, 0, 1, 23, 27, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (86, 15, 1, 2, 24, 26, 0, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (87, 15, 1, 2, 25, 26, 0, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (88, 15, 0, 1, 26, 25, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (89, 15, 0, 1, 27, 24, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (90, 15, 0, 1, 28, 24, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (91, 15, 1, 2, 29, 23, 0, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (92, 15, 1, 1, 30, 23, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (93, 15, 1, 1, 31, 28, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (94, 15, 1, 2, 32, 25, 0, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (95, 15, 0, 2, 33, 21, 0, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (96, 15, 1, 2, 34, 22, 0, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (97, 15, 0, 2, 35, 22, 0, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [RH].[InterviewMark] ([Id], [Mark], [IsRequired], [Status], [IdEmployee], [IdInterview], [TransactionUserId], [IsDeleted], [Deleted_Token], [InterviewerDecision], [StrongPoints], [Weaknesses], [OtherInformations]) VALUES (98, 15, 0, 2, 36, 21, 0, 0, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [RH].[InterviewMark] OFF


COMMIT TRANSACTION

-- Narcisse: Add period and hour some test data

BEGIN TRANSACTION
ALTER TABLE [Shared].[DayOff] DROP CONSTRAINT [FK_DayOff_Period]
ALTER TABLE [Shared].[Hours] DROP CONSTRAINT [FK_Hours_Period]
SET IDENTITY_INSERT [Shared].[Period] ON
INSERT INTO [Shared].[Period] ([Id], [Label], [StartDate], [EndDate], [FirstDayOfWork], [LastDayOfWork], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Printemps 2019', '20190320', '20190505', 1, 5, 0, 0, NULL)
INSERT INTO [Shared].[Period] ([Id], [Label], [StartDate], [EndDate], [FirstDayOfWork], [LastDayOfWork], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Ramadan', '20190506', '20190604', 1, 5, 0, 0, NULL)
INSERT INTO [Shared].[Period] ([Id], [Label], [StartDate], [EndDate], [FirstDayOfWork], [LastDayOfWork], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Ete 2019', '20190605', '20190922', 1, 5, 0, 0, NULL)
INSERT INTO [Shared].[Period] ([Id], [Label], [StartDate], [EndDate], [FirstDayOfWork], [LastDayOfWork], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'Hiver 2019', '20180922', '20190319', 1, 5, 0, 0, NULL)
SET IDENTITY_INSERT [Shared].[Period] OFF
INSERT INTO [Shared].[Hours] ( [Label], [StartTime], [EndTime], [IdPeriod], [IsDeleted], [TransactionUserId], [Deleted_Token], [WorkTimeTable]) VALUES ( N'Matin', '08:00:00.0000000', '11:30:00.0000000', 1, 0, 0, NULL, 1)
INSERT INTO [Shared].[Hours] ( [Label], [StartTime], [EndTime], [IdPeriod], [IsDeleted], [TransactionUserId], [Deleted_Token], [WorkTimeTable]) VALUES ( N'Pause déjeuner', '11:30:00.0000000', '13:00:00.0000000', 1, 0, 0, NULL, 0)
INSERT INTO [Shared].[Hours] ( [Label], [StartTime], [EndTime], [IdPeriod], [IsDeleted], [TransactionUserId], [Deleted_Token], [WorkTimeTable]) VALUES ( N'Après-midi', '13:00:00.0000000', '17:00:00.0000000', 1, 0, 0, NULL, 1)

INSERT INTO [Shared].[Hours] ( [Label], [StartTime], [EndTime], [IdPeriod], [IsDeleted], [TransactionUserId], [Deleted_Token], [WorkTimeTable]) VALUES ( N'Matin', '08:00:00.0000000', '12:00:00.0000000', 2, 0, 0, NULL, 1)
INSERT INTO [Shared].[Hours] ( [Label], [StartTime], [EndTime], [IdPeriod], [IsDeleted], [TransactionUserId], [Deleted_Token], [WorkTimeTable]) VALUES ( N'Pause', '12:00:00.0000000', '12:30:00.0000000', 2, 0, 0, NULL, 0)
INSERT INTO [Shared].[Hours] ( [Label], [StartTime], [EndTime], [IdPeriod], [IsDeleted], [TransactionUserId], [Deleted_Token], [WorkTimeTable]) VALUES ( N'Après-midi', '12:30:00.0000000', '16:00:00.0000000', 2, 0, 0, NULL, 1)

INSERT INTO [Shared].[Hours] ( [Label], [StartTime], [EndTime], [IdPeriod], [IsDeleted], [TransactionUserId], [Deleted_Token], [WorkTimeTable]) VALUES ( N'Matin', '08:00:00.0000000', '11:30:00.0000000', 3, 0, 0, NULL, 1)
INSERT INTO [Shared].[Hours] ( [Label], [StartTime], [EndTime], [IdPeriod], [IsDeleted], [TransactionUserId], [Deleted_Token], [WorkTimeTable]) VALUES ( N'Pause', '11:30:00.0000000', '13:00:00.0000000', 3, 0, 0, NULL, 0)
INSERT INTO [Shared].[Hours] ( [Label], [StartTime], [EndTime], [IdPeriod], [IsDeleted], [TransactionUserId], [Deleted_Token], [WorkTimeTable]) VALUES ( N'Après-midi', '13:00:00.0000000', '17:00:00.0000000', 3, 0, 0, NULL, 1)

INSERT INTO [Shared].[Hours] ( [Label], [StartTime], [EndTime], [IdPeriod], [IsDeleted], [TransactionUserId], [Deleted_Token], [WorkTimeTable]) VALUES ( N'Matin', '08:45:00.0000000', '12:30:00.0000000', 4, 0, 0, NULL, 1)
INSERT INTO [Shared].[Hours] ( [Label], [StartTime], [EndTime], [IdPeriod], [IsDeleted], [TransactionUserId], [Deleted_Token], [WorkTimeTable]) VALUES ( N'Pause', '12:45:00.0000000', '14:00:00.0000000', 4, 0, 0, NULL, 0)
INSERT INTO [Shared].[Hours] ( [Label], [StartTime], [EndTime], [IdPeriod], [IsDeleted], [TransactionUserId], [Deleted_Token], [WorkTimeTable]) VALUES ( N'Après-midi', '14:00:00.0000000', '18:00:00.0000000', 4, 0, 0, NULL, 1)

INSERT INTO [Shared].[DayOff] ( [Label], [Date], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdPeriod]) VALUES ( N'Fête des travailleurs', '20190501', 0, 0, NULL, 1)
INSERT INTO [Shared].[DayOff] ( [Label], [Date], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdPeriod]) VALUES ( N'Fête de l''indépendance', '20190320', 0, 0, NULL, 1)

ALTER TABLE [Shared].[DayOff]
    ADD CONSTRAINT [FK_DayOff_Period] FOREIGN KEY ([IdPeriod]) REFERENCES [Shared].[Period] ([Id])
ALTER TABLE [Shared].[Hours]
    ADD CONSTRAINT [FK_Hours_Period] FOREIGN KEY ([IdPeriod]) REFERENCES [Shared].[Period] ([Id])
COMMIT TRANSACTION

-- Imen chaaben: user role
BEGIN TRANSACTION
UPDATE [ERPSettings].[UserRole] SET [IdRole]=1 WHERE [Id]=4
UPDATE [Payroll].[Employee] SET [IdUpperHierarchy]=32 WHERE [Id]=8
UPDATE [Payroll].[Employee] SET [IdUpperHierarchy]=32 WHERE [Id]=42
UPDATE [Payroll].[Employee] SET [IdUpperHierarchy]=7 WHERE [Id]=32
COMMIT TRANSACTION

--Rabeb Ben Salah: add evaluation criteria data
BEGIN TRANSACTION
ALTER TABLE [RH].[EvaluationCriteria] DROP CONSTRAINT [FK_EvaluationCriteria_EvaluationCriteriaTheme]
SET IDENTITY_INSERT [RH].[EvaluationCriteria] ON
INSERT INTO [RH].[EvaluationCriteria] ([Id], [Label], [IdEvaluationCriteriaTheme], [Code], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (14, N'CALM', 5, N'0', NULL, 0, NULL)
INSERT INTO [RH].[EvaluationCriteria] ([Id], [Label], [IdEvaluationCriteriaTheme], [Code], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (15, N'SERIOUSNESS', 5, N'0', NULL, 0, NULL)
INSERT INTO [RH].[EvaluationCriteria] ([Id], [Label], [IdEvaluationCriteriaTheme], [Code], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (16, N'SYMPATHY', 5, N'0', NULL, 0, NULL)
INSERT INTO [RH].[EvaluationCriteria] ([Id], [Label], [IdEvaluationCriteriaTheme], [Code], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (17, N'POSTURE', 5, N'0', NULL, 0, NULL)
SET IDENTITY_INSERT [RH].[EvaluationCriteria] OFF
ALTER TABLE [RH].[EvaluationCriteria]
    ADD CONSTRAINT [FK_EvaluationCriteria_EvaluationCriteriaTheme] FOREIGN KEY ([IdEvaluationCriteriaTheme]) REFERENCES [RH].[EvaluationCriteriaTheme] ([Id])
COMMIT TRANSACTION 

--- Marwa : change codification of warehouse ---
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
UPDATE [ERPSettings].[Codification] SET [LastCounterValue]=N'0019' WHERE [Id]=40
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
COMMIT TRANSACTION

--Imen chaaben: add documentRequestType
BEGIN TRANSACTION
SET IDENTITY_INSERT [Payroll].[DocumentRequestType] ON
INSERT INTO [Payroll].[DocumentRequestType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'bulletin de paie ', N'bulletin de paie ', 0, 0, NULL)
INSERT INTO [Payroll].[DocumentRequestType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Attestation de travail', N'Attestation de travail', 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[DocumentRequestType] OFF
COMMIT TRANSACTION

-- Mohamed BOUZIDI Add ADMIN-BUT-CONTRACT role

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[UserRole] DROP CONSTRAINT [FK_UserRole_Role]
ALTER TABLE [ERPSettings].[UserRole] DROP CONSTRAINT [FK_UserRole_User]


DELETE FROM [ERPSettings].[UserRole] WHERE [Id]=7

SET IDENTITY_INSERT [ERPSettings].[Role] ON
INSERT INTO [ERPSettings].[Role] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token]) VALUES (5, N'ADMIN-BUT-CONTRACT', N'Administrateur sauf contrat', 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[Role] OFF

SET IDENTITY_INSERT [ERPSettings].[UserRole] ON
INSERT INTO [ERPSettings].[UserRole] ([Id], [IdRole], [IdUser], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (8, 5, 7, 0, 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[UserRole] OFF

ALTER TABLE [ERPSettings].[UserRole]
    ADD CONSTRAINT [FK_UserRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[UserRole]
    ADD CONSTRAINT [FK_UserRole_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE
COMMIT TRANSACTION

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[ReportTemplate] DROP CONSTRAINT [FK_ReportTemplate_Entity]
SET IDENTITY_INSERT [ERPSettings].[ReportTemplate] ON
INSERT INTO [ERPSettings].[ReportTemplate] ([Id], [IdEntity], [TemplateCode], [TemplateNameFr], [TemplateNameEn]) VALUES (1, 87, N'DocumentSparkFr', N' document Fr', N'Document Fr1')
INSERT INTO [ERPSettings].[ReportTemplate] ([Id], [IdEntity], [TemplateCode], [TemplateNameFr], [TemplateNameEn]) VALUES (2, 87, N'DocumentSparkFr+', N' document Fr +', N'Document Fr +1')
INSERT INTO [ERPSettings].[ReportTemplate] ([Id], [IdEntity], [TemplateCode], [TemplateNameFr], [TemplateNameEn]) VALUES (3, 87, N'DocumentSparkEn', N' document En', N'Document En1')
INSERT INTO [ERPSettings].[ReportTemplate] ([Id], [IdEntity], [TemplateCode], [TemplateNameFr], [TemplateNameEn]) VALUES (4, 87, N'DocumentSparkEn+', N' document En +', N'Document En +1')
SET IDENTITY_INSERT [ERPSettings].[ReportTemplate] OFF
ALTER TABLE [ERPSettings].[ReportTemplate]
    ADD CONSTRAINT [FK_ReportTemplate_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
COMMIT TRANSACTION

--- Kossi add some test data

BEGIN TRANSACTION

ALTER TABLE [RH].[Review] DROP CONSTRAINT [FK_Review_Employee_Collaborator]
ALTER TABLE [RH].[Formation] DROP CONSTRAINT [FK_Formation_FormationType]

SET IDENTITY_INSERT [RH].[FormationType] ON

INSERT INTO [RH].[FormationType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Technique', N'Technique', 0, 0, NULL)

SET IDENTITY_INSERT [RH].[FormationType] OFF

SET IDENTITY_INSERT [RH].[Review] ON

INSERT INTO [RH].[Review] ([Id], [ReviewDate], [State], [IdEmployeeCollaborator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (1, '20180406', 3, 32, NULL, 0, NULL)

SET IDENTITY_INSERT [RH].[Review] OFF

SET IDENTITY_INSERT [RH].[Formation] ON

INSERT INTO [RH].[Formation] ([Id], [Label], [Description], [TransactionUserId], [IsDeleted], [Deleted_Token], [IdFormationType]) VALUES (1, N'Java', N'Maitriser java', NULL, 0, NULL, 1)

INSERT INTO [RH].[Formation] ([Id], [Label], [Description], [TransactionUserId], [IsDeleted], [Deleted_Token], [IdFormationType]) VALUES (2, N'C#', N'Maitriser C#', NULL, 0, NULL, 1)

INSERT INTO [RH].[Formation] ([Id], [Label], [Description], [TransactionUserId], [IsDeleted], [Deleted_Token], [IdFormationType]) VALUES (3, N'PHP', N'Maitriser PHP', NULL, 0, NULL, 1)

INSERT INTO [RH].[Formation] ([Id], [Label], [Description], [TransactionUserId], [IsDeleted], [Deleted_Token], [IdFormationType]) VALUES (4, N'BI', N'Maitriser BI', NULL, 0, NULL, 1)

SET IDENTITY_INSERT [RH].[Formation] OFF

ALTER TABLE [RH].[Review]

    ADD CONSTRAINT [FK_Review_Employee_Collaborator] FOREIGN KEY ([IdEmployeeCollaborator]) REFERENCES [Payroll].[Employee] ([Id])

ALTER TABLE [RH].[Formation]

    WITH NOCHECK ADD CONSTRAINT [FK_Formation_FormationType] FOREIGN KEY ([IdFormationType]) REFERENCES [RH].[FormationType] ([Id])

COMMIT TRANSACTION

--Rabeb: update InterviewType table data 

BEGIN TRANSACTION
UPDATE [RH].[InterviewType] SET [Code]=N'HR' WHERE [Id]=1
UPDATE [RH].[InterviewType] SET [Code]=N'TECHNICAL' WHERE [Id]=2
UPDATE [RH].[InterviewType] SET [Code]=N'FUNCTIONAL' WHERE [Id]=3
UPDATE [RH].[InterviewType] SET [Code]=N'PSYCHOTECHNICAL' WHERE [Id]=4
COMMIT TRANSACTION

--Yasmine: insert data into DeliveryType table

INSERT INTO [Sales].[DeliveryType] ([Code], [Label], [IsDeleted], [Deleted_Token]) VALUES ('001', 'Transporteur', 0, NULL)
INSERT INTO [Sales].[DeliveryType] ([Code], [Label], [IsDeleted], [Deleted_Token]) VALUES ('002', 'Comptoir', 0, NULL)
INSERT INTO [Sales].[DeliveryType] ([Code], [Label], [IsDeleted], [Deleted_Token]) VALUES ('003', 'Louage', 0, NULL)
INSERT INTO [Sales].[DeliveryType] ([Code], [Label], [IsDeleted], [Deleted_Token]) VALUES ('004', 'Avec nous', 0, NULL)

--- Imen chaaben: Update [PaymentMethod] CHQ and TRT [Immediate] to false

BEGIN TRANSACTION
UPDATE [Payment].[PaymentMethod] SET [Immediate]=0 WHERE [Id]=4
UPDATE [Payment].[PaymentMethod] SET [Immediate]=0 WHERE [Id]=5
COMMIT TRANSACTION
