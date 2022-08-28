/*
This script was created by Visual Studio on 17/05/2018 at 16:09.
Run this script on ..MasterTEST (SPARKIT\ngagoba-stg) to make it the same as ..MasterGUID (ngagoba).
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
ALTER TABLE [Administration].[AxisValueRelationShip] DROP CONSTRAINT [FK_AxisValueRelationShip_AxisValue]
ALTER TABLE [Administration].[AxisValueRelationShip] DROP CONSTRAINT [FK__AxisRelat__IdAxi__6A3191A0]
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [FK_GridOptions_GridComponent]
ALTER TABLE [Payroll].[ConstantRateValidityPeriod] DROP CONSTRAINT [FK_ConstantRate_ValidityPeriod]
ALTER TABLE [Payroll].[Variable] DROP CONSTRAINT [FK_Variable_RuleUnique]
ALTER TABLE [ERPSettings].[ReportParameters] DROP CONSTRAINT [FK_ReportViewerParameters_ReportViewerComponent]
ALTER TABLE [Sales].[DocumentTypeRelation] DROP CONSTRAINT [FK_DocumentTypeRelation_DocumentTypeRelation]
ALTER TABLE [Sales].[DocumentTypeRelation] DROP CONSTRAINT [FK_DocumentTypeRelation_DocumentType]
ALTER TABLE [Sales].[DocumentType] DROP CONSTRAINT [FK_DocumentType_DocumentType]
ALTER TABLE [Sales].[PurchaseSettings] DROP CONSTRAINT [FK_PurchaseSetting_Company]
ALTER TABLE [ERPSettings].[ToolBarItem] DROP CONSTRAINT [FK_ToolBarItemToolBarOptions]
ALTER TABLE [ERPSettings].[ToolBarOptions] DROP CONSTRAINT [FK_ToolBarOptionsToolbarComponent]
ALTER TABLE [ERPSettings].[ToolBarComponent] DROP CONSTRAINT [FK_ComponentToolbarComponent]
ALTER TABLE [ERPSettings].[Relation] DROP CONSTRAINT [FK_Relation_PredicateFormat]
ALTER TABLE [Payroll].[ConstantRate] DROP CONSTRAINT [FK_ConstantRate_RuleUniqueReference]
ALTER TABLE [ERPSettings].[OrderBy] DROP CONSTRAINT [FK_OrderBy_PredicateFormat]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[CheckBoxComponent] DROP CONSTRAINT [FK_CheckBoxComponent_Component]
ALTER TABLE [ERPSettings].[Menu] DROP CONSTRAINT [FK_Menu_Functionality]
ALTER TABLE [Payroll].[SalaryStructure_SalaryRule] DROP CONSTRAINT [FK_SalaryStructureRule_Structure]
ALTER TABLE [Payroll].[SalaryStructure_SalaryRule] DROP CONSTRAINT [FK_SalaryStructureRule_Rule]
ALTER TABLE [ERPSettings].[ReportComponent] DROP CONSTRAINT [FK_ReportViewerComponent_Component]
ALTER TABLE [Inventory].[ItemWarehouse] DROP CONSTRAINT [FK_ItemWarehouse_Warehouse]
ALTER TABLE [Inventory].[ItemWarehouse] DROP CONSTRAINT [FK_ItemWarehouse_Item]
ALTER TABLE [Stock].[StockDocumentLineSerialNumber] DROP CONSTRAINT [FK_StockDocumentSerialNumber_SerialNumber]
ALTER TABLE [Stock].[SerialNumber] DROP CONSTRAINT [FK_SerialNumber_Article1]
ALTER TABLE [Stock].[SerialNumber] DROP CONSTRAINT [FK_SerialNumber_Batch]
ALTER TABLE [Administration].[AxisRelationShip] DROP CONSTRAINT [FK_AxisRelationShip_Axis1]
ALTER TABLE [Administration].[AxisRelationShip] DROP CONSTRAINT [FK_AxisRelationShip_Axis]
ALTER TABLE [Administration].[Transfer] DROP CONSTRAINT [FK_Transfer_Entity]
ALTER TABLE [Payment].[WithholdingTaxLine] DROP CONSTRAINT [FK_WithholdingTaxLine_WithholdingTax]
ALTER TABLE [Payment].[WithholdingTaxLine] DROP CONSTRAINT [FK_WithholdingTaxLine_Payment]
ALTER TABLE [ERPSettings].[ComboBoxDataSourceItems] DROP CONSTRAINT [FK_ComboBoxDataSourceItems_ComboBoxDataSource]
ALTER TABLE [Payroll].[PayslipDetails] DROP CONSTRAINT [FK_PayslipDetails_Payslip]
ALTER TABLE [ERPSettings].[CheckBoxComponentDetails] DROP CONSTRAINT [FK_CheckBoxDetailsComponent_Component]
ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [FK_Information_RoleInfo]
ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [FK_Role_RoleInfo]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[ButtonComponent] DROP CONSTRAINT [FK_ButtonComponent_Component]
ALTER TABLE [ERPSettings].[ButtonComponent] DROP CONSTRAINT [FK_ButtonComponent_ServiceParameters]
ALTER TABLE [ERPSettings].[FormComponent] DROP CONSTRAINT [FK_FormComponent_Component]
ALTER TABLE [ERPSettings].[FormComponent] DROP CONSTRAINT [FK_FormComponent_ServiceParameters]
ALTER TABLE [ERPSettings].[ImageComponent] DROP CONSTRAINT [FK_ImageComponent_Component]
ALTER TABLE [ERPSettings].[UserInfo] DROP CONSTRAINT [FK_Info_UserInfo]
ALTER TABLE [ERPSettings].[UserInfo] DROP CONSTRAINT [FK_User_UserInfo]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
ALTER TABLE [Payroll].[ParentInCharge] DROP CONSTRAINT [FK_ParentInCharge_ParentType]
ALTER TABLE [Payroll].[ParentInCharge] DROP CONSTRAINT [FK_ParentInCharge_Employee]
ALTER TABLE [ERPSettings].[FieldSetComponent] DROP CONSTRAINT [FK_FieldSetComponent_Component]
ALTER TABLE [Inventory].[TaxeItem] DROP CONSTRAINT [FK_TaxeItem_Taxe]
ALTER TABLE [Inventory].[TaxeItem] DROP CONSTRAINT [FK_TaxeItem_Item]
ALTER TABLE [Sales].[DetailsSettlementMode] DROP CONSTRAINT [FK_DetailsSettlementMode_SettlementType]
ALTER TABLE [Sales].[DetailsSettlementMode] DROP CONSTRAINT [FK_DetailsSettlementMode_PaymentMethod]
ALTER TABLE [Sales].[DetailsSettlementMode] DROP CONSTRAINT [FK_DetailsSettlementMode_SettlementMode]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[InputDatePickerOptions] DROP CONSTRAINT [FK_InputDatePickerOptions_InputComponent]
ALTER TABLE [Administration].[CurrencyRate] DROP CONSTRAINT [FK_CurrencyRate_Currency]
ALTER TABLE [Administration].[AxisEntity] DROP CONSTRAINT [FK_AxisEntity_Entity]
ALTER TABLE [Administration].[AxisEntity] DROP CONSTRAINT [FK__AxisEntit__IdAxi__72C6D7A1]
ALTER TABLE [Inventory].[StockDocument] DROP CONSTRAINT [FK_StockDocument_Warehouse]
ALTER TABLE [Inventory].[StockDocument] DROP CONSTRAINT [FK_StockDocument_Warehouse1]
ALTER TABLE [Inventory].[StockDocument] DROP CONSTRAINT [FK_StockDocument_TypeStockDocument]
ALTER TABLE [Inventory].[StockDocument] DROP CONSTRAINT [FK_StockDocument_DocumentStatus]
ALTER TABLE [Stock].[TypeStockCalculation] DROP CONSTRAINT [FK_TYPESTOC_ASSOCIATI_STOCKCAL]
ALTER TABLE [Stock].[Storage] DROP CONSTRAINT [FK_STORAGE_ASSOCIATI_SECTION]
ALTER TABLE [Stock].[Storage] DROP CONSTRAINT [FK_STORAGE_ASSOCIATI_ARTICLE]
ALTER TABLE [Shared].[City] DROP CONSTRAINT [FK_Ville_Pays]
ALTER TABLE [Payroll].[Leave] DROP CONSTRAINT [FK_Leave_LeaveStatus]
ALTER TABLE [Payroll].[Leave] DROP CONSTRAINT [FK_Leave_LeaveType]
ALTER TABLE [Payroll].[Leave] DROP CONSTRAINT [FK_Leave_Employee]
ALTER TABLE [ERPSettings].[ComboBoxOptions] DROP CONSTRAINT [FK_ComboBoxOptions_ComboBoxComponent]
ALTER TABLE [ERPSettings].[ComboBoxComponent] DROP CONSTRAINT [FK_ComboboxComponent_Component]
ALTER TABLE [ERPSettings].[GridColumnComponent] DROP CONSTRAINT [FK_GridColumnComponent_Component]
ALTER TABLE [Payment].[DocumentPayment] DROP CONSTRAINT [FK_DocumentPayement_Payement]


ALTER TABLE [ERPSettings].[GridButtonComponent] DROP CONSTRAINT [FK_GridButtonComponent_ServiceParameters]
ALTER TABLE [ERPSettings].[GridButtonComponent] DROP CONSTRAINT [FK_GridButtonComponent_Component]
ALTER TABLE [Payroll].[SalaryStructure] DROP CONSTRAINT [FK_SalaryStructure_SalaryStructureParent]
ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_ContributionRegister]
ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_RuleCategory]
ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_RuleType]
ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_Applicability]
ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_RuleUniqueReference]
ALTER TABLE [Sales].[SaleSettings] DROP CONSTRAINT [FK_SaleSetting_Company]
ALTER TABLE [Payroll].[Team] DROP CONSTRAINT [FK_Team_Department]
ALTER TABLE [ERPSettings].[ColumnMenuComponent] DROP CONSTRAINT [FK_ComponentColumnMenu]
ALTER TABLE [Payment].[Payment] DROP CONSTRAINT [FK_Payment_PaymentMethod]

ALTER TABLE [Payment].[Payment] DROP CONSTRAINT [FK_Payment_Tiers]
ALTER TABLE [ERPSettings].[Filter] DROP CONSTRAINT [FK_Filter_PredicateFormat]
ALTER TABLE [Payroll].[EmployeeSkills] DROP CONSTRAINT [FK_EmployeeSkills_Skills]
ALTER TABLE [Payroll].[EmployeeSkills] DROP CONSTRAINT [FK_EmployeeSkills_Employee]
ALTER TABLE [Sales].[DocumentLinePrices] DROP CONSTRAINT [FK_DocumentLinePrices_Prices]
ALTER TABLE [Sales].[DocumentLinePrices] DROP CONSTRAINT [FK_DocumentLinePrices_DocumentLine]
ALTER TABLE [ERPSettings].[ModuleByUser] DROP CONSTRAINT [FK_ModuleByUser_Module]
ALTER TABLE [ERPSettings].[ModuleByUser] DROP CONSTRAINT [FK_ModuleByUser_User]
ALTER TABLE [Payroll].[Manager] DROP CONSTRAINT [FK_Manager_Team]
ALTER TABLE [Payroll].[Manager] DROP CONSTRAINT [FK_Manager_Employee]
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [FK_ComboBoxDataSource_ComboBoxOptions]
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [FK_ComboBoxDataSource_ServiceParameters]
ALTER TABLE [Payroll].[IdentityPieces] DROP CONSTRAINT [FK_IdentityPieces_TypeIdentityPieces]
ALTER TABLE [Payroll].[IdentityPieces] DROP CONSTRAINT [FK_IdentityPieces_Employee]
ALTER TABLE [Inventory].[StockDocumentLine] DROP CONSTRAINT [FK_StockDocumentLine_Item]
ALTER TABLE [Inventory].[StockDocumentLine] DROP CONSTRAINT [FK_StockDocumentLine_StockDocument]
ALTER TABLE [Inventory].[Item] DROP CONSTRAINT [FK_Item_DiscountGroupItem]
ALTER TABLE [Inventory].[Item] DROP CONSTRAINT [FK_Item_UnitType]
ALTER TABLE [Inventory].[Item] DROP CONSTRAINT [FK_Item_UnitType1]
ALTER TABLE [Inventory].[Item] DROP CONSTRAINT [FK_Item_Nature]
ALTER TABLE [Stock].[StockCalculation] DROP CONSTRAINT [FK_STOCKCAL_ASSOCIATI_DOCUMENT]
ALTER TABLE [Shared].[ContactTypeDocument] DROP CONSTRAINT [FK_ContactTypeDocument_Contact]
ALTER TABLE [Shared].[Contact] DROP CONSTRAINT [FK_Contact_Tiers]
ALTER TABLE [ERPSettings].[BarCodeComponent] DROP CONSTRAINT [FK_BarCodeComponent_Component]
ALTER TABLE [ERPSettings].[BarCodeComponent] DROP CONSTRAINT [FK_BarCodeComponent_InputComponent]

ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions]
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_ServiceParameters]
ALTER TABLE [Treasury].[DetailReconciliation] DROP CONSTRAINT [FK_DetailReconciliation2]
ALTER TABLE [Treasury].[DetailReconciliation] DROP CONSTRAINT [FK_DetailReconciliation3]
ALTER TABLE [Treasury].[DetailReconciliation] DROP CONSTRAINT [FK_DetailReconciliation]
ALTER TABLE [Treasury].[DetailTimetable] DROP CONSTRAINT [FK_DetailTimetable_Timetable]

ALTER TABLE [ERPSettings].[DropDownListOptions] DROP CONSTRAINT [FK_DropDownListOptions_DropDownListComponent]
ALTER TABLE [ERPSettings].[DropDownListComponent] DROP CONSTRAINT [FK_DropDownListComponent_Component]
ALTER TABLE [ERPSettings].[LabelComponent] DROP CONSTRAINT [FK_LabelComponent_Component]
ALTER TABLE [ERPSettings].[InputComponent] DROP CONSTRAINT [FK_InputComponent_Component]
ALTER TABLE [Payroll].[ConstantValueValidityPeriod] DROP CONSTRAINT [FK_ConstantValueValidityPeriod_ConstantValue]
ALTER TABLE [Payroll].[ConstantValue] DROP CONSTRAINT [FK_ConstantValue_RuleUniqueReference]
ALTER TABLE [ERPSettings].[DialogComponent] DROP CONSTRAINT [FK_DialogComponent_Component]
ALTER TABLE [Administration].[EntityAxisValues] DROP CONSTRAINT [FK_EntityAxisValues_AxisValue]
ALTER TABLE [Administration].[AxisValue] DROP CONSTRAINT [FK__AxisValue__IdAxi__675524F5]
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [FK_GridDataSource_GridOptions]
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [FK_GridDataSource_ServiceParameters]
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [FK_ServiceParameters_PredicateFormat]
ALTER TABLE [Treasury].[Timetable] DROP CONSTRAINT [FK_Timetable_Tiers]
ALTER TABLE [Sales].[Prices] DROP CONSTRAINT [FK_Prices_DiscountGroupTiers]
ALTER TABLE [Sales].[Prices] DROP CONSTRAINT [FK_Prices_DiscountGroupItem]
ALTER TABLE [Sales].[Prices] DROP CONSTRAINT [FK_Prices_Item]
ALTER TABLE [Sales].[Prices] DROP CONSTRAINT [FK_Prices_Tiers]
ALTER TABLE [Sales].[Prices] DROP CONSTRAINT [FK_Prices_Currency]
ALTER TABLE [ERPSettings].[GridComponent] DROP CONSTRAINT [FK_GridComponent_Component]
ALTER TABLE [Payment].[SettlementCommitment] DROP CONSTRAINT [FK_SettlementCommitment_Settlement]
ALTER TABLE [Payment].[SettlementCommitment] DROP CONSTRAINT [FK_SettlementCommitment_FinancialCommitment]
ALTER TABLE [Sales].[FinancialCommitment] DROP CONSTRAINT [FK_FinancialCommitment_DocumentStatus]
ALTER TABLE [Sales].[FinancialCommitment] DROP CONSTRAINT [FK_FinancialCommitment_PaymentMethod]
ALTER TABLE [Sales].[FinancialCommitment] DROP CONSTRAINT [FK_FinancialCommitment_Document]
ALTER TABLE [Stock].[Article] DROP CONSTRAINT [FK_Article_StockManagementMethod]
ALTER TABLE [Stock].[Article] DROP CONSTRAINT [FK_Article_SaleManagementMethod]
ALTER TABLE [Stock].[Article] DROP CONSTRAINT [FK_Article_AccountingAccount]
ALTER TABLE [ERPSettings].[FunctionnalityByUser] DROP CONSTRAINT [FK_FunctionnalityByUser_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityByUser] DROP CONSTRAINT [FK_FunctionnalityByUser_User]
ALTER TABLE [Treasury].[ReceiptSpent] DROP CONSTRAINT [FK_ReceiptSpent_PaymentMethod]
ALTER TABLE [Treasury].[ReceiptSpent] DROP CONSTRAINT [FK_RecipeSpent_PaymentDirection]
ALTER TABLE [Treasury].[ReceiptSpent] DROP CONSTRAINT [FK_RecipeSpent_Tiers]
ALTER TABLE [Sales].[TaxeGroupTiersConfig] DROP CONSTRAINT [FK_TaxeTiersConfig_TaxeGroupTiers]
ALTER TABLE [Sales].[TaxeGroupTiersConfig] DROP CONSTRAINT [FK_TaxeTiersConfig_Taxe]
ALTER TABLE [Shared].[Taxe] DROP CONSTRAINT [FK_Taxe_TaxeType]
ALTER TABLE [Payment].[WithholdingTax] DROP CONSTRAINT [FK_WithholdingTax_Tiers]
ALTER TABLE [Payroll].[ConsultantsCustomerContract] DROP CONSTRAINT [FK_ConsultantsCustomerContract_Employee]
ALTER TABLE [Payroll].[ConsultantsCustomerContract] DROP CONSTRAINT [FK_ConsultantsCustomerContract_Prices]

ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [FK_Settlement_DocumentStatus]
ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [FK_Settlement_Currency]
ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [FK_Settlement_PaymentMethod]
ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [FK_Settlement_Tiers]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_Tiers_City]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_Tiers_Currency]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_TIERS_ASSOCIATI_PAYEMENT]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_TIERS_ASSOCIATI_TYPETIER]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_Tiers_Pays]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_Tiers_AccountingAccount]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_Tiers_TaxeGroupTiers]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_Tiers_DiscountGroupTiers]
ALTER TABLE [Stock].[StockMovement] DROP CONSTRAINT [FK_StockMovement_StockDocumentLine]
ALTER TABLE [Stock].[StockMovement] DROP CONSTRAINT [FK_StockMovement_Warehouse]
ALTER TABLE [Stock].[StockMovement] DROP CONSTRAINT [FK_StockMovement_DocumentLine]
ALTER TABLE [Stock].[StockMovement] DROP CONSTRAINT [FK_StockMovement_Item]
ALTER TABLE [Inventory].[Warehouse] DROP CONSTRAINT [FK_Warehouse_Warehouse]
ALTER TABLE [ERPSettings].[RadioButtonComponentDetails] DROP CONSTRAINT [FK_RadioButtonComponentDetails_Component]
ALTER TABLE [ERPSettings].[RadioButtonComponent] DROP CONSTRAINT [FK_RadioButtonComponent_Component]
ALTER TABLE [Payroll].[CommercialsCustomerContract] DROP CONSTRAINT [FK_CommercialsCustomerContract_Prices]
ALTER TABLE [Payroll].[CommercialsCustomerContract] DROP CONSTRAINT [FK_CommercialsCustomerContract_Employee]
ALTER TABLE [ERPSettings].[ComponentByUser] DROP CONSTRAINT [FK_ComponentByUser_User]
ALTER TABLE [ERPSettings].[ComponentByUser] DROP CONSTRAINT [FK_ComponentByUser_Component]
ALTER TABLE [ERPSettings].[QrCodeComponent] DROP CONSTRAINT [FK_QrCodeComponent_Component]
ALTER TABLE [ERPSettings].[QrCodeComponent] DROP CONSTRAINT [FK_QrCodeComponent_InputComponent]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
ALTER TABLE [Payroll].[Payslip] DROP CONSTRAINT [FK_Payslip_Employee]
ALTER TABLE [Payroll].[Payslip] DROP CONSTRAINT [FK_Payslip_Contract]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Echellon]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Grade]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_MaritalStatus]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Team]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_UpperHierarchy]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_City]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Country]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Employee]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_QualificationCountry]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_QualificationType]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_NationalityCity]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_NationalityCountry]
ALTER TABLE [Shared].[Company] DROP CONSTRAINT [FK_Company_ZipCode]
ALTER TABLE [Shared].[Company] DROP CONSTRAINT [FK_Company_Currency]

ALTER TABLE [Shared].[ZipCode] DROP CONSTRAINT [FK_ZipCode_City]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
ALTER TABLE [ERPSettings].[UserRole] DROP CONSTRAINT [FK_UserRole_Role]
ALTER TABLE [ERPSettings].[UserRole] DROP CONSTRAINT [FK_UserRole_User]
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_Job]
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_PlannedPayroll]
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_SalaryStructure]
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_Employee]
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_ContractType]

SET IDENTITY_INSERT [Payroll].[PlannedPayroll] ON
INSERT INTO [Payroll].[PlannedPayroll] ([Id], [Value], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Bi-Hebdomadaire', 0, NULL, NULL)
INSERT INTO [Payroll].[PlannedPayroll] ([Id], [Value], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Hebdomadaire', 0, NULL, NULL)
INSERT INTO [Payroll].[PlannedPayroll] ([Id], [Value], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Bi-Mensuel', 0, NULL, NULL)
INSERT INTO [Payroll].[PlannedPayroll] ([Id], [Value], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'Mensuel', 0, NULL, NULL)
INSERT INTO [Payroll].[PlannedPayroll] ([Id], [Value], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (6, N'Trimestriel', 0, NULL, NULL)
INSERT INTO [Payroll].[PlannedPayroll] ([Id], [Value], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (7, N'Semestriel', 0, NULL, NULL)
INSERT INTO [Payroll].[PlannedPayroll] ([Id], [Value], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (8, N'Annuel', 0, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[PlannedPayroll] OFF

SET IDENTITY_INSERT [Payroll].[Contract] ON
INSERT INTO [Payroll].[Contract] ([Id], [ContractReference], [StartDate], [EndDate], [BaseSalary], [WorkingTime], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdEmployee], [IdJob], [IdContractType], [IdSalaryStructure], [IdPlannedPayroll]) VALUES (6, N'Spark-4855', '20180515', NULL, 1200, 8, 0, NULL, NULL, 8, 1, 1, 1, 5)
SET IDENTITY_INSERT [Payroll].[Contract] OFF


SET IDENTITY_INSERT [Payroll].[ContractType] ON
INSERT INTO [Payroll].[ContractType] ([Id], [ContractTypeReference], [Label], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'TempPlein', N'Temp plein', N'Contrat à temp plein', 0, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[ContractType] OFF
SET IDENTITY_INSERT [Payroll].[Job] ON
INSERT INTO [Payroll].[Job] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Développeur .NET', 0, NULL, NULL)
INSERT INTO [Payroll].[Job] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Ingenieur', 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[Job] OFF
SET IDENTITY_INSERT [Payroll].[ConstantValue] ON
INSERT INTO [Payroll].[ConstantValue] ([Id], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference]) VALUES (2, N'Constante de prime de présence', 0, 0, NULL, 10)
INSERT INTO [Payroll].[ConstantValue] ([Id], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference]) VALUES (3, N'Constante de prime transport', 0, 0, NULL, 11)
INSERT INTO [Payroll].[ConstantValue] ([Id], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference]) VALUES (4, N'Retenue à la source', 0, 0, NULL, 19)
INSERT INTO [Payroll].[ConstantValue] ([Id], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference]) VALUES (5, N'Essai', 0, 0, NULL, 23)
SET IDENTITY_INSERT [Payroll].[ConstantValue] OFF
SET IDENTITY_INSERT [Payroll].[ConstantValueValidityPeriod] ON
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (7, '20180501', 2.08, 2, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (8, '20180601', 2.08, 2, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (9, '20180701', 2.08, 2, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (10, '20180801', 2.08, 2, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (11, '20180501', 36.11, 3, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (12, '20180601', 36.11, 3, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (13, '20180701', 36.11, 3, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (14, '20180501', 80, 4, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (15, '20180601', 80, 4, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (16, '20180701', 80, 4, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (17, '20180801', 85, 4, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (18, '20180101', 10, 5, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (19, '20180201', 11, 5, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (20, '20180301', 12, 5, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantValueValidityPeriod] ([Id], [Date], [Value], [IdConstantValue], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (21, '20180401', 13, 5, 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[ConstantValueValidityPeriod] OFF
SET IDENTITY_INSERT [Payroll].[TypeIdentityPieces] ON
INSERT INTO [Payroll].[TypeIdentityPieces] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'CIN', N'Carte d''identité nationale', 0, 0, NULL)
INSERT INTO [Payroll].[TypeIdentityPieces] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'PASSEPORT', N'Passeport', 0, 0, NULL)
INSERT INTO [Payroll].[TypeIdentityPieces] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'PERMIS', N'Permis de conduire', 0, 0, NULL)
INSERT INTO [Payroll].[TypeIdentityPieces] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'Autre', N'Autre types de pièce d''identité', 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[TypeIdentityPieces] OFF
SET IDENTITY_INSERT [Payroll].[IdentityPieces] ON
INSERT INTO [Payroll].[IdentityPieces] ([Id], [IdEmployee], [PieceNumber], [Current], [CreationDate], [CreationPlace], [ExpirationDate], [IdTypeIdentityPieces], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, 8, N'EB093132', 1, '20170825', N'Lomé-TOGO', '20220825', 3, 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[IdentityPieces] OFF

SET IDENTITY_INSERT [Payroll].[SalaryRule] ON
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [rule], [IdRuleType], [AppearsOnPaySlip], [IdApplicability], [IdRuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference]) VALUES (3, N'Salaire de base de l''employé', N'Salaire de base de l''employé', 1, N'BASE', 1, 0, 1, 2, 0, 0, NULL, NULL, 13)
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [rule], [IdRuleType], [AppearsOnPaySlip], [IdApplicability], [IdRuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference]) VALUES (4, N'Prime de présence', N'Règle salariale concernant les 
prime de présence', 2, N'PRESENCE', 1, 0, 1, 2, 0, 0, NULL, NULL, 14)
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [rule], [IdRuleType], [AppearsOnPaySlip], [IdApplicability], [IdRuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference]) VALUES (5, N'Indemnité de transport', N'Indemnité de transport', 3, N'TRANSPORT', 1, 0, 1, 2, 0, 0, NULL, NULL, 15)
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [rule], [IdRuleType], [AppearsOnPaySlip], [IdApplicability], [IdRuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference]) VALUES (6, N'Salaire brut de l''employé', N'Total Brut', 4, N'R_BASE + R_PRESENCE + R_TRANSPORT', 1, 0, 2, 2, 0, 0, NULL, NULL, 16)
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [rule], [IdRuleType], [AppearsOnPaySlip], [IdApplicability], [IdRuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference]) VALUES (7, N'Retenue CNSS', N'Retenue CNSS à la source', 5, N'R_BRUT*CNSS', 2, 0, 2, 2, 0, 0, NULL, NULL, 17)
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [rule], [IdRuleType], [AppearsOnPaySlip], [IdApplicability], [IdRuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference]) VALUES (8, N'Salaire Net Fiscal', N'Salaire Net Fiscal', 6, N'R_BRUT - R_CNSS', 2, 0, 2, 2, 0, 0, NULL, NULL, 18)
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [rule], [IdRuleType], [AppearsOnPaySlip], [IdApplicability], [IdRuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference]) VALUES (9, N'Retenue à la source', N'Retenue à la source', 7, N'CV_Rsource', 2, 0, 3, 1, 0, 0, NULL, NULL, 20)
INSERT INTO [Payroll].[SalaryRule] ([Id], [Name], [Description], [Order], [rule], [IdRuleType], [AppearsOnPaySlip], [IdApplicability], [IdRuleCategory], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdContributionRegister], [IdRuleUniqueReference]) VALUES (10, N'Salaire net à payer', N'Salaire net à payer final', 8, N'R_NET', 1, 0, 3, 2, 0, 0, NULL, NULL, 21)
SET IDENTITY_INSERT [Payroll].[SalaryRule] OFF
SET IDENTITY_INSERT [Payroll].[SalaryStructure] ON
INSERT INTO [Payroll].[SalaryStructure] ([Id], [SalaryStructureReference], [Name], [Order], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdParent]) VALUES (1, N'DevJunior', N'Développeur Junior', 1, 0, NULL, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[SalaryStructure] OFF
SET IDENTITY_INSERT [Payroll].[Applicability] ON
INSERT INTO [Payroll].[Applicability] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'BASE', 0, NULL, NULL)
INSERT INTO [Payroll].[Applicability] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'BRUT', 0, NULL, NULL)
INSERT INTO [Payroll].[Applicability] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'NET FISCAL', 0, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[Applicability] OFF
SET IDENTITY_INSERT [Payroll].[RuleUniqueReference] ON
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (10, N'PRESENCE', 3, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (11, N'TRANSPORT', 3, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (12, N'BASE', 2, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (13, N'R_BASE', 1, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (14, N'R_PRESENCE', 1, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (15, N'R_TRANSPORT', 1, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (16, N'R_BRUT', 1, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (17, N'R_CNSS', 1, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (18, N'R_NET', 1, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (19, N'CV_Rsource', 3, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (20, N'R_SOURCE', 1, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (21, N'R_NETAPAYER', 1, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (22, N'CNSS', 4, 0, 0, NULL)
INSERT INTO [Payroll].[RuleUniqueReference] ([Id], [Reference], [Type], [IsDeleted], [TransactionUserId], [DeletedToken]) VALUES (23, N'Essai', 3, 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[RuleUniqueReference] OFF
SET IDENTITY_INSERT [Payroll].[ParentInCharge] ON
INSERT INTO [Payroll].[ParentInCharge] ([Id], [Name], [FirstName], [BirthDate], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdParentType], [IdEmployee]) VALUES (1, N'Gagoba', N'Noel', '20221029', 0, NULL, NULL, 1, 8)
SET IDENTITY_INSERT [Payroll].[ParentInCharge] OFF

SET IDENTITY_INSERT [Payroll].[RuleCategory] ON
INSERT INTO [Payroll].[RuleCategory] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Patronnal', 0, NULL, NULL)
INSERT INTO [Payroll].[RuleCategory] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Salarial', 0, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[RuleCategory] OFF
SET IDENTITY_INSERT [Payroll].[SalaryStructure_SalaryRule] ON
INSERT INTO [Payroll].[SalaryStructure_SalaryRule] ([Id], [IdStructure], [IdRule], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, 1, 3, 0, NULL, NULL)
INSERT INTO [Payroll].[SalaryStructure_SalaryRule] ([Id], [IdStructure], [IdRule], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, 1, 4, 0, NULL, NULL)
INSERT INTO [Payroll].[SalaryStructure_SalaryRule] ([Id], [IdStructure], [IdRule], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, 1, 5, 0, NULL, NULL)
INSERT INTO [Payroll].[SalaryStructure_SalaryRule] ([Id], [IdStructure], [IdRule], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, 1, 6, 0, NULL, NULL)
INSERT INTO [Payroll].[SalaryStructure_SalaryRule] ([Id], [IdStructure], [IdRule], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, 1, 7, 0, NULL, NULL)
INSERT INTO [Payroll].[SalaryStructure_SalaryRule] ([Id], [IdStructure], [IdRule], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (6, 1, 8, 0, NULL, NULL)
INSERT INTO [Payroll].[SalaryStructure_SalaryRule] ([Id], [IdStructure], [IdRule], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (7, 1, 9, 0, NULL, NULL)
INSERT INTO [Payroll].[SalaryStructure_SalaryRule] ([Id], [IdStructure], [IdRule], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (8, 1, 10, 0, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[SalaryStructure_SalaryRule] OFF
SET IDENTITY_INSERT [Payroll].[RuleType] ON
INSERT INTO [Payroll].[RuleType] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Gain', 0, NULL, NULL)
INSERT INTO [Payroll].[RuleType] ([Id], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Retenue', 0, NULL, NULL)
SET IDENTITY_INSERT [Payroll].[RuleType] OFF
SET IDENTITY_INSERT [Payroll].[ConstantRate] ON
INSERT INTO [Payroll].[ConstantRate] ([Id], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference]) VALUES (1, N'Caisse nationale de sécurité sociale', 0, 0, NULL, 22)
SET IDENTITY_INSERT [Payroll].[ConstantRate] OFF
SET IDENTITY_INSERT [Payroll].[Variable] ON
INSERT INTO [Payroll].[Variable] ([Id], [Description], [Formule], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdRuleUniqueReference]) VALUES (5, N'Variable de salaire de base', N'Contract.BaseSalary', 0, 0, NULL, 12)
SET IDENTITY_INSERT [Payroll].[Variable] OFF
SET IDENTITY_INSERT [Payroll].[ConstantRateValidityPeriod] ON
INSERT INTO [Payroll].[ConstantRateValidityPeriod] ([Id], [Date], [SalaryRate], [EmployerRate], [IdConstantRate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, '20180501', 0.0918, 0.15, 1, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantRateValidityPeriod] ([Id], [Date], [SalaryRate], [EmployerRate], [IdConstantRate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, '20180601', 0.0918, 0.15, 1, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantRateValidityPeriod] ([Id], [Date], [SalaryRate], [EmployerRate], [IdConstantRate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, '20180701', 0.0918, 0.15, 1, 0, 0, NULL)
INSERT INTO [Payroll].[ConstantRateValidityPeriod] ([Id], [Date], [SalaryRate], [EmployerRate], [IdConstantRate], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, '20180801', 0.0918, 0.15, 1, 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[ConstantRateValidityPeriod] OFF

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

ALTER TABLE [Administration].[AxisValueRelationShip]
    ADD CONSTRAINT [FK_AxisValueRelationShip_AxisValue] FOREIGN KEY ([IdAxisValueParent]) REFERENCES [Administration].[AxisValue] ([Id])
ALTER TABLE [Administration].[AxisValueRelationShip]
    ADD CONSTRAINT [FK__AxisRelat__IdAxi__6A3191A0] FOREIGN KEY ([IdAxisValue]) REFERENCES [Administration].[AxisValue] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[GridOptions]
    ADD CONSTRAINT [FK_GridOptions_GridComponent] FOREIGN KEY ([IdGridOptions]) REFERENCES [ERPSettings].[GridComponent] ([IdComponent])
ALTER TABLE [Payroll].[ConstantRateValidityPeriod]
    ADD CONSTRAINT [FK_ConstantRate_ValidityPeriod] FOREIGN KEY ([IdConstantRate]) REFERENCES [Payroll].[ConstantRate] ([Id])
ALTER TABLE [Payroll].[Variable]
    WITH NOCHECK ADD CONSTRAINT [FK_Variable_RuleUnique] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
ALTER TABLE [ERPSettings].[ReportParameters]
    ADD CONSTRAINT [FK_ReportViewerParameters_ReportViewerComponent] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[ReportComponent] ([IdComponent])
ALTER TABLE [Sales].[DocumentTypeRelation]
    ADD CONSTRAINT [FK_DocumentTypeRelation_DocumentTypeRelation] FOREIGN KEY ([CodeDocumentType]) REFERENCES [Sales].[DocumentType] ([CodeType])
ALTER TABLE [Sales].[DocumentTypeRelation]
    ADD CONSTRAINT [FK_DocumentTypeRelation_DocumentType] FOREIGN KEY ([CodeDocumentTypeAssociated]) REFERENCES [Sales].[DocumentType] ([CodeType])
ALTER TABLE [Sales].[DocumentType]
    ADD CONSTRAINT [FK_DocumentType_DocumentType] FOREIGN KEY ([DefaultCodeDocumentTypeAssociated]) REFERENCES [Sales].[DocumentType] ([CodeType])
ALTER TABLE [Sales].[PurchaseSettings]
    ADD CONSTRAINT [FK_PurchaseSetting_Company] FOREIGN KEY ([Id]) REFERENCES [Shared].[Company] ([Id])
ALTER TABLE [ERPSettings].[ToolBarItem]
    ADD CONSTRAINT [FK_ToolBarItemToolBarOptions] FOREIGN KEY ([IdToolBarOptions]) REFERENCES [ERPSettings].[ToolBarOptions] ([IdToolBarOptions])
ALTER TABLE [ERPSettings].[ToolBarOptions]
    ADD CONSTRAINT [FK_ToolBarOptionsToolbarComponent] FOREIGN KEY ([IdToolBarOptions]) REFERENCES [ERPSettings].[ToolBarComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[ToolBarComponent]
    ADD CONSTRAINT [FK_ComponentToolbarComponent] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Relation]
    ADD CONSTRAINT [FK_Relation_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [Payroll].[ConstantRate]
    WITH NOCHECK ADD CONSTRAINT [FK_ConstantRate_RuleUniqueReference] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
ALTER TABLE [ERPSettings].[OrderBy]
    ADD CONSTRAINT [FK_OrderBy_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[CheckBoxComponent]
    ADD CONSTRAINT [FK_CheckBoxComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Menu]
    ADD CONSTRAINT [FK_Menu_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [Payroll].[SalaryStructure_SalaryRule]
    ADD CONSTRAINT [FK_SalaryStructureRule_Structure] FOREIGN KEY ([IdStructure]) REFERENCES [Payroll].[SalaryStructure] ([Id])
ALTER TABLE [Payroll].[SalaryStructure_SalaryRule]
    WITH NOCHECK ADD CONSTRAINT [FK_SalaryStructureRule_Rule] FOREIGN KEY ([IdRule]) REFERENCES [Payroll].[SalaryRule] ([Id])
ALTER TABLE [ERPSettings].[ReportComponent]
    ADD CONSTRAINT [FK_ReportViewerComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Inventory].[ItemWarehouse]
    ADD CONSTRAINT [FK_ItemWarehouse_Warehouse] FOREIGN KEY ([IdWarehouse]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [Inventory].[ItemWarehouse]
    ADD CONSTRAINT [FK_ItemWarehouse_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id]) ON DELETE CASCADE
ALTER TABLE [Stock].[StockDocumentLineSerialNumber]
    ADD CONSTRAINT [FK_StockDocumentSerialNumber_SerialNumber] FOREIGN KEY ([IdSerialNumber]) REFERENCES [Stock].[SerialNumber] ([IdSerialNumber])
ALTER TABLE [Stock].[SerialNumber]
    ADD CONSTRAINT [FK_SerialNumber_Article1] FOREIGN KEY ([IdArticle]) REFERENCES [Stock].[Article] ([Id])
ALTER TABLE [Stock].[SerialNumber]
    ADD CONSTRAINT [FK_SerialNumber_Batch] FOREIGN KEY ([IdBatch]) REFERENCES [Stock].[Batch] ([IdBatch])
ALTER TABLE [Administration].[AxisRelationShip]
    ADD CONSTRAINT [FK_AxisRelationShip_Axis1] FOREIGN KEY ([IdAxisParent]) REFERENCES [Administration].[Axis] ([Id])
ALTER TABLE [Administration].[AxisRelationShip]
    ADD CONSTRAINT [FK_AxisRelationShip_Axis] FOREIGN KEY ([IdAxis]) REFERENCES [Administration].[Axis] ([Id]) ON DELETE CASCADE
ALTER TABLE [Administration].[Transfer]
    ADD CONSTRAINT [FK_Transfer_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [Payment].[WithholdingTaxLine]
    ADD CONSTRAINT [FK_WithholdingTaxLine_WithholdingTax] FOREIGN KEY ([IdWithholdingTax]) REFERENCES [Payment].[WithholdingTax] ([Id])
ALTER TABLE [Payment].[WithholdingTaxLine]
    ADD CONSTRAINT [FK_WithholdingTaxLine_Payment] FOREIGN KEY ([IdReglement]) REFERENCES [Payment].[Payment] ([Id])
ALTER TABLE [ERPSettings].[ComboBoxDataSourceItems]
    ADD CONSTRAINT [FK_ComboBoxDataSourceItems_ComboBoxDataSource] FOREIGN KEY ([IdComboBoxDataSource]) REFERENCES [ERPSettings].[ComboBoxDataSource] ([IdComponent])
ALTER TABLE [Payroll].[PayslipDetails]
    ADD CONSTRAINT [FK_PayslipDetails_Payslip] FOREIGN KEY ([IdPayslip]) REFERENCES [Payroll].[Payslip] ([Id])
ALTER TABLE [ERPSettings].[CheckBoxComponentDetails]
    ADD CONSTRAINT [FK_CheckBoxDetailsComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[RoleInfo]
    ADD CONSTRAINT [FK_Information_RoleInfo] FOREIGN KEY ([IdInformation]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[RoleInfo]
    ADD CONSTRAINT [FK_Role_RoleInfo] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ButtonComponent]
    ADD CONSTRAINT [FK_ButtonComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ButtonComponent]
    ADD CONSTRAINT [FK_ButtonComponent_ServiceParameters] FOREIGN KEY ([IdServiceParameter]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[FormComponent]
    ADD CONSTRAINT [FK_FormComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[FormComponent]
    ADD CONSTRAINT [FK_FormComponent_ServiceParameters] FOREIGN KEY ([IdServiceParameter]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[ImageComponent]
    ADD CONSTRAINT [FK_ImageComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[UserInfo]
    ADD CONSTRAINT [FK_Info_UserInfo] FOREIGN KEY ([IdInformation]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[UserInfo]
    ADD CONSTRAINT [FK_User_UserInfo] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [Payroll].[ParentInCharge]
    ADD CONSTRAINT [FK_ParentInCharge_ParentType] FOREIGN KEY ([IdParentType]) REFERENCES [Payroll].[ParentType] ([Id])
ALTER TABLE [Payroll].[ParentInCharge]
    ADD CONSTRAINT [FK_ParentInCharge_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [ERPSettings].[FieldSetComponent]
    ADD CONSTRAINT [FK_FieldSetComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Inventory].[TaxeItem]
    ADD CONSTRAINT [FK_TaxeItem_Taxe] FOREIGN KEY ([IdTaxe]) REFERENCES [Shared].[Taxe] ([Id])
ALTER TABLE [Inventory].[TaxeItem]
    ADD CONSTRAINT [FK_TaxeItem_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id]) ON DELETE CASCADE
ALTER TABLE [Sales].[DetailsSettlementMode]
    ADD CONSTRAINT [FK_DetailsSettlementMode_SettlementType] FOREIGN KEY ([IdSettlementType]) REFERENCES [Sales].[SettlementType] ([Id]) ON DELETE SET NULL
ALTER TABLE [Sales].[DetailsSettlementMode]
    ADD CONSTRAINT [FK_DetailsSettlementMode_PaymentMethod] FOREIGN KEY ([IdPaymentMethod]) REFERENCES [Payment].[PaymentMethod] ([Id]) ON DELETE SET NULL
ALTER TABLE [Sales].[DetailsSettlementMode]
    ADD CONSTRAINT [FK_DetailsSettlementMode_SettlementMode] FOREIGN KEY ([IdSettlementMode]) REFERENCES [Sales].[SettlementMode] ([Id]) ON DELETE SET NULL
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[InputDatePickerOptions]
    ADD CONSTRAINT [FK_InputDatePickerOptions_InputComponent] FOREIGN KEY ([IdDatePickerOptions]) REFERENCES [ERPSettings].[InputComponent] ([IdComponent])
ALTER TABLE [Administration].[CurrencyRate]
    ADD CONSTRAINT [FK_CurrencyRate_Currency] FOREIGN KEY ([IdCurrency]) REFERENCES [Administration].[Currency] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [Administration].[AxisEntity]
    ADD CONSTRAINT [FK_AxisEntity_Entity] FOREIGN KEY ([IdTableEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [Administration].[AxisEntity]
    ADD CONSTRAINT [FK__AxisEntit__IdAxi__72C6D7A1] FOREIGN KEY ([IdAxis]) REFERENCES [Administration].[Axis] ([Id]) ON DELETE CASCADE
ALTER TABLE [Inventory].[StockDocument]
    ADD CONSTRAINT [FK_StockDocument_Warehouse] FOREIGN KEY ([IdWarehouseDestination]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [Inventory].[StockDocument]
    ADD CONSTRAINT [FK_StockDocument_Warehouse1] FOREIGN KEY ([IdWarehouseSource]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [Inventory].[StockDocument]
    ADD CONSTRAINT [FK_StockDocument_TypeStockDocument] FOREIGN KEY ([TypeStockDocument]) REFERENCES [Inventory].[StockDocumentType] ([CodeType])
ALTER TABLE [Inventory].[StockDocument]
    ADD CONSTRAINT [FK_StockDocument_DocumentStatus] FOREIGN KEY ([IdDocumentStatus]) REFERENCES [Sales].[DocumentStatus] ([Id])
ALTER TABLE [Stock].[TypeStockCalculation]
    ADD CONSTRAINT [FK_TYPESTOC_ASSOCIATI_STOCKCAL] FOREIGN KEY ([IdStockCalculation]) REFERENCES [Stock].[StockCalculation] ([Id])

ALTER TABLE [Stock].[Storage]
    ADD CONSTRAINT [FK_STORAGE_ASSOCIATI_SECTION] FOREIGN KEY ([IdSection]) REFERENCES [Stock].[Section] ([IdSection])
ALTER TABLE [Stock].[Storage]
    ADD CONSTRAINT [FK_STORAGE_ASSOCIATI_ARTICLE] FOREIGN KEY ([IdArticle]) REFERENCES [Stock].[Article] ([Id])
ALTER TABLE [Shared].[City]
    ADD CONSTRAINT [FK_Ville_Pays] FOREIGN KEY ([IdPays]) REFERENCES [Shared].[Country] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payroll].[Leave]
    ADD CONSTRAINT [FK_Leave_LeaveStatus] FOREIGN KEY ([IdLeaveStatus]) REFERENCES [Payroll].[LeaveStatus] ([Id])
ALTER TABLE [Payroll].[Leave]
    ADD CONSTRAINT [FK_Leave_LeaveType] FOREIGN KEY ([IdLeaveType]) REFERENCES [Payroll].[LeaveType] ([Id])
ALTER TABLE [Payroll].[Leave]
    ADD CONSTRAINT [FK_Leave_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [ERPSettings].[ComboBoxOptions]
    ADD CONSTRAINT [FK_ComboBoxOptions_ComboBoxComponent] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[ComboBoxComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxComponent]
    ADD CONSTRAINT [FK_ComboboxComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[GridColumnComponent]
    ADD CONSTRAINT [FK_GridColumnComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Payment].[DocumentPayment]
    ADD CONSTRAINT [FK_DocumentPayement_Payement] FOREIGN KEY ([IdPayment]) REFERENCES [Payment].[Payment] ([Id])

ALTER TABLE [ERPSettings].[GridButtonComponent]
    ADD CONSTRAINT [FK_GridButtonComponent_ServiceParameters] FOREIGN KEY ([IdServiceParameter]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[GridButtonComponent]
    ADD CONSTRAINT [FK_GridButtonComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Payroll].[SalaryStructure]
    ADD CONSTRAINT [FK_SalaryStructure_SalaryStructureParent] FOREIGN KEY ([IdParent]) REFERENCES [Payroll].[SalaryStructure] ([Id])
ALTER TABLE [Payroll].[SalaryRule]
    ADD CONSTRAINT [FK_SalaryRule_ContributionRegister] FOREIGN KEY ([IdContributionRegister]) REFERENCES [Payroll].[ContributionRegister] ([Id])
ALTER TABLE [Payroll].[SalaryRule]
    ADD CONSTRAINT [FK_SalaryRule_RuleCategory] FOREIGN KEY ([IdRuleCategory]) REFERENCES [Payroll].[RuleCategory] ([Id])
ALTER TABLE [Payroll].[SalaryRule]
    ADD CONSTRAINT [FK_SalaryRule_RuleType] FOREIGN KEY ([IdRuleType]) REFERENCES [Payroll].[RuleType] ([Id])
ALTER TABLE [Payroll].[SalaryRule]
    ADD CONSTRAINT [FK_SalaryRule_Applicability] FOREIGN KEY ([IdApplicability]) REFERENCES [Payroll].[Applicability] ([Id])
ALTER TABLE [Payroll].[SalaryRule]
    WITH NOCHECK ADD CONSTRAINT [FK_SalaryRule_RuleUniqueReference] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
ALTER TABLE [Sales].[SaleSettings]
    ADD CONSTRAINT [FK_SaleSetting_Company] FOREIGN KEY ([Id]) REFERENCES [Shared].[Company] ([Id])
ALTER TABLE [Payroll].[Team]
    ADD CONSTRAINT [FK_Team_Department] FOREIGN KEY ([IdDepartment]) REFERENCES [Payroll].[Department] ([Id])
ALTER TABLE [ERPSettings].[ColumnMenuComponent]
    ADD CONSTRAINT [FK_ComponentColumnMenu] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Payment].[Payment]
    ADD CONSTRAINT [FK_Payment_PaymentMethod] FOREIGN KEY ([IdPaymentMethod]) REFERENCES [Payment].[PaymentMethod] ([Id])

ALTER TABLE [Payment].[Payment]
    ADD CONSTRAINT [FK_Payment_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [ERPSettings].[Filter]
    ADD CONSTRAINT [FK_Filter_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [Payroll].[EmployeeSkills]
    ADD CONSTRAINT [FK_EmployeeSkills_Skills] FOREIGN KEY ([IdSkills]) REFERENCES [Payroll].[Skills] ([Id])
ALTER TABLE [Payroll].[EmployeeSkills]
    ADD CONSTRAINT [FK_EmployeeSkills_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Sales].[DocumentLinePrices]
    ADD CONSTRAINT [FK_DocumentLinePrices_Prices] FOREIGN KEY ([IdPrices]) REFERENCES [Sales].[Prices] ([Id])
ALTER TABLE [Sales].[DocumentLinePrices]
    ADD CONSTRAINT [FK_DocumentLinePrices_DocumentLine] FOREIGN KEY ([IdDocumentLine]) REFERENCES [Sales].[DocumentLine] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[ModuleByUser]
    ADD CONSTRAINT [FK_ModuleByUser_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByUser]
    ADD CONSTRAINT [FK_ModuleByUser_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payroll].[Manager]
    ADD CONSTRAINT [FK_Manager_Team] FOREIGN KEY ([IdTeam]) REFERENCES [Payroll].[Team] ([Id])
ALTER TABLE [Payroll].[Manager]
    ADD CONSTRAINT [FK_Manager_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [ERPSettings].[ComboBoxDataSource]
    ADD CONSTRAINT [FK_ComboBoxDataSource_ComboBoxOptions] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[ComboBoxOptions] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxDataSource]
    ADD CONSTRAINT [FK_ComboBoxDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [Payroll].[IdentityPieces]
    ADD CONSTRAINT [FK_IdentityPieces_TypeIdentityPieces] FOREIGN KEY ([IdTypeIdentityPieces]) REFERENCES [Payroll].[TypeIdentityPieces] ([Id])
ALTER TABLE [Payroll].[IdentityPieces]
    ADD CONSTRAINT [FK_IdentityPieces_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Inventory].[StockDocumentLine]
    ADD CONSTRAINT [FK_StockDocumentLine_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id])
ALTER TABLE [Inventory].[StockDocumentLine]
    ADD CONSTRAINT [FK_StockDocumentLine_StockDocument] FOREIGN KEY ([IdStockDocument]) REFERENCES [Inventory].[StockDocument] ([Id]) ON DELETE CASCADE
ALTER TABLE [Inventory].[Item]
    ADD CONSTRAINT [FK_Item_DiscountGroupItem] FOREIGN KEY ([IdDiscountGroupItem]) REFERENCES [Inventory].[DiscountGroupItem] ([Id])
ALTER TABLE [Inventory].[Item]
    ADD CONSTRAINT [FK_Item_UnitType] FOREIGN KEY ([IdUnitSales]) REFERENCES [Stock].[MeasureUnit] ([Id])
ALTER TABLE [Inventory].[Item]
    ADD CONSTRAINT [FK_Item_UnitType1] FOREIGN KEY ([IdUnitStock]) REFERENCES [Stock].[MeasureUnit] ([Id])
ALTER TABLE [Inventory].[Item]
    ADD CONSTRAINT [FK_Item_Nature] FOREIGN KEY ([IdNature]) REFERENCES [Inventory].[Nature] ([Id])
ALTER TABLE [Stock].[StockCalculation]
    ADD CONSTRAINT [FK_STOCKCAL_ASSOCIATI_DOCUMENT] FOREIGN KEY ([IdDocument]) REFERENCES [Sales].[Document] ([Id])
ALTER TABLE [Shared].[ContactTypeDocument]
    ADD CONSTRAINT [FK_ContactTypeDocument_Contact] FOREIGN KEY ([IdContact]) REFERENCES [Shared].[Contact] ([Id]) ON DELETE CASCADE
ALTER TABLE [Shared].[Contact]
    ADD CONSTRAINT [FK_Contact_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[BarCodeComponent]
    ADD CONSTRAINT [FK_BarCodeComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[BarCodeComponent]
    ADD CONSTRAINT [FK_BarCodeComponent_InputComponent] FOREIGN KEY ([IdInputComponent]) REFERENCES [ERPSettings].[InputComponent] ([IdComponent])

ALTER TABLE [ERPSettings].[DropDownListDataSource]
    ADD CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListOptions] ([IdDropDownListOptions])
ALTER TABLE [ERPSettings].[DropDownListDataSource]
    ADD CONSTRAINT [FK_DropDownListDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [Treasury].[DetailReconciliation]
    ADD CONSTRAINT [FK_DetailReconciliation2] FOREIGN KEY ([IdPayment]) REFERENCES [Payment].[Payment] ([Id])
ALTER TABLE [Treasury].[DetailReconciliation]
    ADD CONSTRAINT [FK_DetailReconciliation3] FOREIGN KEY ([IdDetailTimetable]) REFERENCES [Treasury].[DetailTimetable] ([Id])
ALTER TABLE [Treasury].[DetailReconciliation]
    ADD CONSTRAINT [FK_DetailReconciliation] FOREIGN KEY ([IdReconciliation]) REFERENCES [Treasury].[Reconciliation] ([Id])
ALTER TABLE [Treasury].[DetailTimetable]
    ADD CONSTRAINT [FK_DetailTimetable_Timetable] FOREIGN KEY ([IdTimetable]) REFERENCES [Treasury].[Timetable] ([Id])

ALTER TABLE [ERPSettings].[DropDownListOptions]
    ADD CONSTRAINT [FK_DropDownListOptions_DropDownListComponent] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[DropDownListComponent]
    ADD CONSTRAINT [FK_DropDownListComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[LabelComponent]
    ADD CONSTRAINT [FK_LabelComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[InputComponent]
    ADD CONSTRAINT [FK_InputComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Payroll].[ConstantValueValidityPeriod]
    ADD CONSTRAINT [FK_ConstantValueValidityPeriod_ConstantValue] FOREIGN KEY ([IdConstantValue]) REFERENCES [Payroll].[ConstantValue] ([Id])
ALTER TABLE [Payroll].[ConstantValue]
    WITH NOCHECK ADD CONSTRAINT [FK_ConstantValue_RuleUniqueReference] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
ALTER TABLE [ERPSettings].[DialogComponent]
    ADD CONSTRAINT [FK_DialogComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Administration].[EntityAxisValues]
    ADD CONSTRAINT [FK_EntityAxisValues_AxisValue] FOREIGN KEY ([IdAxisValue]) REFERENCES [Administration].[AxisValue] ([Id])
ALTER TABLE [Administration].[AxisValue]
    ADD CONSTRAINT [FK__AxisValue__IdAxi__675524F5] FOREIGN KEY ([IdAxis]) REFERENCES [Administration].[Axis] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[GridDataSource]
    ADD CONSTRAINT [FK_GridDataSource_GridOptions] FOREIGN KEY ([IdGridOptions]) REFERENCES [ERPSettings].[GridOptions] ([IdGridOptions])
ALTER TABLE [ERPSettings].[GridDataSource]
    ADD CONSTRAINT [FK_GridDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[ServiceParameters]
    ADD CONSTRAINT [FK_ServiceParameters_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])

ALTER TABLE [Treasury].[Timetable]
    ADD CONSTRAINT [FK_Timetable_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Sales].[Prices]
    ADD CONSTRAINT [FK_Prices_DiscountGroupTiers] FOREIGN KEY ([IdDiscountGroupTiers]) REFERENCES [Sales].[DiscountGroupTiers] ([Id])
ALTER TABLE [Sales].[Prices]
    ADD CONSTRAINT [FK_Prices_DiscountGroupItem] FOREIGN KEY ([IdDiscountGroupItem]) REFERENCES [Inventory].[DiscountGroupItem] ([Id])
ALTER TABLE [Sales].[Prices]
    ADD CONSTRAINT [FK_Prices_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id]) ON DELETE SET NULL
ALTER TABLE [Sales].[Prices]
    ADD CONSTRAINT [FK_Prices_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Sales].[Prices]
    ADD CONSTRAINT [FK_Prices_Currency] FOREIGN KEY ([IdUsedCurrency]) REFERENCES [Administration].[Currency] ([Id]) ON DELETE SET DEFAULT
ALTER TABLE [ERPSettings].[GridComponent]
    ADD CONSTRAINT [FK_GridComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Payment].[SettlementCommitment]
    ADD CONSTRAINT [FK_SettlementCommitment_Settlement] FOREIGN KEY ([SettlementId]) REFERENCES [Payment].[Settlement] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payment].[SettlementCommitment]
    ADD CONSTRAINT [FK_SettlementCommitment_FinancialCommitment] FOREIGN KEY ([CommitmentId]) REFERENCES [Sales].[FinancialCommitment] ([Id])
ALTER TABLE [Sales].[FinancialCommitment]
    ADD CONSTRAINT [FK_FinancialCommitment_DocumentStatus] FOREIGN KEY ([IdStatus]) REFERENCES [Sales].[DocumentStatus] ([Id])
ALTER TABLE [Sales].[FinancialCommitment]
    ADD CONSTRAINT [FK_FinancialCommitment_PaymentMethod] FOREIGN KEY ([IdPaymentMethod]) REFERENCES [Payment].[PaymentMethod] ([Id])
ALTER TABLE [Sales].[FinancialCommitment]
    ADD CONSTRAINT [FK_FinancialCommitment_Document] FOREIGN KEY ([IdDocument]) REFERENCES [Sales].[Document] ([Id]) ON DELETE CASCADE
ALTER TABLE [Stock].[Article]
    ADD CONSTRAINT [FK_Article_StockManagementMethod] FOREIGN KEY ([IdStockManagementMethod]) REFERENCES [Stock].[StockManagementMethod] ([Id])
ALTER TABLE [Stock].[Article]
    ADD CONSTRAINT [FK_Article_SaleManagementMethod] FOREIGN KEY ([IdSaleManagementMethod]) REFERENCES [Stock].[SaleManagementMethod] ([IdSaleManagementMethod])
ALTER TABLE [Stock].[Article]
    ADD CONSTRAINT [FK_Article_AccountingAccount] FOREIGN KEY ([IdAccountingAccount]) REFERENCES [accounting].[AccountingAccount] ([Id])
ALTER TABLE [ERPSettings].[FunctionnalityByUser]
    ADD CONSTRAINT [FK_FunctionnalityByUser_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityByUser]
    ADD CONSTRAINT [FK_FunctionnalityByUser_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE
ALTER TABLE [Treasury].[ReceiptSpent]
    ADD CONSTRAINT [FK_ReceiptSpent_PaymentMethod] FOREIGN KEY ([IdPaymentMethod]) REFERENCES [Payment].[PaymentMethod] ([Id])
ALTER TABLE [Treasury].[ReceiptSpent]
    ADD CONSTRAINT [FK_RecipeSpent_PaymentDirection] FOREIGN KEY ([IdPaymentDirection]) REFERENCES [Treasury].[PaymentDirection] ([Id])
ALTER TABLE [Treasury].[ReceiptSpent]
    ADD CONSTRAINT [FK_RecipeSpent_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Sales].[TaxeGroupTiersConfig]
    ADD CONSTRAINT [FK_TaxeTiersConfig_TaxeGroupTiers] FOREIGN KEY ([IdTaxeGroupTiers]) REFERENCES [Sales].[TaxeGroupTiers] ([Id]) ON DELETE CASCADE
ALTER TABLE [Sales].[TaxeGroupTiersConfig]
    ADD CONSTRAINT [FK_TaxeTiersConfig_Taxe] FOREIGN KEY ([IdTaxe]) REFERENCES [Shared].[Taxe] ([Id])
ALTER TABLE [Shared].[Taxe]
    ADD CONSTRAINT [FK_Taxe_TaxeType] FOREIGN KEY ([IdTaxeType]) REFERENCES [Shared].[TaxeType] ([Id])
ALTER TABLE [Payment].[WithholdingTax]
    ADD CONSTRAINT [FK_WithholdingTax_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Payroll].[ConsultantsCustomerContract]
    ADD CONSTRAINT [FK_ConsultantsCustomerContract_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Payroll].[ConsultantsCustomerContract]
    ADD CONSTRAINT [FK_ConsultantsCustomerContract_Prices] FOREIGN KEY ([IdPrices]) REFERENCES [Sales].[Prices] ([Id]) ON DELETE CASCADE

ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_DocumentStatus] FOREIGN KEY ([IdStatus]) REFERENCES [Sales].[DocumentStatus] ([Id])
ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_Currency] FOREIGN KEY ([IdUsedCurrency]) REFERENCES [Administration].[Currency] ([Id])
ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_PaymentMethod] FOREIGN KEY ([PaymentMeans]) REFERENCES [Payment].[PaymentMethod] ([Id])
ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_Tiers_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_Tiers_Currency] FOREIGN KEY ([IdCurrency]) REFERENCES [Administration].[Currency] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_TIERS_ASSOCIATI_PAYEMENT] FOREIGN KEY ([IdPaymentCondition]) REFERENCES [Payment].[PaymentCondition] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_TIERS_ASSOCIATI_TYPETIER] FOREIGN KEY ([IdTypeTiers]) REFERENCES [Sales].[TypeTiers] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_Tiers_Pays] FOREIGN KEY ([IdPays]) REFERENCES [Shared].[Country] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_Tiers_AccountingAccount] FOREIGN KEY ([IdAccountingAccount]) REFERENCES [accounting].[AccountingAccount] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_Tiers_TaxeGroupTiers] FOREIGN KEY ([IdTaxeGroupTiers]) REFERENCES [Sales].[TaxeGroupTiers] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_Tiers_DiscountGroupTiers] FOREIGN KEY ([IdDiscountGroupTiers]) REFERENCES [Sales].[DiscountGroupTiers] ([Id])
ALTER TABLE [Stock].[StockMovement]
    ADD CONSTRAINT [FK_StockMovement_StockDocumentLine] FOREIGN KEY ([IdStockDocumentLine]) REFERENCES [Inventory].[StockDocumentLine] ([Id]) ON DELETE CASCADE
ALTER TABLE [Stock].[StockMovement]
    ADD CONSTRAINT [FK_StockMovement_Warehouse] FOREIGN KEY ([IdWarehouse]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [Stock].[StockMovement]
    ADD CONSTRAINT [FK_StockMovement_DocumentLine] FOREIGN KEY ([IdDocumentLine]) REFERENCES [Sales].[DocumentLine] ([Id])
ALTER TABLE [Stock].[StockMovement]
    ADD CONSTRAINT [FK_StockMovement_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id]) ON DELETE SET NULL
ALTER TABLE [Inventory].[Warehouse]
    ADD CONSTRAINT [FK_Warehouse_Warehouse] FOREIGN KEY ([IdWarehouseParent]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [ERPSettings].[RadioButtonComponentDetails]
    ADD CONSTRAINT [FK_RadioButtonComponentDetails_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[RadioButtonComponent]
    ADD CONSTRAINT [FK_RadioButtonComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Payroll].[CommercialsCustomerContract]
    ADD CONSTRAINT [FK_CommercialsCustomerContract_Prices] FOREIGN KEY ([IdPrices]) REFERENCES [Sales].[Prices] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payroll].[CommercialsCustomerContract]
    ADD CONSTRAINT [FK_CommercialsCustomerContract_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [ERPSettings].[ComponentByUser]
    ADD CONSTRAINT [FK_ComponentByUser_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[ComponentByUser]
    ADD CONSTRAINT [FK_ComponentByUser_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[QrCodeComponent]
    ADD CONSTRAINT [FK_QrCodeComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[QrCodeComponent]
    ADD CONSTRAINT [FK_QrCodeComponent_InputComponent] FOREIGN KEY ([IdInputComponent]) REFERENCES [ERPSettings].[InputComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Payroll].[Payslip]
    ADD CONSTRAINT [FK_Payslip_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Payroll].[Payslip]
    ADD CONSTRAINT [FK_Payslip_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Echellon] FOREIGN KEY ([IdEchellon]) REFERENCES [Payroll].[Echellon] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Grade] FOREIGN KEY ([IdGrade]) REFERENCES [Payroll].[Grade] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_MaritalStatus] FOREIGN KEY ([IdMaritalStatus]) REFERENCES [Payroll].[MaritalStatus] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Team] FOREIGN KEY ([IdTeam]) REFERENCES [Payroll].[Team] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_UpperHierarchy] FOREIGN KEY ([IdUpperHierarchy]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Employee] FOREIGN KEY ([IdLineManager]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_QualificationCountry] FOREIGN KEY ([IdQualificationCountry]) REFERENCES [Shared].[Country] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_QualificationType] FOREIGN KEY ([IdQualificationType]) REFERENCES [Payroll].[QualificationType] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_NationalityCity] FOREIGN KEY ([IdNationalityCity]) REFERENCES [Shared].[City] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_NationalityCountry] FOREIGN KEY ([IdNationalityCountry]) REFERENCES [Shared].[Country] ([Id])
ALTER TABLE [Shared].[Company]
    ADD CONSTRAINT [FK_Company_ZipCode] FOREIGN KEY ([IdZipCode]) REFERENCES [Shared].[ZipCode] ([Id])
ALTER TABLE [Shared].[Company]
    ADD CONSTRAINT [FK_Company_Currency] FOREIGN KEY ([IdCurrency]) REFERENCES [Administration].[Currency] ([Id])

ALTER TABLE [Shared].[ZipCode]
    ADD CONSTRAINT [FK_ZipCode_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[UserRole]
    ADD CONSTRAINT [FK_UserRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[UserRole]
    ADD CONSTRAINT [FK_UserRole_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payroll].[Contract]
    ADD CONSTRAINT [FK_Contract_Job] FOREIGN KEY ([IdJob]) REFERENCES [Payroll].[Job] ([Id])
ALTER TABLE [Payroll].[Contract]
    ADD CONSTRAINT [FK_Contract_PlannedPayroll] FOREIGN KEY ([IdPlannedPayroll]) REFERENCES [Payroll].[PlannedPayroll] ([Id])
ALTER TABLE [Payroll].[Contract]
    ADD CONSTRAINT [FK_Contract_SalaryStructure] FOREIGN KEY ([IdSalaryStructure]) REFERENCES [Payroll].[SalaryStructure] ([Id])
ALTER TABLE [Payroll].[Contract]
    ADD CONSTRAINT [FK_Contract_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Payroll].[Contract]
    ADD CONSTRAINT [FK_Contract_ContractType] FOREIGN KEY ([IdContractType]) REFERENCES [Payroll].[ContractType] ([Id])
COMMIT TRANSACTION

