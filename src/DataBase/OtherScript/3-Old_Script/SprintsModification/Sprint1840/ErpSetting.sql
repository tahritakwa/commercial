---- Nihel: Set IsToManager as default for purchaseRequest information
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
UPDATE [ERPSettings].[Information] SET [IsToManager]=1 WHERE [IdInfo]=1000500060
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
COMMIT TRANSACTION



--Mohamed BOUZIDI Correct bug 5627 ==> DELETE BUTTON VALIDATE FROM Purchase request
BEGIN TRANSACTION

ALTER TABLE [Stock].[StockDocumentLineSerialNumber] DROP CONSTRAINT [FK_StockDocumentSerialNumber_SerialNumber]
ALTER TABLE [Payroll].[ConstantValueValidityPeriod] DROP CONSTRAINT [FK_ConstantValueValidityPeriod_ConstantValue]
ALTER TABLE [Sales].[DocumentTypeRelation] DROP CONSTRAINT [FK_DocumentTypeRelation_DocumentTypeRelation]
ALTER TABLE [Sales].[DocumentTypeRelation] DROP CONSTRAINT [FK_DocumentTypeRelation_DocumentType]
ALTER TABLE [Sales].[DocumentType] DROP CONSTRAINT [FK_DocumentType_DocumentType]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[PopupComponent] DROP CONSTRAINT [FK_PopupComponent_Component]
ALTER TABLE [Payroll].[ConsultantsCustomerContract] DROP CONSTRAINT [FK_ConsultantsCustomerContract_Employee]
ALTER TABLE [Payroll].[ConsultantsCustomerContract] DROP CONSTRAINT [FK_ConsultantsCustomerContract_Prices]
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [ERPSettings].[MsgNotification] DROP CONSTRAINT [FK_MsgNotification_Message]
ALTER TABLE [ERPSettings].[Message] DROP CONSTRAINT [FK_Information_Message]
ALTER TABLE [Payroll].[PayslipDetails] DROP CONSTRAINT [FK_PayslipDetails_Payslip]
ALTER TABLE [Stock].[TypeStockCalculation] DROP CONSTRAINT [FK_TYPESTOC_ASSOCIATI_STOCKCAL]
ALTER TABLE [Stock].[StockCalculation] DROP CONSTRAINT [FK_STOCKCAL_ASSOCIATI_DOCUMENT]
ALTER TABLE [ERPSettings].[ReportParameters] DROP CONSTRAINT [FK_ReportViewerParameters_ReportViewerComponent]
ALTER TABLE [ERPSettings].[ColumnMenuComponent] DROP CONSTRAINT [FK_ComponentColumnMenu]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[UserInfo] DROP CONSTRAINT [FK_Info_UserInfo]
ALTER TABLE [ERPSettings].[UserInfo] DROP CONSTRAINT [FK_User_UserInfo]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
ALTER TABLE [Payroll].[ConstantValue] DROP CONSTRAINT [FK_ConstantValue_RuleUniqueReference]
ALTER TABLE [Payroll].[ConstantRateValidityPeriod] DROP CONSTRAINT [FK_ConstantRate_ValidityPeriod]
ALTER TABLE [Payroll].[ConstantRate] DROP CONSTRAINT [FK_ConstantRate_RuleUniqueReference]
ALTER TABLE [ERPSettings].[CheckBoxComponentDetails] DROP CONSTRAINT [FK_CheckBoxDetailsComponent_Component]
ALTER TABLE [ERPSettings].[GridColumnComponent] DROP CONSTRAINT [FK_GridColumnComponent_Component]
ALTER TABLE [ERPSettings].[ComponentByRole] DROP CONSTRAINT [FK_ComponentByRole_Component]
ALTER TABLE [ERPSettings].[ComponentByRole] DROP CONSTRAINT [FK_ComponentByRole_Role]
ALTER TABLE [Immobilisation].[Active] DROP CONSTRAINT [FK_Active_Category1]
ALTER TABLE [Immobilisation].[Active] DROP CONSTRAINT [FK_Active_DocumentLine1]
ALTER TABLE [Administration].[EntityAxisValues] DROP CONSTRAINT [FK_EntityAxisValues_AxisValue]
ALTER TABLE [Administration].[EntityAxisValues] DROP CONSTRAINT [FK_EntityAxisValues_Entity]
ALTER TABLE [Sales].[PurchaseSettings] DROP CONSTRAINT [FK_PurchaseSettings_User]
ALTER TABLE [Sales].[PurchaseSettings] DROP CONSTRAINT [FK_PurchaseSetting_Company]
ALTER TABLE [Payroll].[Variable] DROP CONSTRAINT [FK_Variable_RuleUnique]
ALTER TABLE [ERPSettings].[RadioButtonComponent] DROP CONSTRAINT [FK_RadioButtonComponent_Component]
ALTER TABLE [ERPSettings].[GridButtonComponent] DROP CONSTRAINT [FK_GridButtonComponent_ServiceParameters]
ALTER TABLE [ERPSettings].[GridButtonComponent] DROP CONSTRAINT [FK_GridButtonComponent_Component]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [FK_Information_RoleInfo]
ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [FK_Role_RoleInfo]
ALTER TABLE [Treasury].[DetailReconciliation] DROP CONSTRAINT [FK_DetailReconciliation3]
ALTER TABLE [Treasury].[DetailReconciliation] DROP CONSTRAINT [FK_DetailReconciliation]
ALTER TABLE [ERPSettings].[ImageComponent] DROP CONSTRAINT [FK_ImageComponent_Component]
ALTER TABLE [ERPSettings].[OrderBy] DROP CONSTRAINT [FK_OrderBy_PredicateFormat]
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
ALTER TABLE [Sales].[DocumentLineTaxe] DROP CONSTRAINT [FK_DocumentLineTaxe_Taxe]
ALTER TABLE [Sales].[DocumentLineTaxe] DROP CONSTRAINT [FK_DocumentLineTaxe_DocumentLine]
ALTER TABLE [Payroll].[Payslip] DROP CONSTRAINT [FK_Payslip_Contract]
ALTER TABLE [Payroll].[Payslip] DROP CONSTRAINT [FK_Payslip_Employee]
ALTER TABLE [Sales].[DocumentLinePrices] DROP CONSTRAINT [FK_DocumentLinePrices_Prices]
ALTER TABLE [Sales].[DocumentLinePrices] DROP CONSTRAINT [FK_DocumentLinePrices_DocumentLine]
ALTER TABLE [ERPSettings].[FieldSetComponent] DROP CONSTRAINT [FK_FieldSetComponent_Component]
ALTER TABLE [ERPSettings].[ComboBoxComponent] DROP CONSTRAINT [FK_ComboboxComponent_Component]
ALTER TABLE [Administration].[AxisEntity] DROP CONSTRAINT [FK_AxisEntity_Entity]
ALTER TABLE [Administration].[AxisEntity] DROP CONSTRAINT [FK__AxisEntit__IdAxi__72C6D7A1]
ALTER TABLE [Administration].[AxisValueRelationShip] DROP CONSTRAINT [FK__AxisRelat__IdAxi__6A3191A0]
ALTER TABLE [Administration].[AxisValueRelationShip] DROP CONSTRAINT [FK_AxisValueRelationShip_AxisValue]
ALTER TABLE [Administration].[AxisValue] DROP CONSTRAINT [FK__AxisValue__IdAxi__675524F5]
ALTER TABLE [Stock].[Article] DROP CONSTRAINT [FK_Article_StockManagementMethod]
ALTER TABLE [Stock].[Article] DROP CONSTRAINT [FK_Article_SaleManagementMethod]
ALTER TABLE [Stock].[Article] DROP CONSTRAINT [FK_Article_AccountingAccount]
ALTER TABLE [Sales].[SaleSettings] DROP CONSTRAINT [FK_SaleSetting_Company]
ALTER TABLE [Stock].[Storage] DROP CONSTRAINT [FK_STORAGE_ASSOCIATI_SECTION]
ALTER TABLE [Stock].[Storage] DROP CONSTRAINT [FK_STORAGE_ASSOCIATI_ARTICLE]
ALTER TABLE [ERPSettings].[CheckBoxComponent] DROP CONSTRAINT [FK_CheckBoxComponent_Component]
ALTER TABLE [ERPSettings].[DropDownListComponent] DROP CONSTRAINT [FK_DropDownListComponent_Component]
ALTER TABLE [Administration].[AxisRelationShip] DROP CONSTRAINT [FK_AxisRelationShip_Axis1]
ALTER TABLE [Administration].[AxisRelationShip] DROP CONSTRAINT [FK_AxisRelationShip_Axis]
ALTER TABLE [Stock].[SerialNumber] DROP CONSTRAINT [FK_SerialNumber_Article1]
ALTER TABLE [Stock].[SerialNumber] DROP CONSTRAINT [FK_SerialNumber_Batch]
ALTER TABLE [ERPSettings].[FormComponent] DROP CONSTRAINT [FK_FormComponent_Component]
ALTER TABLE [ERPSettings].[FormComponent] DROP CONSTRAINT [FK_FormComponent_ServiceParameters]
ALTER TABLE [Administration].[CurrencyRate] DROP CONSTRAINT [FK_CurrencyRate_Currency]
ALTER TABLE [ERPSettings].[ComboBoxOptions] DROP CONSTRAINT [FK_ComboBoxOptions_ComboBoxComponent]
ALTER TABLE [ERPSettings].[RadioButtonComponentDetails] DROP CONSTRAINT [FK_RadioButtonComponentDetails_Component]
ALTER TABLE [ERPSettings].[InputDatePickerOptions] DROP CONSTRAINT [FK_InputDatePickerOptions_InputComponent]
ALTER TABLE [Treasury].[DetailTimetable] DROP CONSTRAINT [FK_DetailTimetable_Timetable]
ALTER TABLE [Treasury].[DetailTimetable] DROP CONSTRAINT [FK_DetailTimetable_PaymentType]
ALTER TABLE [ERPSettings].[ModuleByUser] DROP CONSTRAINT [FK_ModuleByUser_Module]
ALTER TABLE [ERPSettings].[ModuleByUser] DROP CONSTRAINT [FK_ModuleByUser_User]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[ReportComponent] DROP CONSTRAINT [FK_ReportViewerComponent_Component]
ALTER TABLE [ERPSettings].[BarCodeComponent] DROP CONSTRAINT [FK_BarCodeComponent_Component]
ALTER TABLE [ERPSettings].[BarCodeComponent] DROP CONSTRAINT [FK_BarCodeComponent_InputComponent]
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_Employee]
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_PlannedPayroll]
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_SalaryStructure]
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_Job]
ALTER TABLE [Payroll].[SalaryStructure] DROP CONSTRAINT [FK_SalaryStructure_SalaryStructureParent]
ALTER TABLE [Inventory].[ItemWarehouse] DROP CONSTRAINT [FK_ItemWarehouse_Warehouse]
ALTER TABLE [Inventory].[ItemWarehouse] DROP CONSTRAINT [FK_ItemWarehouse_Item]
ALTER TABLE [ERPSettings].[DialogComponent] DROP CONSTRAINT [FK_DialogComponent_Component]
ALTER TABLE [Shared].[City] DROP CONSTRAINT [FK_Ville_Pays]
ALTER TABLE [Payment].[SettlementCommitment] DROP CONSTRAINT [FK_SettlementCommitment_Settlement]
ALTER TABLE [Payment].[SettlementCommitment] DROP CONSTRAINT [FK_SettlementCommitment_FinancialCommitment]
ALTER TABLE [Inventory].[StockDocument] DROP CONSTRAINT [FK_StockDocument_Warehouse]
ALTER TABLE [Inventory].[StockDocument] DROP CONSTRAINT [FK_StockDocument_Warehouse1]
ALTER TABLE [Inventory].[StockDocument] DROP CONSTRAINT [FK_StockDocument_TypeStockDocument]
ALTER TABLE [Inventory].[StockDocument] DROP CONSTRAINT [FK_StockDocument_DocumentStatus]
ALTER TABLE [Payroll].[CommercialsCustomerContract] DROP CONSTRAINT [FK_CommercialsCustomerContract_Employee]
ALTER TABLE [Payroll].[CommercialsCustomerContract] DROP CONSTRAINT [FK_CommercialsCustomerContract_Prices]
ALTER TABLE [Payroll].[Manager] DROP CONSTRAINT [FK_Manager_Team]
ALTER TABLE [Payroll].[Manager] DROP CONSTRAINT [FK_Manager_Employee]
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [FK_GridOptions_GridComponent]
ALTER TABLE [ERPSettings].[GridComponent] DROP CONSTRAINT [FK_GridComponent_Component]
ALTER TABLE [ERPSettings].[InputComponent] DROP CONSTRAINT [FK_InputComponent_Component]
ALTER TABLE [Payment].[WithholdingTaxLine] DROP CONSTRAINT [FK_WithholdingTaxLine_WithholdingTax]
ALTER TABLE [Payment].[WithholdingTax] DROP CONSTRAINT [FK_WithholdingTax_Tiers]
ALTER TABLE [Shared].[ContactTypeDocument] DROP CONSTRAINT [FK_ContactTypeDocument_Contact]
ALTER TABLE [ERPSettings].[ButtonComponent] DROP CONSTRAINT [FK_ButtonComponent_Component]
ALTER TABLE [ERPSettings].[ButtonComponent] DROP CONSTRAINT [FK_ButtonComponent_ServiceParameters]
ALTER TABLE [ERPSettings].[LabelComponent] DROP CONSTRAINT [FK_LabelComponent_Component]
ALTER TABLE [ERPSettings].[FunctionnalityByUser] DROP CONSTRAINT [FK_FunctionnalityByUser_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityByUser] DROP CONSTRAINT [FK_FunctionnalityByUser_User]
ALTER TABLE [Payroll].[ParentInCharge] DROP CONSTRAINT [FK_ParentInCharge_Employee]
ALTER TABLE [Payroll].[ParentInCharge] DROP CONSTRAINT [FK_ParentInCharge_ParentType]
ALTER TABLE [Inventory].[Warehouse] DROP CONSTRAINT [FK_Warehouse_Warehouse]
ALTER TABLE [Sales].[Prices] DROP CONSTRAINT [FK_Prices_DiscountGroupTiers]
ALTER TABLE [Sales].[Prices] DROP CONSTRAINT [FK_Prices_DiscountGroupItem]
ALTER TABLE [Sales].[Prices] DROP CONSTRAINT [FK_Prices_Item]
ALTER TABLE [Sales].[Prices] DROP CONSTRAINT [FK_Prices_Tiers]
ALTER TABLE [Sales].[Prices] DROP CONSTRAINT [FK_Prices_Currency]
ALTER TABLE [Sales].[Prices] DROP CONSTRAINT [FK_Prices_ContractServiceType]
ALTER TABLE [Inventory].[StockDocumentLine] DROP CONSTRAINT [FK_StockDocumentLine_StockDocument]
ALTER TABLE [Inventory].[StockDocumentLine] DROP CONSTRAINT [FK_StockDocumentLine_Item]
ALTER TABLE [Payroll].[Leave] DROP CONSTRAINT [FK_Leave_LeaveStatus]
ALTER TABLE [Payroll].[Leave] DROP CONSTRAINT [FK_Leave_LeaveType]
ALTER TABLE [Payroll].[Leave] DROP CONSTRAINT [FK_Leave_Employee]
ALTER TABLE [Payroll].[Team] DROP CONSTRAINT [FK_Team_Department]
ALTER TABLE [Payroll].[SalaryStructure_SalaryRule] DROP CONSTRAINT [FK_SalaryStructureRule_Rule]
ALTER TABLE [Payroll].[SalaryStructure_SalaryRule] DROP CONSTRAINT [FK_SalaryStructureRule_Structure]
ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_ContributionRegister]
ALTER TABLE [Payroll].[SalaryRule] DROP CONSTRAINT [FK_SalaryRule_RuleUniqueReference]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[QrCodeComponent] DROP CONSTRAINT [FK_QrCodeComponent_Component]
ALTER TABLE [ERPSettings].[QrCodeComponent] DROP CONSTRAINT [FK_QrCodeComponent_InputComponent]
ALTER TABLE [Treasury].[ReceiptSpent] DROP CONSTRAINT [FK_ReceiptSpent_PaymentMethod]
ALTER TABLE [Treasury].[ReceiptSpent] DROP CONSTRAINT [FK_RecipeSpent_PaymentDirection]
ALTER TABLE [Treasury].[ReceiptSpent] DROP CONSTRAINT [FK_RecipeSpent_Tiers]
ALTER TABLE [Shared].[Company] DROP CONSTRAINT [FK_Company_ZipCode]
ALTER TABLE [Shared].[Company] DROP CONSTRAINT [FK_Company_Currency]
ALTER TABLE [Shared].[Company] DROP CONSTRAINT [FK_Company_BankAccount]
ALTER TABLE [Shared].[ZipCode] DROP CONSTRAINT [FK_ZipCode_City]
ALTER TABLE [ERPSettings].[ToolBarComponent] DROP CONSTRAINT [FK_ComponentToolbarComponent]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
ALTER TABLE [ERPSettings].[ToolBarItem] DROP CONSTRAINT [FK_ToolBarItemToolBarOptions]
ALTER TABLE [ERPSettings].[ToolBarOptions] DROP CONSTRAINT [FK_ToolBarOptionsToolbarComponent]
ALTER TABLE [Stock].[StockMovement] DROP CONSTRAINT [FK_StockMovement_StockDocumentLine]
ALTER TABLE [Stock].[StockMovement] DROP CONSTRAINT [FK_StockMovement_Warehouse]
ALTER TABLE [Stock].[StockMovement] DROP CONSTRAINT [FK_StockMovement_DocumentLine]
ALTER TABLE [Stock].[StockMovement] DROP CONSTRAINT [FK_StockMovement_Item]
ALTER TABLE [Inventory].[Item] DROP CONSTRAINT [FK_Item_DiscountGroupItem]
ALTER TABLE [Inventory].[Item] DROP CONSTRAINT [FK_Item_UnitType]
ALTER TABLE [Inventory].[Item] DROP CONSTRAINT [FK_Item_UnitType1]
ALTER TABLE [Inventory].[Item] DROP CONSTRAINT [FK_Item_Nature]
ALTER TABLE [Inventory].[Item] DROP CONSTRAINT [FK_Item_Tiers]
ALTER TABLE [ERPSettings].[Relation] DROP CONSTRAINT [FK_Relation_PredicateFormat]
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions]
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_ServiceParameters]
ALTER TABLE [ERPSettings].[DropDownListOptions] DROP CONSTRAINT [FK_DropDownListOptions_DropDownListComponent]
ALTER TABLE [Payment].[PaymentMethod] DROP CONSTRAINT [FK_PayementMethod_PayementType]
ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [FK_Settlement_BankAccount]
ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [FK_Settlement_DocumentStatus]
ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [FK_Settlement_Currency]
ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [FK_Settlement_PaymentMethod]
ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [FK_Settlement_Tiers]
ALTER TABLE [Payroll].[EmployeeSkills] DROP CONSTRAINT [FK_EmployeeSkills_Skills]
ALTER TABLE [Payroll].[EmployeeSkills] DROP CONSTRAINT [FK_EmployeeSkills_Employee]
ALTER TABLE [Sales].[TaxeGroupTiersConfig] DROP CONSTRAINT [FK_TaxeTiersConfig_TaxeGroupTiers]
ALTER TABLE [Sales].[TaxeGroupTiersConfig] DROP CONSTRAINT [FK_TaxeTiersConfig_Taxe]
ALTER TABLE [ERPSettings].[ComboBoxDataSourceItems] DROP CONSTRAINT [FK_ComboBoxDataSourceItems_ComboBoxDataSource]
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [FK_ComboBoxDataSource_ComboBoxOptions]
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [FK_ComboBoxDataSource_ServiceParameters]
ALTER TABLE [ERPSettings].[Filter] DROP CONSTRAINT [FK_Filter_PredicateFormat]
ALTER TABLE [ERPSettings].[ComponentByUser] DROP CONSTRAINT [FK_ComponentByUser_User]
ALTER TABLE [ERPSettings].[ComponentByUser] DROP CONSTRAINT [FK_ComponentByUser_Component]
ALTER TABLE [ERPSettings].[User] DROP CONSTRAINT [FK_User_User]
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [FK_GridDataSource_GridOptions]
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [FK_GridDataSource_ServiceParameters]
ALTER TABLE [Immobilisation].[History] DROP CONSTRAINT [FK_History_Active]
ALTER TABLE [Immobilisation].[History] DROP CONSTRAINT [FK_History_Employee]
ALTER TABLE [Treasury].[Timetable] DROP CONSTRAINT [FK_Timetable_PaymentType]
ALTER TABLE [Treasury].[Timetable] DROP CONSTRAINT [FK_Timetable_Tiers]
ALTER TABLE [Inventory].[TaxeItem] DROP CONSTRAINT [FK_TaxeItem_Taxe]
ALTER TABLE [Inventory].[TaxeItem] DROP CONSTRAINT [FK_TaxeItem_Item]
ALTER TABLE [Shared].[Taxe] DROP CONSTRAINT [FK_Taxe_TaxeType]
ALTER TABLE [ERPSettings].[UserRole] DROP CONSTRAINT [FK_UserRole_Role]
ALTER TABLE [ERPSettings].[UserRole] DROP CONSTRAINT [FK_UserRole_User]
ALTER TABLE [Sales].[DetailsSettlementMode] DROP CONSTRAINT [FK_DetailsSettlementMode_SettlementType]
ALTER TABLE [Sales].[DetailsSettlementMode] DROP CONSTRAINT [FK_DetailsSettlementMode_PaymentMethod]
ALTER TABLE [Sales].[DetailsSettlementMode] DROP CONSTRAINT [FK_DetailsSettlementMode_SettlementMode]
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [FK_ServiceParameters_PredicateFormat]
ALTER TABLE [Sales].[FinancialCommitment] DROP CONSTRAINT [FK_FinancialCommitment_DocumentStatus]
ALTER TABLE [Sales].[FinancialCommitment] DROP CONSTRAINT [FK_FinancialCommitment_PaymentMethod]
ALTER TABLE [Sales].[FinancialCommitment] DROP CONSTRAINT [FK_FinancialCommitment_Document]
ALTER TABLE [Payroll].[IdentityPieces] DROP CONSTRAINT [FK_IdentityPieces_TypeIdentityPieces]
ALTER TABLE [Payroll].[IdentityPieces] DROP CONSTRAINT [FK_IdentityPieces_Employee]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_City]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Country]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Employee]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_QualificationCountry]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_QualificationType]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Grade]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Team]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_UpperHierarchy]
ALTER TABLE [Shared].[Contact] DROP CONSTRAINT [FK_Contact_Tiers]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_Tiers_Pays]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_Tiers_AccountingAccount]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_Tiers_TaxeGroupTiers]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_Tiers_DiscountGroupTiers]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_Tiers_City]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_Tiers_Currency]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_TIERS_ASSOCIATI_PAYEMENT]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_TIERS_ASSOCIATI_TYPETIER]

DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'3aad5dda-266c-4f33-8f17-d4fbb24e9659'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'a38979be-c38d-4a32-93bb-a69f81438ea1'
DELETE FROM [ERPSettings].[ButtonComponent] WHERE [IdComponent]=N'a38979be-c38d-4a32-93bb-a69f81438ea1'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'3aad5dda-266c-4f33-8f17-d4fbb24e9659'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'a38979be-c38d-4a32-93bb-a69f81438ea1'
DELETE FROM [ERPSettings].[ServiceParameters] WHERE [IdServiceParameters]=N'45aed06e-3bc3-4daf-975e-22dda25f0af4'

UPDATE [ERPSettings].[Component] SET [rank]=3 WHERE [IdComponent]=N'0017d818-2acc-49c6-b819-83ff3dbf8735'
UPDATE [ERPSettings].[Component] SET [rank]=2 WHERE [IdComponent]=N'ebfbf1f9-64e5-41cf-b896-cc72c9b0b002'

ALTER TABLE [Stock].[StockDocumentLineSerialNumber]
    ADD CONSTRAINT [FK_StockDocumentSerialNumber_SerialNumber] FOREIGN KEY ([IdSerialNumber]) REFERENCES [Stock].[SerialNumber] ([IdSerialNumber])
ALTER TABLE [Payroll].[ConstantValueValidityPeriod]
    ADD CONSTRAINT [FK_ConstantValueValidityPeriod_ConstantValue] FOREIGN KEY ([IdConstantValue]) REFERENCES [Payroll].[ConstantValue] ([Id])
ALTER TABLE [Sales].[DocumentTypeRelation]
    ADD CONSTRAINT [FK_DocumentTypeRelation_DocumentTypeRelation] FOREIGN KEY ([CodeDocumentType]) REFERENCES [Sales].[DocumentType] ([CodeType])
ALTER TABLE [Sales].[DocumentTypeRelation]
    ADD CONSTRAINT [FK_DocumentTypeRelation_DocumentType] FOREIGN KEY ([CodeDocumentTypeAssociated]) REFERENCES [Sales].[DocumentType] ([CodeType])
ALTER TABLE [Sales].[DocumentType]
    ADD CONSTRAINT [FK_DocumentType_DocumentType] FOREIGN KEY ([DefaultCodeDocumentTypeAssociated]) REFERENCES [Sales].[DocumentType] ([CodeType])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[PopupComponent]
    ADD CONSTRAINT [FK_PopupComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Payroll].[ConsultantsCustomerContract]
    ADD CONSTRAINT [FK_ConsultantsCustomerContract_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Payroll].[ConsultantsCustomerContract]
    ADD CONSTRAINT [FK_ConsultantsCustomerContract_Prices] FOREIGN KEY ([IdPrices]) REFERENCES [Sales].[Prices] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[MsgNotification]
    ADD CONSTRAINT [FK_MsgNotification_Message] FOREIGN KEY ([IdMsg]) REFERENCES [ERPSettings].[Message] ([Id])
ALTER TABLE [ERPSettings].[Message]
    ADD CONSTRAINT [FK_Information_Message] FOREIGN KEY ([IdInformation]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [Payroll].[PayslipDetails]
    ADD CONSTRAINT [FK_PayslipDetails_Payslip] FOREIGN KEY ([IdPayslip]) REFERENCES [Payroll].[Payslip] ([Id])
ALTER TABLE [Stock].[TypeStockCalculation]
    ADD CONSTRAINT [FK_TYPESTOC_ASSOCIATI_STOCKCAL] FOREIGN KEY ([IdStockCalculation]) REFERENCES [Stock].[StockCalculation] ([Id])
ALTER TABLE [Stock].[StockCalculation]
    ADD CONSTRAINT [FK_STOCKCAL_ASSOCIATI_DOCUMENT] FOREIGN KEY ([IdDocument]) REFERENCES [Sales].[Document] ([Id])
ALTER TABLE [ERPSettings].[ReportParameters]
    ADD CONSTRAINT [FK_ReportViewerParameters_ReportViewerComponent] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[ReportComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[ColumnMenuComponent]
    ADD CONSTRAINT [FK_ComponentColumnMenu] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[UserInfo]
    ADD CONSTRAINT [FK_Info_UserInfo] FOREIGN KEY ([IdInformation]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[UserInfo]
    ADD CONSTRAINT [FK_User_UserInfo] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [Payroll].[ConstantValue]
    ADD CONSTRAINT [FK_ConstantValue_RuleUniqueReference] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
ALTER TABLE [Payroll].[ConstantRateValidityPeriod]
    ADD CONSTRAINT [FK_ConstantRate_ValidityPeriod] FOREIGN KEY ([IdConstantRate]) REFERENCES [Payroll].[ConstantRate] ([Id])
ALTER TABLE [Payroll].[ConstantRate]
    ADD CONSTRAINT [FK_ConstantRate_RuleUniqueReference] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
ALTER TABLE [ERPSettings].[CheckBoxComponentDetails]
    ADD CONSTRAINT [FK_CheckBoxDetailsComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[GridColumnComponent]
    ADD CONSTRAINT [FK_GridColumnComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ComponentByRole]
    ADD CONSTRAINT [FK_ComponentByRole_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ComponentByRole]
    ADD CONSTRAINT [FK_ComponentByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [Immobilisation].[Active]
    ADD CONSTRAINT [FK_Active_Category1] FOREIGN KEY ([IdCategory]) REFERENCES [Immobilisation].[Category] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [Immobilisation].[Active]
    ADD CONSTRAINT [FK_Active_DocumentLine1] FOREIGN KEY ([IdDocumentLine]) REFERENCES [Sales].[DocumentLine] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [Administration].[EntityAxisValues]
    ADD CONSTRAINT [FK_EntityAxisValues_AxisValue] FOREIGN KEY ([IdAxisValue]) REFERENCES [Administration].[AxisValue] ([Id])
ALTER TABLE [Administration].[EntityAxisValues]
    ADD CONSTRAINT [FK_EntityAxisValues_Entity] FOREIGN KEY ([Entity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [Sales].[PurchaseSettings]
    ADD CONSTRAINT [FK_PurchaseSettings_User] FOREIGN KEY ([IdPurchasingManager]) REFERENCES [ERPSettings].[User] ([Id])
ALTER TABLE [Sales].[PurchaseSettings]
    ADD CONSTRAINT [FK_PurchaseSetting_Company] FOREIGN KEY ([Id]) REFERENCES [Shared].[Company] ([Id])
ALTER TABLE [Payroll].[Variable]
    ADD CONSTRAINT [FK_Variable_RuleUnique] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
ALTER TABLE [ERPSettings].[RadioButtonComponent]
    ADD CONSTRAINT [FK_RadioButtonComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[GridButtonComponent]
    ADD CONSTRAINT [FK_GridButtonComponent_ServiceParameters] FOREIGN KEY ([IdServiceParameter]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[GridButtonComponent]
    ADD CONSTRAINT [FK_GridButtonComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[RoleInfo]
    ADD CONSTRAINT [FK_Information_RoleInfo] FOREIGN KEY ([IdInformation]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[RoleInfo]
    ADD CONSTRAINT [FK_Role_RoleInfo] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id])
ALTER TABLE [Treasury].[DetailReconciliation]
    ADD CONSTRAINT [FK_DetailReconciliation3] FOREIGN KEY ([IdDetailTimetable]) REFERENCES [Treasury].[DetailTimetable] ([Id])
ALTER TABLE [Treasury].[DetailReconciliation]
    ADD CONSTRAINT [FK_DetailReconciliation] FOREIGN KEY ([IdReconciliation]) REFERENCES [Treasury].[Reconciliation] ([Id])
ALTER TABLE [ERPSettings].[ImageComponent]
    ADD CONSTRAINT [FK_ImageComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[OrderBy]
    ADD CONSTRAINT [FK_OrderBy_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [Sales].[DocumentLineTaxe]
    ADD CONSTRAINT [FK_DocumentLineTaxe_Taxe] FOREIGN KEY ([IdTaxe]) REFERENCES [Shared].[Taxe] ([Id])
ALTER TABLE [Sales].[DocumentLineTaxe]
    ADD CONSTRAINT [FK_DocumentLineTaxe_DocumentLine] FOREIGN KEY ([IdDocumentLine]) REFERENCES [Sales].[DocumentLine] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payroll].[Payslip]
    ADD CONSTRAINT [FK_Payslip_Contract] FOREIGN KEY ([IdContract]) REFERENCES [Payroll].[Contract] ([Id])
ALTER TABLE [Payroll].[Payslip]
    ADD CONSTRAINT [FK_Payslip_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Sales].[DocumentLinePrices]
    ADD CONSTRAINT [FK_DocumentLinePrices_Prices] FOREIGN KEY ([IdPrices]) REFERENCES [Sales].[Prices] ([Id])
ALTER TABLE [Sales].[DocumentLinePrices]
    ADD CONSTRAINT [FK_DocumentLinePrices_DocumentLine] FOREIGN KEY ([IdDocumentLine]) REFERENCES [Sales].[DocumentLine] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FieldSetComponent]
    ADD CONSTRAINT [FK_FieldSetComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxComponent]
    ADD CONSTRAINT [FK_ComboboxComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Administration].[AxisEntity]
    ADD CONSTRAINT [FK_AxisEntity_Entity] FOREIGN KEY ([IdTableEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [Administration].[AxisEntity]
    ADD CONSTRAINT [FK__AxisEntit__IdAxi__72C6D7A1] FOREIGN KEY ([IdAxis]) REFERENCES [Administration].[Axis] ([Id]) ON DELETE CASCADE
ALTER TABLE [Administration].[AxisValueRelationShip]
    ADD CONSTRAINT [FK__AxisRelat__IdAxi__6A3191A0] FOREIGN KEY ([IdAxisValue]) REFERENCES [Administration].[AxisValue] ([Id]) ON DELETE CASCADE
ALTER TABLE [Administration].[AxisValueRelationShip]
    ADD CONSTRAINT [FK_AxisValueRelationShip_AxisValue] FOREIGN KEY ([IdAxisValueParent]) REFERENCES [Administration].[AxisValue] ([Id])
ALTER TABLE [Administration].[AxisValue]
    ADD CONSTRAINT [FK__AxisValue__IdAxi__675524F5] FOREIGN KEY ([IdAxis]) REFERENCES [Administration].[Axis] ([Id]) ON DELETE CASCADE
ALTER TABLE [Stock].[Article]
    ADD CONSTRAINT [FK_Article_StockManagementMethod] FOREIGN KEY ([IdStockManagementMethod]) REFERENCES [Stock].[StockManagementMethod] ([Id])
ALTER TABLE [Stock].[Article]
    ADD CONSTRAINT [FK_Article_SaleManagementMethod] FOREIGN KEY ([IdSaleManagementMethod]) REFERENCES [Stock].[SaleManagementMethod] ([IdSaleManagementMethod])
ALTER TABLE [Stock].[Article]
    ADD CONSTRAINT [FK_Article_AccountingAccount] FOREIGN KEY ([IdAccountingAccount]) REFERENCES [accounting].[AccountingAccount] ([Id])
ALTER TABLE [Sales].[SaleSettings]
    ADD CONSTRAINT [FK_SaleSetting_Company] FOREIGN KEY ([Id]) REFERENCES [Shared].[Company] ([Id])
ALTER TABLE [Stock].[Storage]
    ADD CONSTRAINT [FK_STORAGE_ASSOCIATI_SECTION] FOREIGN KEY ([IdSection]) REFERENCES [Stock].[Section] ([IdSection])
ALTER TABLE [Stock].[Storage]
    ADD CONSTRAINT [FK_STORAGE_ASSOCIATI_ARTICLE] FOREIGN KEY ([IdArticle]) REFERENCES [Stock].[Article] ([Id])
ALTER TABLE [ERPSettings].[CheckBoxComponent]
    ADD CONSTRAINT [FK_CheckBoxComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[DropDownListComponent]
    ADD CONSTRAINT [FK_DropDownListComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Administration].[AxisRelationShip]
    ADD CONSTRAINT [FK_AxisRelationShip_Axis1] FOREIGN KEY ([IdAxisParent]) REFERENCES [Administration].[Axis] ([Id])
ALTER TABLE [Administration].[AxisRelationShip]
    ADD CONSTRAINT [FK_AxisRelationShip_Axis] FOREIGN KEY ([IdAxis]) REFERENCES [Administration].[Axis] ([Id]) ON DELETE CASCADE
ALTER TABLE [Stock].[SerialNumber]
    ADD CONSTRAINT [FK_SerialNumber_Article1] FOREIGN KEY ([IdArticle]) REFERENCES [Stock].[Article] ([Id])
ALTER TABLE [Stock].[SerialNumber]
    ADD CONSTRAINT [FK_SerialNumber_Batch] FOREIGN KEY ([IdBatch]) REFERENCES [Stock].[Batch] ([IdBatch])
ALTER TABLE [ERPSettings].[FormComponent]
    ADD CONSTRAINT [FK_FormComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[FormComponent]
    ADD CONSTRAINT [FK_FormComponent_ServiceParameters] FOREIGN KEY ([IdServiceParameter]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [Administration].[CurrencyRate]
    ADD CONSTRAINT [FK_CurrencyRate_Currency] FOREIGN KEY ([IdCurrency]) REFERENCES [Administration].[Currency] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [ERPSettings].[ComboBoxOptions]
    ADD CONSTRAINT [FK_ComboBoxOptions_ComboBoxComponent] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[ComboBoxComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[RadioButtonComponentDetails]
    ADD CONSTRAINT [FK_RadioButtonComponentDetails_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[InputDatePickerOptions]
    ADD CONSTRAINT [FK_InputDatePickerOptions_InputComponent] FOREIGN KEY ([IdDatePickerOptions]) REFERENCES [ERPSettings].[InputComponent] ([IdComponent])
ALTER TABLE [Treasury].[DetailTimetable]
    ADD CONSTRAINT [FK_DetailTimetable_Timetable] FOREIGN KEY ([IdTimetable]) REFERENCES [Treasury].[Timetable] ([Id])
ALTER TABLE [Treasury].[DetailTimetable]
    ADD CONSTRAINT [FK_DetailTimetable_PaymentType] FOREIGN KEY ([IdPaymentType]) REFERENCES [Payment].[PaymentType] ([Id])
ALTER TABLE [ERPSettings].[ModuleByUser]
    ADD CONSTRAINT [FK_ModuleByUser_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByUser]
    ADD CONSTRAINT [FK_ModuleByUser_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ReportComponent]
    ADD CONSTRAINT [FK_ReportViewerComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[BarCodeComponent]
    ADD CONSTRAINT [FK_BarCodeComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[BarCodeComponent]
    ADD CONSTRAINT [FK_BarCodeComponent_InputComponent] FOREIGN KEY ([IdInputComponent]) REFERENCES [ERPSettings].[InputComponent] ([IdComponent])
ALTER TABLE [Payroll].[Contract]
    ADD CONSTRAINT [FK_Contract_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Payroll].[Contract]
    ADD CONSTRAINT [FK_Contract_PlannedPayroll] FOREIGN KEY ([IdPlannedPayroll]) REFERENCES [Payroll].[PlannedPayroll] ([Id])
ALTER TABLE [Payroll].[Contract]
    ADD CONSTRAINT [FK_Contract_SalaryStructure] FOREIGN KEY ([IdSalaryStructure]) REFERENCES [Payroll].[SalaryStructure] ([Id])
ALTER TABLE [Payroll].[Contract]
    WITH NOCHECK ADD CONSTRAINT [FK_Contract_Job] FOREIGN KEY ([IdJob]) REFERENCES [Payroll].[Job] ([Id])
ALTER TABLE [Payroll].[SalaryStructure]
    ADD CONSTRAINT [FK_SalaryStructure_SalaryStructureParent] FOREIGN KEY ([IdParent]) REFERENCES [Payroll].[SalaryStructure] ([Id])
ALTER TABLE [Inventory].[ItemWarehouse]
    ADD CONSTRAINT [FK_ItemWarehouse_Warehouse] FOREIGN KEY ([IdWarehouse]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [Inventory].[ItemWarehouse]
    ADD CONSTRAINT [FK_ItemWarehouse_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[DialogComponent]
    ADD CONSTRAINT [FK_DialogComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Shared].[City]
    ADD CONSTRAINT [FK_Ville_Pays] FOREIGN KEY ([IdPays]) REFERENCES [Shared].[Country] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payment].[SettlementCommitment]
    ADD CONSTRAINT [FK_SettlementCommitment_Settlement] FOREIGN KEY ([SettlementId]) REFERENCES [Payment].[Settlement] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payment].[SettlementCommitment]
    ADD CONSTRAINT [FK_SettlementCommitment_FinancialCommitment] FOREIGN KEY ([CommitmentId]) REFERENCES [Sales].[FinancialCommitment] ([Id])
ALTER TABLE [Inventory].[StockDocument]
    ADD CONSTRAINT [FK_StockDocument_Warehouse] FOREIGN KEY ([IdWarehouseDestination]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [Inventory].[StockDocument]
    ADD CONSTRAINT [FK_StockDocument_Warehouse1] FOREIGN KEY ([IdWarehouseSource]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [Inventory].[StockDocument]
    ADD CONSTRAINT [FK_StockDocument_TypeStockDocument] FOREIGN KEY ([TypeStockDocument]) REFERENCES [Inventory].[StockDocumentType] ([CodeType])
ALTER TABLE [Inventory].[StockDocument]
    ADD CONSTRAINT [FK_StockDocument_DocumentStatus] FOREIGN KEY ([IdDocumentStatus]) REFERENCES [Sales].[DocumentStatus] ([Id])
ALTER TABLE [Payroll].[CommercialsCustomerContract]
    ADD CONSTRAINT [FK_CommercialsCustomerContract_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Payroll].[CommercialsCustomerContract]
    ADD CONSTRAINT [FK_CommercialsCustomerContract_Prices] FOREIGN KEY ([IdPrices]) REFERENCES [Sales].[Prices] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payroll].[Manager]
    ADD CONSTRAINT [FK_Manager_Team] FOREIGN KEY ([IdTeam]) REFERENCES [Payroll].[Team] ([Id])
ALTER TABLE [Payroll].[Manager]
    ADD CONSTRAINT [FK_Manager_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [ERPSettings].[GridOptions]
    ADD CONSTRAINT [FK_GridOptions_GridComponent] FOREIGN KEY ([IdGridOptions]) REFERENCES [ERPSettings].[GridComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[GridComponent]
    ADD CONSTRAINT [FK_GridComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[InputComponent]
    ADD CONSTRAINT [FK_InputComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Payment].[WithholdingTaxLine]
    ADD CONSTRAINT [FK_WithholdingTaxLine_WithholdingTax] FOREIGN KEY ([IdWithholdingTax]) REFERENCES [Payment].[WithholdingTax] ([Id])
ALTER TABLE [Payment].[WithholdingTax]
    ADD CONSTRAINT [FK_WithholdingTax_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Shared].[ContactTypeDocument]
    ADD CONSTRAINT [FK_ContactTypeDocument_Contact] FOREIGN KEY ([IdContact]) REFERENCES [Shared].[Contact] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[ButtonComponent]
    ADD CONSTRAINT [FK_ButtonComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ButtonComponent]
    ADD CONSTRAINT [FK_ButtonComponent_ServiceParameters] FOREIGN KEY ([IdServiceParameter]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[LabelComponent]
    ADD CONSTRAINT [FK_LabelComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[FunctionnalityByUser]
    ADD CONSTRAINT [FK_FunctionnalityByUser_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityByUser]
    ADD CONSTRAINT [FK_FunctionnalityByUser_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payroll].[ParentInCharge]
    ADD CONSTRAINT [FK_ParentInCharge_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Payroll].[ParentInCharge]
    ADD CONSTRAINT [FK_ParentInCharge_ParentType] FOREIGN KEY ([IdParentType]) REFERENCES [Payroll].[ParentType] ([Id])
ALTER TABLE [Inventory].[Warehouse]
    ADD CONSTRAINT [FK_Warehouse_Warehouse] FOREIGN KEY ([IdWarehouseParent]) REFERENCES [Inventory].[Warehouse] ([Id])
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
ALTER TABLE [Sales].[Prices]
    ADD CONSTRAINT [FK_Prices_ContractServiceType] FOREIGN KEY ([IdContractServiceType]) REFERENCES [Sales].[ContractServiceType] ([Id])
ALTER TABLE [Inventory].[StockDocumentLine]
    ADD CONSTRAINT [FK_StockDocumentLine_StockDocument] FOREIGN KEY ([IdStockDocument]) REFERENCES [Inventory].[StockDocument] ([Id]) ON DELETE CASCADE
ALTER TABLE [Inventory].[StockDocumentLine]
    ADD CONSTRAINT [FK_StockDocumentLine_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id])
ALTER TABLE [Payroll].[Leave]
    ADD CONSTRAINT [FK_Leave_LeaveStatus] FOREIGN KEY ([IdLeaveStatus]) REFERENCES [Payroll].[LeaveStatus] ([Id])
ALTER TABLE [Payroll].[Leave]
    ADD CONSTRAINT [FK_Leave_LeaveType] FOREIGN KEY ([IdLeaveType]) REFERENCES [Payroll].[LeaveType] ([Id])
ALTER TABLE [Payroll].[Leave]
    ADD CONSTRAINT [FK_Leave_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Payroll].[Team]
    ADD CONSTRAINT [FK_Team_Department] FOREIGN KEY ([IdDepartment]) REFERENCES [Payroll].[Department] ([Id])
ALTER TABLE [Payroll].[SalaryStructure_SalaryRule]
    WITH NOCHECK ADD CONSTRAINT [FK_SalaryStructureRule_Rule] FOREIGN KEY ([IdRule]) REFERENCES [Payroll].[SalaryRule] ([Id])
ALTER TABLE [Payroll].[SalaryStructure_SalaryRule]
    ADD CONSTRAINT [FK_SalaryStructureRule_Structure] FOREIGN KEY ([IdStructure]) REFERENCES [Payroll].[SalaryStructure] ([Id])
ALTER TABLE [Payroll].[SalaryRule]
    WITH NOCHECK ADD CONSTRAINT [FK_SalaryRule_ContributionRegister] FOREIGN KEY ([IdContributionRegister]) REFERENCES [Payroll].[ContributionRegister] ([Id])
ALTER TABLE [Payroll].[SalaryRule]
    WITH NOCHECK ADD CONSTRAINT [FK_SalaryRule_RuleUniqueReference] FOREIGN KEY ([IdRuleUniqueReference]) REFERENCES [Payroll].[RuleUniqueReference] ([Id])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[QrCodeComponent]
    ADD CONSTRAINT [FK_QrCodeComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[QrCodeComponent]
    ADD CONSTRAINT [FK_QrCodeComponent_InputComponent] FOREIGN KEY ([IdInputComponent]) REFERENCES [ERPSettings].[InputComponent] ([IdComponent])
ALTER TABLE [Treasury].[ReceiptSpent]
    ADD CONSTRAINT [FK_ReceiptSpent_PaymentMethod] FOREIGN KEY ([IdPaymentMethod]) REFERENCES [Payment].[PaymentMethod] ([Id])
ALTER TABLE [Treasury].[ReceiptSpent]
    ADD CONSTRAINT [FK_RecipeSpent_PaymentDirection] FOREIGN KEY ([IdPaymentDirection]) REFERENCES [Treasury].[PaymentDirection] ([Id])
ALTER TABLE [Treasury].[ReceiptSpent]
    ADD CONSTRAINT [FK_RecipeSpent_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Shared].[Company]
    ADD CONSTRAINT [FK_Company_ZipCode] FOREIGN KEY ([IdZipCode]) REFERENCES [Shared].[ZipCode] ([Id])
ALTER TABLE [Shared].[Company]
    ADD CONSTRAINT [FK_Company_Currency] FOREIGN KEY ([IdCurrency]) REFERENCES [Administration].[Currency] ([Id])
ALTER TABLE [Shared].[Company]
    ADD CONSTRAINT [FK_Company_BankAccount] FOREIGN KEY ([IdBankAccount]) REFERENCES [Shared].[BankAccount] ([Id])
ALTER TABLE [Shared].[ZipCode]
    ADD CONSTRAINT [FK_ZipCode_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id])
ALTER TABLE [ERPSettings].[ToolBarComponent]
    ADD CONSTRAINT [FK_ComponentToolbarComponent] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ToolBarItem]
    ADD CONSTRAINT [FK_ToolBarItemToolBarOptions] FOREIGN KEY ([IdToolBarOptions]) REFERENCES [ERPSettings].[ToolBarOptions] ([IdToolBarOptions])
ALTER TABLE [ERPSettings].[ToolBarOptions]
    ADD CONSTRAINT [FK_ToolBarOptionsToolbarComponent] FOREIGN KEY ([IdToolBarOptions]) REFERENCES [ERPSettings].[ToolBarComponent] ([IdComponent])
ALTER TABLE [Stock].[StockMovement]
    ADD CONSTRAINT [FK_StockMovement_StockDocumentLine] FOREIGN KEY ([IdStockDocumentLine]) REFERENCES [Inventory].[StockDocumentLine] ([Id]) ON DELETE CASCADE
ALTER TABLE [Stock].[StockMovement]
    ADD CONSTRAINT [FK_StockMovement_Warehouse] FOREIGN KEY ([IdWarehouse]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [Stock].[StockMovement]
    ADD CONSTRAINT [FK_StockMovement_DocumentLine] FOREIGN KEY ([IdDocumentLine]) REFERENCES [Sales].[DocumentLine] ([Id])
ALTER TABLE [Stock].[StockMovement]
    ADD CONSTRAINT [FK_StockMovement_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id]) ON DELETE SET NULL
ALTER TABLE [Inventory].[Item]
    ADD CONSTRAINT [FK_Item_DiscountGroupItem] FOREIGN KEY ([IdDiscountGroupItem]) REFERENCES [Inventory].[DiscountGroupItem] ([Id])
ALTER TABLE [Inventory].[Item]
    ADD CONSTRAINT [FK_Item_UnitType] FOREIGN KEY ([IdUnitSales]) REFERENCES [Stock].[MeasureUnit] ([Id])
ALTER TABLE [Inventory].[Item]
    ADD CONSTRAINT [FK_Item_UnitType1] FOREIGN KEY ([IdUnitStock]) REFERENCES [Stock].[MeasureUnit] ([Id])
ALTER TABLE [Inventory].[Item]
    ADD CONSTRAINT [FK_Item_Nature] FOREIGN KEY ([IdNature]) REFERENCES [Inventory].[Nature] ([Id])
ALTER TABLE [Inventory].[Item]
    ADD CONSTRAINT [FK_Item_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [ERPSettings].[Relation]
    ADD CONSTRAINT [FK_Relation_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[DropDownListDataSource]
    ADD CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListOptions] ([IdDropDownListOptions])
ALTER TABLE [ERPSettings].[DropDownListDataSource]
    ADD CONSTRAINT [FK_DropDownListDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[DropDownListOptions]
    ADD CONSTRAINT [FK_DropDownListOptions_DropDownListComponent] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListComponent] ([IdComponent])
ALTER TABLE [Payment].[PaymentMethod]
    ADD CONSTRAINT [FK_PayementMethod_PayementType] FOREIGN KEY ([IdPaymentType]) REFERENCES [Payment].[PaymentType] ([Id])
ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_BankAccount] FOREIGN KEY ([IdBankAccount]) REFERENCES [Shared].[BankAccount] ([Id])
ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_DocumentStatus] FOREIGN KEY ([IdStatus]) REFERENCES [Sales].[DocumentStatus] ([Id])
ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_Currency] FOREIGN KEY ([IdUsedCurrency]) REFERENCES [Administration].[Currency] ([Id])
ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_PaymentMethod] FOREIGN KEY ([PaymentMeans]) REFERENCES [Payment].[PaymentMethod] ([Id])
ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Payroll].[EmployeeSkills]
    ADD CONSTRAINT [FK_EmployeeSkills_Skills] FOREIGN KEY ([IdSkills]) REFERENCES [Payroll].[Skills] ([Id])
ALTER TABLE [Payroll].[EmployeeSkills]
    ADD CONSTRAINT [FK_EmployeeSkills_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Sales].[TaxeGroupTiersConfig]
    ADD CONSTRAINT [FK_TaxeTiersConfig_TaxeGroupTiers] FOREIGN KEY ([IdTaxeGroupTiers]) REFERENCES [Sales].[TaxeGroupTiers] ([Id]) ON DELETE CASCADE
ALTER TABLE [Sales].[TaxeGroupTiersConfig]
    ADD CONSTRAINT [FK_TaxeTiersConfig_Taxe] FOREIGN KEY ([IdTaxe]) REFERENCES [Shared].[Taxe] ([Id])
ALTER TABLE [ERPSettings].[ComboBoxDataSourceItems]
    ADD CONSTRAINT [FK_ComboBoxDataSourceItems_ComboBoxDataSource] FOREIGN KEY ([IdComboBoxDataSource]) REFERENCES [ERPSettings].[ComboBoxDataSource] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxDataSource]
    ADD CONSTRAINT [FK_ComboBoxDataSource_ComboBoxOptions] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[ComboBoxOptions] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxDataSource]
    ADD CONSTRAINT [FK_ComboBoxDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[Filter]
    ADD CONSTRAINT [FK_Filter_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[ComponentByUser]
    ADD CONSTRAINT [FK_ComponentByUser_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[ComponentByUser]
    ADD CONSTRAINT [FK_ComponentByUser_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[User]
    ADD CONSTRAINT [FK_User_User] FOREIGN KEY ([IdUserParent]) REFERENCES [ERPSettings].[User] ([Id])
ALTER TABLE [ERPSettings].[GridDataSource]
    ADD CONSTRAINT [FK_GridDataSource_GridOptions] FOREIGN KEY ([IdGridOptions]) REFERENCES [ERPSettings].[GridOptions] ([IdGridOptions])
ALTER TABLE [ERPSettings].[GridDataSource]
    ADD CONSTRAINT [FK_GridDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [Immobilisation].[History]
    ADD CONSTRAINT [FK_History_Active] FOREIGN KEY ([IdActive]) REFERENCES [Immobilisation].[Active] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [Immobilisation].[History]
    ADD CONSTRAINT [FK_History_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [Treasury].[Timetable]
    ADD CONSTRAINT [FK_Timetable_PaymentType] FOREIGN KEY ([IdPaymentType]) REFERENCES [Payment].[PaymentType] ([Id])
ALTER TABLE [Treasury].[Timetable]
    ADD CONSTRAINT [FK_Timetable_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Inventory].[TaxeItem]
    ADD CONSTRAINT [FK_TaxeItem_Taxe] FOREIGN KEY ([IdTaxe]) REFERENCES [Shared].[Taxe] ([Id])
ALTER TABLE [Inventory].[TaxeItem]
    ADD CONSTRAINT [FK_TaxeItem_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id]) ON DELETE CASCADE
ALTER TABLE [Shared].[Taxe]
    ADD CONSTRAINT [FK_Taxe_TaxeType] FOREIGN KEY ([IdTaxeType]) REFERENCES [Shared].[TaxeType] ([Id])
ALTER TABLE [ERPSettings].[UserRole]
    ADD CONSTRAINT [FK_UserRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[UserRole]
    ADD CONSTRAINT [FK_UserRole_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE
ALTER TABLE [Sales].[DetailsSettlementMode]
    ADD CONSTRAINT [FK_DetailsSettlementMode_SettlementType] FOREIGN KEY ([IdSettlementType]) REFERENCES [Sales].[SettlementType] ([Id]) ON DELETE SET NULL
ALTER TABLE [Sales].[DetailsSettlementMode]
    ADD CONSTRAINT [FK_DetailsSettlementMode_PaymentMethod] FOREIGN KEY ([IdPaymentMethod]) REFERENCES [Payment].[PaymentMethod] ([Id]) ON DELETE SET NULL
ALTER TABLE [Sales].[DetailsSettlementMode]
    ADD CONSTRAINT [FK_DetailsSettlementMode_SettlementMode] FOREIGN KEY ([IdSettlementMode]) REFERENCES [Sales].[SettlementMode] ([Id]) ON DELETE SET NULL
ALTER TABLE [ERPSettings].[ServiceParameters]
    ADD CONSTRAINT [FK_ServiceParameters_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [Sales].[FinancialCommitment]
    ADD CONSTRAINT [FK_FinancialCommitment_DocumentStatus] FOREIGN KEY ([IdStatus]) REFERENCES [Sales].[DocumentStatus] ([Id])
ALTER TABLE [Sales].[FinancialCommitment]
    ADD CONSTRAINT [FK_FinancialCommitment_PaymentMethod] FOREIGN KEY ([IdPaymentMethod]) REFERENCES [Payment].[PaymentMethod] ([Id])
ALTER TABLE [Sales].[FinancialCommitment]
    ADD CONSTRAINT [FK_FinancialCommitment_Document] FOREIGN KEY ([IdDocument]) REFERENCES [Sales].[Document] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payroll].[IdentityPieces]
    ADD CONSTRAINT [FK_IdentityPieces_TypeIdentityPieces] FOREIGN KEY ([IdTypeIdentityPieces]) REFERENCES [Payroll].[TypeIdentityPieces] ([Id])
ALTER TABLE [Payroll].[IdentityPieces]
    ADD CONSTRAINT [FK_IdentityPieces_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
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
    WITH NOCHECK ADD CONSTRAINT [FK_Employee_Grade] FOREIGN KEY ([IdGrade]) REFERENCES [Payroll].[Grade] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Team] FOREIGN KEY ([IdTeam]) REFERENCES [Payroll].[Team] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_UpperHierarchy] FOREIGN KEY ([IdUpperHierarchy]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Shared].[Contact]
    ADD CONSTRAINT [FK_Contact_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id]) ON DELETE CASCADE
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_Tiers_Pays] FOREIGN KEY ([IdPays]) REFERENCES [Shared].[Country] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_Tiers_AccountingAccount] FOREIGN KEY ([IdAccountingAccount]) REFERENCES [accounting].[AccountingAccount] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_Tiers_TaxeGroupTiers] FOREIGN KEY ([IdTaxeGroupTiers]) REFERENCES [Sales].[TaxeGroupTiers] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_Tiers_DiscountGroupTiers] FOREIGN KEY ([IdDiscountGroupTiers]) REFERENCES [Sales].[DiscountGroupTiers] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_Tiers_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_Tiers_Currency] FOREIGN KEY ([IdCurrency]) REFERENCES [Administration].[Currency] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_TIERS_ASSOCIATI_PAYEMENT] FOREIGN KEY ([IdPaymentCondition]) REFERENCES [Payment].[PaymentCondition] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_TIERS_ASSOCIATI_TYPETIER] FOREIGN KEY ([IdTypeTiers]) REFERENCES [Sales].[TypeTiers] ([Id])

COMMIT TRANSACTION

---- Nihel: disable code field in employe, contract and payslip interfaces
BEGIN TRANSACTION
UPDATE [ERPSettings].[InputComponent] SET [required]=0, [ng_disabled]=1 WHERE [IdComponent]=N'66659962-d392-4d04-9e52-ed4aca93f64f'
UPDATE [ERPSettings].[InputComponent] SET [required]=0, [ng_disabled]=1 WHERE [IdComponent]=N'6bf0d400-7eb3-4dfa-b6c8-e79f1db31e1e'
UPDATE [ERPSettings].[InputComponent] SET [required]=0, [ng_disabled]=1 WHERE [IdComponent]=N'6ec179de-b0eb-401c-9e8a-45aa3a6fbcc0'
UPDATE [ERPSettings].[InputComponent] SET [required]=0, [ng_disabled]=1 WHERE [IdComponent]=N'88d19b1e-0962-4dc6-bb5b-e679b2fd44e3'
UPDATE [ERPSettings].[InputComponent] SET [required]=0, [ng_disabled]=1 WHERE [IdComponent]=N'b68fedf9-c8e2-45ab-8a24-ac9fe737cbd1'
UPDATE [ERPSettings].[InputComponent] SET [required]=0, [ng_disabled]=1 WHERE [IdComponent]=N'f5b1cc4d-162c-49ac-82b4-badebef1a180'
COMMIT TRANSACTION

---- Nihel: employee, contract and payslip codification
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (22, 339, NULL, NULL, 98)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (23, 356, NULL, NULL, 104)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (24, 353, NULL, NULL, 100)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (98, N'CodeEmployee', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (99, N'EmployeeCounter', 1, NULL, NULL, NULL, 98, 1, 1, N'0000', 4)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (100, N'CodePaySlip', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (101, N'PaySlipYear', 1, N'return (DateTime.Now.Year.ToString());', N'string', NULL, 100, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (102, N'PayslipCaractere-', 2, NULL, NULL, N'-', 100, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (103, N'PaySlipCounter', 3, NULL, NULL, NULL, 100, 1, 1, N'0000', 4)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (104, N'CodeContract', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (105, N'ContractConstant', 1, NULL, NULL, N'Contract-', 104, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (106, N'ContractCounter', 2, NULL, NULL, NULL, 104, 1, 1, N'0000', 4)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
COMMIT TRANSACTION
---- change matricule field type from int to string
BEGIN TRANSACTION
UPDATE [ERPSettings].[GridColumnComponent] SET [type]=N'string' WHERE [IdComponent]=N'3a838f09-a5cb-4d3b-b8f6-7932c905e9ee'
UPDATE [ERPSettings].[InputComponent] SET [inputType]=0, [k_format]=N'', [k_min]=N'', [k_decimals]=N'' WHERE [IdComponent]=N'66659962-d392-4d04-9e52-ed4aca93f64f'
UPDATE [ERPSettings].[InputComponent] SET [inputType]=0, [k_format]=N'', [k_min]=N'', [k_decimals]=N'' WHERE [IdComponent]=N'f5b1cc4d-162c-49ac-82b4-badebef1a180'
COMMIT TRANSACTION



---- Marwa: delete PaymentDate ---

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[GridColumnComponent] DROP CONSTRAINT [FK_GridColumnComponent_Component]
ALTER TABLE [ERPSettings].[ComponentByRole] DROP CONSTRAINT [FK_ComponentByRole_Component]
ALTER TABLE [ERPSettings].[ComponentByRole] DROP CONSTRAINT [FK_ComponentByRole_Role]
ALTER TABLE [ERPSettings].[InputComponent] DROP CONSTRAINT [FK_InputComponent_Component]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
DELETE FROM [ERPSettings].[GridColumnComponent] WHERE [IdComponent]=N'39e59cef-370d-4fb2-8b14-f339aa913a79'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'30c11f79-d493-4a53-896d-a41258dcc24e'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'39e59cef-370d-4fb2-8b14-f339aa913a79'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'f605aa47-2a89-423a-bd5f-b8ab9def01db'
DELETE FROM [ERPSettings].[InputComponent] WHERE [IdComponent]=N'30c11f79-d493-4a53-896d-a41258dcc24e'
DELETE FROM [ERPSettings].[InputComponent] WHERE [IdComponent]=N'f605aa47-2a89-423a-bd5f-b8ab9def01db'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'30c11f79-d493-4a53-896d-a41258dcc24e'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'39e59cef-370d-4fb2-8b14-f339aa913a79'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'f605aa47-2a89-423a-bd5f-b8ab9def01db'
UPDATE [ERPSettings].[Component] SET [rank]=5 WHERE [IdComponent]=N'270f086a-3581-4c7c-ba25-a39e59c36150'
UPDATE [ERPSettings].[Component] SET [rank]=4 WHERE [IdComponent]=N'3f2e7460-706a-4988-828c-2b55f2d024b2'
UPDATE [ERPSettings].[Component] SET [rank]=6 WHERE [IdComponent]=N'bed7894c-6c36-4d83-9dfd-b3b4fda7bf65'
ALTER TABLE [ERPSettings].[GridColumnComponent]
    ADD CONSTRAINT [FK_GridColumnComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ComponentByRole]
    ADD CONSTRAINT [FK_ComponentByRole_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ComponentByRole]
    ADD CONSTRAINT [FK_ComponentByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[InputComponent]
    ADD CONSTRAINT [FK_InputComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
COMMIT TRANSACTION


--Mohamed BOUZIDI Premium managment

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Relation] DROP CONSTRAINT [FK_Relation_PredicateFormat]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[CheckBoxComponent] DROP CONSTRAINT [FK_CheckBoxComponent_Component]
ALTER TABLE [ERPSettings].[ComboBoxOptions] DROP CONSTRAINT [FK_ComboBoxOptions_ComboBoxComponent]
ALTER TABLE [ERPSettings].[ComboBoxComponent] DROP CONSTRAINT [FK_ComboboxComponent_Component]
ALTER TABLE [ERPSettings].[GridColumnComponent] DROP CONSTRAINT [FK_GridColumnComponent_Component]
ALTER TABLE [ERPSettings].[ComponentByRole] DROP CONSTRAINT [FK_ComponentByRole_Component]
ALTER TABLE [ERPSettings].[ComponentByRole] DROP CONSTRAINT [FK_ComponentByRole_Role]
ALTER TABLE [ERPSettings].[GridButtonComponent] DROP CONSTRAINT [FK_GridButtonComponent_ServiceParameters]
ALTER TABLE [ERPSettings].[GridButtonComponent] DROP CONSTRAINT [FK_GridButtonComponent_Component]
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [FK_GridOptions_GridComponent]
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
ALTER TABLE [ERPSettings].[GridComponent] DROP CONSTRAINT [FK_GridComponent_Component]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[FormComponent] DROP CONSTRAINT [FK_FormComponent_Component]
ALTER TABLE [ERPSettings].[FormComponent] DROP CONSTRAINT [FK_FormComponent_ServiceParameters]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[ButtonComponent] DROP CONSTRAINT [FK_ButtonComponent_Component]
ALTER TABLE [ERPSettings].[ButtonComponent] DROP CONSTRAINT [FK_ButtonComponent_ServiceParameters]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [FK_GridDataSource_GridOptions]
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [FK_GridDataSource_ServiceParameters]
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [FK_ServiceParameters_PredicateFormat]
ALTER TABLE [ERPSettings].[ComboBoxDataSourceItems] DROP CONSTRAINT [FK_ComboBoxDataSourceItems_ComboBoxDataSource]
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [FK_ComboBoxDataSource_ComboBoxOptions]
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [FK_ComboBoxDataSource_ServiceParameters]
ALTER TABLE [ERPSettings].[Filter] DROP CONSTRAINT [FK_Filter_PredicateFormat]
ALTER TABLE [ERPSettings].[InputComponent] DROP CONSTRAINT [FK_InputComponent_Component]
UPDATE [ERPSettings].[Component] SET [rank]=18 WHERE [IdComponent]=N'04b06e7e-59cf-4952-9fbf-69515584ffce'
UPDATE [ERPSettings].[Component] SET [rank]=22 WHERE [IdComponent]=N'05590ee0-d652-49e5-93d6-24ebf7ca93fe'
UPDATE [ERPSettings].[Component] SET [rank]=28 WHERE [IdComponent]=N'06089db8-32bb-4b70-b5d2-1816bbdb3ab0'
UPDATE [ERPSettings].[Component] SET [rank]=13 WHERE [IdComponent]=N'0b8354dc-e3c0-4282-a286-5e867db82d24'
UPDATE [ERPSettings].[Component] SET [rank]=26 WHERE [IdComponent]=N'19fb677c-7304-44e5-b1d6-3879fc338a9a'
UPDATE [ERPSettings].[Component] SET [rank]=27 WHERE [IdComponent]=N'2345b846-7b3c-4be7-8ebb-66e5a92264e8'
UPDATE [ERPSettings].[Component] SET [rank]=23 WHERE [IdComponent]=N'2e3b020e-4b9f-4803-8558-5e5f6c60e8e9'
UPDATE [ERPSettings].[Component] SET [rank]=16 WHERE [IdComponent]=N'3409e0a2-f487-481f-9ecb-42a4a55b314b'
UPDATE [ERPSettings].[Component] SET [ComponentName]=N'AppearsOnPaySlip' WHERE [IdComponent]=N'38438358-79a4-4a11-ad34-6b5162d3458c'
UPDATE [ERPSettings].[Component] SET [rank]=7 WHERE [IdComponent]=N'41770a0e-38f0-446d-a1c4-8ec16a417bd9'
UPDATE [ERPSettings].[Component] SET [rank]=15 WHERE [IdComponent]=N'417b6c39-1ed2-4f9b-8358-6cafec964edc'
UPDATE [ERPSettings].[Component] SET [rank]=20 WHERE [IdComponent]=N'4b151128-218b-44c1-87ed-d8708c3cab38'
UPDATE [ERPSettings].[Component] SET [rank]=19 WHERE [IdComponent]=N'609e0571-75d6-47d6-8d47-a0ea1576557b'
UPDATE [ERPSettings].[Component] SET [rank]=25 WHERE [IdComponent]=N'856e427e-7cd6-40d4-b36b-d8242f4ac7fc'
UPDATE [ERPSettings].[Component] SET [rank]=27 WHERE [IdComponent]=N'9ce5f72e-f160-4032-a84f-d543cfaea7f3'
UPDATE [ERPSettings].[Component] SET [rank]=17 WHERE [IdComponent]=N'a3d81356-4f74-4b3d-bfcc-9ead596c2001'
UPDATE [ERPSettings].[Component] SET [rank]=29 WHERE [IdComponent]=N'abeb2693-a831-4c0e-94d4-1e24734c3f82'
UPDATE [ERPSettings].[Component] SET [rank]=21 WHERE [IdComponent]=N'd14aa9d2-e5cb-48df-bc78-b14efc1890e0'
UPDATE [ERPSettings].[Component] SET [rank]=24 WHERE [IdComponent]=N'd4ff81d4-e4a3-465a-9bef-2b091d061abd'
UPDATE [ERPSettings].[Component] SET [rank]=26 WHERE [IdComponent]=N'e5e0f3d0-0d98-4576-92da-4d128268fddd'
UPDATE [ERPSettings].[Component] SET [rank]=25 WHERE [IdComponent]=N'e9a800ed-1f13-46c0-b080-46399da92c97'
UPDATE [ERPSettings].[Component] SET [rank]=30 WHERE [IdComponent]=N'ea1f9039-adba-4029-8651-2f099adcac15'
UPDATE [ERPSettings].[Component] SET [rank]=14 WHERE [IdComponent]=N'ecb6bc33-3248-40c1-b2ff-30a127fc96b1'
UPDATE [ERPSettings].[Component] SET [ComponentName]=N'AppearsOnPaySlip' WHERE [IdComponent]=N'f68b956d-e4f9-4eb7-8193-e95edb3b7f54'
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'3168f817-11b4-4171-a2c0-4ffc832986b7', 0, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'4fe48462-f5be-4016-b640-89dd3b233491', 4, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, N'''n3''', N'0.1', NULL, N'3', N'0.1', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'532d597d-f8a1-4dc1-a0d6-2d92fcb82323', 0, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'5aae6e67-73d0-4046-9da0-10cc86d8d3bd', 0, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'5f793a38-f2ca-48dd-bab1-1381f7e4af59', 4, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, N'''n3''', N'0.1', NULL, N'3', N'0.1', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'a930c52d-d8a4-4735-b703-c839ee180267', 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'bb118446-f4cd-46d4-b08b-39aab4c21d47', 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'f9e3d2bb-6d37-4c61-8ef4-9bf64b0bc163', 0, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[PredicateFormat] ([IdPredicateFormat], [PredicateName], [Operator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'21bca8bd-081c-4965-a128-c03e3428d2d5', NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'01aab373-7481-4914-94c3-46b4f4c652c4', N'21bca8bd-081c-4965-a128-c03e3428d2d5', N'IsPremium', 1, N'1', 0, NULL, 0, NULL, NULL, 6)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'ae8b27a2-a617-47b6-9e1b-4798bf26f90c', N'21bca8bd-081c-4965-a128-c03e3428d2d5', N'Order', 5, N'0', 0, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComboBoxDataSource] ([IdComponent], [IdServiceParameters], [error], [autoSync], [pageSize], [serverPaging], [serverSorting], [serverFiltering], [serverGrouping], [serverAggregates], [IsStaticDataSource]) VALUES (N'5649d385-3c76-45b0-84da-e6d721512f95', NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 1)
INSERT INTO [ERPSettings].[ComboBoxDataSource] ([IdComponent], [IdServiceParameters], [error], [autoSync], [pageSize], [serverPaging], [serverSorting], [serverFiltering], [serverGrouping], [serverAggregates], [IsStaticDataSource]) VALUES (N'e242d580-186f-44b5-8fb5-e0b573d7e2c8', NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 1)
INSERT INTO [ERPSettings].[ComboBoxDataSourceItems] ([IdComboBoxDataSourceItems], [IdComboBoxDataSource], [Value], [Fr], [En]) VALUES (N'64c3c082-1164-462d-873f-b0040d13421c', N'e242d580-186f-44b5-8fb5-e0b573d7e2c8', N'false', N'Variable', N'Variable')
INSERT INTO [ERPSettings].[ComboBoxDataSourceItems] ([IdComboBoxDataSourceItems], [IdComboBoxDataSource], [Value], [Fr], [En]) VALUES (N'76f3bc10-ecf4-46e5-a9c8-a070e6c43e33', N'5649d385-3c76-45b0-84da-e6d721512f95', N'true', N'Fixe', N'Fixed')
INSERT INTO [ERPSettings].[ComboBoxDataSourceItems] ([IdComboBoxDataSourceItems], [IdComboBoxDataSource], [Value], [Fr], [En]) VALUES (N'903161da-6845-4e23-9695-1c4f1393c4ec', N'e242d580-186f-44b5-8fb5-e0b573d7e2c8', N'true', N'Fixe', N'Fixed')
INSERT INTO [ERPSettings].[ComboBoxDataSourceItems] ([IdComboBoxDataSourceItems], [IdComboBoxDataSource], [Value], [Fr], [En]) VALUES (N'e423b0f7-db78-4333-82f5-91288f8fc907', N'5649d385-3c76-45b0-84da-e6d721512f95', N'false', N'Variable', N'Variable')
INSERT INTO [ERPSettings].[ServiceParameters] ([IdServiceParameters], [Method], [URL], [TModel], [Module], [IdPredicateFormat], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'0a1b9a61-b983-4814-8265-48e3708fce75', N'GET', N'/api/base/get', N'Premium', N'PayRoll', NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[ServiceParameters] ([IdServiceParameters], [Method], [URL], [TModel], [Module], [IdPredicateFormat], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'4bbfecb3-152a-47c9-ab41-935d958c440e', N'PUT', N'/api/base/update', N'Premium', N'PayRoll', NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[ServiceParameters] ([IdServiceParameters], [Method], [URL], [TModel], [Module], [IdPredicateFormat], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'4bcfde9c-b78a-412c-8f41-3cebf955d510', N'DELETE', N'/api/base/delete/:id', N'Premium', N'PayRoll', NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[ServiceParameters] ([IdServiceParameters], [Method], [URL], [TModel], [Module], [IdPredicateFormat], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'd1b17471-40e5-47fa-b830-804e810b63cc', N'POST', N'/api/base/insert', N'Premium', N'PayRoll', NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[ServiceParameters] ([IdServiceParameters], [Method], [URL], [TModel], [Module], [IdPredicateFormat], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'fee3b4e6-d3c5-456b-8439-3b2445c4abdd', N'GET', N'/api/base/getById/:id', N'Premium', N'PayRoll', NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[GridDataSource] ([IdGridOptions], [IdServiceParameters], [error], [autoSync], [pageSize], [serverPaging], [serverSorting], [serverFiltering], [serverGrouping], [serverAggregates], [batch], [Id], [ParentId], [children], [hasChildrens], [expanded]) VALUES (N'f5e9da41-5ce8-4a46-a1d5-85dd2956ca36', N'0a1b9a61-b983-4814-8265-48e3708fce75', NULL, 0, 5, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'0563a4ce-dc23-45d8-8013-49b769d87e1a', 2, N'DIV2', 9, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', N'876fde38-2cb9-4d5b-ad79-2d730a1bd842', N'DIV2', N'DIV2_EN', N'DIV2_AR', N'DIV2_DE', N'DIV2_CH', N'DIV2_ES', NULL, N'', N'', N'', 0, NULL, N'SalaryRule', NULL, NULL, 1, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'0dcbdbc4-6bc1-4a35-b973-52cf1c777509', 1, N'BUTTON1', 7, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', N'6b126ebb-add3-4166-b24d-ee7e4fbfc15f', N'Retourner à la liste', N'Back to list', N'Retourner à la liste_AR', N'Retourner à la liste_DE', N'Retourner à la liste_CH', N'Retourner à la liste_ES', NULL, N'form-group col-lg-12 col-md-12 col-sm-12', N'', N'k-button', 0, NULL, N'Premium', NULL, NULL, 1, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'1c216d30-d100-4f52-91d0-788befc48e92', 1, N'Code', 4, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', N'f5e9da41-5ce8-4a46-a1d5-85dd2956ca36', N'Code', N'Code', N'', N'', N'', N'', NULL, N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'27aa5447-e119-416f-a7ca-af784acdcb0e', 1, N'GRIDBUTTON2', 16, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', N'd21ab973-6431-49cc-ba58-5db01cd94dde', N'Mettre à jour', N'Update', N'Update_AR', N'Update_DE', N'Update_CH', N'Update_ES', N'f8e3b5d8-aa96-43bc-b0f4-d1e94c6f6e01', N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'k-icon k-i-edit k-i-pencil', 1, NULL, N'Premium', N'color:cornflowerblue;', NULL, 1, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'304dcb57-3071-436b-a002-d3f0be3a4c8c', 1, N'DIV7', 9, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', N'7e352d30-d4ff-43f1-81b5-c0d6203652cb', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', N'row', 0, NULL, N'Premium', NULL, NULL, 1, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'3168f817-11b4-4171-a2c0-4ffc832986b7', 2, N'Name', 1, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', N'304dcb57-3071-436b-a002-d3f0be3a4c8c', N'Nom', N'Name', N'Name', N'Name', N'Reference', N'Reference', N'b532898e-7712-4db0-a15d-a42fe6fad548', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'k-textbox', 0, NULL, N'Premium', NULL, NULL, 1, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'36139e4c-8f3b-40c7-a2a1-3faed92de97e', 6, N'Contributory', 4, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', N'f5e9da41-5ce8-4a46-a1d5-85dd2956ca36', N'Cotisable', N'Contributory', N'', N'', N'', N'', NULL, N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'3d926aeb-ebab-4d15-9b5b-315eda0de0ed', 1, N'FORM1', 6, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', NULL, N'FORM1', N'FORM1_EN', N'FORM1_AR', N'FORM1_DE', N'FORM1_CH', N'FORM1_ES', NULL, N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'4438b92a-8c8a-4adf-956c-154a6d06a1e9', 1, N'DIVCONTAINER1', 17, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', N'757898df-4290-4f6f-b311-2e9dfe9c96b6', N'Ajouter prime', N'Add premium', N'', N'', N'', N'', NULL, N'', N'', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'4fe48462-f5be-4016-b640-89dd3b233491', 4, N'Valeur', 1, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', N'304dcb57-3071-436b-a002-d3f0be3a4c8c', N'Valeur', N'Value', N'', N'', N'', N'', N'b532898e-7712-4db0-a15d-a42fe6fad548', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'532d597d-f8a1-4dc1-a0d6-2d92fcb82323', 2, N'Name', 1, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', N'fc39a409-8af9-4e1f-bf5d-1ff3c4e8273e', N'Nom', N'Name', N'Name', N'Name', N'Reference', N'Reference', N'6942ab29-dfe3-4545-b19f-dffcf48100f2', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'k-textbox', 0, NULL, N'Premium', NULL, NULL, 1, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'5649d385-3c76-45b0-84da-e6d721512f95', 7, N'IsFixe', 11, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', N'304dcb57-3071-436b-a002-d3f0be3a4c8c', N'Type', N'Type', NULL, NULL, NULL, NULL, N'b532898e-7712-4db0-a15d-a42fe6fad548', N'form-group col-lg-3 col-md-6 col-sm-12 ', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'565b1e4e-740b-4735-8978-b7e7a9ceff13', 1, N'DIV1', 9, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', N'876fde38-2cb9-4d5b-ad79-2d730a1bd842', N'DIV1', N'DIV1_EN', N'DIV1_AR', N'DIV1_DE', N'DIV1_CH', N'DIV1_ES', NULL, N'', N'', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'5aae6e67-73d0-4046-9da0-10cc86d8d3bd', 1, N'Code', 1, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', N'fc39a409-8af9-4e1f-bf5d-1ff3c4e8273e', N'Code', N'Code', N'Code', N'Code', N'Code', N'Code', N'6942ab29-dfe3-4545-b19f-dffcf48100f2', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'k-textbox', 0, NULL, N'Premium', NULL, NULL, 1, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'5e8b0e6c-8f8a-4255-bd21-d1d01688500a', 2, N'DIV2', 9, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', N'c1c44ed7-eef8-40e2-be94-e49602b8e7e6', N'DIV2', N'DIV2', N'DIV2_AR', N'DIV2_DE', N'DIV2_CH', N'DIV2_ES', NULL, N'', N'', N'', 0, NULL, N'Premium', NULL, N'', 1, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'5f793a38-f2ca-48dd-bab1-1381f7e4af59', 4, N'Valeur', 1, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', N'fc39a409-8af9-4e1f-bf5d-1ff3c4e8273e', N'Valeur', N'Value', N'', N'', N'', N'', N'6942ab29-dfe3-4545-b19f-dffcf48100f2', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'60511f2d-e48c-431f-961b-04a07c1774fa', 1, N'BUTTON1', 7, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', N'd749daaf-9e16-47c3-bfcb-86de6346aae8', N'Ajouter prime', N'Add premium', N'', N'', N'', N'', NULL, N'form-group col-lg-4 col-md-4 col-sm-4', N'col-lg-4 col-md-4 col-sm-4', N'k-button', 0, NULL, N'Premium', NULL, NULL, 1, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'6942ab29-dfe3-4545-b19f-dffcf48100f2', 1, N'BUTTON1', 7, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', N'0563a4ce-dc23-45d8-8013-49b769d87e1a', N'Enregistrer', N'Save', N'Enregistrer_AR', N'Enregistrer_DE', N'Enregistrer_CH', N'Enregistrer_ES', NULL, N'form-group col-lg-12 col-md-12 col-sm-12', N'', N'k-button', 0, NULL, N'Premium', NULL, NULL, 1, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'6b126ebb-add3-4166-b24d-ee7e4fbfc15f', 1, N'DIV1', 9, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', N'f833d0af-79cd-4970-a3f9-21e624caed6c', N'DIV1', N'DIV1_EN', N'DIV1_AR', N'DIV1_DE', N'DIV1_CH', N'DIV1_ES', NULL, N'', N'', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'6da14c4e-d5d4-420f-9c20-477d83f36008', 2, N'DIV2', 9, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', N'f833d0af-79cd-4970-a3f9-21e624caed6c', N'DIV2', N'DIV2_EN', N'DIV2_AR', N'DIV2_DE', N'DIV2_CH', N'DIV2_ES', NULL, N'', N'', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'6e97ffec-a966-40c8-b258-4e21803aac64', 3, N'Valeur', 4, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', N'f5e9da41-5ce8-4a46-a1d5-85dd2956ca36', N'Valeur', N'Value', N'', N'', N'', N'', NULL, N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'6f04fb81-fc46-4621-a46b-5606f5b018c4', 4, N'Description', 4, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', N'f5e9da41-5ce8-4a46-a1d5-85dd2956ca36', N'Description', N'Description', N'', N'', N'', N'', NULL, N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'757898df-4290-4f6f-b311-2e9dfe9c96b6', 1, N'FORM1', 6, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', NULL, N'FORM1', N'FORM1_EN', N'FORM1_AR', N'FORM1_DE', N'FORM1_CH', N'FORM1_ES', NULL, N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'container-fluid', 0, NULL, N'Premium', NULL, NULL, 1, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'7b680039-34e2-4f60-b404-88306ef83e57', 5, N'IsContributory', 13, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', N'304dcb57-3071-436b-a002-d3f0be3a4c8c', N'Cotisable', N'Contributory', NULL, NULL, NULL, NULL, N'b532898e-7712-4db0-a15d-a42fe6fad548', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'7e352d30-d4ff-43f1-81b5-c0d6203652cb', 1, N'DIVCONTAINER1', 17, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', N'3d926aeb-ebab-4d15-9b5b-315eda0de0ed', N'Modifer prime', N'Modify premium', N'', N'', N'', N'', NULL, N'', N'', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'822714b1-c408-4293-a683-f561086c91b8', 5, N'Type', 4, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', N'f5e9da41-5ce8-4a46-a1d5-85dd2956ca36', N'Type', N'Type', N'', N'', N'', N'', NULL, N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'876fde38-2cb9-4d5b-ad79-2d730a1bd842', 2, N'DIV4', 9, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', N'757898df-4290-4f6f-b311-2e9dfe9c96b6', N'DIV4', N'DIV4_EN', N'DIV4_AR', N'DIV4_DE', N'DIV4_CH', N'DIV4_ES', NULL, N'', N'', N'btn-group', 0, NULL, N'Premium', N'float:right;', NULL, 1, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'88a8f6cd-686d-4abe-817c-854690d644d8', 6, N'IsTaxable', 13, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', N'304dcb57-3071-436b-a002-d3f0be3a4c8c', N'Imposable', N'Taxable', NULL, NULL, NULL, NULL, N'b532898e-7712-4db0-a15d-a42fe6fad548', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'a930c52d-d8a4-4735-b703-c839ee180267', 3, N'Description', 1, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', N'fc39a409-8af9-4e1f-bf5d-1ff3c4e8273e', N'Description', N'Description_EN', N'Description_AR', N'Description_DE', N'Description_CH', N'Description_ES ', N'6942ab29-dfe3-4545-b19f-dffcf48100f2', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'k-textbox', 0, NULL, N'Premium', N'height: 100px;', NULL, 1, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'b532898e-7712-4db0-a15d-a42fe6fad548', 1, N'BUTTON1', 7, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', N'6da14c4e-d5d4-420f-9c20-477d83f36008', N'Mettre à jour', N'Update', N'Enregistrer_AR', N'Enregistrer_DE', N'Enregistrer_CH', N'Enregistrer_ES', NULL, N'form-group col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'k-button', 0, NULL, N'Premium', NULL, NULL, 1, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'bb118446-f4cd-46d4-b08b-39aab4c21d47', 3, N'Description', 1, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', N'304dcb57-3071-436b-a002-d3f0be3a4c8c', N'Description', N'Description_EN', N'Description_AR', N'Description_DE', N'Description_CH', N'Description_ES ', N'b532898e-7712-4db0-a15d-a42fe6fad548', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'k-textbox', 0, NULL, N'Premium', N'height: 100px;', NULL, 1, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'c1c0f384-54af-410c-8939-f337926ecfb4', 7, N'Taxable', 4, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', N'f5e9da41-5ce8-4a46-a1d5-85dd2956ca36', N'Imposable', N'Taxable', N'', N'', N'', N'', NULL, N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'c1c44ed7-eef8-40e2-be94-e49602b8e7e6', 1, N'DIVCONTAINER1', 17, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', N'ce3fc6c9-9d25-494a-997c-595d6aef97f8', N'Liste des primes', N'List of the premiums', N'', N'', N'', N'', NULL, N'col-lg-12 col-md-12 col-sm-12', N'', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'ce3fc6c9-9d25-494a-997c-595d6aef97f8', 1, N'FORM1', 6, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', NULL, N'FORM1', N'FORM1', N'FORM1_AR', N'FORM1_DE', N'FORM1_CH', N'FORM1_ES', NULL, N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'd21ab973-6431-49cc-ba58-5db01cd94dde', 8, N'GRIDCOLUMN5', 4, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', N'f5e9da41-5ce8-4a46-a1d5-85dd2956ca36', N'GRIDCOLUMN5', N'GRIDCOLUMN5_EN', N'GRIDCOLUMN5_AR', N'GRIDCOLUMN5_DE', N'GRIDCOLUMN5_CH', N'GRIDCOLUMN5_ES', NULL, N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'd749daaf-9e16-47c3-bfcb-86de6346aae8', 1, N'DIV1', 9, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', N'c1c44ed7-eef8-40e2-be94-e49602b8e7e6', N'DIV1', N'DIV1', N'DIV1_AR', N'DIV1_DE', N'DIV1_CH', N'DIV1_ES', NULL, N'', N'', N'', 0, NULL, N'Premium', N'', NULL, 1, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'd9ca752c-b1be-4d00-a789-984e20aa1747', 1, N'BUTTON1', 7, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', N'565b1e4e-740b-4735-8978-b7e7a9ceff13', N'Retourner à la liste', N'Back to list', N'Retourner à la liste_AR', N'Retourner à la liste_DE', N'Retourner à la liste_CH', N'Retourner à la liste_ES', NULL, N'form-group col-lg-12 col-md-12 col-sm-12', N'', N'k-button', 0, NULL, N'Premium', NULL, NULL, 1, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'dfb6426c-7000-4b3b-b95a-1e839ea34665', 2, N'GRIDBUTTON2', 16, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', N'd21ab973-6431-49cc-ba58-5db01cd94dde', N'Supprimer', N'Delete', N'Supprimer_AR', N'Supprimer_DE', N'Supprimer_CH', N'Supprimer_ES', NULL, N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'k-icon k-i-delete k-i-trash', 1, NULL, N'Premium', N'color: indianred;', NULL, 1, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'e04973ac-1a84-47d8-ba51-317b1dcebddf', 2, N'Name', 4, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', N'f5e9da41-5ce8-4a46-a1d5-85dd2956ca36', N'Nom', N'Code', N'', N'', N'', N'', NULL, N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'e242d580-186f-44b5-8fb5-e0b573d7e2c8', 7, N'IsFixe', 11, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', N'fc39a409-8af9-4e1f-bf5d-1ff3c4e8273e', N'Type', N'Type', NULL, NULL, NULL, NULL, N'6942ab29-dfe3-4545-b19f-dffcf48100f2', N'form-group col-lg-3 col-md-6 col-sm-12 ', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'f51fc60d-1483-47d6-b011-d8a3fb2a5d3f', 5, N'IsContributory', 13, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', N'fc39a409-8af9-4e1f-bf5d-1ff3c4e8273e', N'Cotisable', N'Contributory', NULL, NULL, NULL, NULL, N'6942ab29-dfe3-4545-b19f-dffcf48100f2', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'f528a747-dab8-4815-91d4-89a1f4bc55f0', 6, N'IsTaxable', 13, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', N'fc39a409-8af9-4e1f-bf5d-1ff3c4e8273e', N'Imposable', N'Taxable', NULL, NULL, NULL, NULL, N'6942ab29-dfe3-4545-b19f-dffcf48100f2', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'f5e9da41-5ce8-4a46-a1d5-85dd2956ca36', 1, N'SalaryStructureTab', 3, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', N'5e8b0e6c-8f8a-4255-bd21-d1d01688500a', N'Prime', N'Premium', N'', N'', N'', N'', N'e793b94f-af29-4cdd-a8f7-0d7553eca4b0', N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'f833d0af-79cd-4970-a3f9-21e624caed6c', 2, N'DIV4', 9, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', N'3d926aeb-ebab-4d15-9b5b-315eda0de0ed', N'DIV4', N'DIV4_EN', N'DIV4_AR', N'DIV4_DE', N'DIV4_CH', N'DIV4_ES', NULL, N'', N'', N'btn-group', 0, NULL, N'Premium', N'float:right;', NULL, 1, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'f9e3d2bb-6d37-4c61-8ef4-9bf64b0bc163', 1, N'Code', 1, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', N'304dcb57-3071-436b-a002-d3f0be3a4c8c', N'Code', N'Code', N'Code', N'Code', N'Code', N'Code', N'b532898e-7712-4db0-a15d-a42fe6fad548', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'k-textbox', 0, NULL, N'Premium', NULL, NULL, 1, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'fc39a409-8af9-4e1f-bf5d-1ff3c4e8273e', 1, N'DIV7', 9, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', N'4438b92a-8c8a-4adf-956c-154a6d06a1e9', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', N'row', 0, NULL, N'Premium', NULL, NULL, 1, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', NULL)
INSERT INTO [ERPSettings].[ButtonComponent] ([IdComponent], [ng_model], [ng_click], [type], [ButtonType], [IdServiceParameter], [ngDisabled]) VALUES (N'0dcbdbc4-6bc1-4a35-b973-52cf1c777509', N'', N'bController.baseService.actionService.redirectionService.redirectTo(''/payroll/premium/list'')', N'submit', 0, NULL, NULL)
INSERT INTO [ERPSettings].[ButtonComponent] ([IdComponent], [ng_model], [ng_click], [type], [ButtonType], [IdServiceParameter], [ngDisabled]) VALUES (N'60511f2d-e48c-431f-961b-04a07c1774fa', N'', N'bController.baseService.actionService.redirectionService.redirectTo(''/payroll/premium/add'')', N'submit', 0, NULL, NULL)
INSERT INTO [ERPSettings].[ButtonComponent] ([IdComponent], [ng_model], [ng_click], [type], [ButtonType], [IdServiceParameter], [ngDisabled]) VALUES (N'6942ab29-dfe3-4545-b19f-dffcf48100f2', N'', N'bController.baseService.actionService.save(''6942ab29-dfe3-4545-b19f-dffcf48100f2'')', N'submit', 0, N'd1b17471-40e5-47fa-b830-804e810b63cc', NULL)
INSERT INTO [ERPSettings].[ButtonComponent] ([IdComponent], [ng_model], [ng_click], [type], [ButtonType], [IdServiceParameter], [ngDisabled]) VALUES (N'b532898e-7712-4db0-a15d-a42fe6fad548', N'', N'bController.baseService.actionService.save(''b532898e-7712-4db0-a15d-a42fe6fad548'')', N'submit', 0, N'4bbfecb3-152a-47c9-ab41-935d958c440e', NULL)
INSERT INTO [ERPSettings].[ButtonComponent] ([IdComponent], [ng_model], [ng_click], [type], [ButtonType], [IdServiceParameter], [ngDisabled]) VALUES (N'd9ca752c-b1be-4d00-a789-984e20aa1747', N'', N'bController.baseService.actionService.redirectionService.redirectTo(''/payroll/premium/list'')', N'submit', 0, NULL, NULL)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'51bf3865-133e-4e97-9f81-13564644742d', N'Premium', N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 12, N'Prime', N'Premium', N'Premium AR', N'Premium DE', N'Premium CH', N'Premium ES', N'icon-note', 1)
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute]) VALUES (N'78d5d270-ecd3-4013-a306-d881b94b0bdf', N'Premium-UPDATE', 2, N'Modifier prime', N'Modify premium', NULL, NULL, NULL, NULL, N'/payroll/premium/update', 0)
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute]) VALUES (N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', N'Premium-ADD', 1, N'Ajouter prime', N'Add premium', NULL, NULL, NULL, NULL, N'/payroll/premium/add', 0)
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute]) VALUES (N'e456ef1c-a28d-42a7-8324-ab5448f9139b', N'Premium-LIST', 4, N'Lister Prime', N'List premium', NULL, NULL, NULL, NULL, N'/payroll/premium/list', 1)
INSERT INTO [ERPSettings].[FormComponent] ([IdComponent], [k_rules], [ng_controller], [ng_submit], [data_ng_init], [IdServiceParameter], [NameSpace]) VALUES (N'3d926aeb-ebab-4d15-9b5b-315eda0de0ed', NULL, N'BaseController as bController', NULL, N'bController.baseService.initService.initView()', N'fee3b4e6-d3c5-456b-8439-3b2445c4abdd', N'Payroll.Premium')
INSERT INTO [ERPSettings].[FormComponent] ([IdComponent], [k_rules], [ng_controller], [ng_submit], [data_ng_init], [IdServiceParameter], [NameSpace]) VALUES (N'757898df-4290-4f6f-b311-2e9dfe9c96b6', NULL, N'BaseController as bController', NULL, N'bController.baseService.initService.initView()', NULL, N'Payroll.Premium')
INSERT INTO [ERPSettings].[FormComponent] ([IdComponent], [k_rules], [ng_controller], [ng_submit], [data_ng_init], [IdServiceParameter], [NameSpace]) VALUES (N'ce3fc6c9-9d25-494a-997c-595d6aef97f8', NULL, N'BaseController as bController', NULL, N'bController.baseService.initService.initView()', NULL, N'Payroll.Premium')

INSERT INTO [ERPSettings].[ModuleByRole] ([IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'51bf3865-133e-4e97-9f81-13564644742d', 1, 1)

INSERT INTO [ERPSettings].[GridComponent] ([IdComponent], [TreeType], [k_on_change]) VALUES (N'f5e9da41-5ce8-4a46-a1d5-85dd2956ca36', 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (362, N'Payroll', N'Premium', N'Premium', NULL, 0, N'Prime', N'Premium', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF
INSERT INTO [ERPSettings].[GridOptions] ([IdGridOptions], [name], [allowCopy], [altRowTemplate], [autoBind], [dataBound], [columnResizeHandleWidth], [columnMenu], [detailTemplate], [editable], [filterable], [groupable], [height], [mobile], [navigatable], [noRecords], [pageable], [reorderable], [resizable], [rowTemplate], [scrollable], [selectable], [sortable], [excel], [pdf], [checkboxes], [dataTextField], [select], [check], [expand], [loadOnDemand]) VALUES (N'f5e9da41-5ce8-4a46-a1d5-85dd2956ca36', NULL, 0, N'True', 1, NULL, NULL, 0, NULL, 0, 1, 1, 500, 0, 1, 0, 1, 0, 1, NULL, 1, N'0', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[GridButtonComponent] ([IdComponent], [ng_click], [type], [k_content], [IdServiceParameter]) VALUES (N'27aa5447-e119-416f-a7ca-af784acdcb0e', N'bController.baseService.actionService.redirectToEditForm(dataItem,''27aa5447-e119-416f-a7ca-af784acdcb0e'')', N'submit', N'{{''27aa5447-e119-416f-a7ca-af784acdcb0e'' | translate }}', NULL)
INSERT INTO [ERPSettings].[GridButtonComponent] ([IdComponent], [ng_click], [type], [k_content], [IdServiceParameter]) VALUES (N'dfb6426c-7000-4b3b-b95a-1e839ea34665', N'bController.baseService.actionService.delete(dataItem,''dfb6426c-7000-4b3b-b95a-1e839ea34665'',''f5e9da41-5ce8-4a46-a1d5-85dd2956ca36'')', N'submit', N'{{''dfb6426c-7000-4b3b-b95a-1e839ea34665'' | translate }}', N'4bcfde9c-b78a-412c-8f41-3cebf955d510')


INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'ce3fc6c9-9d25-494a-997c-595d6aef97f8', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'c1c44ed7-eef8-40e2-be94-e49602b8e7e6', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'5e8b0e6c-8f8a-4255-bd21-d1d01688500a', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'f5e9da41-5ce8-4a46-a1d5-85dd2956ca36', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'1c216d30-d100-4f52-91d0-788befc48e92', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'36139e4c-8f3b-40c7-a2a1-3faed92de97e', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'd21ab973-6431-49cc-ba58-5db01cd94dde', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'27aa5447-e119-416f-a7ca-af784acdcb0e', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'6e97ffec-a966-40c8-b258-4e21803aac64', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'822714b1-c408-4293-a683-f561086c91b8', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'c1c0f384-54af-410c-8939-f337926ecfb4', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'd749daaf-9e16-47c3-bfcb-86de6346aae8', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'60511f2d-e48c-431f-961b-04a07c1774fa', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'e04973ac-1a84-47d8-ba51-317b1dcebddf', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'757898df-4290-4f6f-b311-2e9dfe9c96b6', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'4438b92a-8c8a-4adf-956c-154a6d06a1e9', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'fc39a409-8af9-4e1f-bf5d-1ff3c4e8273e', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'5f793a38-f2ca-48dd-bab1-1381f7e4af59', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'5aae6e67-73d0-4046-9da0-10cc86d8d3bd', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'a930c52d-d8a4-4735-b703-c839ee180267', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'532d597d-f8a1-4dc1-a0d6-2d92fcb82323', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'876fde38-2cb9-4d5b-ad79-2d730a1bd842', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'565b1e4e-740b-4735-8978-b7e7a9ceff13', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'd9ca752c-b1be-4d00-a789-984e20aa1747', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'0563a4ce-dc23-45d8-8013-49b769d87e1a', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'6942ab29-dfe3-4545-b19f-dffcf48100f2', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'6f04fb81-fc46-4621-a46b-5606f5b018c4', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'f51fc60d-1483-47d6-b011-d8a3fb2a5d3f', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'f528a747-dab8-4815-91d4-89a1f4bc55f0', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'dfb6426c-7000-4b3b-b95a-1e839ea34665', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'3d926aeb-ebab-4d15-9b5b-315eda0de0ed', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'6da14c4e-d5d4-420f-9c20-477d83f36008', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'b532898e-7712-4db0-a15d-a42fe6fad548', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'304dcb57-3071-436b-a002-d3f0be3a4c8c', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'f9e3d2bb-6d37-4c61-8ef4-9bf64b0bc163', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'4fe48462-f5be-4016-b640-89dd3b233491', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'3168f817-11b4-4171-a2c0-4ffc832986b7', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'88a8f6cd-686d-4abe-817c-854690d644d8', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'bb118446-f4cd-46d4-b08b-39aab4c21d47', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'7b680039-34e2-4f60-b404-88306ef83e57', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'7e352d30-d4ff-43f1-81b5-c0d6203652cb', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'f833d0af-79cd-4970-a3f9-21e624caed6c', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'6b126ebb-add3-4166-b24d-ee7e4fbfc15f', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'0dcbdbc4-6bc1-4a35-b973-52cf1c777509', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'e242d580-186f-44b5-8fb5-e0b573d7e2c8', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'5649d385-3c76-45b0-84da-e6d721512f95', 1, 1, NULL, NULL, NULL)


INSERT INTO [ERPSettings].[GridColumnComponent] ([IdComponent], [field], [title], [width], [format], [groupHeaderTemplate], [hidden], [template], [nullable], [type], [editable], [defaultValue], [menu], [headerTemplate], [filterable], [sortable]) VALUES (N'1c216d30-d100-4f52-91d0-788befc48e92', N'Code', N'{{''1c216d30-d100-4f52-91d0-788befc48e92'' | translate }}', NULL, NULL, N'#= value #', 0, NULL, 0, N'', 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[GridColumnComponent] ([IdComponent], [field], [title], [width], [format], [groupHeaderTemplate], [hidden], [template], [nullable], [type], [editable], [defaultValue], [menu], [headerTemplate], [filterable], [sortable]) VALUES (N'36139e4c-8f3b-40c7-a2a1-3faed92de97e', N'IsContributory', N'{{''36139e4c-8f3b-40c7-a2a1-3faed92de97e'' | translate }}', NULL, NULL, N'#= value #', 0, N'<span class="ng-binding" >#= IsContributory? value=''{{\''9016\'' | translate }}'' : value=''{{\''9017\'' | translate }}''#</span>', 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[GridColumnComponent] ([IdComponent], [field], [title], [width], [format], [groupHeaderTemplate], [hidden], [template], [nullable], [type], [editable], [defaultValue], [menu], [headerTemplate], [filterable], [sortable]) VALUES (N'6e97ffec-a966-40c8-b258-4e21803aac64', N'Valeur', N'{{''6e97ffec-a966-40c8-b258-4e21803aac64'' | translate }}', NULL, NULL, N'#= value #', 0, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[GridColumnComponent] ([IdComponent], [field], [title], [width], [format], [groupHeaderTemplate], [hidden], [template], [nullable], [type], [editable], [defaultValue], [menu], [headerTemplate], [filterable], [sortable]) VALUES (N'6f04fb81-fc46-4621-a46b-5606f5b018c4', N'Description', N'{{''6f04fb81-fc46-4621-a46b-5606f5b018c4'' | translate }}', NULL, NULL, N'#= value #', 0, NULL, 0, N'', 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[GridColumnComponent] ([IdComponent], [field], [title], [width], [format], [groupHeaderTemplate], [hidden], [template], [nullable], [type], [editable], [defaultValue], [menu], [headerTemplate], [filterable], [sortable]) VALUES (N'822714b1-c408-4293-a683-f561086c91b8', N'IsFixe', N'{{''822714b1-c408-4293-a683-f561086c91b8'' | translate }}', NULL, NULL, N'#= value #', 0, N'<span class="ng-binding" >#= IsFixe? value=''{{\''76f3bc10-ecf4-46e5-a9c8-a070e6c43e33\'' | translate }}'' : value=''{{\''64c3c082-1164-462d-873f-b0040d13421c\'' | translate }}''#</span>', 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[GridColumnComponent] ([IdComponent], [field], [title], [width], [format], [groupHeaderTemplate], [hidden], [template], [nullable], [type], [editable], [defaultValue], [menu], [headerTemplate], [filterable], [sortable]) VALUES (N'c1c0f384-54af-410c-8939-f337926ecfb4', N'IsTaxable', N'{{''c1c0f384-54af-410c-8939-f337926ecfb4'' | translate }}', NULL, NULL, N'#= value #', 0, N'<span class="ng-binding" >#= IsTaxable ? value=''{{\''9016\'' | translate }}'' : value=''{{\''9017\'' | translate }}''#</span>', 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[GridColumnComponent] ([IdComponent], [field], [title], [width], [format], [groupHeaderTemplate], [hidden], [template], [nullable], [type], [editable], [defaultValue], [menu], [headerTemplate], [filterable], [sortable]) VALUES (N'd21ab973-6431-49cc-ba58-5db01cd94dde', NULL, N'{{''d21ab973-6431-49cc-ba58-5db01cd94dde'' | translate }}', NULL, NULL, N'#= value #', 0, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[GridColumnComponent] ([IdComponent], [field], [title], [width], [format], [groupHeaderTemplate], [hidden], [template], [nullable], [type], [editable], [defaultValue], [menu], [headerTemplate], [filterable], [sortable]) VALUES (N'e04973ac-1a84-47d8-ba51-317b1dcebddf', N'Name', N'{{''e04973ac-1a84-47d8-ba51-317b1dcebddf'' | translate }}', NULL, NULL, N'#= value #', 0, NULL, 0, N'', 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComboBoxComponent] ([IdComponent], [ng_model], [required], [ng_disabled], [ng_bind], [ng_blur], [placeholder], [k_option_label], [k_on_change], [k_data_text_field], [k_data_value_field], [k_filter], [k_autoBind], [k_data_source], [globalization]) VALUES (N'5649d385-3c76-45b0-84da-e6d721512f95', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT INTO [ERPSettings].[ComboBoxComponent] ([IdComponent], [ng_model], [required], [ng_disabled], [ng_bind], [ng_blur], [placeholder], [k_option_label], [k_on_change], [k_data_text_field], [k_data_value_field], [k_filter], [k_autoBind], [k_data_source], [globalization]) VALUES (N'e242d580-186f-44b5-8fb5-e0b573d7e2c8', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT INTO [ERPSettings].[ComboBoxOptions] ([IdComponent], [autoBind], [dataTextField], [dataValueField], [delay], [enable], [filter], [fixedGroupTemplate], [groupTemplate], [height], [headerTemplate], [template], [valueTemplate], [footerTemplate], [change], [close], [dataBound], [filtering], [open], [select], [name]) VALUES (N'5649d385-3c76-45b0-84da-e6d721512f95', 1, N'Text', N'Value', NULL, 1, N'contains', NULL, NULL, 300, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComboBoxOptions] ([IdComponent], [autoBind], [dataTextField], [dataValueField], [delay], [enable], [filter], [fixedGroupTemplate], [groupTemplate], [height], [headerTemplate], [template], [valueTemplate], [footerTemplate], [change], [close], [dataBound], [filtering], [open], [select], [name]) VALUES (N'e242d580-186f-44b5-8fb5-e0b573d7e2c8', 1, N'Text', N'Value', NULL, 1, N'contains', NULL, NULL, 300, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[CheckBoxComponent] ([IdComponent], [Checked], [ng_change]) VALUES (N'7b680039-34e2-4f60-b404-88306ef83e57', 1, NULL)
INSERT INTO [ERPSettings].[CheckBoxComponent] ([IdComponent], [Checked], [ng_change]) VALUES (N'88a8f6cd-686d-4abe-817c-854690d644d8', 1, NULL)
INSERT INTO [ERPSettings].[CheckBoxComponent] ([IdComponent], [Checked], [ng_change]) VALUES (N'f51fc60d-1483-47d6-b011-d8a3fb2a5d3f', 1, NULL)
INSERT INTO [ERPSettings].[CheckBoxComponent] ([IdComponent], [Checked], [ng_change]) VALUES (N'f528a747-dab8-4815-91d4-89a1f4bc55f0', 1, NULL)

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'e456ef1c-a28d-42a7-8324-ab5448f9139b', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', 1, 1, 1, NULL)
INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES ( N'78d5d270-ecd3-4013-a306-d881b94b0bdf', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[Relation] ([IdRelation], [IdPredicateFormat], [Prop], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'96821996-e138-44e8-8494-2b05174c215d', N'21bca8bd-081c-4965-a128-c03e3428d2d5', N'IdRuleUniqueReferenceNavigation', NULL, 0, NULL)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'155f5c74-ce53-4bfd-8248-1cc97c5de05f', N'78d5d270-ecd3-4013-a306-d881b94b0bdf', N'51bf3865-133e-4e97-9f81-13564644742d')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'173d9931-b959-4ef6-b3f0-f938e064f89d', N'e456ef1c-a28d-42a7-8324-ab5448f9139b', N'51bf3865-133e-4e97-9f81-13564644742d')
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'dd37afe3-3f6f-4586-87f4-79939163f84e', N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', N'51bf3865-133e-4e97-9f81-13564644742d')
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9016, N'Oui', N'Yes', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9017, N'Non', N'No', NULL, NULL, NULL, NULL, NULL, 0, NULL)
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Relation]
    ADD CONSTRAINT [FK_Relation_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[CheckBoxComponent]
    ADD CONSTRAINT [FK_CheckBoxComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxOptions]
    ADD CONSTRAINT [FK_ComboBoxOptions_ComboBoxComponent] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[ComboBoxComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxComponent]
    ADD CONSTRAINT [FK_ComboboxComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[GridColumnComponent]
    ADD CONSTRAINT [FK_GridColumnComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ComponentByRole]
    ADD CONSTRAINT [FK_ComponentByRole_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ComponentByRole]
    ADD CONSTRAINT [FK_ComponentByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[GridButtonComponent]
    ADD CONSTRAINT [FK_GridButtonComponent_ServiceParameters] FOREIGN KEY ([IdServiceParameter]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[GridButtonComponent]
    ADD CONSTRAINT [FK_GridButtonComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[GridOptions]
    ADD CONSTRAINT [FK_GridOptions_GridComponent] FOREIGN KEY ([IdGridOptions]) REFERENCES [ERPSettings].[GridComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[GridComponent]
    ADD CONSTRAINT [FK_GridComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FormComponent]
    ADD CONSTRAINT [FK_FormComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[FormComponent]
    ADD CONSTRAINT [FK_FormComponent_ServiceParameters] FOREIGN KEY ([IdServiceParameter]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ButtonComponent]
    ADD CONSTRAINT [FK_ButtonComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ButtonComponent]
    ADD CONSTRAINT [FK_ButtonComponent_ServiceParameters] FOREIGN KEY ([IdServiceParameter]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[GridDataSource]
    ADD CONSTRAINT [FK_GridDataSource_GridOptions] FOREIGN KEY ([IdGridOptions]) REFERENCES [ERPSettings].[GridOptions] ([IdGridOptions])
ALTER TABLE [ERPSettings].[GridDataSource]
    ADD CONSTRAINT [FK_GridDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[ServiceParameters]
    ADD CONSTRAINT [FK_ServiceParameters_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[ComboBoxDataSourceItems]
    ADD CONSTRAINT [FK_ComboBoxDataSourceItems_ComboBoxDataSource] FOREIGN KEY ([IdComboBoxDataSource]) REFERENCES [ERPSettings].[ComboBoxDataSource] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxDataSource]
    ADD CONSTRAINT [FK_ComboBoxDataSource_ComboBoxOptions] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[ComboBoxOptions] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxDataSource]
    ADD CONSTRAINT [FK_ComboBoxDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[Filter]
    ADD CONSTRAINT [FK_Filter_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[InputComponent]
    ADD CONSTRAINT [FK_InputComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
COMMIT TRANSACTION



---- Marwa : Reporting paie ---
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[ComboBoxOptions] DROP CONSTRAINT [FK_ComboBoxOptions_ComboBoxComponent]
ALTER TABLE [ERPSettings].[ComboBoxComponent] DROP CONSTRAINT [FK_ComboboxComponent_Component]
ALTER TABLE [ERPSettings].[ComponentByRole] DROP CONSTRAINT [FK_ComponentByRole_Component]
ALTER TABLE [ERPSettings].[ComponentByRole] DROP CONSTRAINT [FK_ComponentByRole_Role]
ALTER TABLE [ERPSettings].[CheckBoxComponent] DROP CONSTRAINT [FK_CheckBoxComponent_Component]
ALTER TABLE [ERPSettings].[InputComponent] DROP CONSTRAINT [FK_InputComponent_Component]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
ALTER TABLE [ERPSettings].[ComboBoxDataSourceItems] DROP CONSTRAINT [FK_ComboBoxDataSourceItems_ComboBoxDataSource]
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [FK_ComboBoxDataSource_ComboBoxOptions]
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [FK_ComboBoxDataSource_ServiceParameters]
DELETE FROM [ERPSettings].[ComboBoxOptions] WHERE [IdComponent]=N'5a09706c-e7cf-4273-bb10-1448e9135bb4'
DELETE FROM [ERPSettings].[ComboBoxOptions] WHERE [IdComponent]=N'fa3a4471-6c62-407b-adea-9c6b757c1f98'
DELETE FROM [ERPSettings].[ComboBoxComponent] WHERE [IdComponent]=N'5a09706c-e7cf-4273-bb10-1448e9135bb4'
DELETE FROM [ERPSettings].[ComboBoxComponent] WHERE [IdComponent]=N'fa3a4471-6c62-407b-adea-9c6b757c1f98'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'5a09706c-e7cf-4273-bb10-1448e9135bb4'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'fa3a4471-6c62-407b-adea-9c6b757c1f98'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'5a09706c-e7cf-4273-bb10-1448e9135bb4'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'fa3a4471-6c62-407b-adea-9c6b757c1f98'
DELETE FROM [ERPSettings].[ComboBoxDataSourceItems] WHERE [IdComboBoxDataSourceItems]=N'007d39ed-586b-4b4a-9587-44d4da744215'
DELETE FROM [ERPSettings].[ComboBoxDataSourceItems] WHERE [IdComboBoxDataSourceItems]=N'a0c9192c-c4f8-4f71-ae02-68d20a6a959a'
DELETE FROM [ERPSettings].[ComboBoxDataSourceItems] WHERE [IdComboBoxDataSourceItems]=N'e0fe9495-dd47-4299-9785-c245ce8fe6c7'
DELETE FROM [ERPSettings].[ComboBoxDataSourceItems] WHERE [IdComboBoxDataSourceItems]=N'e8255017-c169-450f-8b89-d2872538a5e2'
DELETE FROM [ERPSettings].[ComboBoxDataSource] WHERE [IdComponent]=N'5a09706c-e7cf-4273-bb10-1448e9135bb4'
DELETE FROM [ERPSettings].[ComboBoxDataSource] WHERE [IdComponent]=N'fa3a4471-6c62-407b-adea-9c6b757c1f98'
UPDATE [ERPSettings].[Component] SET [rank]=4 WHERE [IdComponent]=N'1156eccb-e4d5-4009-bf0a-e7e459ee9d51'
UPDATE [ERPSettings].[Component] SET [rank]=3, [IdComponentParent]=N'88b222d7-4861-4b99-98da-8b219e30e746' WHERE [IdComponent]=N'21a9f7c8-c0bc-45fe-8494-b05271f3a14c'
UPDATE [ERPSettings].[Component] SET [rank]=1 WHERE [IdComponent]=N'28afaa65-8331-4d0e-bcfe-e1c416a13801'
UPDATE [ERPSettings].[Component] SET [rank]=3, [IdComponentParent]=N'74422c96-1908-46ee-bff2-f189f8ee495a' WHERE [IdComponent]=N'2c7f8103-b231-48e3-bdb6-e42f47e1f7ce'
UPDATE [ERPSettings].[Component] SET [rank]=4 WHERE [IdComponent]=N'2d0d6014-a085-43d7-bd9c-6f5abbb36031'
UPDATE [ERPSettings].[Component] SET [rank]=3 WHERE [IdComponent]=N'3bd370b2-4b70-43cc-97c0-9d184e018183'
UPDATE [ERPSettings].[Component] SET [rank]=1 WHERE [IdComponent]=N'5ecf290d-58b9-451e-8b07-89148d142ccd'
UPDATE [ERPSettings].[Component] SET [rank]=2 WHERE [IdComponent]=N'66659962-d392-4d04-9e52-ed4aca93f64f'
UPDATE [ERPSettings].[Component] SET [rank]=3 WHERE [IdComponent]=N'87120823-97e8-4556-9527-530371fa31af'
UPDATE [ERPSettings].[Component] SET [rank]=3 WHERE [IdComponent]=N'b5d274ba-7936-49cc-85a2-5e9e08e71979'
UPDATE [ERPSettings].[Component] SET [rank]=2 WHERE [IdComponent]=N'f5b1cc4d-162c-49ac-82b4-badebef1a180'
UPDATE [ERPSettings].[Component] SET [rank]=3 WHERE [IdComponent]=N'fb9a3338-52c6-4e50-9c7d-31c71c632641'
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'0ecf1de3-ec62-489c-83e9-2c17d9124136', 10, N'CnssAffiliation', 1, N'da8aecae-09e6-4f74-bfab-314673238ac1', N'f61cb437-5259-4087-925e-246453a85a1d', N'Affiliation CNSS', N'CNSS Affiliation', N'Affiliation CNSS_AR', N'Affiliation CNSS_DE', N'Affiliation CNSS_CH', N'Affiliation CNSS_ES', N'efe48036-e6b0-442c-b7ce-282bd77e8d71', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12 ', N'k-textbox', 0, NULL, N'Company', N'', NULL, 1, N'da8aecae-09e6-4f74-bfab-314673238ac1', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'2e511394-1ce0-45f1-92d4-26c7ebafa511', 2, N'HiringDate', 1, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', N'401dbbe5-41b6-414a-80dc-2b275a3a91e9', N'Date d''embauche', N'Hiring Date', N'Date d''embauche', N'Date d''embauche', N'Date d''embauche', N'Date d''embauche', N'dd223655-4ec6-4514-b1d7-c20ba191e638', N'form-group col-lg-6 col-md-6 col-sm-12 ', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'Employee', NULL, NULL, 1, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'37013f30-6081-41ff-8423-dfdf35000742', 2, N'DIV2', 9, N'4915c87a-4c0a-4635-beb4-6626d46415c2', N'012d7733-0973-455b-939d-b89510162438', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', N'row', 0, NULL, N'Employee', NULL, NULL, 1, N'4915c87a-4c0a-4635-beb4-6626d46415c2', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'401dbbe5-41b6-414a-80dc-2b275a3a91e9', 2, N'DIV2', 9, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', N'a6af5a38-40d3-4ccb-a754-94c5e0d71fbb', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', N'row', 0, NULL, N'Employee', NULL, NULL, 1, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'437c3427-65b4-43b7-9bed-59dec9a510d6', 1, N'Category', 1, N'4915c87a-4c0a-4635-beb4-6626d46415c2', N'37013f30-6081-41ff-8423-dfdf35000742', N'Catégorie', N'Category', N'Catégorie', N'Catégorie', N'Catégorie', N'Catégorie', N'1301c855-d07e-480c-a003-749357444c4a', N'form-group col-lg-6 col-md-12 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'k-textbox', 0, NULL, N'Employee', NULL, NULL, 1, N'4915c87a-4c0a-4635-beb4-6626d46415c2', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'74422c96-1908-46ee-bff2-f189f8ee495a', 2, N'DIV3', 9, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', N'dabba246-8ee7-493c-ac73-96f201863d9e', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', N'row', 0, NULL, N'Employee', NULL, NULL, 1, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'7d883e00-c08d-44ec-9a35-90e155879455', 1, N'NumberDaysWorked', 1, N'0acce7c4-1da6-4276-a199-a4db6270bfd7', N'88b222d7-4861-4b99-98da-8b219e30e746', N'Nombre de jours travaillés', N'Number of Days Worked', NULL, NULL, NULL, NULL, N'019d04b1-234d-4b71-afa3-ef11f67559c2', N'form-group col-lg-6 col-md-6 col-sm-12 ', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'Payslip', NULL, NULL, 1, N'0acce7c4-1da6-4276-a199-a4db6270bfd7', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'83275351-e2dd-4045-ae42-a4576925fc71', 1, N'Cin', 1, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', N'41b877b8-7ee0-473a-a9b4-c93b48c59d48', N'CIN', N'CIN', N'CIN', N'CIN', N'CIN', N'CIN', N'dd223655-4ec6-4514-b1d7-c20ba191e638', N'form-group col-lg-3 col-md-6 col-sm-12 ', N'col-lg-12 col-md-12 col-sm-12', N'k-textbox', 0, NULL, N'Employee', NULL, NULL, 1, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'88b222d7-4861-4b99-98da-8b219e30e746', 2, N'DIV3', 9, N'0acce7c4-1da6-4276-a199-a4db6270bfd7', N'a0c075b3-061b-4336-8fe3-05db1b354358', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', N'row', 0, NULL, N'Payslip', NULL, NULL, 1, N'0acce7c4-1da6-4276-a199-a4db6270bfd7', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'94b87734-5d0d-4cc3-87e4-cd4bed8d9fd4', 4, N'DIV4', 9, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', N'6fcedd7c-ecf7-47a7-85e0-f3afb990f50a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', N'row', 0, NULL, N'Employee', NULL, NULL, 1, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'9f8a3c39-1b42-43f2-83d6-e7bba93cee72', 1, N'FamilyLeader', 13, N'4915c87a-4c0a-4635-beb4-6626d46415c2', N'e953ba65-67a9-4779-a13e-46d2f03bcabe', N'Chef de famille', N'Family Leader', N'Chef de famille', N'Chef de famille', N'Chef de famille', N'Chef de famille', N'1301c855-d07e-480c-a003-749357444c4a', N'form-group col-lg-12 col-md-12 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'Employee', NULL, NULL, 1, N'4915c87a-4c0a-4635-beb4-6626d46415c2', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'a8e52427-e0fc-4427-a64e-6419fb6c6fcd', 1, N'Category', 1, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', N'401dbbe5-41b6-414a-80dc-2b275a3a91e9', N'Catégorie', N'Category', N'Catégorie', N'Catégorie', N'Catégorie', N'Catégorie', N'dd223655-4ec6-4514-b1d7-c20ba191e638', N'form-group col-lg-6 col-md-12 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'k-textbox', 0, NULL, N'Employee', NULL, NULL, 1, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'ad7e9aae-550f-40be-a7d5-cb96ffebddc1', 1, N'FamilyLeader', 13, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', N'94b87734-5d0d-4cc3-87e4-cd4bed8d9fd4', N'Chef de famille', N'Family Leader', N'Chef de famille', N'Chef de famille', N'Chef de famille', N'Chef de famille', N'dd223655-4ec6-4514-b1d7-c20ba191e638', N'form-group col-lg-12 col-md-12 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'Employee', NULL, NULL, 1, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'b42c62d5-97a3-4c4a-a8d5-fd27bbc6cd1d', 2, N'HiringDate', 1, N'4915c87a-4c0a-4635-beb4-6626d46415c2', N'37013f30-6081-41ff-8423-dfdf35000742', N'Date d''embauche', N'Hiring Date', N'Date d''embauche', N'Date d''embauche', N'Date d''embauche', N'Date d''embauche', N'1301c855-d07e-480c-a003-749357444c4a', N'form-group col-lg-6 col-md-6 col-sm-12 ', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'Employee', NULL, NULL, 1, N'4915c87a-4c0a-4635-beb4-6626d46415c2', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'b9236f3f-ba40-411d-aa8a-31c9dcae5759', 2, N'NumberDaysLeaveTaken', 1, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', N'74422c96-1908-46ee-bff2-f189f8ee495a', N'Nombre de jours de congés pris', N'Number of Days Leave Taken', NULL, NULL, NULL, NULL, N'019d04b1-234d-4b71-afa3-ef11f67559c2', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'Payslip', NULL, NULL, 1, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'd16eb1a5-803b-4790-9add-02d7aa8127cb', 1, N'Cin', 1, N'4915c87a-4c0a-4635-beb4-6626d46415c2', N'4f2d9fd5-ba44-4b6c-80ea-c80866bd239c', N'CIN', N'CIN', N'CIN', N'CIN', N'CIN', N'CIN', N'1301c855-d07e-480c-a003-749357444c4a', N'form-group col-lg-3 col-md-6 col-sm-12 ', N'col-lg-12 col-md-12 col-sm-12', N'k-textbox', 0, NULL, N'Employee', NULL, NULL, 1, N'4915c87a-4c0a-4635-beb4-6626d46415c2', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'e953ba65-67a9-4779-a13e-46d2f03bcabe', 4, N'DIV4', 9, N'4915c87a-4c0a-4635-beb4-6626d46415c2', N'32dc7c25-676b-4928-a88f-2ec70bb2eac0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', N'', N'row', 0, NULL, N'Employee', NULL, NULL, 1, N'4915c87a-4c0a-4635-beb4-6626d46415c2', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'f3184b91-2fa8-4c82-bcfd-c13c77e47546', 1, N'NumberDaysWorked', 1, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', N'74422c96-1908-46ee-bff2-f189f8ee495a', N'Nombre de jours travaillés', N'Number of Days Worked', NULL, NULL, NULL, NULL, N'019d04b1-234d-4b71-afa3-ef11f67559c2', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'Payslip', NULL, NULL, 1, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'ffea742e-07cc-4e5d-8d2d-6679bec58905', 2, N'NumberDaysLeaveTaken', 1, N'0acce7c4-1da6-4276-a199-a4db6270bfd7', N'88b222d7-4861-4b99-98da-8b219e30e746', N'nombre de jours de congés pris', N'Number of Days Leave Taken', NULL, NULL, NULL, NULL, N'019d04b1-234d-4b71-afa3-ef11f67559c2', N'form-group col-lg-3 col-md-6 col-sm-12 ', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'Payslip', NULL, NULL, 1, N'0acce7c4-1da6-4276-a199-a4db6270bfd7', NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'0ecf1de3-ec62-489c-83e9-2c17d9124136', 0, NULL, 0, NULL, NULL, 50, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'2e511394-1ce0-45f1-92d4-26c7ebafa511', 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'437c3427-65b4-43b7-9bed-59dec9a510d6', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'7d883e00-c08d-44ec-9a35-90e155879455', 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, N'''n0''', N'0', N'20', N'0', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'83275351-e2dd-4045-ae42-a4576925fc71', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'a8e52427-e0fc-4427-a64e-6419fb6c6fcd', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'b42c62d5-97a3-4c4a-a8d5-fd27bbc6cd1d', 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'b9236f3f-ba40-411d-aa8a-31c9dcae5759', 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, N'''n0''', N'0', N'20', N'0', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'd16eb1a5-803b-4790-9add-02d7aa8127cb', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'f3184b91-2fa8-4c82-bcfd-c13c77e47546', 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, N'''n0''', N'0', N'20', N'0', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'ffea742e-07cc-4e5d-8d2d-6679bec58905', 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, N'''n0''', N'0', N'20', N'0', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[CheckBoxComponent] ([IdComponent], [Checked], [ng_change]) VALUES (N'9f8a3c39-1b42-43f2-83d6-e7bba93cee72', 0, NULL)
INSERT INTO [ERPSettings].[CheckBoxComponent] ([IdComponent], [Checked], [ng_change]) VALUES (N'ad7e9aae-550f-40be-a7d5-cb96ffebddc1', 0, NULL)

INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'0ecf1de3-ec62-489c-83e9-2c17d9124136', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'401dbbe5-41b6-414a-80dc-2b275a3a91e9', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'2e511394-1ce0-45f1-92d4-26c7ebafa511', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'a8e52427-e0fc-4427-a64e-6419fb6c6fcd', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'37013f30-6081-41ff-8423-dfdf35000742', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'b42c62d5-97a3-4c4a-a8d5-fd27bbc6cd1d', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'437c3427-65b4-43b7-9bed-59dec9a510d6', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'83275351-e2dd-4045-ae42-a4576925fc71', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'94b87734-5d0d-4cc3-87e4-cd4bed8d9fd4', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'ad7e9aae-550f-40be-a7d5-cb96ffebddc1', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'd16eb1a5-803b-4790-9add-02d7aa8127cb', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'e953ba65-67a9-4779-a13e-46d2f03bcabe', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'9f8a3c39-1b42-43f2-83d6-e7bba93cee72', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'74422c96-1908-46ee-bff2-f189f8ee495a', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'f3184b91-2fa8-4c82-bcfd-c13c77e47546', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'b9236f3f-ba40-411d-aa8a-31c9dcae5759', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'88b222d7-4861-4b99-98da-8b219e30e746', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'7d883e00-c08d-44ec-9a35-90e155879455', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'ffea742e-07cc-4e5d-8d2d-6679bec58905', 1, 1, NULL, NULL, NULL)

ALTER TABLE [ERPSettings].[ComboBoxOptions]
    ADD CONSTRAINT [FK_ComboBoxOptions_ComboBoxComponent] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[ComboBoxComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxComponent]
    ADD CONSTRAINT [FK_ComboboxComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ComponentByRole]
    ADD CONSTRAINT [FK_ComponentByRole_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ComponentByRole]
    ADD CONSTRAINT [FK_ComponentByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[CheckBoxComponent]
    ADD CONSTRAINT [FK_CheckBoxComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[InputComponent]
    ADD CONSTRAINT [FK_InputComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxDataSourceItems]
    ADD CONSTRAINT [FK_ComboBoxDataSourceItems_ComboBoxDataSource] FOREIGN KEY ([IdComboBoxDataSource]) REFERENCES [ERPSettings].[ComboBoxDataSource] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxDataSource]
    ADD CONSTRAINT [FK_ComboBoxDataSource_ComboBoxOptions] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[ComboBoxOptions] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxDataSource]
    ADD CONSTRAINT [FK_ComboBoxDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
COMMIT TRANSACTION

--Mohamed BOUZIDI Premium list in Contract and PaySlip

BEGIN TRANSACTION

ALTER TABLE [ERPSettings].[Relation] DROP CONSTRAINT [FK_Relation_PredicateFormat]
ALTER TABLE [ERPSettings].[ComponentByRole] DROP CONSTRAINT [FK_ComponentByRole_Component]
ALTER TABLE [ERPSettings].[ComponentByRole] DROP CONSTRAINT [FK_ComponentByRole_Role]
ALTER TABLE [ERPSettings].[DropDownListComponent] DROP CONSTRAINT [FK_DropDownListComponent_Component]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions]
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_ServiceParameters]
ALTER TABLE [ERPSettings].[DropDownListOptions] DROP CONSTRAINT [FK_DropDownListOptions_DropDownListComponent]
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [FK_ServiceParameters_PredicateFormat]
ALTER TABLE [ERPSettings].[Filter] DROP CONSTRAINT [FK_Filter_PredicateFormat]
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'12f93ae5-ecb1-4221-878f-3d0a5bafa2e0'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'203d34ef-1b0a-467a-a13d-68c7c64a0df5'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'3eb0be5f-6b50-4d2d-857a-1954ec36af39'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'72be3534-35d1-4a9d-9b9e-1a851a5bd4df'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'12f93ae5-ecb1-4221-878f-3d0a5bafa2e0'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'203d34ef-1b0a-467a-a13d-68c7c64a0df5'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'3eb0be5f-6b50-4d2d-857a-1954ec36af39'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'72be3534-35d1-4a9d-9b9e-1a851a5bd4df'
UPDATE [ERPSettings].[Component] SET [rank]=6, [IdComponentParent]=N'f8512d08-31f4-46b5-ac46-bf86d2d98a5f' WHERE [IdComponent]=N'1e3d3c38-414e-451c-80c4-be3820b2c165'
UPDATE [ERPSettings].[Component] SET [rank]=7, [IdComponentParent]=N'183b3bec-f7a9-4cf8-ab46-90f8b170d4c3' WHERE [IdComponent]=N'2ec5bf7d-6d49-4c11-9239-126c856fa944'
UPDATE [ERPSettings].[Component] SET [rank]=6, [IdComponentParent]=N'183b3bec-f7a9-4cf8-ab46-90f8b170d4c3', [classLabel]=N'col-lg-12 col-md-12 col-sm-12' WHERE [IdComponent]=N'40b9cc09-0257-4b11-a1fb-a6de13c15c25'
UPDATE [ERPSettings].[Component] SET [IsEncapsulated]=0 WHERE [IdComponent]=N'4dbbb3cc-16ef-4c0b-ad36-a17c09a40d15'
UPDATE [ERPSettings].[Component] SET [rank]=4, [IdComponentParent]=N'f8512d08-31f4-46b5-ac46-bf86d2d98a5f' WHERE [IdComponent]=N'4ffd70b7-ba4f-4276-86df-85a95adbbd2f'
UPDATE [ERPSettings].[Component] SET [rank]=5, [IdComponentParent]=N'183b3bec-f7a9-4cf8-ab46-90f8b170d4c3' WHERE [IdComponent]=N'5ac788c0-be50-42f8-833c-9a1ad837fb15'
UPDATE [ERPSettings].[Component] SET [rank]=5, [IdComponentParent]=N'f8512d08-31f4-46b5-ac46-bf86d2d98a5f' WHERE [IdComponent]=N'62f58dd8-c17f-4f73-b9a7-97cf6360d673'
UPDATE [ERPSettings].[Component] SET [rank]=8, [IdComponentParent]=N'183b3bec-f7a9-4cf8-ab46-90f8b170d4c3' WHERE [IdComponent]=N'634573d5-023b-4c67-84e6-4d4c3a903e34'
UPDATE [ERPSettings].[Component] SET [rank]=9, [IdComponentParent]=N'f8512d08-31f4-46b5-ac46-bf86d2d98a5f' WHERE [IdComponent]=N'7bb3cc3b-9c42-4a60-ae04-b26ad6a91436'
UPDATE [ERPSettings].[Component] SET [rank]=9, [IdComponentParent]=N'183b3bec-f7a9-4cf8-ab46-90f8b170d4c3' WHERE [IdComponent]=N'99e07ef6-3dfa-4b45-b61e-0e1461c1a77f'
UPDATE [ERPSettings].[Component] SET [classLabel]=N'col-lg-12 col-md-12 col-sm-12' WHERE [IdComponent]=N'b3619f85-8be8-474a-9044-b1d6273bee55'
UPDATE [ERPSettings].[Component] SET [IsEncapsulated]=0 WHERE [IdComponent]=N'b4cd4221-9cc0-4f28-8067-90d992f2775c'
UPDATE [ERPSettings].[Component] SET [classLabel]=N'col-lg-12 col-md-12 col-sm-12' WHERE [IdComponent]=N'b61d7319-3164-414c-bd83-3196896286d9'
UPDATE [ERPSettings].[Component] SET [rank]=4, [IdComponentParent]=N'183b3bec-f7a9-4cf8-ab46-90f8b170d4c3' WHERE [IdComponent]=N'b774f3b4-83af-408a-b558-bb83710820c2'
UPDATE [ERPSettings].[Component] SET [rank]=8, [IdComponentParent]=N'f8512d08-31f4-46b5-ac46-bf86d2d98a5f' WHERE [IdComponent]=N'ca1e52f7-f3d5-4e22-a0d0-f38c08377e4d'
UPDATE [ERPSettings].[Component] SET [rank]=7, [IdComponentParent]=N'f8512d08-31f4-46b5-ac46-bf86d2d98a5f' WHERE [IdComponent]=N'f61b31e6-902a-4a74-958e-6322db51cbd9'
UPDATE [ERPSettings].[ServiceParameters] SET [IdPredicateFormat]=N'a9fb39b2-4686-46df-b681-ce08fc55dc07' WHERE [IdServiceParameters]=N'24d0f2a9-1990-436d-9e06-593631170f6f'
UPDATE [ERPSettings].[ServiceParameters] SET [Method]=N'POST', [URL]=N'/api/base/getPredicate', [IdPredicateFormat]=N'12c347e8-1f56-463b-be4c-db79f3840b59' WHERE [IdServiceParameters]=N'35077b13-a296-44ec-82e5-70ded6c5667b'
UPDATE [ERPSettings].[ServiceParameters] SET [IdPredicateFormat]=N'ef085c57-f129-4ef1-9558-c7a9e1d9cfef' WHERE [IdServiceParameters]=N'70b217e7-a81a-4c6b-a5ed-823dbfaa34fb'
INSERT INTO [ERPSettings].[PredicateFormat] ([IdPredicateFormat], [PredicateName], [Operator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'12c347e8-1f56-463b-be4c-db79f3840b59', NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[PredicateFormat] ([IdPredicateFormat], [PredicateName], [Operator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'205899a2-c50c-48f9-bf26-7aad97032614', NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[PredicateFormat] ([IdPredicateFormat], [PredicateName], [Operator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'57472157-b945-414a-8a65-064eed14d80f', NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[PredicateFormat] ([IdPredicateFormat], [PredicateName], [Operator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'a9fb39b2-4686-46df-b681-ce08fc55dc07', NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[PredicateFormat] ([IdPredicateFormat], [PredicateName], [Operator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'bf3f2359-b904-43f3-a49d-d993d256fbf9', NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[PredicateFormat] ([IdPredicateFormat], [PredicateName], [Operator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'c2fa2a49-23b4-46e0-a4a2-48c2dd2a9f09', NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[PredicateFormat] ([IdPredicateFormat], [PredicateName], [Operator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'e37cc89d-3855-4ab7-8a06-54aa8897c52c', NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[PredicateFormat] ([IdPredicateFormat], [PredicateName], [Operator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'ef085c57-f129-4ef1-9558-c7a9e1d9cfef', NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'04d8c210-e0bb-4bcb-8e31-bca84e9f5022', N'c2fa2a49-23b4-46e0-a4a2-48c2dd2a9f09', N'Code', 2, NULL, 0, NULL, 0, 1, NULL, 18)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'04e2aed3-4721-4c9a-924a-45d827e9a567', N'57472157-b945-414a-8a65-064eed14d80f', N'Code', 2, NULL, 0, NULL, 0, 1, NULL, 18)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'244c3ffc-3bcb-4298-aa31-c34710af4fe2', N'57472157-b945-414a-8a65-064eed14d80f', N'Name', 2, NULL, 0, NULL, 0, 1, NULL, 18)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'36f64e44-b56d-43e9-ade6-327509c44630', N'c2fa2a49-23b4-46e0-a4a2-48c2dd2a9f09', N'IsFixe', 1, N'true', 0, NULL, 0, NULL, NULL, 3)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'66f650db-e1cb-4722-b23e-8523f924f617', N'e37cc89d-3855-4ab7-8a06-54aa8897c52c', N'Code', 2, NULL, 0, NULL, 0, 1, NULL, 18)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'852a43a4-df31-464c-a49f-e736b49b5121', N'ef085c57-f129-4ef1-9558-c7a9e1d9cfef', N'ContractPremium', NULL, NULL, 1, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'8c519cde-0fe5-4876-8bba-244d62dc6430', N'e37cc89d-3855-4ab7-8a06-54aa8897c52c', N'Name', 2, NULL, 0, NULL, 0, 1, NULL, 18)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'8ca99eac-2118-4499-b506-ae2fb3c49850', N'c2fa2a49-23b4-46e0-a4a2-48c2dd2a9f09', N'Name', 2, NULL, 0, NULL, 0, 1, NULL, 18)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'8eef6eb1-85de-42b3-b6e2-ab9133e253d3', N'12c347e8-1f56-463b-be4c-db79f3840b59', N'Id', NULL, NULL, 1, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'a72e5c89-6489-4bc9-ba7a-1840455495a0', N'57472157-b945-414a-8a65-064eed14d80f', N'IsFixe', 1, N'false', 0, NULL, 0, NULL, NULL, 3)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'f9951bde-9287-4d0b-a18a-8463b0e1c124', N'e37cc89d-3855-4ab7-8a06-54aa8897c52c', N'IsFixe', 1, N'true', 0, NULL, 0, NULL, NULL, 3)
INSERT INTO [ERPSettings].[ServiceParameters] ([IdServiceParameters], [Method], [URL], [TModel], [Module], [IdPredicateFormat], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'0cf0ffc0-3eee-41cf-a60e-de15fdbf4c09', N'POST', N'/api/base/get', N'Premium', N'PayRoll', N'e37cc89d-3855-4ab7-8a06-54aa8897c52c', NULL, 0, NULL)
INSERT INTO [ERPSettings].[ServiceParameters] ([IdServiceParameters], [Method], [URL], [TModel], [Module], [IdPredicateFormat], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'5ab3da1b-3902-40cc-8789-3753cbc5dace', N'POST', N'/api/base/get', N'Premium', N'PayRoll', N'57472157-b945-414a-8a65-064eed14d80f', NULL, 0, NULL)
INSERT INTO [ERPSettings].[ServiceParameters] ([IdServiceParameters], [Method], [URL], [TModel], [Module], [IdPredicateFormat], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'de10854c-8b22-4a69-8a5b-9a2e4fca20d4', N'POST', N'/api/base/get', N'Premium', N'PayRoll', N'c2fa2a49-23b4-46e0-a4a2-48c2dd2a9f09', NULL, 0, NULL)
INSERT INTO [ERPSettings].[DropDownListOptions] ([IdDropDownListOptions], [name], [autoBind], [dataTextField], [dataValueField], [delay], [enable], [filter], [fixedGroupTemplate], [groupTemplate], [height], [headerTemplate], [template], [valueTemplate], [footerTemplate], [close], [dataBound], [filtering], [open], [select], [cascadeFrom], [cascadeFromField]) VALUES (N'18dd3739-d287-480a-a074-eb2b2d4f9424', NULL, 1, N'Name', N'Id', NULL, 1, N'Contains', NULL, NULL, 200, N'<div class="dropdown-header k-widget k-header"><span>{{''676fd436-f196-4257-acea-9caad8d8374d '' | translate }}</span><span>{{''9c509362-a2e4-4135-837b-6e33256a5bd5 '' | translate }}</span></div>', N'<table class="customDropDown sz-40-60"><tr><td>#:data.Code#</td><td>#if(data.Name != null){# #:data.Name ## }#</td></tr></table>', N'<span>#if(data.Code != null){# #: data.Code.length>9 ? data.Code.substring(0,7)+".." : data.Code # #}#</span>', N'Total #: instance.dataSource.total() #', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[DropDownListOptions] ([IdDropDownListOptions], [name], [autoBind], [dataTextField], [dataValueField], [delay], [enable], [filter], [fixedGroupTemplate], [groupTemplate], [height], [headerTemplate], [template], [valueTemplate], [footerTemplate], [close], [dataBound], [filtering], [open], [select], [cascadeFrom], [cascadeFromField]) VALUES (N'cdb8742b-4e1c-482f-944b-ee48def40a39', NULL, 1, N'Name', N'Id', NULL, 1, N'Contains', NULL, NULL, 200, N'<div class="dropdown-header k-widget k-header"><span>{{''676fd436-f196-4257-acea-9caad8d8374d '' | translate }}</span><span>{{''9c509362-a2e4-4135-837b-6e33256a5bd5 '' | translate }}</span></div>', N'<table class="customDropDown sz-40-60"><tr><td>#:data.Code#</td><td>#if(data.Name != null){# #:data.Name ## }#</td></tr></table>', N'<span>#if(data.Code != null){# #: data.Code.length>9 ? data.Code.substring(0,7)+".." : data.Code # #}#</span>', N'Total #: instance.dataSource.total() #', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[DropDownListOptions] ([IdDropDownListOptions], [name], [autoBind], [dataTextField], [dataValueField], [delay], [enable], [filter], [fixedGroupTemplate], [groupTemplate], [height], [headerTemplate], [template], [valueTemplate], [footerTemplate], [close], [dataBound], [filtering], [open], [select], [cascadeFrom], [cascadeFromField]) VALUES (N'e84de611-9ff6-4358-b72d-5dc2b9c98bac', NULL, 1, N'Name', N'Id', NULL, 1, N'Contains', NULL, NULL, 200, N'<div class="dropdown-header k-widget k-header"><span>{{''676fd436-f196-4257-acea-9caad8d8374d '' | translate }}</span><span>{{''9c509362-a2e4-4135-837b-6e33256a5bd5 '' | translate }}</span></div>', N'<table class="customDropDown sz-40-60"><tr><td>#:data.Code#</td><td>#if(data.Name != null){# #:data.Name ## }#</td></tr></table>', N'<span>#if(data.Code != null){# #: data.Code.length>9 ? data.Code.substring(0,7)+".." : data.Code # #}#</span>', N'Total #: instance.dataSource.total() #', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[DropDownListDataSource] ([IdDropDownListOptions], [IdServiceParameters], [error], [autoSync], [pageSize], [serverPaging], [serverSorting], [serverFiltering], [serverGrouping], [serverAggregates]) VALUES (N'18dd3739-d287-480a-a074-eb2b2d4f9424', N'de10854c-8b22-4a69-8a5b-9a2e4fca20d4', NULL, 0, 32, 1, 0, 1, 0, 0)
INSERT INTO [ERPSettings].[DropDownListDataSource] ([IdDropDownListOptions], [IdServiceParameters], [error], [autoSync], [pageSize], [serverPaging], [serverSorting], [serverFiltering], [serverGrouping], [serverAggregates]) VALUES (N'cdb8742b-4e1c-482f-944b-ee48def40a39', N'0cf0ffc0-3eee-41cf-a60e-de15fdbf4c09', NULL, 0, 32, 1, 0, 1, 0, 0)
INSERT INTO [ERPSettings].[DropDownListDataSource] ([IdDropDownListOptions], [IdServiceParameters], [error], [autoSync], [pageSize], [serverPaging], [serverSorting], [serverFiltering], [serverGrouping], [serverAggregates]) VALUES (N'e84de611-9ff6-4358-b72d-5dc2b9c98bac', N'5ab3da1b-3902-40cc-8789-3753cbc5dace', NULL, 0, 32, 1, 0, 1, 0, 0)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'18dd3739-d287-480a-a074-eb2b2d4f9424', 10, N'ContractPremium', 8, N'f2630114-6cf4-431d-99f4-a3c79dadd2af', N'f8512d08-31f4-46b5-ac46-bf86d2d98a5f', N'Prime', N'Premium', N'Premium_AR', N'Premium_DE', N'Premium_CH', N'Role_ES', N'0e546098-5427-4342-ba18-b8e3bc2738b2', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'k-textbox', 0, NULL, N'Premium', NULL, NULL, 1, N'f2630114-6cf4-431d-99f4-a3c79dadd2af', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'cdb8742b-4e1c-482f-944b-ee48def40a39', 10, N'ContractPremium', 8, N'68fec29f-1c31-4860-8e21-47e345398528', N'183b3bec-f7a9-4cf8-ab46-90f8b170d4c3', N'Prime', N'Premium', N'Premium_AR', N'Premium_DE', N'Premium_CH', N'Role_ES', N'fd3d8032-c081-45ec-8b9c-92fde021316a', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'k-textbox', 0, NULL, N'Premium', NULL, NULL, 0, N'68fec29f-1c31-4860-8e21-47e345398528', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'e84de611-9ff6-4358-b72d-5dc2b9c98bac', 2, N'PaySlipPremium', 8, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', N'fb9a3338-52c6-4e50-9c7d-31c71c632641', N'Prime', N'Premium', N'Premium_AR', N'Premium_DE', N'Premium_CH', N'Role_ES', N'019d04b1-234d-4b71-afa3-ef11f67559c2', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'k-textbox', 0, NULL, N'Premium', NULL, NULL, 0, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', NULL)
INSERT INTO [ERPSettings].[DropDownListComponent] ([IdComponent], [ng_model], [required], [ng_blur], [ng_bind], [k_on_change], [DropdownType], [DropdownIndex], [ng_disabled], [urlValueMapper], [globalization]) VALUES (N'18dd3739-d287-480a-a074-eb2b2d4f9424', N'', 0, NULL, NULL, N'', 2, N'IdPremium', NULL, NULL, 0)
INSERT INTO [ERPSettings].[DropDownListComponent] ([IdComponent], [ng_model], [required], [ng_blur], [ng_bind], [k_on_change], [DropdownType], [DropdownIndex], [ng_disabled], [urlValueMapper], [globalization]) VALUES (N'cdb8742b-4e1c-482f-944b-ee48def40a39', N'', 0, NULL, NULL, N'', 2, N'IdPremium', NULL, NULL, 0)
INSERT INTO [ERPSettings].[DropDownListComponent] ([IdComponent], [ng_model], [required], [ng_blur], [ng_bind], [k_on_change], [DropdownType], [DropdownIndex], [ng_disabled], [urlValueMapper], [globalization]) VALUES (N'e84de611-9ff6-4358-b72d-5dc2b9c98bac', N'', 0, NULL, NULL, N'', 2, N'IdPremium', NULL, NULL, 0)

INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'cdb8742b-4e1c-482f-944b-ee48def40a39', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'18dd3739-d287-480a-a074-eb2b2d4f9424', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'e84de611-9ff6-4358-b72d-5dc2b9c98bac', 1, 1, NULL, NULL, NULL)

INSERT INTO [ERPSettings].[Relation] ([IdRelation], [IdPredicateFormat], [Prop], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'0abc59f1-22d5-4a77-8a7c-2b06cfa83fb3', N'bf3f2359-b904-43f3-a49d-d993d256fbf9', N'IdContract', NULL, 0, NULL)
INSERT INTO [ERPSettings].[Relation] ([IdRelation], [IdPredicateFormat], [Prop], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'453c3487-08d1-4456-adb6-0c8bbfd0c966', N'205899a2-c50c-48f9-bf26-7aad97032614', N'ContractPremium', NULL, 0, NULL)
INSERT INTO [ERPSettings].[Relation] ([IdRelation], [IdPredicateFormat], [Prop], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'a515f06b-09cb-4831-863a-945e6f81d16e', N'a9fb39b2-4686-46df-b681-ce08fc55dc07', N'IdEmployeeNavigation', NULL, 0, NULL)
INSERT INTO [ERPSettings].[Relation] ([IdRelation], [IdPredicateFormat], [Prop], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'f726adc7-7db4-4cb0-96c8-5c790c4c695e', N'12c347e8-1f56-463b-be4c-db79f3840b59', N'ContractPremium', NULL, 0, NULL)
ALTER TABLE [ERPSettings].[Relation]
    ADD CONSTRAINT [FK_Relation_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[ComponentByRole]
    ADD CONSTRAINT [FK_ComponentByRole_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ComponentByRole]
    ADD CONSTRAINT [FK_ComponentByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[DropDownListComponent]
    ADD CONSTRAINT [FK_DropDownListComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[DropDownListDataSource]
    ADD CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListOptions] ([IdDropDownListOptions])
ALTER TABLE [ERPSettings].[DropDownListDataSource]
    ADD CONSTRAINT [FK_DropDownListDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[DropDownListOptions]
    ADD CONSTRAINT [FK_DropDownListOptions_DropDownListComponent] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[ServiceParameters]
    ADD CONSTRAINT [FK_ServiceParameters_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[Filter]
    ADD CONSTRAINT [FK_Filter_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])

COMMIT TRANSACTION

---- Nihel : notification for circular relationship user-manager
BEGIN TRANSACTION
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (891, N'Le manager sélectionné est l''un de vos collaborateurs', N'The selected manager is one of your employees', NULL, NULL, NULL, NULL, NULL, 0, NULL)
COMMIT TRANSACTION

---- Nihel : ChangePWd, update profile
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Relation] DROP CONSTRAINT [FK_Relation_PredicateFormat]
ALTER TABLE [ERPSettings].[DropDownListComponent] DROP CONSTRAINT [FK_DropDownListComponent_Component]
ALTER TABLE [ERPSettings].[FormComponent] DROP CONSTRAINT [FK_FormComponent_Component]
ALTER TABLE [ERPSettings].[FormComponent] DROP CONSTRAINT [FK_FormComponent_ServiceParameters]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[ButtonComponent] DROP CONSTRAINT [FK_ButtonComponent_Component]
ALTER TABLE [ERPSettings].[ButtonComponent] DROP CONSTRAINT [FK_ButtonComponent_ServiceParameters]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions]
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_ServiceParameters]
ALTER TABLE [ERPSettings].[DropDownListOptions] DROP CONSTRAINT [FK_DropDownListOptions_DropDownListComponent]
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [FK_ServiceParameters_PredicateFormat]
ALTER TABLE [ERPSettings].[Filter] DROP CONSTRAINT [FK_Filter_PredicateFormat]
ALTER TABLE [ERPSettings].[InputComponent] DROP CONSTRAINT [FK_InputComponent_Component]
UPDATE [ERPSettings].[FunctionnalityModule] SET [IdModule]=N'b5f325f6-4bd5-4281-aecd-7ad0312e8d38' WHERE [IdFunctionnalityModule]=N'5b3c3027-b5c1-4d6f-9d2f-69b91d48a2ca'
UPDATE [ERPSettings].[Functionality] SET [FunctionalityName]=N'Profile-ChangePwd', [DefaultRoute]=N'/divers/profile/changePwd' WHERE [IdFunctionality]=N'6d1006f2-51ab-4aba-abc6-b597f28b1603'
UPDATE [ERPSettings].[Module] SET [ModuleName]=N'Divers' WHERE [IdModule]=N'7df17a2a-bfbd-4753-a61d-7f010d64cad7'
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'550ac0ba-6000-418e-aaf3-c589dccfc549', 0, NULL, NULL, NULL, NULL, 255, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'''(+990)000000000000''', NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'6958eb8b-f41d-472c-8dff-04fdc258a2b8', 0, NULL, NULL, NULL, NULL, 255, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'''(+990)000000000000''', NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'6e1b32e8-d8a2-4287-8f9c-29e83081e996', 0, NULL, 1, NULL, NULL, 255, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'ac239ed3-8d7b-48dd-975b-79624f26384a', 0, NULL, NULL, NULL, NULL, 255, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'''(+990)000000000000''', NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'bc93b4ce-060f-45f7-9622-d55069bd1ca0', 5, NULL, 1, NULL, NULL, 255, NULL, NULL, NULL, N'', NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'bd76f1a7-b98d-4ccb-8e69-86af6841c33f', 0, NULL, 1, NULL, NULL, 255, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[PredicateFormat] ([IdPredicateFormat], [PredicateName], [Operator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'3bd806f1-056c-4e51-88ee-0eb0cece4621', NULL, 0, NULL, 0, NULL)
INSERT INTO [ERPSettings].[PredicateFormat] ([IdPredicateFormat], [PredicateName], [Operator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'68405282-28a1-4384-98db-b8a3062ec7e1', NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[PredicateFormat] ([IdPredicateFormat], [PredicateName], [Operator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'c66ae1ec-f764-4724-9cae-645f6aceabae', NULL, 0, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'463ad871-f6a9-4fdf-9a23-8a4e6e94ed81', N'c66ae1ec-f764-4724-9cae-645f6aceabae', N'UserRole', 1, NULL, 1, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'83c85199-efb6-4298-8ba9-0302a01ae022', N'68405282-28a1-4384-98db-b8a3062ec7e1', N'RoleName', 2, NULL, 0, NULL, 0, 1, NULL, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'91287746-fa55-4bd6-ac15-e0cdf8e816d8', N'3bd806f1-056c-4e51-88ee-0eb0cece4621', N'Id', 1, N'', 1, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'f405285c-ce3c-47a1-9335-90cc47fdfea2', N'68405282-28a1-4384-98db-b8a3062ec7e1', N'Code', 2, NULL, 0, NULL, 0, 1, NULL, NULL)
INSERT INTO [ERPSettings].[ServiceParameters] ([IdServiceParameters], [Method], [URL], [TModel], [Module], [IdPredicateFormat], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'1ff778cf-509f-48a2-af32-2bd40f77cc3b', N'POST', N'/api/user/getPredicate', N'User', N'Shared', N'3bd806f1-056c-4e51-88ee-0eb0cece4621', NULL, 0, NULL)
INSERT INTO [ERPSettings].[ServiceParameters] ([IdServiceParameters], [Method], [URL], [TModel], [Module], [IdPredicateFormat], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'545aa6c3-d7fb-463e-81cd-9a7b6f29c483', N'GET', N'/api/base/get', N'User', N'Shared', NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[ServiceParameters] ([IdServiceParameters], [Method], [URL], [TModel], [Module], [IdPredicateFormat], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'6eab889c-b4af-4c0c-8e08-4aa54e48fc86', N'POST', N'/api/base/get', N'Role', N'Shared', N'68405282-28a1-4384-98db-b8a3062ec7e1', NULL, 0, NULL)
INSERT INTO [ERPSettings].[ServiceParameters] ([IdServiceParameters], [Method], [URL], [TModel], [Module], [IdPredicateFormat], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'ebfb2453-f9cf-4ab6-83a6-563f71036bb8', N'PUT', N'/api/base/update', N'User', N'Shared', N'c66ae1ec-f764-4724-9cae-645f6aceabae', NULL, 0, NULL)
INSERT INTO [ERPSettings].[DropDownListOptions] ([IdDropDownListOptions], [name], [autoBind], [dataTextField], [dataValueField], [delay], [enable], [filter], [fixedGroupTemplate], [groupTemplate], [height], [headerTemplate], [template], [valueTemplate], [footerTemplate], [close], [dataBound], [filtering], [open], [select], [cascadeFrom], [cascadeFromField]) VALUES (N'7adb526b-9c67-4ab0-8084-1e6decc7aa34', NULL, 1, N'FirstName', N'Id', NULL, 1, N'contains', NULL, NULL, 300, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[DropDownListOptions] ([IdDropDownListOptions], [name], [autoBind], [dataTextField], [dataValueField], [delay], [enable], [filter], [fixedGroupTemplate], [groupTemplate], [height], [headerTemplate], [template], [valueTemplate], [footerTemplate], [close], [dataBound], [filtering], [open], [select], [cascadeFrom], [cascadeFromField]) VALUES (N'be18002d-caa6-4ba4-ab84-774837e5bd6b', NULL, 1, N'RoleName', N'Id', NULL, 1, N'startswith', NULL, NULL, 200, N'<div class="dropdown-header k-widget k-header"><span>{{''676fd436-f196-4257-acea-9caad8d8374d '' | translate }}</span><span>{{''9c509362-a2e4-4135-837b-6e33256a5bd5 '' | translate }}</span></div>', N'<table class="customDropDown sz-40-60"><tr><td>#:data.Code#</td><td>#if(data.RoleName != null){# #:data.RoleName ## }#</td></tr></table>', N'<span>#if(data.Code != null){# #: data.Code.length>9 ? data.Code.substring(0,7)+".." : data.Code # #}#</span>', N'Total #: instance.dataSource.total() #', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[DropDownListDataSource] ([IdDropDownListOptions], [IdServiceParameters], [error], [autoSync], [pageSize], [serverPaging], [serverSorting], [serverFiltering], [serverGrouping], [serverAggregates]) VALUES (N'7adb526b-9c67-4ab0-8084-1e6decc7aa34', N'545aa6c3-d7fb-463e-81cd-9a7b6f29c483', NULL, 0, NULL, 0, 0, 0, 0, 0)
INSERT INTO [ERPSettings].[DropDownListDataSource] ([IdDropDownListOptions], [IdServiceParameters], [error], [autoSync], [pageSize], [serverPaging], [serverSorting], [serverFiltering], [serverGrouping], [serverAggregates]) VALUES (N'be18002d-caa6-4ba4-ab84-774837e5bd6b', N'6eab889c-b4af-4c0c-8e08-4aa54e48fc86', NULL, 0, 32, 1, 0, 1, 0, 0)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'0c699e0f-575a-43de-bcb8-8eeb1abc217a', 1, N'DIV-Update', 9, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', N'12c90ed5-1e01-4da4-ac28-7a622ad46506', N'DIV1', N'DIV1', N'DIV1_AR', N'DIV1_DE', N'DIV1_CH', N'DIV1_ES', NULL, N'', N'', N'', 0, NULL, N'User', NULL, N'', 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'0d5c7589-0b46-43b9-9ef6-9079bdfcec8a', 2, N'DIV2', 9, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', N'86195d5c-ab7f-43b6-a40a-422d26ea0a5c', N'DIV2', N'DIV2', N'DIV2_AR', N'DIV2_DE', N'DIV2_CH', N'DIV2_ES', NULL, N'', N'', N'row classButtons text-center', 0, NULL, N'Item', N'float:right', NULL, 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'12c90ed5-1e01-4da4-ac28-7a622ad46506', 2, N'DIV2', 9, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', N'0d5c7589-0b46-43b9-9ef6-9079bdfcec8a', N'DIV2', N'DIV2', N'DIV2_AR', N'DIV2_DE', N'DIV2_CH', N'DIV2_ES', NULL, N'', N'', N'btn-group', 0, NULL, N'Item', N'float: right;display:inline-flex', NULL, 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'2558796b-850d-40b3-8afd-14a9ace96247', 1, N'BUTTON1', 7, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', N'c8a4c2ce-4f4f-449f-9521-38ce5130f040', N'Mettre à jour', N'Update', N'Mettre à jour_AR', N'Mettre à jour_DE', N'Mettre à jour_CH', N'Mettre à jour_ES', NULL, N'form-group col-lg-12 col-md-12 col-sm-12 updateCompany', N'', N'k-button', 0, NULL, N'User', NULL, NULL, 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'4882e4ab-c109-4108-bc9f-8c8b91074c4c', 1, N'BUTTON2', 7, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', N'0c699e0f-575a-43de-bcb8-8eeb1abc217a', N'Retourner à la liste', N'Back to list', N'Retourner a la liste_AR', N'Retourner a la liste_DE', N'Retourner a la liste_CH', N'Retourner a la liste_ES', NULL, N'form-group col-lg-12 col-md-12 col-sm-12', N'', N'k-button', 0, NULL, N'User', NULL, NULL, 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'550ac0ba-6000-418e-aaf3-c589dccfc549', 7, N'WorkPhone', 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', N'9dbff93f-d504-471c-b77e-a8cf286774a3', N'Téléphone travail', N'Work phone', N'Telephone travail_AR', N'Telephone travail_DE', N'Telephone travail_CH', N'Telephone travail_ES', N'2558796b-850d-40b3-8afd-14a9ace96247', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'k-textbox', 0, NULL, N'User', NULL, NULL, 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'672a9589-0f2f-4f17-b95b-ac22b0b36076', 1, N'DIV1', 9, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', N'0d5c7589-0b46-43b9-9ef6-9079bdfcec8a', N'DIV1', N'DIV1', N'DIV1_AR', N'DIV1_DE', N'DIV1_CH', N'DIV1_ES', NULL, N'', N'', N'', 0, NULL, N'Item', NULL, NULL, 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'6958eb8b-f41d-472c-8dff-04fdc258a2b8', 8, N'MobilePhone', 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', N'9dbff93f-d504-471c-b77e-a8cf286774a3', N'Téléphone portable', N'Cell phone', N'Telephone portable_AR', N'Telephone portable_DE', N'Telephone portable_CH', N'Telephone portable_ES', N'2558796b-850d-40b3-8afd-14a9ace96247', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'k-textbox', 0, NULL, N'User', NULL, NULL, 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'6e1b32e8-d8a2-4287-8f9c-29e83081e996', 1, N'LastName', 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', N'9dbff93f-d504-471c-b77e-a8cf286774a3', N'Nom', N'Name', N'Nom_AR', N'Nom_DE', N'Nom_CH', N'Nom_ES', N'2558796b-850d-40b3-8afd-14a9ace96247', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'k-textbox', 0, NULL, N'User', NULL, NULL, 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'7adb526b-9c67-4ab0-8084-1e6decc7aa34', 5, N'IdUserParent', 8, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', N'9dbff93f-d504-471c-b77e-a8cf286774a3', N'Manager', N'Manager', N'Manager', N'Manager', N'Manager', NULL, N'2558796b-850d-40b3-8afd-14a9ace96247', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'', 0, NULL, N'Role', NULL, NULL, 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'7b1fcc71-afef-4f71-9c71-95f270917e2a', 1, N'DIVCONTAINER', 17, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', N'86195d5c-ab7f-43b6-a40a-422d26ea0a5c', N'Modifier utilisateur', N'Update user', N'Modifier utilisateur_AR', N'Modifier utilisateur_DE', N'Modifier utilisateur_CH', N'Modifier utilisateur_ES', NULL, N'', N'', N'', 0, NULL, N'User', NULL, NULL, 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'86195d5c-ab7f-43b6-a40a-422d26ea0a5c', 1, N'FORM1', 6, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', NULL, N'FORM1', N'FORM1', N'FORM1_AR', N'FORM1_DE', N'FORM1_CH', N'FORM1_ES', NULL, N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'container-fluid', 0, NULL, N'User', NULL, NULL, 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'9dbff93f-d504-471c-b77e-a8cf286774a3', 1, N'DIV1', 9, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', N'7b1fcc71-afef-4f71-9c71-95f270917e2a', N'DIV1', N'DIV1', N'DIV1_AR', N'DIV1_DE', N'DIV1_CH', N'DIV1_ES', NULL, N'', N'', N'row', 0, NULL, N'User', NULL, NULL, 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'ac239ed3-8d7b-48dd-975b-79624f26384a', 6, N'Phone', 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', N'9dbff93f-d504-471c-b77e-a8cf286774a3', N'Téléphone personnel', N'Personel phone', N'Telephone personnel_AR', N'Telephone personnel_DE', N'Telephone personnel_CH', N'Telephone personnel_ES', N'2558796b-850d-40b3-8afd-14a9ace96247', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'k-textbox', 0, NULL, N'User', NULL, NULL, 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'bc93b4ce-060f-45f7-9622-d55069bd1ca0', 3, N'Email', 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', N'9dbff93f-d504-471c-b77e-a8cf286774a3', N'Email', N'Email', N'Email_AR', N'Email_DE', N'Email_CH', N'Email_ES', N'2558796b-850d-40b3-8afd-14a9ace96247', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'k-textbox', 0, NULL, N'User', NULL, NULL, 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'bd76f1a7-b98d-4ccb-8e69-86af6841c33f', 2, N'FirstName', 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', N'9dbff93f-d504-471c-b77e-a8cf286774a3', N'Prénom', N'First name', N'Prenom_AR', N'Prenom_DE', N'Prenom_CH', N'Prenom_ES', N'2558796b-850d-40b3-8afd-14a9ace96247', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'k-textbox', 0, NULL, N'User', NULL, NULL, 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'be18002d-caa6-4ba4-ab84-774837e5bd6b', 4, N'UserRole', 8, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', N'9dbff93f-d504-471c-b77e-a8cf286774a3', N'Rôle', N'Role', N'Role_AR', N'Role_DE', N'Role_CH', N'Role_ES', N'2558796b-850d-40b3-8afd-14a9ace96247', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'k-textbox', 0, NULL, N'User', NULL, NULL, 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'c8a4c2ce-4f4f-449f-9521-38ce5130f040', 2, N'DIV2', 9, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', N'12c90ed5-1e01-4da4-ac28-7a622ad46506', N'DIV2', N'DIV2', N'DIV2_AR', N'DIV2_DE', N'DIV2_CH', N'DIV2_ES', NULL, N'', N'', N'', 0, NULL, N'Item', N'', NULL, 1, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', NULL)

INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'0c699e0f-575a-43de-bcb8-8eeb1abc217a', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'0d5c7589-0b46-43b9-9ef6-9079bdfcec8a', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'12c90ed5-1e01-4da4-ac28-7a622ad46506', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'2558796b-850d-40b3-8afd-14a9ace96247', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'4882e4ab-c109-4108-bc9f-8c8b91074c4c', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'550ac0ba-6000-418e-aaf3-c589dccfc549', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'672a9589-0f2f-4f17-b95b-ac22b0b36076', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'6958eb8b-f41d-472c-8dff-04fdc258a2b8', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'6e1b32e8-d8a2-4287-8f9c-29e83081e996', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'7adb526b-9c67-4ab0-8084-1e6decc7aa34', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'7b1fcc71-afef-4f71-9c71-95f270917e2a', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'86195d5c-ab7f-43b6-a40a-422d26ea0a5c', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'9dbff93f-d504-471c-b77e-a8cf286774a3', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'ac239ed3-8d7b-48dd-975b-79624f26384a', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'bc93b4ce-060f-45f7-9622-d55069bd1ca0', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'bd76f1a7-b98d-4ccb-8e69-86af6841c33f', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'be18002d-caa6-4ba4-ab84-774837e5bd6b', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'c8a4c2ce-4f4f-449f-9521-38ce5130f040', 1, 1, NULL, NULL, NULL)


INSERT INTO [ERPSettings].[ButtonComponent] ([IdComponent], [ng_model], [ng_click], [type], [ButtonType], [IdServiceParameter], [ngDisabled]) VALUES (N'2558796b-850d-40b3-8afd-14a9ace96247', N'', N'bController.baseService.actionService.save(''2558796b-850d-40b3-8afd-14a9ace96247'')', N'submit', 0, N'ebfb2453-f9cf-4ab6-83a6-563f71036bb8', NULL)
INSERT INTO [ERPSettings].[ButtonComponent] ([IdComponent], [ng_model], [ng_click], [type], [ButtonType], [IdServiceParameter], [ngDisabled]) VALUES (N'4882e4ab-c109-4108-bc9f-8c8b91074c4c', N'', N'bController.baseService.actionService.redirectionService.redirectTo(''/administration/user/list'')', N'submit', 0, NULL, NULL)
INSERT INTO [ERPSettings].[Module] ([IdModule], [ModuleName], [IdModuleParent], [Rank], [FR], [EN], [AR], [DE], [CH], [ES], [class], [InMenuList]) VALUES (N'b5f325f6-4bd5-4281-aecd-7ad0312e8d38', N'Profile', N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 2, N'Profile', N'Profile', N'Profile', N'Profile', N'Profile', N'Profile', N'icon-note', 0)

INSERT INTO [ERPSettings].[ModuleByRole] ( [IdRole], [IdModule], [IsActive], [IsVisible]) VALUES (1, N'b5f325f6-4bd5-4281-aecd-7ad0312e8d38', 1, 1)


INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute]) VALUES (N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', N'Profile-UPDATE', 2, N'Modifier profile', N'Update profile', NULL, NULL, NULL, NULL, N'/divers/profile/update', 0)

INSERT INTO [ERPSettings].[FunctionalityByRole] ([IdFunctionality], [IdRole], [IsActive], [IsVisible], [TransactionUserId]) VALUES (N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', 1, 1, 1, NULL)

INSERT INTO [ERPSettings].[FormComponent] ([IdComponent], [k_rules], [ng_controller], [ng_submit], [data_ng_init], [IdServiceParameter], [NameSpace]) VALUES (N'86195d5c-ab7f-43b6-a40a-422d26ea0a5c', NULL, N'BaseController as bController', NULL, N'bController.baseService.initService.initView()', N'1ff778cf-509f-48a2-af32-2bd40f77cc3b', N'Administration.User')
INSERT INTO [ERPSettings].[DropDownListComponent] ([IdComponent], [ng_model], [required], [ng_blur], [ng_bind], [k_on_change], [DropdownType], [DropdownIndex], [ng_disabled], [urlValueMapper], [globalization]) VALUES (N'7adb526b-9c67-4ab0-8084-1e6decc7aa34', N'', NULL, NULL, NULL, N'bController.baseService.actionService.onChangeDataSource(''7adb526b-9c67-4ab0-8084-1e6decc7aa34'')', 1, NULL, NULL, NULL, 0)
INSERT INTO [ERPSettings].[DropDownListComponent] ([IdComponent], [ng_model], [required], [ng_blur], [ng_bind], [k_on_change], [DropdownType], [DropdownIndex], [ng_disabled], [urlValueMapper], [globalization]) VALUES (N'be18002d-caa6-4ba4-ab84-774837e5bd6b', N'', 1, NULL, NULL, N'', 2, N'IdRole', NULL, NULL, 0)
INSERT INTO [ERPSettings].[Relation] ([IdRelation], [IdPredicateFormat], [Prop], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'6508d301-90b6-4b88-ae39-52c9780dd9e3', N'3bd806f1-056c-4e51-88ee-0eb0cece4621', N'UserRole', NULL, 0, NULL)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES (N'c6eee9ac-1eb5-45ac-a65a-4f7a9becb82c', N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', N'b5f325f6-4bd5-4281-aecd-7ad0312e8d38')
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Relation]
    ADD CONSTRAINT [FK_Relation_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[DropDownListComponent]
    ADD CONSTRAINT [FK_DropDownListComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[FormComponent]
    ADD CONSTRAINT [FK_FormComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[FormComponent]
    ADD CONSTRAINT [FK_FormComponent_ServiceParameters] FOREIGN KEY ([IdServiceParameter]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ButtonComponent]
    ADD CONSTRAINT [FK_ButtonComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ButtonComponent]
    ADD CONSTRAINT [FK_ButtonComponent_ServiceParameters] FOREIGN KEY ([IdServiceParameter]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[DropDownListDataSource]
    ADD CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListOptions] ([IdDropDownListOptions])
ALTER TABLE [ERPSettings].[DropDownListDataSource]
    ADD CONSTRAINT [FK_DropDownListDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[DropDownListOptions]
    ADD CONSTRAINT [FK_DropDownListOptions_DropDownListComponent] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[ServiceParameters]
    ADD CONSTRAINT [FK_ServiceParameters_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[Filter]
    ADD CONSTRAINT [FK_Filter_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[InputComponent]
    ADD CONSTRAINT [FK_InputComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
COMMIT TRANSACTION


--- Marwa Afficher le nom et le prenom de la personne du dropdown Manager -----

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[DropDownListOptions] DROP CONSTRAINT [FK_DropDownListOptions_DropDownListComponent]
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [FK_ServiceParameters_PredicateFormat]
ALTER TABLE [ERPSettings].[Filter] DROP CONSTRAINT [FK_Filter_PredicateFormat]
UPDATE [ERPSettings].[DropDownListOptions] SET [headerTemplate]=N'<div class="dropdown-header k-widget k-header"><span>{{''f4e07c53-955c-4116-a3ca-9f8e712e3a46'' | translate }}</span><span>{{''1e7a5afd-5699-4b5a-97c4-da8e42e3d57d'' | translate }}</span></div>', [template]=N'<table class="customDropDown sz-40-60"><tr><td>#:data.FirstName#</td><td>#if(data.LastName != null){# #:data.LastName ## }#</td></tr></table>', [valueTemplate]=N'<span>#if(data.FirstName != null){# #: data.FirstName.length>9 ? data.FirstName.substring(0,7)+".." : data.FirstName # #}#</span>', [footerTemplate]=N'Total #: instance.dataSource.total() #' WHERE [IdDropDownListOptions]=N'08211794-d719-4f8e-9642-37eb55e436c4'
UPDATE [ERPSettings].[DropDownListOptions] SET [headerTemplate]=N'<div class="dropdown-header k-widget k-header"><span>{{''8f676700-f9c0-4090-83f4-8fbb814f4fc2'' | translate }}</span><span>{{''d3ba5ea3-8503-43b7-9b37-2d342c55ce89'' | translate }}</span></div>', [template]=N'<table class="customDropDown sz-40-60"><tr><td>#:data.FirstName#</td><td>#if(data.LastName != null){# #:data.LastName ## }#</td></tr></table>', [valueTemplate]=N'<span>#if(data.FirstName != null){# #: data.FirstName.length>9 ? data.FirstName.substring(0,7)+".." : data.FirstName # #}#</span>', [footerTemplate]=N'Total #: instance.dataSource.total() #' WHERE [IdDropDownListOptions]=N'3a7e2fc2-270c-418f-bf30-c0a84acb459e'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/GetPreviousDocumentLines' WHERE [IdServiceParameters]=N'1cd829b6-162d-4f25-a88a-d51d10248af5'
UPDATE [ERPSettings].[ServiceParameters] SET [IdPredicateFormat]=N'0191a52b-d987-4efd-a9b5-a19940ea2a60' WHERE [IdServiceParameters]=N'3950de5a-b22c-46b3-8464-003b376a2ba8'
UPDATE [ERPSettings].[ServiceParameters] SET [IdPredicateFormat]=N'106f952f-fabf-4d14-93f5-601dcda6e577' WHERE [IdServiceParameters]=N'dbb5a0f4-3b11-406f-9221-284ad2dd27e8'
UPDATE [ERPSettings].[ServiceParameters] SET [URL]=N'/api/document/GetPreviousDocumentLines' WHERE [IdServiceParameters]=N'e0953e8a-e26e-4717-aa4d-d2a9697fcd27'
INSERT INTO [ERPSettings].[PredicateFormat] ([IdPredicateFormat], [PredicateName], [Operator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'0191a52b-d987-4efd-a9b5-a19940ea2a60', NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[PredicateFormat] ([IdPredicateFormat], [PredicateName], [Operator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'106f952f-fabf-4d14-93f5-601dcda6e577', NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'28941a60-fb12-4d07-8d2c-c598482f61fa', N'106f952f-fabf-4d14-93f5-601dcda6e577', N'LastName', 2, NULL, 0, NULL, 0, 1, NULL, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'2c8dea6d-7862-4b9d-9b8d-dffdd9b33ea1', N'0191a52b-d987-4efd-a9b5-a19940ea2a60', N'FirstName', 2, NULL, 0, NULL, 0, 1, NULL, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'52e160f5-cc41-4812-a8c2-1cdff0863a92', N'0191a52b-d987-4efd-a9b5-a19940ea2a60', N'LastName', 2, NULL, 0, NULL, 0, 1, NULL, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'6a9bf99a-e5b1-4b95-8229-43298ecf210d', N'106f952f-fabf-4d14-93f5-601dcda6e577', N'FirstName', 2, NULL, 0, NULL, 0, 1, NULL, NULL)
ALTER TABLE [ERPSettings].[DropDownListOptions]
    ADD CONSTRAINT [FK_DropDownListOptions_DropDownListComponent] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[ServiceParameters]
    ADD CONSTRAINT [FK_ServiceParameters_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[Filter]
    ADD CONSTRAINT [FK_Filter_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
COMMIT TRANSACTION

--- Marwa : modification reporting paie ---
BEGIN TRANSACTION

UPDATE [ERPSettings].[InputComponent] SET [required]=0 WHERE [IdComponent]=N'0780d3ce-4946-4cfe-a3f4-20af2844391b'
UPDATE [ERPSettings].[InputComponent] SET [required]=0 WHERE [IdComponent]=N'634573d5-023b-4c67-84e6-4d4c3a903e34'
UPDATE [ERPSettings].[InputComponent] SET [required]=0 WHERE [IdComponent]=N'91aef056-aa67-4b3e-89ff-8fa58b73fb6e'
UPDATE [ERPSettings].[InputComponent] SET [required]=0 WHERE [IdComponent]=N'ca1e52f7-f3d5-4e22-a0d0-f38c08377e4d'
UPDATE [ERPSettings].[DropDownListComponent] SET [required]=0 WHERE [IdComponent]=N'7ca13915-9340-4296-a90f-4c4ea85abd54'
UPDATE [ERPSettings].[DropDownListComponent] SET [required]=0 WHERE [IdComponent]=N'fb55679b-135f-43e5-b8a9-8996394f37bf'

COMMIT TRANSACTION

---- Nihel : codification for invoice approvement  
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
ALTER TABLE [ERPSettings].[InputComponent] DROP CONSTRAINT [FK_InputComponent_Component]
UPDATE [ERPSettings].[InputComponent] SET [ng_disabled]=1 WHERE [IdComponent]=N'1b894c82-bb5c-40bd-b056-92bdf89fa3f6'
UPDATE [ERPSettings].[InputComponent] SET [ng_disabled]=1 WHERE [IdComponent]=N'2e0fae36-6ad3-4706-bc2a-1c2344ced310'
UPDATE [ERPSettings].[InputComponent] SET [ng_disabled]=1, [ng_readonly]=0 WHERE [IdComponent]=N'34920d7a-864f-4bd8-942e-40930af1cc97'
UPDATE [ERPSettings].[InputComponent] SET [required]=0, [ng_disabled]=1 WHERE [IdComponent]=N'45c40492-fabd-4046-9468-eccd6038daa0'
UPDATE [ERPSettings].[InputComponent] SET [required]=0, [ng_disabled]=1 WHERE [IdComponent]=N'5ba56760-a216-499a-960b-01514576c416'
UPDATE [ERPSettings].[InputComponent] SET [ng_disabled]=1 WHERE [IdComponent]=N'75356ce6-69bc-4afe-b6f9-ef8ef7d742ae'
UPDATE [ERPSettings].[InputComponent] SET [required]=0, [ng_disabled]=1 WHERE [IdComponent]=N'7d5a9629-c8e7-46be-a65d-0e853bafc4a1'
UPDATE [ERPSettings].[InputComponent] SET [ng_disabled]=1 WHERE [IdComponent]=N'93c81917-0cac-496d-8348-27e52343f8a0'
UPDATE [ERPSettings].[InputComponent] SET [required]=0, [ng_disabled]=1 WHERE [IdComponent]=N'9cb71f8f-6f8a-4a86-ae9a-860c7b26c23c'
UPDATE [ERPSettings].[InputComponent] SET [ng_disabled]=1 WHERE [IdComponent]=N'a9bbcf14-c09e-44ec-b92e-c8cc33f51cd8'
UPDATE [ERPSettings].[InputComponent] SET [ng_disabled]=1, [ng_readonly]=0 WHERE [IdComponent]=N'ae5740ac-c3d5-45fa-99b6-f5f759df2e9c'
UPDATE [ERPSettings].[InputComponent] SET [ng_disabled]=1 WHERE [IdComponent]=N'bb491f21-7c66-4525-a27f-b3a73126f628'
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (25, 87, N'DocumentTypeCode', N'A-I-SA', 107)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (107, N'CodeFactureClient-Approved', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (108, N'CaractereFA', 1, NULL, NULL, N'FA', 107, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (109, N'Annee', 2, N'return (DateTime.Now.Year.ToString().Substring(2,2));', N'string', NULL, 107, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (111, N'compteurFactureClient', 3, NULL, NULL, NULL, 107, 1, 1, N'00000000', 8)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (892, N'Il faut valider tous les factures antérieures. ', N'You must validate all previous invoices.', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (893, N'Il y a de(s) facture(s) postérieure(s) validée(s).', N'
There are approved subsequent invoice(s).', NULL, NULL, NULL, NULL, NULL, 0, NULL)
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[InputComponent]
    ADD CONSTRAINT [FK_InputComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
COMMIT TRANSACTION

-- Narcisse : payroll

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [ERPSettings].[InputComponent] DROP CONSTRAINT [FK_InputComponent_Component]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
UPDATE [ERPSettings].[Codification] SET [LastCounterValue]=N'0021' WHERE [Id]=103
UPDATE [ERPSettings].[InputComponent] SET [inputType]=6 WHERE [IdComponent]=N'88d19b1e-0962-4dc6-bb5b-e679b2fd44e3'
UPDATE [ERPSettings].[InputComponent] SET [required]=1, [defaultValue]=N'0' WHERE [IdComponent]=N'b9236f3f-ba40-411d-aa8a-31c9dcae5759'
UPDATE [ERPSettings].[InputComponent] SET [required]=1, [k_max]=N'', [defaultValue]=N'' WHERE [IdComponent]=N'f3184b91-2fa8-4c82-bcfd-c13c77e47546'
UPDATE [ERPSettings].[Component] SET [rank]=3, [IdComponentParent]=N'74422c96-1908-46ee-bff2-f189f8ee495a' WHERE [IdComponent]=N'28afaa65-8331-4d0e-bcfe-e1c416a13801'
UPDATE [ERPSettings].[Component] SET [rank]=2 WHERE [IdComponent]=N'2c7f8103-b231-48e3-bdb6-e42f47e1f7ce'
UPDATE [ERPSettings].[Component] SET [rank]=1 WHERE [IdComponent]=N'b9236f3f-ba40-411d-aa8a-31c9dcae5759'
UPDATE [ERPSettings].[Component] SET [rank]=1 WHERE [IdComponent]=N'e84de611-9ff6-4358-b72d-5dc2b9c98bac'
UPDATE [ERPSettings].[Component] SET [rank]=4, [IdComponentParent]=N'bdef5342-75d0-40e4-98a1-77975345ac5e' WHERE [IdComponent]=N'f3184b91-2fa8-4c82-bcfd-c13c77e47546'
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[InputComponent]
    ADD CONSTRAINT [FK_InputComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
COMMIT TRANSACTION



----Nihel: analytical axis: delete analytical axis value in use
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
UPDATE [ERPSettings].[Component] SET [IdButton]=N'68a7affe-4269-4bd9-8020-c8a109924743' WHERE [IdComponent]=N'46f033e0-02c0-432d-866c-c82ba90721f3'
UPDATE [ERPSettings].[Component] SET [IdButton]=N'635993ad-34b6-4ece-ad35-ded0d0113c1c' WHERE [IdComponent]=N'bf77f17b-6fed-434c-9e3c-268538dfbb91'
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
COMMIT TRANSACTION



--- Marwa suppression des interfaces echellon---
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[ComponentByRole] DROP CONSTRAINT [FK_ComponentByRole_Component]
ALTER TABLE [ERPSettings].[ComponentByRole] DROP CONSTRAINT [FK_ComponentByRole_Role]
ALTER TABLE [ERPSettings].[GridButtonComponent] DROP CONSTRAINT [FK_GridButtonComponent_ServiceParameters]
ALTER TABLE [ERPSettings].[GridButtonComponent] DROP CONSTRAINT [FK_GridButtonComponent_Component]
ALTER TABLE [ERPSettings].[GridComponent] DROP CONSTRAINT [FK_GridComponent_Component]
ALTER TABLE [ERPSettings].[FormComponent] DROP CONSTRAINT [FK_FormComponent_Component]
ALTER TABLE [ERPSettings].[FormComponent] DROP CONSTRAINT [FK_FormComponent_ServiceParameters]
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions]
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_ServiceParameters]
ALTER TABLE [ERPSettings].[InputComponent] DROP CONSTRAINT [FK_InputComponent_Component]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [ERPSettings].[ButtonComponent] DROP CONSTRAINT [FK_ButtonComponent_Component]
ALTER TABLE [ERPSettings].[ButtonComponent] DROP CONSTRAINT [FK_ButtonComponent_ServiceParameters]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[GridColumnComponent] DROP CONSTRAINT [FK_GridColumnComponent_Component]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
ALTER TABLE [ERPSettings].[DropDownListOptions] DROP CONSTRAINT [FK_DropDownListOptions_DropDownListComponent]
ALTER TABLE [ERPSettings].[DropDownListComponent] DROP CONSTRAINT [FK_DropDownListComponent_Component]
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [FK_GridDataSource_GridOptions]
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [FK_GridDataSource_ServiceParameters]
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [FK_GridOptions_GridComponent]
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [FK_ServiceParameters_PredicateFormat]
DELETE FROM [ERPSettings].[FunctionalityByRole] WHERE [IdFunctionality]=N'35240f39-4f3d-4e06-9cff-16b51589f516'
DELETE FROM [ERPSettings].[FunctionalityByRole] WHERE [IdFunctionality]=N'a4f40551-3b1d-4236-bb7d-0ce0e663ef5a'
DELETE FROM [ERPSettings].[FunctionalityByRole] WHERE [IdFunctionality]=N'f53855e9-1ef1-428b-8f01-bc02a24a5277'
DELETE FROM [ERPSettings].[FunctionnalityModule] WHERE [IdFunctionnalityModule]=N'183e7322-9797-407d-9a15-12555b8803de'
DELETE FROM [ERPSettings].[FunctionnalityModule] WHERE [IdFunctionnalityModule]=N'79e5c06a-a496-4847-a247-a83644e51071'
DELETE FROM [ERPSettings].[FunctionnalityModule] WHERE [IdFunctionnalityModule]=N'9549beef-5ba1-4c1b-bd9c-6caa8fe41663'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'0f3e3a56-0948-4889-973f-b37e4493485f'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'12038896-804b-4944-9a4e-8b3d4434ca5b'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'14421403-d04c-4b63-afe6-9c3a417a40d6'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'1c4752ef-ae63-4322-853b-2b631f7b15bc'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'21f3ccb3-ace3-4c3b-862a-fd2190c85f59'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'2c39c628-7898-4752-8f9c-a8110b44c912'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'2d2e604e-ce7b-4fb5-90c4-7ccec70cabe4'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'2eda8912-1022-4747-9c31-51cce217c8e0'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'32106801-d09e-4287-9e09-9238a6a4ef63'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'36ebbf3c-fac8-456a-8bf4-88217a9a2452'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'36f4e08c-14e8-4978-9567-cd6b2e7cc031'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'3c24a2b4-daa5-420e-ae28-9fbee12ecf9d'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'42a06cc4-de5b-43c3-b7e2-67a5164bd40b'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'5bd1c9d0-61c9-4d4a-9269-12dfc7591b78'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'7ca13915-9340-4296-a90f-4c4ea85abd54'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'99d101d0-fd0c-45ba-a20b-f2ae4568f959'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'9ac9b5d1-e422-4210-87a7-8ee54bf12a5a'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'a7315aee-c471-4382-9a8d-58c834ce314c'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'a8acf613-c6c1-4b83-ba60-209e4b6c9aa5'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'aac15e91-0c18-404d-8c81-e188009cdc8b'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'ae8484b0-9464-47b9-950e-1b4f46b8a7dd'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'b25d71b8-5b89-496b-8b6e-0113a278f96a'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'b5f3bd2e-be4b-41dd-b9cf-f0247ba2b87d'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'ba3f3e37-1e93-493b-9d9f-6a1722496088'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'bc1ade50-9e39-4748-be7a-3535d123b7a7'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'c179e97d-5e26-4c1d-a86b-9b55d3f42f4d'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'c361524a-969e-451f-916c-5c7330c802c6'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'ca18a791-37a3-4f46-a93e-2ca8d98ff17e'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'cba795fd-46f2-4c2b-ac83-43988015ca08'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'ccb6a075-7b19-49ee-9e0c-b385c6a308c4'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'f6839a6f-3592-4f60-b635-4934aa06505c'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'f8068b5f-e2e0-4bc7-8c3f-a606ff6c4558'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'fb55679b-135f-43e5-b8a9-8996394f37bf'
DELETE FROM [ERPSettings].[GridButtonComponent] WHERE [IdComponent]=N'2c39c628-7898-4752-8f9c-a8110b44c912'
DELETE FROM [ERPSettings].[GridButtonComponent] WHERE [IdComponent]=N'42a06cc4-de5b-43c3-b7e2-67a5164bd40b'
DELETE FROM [ERPSettings].[GridComponent] WHERE [IdComponent]=N'cba795fd-46f2-4c2b-ac83-43988015ca08'
DELETE FROM [ERPSettings].[FormComponent] WHERE [IdComponent]=N'14421403-d04c-4b63-afe6-9c3a417a40d6'
DELETE FROM [ERPSettings].[FormComponent] WHERE [IdComponent]=N'36f4e08c-14e8-4978-9567-cd6b2e7cc031'
DELETE FROM [ERPSettings].[FormComponent] WHERE [IdComponent]=N'a8acf613-c6c1-4b83-ba60-209e4b6c9aa5'
DELETE FROM [ERPSettings].[DropDownListDataSource] WHERE [IdDropDownListOptions]=N'7ca13915-9340-4296-a90f-4c4ea85abd54'
DELETE FROM [ERPSettings].[DropDownListDataSource] WHERE [IdDropDownListOptions]=N'fb55679b-135f-43e5-b8a9-8996394f37bf'
DELETE FROM [ERPSettings].[InputComponent] WHERE [IdComponent]=N'2eda8912-1022-4747-9c31-51cce217c8e0'
DELETE FROM [ERPSettings].[InputComponent] WHERE [IdComponent]=N'3c24a2b4-daa5-420e-ae28-9fbee12ecf9d'
DELETE FROM [ERPSettings].[InputComponent] WHERE [IdComponent]=N'aac15e91-0c18-404d-8c81-e188009cdc8b'
DELETE FROM [ERPSettings].[InputComponent] WHERE [IdComponent]=N'ca18a791-37a3-4f46-a93e-2ca8d98ff17e'
DELETE FROM [ERPSettings].[Functionality] WHERE [IdFunctionality]=N'35240f39-4f3d-4e06-9cff-16b51589f516'
DELETE FROM [ERPSettings].[Functionality] WHERE [IdFunctionality]=N'a4f40551-3b1d-4236-bb7d-0ce0e663ef5a'
DELETE FROM [ERPSettings].[Functionality] WHERE [IdFunctionality]=N'f53855e9-1ef1-428b-8f01-bc02a24a5277'
DELETE FROM [ERPSettings].[ButtonComponent] WHERE [IdComponent]=N'32106801-d09e-4287-9e09-9238a6a4ef63'
DELETE FROM [ERPSettings].[ButtonComponent] WHERE [IdComponent]=N'5bd1c9d0-61c9-4d4a-9269-12dfc7591b78'
DELETE FROM [ERPSettings].[ButtonComponent] WHERE [IdComponent]=N'ba3f3e37-1e93-493b-9d9f-6a1722496088'
DELETE FROM [ERPSettings].[ButtonComponent] WHERE [IdComponent]=N'bc1ade50-9e39-4748-be7a-3535d123b7a7'
DELETE FROM [ERPSettings].[ButtonComponent] WHERE [IdComponent]=N'f8068b5f-e2e0-4bc7-8c3f-a606ff6c4558'
DELETE FROM [ERPSettings].[ModuleByRole] WHERE [IdModule]=N'b4cf9263-6554-4f45-a26d-22e8d58099d5'
DELETE FROM [ERPSettings].[Module] WHERE [IdModule]=N'b4cf9263-6554-4f45-a26d-22e8d58099d5'
DELETE FROM [ERPSettings].[GridColumnComponent] WHERE [IdComponent]=N'1c4752ef-ae63-4322-853b-2b631f7b15bc'
DELETE FROM [ERPSettings].[GridColumnComponent] WHERE [IdComponent]=N'36ebbf3c-fac8-456a-8bf4-88217a9a2452'
DELETE FROM [ERPSettings].[GridColumnComponent] WHERE [IdComponent]=N'c361524a-969e-451f-916c-5c7330c802c6'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'0f3e3a56-0948-4889-973f-b37e4493485f'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'12038896-804b-4944-9a4e-8b3d4434ca5b'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'14421403-d04c-4b63-afe6-9c3a417a40d6'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'1c4752ef-ae63-4322-853b-2b631f7b15bc'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'21f3ccb3-ace3-4c3b-862a-fd2190c85f59'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'2c39c628-7898-4752-8f9c-a8110b44c912'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'2d2e604e-ce7b-4fb5-90c4-7ccec70cabe4'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'2eda8912-1022-4747-9c31-51cce217c8e0'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'32106801-d09e-4287-9e09-9238a6a4ef63'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'36ebbf3c-fac8-456a-8bf4-88217a9a2452'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'36f4e08c-14e8-4978-9567-cd6b2e7cc031'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'3c24a2b4-daa5-420e-ae28-9fbee12ecf9d'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'42a06cc4-de5b-43c3-b7e2-67a5164bd40b'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'5bd1c9d0-61c9-4d4a-9269-12dfc7591b78'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'7ca13915-9340-4296-a90f-4c4ea85abd54'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'99d101d0-fd0c-45ba-a20b-f2ae4568f959'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'9ac9b5d1-e422-4210-87a7-8ee54bf12a5a'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'a7315aee-c471-4382-9a8d-58c834ce314c'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'a8acf613-c6c1-4b83-ba60-209e4b6c9aa5'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'aac15e91-0c18-404d-8c81-e188009cdc8b'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'ae8484b0-9464-47b9-950e-1b4f46b8a7dd'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'b25d71b8-5b89-496b-8b6e-0113a278f96a'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'b5f3bd2e-be4b-41dd-b9cf-f0247ba2b87d'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'ba3f3e37-1e93-493b-9d9f-6a1722496088'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'bc1ade50-9e39-4748-be7a-3535d123b7a7'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'c179e97d-5e26-4c1d-a86b-9b55d3f42f4d'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'c361524a-969e-451f-916c-5c7330c802c6'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'ca18a791-37a3-4f46-a93e-2ca8d98ff17e'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'cba795fd-46f2-4c2b-ac83-43988015ca08'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'ccb6a075-7b19-49ee-9e0c-b385c6a308c4'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'f6839a6f-3592-4f60-b635-4934aa06505c'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'f8068b5f-e2e0-4bc7-8c3f-a606ff6c4558'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'fb55679b-135f-43e5-b8a9-8996394f37bf'
DELETE FROM [ERPSettings].[DropDownListOptions] WHERE [IdDropDownListOptions]=N'7ca13915-9340-4296-a90f-4c4ea85abd54'
DELETE FROM [ERPSettings].[DropDownListOptions] WHERE [IdDropDownListOptions]=N'fb55679b-135f-43e5-b8a9-8996394f37bf'
DELETE FROM [ERPSettings].[DropDownListComponent] WHERE [IdComponent]=N'7ca13915-9340-4296-a90f-4c4ea85abd54'
DELETE FROM [ERPSettings].[DropDownListComponent] WHERE [IdComponent]=N'fb55679b-135f-43e5-b8a9-8996394f37bf'
DELETE FROM [ERPSettings].[GridDataSource] WHERE [IdGridOptions]=N'cba795fd-46f2-4c2b-ac83-43988015ca08'
DELETE FROM [ERPSettings].[GridOptions] WHERE [IdGridOptions]=N'cba795fd-46f2-4c2b-ac83-43988015ca08'
DELETE FROM [ERPSettings].[ServiceParameters] WHERE [IdServiceParameters]=N'0ce75450-3d0d-4e81-8038-bcaf4345783d'
DELETE FROM [ERPSettings].[ServiceParameters] WHERE [IdServiceParameters]=N'26f0d121-1c72-4100-a920-5ca835c5e74f'
DELETE FROM [ERPSettings].[ServiceParameters] WHERE [IdServiceParameters]=N'7bee8a28-6b88-45e2-bc42-00a14a5b6fa8'
DELETE FROM [ERPSettings].[ServiceParameters] WHERE [IdServiceParameters]=N'8a8ee87b-b314-4756-9850-2c361eb4a37b'
DELETE FROM [ERPSettings].[ServiceParameters] WHERE [IdServiceParameters]=N'8d9f8751-ec3a-40a6-bbe3-37119409a6a6'
DELETE FROM [ERPSettings].[ServiceParameters] WHERE [IdServiceParameters]=N'd8f93c33-b5b8-46f1-9d23-765505ce48ea'
UPDATE [ERPSettings].[InputComponent] SET [required]=0 WHERE [IdComponent]=N'44c92349-46af-493d-95f0-13e7ebc740ab'
UPDATE [ERPSettings].[InputComponent] SET [required]=0 WHERE [IdComponent]=N'6baa8a97-2bca-4382-940f-d7917b7dabda'
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'26b21e7e-c3d2-4335-9fc1-7f3e040fbea5', 2, N'Echelon', 1, N'4915c87a-4c0a-4635-beb4-6626d46415c2', N'81839904-2652-439f-9a76-f73264eb3e28', N'Echellon', N'Echelon', N'Echelon', N'Echelon', N'Echelon', N'Echelon', N'1301c855-d07e-480c-a003-749357444c4a', N'form-group col-lg-4 col-md-4 col-sm-12 ', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'ItemWarehouse', NULL, NULL, 1, N'4915c87a-4c0a-4635-beb4-6626d46415c2', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'6ad064e7-70e9-4499-8745-832353348685', 2, N'Echelon', 1, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', N'd9553354-6324-4235-ae09-7e30de1da452', N'Echellon', N'Echelon', N'Echelon', N'Echelon', N'Echelon', N'Echelon', N'dd223655-4ec6-4514-b1d7-c20ba191e638', N'form-group col-lg-4 col-md-4 col-sm-12 ', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'ItemWarehouse', NULL, NULL, 1, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'26b21e7e-c3d2-4335-9fc1-7f3e040fbea5', 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, N'''n0''', N'0', NULL, N'0', NULL, NULL, NULL, NULL, N'', NULL, 0, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'6ad064e7-70e9-4499-8745-832353348685', 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, N'''n0''', N'0', NULL, N'0', NULL, NULL, NULL, NULL, N'', NULL, 0, NULL, NULL, NULL, NULL)

INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'6ad064e7-70e9-4499-8745-832353348685', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'26b21e7e-c3d2-4335-9fc1-7f3e040fbea5', 1, 1, NULL, NULL, NULL)

ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ComponentByRole]
    ADD CONSTRAINT [FK_ComponentByRole_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ComponentByRole]
    ADD CONSTRAINT [FK_ComponentByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[GridButtonComponent]
    ADD CONSTRAINT [FK_GridButtonComponent_ServiceParameters] FOREIGN KEY ([IdServiceParameter]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[GridButtonComponent]
    ADD CONSTRAINT [FK_GridButtonComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[GridComponent]
    ADD CONSTRAINT [FK_GridComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[FormComponent]
    ADD CONSTRAINT [FK_FormComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[FormComponent]
    ADD CONSTRAINT [FK_FormComponent_ServiceParameters] FOREIGN KEY ([IdServiceParameter]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[DropDownListDataSource]
    ADD CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListOptions] ([IdDropDownListOptions])
ALTER TABLE [ERPSettings].[DropDownListDataSource]
    ADD CONSTRAINT [FK_DropDownListDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[InputComponent]
    ADD CONSTRAINT [FK_InputComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [ERPSettings].[ButtonComponent]
    ADD CONSTRAINT [FK_ButtonComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ButtonComponent]
    ADD CONSTRAINT [FK_ButtonComponent_ServiceParameters] FOREIGN KEY ([IdServiceParameter]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[GridColumnComponent]
    ADD CONSTRAINT [FK_GridColumnComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[DropDownListOptions]
    ADD CONSTRAINT [FK_DropDownListOptions_DropDownListComponent] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[DropDownListComponent]
    ADD CONSTRAINT [FK_DropDownListComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[GridDataSource]
    ADD CONSTRAINT [FK_GridDataSource_GridOptions] FOREIGN KEY ([IdGridOptions]) REFERENCES [ERPSettings].[GridOptions] ([IdGridOptions])
ALTER TABLE [ERPSettings].[GridDataSource]
    ADD CONSTRAINT [FK_GridDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[GridOptions]
    ADD CONSTRAINT [FK_GridOptions_GridComponent] FOREIGN KEY ([IdGridOptions]) REFERENCES [ERPSettings].[GridComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[ServiceParameters]
    ADD CONSTRAINT [FK_ServiceParameters_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
COMMIT TRANSACTION
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
UPDATE [ERPSettings].[Component] SET [FR]=N'Mettre à jour', [EN]=N'Update', [AR]=N'Update', [DE]=N'Update', [CH]=N'Update', [ES]=N'Update' WHERE [IdComponent]=N'4d5647cc-e63c-466f-9a6f-c549325e0724'
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
COMMIT TRANSACTION

---- Nihel: get user list except current user
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions]
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_ServiceParameters]
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [FK_ServiceParameters_PredicateFormat]
ALTER TABLE [ERPSettings].[Filter] DROP CONSTRAINT [FK_Filter_PredicateFormat]
UPDATE [ERPSettings].[DropDownListDataSource] SET [pageSize]=32, [serverPaging]=1, [serverFiltering]=1 WHERE [IdDropDownListOptions]=N'08211794-d719-4f8e-9642-37eb55e436c4'
UPDATE [ERPSettings].[DropDownListDataSource] SET [pageSize]=32, [serverPaging]=1, [serverFiltering]=1 WHERE [IdDropDownListOptions]=N'3a7e2fc2-270c-418f-bf30-c0a84acb459e'
UPDATE [ERPSettings].[ServiceParameters] SET [Method]=N'POST', [URL]=N'/api/base/getDataSourcePredicate' WHERE [IdServiceParameters]=N'3950de5a-b22c-46b3-8464-003b376a2ba8'
UPDATE [ERPSettings].[ServiceParameters] SET [Method]=N'POST', [URL]=N'/api/base/getDataSourcePredicate' WHERE [IdServiceParameters]=N'dbb5a0f4-3b11-406f-9221-284ad2dd27e8'
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'09cd53a3-6f99-4424-8ab1-e523e883d1b3', N'106f952f-fabf-4d14-93f5-601dcda6e577', N'Id', 5, NULL, 1, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'bef1fc51-5d54-4d61-bd68-460b3b1e7325', N'0191a52b-d987-4efd-a9b5-a19940ea2a60', N'Id', 5, NULL, 1, NULL, 0, NULL, NULL, NULL)
ALTER TABLE [ERPSettings].[DropDownListDataSource]
    ADD CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListOptions] ([IdDropDownListOptions])
ALTER TABLE [ERPSettings].[DropDownListDataSource]
    ADD CONSTRAINT [FK_DropDownListDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[ServiceParameters]
    ADD CONSTRAINT [FK_ServiceParameters_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[Filter]
    ADD CONSTRAINT [FK_Filter_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
COMMIT TRANSACTION

---- Nihel : hidden unused columns
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[GridColumnComponent] DROP CONSTRAINT [FK_GridColumnComponent_Component]
UPDATE [ERPSettings].[GridColumnComponent] SET [hidden]=1 WHERE [IdComponent]=N'0626ce9d-444f-442b-97f8-89d875d3118a'
UPDATE [ERPSettings].[GridColumnComponent] SET [hidden]=1 WHERE [IdComponent]=N'442813e2-6623-4664-8ce8-ecc4080ebe79'
UPDATE [ERPSettings].[GridColumnComponent] SET [hidden]=1 WHERE [IdComponent]=N'824db2ad-fefd-44b8-92f2-9fa1736acee0'
UPDATE [ERPSettings].[GridColumnComponent] SET [hidden]=1 WHERE [IdComponent]=N'd7e44f6a-f259-4c24-b094-f295c6283b7a'
ALTER TABLE [ERPSettings].[GridColumnComponent]
    ADD CONSTRAINT [FK_GridColumnComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
COMMIT TRANSACTION

---- Nihel: dropdown style 
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[GridColumnComponent] DROP CONSTRAINT [FK_GridColumnComponent_Component]
ALTER TABLE [ERPSettings].[ComboBoxComponent] DROP CONSTRAINT [FK_ComboboxComponent_Component]
ALTER TABLE [ERPSettings].[ComboBoxOptions] DROP CONSTRAINT [FK_ComboBoxOptions_ComboBoxComponent]
ALTER TABLE [ERPSettings].[DropDownListComponent] DROP CONSTRAINT [FK_DropDownListComponent_Component]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions]
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_ServiceParameters]
ALTER TABLE [ERPSettings].[DropDownListOptions] DROP CONSTRAINT [FK_DropDownListOptions_DropDownListComponent]
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [FK_ServiceParameters_PredicateFormat]
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [FK_ComboBoxDataSource_ComboBoxOptions]
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [FK_ComboBoxDataSource_ServiceParameters]
ALTER TABLE [ERPSettings].[Filter] DROP CONSTRAINT [FK_Filter_PredicateFormat]
DELETE FROM [ERPSettings].[ComboBoxComponent] WHERE [IdComponent]=N'0db96c12-8d64-450f-b2ea-1361053778fd'
DELETE FROM [ERPSettings].[ComboBoxComponent] WHERE [IdComponent]=N'38b12f1d-1057-4a06-9541-4144e2374425'
DELETE FROM [ERPSettings].[ComboBoxOptions] WHERE [IdComponent]=N'0db96c12-8d64-450f-b2ea-1361053778fd'
DELETE FROM [ERPSettings].[ComboBoxOptions] WHERE [IdComponent]=N'38b12f1d-1057-4a06-9541-4144e2374425'

DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'0db96c12-8d64-450f-b2ea-1361053778fd'
DELETE FROM [ERPSettings].[ComponentByRole] WHERE [IdComponent]=N'38b12f1d-1057-4a06-9541-4144e2374425'

DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'0db96c12-8d64-450f-b2ea-1361053778fd'
DELETE FROM [ERPSettings].[Component] WHERE [IdComponent]=N'38b12f1d-1057-4a06-9541-4144e2374425'
DELETE FROM [ERPSettings].[ServiceParameters] WHERE [IdServiceParameters]=N'4bc1238e-b542-48c9-9062-15f0fed5bb2d'
DELETE FROM [ERPSettings].[ServiceParameters] WHERE [IdServiceParameters]=N'50f40edb-612c-48a4-8ccf-8746ce20cca8'
DELETE FROM [ERPSettings].[ComboBoxDataSource] WHERE [IdComponent]=N'0db96c12-8d64-450f-b2ea-1361053778fd'
DELETE FROM [ERPSettings].[ComboBoxDataSource] WHERE [IdComponent]=N'38b12f1d-1057-4a06-9541-4144e2374425'
UPDATE [ERPSettings].[GridColumnComponent] SET [hidden]=1 WHERE [IdComponent]=N'0626ce9d-444f-442b-97f8-89d875d3118a'
UPDATE [ERPSettings].[GridColumnComponent] SET [hidden]=1 WHERE [IdComponent]=N'442813e2-6623-4664-8ce8-ecc4080ebe79'
UPDATE [ERPSettings].[GridColumnComponent] SET [hidden]=1 WHERE [IdComponent]=N'824db2ad-fefd-44b8-92f2-9fa1736acee0'
UPDATE [ERPSettings].[GridColumnComponent] SET [hidden]=1 WHERE [IdComponent]=N'd7e44f6a-f259-4c24-b094-f295c6283b7a'
UPDATE [ERPSettings].[Component] SET [rank]=8, [classDiv]=N'form-group col-lg-4 col-md-6 col-sm-12' WHERE [IdComponent]=N'0a365622-80f6-4364-9e13-a81d0316129d'
UPDATE [ERPSettings].[Component] SET [rank]=6, [class]=N'k-textbox' WHERE [IdComponent]=N'1491facb-d394-4a25-b190-f625801fb276'
UPDATE [ERPSettings].[Component] SET [rank]=9, [classDiv]=N'form-group col-lg-4 col-md-6 col-sm-12' WHERE [IdComponent]=N'3378dff9-8d62-4a9a-a999-c7b0f622f56e'
UPDATE [ERPSettings].[Component] SET [class]=N'k-textbox' WHERE [IdComponent]=N'661cf95a-9f6c-40c8-bbef-1fdbfc3c7430'
UPDATE [ERPSettings].[Component] SET [rank]=7, [classDiv]=N'form-group col-lg-4 col-md-6 col-sm-12' WHERE [IdComponent]=N'6f6aa744-61db-478b-8b6a-4d77ea074829'
UPDATE [ERPSettings].[Component] SET [class]=N'k-textbox' WHERE [IdComponent]=N'7f32af6b-47f1-4c9f-b04c-0150c070265d'
UPDATE [ERPSettings].[Component] SET [rank]=4, [classDiv]=N'form-group col-lg-4 col-md-6 col-sm-12', [class]=N'k-textbox' WHERE [IdComponent]=N'81286632-579d-4af2-8f56-bf01bbb7fa66'
UPDATE [ERPSettings].[Component] SET [class]=N'k-textbox' WHERE [IdComponent]=N'c8407d0b-f4ec-4973-9a8b-405221d17b89'
UPDATE [ERPSettings].[Component] SET [rank]=5, [class]=N'k-textbox' WHERE [IdComponent]=N'e496b74a-9f8a-4acd-8f85-bab5de792ba1'
UPDATE [ERPSettings].[DropDownListOptions] SET [headerTemplate]=N'<div class="dropdown-header k-widget k-header"><span>{{''8f676700-f9c0-4090-83f4-8fbb814f4fc2'' | translate }}</span><span>{{''d3ba5ea3-8503-43b7-9b37-2d342c55ce89'' | translate }}</span></div>', [template]=N'<table class="customDropDown sz-40-60"><tr><td>#:data.FirstName#</td><td>#if(data.LastName != null){# #:data.LastName ## }#</td></tr></table>', [valueTemplate]=N'<span>#if(data.FirstName != null){# #: data.FirstName.length>9 ? data.FirstName.substring(0,7)+".." : data.FirstName # #}#</span>', [footerTemplate]=N'Total #: instance.dataSource.total() #' WHERE [IdDropDownListOptions]=N'1491facb-d394-4a25-b190-f625801fb276'
INSERT INTO [ERPSettings].[PredicateFormat] ([IdPredicateFormat], [PredicateName], [Operator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'a488e540-3728-4fee-a881-48bbda0d6be7', NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[PredicateFormat] ([IdPredicateFormat], [PredicateName], [Operator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'a5b30635-12d7-454b-98df-b07f0f8cc2a1', NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'0446a54f-9641-4c08-86a2-b210c91d1a57', N'a5b30635-12d7-454b-98df-b07f0f8cc2a1', N'Label', 2, NULL, 0, NULL, 0, 1, NULL, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'1472cd3d-ff52-43db-947a-6bc472d00f79', N'a5b30635-12d7-454b-98df-b07f0f8cc2a1', N'Code', 2, NULL, 0, NULL, 0, 1, NULL, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'9260f807-345d-4d97-ae48-8bf146617c45', N'a488e540-3728-4fee-a881-48bbda0d6be7', N'Label', 2, NULL, 0, NULL, 0, 1, NULL, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'9ba1a4cc-e012-4a1c-b403-b807214caa91', N'a488e540-3728-4fee-a881-48bbda0d6be7', N'Code', 2, NULL, 0, NULL, 0, 1, NULL, NULL)
INSERT INTO [ERPSettings].[ServiceParameters] ([IdServiceParameters], [Method], [URL], [TModel], [Module], [IdPredicateFormat], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'37419903-b70e-4647-97d9-10151da10d2a', N'POST', N'/api/base/getDataSourcePredicate', N'Category', N'Immobilisation', N'a5b30635-12d7-454b-98df-b07f0f8cc2a1', NULL, 0, NULL)
INSERT INTO [ERPSettings].[ServiceParameters] ([IdServiceParameters], [Method], [URL], [TModel], [Module], [IdPredicateFormat], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'fda6e152-418b-4c4d-afe4-bdc0f002c524', N'POST', N'/api/base/getDataSourcePredicate', N'Category', N'Immobilisation', N'a488e540-3728-4fee-a881-48bbda0d6be7', NULL, 0, NULL)
INSERT INTO [ERPSettings].[DropDownListOptions] ([IdDropDownListOptions], [name], [autoBind], [dataTextField], [dataValueField], [delay], [enable], [filter], [fixedGroupTemplate], [groupTemplate], [height], [headerTemplate], [template], [valueTemplate], [footerTemplate], [close], [dataBound], [filtering], [open], [select], [cascadeFrom], [cascadeFromField]) VALUES (N'0eda4d3f-ce15-457f-9126-34311d1d5433', NULL, 1, N'Code', N'Id', NULL, 1, N'contains', NULL, NULL, 300, N'<div class="dropdown-header k-widget k-header"><span>{{''39577146-d912-4808-8b49-53e870a0ceb6 '' | translate }}</span><span>{{''b01e9729-a946-43de-bd86-275357ae9f73 '' | translate }}</span></div>', N'<table class="customDropDown sz-40-60"><tr><td>#:data.Code#</td><td>#if(data.Label != null){# #:data.Label ## }#</td></tr></table>', N'<span>#if(data.Code != null){# #: data.Code.length>9 ? data.Code.substring(0,7)+".." : data.Code # #}#</span>', N'Total #: instance.dataSource.total() #', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[DropDownListOptions] ([IdDropDownListOptions], [name], [autoBind], [dataTextField], [dataValueField], [delay], [enable], [filter], [fixedGroupTemplate], [groupTemplate], [height], [headerTemplate], [template], [valueTemplate], [footerTemplate], [close], [dataBound], [filtering], [open], [select], [cascadeFrom], [cascadeFromField]) VALUES (N'a6e97f2e-c05c-4e17-a362-7c481b6638e3', NULL, 1, N'Code', N'Id', NULL, 1, N'contains', NULL, NULL, 300, N'<div class="dropdown-header k-widget k-header"><span>{{''39577146-d912-4808-8b49-53e870a0ceb6 '' | translate }}</span><span>{{''b01e9729-a946-43de-bd86-275357ae9f73 '' | translate }}</span></div>', N'<table class="customDropDown sz-40-60"><tr><td>#:data.Code#</td><td>#if(data.Label != null){# #:data.Label ## }#</td></tr></table>', N'<span>#if(data.Code != null){# #: data.Code.length>9 ? data.Code.substring(0,7)+".." : data.Code # #}#</span>', N'Total #: instance.dataSource.total() #', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[DropDownListDataSource] ([IdDropDownListOptions], [IdServiceParameters], [error], [autoSync], [pageSize], [serverPaging], [serverSorting], [serverFiltering], [serverGrouping], [serverAggregates]) VALUES (N'0eda4d3f-ce15-457f-9126-34311d1d5433', N'fda6e152-418b-4c4d-afe4-bdc0f002c524', NULL, 0, 32, 1, 0, 1, 0, 0)
INSERT INTO [ERPSettings].[DropDownListDataSource] ([IdDropDownListOptions], [IdServiceParameters], [error], [autoSync], [pageSize], [serverPaging], [serverSorting], [serverFiltering], [serverGrouping], [serverAggregates]) VALUES (N'a6e97f2e-c05c-4e17-a362-7c481b6638e3', N'37419903-b70e-4647-97d9-10151da10d2a', NULL, 0, 32, 1, 0, 1, 0, 0)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'0eda4d3f-ce15-457f-9126-34311d1d5433', 9, N'IdCategory', 8, N'd676cd58-7d69-4eec-b6f9-0cb34391d9f7', N'1997de18-0f67-4a03-ba10-8437c3ebd6fe', N'Catégorie', N'Category', NULL, NULL, NULL, NULL, N'ba156661-b14e-4ef4-a71e-35d6cef9fc7d', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'Active', NULL, NULL, 1, N'd676cd58-7d69-4eec-b6f9-0cb34391d9f7', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'a6e97f2e-c05c-4e17-a362-7c481b6638e3', 9, N'IdCategory', 8, N'2ed16d00-54cf-40d9-a6ae-8ee4d26f9a32', N'0e4b75d7-a3ab-44eb-9c49-827ecef4a4f9', N'Catégorie', N'Category', NULL, NULL, NULL, NULL, N'96ffe7e5-a630-402f-9381-4c96cf174975', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'Active', NULL, NULL, 1, N'2ed16d00-54cf-40d9-a6ae-8ee4d26f9a32', NULL)
INSERT INTO [ERPSettings].[DropDownListComponent] ([IdComponent], [ng_model], [required], [ng_blur], [ng_bind], [k_on_change], [DropdownType], [DropdownIndex], [ng_disabled], [urlValueMapper], [globalization]) VALUES (N'0eda4d3f-ce15-457f-9126-34311d1d5433', N'', 1, NULL, NULL, N'bController.baseService.actionService.onChangeDataSource(''0eda4d3f-ce15-457f-9126-34311d1d5433'')', 1, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[DropDownListComponent] ([IdComponent], [ng_model], [required], [ng_blur], [ng_bind], [k_on_change], [DropdownType], [DropdownIndex], [ng_disabled], [urlValueMapper], [globalization]) VALUES (N'a6e97f2e-c05c-4e17-a362-7c481b6638e3', N'', 1, NULL, NULL, N'bController.baseService.actionService.onChangeDataSource(''a6e97f2e-c05c-4e17-a362-7c481b6638e3'')', 1, NULL, NULL, NULL, NULL)

INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'0eda4d3f-ce15-457f-9126-34311d1d5433', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ([IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES (1, N'a6e97f2e-c05c-4e17-a362-7c481b6638e3', 1, 1, NULL, NULL, NULL)


ALTER TABLE [ERPSettings].[GridColumnComponent]
    ADD CONSTRAINT [FK_GridColumnComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxComponent]
    ADD CONSTRAINT [FK_ComboboxComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxOptions]
    ADD CONSTRAINT [FK_ComboBoxOptions_ComboBoxComponent] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[ComboBoxComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[DropDownListComponent]
    ADD CONSTRAINT [FK_DropDownListComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[DropDownListDataSource]
    ADD CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListOptions] ([IdDropDownListOptions])
ALTER TABLE [ERPSettings].[DropDownListDataSource]
    ADD CONSTRAINT [FK_DropDownListDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[DropDownListOptions]
    ADD CONSTRAINT [FK_DropDownListOptions_DropDownListComponent] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[ServiceParameters]
    ADD CONSTRAINT [FK_ServiceParameters_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[ComboBoxDataSource]
    ADD CONSTRAINT [FK_ComboBoxDataSource_ComboBoxOptions] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[ComboBoxOptions] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxDataSource]
    ADD CONSTRAINT [FK_ComboBoxDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[Filter]
    ADD CONSTRAINT [FK_Filter_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
COMMIT TRANSACTION


--Mohamed BOUZIDI Correct bug 5686 set value of Premium

BEGIN TRANSACTION

ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [ERPSettings].[Relation] DROP CONSTRAINT [FK_Relation_PredicateFormat]
ALTER TABLE [ERPSettings].[GridColumnComponent] DROP CONSTRAINT [FK_GridColumnComponent_Component]
ALTER TABLE [ERPSettings].[ComponentByRole] DROP CONSTRAINT [FK_ComponentByRole_Component]
ALTER TABLE [ERPSettings].[ComponentByRole] DROP CONSTRAINT [FK_ComponentByRole_Role]
ALTER TABLE [ERPSettings].[GridButtonComponent] DROP CONSTRAINT [FK_GridButtonComponent_ServiceParameters]
ALTER TABLE [ERPSettings].[GridButtonComponent] DROP CONSTRAINT [FK_GridButtonComponent_Component]
ALTER TABLE [ERPSettings].[GridComponent] DROP CONSTRAINT [FK_GridComponent_Component]
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
ALTER TABLE [ERPSettings].[ButtonComponent] DROP CONSTRAINT [FK_ButtonComponent_Component]
ALTER TABLE [ERPSettings].[ButtonComponent] DROP CONSTRAINT [FK_ButtonComponent_ServiceParameters]
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [FK_GridOptions_GridComponent]
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [FK_GridDataSource_GridOptions]
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [FK_GridDataSource_ServiceParameters]
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [FK_ServiceParameters_PredicateFormat]
ALTER TABLE [ERPSettings].[DropDownListOptions] DROP CONSTRAINT [FK_DropDownListOptions_DropDownListComponent]
ALTER TABLE [ERPSettings].[DropDownListComponent] DROP CONSTRAINT [FK_DropDownListComponent_Component]
ALTER TABLE [ERPSettings].[Filter] DROP CONSTRAINT [FK_Filter_PredicateFormat]
ALTER TABLE [ERPSettings].[InputComponent] DROP CONSTRAINT [FK_InputComponent_Component]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
UPDATE [ERPSettings].[Codification] SET [LastCounterValue]=N'0017' WHERE [Id]=103
UPDATE [ERPSettings].[Codification] SET [LastCounterValue]=N'0001' WHERE [Id]=106
UPDATE [ERPSettings].[DropDownListOptions] SET [valueTemplate]=N'<span>#if(data.Name != null){# #: data.Name.length>9 ? data.Name.substring(0,7)+".." : data.Name # #}#</span>' WHERE [IdDropDownListOptions]=N'e84de611-9ff6-4358-b72d-5dc2b9c98bac'
UPDATE [ERPSettings].[DropDownListComponent] SET [required]=1, [k_on_change]=N'bController.baseService.actionService.onChangeDataSource(''e84de611-9ff6-4358-b72d-5dc2b9c98bac'')', [DropdownType]=1, [DropdownIndex]=N'' WHERE [IdComponent]=N'e84de611-9ff6-4358-b72d-5dc2b9c98bac'
UPDATE [ERPSettings].[Component] SET [rank]=3 WHERE [IdComponent]=N'ad9a5b5a-2ec0-41d1-9ee1-ad6f0b07cb39'
UPDATE [ERPSettings].[Component] SET [rank]=1, [ComponentName]=N'IdPremium', [IdComponentParent]=N'c3f7c958-40be-482d-aee8-c5b1ff0083fe', [IdButton]=N'd2e441ed-8700-443a-bf23-418b05905b17', [class]=N'', [EntityName]=N'PaySlipPremium' WHERE [IdComponent]=N'e84de611-9ff6-4358-b72d-5dc2b9c98bac'
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'0b883fce-3bc9-406c-abd3-c5f91b3ccb6c', 2, N'DIV2', 9, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', N'be1bed97-fe43-4c9a-a238-d43ebcdbf2fe', N'DIV2', N'DIV2', N'DIV2_AR', N'DIV2_DE', N'DIV2_CH', N'DIV2_ES', NULL, N'', N'', N'', 0, NULL, N'Payslip', N'padding-bottom:20px;', NULL, 1, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'39336b89-885a-4e24-b997-8961b9c3cdc9', 3, N'Name', 1, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', N'c3f7c958-40be-482d-aee8-c5b1ff0083fe', N'Name', N'Name', NULL, NULL, NULL, NULL, N'd2e441ed-8700-443a-bf23-418b05905b17', N'form-group col-lg-12 col-md-12 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'k-textbox', 0, N'e84de611-9ff6-4358-b72d-5dc2b9c98bac', N'Premium', NULL, N'true', 1, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'40a4099f-8875-4978-b3b4-198638e96de3', 1, N'Edit', 16, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', N'd0f17651-bbb9-46ba-8eec-f5dbeb032704', N'Modifier', N'Edit', N'Edit_AR', N'Edit_DE', N'Edit_CH', N'Edit_ES', N'd2e441ed-8700-443a-bf23-418b05905b17', N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'k-icon k-i-edit k-i-pencil', 0, NULL, N'PaySlipPremium', N'color:cornflowerblue;', NULL, 1, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'43f519ec-a679-4911-a75d-75d317c07c1b', 2, N'Name', 4, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', N'a2f0f445-f73f-4968-8264-e24f933325d1', N'Nom de la prime', N'Premium name', NULL, NULL, NULL, NULL, NULL, N'col-lg-12 col-md-12 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'Premium', NULL, NULL, 1, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'583dfd35-34d3-41cc-9e60-a559d639a501', 1, N'IdPremium', 4, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', N'a2f0f445-f73f-4968-8264-e24f933325d1', N'Id Prime', N'Id Premium', N'Id Premium_AR', N'Id Premium_DE', N'Id Premium_CH', N'Id Premium_ES', NULL, N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'', 0, NULL, N'PaySlipPremium', NULL, NULL, 1, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'975c68da-803a-4c7c-8aa7-4c913610c253', 2, N'Value', 1, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', N'c3f7c958-40be-482d-aee8-c5b1ff0083fe', N'Valeur', N'Value', N'Value_AR', N'Value_DE', N'Value_CH', N'Value_ES', N'd2e441ed-8700-443a-bf23-418b05905b17', N'form-group col-lg-4 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'PaySlipPremium', NULL, NULL, 0, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'9878aef4-5b43-4bdd-8fda-0aab23b5f179', 2, N'Delete', 16, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', N'd0f17651-bbb9-46ba-8eec-f5dbeb032704', N'Supprimer', N'Delete', N'Delete_AR', N'Delete_DE', N'Delete_CH', N'Delete_ES', N'd2e441ed-8700-443a-bf23-418b05905b17', N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'k-icon k-i-delete k-i-trash', 0, NULL, N'PaySlipPremium', N'color: indianred;', NULL, 1, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'a2f0f445-f73f-4968-8264-e24f933325d1', 1, N'PaySlipPremium', 3, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', N'0b883fce-3bc9-406c-abd3-c5f91b3ccb6c', N'PaySlipPremium', N'PaySlipPremium', N'PaySlipPremium_AR', N'PaySlipPremium_DE', N'PaySlipPremium_CH', N'PaySlipPremium_ES', N'019d04b1-234d-4b71-afa3-ef11f67559c2', N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'', 0, NULL, N'PaySlipPremium', NULL, NULL, 1, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'be1bed97-fe43-4c9a-a238-d43ebcdbf2fe', 2, N'DIVCONTAINER2', 17, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', N'b6888e43-897c-44e9-9de1-7065373e39cf', N'Prime', N'Premium', N'Premium_AR', N'Premium_DE', N'Premium_CH', N'Premium_ES', NULL, N'col-lg-12 col-md-12 col-sm-12', N'', N'', 0, NULL, N'PaySlipPremium', NULL, NULL, 1, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'c3f7c958-40be-482d-aee8-c5b1ff0083fe', 1, N'DIV2', 9, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', N'be1bed97-fe43-4c9a-a238-d43ebcdbf2fe', N'DIV2', N'DIV2', N'DIV2_AR', N'DIV2_DE', N'DIV2_CH', N'DIV2_ES', NULL, N'', N'', N'row', 0, NULL, N'PaySlipPremium', NULL, NULL, 1, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'd0f17651-bbb9-46ba-8eec-f5dbeb032704', 4, N'GRIDCOLUMN4', 4, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', N'a2f0f445-f73f-4968-8264-e24f933325d1', N'GRIDCOLUMN4', N'GRIDCOLUMN4', N'GRIDCOLUMN4_AR', N'GRIDCOLUMN4_DE', N'GRIDCOLUMN4_CH', N'GRIDCOLUMN4_ES', NULL, N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'', 0, NULL, N'PaySlipPremium', NULL, NULL, 1, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'd2e441ed-8700-443a-bf23-418b05905b17', 4, N'Ajouter', 7, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', N'c3f7c958-40be-482d-aee8-c5b1ff0083fe', N'Ajouter à la liste', N'Add to list', N'Enregistrer_AR', N'Enregistrer_DE', N'Enregistrer_CH', N'Enregistrer_ES', NULL, N'form-group col-lg-4 col-md-6 col-sm-12', N'', N'k-button ', 0, NULL, N'PaySlipPremium', N'margin-top: 50px;background-color: transparent;border: none;color: #126a70;', NULL, 1, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'db860ee4-0cee-4458-bc8b-1e9db4ddc9e8', 3, N'Value', 4, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', N'a2f0f445-f73f-4968-8264-e24f933325d1', N'Valeur', N'Value', N'Value_AR', N'Value_DE', N'Value_CH', N'Value_ES', NULL, N'col-lg-12 col-md-12 col-sm-12', N'col-lg-4 col-md-4 col-sm-4', N'', 0, NULL, N'PaySlipPremium', NULL, NULL, 1, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'39336b89-885a-4e24-b997-8961b9c3cdc9', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'{{''39336b89-885a-4e24-b997-8961b9c3cdc9'' | translate }}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[InputComponent] ([IdComponent], [inputType], [ng_model], [required], [ng_disabled], [ng_minlength], [ng_maxlength], [ng_change], [ng_bind], [ng_blur], [placeholder], [k_ng_model], [k_on_change], [k_format], [k_min], [k_max], [k_decimals], [k_step], [ui_date_mask], [pattern], [k_mask], [defaultValue], [ng_readonly], [formatPrecision], [IsCurrency], [Accept], [MaxFileSize], [MinFileSize]) VALUES (N'975c68da-803a-4c7c-8aa7-4c913610c253', 4, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, NULL, N'0.001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[PredicateFormat] ([IdPredicateFormat], [PredicateName], [Operator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'0819d076-9415-4e92-8c80-d46fb67147e2', NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[PredicateFormat] ([IdPredicateFormat], [PredicateName], [Operator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'9f9f2cb6-95a5-45a4-b0be-43d058dfd819', NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'd4df6a37-7953-435a-87e8-c0ba92bb1ee7', N'0819d076-9415-4e92-8c80-d46fb67147e2', N'Id', 1, N'0', 0, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'f3b0653b-c427-4422-be3a-f908ea804e15', N'9f9f2cb6-95a5-45a4-b0be-43d058dfd819', N'IdPaySlip', 1, NULL, 1, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ServiceParameters] ([IdServiceParameters], [Method], [URL], [TModel], [Module], [IdPredicateFormat], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'6c78e921-8b34-4f53-9c3b-7c775c5fc980', N'POST', N'/api/base/getPredicate', N'PaySlipPremium', N'PayRoll', N'9f9f2cb6-95a5-45a4-b0be-43d058dfd819', NULL, 0, NULL)
INSERT INTO [ERPSettings].[GridDataSource] ([IdGridOptions], [IdServiceParameters], [error], [autoSync], [pageSize], [serverPaging], [serverSorting], [serverFiltering], [serverGrouping], [serverAggregates], [batch], [Id], [ParentId], [children], [hasChildrens], [expanded]) VALUES (N'a2f0f445-f73f-4968-8264-e24f933325d1', N'6c78e921-8b34-4f53-9c3b-7c775c5fc980', NULL, 0, 20, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[GridOptions] ([IdGridOptions], [name], [allowCopy], [altRowTemplate], [autoBind], [dataBound], [columnResizeHandleWidth], [columnMenu], [detailTemplate], [editable], [filterable], [groupable], [height], [mobile], [navigatable], [noRecords], [pageable], [reorderable], [resizable], [rowTemplate], [scrollable], [selectable], [sortable], [excel], [pdf], [checkboxes], [dataTextField], [select], [check], [expand], [loadOnDemand]) VALUES (N'a2f0f445-f73f-4968-8264-e24f933325d1', NULL, 0, N'True', 1, NULL, NULL, 0, NULL, 0, 1, 1, NULL, 0, 1, 0, 1, 0, 1, NULL, 1, N'False', 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ButtonComponent] ([IdComponent], [ng_model], [ng_click], [type], [ButtonType], [IdServiceParameter], [ngDisabled]) VALUES (N'd2e441ed-8700-443a-bf23-418b05905b17', N'', N'bController.baseService.actionService.addToGrid(''d2e441ed-8700-443a-bf23-418b05905b17'',''a2f0f445-f73f-4968-8264-e24f933325d1'')', N'submit', 0, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (367, N'Payroll', N'PaySlipPremium', N'PaySlip_Premium', NULL, 0, N'Bulletin Prime', N'PaySlip Premium', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF
INSERT INTO [ERPSettings].[GridComponent] ([IdComponent], [TreeType], [k_on_change]) VALUES (N'a2f0f445-f73f-4968-8264-e24f933325d1', 0, NULL)
INSERT INTO [ERPSettings].[GridButtonComponent] ([IdComponent], [ng_click], [type], [k_content], [IdServiceParameter]) VALUES (N'40a4099f-8875-4978-b3b4-198638e96de3', N'bController.baseService.actionService.updateLocalInGrid(dataItem,''40a4099f-8875-4978-b3b4-198638e96de3'')', N'submit', N'{{''40a4099f-8875-4978-b3b4-198638e96de3'' | translate }}', NULL)
INSERT INTO [ERPSettings].[GridButtonComponent] ([IdComponent], [ng_click], [type], [k_content], [IdServiceParameter]) VALUES (N'9878aef4-5b43-4bdd-8fda-0aab23b5f179', N'bController.baseService.actionService.deleteFromGrid(dataItem,''9878aef4-5b43-4bdd-8fda-0aab23b5f179'',''a2f0f445-f73f-4968-8264-e24f933325d1'')', N'submit', N'{{''9878aef4-5b43-4bdd-8fda-0aab23b5f179'' | translate }}', NULL)

INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'be1bed97-fe43-4c9a-a238-d43ebcdbf2fe', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'0b883fce-3bc9-406c-abd3-c5f91b3ccb6c', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'a2f0f445-f73f-4968-8264-e24f933325d1', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'583dfd35-34d3-41cc-9e60-a559d639a501', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'd0f17651-bbb9-46ba-8eec-f5dbeb032704', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'40a4099f-8875-4978-b3b4-198638e96de3', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'9878aef4-5b43-4bdd-8fda-0aab23b5f179', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'c3f7c958-40be-482d-aee8-c5b1ff0083fe', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'd2e441ed-8700-443a-bf23-418b05905b17', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'975c68da-803a-4c7c-8aa7-4c913610c253', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'db860ee4-0cee-4458-bc8b-1e9db4ddc9e8', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'43f519ec-a679-4911-a75d-75d317c07c1b', 1, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'39336b89-885a-4e24-b997-8961b9c3cdc9', 1, 1, NULL, NULL, NULL)

INSERT INTO [ERPSettings].[GridColumnComponent] ([IdComponent], [field], [title], [width], [format], [groupHeaderTemplate], [hidden], [template], [nullable], [type], [editable], [defaultValue], [menu], [headerTemplate], [filterable], [sortable]) VALUES (N'43f519ec-a679-4911-a75d-75d317c07c1b', N'Name', N'{{''43f519ec-a679-4911-a75d-75d317c07c1b'' | translate}}', NULL, NULL, N'#= value #', 0, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[GridColumnComponent] ([IdComponent], [field], [title], [width], [format], [groupHeaderTemplate], [hidden], [template], [nullable], [type], [editable], [defaultValue], [menu], [headerTemplate], [filterable], [sortable]) VALUES (N'583dfd35-34d3-41cc-9e60-a559d639a501', N'IdPremium', N'{{''583dfd35-34d3-41cc-9e60-a559d639a501'' | translate }}', NULL, NULL, N'#= value #', 1, NULL, 0, NULL, 0, NULL, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[GridColumnComponent] ([IdComponent], [field], [title], [width], [format], [groupHeaderTemplate], [hidden], [template], [nullable], [type], [editable], [defaultValue], [menu], [headerTemplate], [filterable], [sortable]) VALUES (N'd0f17651-bbb9-46ba-8eec-f5dbeb032704', NULL, N'{{''d0f17651-bbb9-46ba-8eec-f5dbeb032704'' | translate }}', NULL, NULL, N'#= value #', 0, NULL, 0, NULL, 0, NULL, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[GridColumnComponent] ([IdComponent], [field], [title], [width], [format], [groupHeaderTemplate], [hidden], [template], [nullable], [type], [editable], [defaultValue], [menu], [headerTemplate], [filterable], [sortable]) VALUES (N'db860ee4-0cee-4458-bc8b-1e9db4ddc9e8', N'Value', N'{{''db860ee4-0cee-4458-bc8b-1e9db4ddc9e8'' | translate }}', NULL, NULL, N'#= value #', 0, NULL, 0, NULL, 0, NULL, 1, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Relation] ([IdRelation], [IdPredicateFormat], [Prop], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'78efa683-2b58-4cf9-a5bb-b8ac5d44b9e2', N'9f9f2cb6-95a5-45a4-b0be-43d058dfd819', N'IdPremiumNavigation', NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9018, N'Prime', N'Premium', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9019, N'Dépôt', N'Warehouse', NULL, NULL, NULL, NULL, NULL, 0, NULL)
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[Relation]
    ADD CONSTRAINT [FK_Relation_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[GridColumnComponent]
    ADD CONSTRAINT [FK_GridColumnComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ComponentByRole]
    ADD CONSTRAINT [FK_ComponentByRole_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ComponentByRole]
    ADD CONSTRAINT [FK_ComponentByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[GridButtonComponent]
    ADD CONSTRAINT [FK_GridButtonComponent_ServiceParameters] FOREIGN KEY ([IdServiceParameter]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[GridButtonComponent]
    ADD CONSTRAINT [FK_GridButtonComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[GridComponent]
    ADD CONSTRAINT [FK_GridComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[ButtonComponent]
    ADD CONSTRAINT [FK_ButtonComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ButtonComponent]
    ADD CONSTRAINT [FK_ButtonComponent_ServiceParameters] FOREIGN KEY ([IdServiceParameter]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[GridOptions]
    ADD CONSTRAINT [FK_GridOptions_GridComponent] FOREIGN KEY ([IdGridOptions]) REFERENCES [ERPSettings].[GridComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[GridDataSource]
    ADD CONSTRAINT [FK_GridDataSource_GridOptions] FOREIGN KEY ([IdGridOptions]) REFERENCES [ERPSettings].[GridOptions] ([IdGridOptions])
ALTER TABLE [ERPSettings].[GridDataSource]
    ADD CONSTRAINT [FK_GridDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[ServiceParameters]
    ADD CONSTRAINT [FK_ServiceParameters_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[DropDownListOptions]
    ADD CONSTRAINT [FK_DropDownListOptions_DropDownListComponent] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[DropDownListComponent]
    ADD CONSTRAINT [FK_DropDownListComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Filter]
    ADD CONSTRAINT [FK_Filter_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[InputComponent]
    ADD CONSTRAINT [FK_InputComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])

COMMIT TRANSACTION
---- Nihel : Add information parent
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
UPDATE [ERPSettings].[Information] SET [IdInfoParent]=1000500019 WHERE [IdInfo]=1000500026
UPDATE [ERPSettings].[Information] SET [IdInfoParent]=1000500017 WHERE [IdInfo]=1000500029
UPDATE [ERPSettings].[Information] SET [IdInfoParent]=1000500018 WHERE [IdInfo]=1000500033
UPDATE [ERPSettings].[Information] SET [IdInfoParent]=1000500022 WHERE [IdInfo]=1000500035
UPDATE [ERPSettings].[Information] SET [IdInfoParent]=1000500020 WHERE [IdInfo]=1000500039
UPDATE [ERPSettings].[Information] SET [IdInfoParent]=1000500016 WHERE [IdInfo]=1000500041
UPDATE [ERPSettings].[Information] SET [IdInfoParent]=1000500013 WHERE [IdInfo]=1000500043
UPDATE [ERPSettings].[Information] SET [IdInfoParent]=1000500014 WHERE [IdInfo]=1000500045
UPDATE [ERPSettings].[Information] SET [IdInfoParent]=1000500023 WHERE [IdInfo]=1000500047
UPDATE [ERPSettings].[Information] SET [IdInfoParent]=1000500015 WHERE [IdInfo]=1000500048
UPDATE [ERPSettings].[Information] SET [IdInfoParent]=1000500009 WHERE [IdInfo]=1000500050
UPDATE [ERPSettings].[Information] SET [IdInfoParent]=1000500011 WHERE [IdInfo]=1000500052
UPDATE [ERPSettings].[Information] SET [IdInfoParent]=1000500012 WHERE [IdInfo]=1000500054
UPDATE [ERPSettings].[Information] SET [IdInfoParent]=1000500010 WHERE [IdInfo]=1000500056
UPDATE [ERPSettings].[Information] SET [IdInfoParent]=1000500060 WHERE [IdInfo]=1000500065
UPDATE [ERPSettings].[Information] SET [IdInfoParent]=1000500060 WHERE [IdInfo]=1000500066
UPDATE [ERPSettings].[Information] SET [IdInfoParent]=1000501065 WHERE [IdInfo]=1000501066
UPDATE [ERPSettings].[Information] SET [IdInfoParent]=1000501067 WHERE [IdInfo]=1000501068
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
COMMIT TRANSACTION


--- Marwa: fenêtre import ---

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[GridColumnComponent] DROP CONSTRAINT [FK_GridColumnComponent_Component]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
UPDATE [ERPSettings].[GridColumnComponent] SET [field]=N'CheckItem', [template]=N'<input id=checkId''#=Id#'' type=''checkbox'' class=''k-checkbox''  #= IsChecked ? checked=''checked'' : '''' # ng-click=''bController.baseService.actionService.selectRow(this)''><label class=''k-checkbox-label'' for=checkId''#=Id#''></label>', [menu]=0, [headerTemplate]=N'<input type="checkbox" id="header-chb" class="k-checkbox"><label class="k-checkbox-label" for="header-chb"></label>', [filterable]=0, [sortable]=0 WHERE [IdComponent]=N'06254dc8-5466-49fe-b34f-6eb95a30ab58'
UPDATE [ERPSettings].[GridColumnComponent] SET [field]=N'CheckItem', [template]=N'<input id=checkId''#=Id#'' type=''checkbox'' class=''k-checkbox''  #= IsChecked ? checked=''checked'' : '''' # ng-click=''bController.baseService.actionService.selectRow(this)''><label class=''k-checkbox-label'' for=checkId''#=Id#''></label>', [menu]=0, [headerTemplate]=N'<input type="checkbox" id="header-chb" class="k-checkbox"><label class="k-checkbox-label" for="header-chb"></label>', [filterable]=0, [sortable]=0 WHERE [IdComponent]=N'1b613a6f-62fe-4d3d-adee-f047bc9819a7'
UPDATE [ERPSettings].[GridColumnComponent] SET [field]=N'CheckItem', [template]=N'<input id=checkId''#=Id#'' type=''checkbox'' class=''k-checkbox''  #= IsChecked ? checked=''checked'' : '''' # ng-click=''bController.baseService.actionService.selectRow(this)''><label class=''k-checkbox-label'' for=checkId''#=Id#''></label>', [menu]=0, [headerTemplate]=N'<input type="checkbox" id="header-chb" class="k-checkbox"><label class="k-checkbox-label" for="header-chb"></label>', [filterable]=0, [sortable]=0 WHERE [IdComponent]=N'2212c96d-818e-4aaa-8976-27e8ffcdc89d'
UPDATE [ERPSettings].[GridColumnComponent] SET [field]=N'CheckItem', [template]=N'<input id=checkId''#=Id#'' type=''checkbox'' class=''k-checkbox''  #= IsChecked ? checked=''checked'' : '''' # ng-click=''bController.baseService.actionService.selectRow(this)''><label class=''k-checkbox-label'' for=checkId''#=Id#''></label>', [menu]=0, [headerTemplate]=N'<input type="checkbox" id="header-chb" class="k-checkbox"><label class="k-checkbox-label" for="header-chb"></label>', [filterable]=0, [sortable]=0 WHERE [IdComponent]=N'2579dd19-d8de-47b1-822e-4fb1122f7960'
UPDATE [ERPSettings].[GridColumnComponent] SET [field]=N'CheckItem', [template]=N'<input id=checkId''#=Id#'' type=''checkbox'' class=''k-checkbox''  #= IsChecked ? checked=''checked'' : '''' # ng-click=''bController.baseService.actionService.selectRow(this)''><label class=''k-checkbox-label'' for=checkId''#=Id#''></label>', [menu]=0, [headerTemplate]=N'<input type="checkbox" id="header-chb" class="k-checkbox"><label class="k-checkbox-label" for="header-chb"></label>', [filterable]=0, [sortable]=0 WHERE [IdComponent]=N'2d1ce3a7-6554-4406-95df-5d02c359c340'
UPDATE [ERPSettings].[GridColumnComponent] SET [field]=N'CheckItem', [template]=N'<input id=checkId''#=Id#'' type=''checkbox'' class=''k-checkbox''  #= IsChecked ? checked=''checked'' : '''' # ng-click=''bController.baseService.actionService.selectRow(this)''><label class=''k-checkbox-label'' for=checkId''#=Id#''></label>', [menu]=0, [headerTemplate]=N'<input type="checkbox" id="header-chb" class="k-checkbox"><label class="k-checkbox-label" for="header-chb"></label>', [filterable]=0, [sortable]=0 WHERE [IdComponent]=N'35e07c1a-87b2-492c-9ebf-3f9e947af71a'
UPDATE [ERPSettings].[GridColumnComponent] SET [field]=N'CheckItem', [template]=N'<input id=checkId''#=Id#'' type=''checkbox'' class=''k-checkbox''  #= IsChecked ? checked=''checked'' : '''' # ng-click=''bController.baseService.actionService.selectRow(this)''><label class=''k-checkbox-label'' for=checkId''#=Id#''></label>', [menu]=0, [headerTemplate]=N'<input type="checkbox" id="header-chb" class="k-checkbox"><label class="k-checkbox-label" for="header-chb"></label>', [filterable]=0, [sortable]=0 WHERE [IdComponent]=N'392160e6-c646-4c8f-8b21-844c7231967c'
UPDATE [ERPSettings].[GridColumnComponent] SET [field]=N'CheckItem', [template]=N'<input id=checkId''#=Id#'' type=''checkbox'' class=''k-checkbox''  #= IsChecked ? checked=''checked'' : '''' # ng-click=''bController.baseService.actionService.selectRow(this)''><label class=''k-checkbox-label'' for=checkId''#=Id#''></label>', [menu]=0, [headerTemplate]=N'<input type="checkbox" id="header-chb" class="k-checkbox"><label class="k-checkbox-label" for="header-chb"></label>', [filterable]=0, [sortable]=0 WHERE [IdComponent]=N'3e20c9e3-d256-4a46-b7ca-839aa332f6ba'
UPDATE [ERPSettings].[GridColumnComponent] SET [field]=N'CheckItem', [template]=N'<input id=checkId''#=Id#'' type=''checkbox'' class=''k-checkbox''  #= IsChecked ? checked=''checked'' : '''' # ng-click=''bController.baseService.actionService.selectRow(this)''><label class=''k-checkbox-label'' for=checkId''#=Id#''></label>', [menu]=0, [headerTemplate]=N'<input type="checkbox" id="header-chb" class="k-checkbox"><label class="k-checkbox-label" for="header-chb"></label>', [filterable]=0, [sortable]=0 WHERE [IdComponent]=N'45362759-6bc7-44a7-80c9-8502d775f7cc'
UPDATE [ERPSettings].[GridColumnComponent] SET [field]=N'CheckItem', [template]=N'<input id=checkId''#=Id#'' type=''checkbox'' class=''k-checkbox''  #= IsChecked ? checked=''checked'' : '''' # ng-click=''bController.baseService.actionService.selectRow(this)''><label class=''k-checkbox-label'' for=checkId''#=Id#''></label>', [menu]=0, [headerTemplate]=N'<input type="checkbox" id="header-chb" class="k-checkbox"><label class="k-checkbox-label" for="header-chb"></label>', [filterable]=0, [sortable]=0 WHERE [IdComponent]=N'682677cd-96c6-4e54-9a46-b926b0aa7c78'
UPDATE [ERPSettings].[GridColumnComponent] SET [field]=N'CheckItem', [template]=N'<input id=checkId''#=Id#'' type=''checkbox'' class=''k-checkbox''  #= IsChecked ? checked=''checked'' : '''' # ng-click=''bController.baseService.actionService.selectRow(this)''><label class=''k-checkbox-label'' for=checkId''#=Id#''></label>', [menu]=0, [headerTemplate]=N'<input type="checkbox" id="header-chb" class="k-checkbox"><label class="k-checkbox-label" for="header-chb"></label>', [filterable]=0, [sortable]=0 WHERE [IdComponent]=N'8e418afa-623b-4b0e-a5dd-c421fd0c973c'
UPDATE [ERPSettings].[GridColumnComponent] SET [field]=N'CheckItem', [template]=N'<input id=checkId''#=Id#'' type=''checkbox'' class=''k-checkbox''  #= IsChecked ? checked=''checked'' : '''' # ng-click=''bController.baseService.actionService.selectRow(this)''><label class=''k-checkbox-label'' for=checkId''#=Id#''></label>', [menu]=0, [headerTemplate]=N'<input type="checkbox" id="header-chb" class="k-checkbox"><label class="k-checkbox-label" for="header-chb"></label>', [filterable]=0, [sortable]=0 WHERE [IdComponent]=N'cd5bc317-6c48-4a6a-ab87-52733aafd4ef'
UPDATE [ERPSettings].[GridColumnComponent] SET [field]=N'CheckItem', [template]=N'<input id=checkId''#=Id#'' type=''checkbox'' class=''k-checkbox''  #= IsChecked ? checked=''checked'' : '''' # ng-click=''bController.baseService.actionService.selectRow(this)''><label class=''k-checkbox-label'' for=checkId''#=Id#''></label>', [menu]=0, [headerTemplate]=N'<input type="checkbox" id="header-chb" class="k-checkbox"><label class="k-checkbox-label" for="header-chb"></label>', [filterable]=0, [sortable]=0 WHERE [IdComponent]=N'cf83ffc3-b297-4ef2-92a6-a8f4e0d62684'
UPDATE [ERPSettings].[GridColumnComponent] SET [field]=N'CheckItem', [template]=N'<input id=checkId''#=Id#'' type=''checkbox'' class=''k-checkbox''  #= IsChecked ? checked=''checked'' : '''' # ng-click=''bController.baseService.actionService.selectRow(this)''><label class=''k-checkbox-label'' for=checkId''#=Id#''></label>', [menu]=0, [headerTemplate]=N'<input type="checkbox" id="header-chb" class="k-checkbox"><label class="k-checkbox-label" for="header-chb"></label>', [filterable]=0, [sortable]=0 WHERE [IdComponent]=N'e3c0e559-54e2-4d87-923a-cf5cde77b17a'
UPDATE [ERPSettings].[GridColumnComponent] SET [field]=N'CheckItem', [template]=N'<input id=checkId''#=Id#'' type=''checkbox'' class=''k-checkbox''  #= IsChecked ? checked=''checked'' : '''' # ng-click=''bController.baseService.actionService.selectRow(this)''><label class=''k-checkbox-label'' for=checkId''#=Id#''></label>', [menu]=0, [headerTemplate]=N'<input type="checkbox" id="header-chb" class="k-checkbox"><label class="k-checkbox-label" for="header-chb"></label>', [filterable]=0, [sortable]=0 WHERE [IdComponent]=N'e3ceadd7-69bc-4a7d-a8d0-0e8025905129'
UPDATE [ERPSettings].[GridColumnComponent] SET [field]=N'CheckItem', [template]=N'<input id=checkId''#=Id#'' type=''checkbox'' class=''k-checkbox''  #= IsChecked ? checked=''checked'' : '''' # ng-click=''bController.baseService.actionService.selectRow(this)''><label class=''k-checkbox-label'' for=checkId''#=Id#''></label>', [menu]=0, [headerTemplate]=N'<input type="checkbox" id="header-chb" class="k-checkbox"><label class="k-checkbox-label" for="header-chb"></label>', [filterable]=0, [sortable]=0 WHERE [IdComponent]=N'eaf95f7e-ad66-452e-a6d4-844b5efadd9c'
UPDATE [ERPSettings].[Component] SET [FR]=N'', [EN]=N'', [AR]=N'', [DE]=N'', [CH]=N'', [ES]=N'' WHERE [IdComponent]=N'06254dc8-5466-49fe-b34f-6eb95a30ab58'
UPDATE [ERPSettings].[Component] SET [ComponentName]=N'Checkbox', [FR]=N'', [EN]=N'', [AR]=N'', [DE]=N'', [CH]=N'', [ES]=N'' WHERE [IdComponent]=N'1b613a6f-62fe-4d3d-adee-f047bc9819a7'
UPDATE [ERPSettings].[Component] SET [FR]=N'', [EN]=N'', [AR]=N'', [DE]=N'', [CH]=N'', [ES]=N'' WHERE [IdComponent]=N'2212c96d-818e-4aaa-8976-27e8ffcdc89d'
UPDATE [ERPSettings].[Component] SET [FR]=N'', [EN]=N'', [AR]=N'', [DE]=N'', [CH]=N'', [ES]=N'' WHERE [IdComponent]=N'2579dd19-d8de-47b1-822e-4fb1122f7960'
UPDATE [ERPSettings].[Component] SET [ComponentName]=N'Checkbox', [FR]=N'', [EN]=N'', [AR]=N'', [DE]=N'', [CH]=N'', [ES]=N'' WHERE [IdComponent]=N'2d1ce3a7-6554-4406-95df-5d02c359c340'
UPDATE [ERPSettings].[Component] SET [FR]=N'', [EN]=N'', [AR]=N'', [DE]=N'', [CH]=N'', [ES]=N'' WHERE [IdComponent]=N'35e07c1a-87b2-492c-9ebf-3f9e947af71a'
UPDATE [ERPSettings].[Component] SET [FR]=N'', [EN]=N'', [AR]=N'', [DE]=N'', [CH]=N'', [ES]=N'' WHERE [IdComponent]=N'392160e6-c646-4c8f-8b21-844c7231967c'
UPDATE [ERPSettings].[Component] SET [FR]=N'', [EN]=N'', [AR]=N'', [DE]=N'', [CH]=N'', [ES]=N'' WHERE [IdComponent]=N'3e20c9e3-d256-4a46-b7ca-839aa332f6ba'
UPDATE [ERPSettings].[Component] SET [FR]=N'', [EN]=N'', [AR]=N'', [DE]=N'', [CH]=N'', [ES]=N'' WHERE [IdComponent]=N'45362759-6bc7-44a7-80c9-8502d775f7cc'
UPDATE [ERPSettings].[Component] SET [FR]=N'', [EN]=N'', [AR]=N'', [DE]=N'', [CH]=N'', [ES]=N'' WHERE [IdComponent]=N'682677cd-96c6-4e54-9a46-b926b0aa7c78'
UPDATE [ERPSettings].[Component] SET [ComponentName]=N'Checkbox', [FR]=N'', [EN]=N'', [AR]=N'', [DE]=N'', [CH]=N'', [ES]=N'' WHERE [IdComponent]=N'8e418afa-623b-4b0e-a5dd-c421fd0c973c'
UPDATE [ERPSettings].[Component] SET [FR]=N'', [EN]=N'', [AR]=N'', [DE]=N'', [CH]=N'', [ES]=N'' WHERE [IdComponent]=N'cd5bc317-6c48-4a6a-ab87-52733aafd4ef'
UPDATE [ERPSettings].[Component] SET [FR]=N'', [EN]=N'', [AR]=N'', [DE]=N'', [CH]=N'', [ES]=N'' WHERE [IdComponent]=N'cf83ffc3-b297-4ef2-92a6-a8f4e0d62684'
UPDATE [ERPSettings].[Component] SET [FR]=N'', [EN]=N'', [AR]=N'', [DE]=N'', [CH]=N'', [ES]=N'' WHERE [IdComponent]=N'e3c0e559-54e2-4d87-923a-cf5cde77b17a'
UPDATE [ERPSettings].[Component] SET [FR]=N'', [EN]=N'', [AR]=N'', [DE]=N'', [CH]=N'', [ES]=N'' WHERE [IdComponent]=N'e3ceadd7-69bc-4a7d-a8d0-0e8025905129'
UPDATE [ERPSettings].[Component] SET [ComponentName]=N'Checkbox', [FR]=N'', [EN]=N'', [AR]=N'', [DE]=N'', [CH]=N'', [ES]=N'' WHERE [IdComponent]=N'eaf95f7e-ad66-452e-a6d4-844b5efadd9c'
ALTER TABLE [ERPSettings].[GridColumnComponent]
    ADD CONSTRAINT [FK_GridColumnComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
COMMIT TRANSACTION


--Mohamed BOUZIDI Comp.Valeur To Comp.Value

BEGIN TRANSACTION

ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [ERPSettings].[GridColumnComponent] DROP CONSTRAINT [FK_GridColumnComponent_Component]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
UPDATE [ERPSettings].[Codification] SET [LastCounterValue]=N'0020' WHERE [Id]=103
UPDATE [ERPSettings].[Codification] SET [LastCounterValue]=N'0002' WHERE [Id]=106
UPDATE [ERPSettings].[GridColumnComponent] SET [field]=N'Value' WHERE [IdComponent]=N'6e97ffec-a966-40c8-b258-4e21803aac64'
UPDATE [ERPSettings].[Component] SET [ComponentName]=N'Value' WHERE [IdComponent]=N'4fe48462-f5be-4016-b640-89dd3b233491'
UPDATE [ERPSettings].[Component] SET [ComponentName]=N'Value' WHERE [IdComponent]=N'5f793a38-f2ca-48dd-bab1-1381f7e4af59'
UPDATE [ERPSettings].[Component] SET [ComponentName]=N'Value' WHERE [IdComponent]=N'6e97ffec-a966-40c8-b258-4e21803aac64'
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[GridColumnComponent]
    ADD CONSTRAINT [FK_GridColumnComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])

COMMIT TRANSACTION
--- Marwa : correction des bogues ----
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [FK_ServiceParameters_PredicateFormat]
UPDATE [ERPSettings].[Component] SET [FR]=N'Fonction', [EN]=N'Function' WHERE [IdComponent]=N'873d5198-232f-4fd4-b0c4-4e79d1800142'
UPDATE [ERPSettings].[Component] SET [FR]=N'Fonction', [EN]=N'Function' WHERE [IdComponent]=N'8b513bd8-e2af-41cd-9639-12cf5bf23ab8'
UPDATE [ERPSettings].[Component] SET [FR]=N'Nombre de jours de congés payés', [EN]=N'Number of days of paid leave' WHERE [IdComponent]=N'b9236f3f-ba40-411d-aa8a-31c9dcae5759'
UPDATE [ERPSettings].[Component] SET [FR]=N'nombre de jours de congés payés', [EN]=N'Number of days of paid leave' WHERE [IdComponent]=N'ffea742e-07cc-4e5d-8d2d-6679bec58905'
UPDATE [ERPSettings].[ServiceParameters] SET [Method]=N'PUT' WHERE [IdServiceParameters]=N'7a24421e-32ea-456a-9279-56e4c966dcf8'
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ServiceParameters]
    ADD CONSTRAINT [FK_ServiceParameters_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
COMMIT TRANSACTION

---- Nihe: bug fixing
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[CheckBoxComponent] DROP CONSTRAINT [FK_CheckBoxComponent_Component]
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions]
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_ServiceParameters]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
ALTER TABLE [ERPSettings].[DropDownListOptions] DROP CONSTRAINT [FK_DropDownListOptions_DropDownListComponent]
ALTER TABLE [ERPSettings].[Filter] DROP CONSTRAINT [FK_Filter_PredicateFormat]
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [FK_ServiceParameters_PredicateFormat]
UPDATE [ERPSettings].[DropDownListDataSource] SET [pageSize]=32, [serverPaging]=1, [serverFiltering]=1 WHERE [IdDropDownListOptions]=N'7adb526b-9c67-4ab0-8084-1e6decc7aa34'
UPDATE [ERPSettings].[Information] SET [IsAcceptedInfo]=1 WHERE [IdInfo]=1000501067
UPDATE [ERPSettings].[Information] SET [IsAcceptedInfo]=0 WHERE [IdInfo]=1000501068
UPDATE [ERPSettings].[Component] SET [classDiv]=N'form-group col-lg-3 col-md-6 col-sm-12' WHERE [IdComponent]=N'0a365622-80f6-4364-9e13-a81d0316129d'
UPDATE [ERPSettings].[Component] SET [classDiv]=N'form-group col-lg-3 col-md-6 col-sm-12' WHERE [IdComponent]=N'3378dff9-8d62-4a9a-a999-c7b0f622f56e'
UPDATE [ERPSettings].[Component] SET [classDiv]=N'form-group col-lg-3 col-md-6 col-sm-12' WHERE [IdComponent]=N'6f6aa744-61db-478b-8b6a-4d77ea074829'
UPDATE [ERPSettings].[Component] SET [rank]=11 WHERE [IdComponent]=N'9abf5e6d-50b5-4973-ad29-cf36110acd86'
UPDATE [ERPSettings].[Component] SET [rank]=12 WHERE [IdComponent]=N'9e834a87-c047-4f78-bf61-bb4a7f9abe2f'
UPDATE [ERPSettings].[DropDownListOptions] SET [valueTemplate]=N'<span>#if(data.FirstName != null && data.LastName != null){# #: data.FirstName + '' '' + data.LastName # #}#</span>' WHERE [IdDropDownListOptions]=N'08211794-d719-4f8e-9642-37eb55e436c4'
UPDATE [ERPSettings].[DropDownListOptions] SET [valueTemplate]=N'<span>#if(data.FirstName != null && data.LastName != null){# #: data.FirstName + data.LastName # #}#</span>' WHERE [IdDropDownListOptions]=N'1491facb-d394-4a25-b190-f625801fb276'
UPDATE [ERPSettings].[DropDownListOptions] SET [valueTemplate]=N'<span>#if(data.FirstName != null && data.LastName != null){# #: data.FirstName + '' '' + data.LastName # #}#</span>' WHERE [IdDropDownListOptions]=N'21c07572-d1a2-4d59-bb7b-f2dee51caa42'
UPDATE [ERPSettings].[DropDownListOptions] SET [valueTemplate]=N'<span>#if(data.FirstName != null && data.LastName != null){# #: data.FirstName + '' '' + data.LastName # #}#</span>' WHERE [IdDropDownListOptions]=N'3a7e2fc2-270c-418f-bf30-c0a84acb459e'
UPDATE [ERPSettings].[DropDownListOptions] SET [headerTemplate]=N'<div class="dropdown-header k-widget k-header"><span>{{''8f676700-f9c0-4090-83f4-8fbb814f4fc2'' | translate }}</span><span>{{''d3ba5ea3-8503-43b7-9b37-2d342c55ce89'' | translate }}</span></div>', [template]=N'<table class="customDropDown sz-40-60"><tr><td>#:data.FirstName#</td><td>#if(data.LastName != null){# #:data.LastName ## }#</td></tr></table>', [valueTemplate]=N'<span>#if(data.FirstName != null && data.LastName != null){# #: data.FirstName + '' '' + data.LastName # #}#</span>', [footerTemplate]=N'Total #: instance.dataSource.total() #' WHERE [IdDropDownListOptions]=N'7adb526b-9c67-4ab0-8084-1e6decc7aa34'
UPDATE [ERPSettings].[ServiceParameters] SET [Method]=N'POST', [URL]=N'/api/base/getDataSourcePredicate', [IdPredicateFormat]=N'da81fb00-8eee-4c11-9c43-b4d3d834ad10' WHERE [IdServiceParameters]=N'545aa6c3-d7fb-463e-81cd-9a7b6f29c483'
INSERT INTO [ERPSettings].[PredicateFormat] ([IdPredicateFormat], [PredicateName], [Operator], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (N'da81fb00-8eee-4c11-9c43-b4d3d834ad10', NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'6735de9f-0006-4cc4-9da7-4127d692b004', N'da81fb00-8eee-4c11-9c43-b4d3d834ad10', N'FirstName', 2, NULL, 0, NULL, 0, 1, NULL, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'6b55630e-feaa-4c11-9f26-545c7bbc6e56', N'da81fb00-8eee-4c11-9c43-b4d3d834ad10', N'Id', 5, NULL, 1, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Filter] ([IdFilter], [IdPredicateFormat], [Prop], [Operation], [Value], [IsDynamicValue], [TransactionUserId], [IsDeleted], [IsSearchPredicate], [Deleted_Token], [Type]) VALUES (N'b5ce162f-2cf0-4e53-8612-f94a2c44b7c7', N'da81fb00-8eee-4c11-9c43-b4d3d834ad10', N'LastName', 2, NULL, 0, NULL, 0, 1, NULL, NULL)
INSERT INTO [ERPSettings].[Component] ([IdComponent], [rank], [ComponentName], [IdComponentType], [IdFunctionality], [IdComponentParent], [FR], [EN], [AR], [DE], [CH], [ES], [IdButton], [classDiv], [classLabel], [class], [IsEncapsulated], [IdComponentChangedBy], [EntityName], [style], [ng_hide], [IsToInitialize], [IdFunctionalityForm], [IsFireChange]) VALUES (N'b9d3b6a0-e757-41b1-9c36-b3cfe6492d8c', 10, N'IsAcceptedInfo', 13, N'fb782972-bcd1-4f36-ba23-577b5e83363d', N'3a1b42fd-3503-4053-b16c-069c7bf8c62b', N'Acceptation', N'Acceptance', N'Acceptance', N'Acceptance', N'Acceptance', N'Acceptance', N'28f86bd2-88f5-4cb6-8913-ddc0acfce832', N'form-group col-lg-3 col-md-6 col-sm-12', N'col-lg-12 col-md-12 col-sm-12', N'', 0, NULL, N'Information', NULL, NULL, 1, N'fb782972-bcd1-4f36-ba23-577b5e83363d', NULL)
INSERT INTO [ERPSettings].[CheckBoxComponent] ([IdComponent], [Checked], [ng_change]) VALUES (N'b9d3b6a0-e757-41b1-9c36-b3cfe6492d8c', 0, NULL)
INSERT INTO [ERPSettings].[ComponentByRole] ( [IdRole], [IdComponent], [IsActive], [IsVisible], [ReadFunction], [WriteFunction], [TransactionUserId]) VALUES ( 1, N'b9d3b6a0-e757-41b1-9c36-b3cfe6492d8c', 1, 1, NULL, NULL, NULL)

ALTER TABLE [ERPSettings].[CheckBoxComponent]
    ADD CONSTRAINT [FK_CheckBoxComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[DropDownListDataSource]
    ADD CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListOptions] ([IdDropDownListOptions])
ALTER TABLE [ERPSettings].[DropDownListDataSource]
    ADD CONSTRAINT [FK_DropDownListDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[DropDownListOptions]
    ADD CONSTRAINT [FK_DropDownListOptions_DropDownListComponent] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[Filter]
    ADD CONSTRAINT [FK_Filter_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[ServiceParameters]
    ADD CONSTRAINT [FK_ServiceParameters_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
COMMIT TRANSACTION