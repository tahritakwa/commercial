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
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_Job]
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_Employee]
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_SalaryStructure]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_City]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Country]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Grade]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Team]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_UpperHierarchy]

BEGIN TRANSACTION
SET IDENTITY_INSERT [Payroll].[Cnss] ON
INSERT INTO [Payroll].[Cnss] ([Id], [Label], [EmployerRate], [SalaryRate], [WorkAccidentQuota], [OperatingCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'NORMAL', 16.21, 9.18, 10, N'XXXXO', 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[Cnss] OFF
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
SET IDENTITY_INSERT [Payroll].[TypeIdentityPieces] ON
INSERT INTO [Payroll].[TypeIdentityPieces] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'CIN', N'Carte d''identité nationale', 0, 0, NULL)
INSERT INTO [Payroll].[TypeIdentityPieces] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'PASSEPORT', N'Passeport', 0, 0, NULL)
INSERT INTO [Payroll].[TypeIdentityPieces] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'PERMIS', N'Permis de conduire', 0, 0, NULL)
INSERT INTO [Payroll].[TypeIdentityPieces] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'Autre', N'Autre types de pièce d''identité', 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[TypeIdentityPieces] OFF

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
INSERT INTO [Payroll].[Job] ([Id], [Designation], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Développeur .NET Core', N'Développeur de moins de 2 ans d''expérience', 0, 0, NULL)
INSERT INTO [Payroll].[Job] ([Id], [Designation], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Testeur', N'Testeur de logiciels ', 0, 0, NULL)
INSERT INTO [Payroll].[Job] ([Id], [Designation], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1003, N'Consultant', N'Consultant à l''internationnal', 0, 0, NULL)
INSERT INTO [Payroll].[Job] ([Id], [Designation], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1004, N'Ingenieur', N'Ingénieur spécialiste', 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[Job] OFF

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
    ADD CONSTRAINT [FK_EmployeeSkills_Skills] FOREIGN KEY ([IdSkills]) REFERENCES [Payroll].[Skills] ([Id])
ALTER TABLE [Payroll].[EmployeeSkills]
    ADD CONSTRAINT [FK_EmployeeSkills_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
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
    WITH NOCHECK ADD CONSTRAINT [FK_Contract_Job] FOREIGN KEY ([IdJob]) REFERENCES [Payroll].[Job] ([Id])
ALTER TABLE [Payroll].[Contract]
    ADD CONSTRAINT [FK_Contract_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
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

-- Kossi add leaveType data


BEGIN TRANSACTION
SET IDENTITY_INSERT [Payroll].[LeaveType] ON
INSERT INTO [Payroll].[LeaveType] ([Id], [Code], [IsPayed], [OvertakeAuthorized], [IsDeleted], [TransactionUserId], [Deleted_Token], [Label]) VALUES (2, N'MATERNITE', 1, 0, 0, NULL, NULL, N'Maternité')
INSERT INTO [Payroll].[LeaveType] ([Id], [Code], [IsPayed], [OvertakeAuthorized], [IsDeleted], [TransactionUserId], [Deleted_Token], [Label]) VALUES (3, N'ACCIDENT_DU_TRAVAIL', 1, 0, 0, NULL, NULL, N'Accident de travail')
INSERT INTO [Payroll].[LeaveType] ([Id], [Code], [IsPayed], [OvertakeAuthorized], [IsDeleted], [TransactionUserId], [Deleted_Token], [Label]) VALUES (5, N'EVEN_FAMILIAL', 1, 0, 0, NULL, NULL, N'Evènement familial')
INSERT INTO [Payroll].[LeaveType] ([Id], [Code], [IsPayed], [OvertakeAuthorized], [IsDeleted], [TransactionUserId], [Deleted_Token], [Label]) VALUES (6, N'SANS_SOLDE', 0, 0, 0, NULL, NULL, N'Sans solde')
INSERT INTO [Payroll].[LeaveType] ([Id], [Code], [IsPayed], [OvertakeAuthorized], [IsDeleted], [TransactionUserId], [Deleted_Token], [Label]) VALUES (9, N'CERTIFICATION_EXAM', 1, 0, 0, NULL, NULL, N'Certification')
INSERT INTO [Payroll].[LeaveType] ([Id], [Code], [IsPayed], [OvertakeAuthorized], [IsDeleted], [TransactionUserId], [Deleted_Token], [Label]) VALUES (10, N'PATERNITE', 0, 0, 0, NULL, NULL, N'Paternité')
INSERT INTO [Payroll].[LeaveType] ([Id], [Code], [IsPayed], [OvertakeAuthorized], [IsDeleted], [TransactionUserId], [Deleted_Token], [Label]) VALUES (11, N'INTERVIEW', 0, 0, 0, NULL, NULL, N'Interview')
INSERT INTO [Payroll].[LeaveType] ([Id], [Code], [IsPayed], [OvertakeAuthorized], [IsDeleted], [TransactionUserId], [Deleted_Token], [Label]) VALUES (12, N'VISA', 1, 1, 1, NULL, NULL, N'Visa')
INSERT INTO [Payroll].[LeaveType] ([Id], [Code], [IsPayed], [OvertakeAuthorized], [IsDeleted], [TransactionUserId], [Deleted_Token], [Label]) VALUES (13, N'VACCANCES_ANNUELLES', 1, 1, 1, NULL, NULL, N'Vaccances annuelles')
INSERT INTO [Payroll].[LeaveType] ([Id], [Code], [IsPayed], [OvertakeAuthorized], [IsDeleted], [TransactionUserId], [Deleted_Token], [Label]) VALUES (14, N'PASSAGE_CLIENT', 1, 1, 1, NULL, NULL, N'Passage chez le client')
SET IDENTITY_INSERT [Payroll].[LeaveType] OFF
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
BEGIN TRANSACTION
ALTER TABLE [Payroll].[Variable] DROP CONSTRAINT [FK_Variable_RuleUnique]
UPDATE [Payroll].[Variable] SET [Formule]=N'Si (Employee.FamilyLeader)
    Alors Employee.ChildrenNumber * 100
Sinon 0
Finsi' WHERE [Description] LIKE 'Réduction sur le nombre d''enfants'
ALTER TABLE [Payroll].[Variable]
    ADD CONSTRAINT [FK_Variable_RuleUnique] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
COMMIT TRANSACTION
