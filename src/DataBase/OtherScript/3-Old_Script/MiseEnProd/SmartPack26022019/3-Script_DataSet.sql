/*
This script was created by Visual Studio on 26/04/2018 at 15:48.
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
ALTER TABLE [Sales].[PurchaseSettings] DROP CONSTRAINT [FK_PurchaseSetting_Company]
ALTER TABLE [Administration].[EntityAxisValues] DROP CONSTRAINT [FK_EntityAxisValues_AxisValue]
ALTER TABLE [Sales].[SaleSettings] DROP CONSTRAINT [FK_SaleSetting_Company]
ALTER TABLE [Inventory].[TaxeItem] DROP CONSTRAINT [FK_TaxeItem_Taxe]
ALTER TABLE [Inventory].[TaxeItem] DROP CONSTRAINT [FK_TaxeItem_Item]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Role]
ALTER TABLE [ERPSettings].[FunctionalityByRole] DROP CONSTRAINT [FK_FunctionalityRole_Functionality]
ALTER TABLE [ERPSettings].[ColumnMenuComponent] DROP CONSTRAINT [FK_ComponentColumnMenu]
ALTER TABLE [Inventory].[ItemWarehouse] DROP CONSTRAINT [FK_ItemWarehouse_Warehouse]
ALTER TABLE [Inventory].[ItemWarehouse] DROP CONSTRAINT [FK_ItemWarehouse_Item]
ALTER TABLE [ERPSettings].[CheckBoxComponentDetails] DROP CONSTRAINT [FK_CheckBoxDetailsComponent_Component]
ALTER TABLE [ERPSettings].[MsgNotification] DROP CONSTRAINT [FK_MsgNotification_Message]
ALTER TABLE [ERPSettings].[Message] DROP CONSTRAINT [FK_Information_Message]
ALTER TABLE [Payment].[WithholdingTax] DROP CONSTRAINT [FK_WithholdingTax_Tiers]
ALTER TABLE [ERPSettings].[CheckBoxComponent] DROP CONSTRAINT [FK_CheckBoxComponent_Component]

ALTER TABLE [ERPSettings].[ComboBoxDataSourceItems] DROP CONSTRAINT [FK_ComboBoxDataSourceItems_ComboBoxDataSource]
ALTER TABLE [ERPSettings].[InputDatePickerOptions] DROP CONSTRAINT [FK_InputDatePickerOptions_InputComponent]
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [FK_ComboBoxDataSource_ComboBoxOptions]
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [FK_ComboBoxDataSource_ServiceParameters]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Module]
ALTER TABLE [ERPSettings].[ModuleByRole] DROP CONSTRAINT [FK_ModuleByRole_Role]
ALTER TABLE [ERPSettings].[ButtonComponent] DROP CONSTRAINT [FK_ButtonComponent_Component]
ALTER TABLE [ERPSettings].[ButtonComponent] DROP CONSTRAINT [FK_ButtonComponent_ServiceParameters]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[ToolBarItem] DROP CONSTRAINT [FK_ToolBarItemToolBarOptions]
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
ALTER TABLE [ERPSettings].[BarCodeComponent] DROP CONSTRAINT [FK_BarCodeComponent_Component]
ALTER TABLE [ERPSettings].[BarCodeComponent] DROP CONSTRAINT [FK_BarCodeComponent_InputComponent]
ALTER TABLE [ERPSettings].[OrderBy] DROP CONSTRAINT [FK_OrderBy_PredicateFormat]
ALTER TABLE [ERPSettings].[DropDownListOptions] DROP CONSTRAINT [FK_DropDownListOptions_DropDownListComponent]
ALTER TABLE [Payment].[WithholdingTaxLine] DROP CONSTRAINT [FK_WithholdingTaxLine_WithholdingTax]
ALTER TABLE [Sales].[DocumentLineTaxe] DROP CONSTRAINT [FK_DocumentLineTaxe_Taxe]
ALTER TABLE [Sales].[DocumentLineTaxe] DROP CONSTRAINT [FK_DocumentLineTaxe_DocumentLine]
ALTER TABLE [Shared].[Taxe] DROP CONSTRAINT [FK_Taxe_TaxeType]
ALTER TABLE [ERPSettings].[Relation] DROP CONSTRAINT [FK_Relation_PredicateFormat]
ALTER TABLE [ERPSettings].[ReportParameters] DROP CONSTRAINT [FK_ReportViewerParameters_ReportViewerComponent]
ALTER TABLE [Payment].[SettlementCommitment] DROP CONSTRAINT [FK_SettlementCommitment_Settlement]
ALTER TABLE [Payment].[SettlementCommitment] DROP CONSTRAINT [FK_SettlementCommitment_FinancialCommitment]
ALTER TABLE [Stock].[TypeStockCalculation] DROP CONSTRAINT [FK_TYPESTOC_ASSOCIATI_STOCKCAL]
ALTER TABLE [Sales].[DetailsSettlementMode] DROP CONSTRAINT [FK_DetailsSettlementMode_SettlementType]
ALTER TABLE [Sales].[DetailsSettlementMode] DROP CONSTRAINT [FK_DetailsSettlementMode_PaymentMethod]
ALTER TABLE [Sales].[DetailsSettlementMode] DROP CONSTRAINT [FK_DetailsSettlementMode_SettlementMode]
ALTER TABLE [ERPSettings].[DialogComponent] DROP CONSTRAINT [FK_DialogComponent_Component]
ALTER TABLE [Shared].[ZipCode] DROP CONSTRAINT [FK_ZipCode_City]
ALTER TABLE [ERPSettings].[FieldSetComponent] DROP CONSTRAINT [FK_FieldSetComponent_Component]
ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [FK_Information_RoleInfo]
ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [FK_Role_RoleInfo]
ALTER TABLE [Administration].[CurrencyRate] DROP CONSTRAINT [FK_CurrencyRate_Currency]
ALTER TABLE [Stock].[Article] DROP CONSTRAINT [FK_Article_StockManagementMethod]
ALTER TABLE [Stock].[Article] DROP CONSTRAINT [FK_Article_SaleManagementMethod]
ALTER TABLE [Stock].[Article] DROP CONSTRAINT [FK_Article_AccountingAccount]
ALTER TABLE [ERPSettings].[UserRole] DROP CONSTRAINT [FK_UserRole_Role]
ALTER TABLE [ERPSettings].[UserRole] DROP CONSTRAINT [FK_UserRole_User]
ALTER TABLE [ERPSettings].[ComboBoxOptions] DROP CONSTRAINT [FK_ComboBoxOptions_ComboBoxComponent]
ALTER TABLE [ERPSettings].[ComboBoxComponent] DROP CONSTRAINT [FK_ComboboxComponent_Component]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [Payroll].[IdentityPieces] DROP CONSTRAINT [FK_IdentityPieces_TypeIdentityPieces]
ALTER TABLE [Payroll].[IdentityPieces] DROP CONSTRAINT [FK_IdentityPieces_Employee]
ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [FK_Settlement_BankAccount]
ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [FK_Settlement_DocumentStatus]
ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [FK_Settlement_Currency]
ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [FK_Settlement_PaymentMethod]
ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [FK_Settlement_Tiers]
ALTER TABLE [Stock].[Storage] DROP CONSTRAINT [FK_STORAGE_ASSOCIATI_SECTION]
ALTER TABLE [Stock].[Storage] DROP CONSTRAINT [FK_STORAGE_ASSOCIATI_ARTICLE]
ALTER TABLE [ERPSettings].[ComponentByUser] DROP CONSTRAINT [FK_ComponentByUser_User]
ALTER TABLE [ERPSettings].[ComponentByUser] DROP CONSTRAINT [FK_ComponentByUser_Component]
ALTER TABLE [Shared].[ContactTypeDocument] DROP CONSTRAINT [FK_ContactTypeDocument_Contact]
ALTER TABLE [Sales].[TaxeGroupTiersConfig] DROP CONSTRAINT [FK_TaxeTiersConfig_TaxeGroupTiers]
ALTER TABLE [Sales].[TaxeGroupTiersConfig] DROP CONSTRAINT [FK_TaxeTiersConfig_Taxe]
ALTER TABLE [ERPSettings].[GridColumnComponent] DROP CONSTRAINT [FK_GridColumnComponent_Component]
ALTER TABLE [ERPSettings].[ComponentByRole] DROP CONSTRAINT [FK_ComponentByRole_Component]
ALTER TABLE [ERPSettings].[ComponentByRole] DROP CONSTRAINT [FK_ComponentByRole_Role]
ALTER TABLE [ERPSettings].[GridButtonComponent] DROP CONSTRAINT [FK_GridButtonComponent_ServiceParameters]
ALTER TABLE [ERPSettings].[GridButtonComponent] DROP CONSTRAINT [FK_GridButtonComponent_Component]
ALTER TABLE [Treasury].[Timetable] DROP CONSTRAINT [FK_Timetable_PaymentType]
ALTER TABLE [Treasury].[Timetable] DROP CONSTRAINT [FK_Timetable_Tiers]
ALTER TABLE [ERPSettings].[ImageComponent] DROP CONSTRAINT [FK_ImageComponent_Component]
ALTER TABLE [Payroll].[CommercialsCustomerContract] DROP CONSTRAINT [FK_CommercialsCustomerContract_Employee]
ALTER TABLE [Payroll].[CommercialsCustomerContract] DROP CONSTRAINT [FK_CommercialsCustomerContract_Prices]
ALTER TABLE [Stock].[StockDocumentLineSerialNumber] DROP CONSTRAINT [FK_StockDocumentSerialNumber_SerialNumber]
ALTER TABLE [Stock].[SerialNumber] DROP CONSTRAINT [FK_SerialNumber_Article1]
ALTER TABLE [Stock].[SerialNumber] DROP CONSTRAINT [FK_SerialNumber_Batch]
ALTER TABLE [ERPSettings].[GridComponent] DROP CONSTRAINT [FK_GridComponent_Component]
ALTER TABLE [ERPSettings].[FunctionnalityByUser] DROP CONSTRAINT [FK_FunctionnalityByUser_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityByUser] DROP CONSTRAINT [FK_FunctionnalityByUser_User]
ALTER TABLE [Payroll].[ConsultantsCustomerContract] DROP CONSTRAINT [FK_ConsultantsCustomerContract_Employee]
ALTER TABLE [Payroll].[ConsultantsCustomerContract] DROP CONSTRAINT [FK_ConsultantsCustomerContract_Prices]
ALTER TABLE [ERPSettings].[LabelComponent] DROP CONSTRAINT [FK_LabelComponent_Component]
ALTER TABLE [Administration].[AxisRelationShip] DROP CONSTRAINT [FK_AxisRelationShip_Axis1]
ALTER TABLE [Administration].[AxisRelationShip] DROP CONSTRAINT [FK_AxisRelationShip_Axis]
ALTER TABLE [ERPSettings].[InputComponent] DROP CONSTRAINT [FK_InputComponent_Component]
ALTER TABLE [Treasury].[DetailTimetable] DROP CONSTRAINT [FK_DetailTimetable_Timetable]
ALTER TABLE [Treasury].[DetailTimetable] DROP CONSTRAINT [FK_DetailTimetable_PaymentType]
ALTER TABLE [Administration].[AxisValueRelationShip] DROP CONSTRAINT [FK_AxisValueRelationShip_AxisValue]
ALTER TABLE [Administration].[AxisValueRelationShip] DROP CONSTRAINT [FK__AxisRelat__IdAxi__6A3191A0]
ALTER TABLE [Administration].[AxisValue] DROP CONSTRAINT [FK__AxisValue__IdAxi__675524F5]
ALTER TABLE [Shared].[Contact] DROP CONSTRAINT [FK_Contact_Tiers]
ALTER TABLE [ERPSettings].[FormComponent] DROP CONSTRAINT [FK_FormComponent_Component]
ALTER TABLE [ERPSettings].[FormComponent] DROP CONSTRAINT [FK_FormComponent_ServiceParameters]
ALTER TABLE [Treasury].[ReceiptSpent] DROP CONSTRAINT [FK_ReceiptSpent_PaymentMethod]
ALTER TABLE [Treasury].[ReceiptSpent] DROP CONSTRAINT [FK_RecipeSpent_PaymentDirection]
ALTER TABLE [Treasury].[ReceiptSpent] DROP CONSTRAINT [FK_RecipeSpent_Tiers]
ALTER TABLE [Administration].[AxisEntity] DROP CONSTRAINT [FK_AxisEntity_Entity]
ALTER TABLE [Administration].[AxisEntity] DROP CONSTRAINT [FK__AxisEntit__IdAxi__72C6D7A1]
ALTER TABLE [ERPSettings].[Filter] DROP CONSTRAINT [FK_Filter_PredicateFormat]
ALTER TABLE [Shared].[Company] DROP CONSTRAINT [FK_Company_ZipCode]
ALTER TABLE [Shared].[Company] DROP CONSTRAINT [FK_Company_Currency]
ALTER TABLE [Sales].[DocumentLinePrices] DROP CONSTRAINT [FK_DocumentLinePrices_Prices]
ALTER TABLE [Sales].[DocumentLinePrices] DROP CONSTRAINT [FK_DocumentLinePrices_DocumentLine]
ALTER TABLE [Sales].[DocumentLine] DROP CONSTRAINT [FK_DocumentLine_Item]
ALTER TABLE [Sales].[DocumentLine] DROP CONSTRAINT [FK_DocumentLine_Warehouse]
ALTER TABLE [Sales].[DocumentLine] DROP CONSTRAINT [FK_DocumentLine_DocumentLine]
ALTER TABLE [Sales].[DocumentLine] DROP CONSTRAINT [FK_DocumentLine_Prices]
ALTER TABLE [Sales].[DocumentLine] DROP CONSTRAINT [FK_DocumentLine_Document]
ALTER TABLE [Sales].[DocumentLine] DROP CONSTRAINT [FK_DocumentLine_MeasureUnit]
ALTER TABLE [Stock].[StockCalculation] DROP CONSTRAINT [FK_STOCKCAL_ASSOCIATI_DOCUMENT]
ALTER TABLE [Sales].[DocumentTypeRelation] DROP CONSTRAINT [FK_DocumentTypeRelation_DocumentTypeRelation]
ALTER TABLE [Sales].[DocumentTypeRelation] DROP CONSTRAINT [FK_DocumentTypeRelation_DocumentType]
ALTER TABLE [Sales].[DocumentType] DROP CONSTRAINT [FK_DocumentType_DocumentType]
ALTER TABLE [ERPSettings].[QrCodeComponent] DROP CONSTRAINT [FK_QrCodeComponent_Component]
ALTER TABLE [ERPSettings].[QrCodeComponent] DROP CONSTRAINT [FK_QrCodeComponent_InputComponent]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_City]
ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Country]

ALTER TABLE [Shared].[City] DROP CONSTRAINT [FK_City_Country]
ALTER TABLE [ERPSettings].[ToolBarOptions] DROP CONSTRAINT [FK_ToolBarOptionsToolbarComponent]
ALTER TABLE [ERPSettings].[ToolBarComponent] DROP CONSTRAINT [FK_ComponentToolbarComponent]
ALTER TABLE [ERPSettings].[ModuleByUser] DROP CONSTRAINT [FK_ModuleByUser_Module]
ALTER TABLE [ERPSettings].[ModuleByUser] DROP CONSTRAINT [FK_ModuleByUser_User]
ALTER TABLE [Sales].[Document] DROP CONSTRAINT [FK_Document_DocumentStatus]
ALTER TABLE [Sales].[Document] DROP CONSTRAINT [FK_Document_PaymentMethod]
ALTER TABLE [Sales].[Document] DROP CONSTRAINT [FK_Document_Tiers]
ALTER TABLE [Sales].[Document] DROP CONSTRAINT [FK_Document_SettlementMode]
ALTER TABLE [Sales].[Document] DROP CONSTRAINT [FK_Document_Currency]
ALTER TABLE [Sales].[Document] DROP CONSTRAINT [FK_Document_BankAccount]
ALTER TABLE [Sales].[Document] DROP CONSTRAINT [FK_Document_Employee]
ALTER TABLE [Inventory].[StockDocumentLine] DROP CONSTRAINT [FK_StockDocumentLine_StockDocument]
ALTER TABLE [Inventory].[StockDocumentLine] DROP CONSTRAINT [FK_StockDocumentLine_Item]
ALTER TABLE [Inventory].[StockDocument] DROP CONSTRAINT [FK_StockDocument_Warehouse]
ALTER TABLE [Inventory].[StockDocument] DROP CONSTRAINT [FK_StockDocument_Warehouse1]
ALTER TABLE [Inventory].[StockDocument] DROP CONSTRAINT [FK_StockDocument_TypeStockDocument]
ALTER TABLE [Inventory].[StockDocument] DROP CONSTRAINT [FK_StockDocument_DocumentStatus]
ALTER TABLE [ERPSettings].[Traceability] DROP CONSTRAINT [FK_Traceability_User]
ALTER TABLE [ERPSettings].[RadioButtonComponentDetails] DROP CONSTRAINT [FK_RadioButtonComponentDetails_Component]
ALTER TABLE [ERPSettings].[RadioButtonComponent] DROP CONSTRAINT [FK_RadioButtonComponent_Component]
ALTER TABLE [Stock].[StockMovement] DROP CONSTRAINT [FK_StockMovement_StockDocumentLine]
ALTER TABLE [Stock].[StockMovement] DROP CONSTRAINT [FK_StockMovement_Warehouse]
ALTER TABLE [Stock].[StockMovement] DROP CONSTRAINT [FK_StockMovement_DocumentLine]
ALTER TABLE [Stock].[StockMovement] DROP CONSTRAINT [FK_StockMovement_Item]
ALTER TABLE [Inventory].[Warehouse] DROP CONSTRAINT [FK_Warehouse_Warehouse]
ALTER TABLE [Inventory].[Item] DROP CONSTRAINT [FK_Item_DiscountGroupItem]
ALTER TABLE [Inventory].[Item] DROP CONSTRAINT [FK_Item_UnitType]
ALTER TABLE [Inventory].[Item] DROP CONSTRAINT [FK_Item_UnitType1]
ALTER TABLE [Inventory].[Item] DROP CONSTRAINT [FK_Item_Nature]
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [FK_GridDataSource_GridOptions]
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [FK_GridDataSource_ServiceParameters]
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [FK_GridOptions_GridComponent]
ALTER TABLE [Sales].[FinancialCommitment] DROP CONSTRAINT [FK_FinancialCommitment_DocumentStatus]
ALTER TABLE [Sales].[FinancialCommitment] DROP CONSTRAINT [FK_FinancialCommitment_PaymentMethod]
ALTER TABLE [Sales].[FinancialCommitment] DROP CONSTRAINT [FK_FinancialCommitment_Document]
ALTER TABLE [Payment].[PaymentMethod] DROP CONSTRAINT [FK_PayementMethod_PayementType]
ALTER TABLE [ERPSettings].[ReportComponent] DROP CONSTRAINT [FK_ReportViewerComponent_Component]
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions]
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_ServiceParameters]
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [FK_ServiceParameters_PredicateFormat]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_Tiers_City]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_Tiers_Currency]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_TIERS_ASSOCIATI_PAYEMENT]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_TIERS_ASSOCIATI_TYPETIER]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_Tiers_Country]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_Tiers_AccountingAccount]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_Tiers_TaxeGroupTiers]
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_Tiers_DiscountGroupTiers]
ALTER TABLE [Sales].[Prices] DROP CONSTRAINT [FK_Prices_DiscountGroupTiers]
ALTER TABLE [Sales].[Prices] DROP CONSTRAINT [FK_Prices_DiscountGroupItem]
ALTER TABLE [Sales].[Prices] DROP CONSTRAINT [FK_Prices_Item]
ALTER TABLE [Sales].[Prices] DROP CONSTRAINT [FK_Prices_Tiers]
ALTER TABLE [Sales].[Prices] DROP CONSTRAINT [FK_Prices_Currency]
ALTER TABLE [ERPSettings].[UserInfo] DROP CONSTRAINT [FK_Info_UserInfo]
ALTER TABLE [ERPSettings].[UserInfo] DROP CONSTRAINT [FK_User_UserInfo]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
ALTER TABLE [ERPSettings].[DropDownListComponent] DROP CONSTRAINT [FK_DropDownListComponent_Component]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality]
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component]
SET IDENTITY_INSERT [Administration].[Currency] ON
INSERT INTO [Administration].[Currency] ([Id], [Code], [Symbole], [Description], [CurrencyInLetter], [FloatInLetter], [SalePrecision], [PurchasePrecision], [IsActive], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'TND', N'TND', N'Dinar Tunisien', N'Dinar', N'Millime', 3, 3, 1, 0, 0, NULL)
INSERT INTO [Administration].[Currency] ([Id], [Code], [Symbole], [Description], [CurrencyInLetter], [FloatInLetter], [SalePrecision], [PurchasePrecision], [IsActive], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'EURO', N'€', N'Euro', N'Euros', N'Centime', 2, 2, 1, 0, 0, NULL)
INSERT INTO [Administration].[Currency] ([Id], [Code], [Symbole], [Description], [CurrencyInLetter], [FloatInLetter], [SalePrecision], [PurchasePrecision], [IsActive], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'DOLLAR', N'$', N'Dollar', N'Dollar', N'Penny', 3, 3, 1, 0, 0, NULL)
SET IDENTITY_INSERT [Administration].[Currency] OFF

INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [TypeDocument_int_1], [TypeDocument_int_2], [TypeDocument_int_3], [TypeDocument_int_4], [TypeDocument_int_5], [TypeDocument_int_6], [TypeDocument_int_7], [TypeDocument_int_8], [TypeDocument_int_9], [TypeDocument_int_10], [TypeDocument_bit_1], [TypeDocument_bit_2], [TypeDocument_bit_3], [TypeDocument_bit_4], [TypeDocument_bit_5], [TypeDocument_bit_6], [TypeDocument_bit_7], [TypeDocument_bit_8], [TypeDocument_bit_9], [TypeDocument_bit_10], [TypeDocument_float_1], [TypeDocument_float_2], [TypeDocument_float_3], [TypeDocument_float_4], [TypeDocument_float_5], [TypeDocument_float_6], [TypeDocument_float_7], [TypeDocument_float_8], [TypeDocument_float_9], [TypeDocument_float_10], [TypeDocument_varchar_1], [TypeDocument_varchar_2], [TypeDocument_varchar_3], [TypeDocument_varchar_4], [TypeDocument_varchar_5], [TypeDocument_varchar_6], [TypeDocument_varchar_7], [TypeDocument_varchar_8], [TypeDocument_varchar_9], [TypeDocument_varchar_10], [TypeDocument_date_1], [TypeDocument_date_2], [TypeDocument_date_3], [TypeDocument_date_4], [TypeDocument_date_5], [TypeDocument_date_6], [TypeDocument_date_7], [TypeDocument_date_8], [TypeDocument_date_9], [TypeDocument_date_10], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected]) VALUES (N'A-PU', N'A-PU', N'Avoir Fournisseur', N'Facture d''avoir', NULL, 1, N'O', N'R', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [TypeDocument_int_1], [TypeDocument_int_2], [TypeDocument_int_3], [TypeDocument_int_4], [TypeDocument_int_5], [TypeDocument_int_6], [TypeDocument_int_7], [TypeDocument_int_8], [TypeDocument_int_9], [TypeDocument_int_10], [TypeDocument_bit_1], [TypeDocument_bit_2], [TypeDocument_bit_3], [TypeDocument_bit_4], [TypeDocument_bit_5], [TypeDocument_bit_6], [TypeDocument_bit_7], [TypeDocument_bit_8], [TypeDocument_bit_9], [TypeDocument_bit_10], [TypeDocument_float_1], [TypeDocument_float_2], [TypeDocument_float_3], [TypeDocument_float_4], [TypeDocument_float_5], [TypeDocument_float_6], [TypeDocument_float_7], [TypeDocument_float_8], [TypeDocument_float_9], [TypeDocument_float_10], [TypeDocument_varchar_1], [TypeDocument_varchar_2], [TypeDocument_varchar_3], [TypeDocument_varchar_4], [TypeDocument_varchar_5], [TypeDocument_varchar_6], [TypeDocument_varchar_7], [TypeDocument_varchar_8], [TypeDocument_varchar_9], [TypeDocument_varchar_10], [TypeDocument_date_1], [TypeDocument_date_2], [TypeDocument_date_3], [TypeDocument_date_4], [TypeDocument_date_5], [TypeDocument_date_6], [TypeDocument_date_7], [TypeDocument_date_8], [TypeDocument_date_9], [TypeDocument_date_10], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected]) VALUES (N'A-SA', N'A-SA', N'Avoir Client', N'Facture d''avoir', N'I-SA', 1, N'I', N'R', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0)
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [TypeDocument_int_1], [TypeDocument_int_2], [TypeDocument_int_3], [TypeDocument_int_4], [TypeDocument_int_5], [TypeDocument_int_6], [TypeDocument_int_7], [TypeDocument_int_8], [TypeDocument_int_9], [TypeDocument_int_10], [TypeDocument_bit_1], [TypeDocument_bit_2], [TypeDocument_bit_3], [TypeDocument_bit_4], [TypeDocument_bit_5], [TypeDocument_bit_6], [TypeDocument_bit_7], [TypeDocument_bit_8], [TypeDocument_bit_9], [TypeDocument_bit_10], [TypeDocument_float_1], [TypeDocument_float_2], [TypeDocument_float_3], [TypeDocument_float_4], [TypeDocument_float_5], [TypeDocument_float_6], [TypeDocument_float_7], [TypeDocument_float_8], [TypeDocument_float_9], [TypeDocument_float_10], [TypeDocument_varchar_1], [TypeDocument_varchar_2], [TypeDocument_varchar_3], [TypeDocument_varchar_4], [TypeDocument_varchar_5], [TypeDocument_varchar_6], [TypeDocument_varchar_7], [TypeDocument_varchar_8], [TypeDocument_varchar_9], [TypeDocument_varchar_10], [TypeDocument_date_1], [TypeDocument_date_2], [TypeDocument_date_3], [TypeDocument_date_4], [TypeDocument_date_5], [TypeDocument_date_6], [TypeDocument_date_7], [TypeDocument_date_8], [TypeDocument_date_9], [TypeDocument_date_10], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected]) VALUES (N'D-PU', N'D-PU', N'Bon de reception', N'Bon de reception', N'O-PU', 1, N'I', N'R', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [TypeDocument_int_1], [TypeDocument_int_2], [TypeDocument_int_3], [TypeDocument_int_4], [TypeDocument_int_5], [TypeDocument_int_6], [TypeDocument_int_7], [TypeDocument_int_8], [TypeDocument_int_9], [TypeDocument_int_10], [TypeDocument_bit_1], [TypeDocument_bit_2], [TypeDocument_bit_3], [TypeDocument_bit_4], [TypeDocument_bit_5], [TypeDocument_bit_6], [TypeDocument_bit_7], [TypeDocument_bit_8], [TypeDocument_bit_9], [TypeDocument_bit_10], [TypeDocument_float_1], [TypeDocument_float_2], [TypeDocument_float_3], [TypeDocument_float_4], [TypeDocument_float_5], [TypeDocument_float_6], [TypeDocument_float_7], [TypeDocument_float_8], [TypeDocument_float_9], [TypeDocument_float_10], [TypeDocument_varchar_1], [TypeDocument_varchar_2], [TypeDocument_varchar_3], [TypeDocument_varchar_4], [TypeDocument_varchar_5], [TypeDocument_varchar_6], [TypeDocument_varchar_7], [TypeDocument_varchar_8], [TypeDocument_varchar_9], [TypeDocument_varchar_10], [TypeDocument_date_1], [TypeDocument_date_2], [TypeDocument_date_3], [TypeDocument_date_4], [TypeDocument_date_5], [TypeDocument_date_6], [TypeDocument_date_7], [TypeDocument_date_8], [TypeDocument_date_9], [TypeDocument_date_10], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected]) VALUES (N'D-SA', N'D-SA', N'Bon de livraison', N'Bon de livraison', N'O-SA', 1, N'O', N'R', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0)
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [TypeDocument_int_1], [TypeDocument_int_2], [TypeDocument_int_3], [TypeDocument_int_4], [TypeDocument_int_5], [TypeDocument_int_6], [TypeDocument_int_7], [TypeDocument_int_8], [TypeDocument_int_9], [TypeDocument_int_10], [TypeDocument_bit_1], [TypeDocument_bit_2], [TypeDocument_bit_3], [TypeDocument_bit_4], [TypeDocument_bit_5], [TypeDocument_bit_6], [TypeDocument_bit_7], [TypeDocument_bit_8], [TypeDocument_bit_9], [TypeDocument_bit_10], [TypeDocument_float_1], [TypeDocument_float_2], [TypeDocument_float_3], [TypeDocument_float_4], [TypeDocument_float_5], [TypeDocument_float_6], [TypeDocument_float_7], [TypeDocument_float_8], [TypeDocument_float_9], [TypeDocument_float_10], [TypeDocument_varchar_1], [TypeDocument_varchar_2], [TypeDocument_varchar_3], [TypeDocument_varchar_4], [TypeDocument_varchar_5], [TypeDocument_varchar_6], [TypeDocument_varchar_7], [TypeDocument_varchar_8], [TypeDocument_varchar_9], [TypeDocument_varchar_10], [TypeDocument_date_1], [TypeDocument_date_2], [TypeDocument_date_3], [TypeDocument_date_4], [TypeDocument_date_5], [TypeDocument_date_6], [TypeDocument_date_7], [TypeDocument_date_8], [TypeDocument_date_9], [TypeDocument_date_10], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected]) VALUES (N'I-PU', N'I-PU', N'Facture Achat', N'Facture d''achat', N'D-PU', 0, NULL, NULL, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [TypeDocument_int_1], [TypeDocument_int_2], [TypeDocument_int_3], [TypeDocument_int_4], [TypeDocument_int_5], [TypeDocument_int_6], [TypeDocument_int_7], [TypeDocument_int_8], [TypeDocument_int_9], [TypeDocument_int_10], [TypeDocument_bit_1], [TypeDocument_bit_2], [TypeDocument_bit_3], [TypeDocument_bit_4], [TypeDocument_bit_5], [TypeDocument_bit_6], [TypeDocument_bit_7], [TypeDocument_bit_8], [TypeDocument_bit_9], [TypeDocument_bit_10], [TypeDocument_float_1], [TypeDocument_float_2], [TypeDocument_float_3], [TypeDocument_float_4], [TypeDocument_float_5], [TypeDocument_float_6], [TypeDocument_float_7], [TypeDocument_float_8], [TypeDocument_float_9], [TypeDocument_float_10], [TypeDocument_varchar_1], [TypeDocument_varchar_2], [TypeDocument_varchar_3], [TypeDocument_varchar_4], [TypeDocument_varchar_5], [TypeDocument_varchar_6], [TypeDocument_varchar_7], [TypeDocument_varchar_8], [TypeDocument_varchar_9], [TypeDocument_varchar_10], [TypeDocument_date_1], [TypeDocument_date_2], [TypeDocument_date_3], [TypeDocument_date_4], [TypeDocument_date_5], [TypeDocument_date_6], [TypeDocument_date_7], [TypeDocument_date_8], [TypeDocument_date_9], [TypeDocument_date_10], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected]) VALUES (N'I-SA', N'I-SA', N'Facture', N'Facture de vente', N'D-SA', 0, NULL, NULL, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0)
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [TypeDocument_int_1], [TypeDocument_int_2], [TypeDocument_int_3], [TypeDocument_int_4], [TypeDocument_int_5], [TypeDocument_int_6], [TypeDocument_int_7], [TypeDocument_int_8], [TypeDocument_int_9], [TypeDocument_int_10], [TypeDocument_bit_1], [TypeDocument_bit_2], [TypeDocument_bit_3], [TypeDocument_bit_4], [TypeDocument_bit_5], [TypeDocument_bit_6], [TypeDocument_bit_7], [TypeDocument_bit_8], [TypeDocument_bit_9], [TypeDocument_bit_10], [TypeDocument_float_1], [TypeDocument_float_2], [TypeDocument_float_3], [TypeDocument_float_4], [TypeDocument_float_5], [TypeDocument_float_6], [TypeDocument_float_7], [TypeDocument_float_8], [TypeDocument_float_9], [TypeDocument_float_10], [TypeDocument_varchar_1], [TypeDocument_varchar_2], [TypeDocument_varchar_3], [TypeDocument_varchar_4], [TypeDocument_varchar_5], [TypeDocument_varchar_6], [TypeDocument_varchar_7], [TypeDocument_varchar_8], [TypeDocument_varchar_9], [TypeDocument_varchar_10], [TypeDocument_date_1], [TypeDocument_date_2], [TypeDocument_date_3], [TypeDocument_date_4], [TypeDocument_date_5], [TypeDocument_date_6], [TypeDocument_date_7], [TypeDocument_date_8], [TypeDocument_date_9], [TypeDocument_date_10], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected]) VALUES (N'O-PU', N'O-PU', N'Bon de commande Achat', N'Bon de commande', N'Q-PU', 1, N'I', N'P', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [TypeDocument_int_1], [TypeDocument_int_2], [TypeDocument_int_3], [TypeDocument_int_4], [TypeDocument_int_5], [TypeDocument_int_6], [TypeDocument_int_7], [TypeDocument_int_8], [TypeDocument_int_9], [TypeDocument_int_10], [TypeDocument_bit_1], [TypeDocument_bit_2], [TypeDocument_bit_3], [TypeDocument_bit_4], [TypeDocument_bit_5], [TypeDocument_bit_6], [TypeDocument_bit_7], [TypeDocument_bit_8], [TypeDocument_bit_9], [TypeDocument_bit_10], [TypeDocument_float_1], [TypeDocument_float_2], [TypeDocument_float_3], [TypeDocument_float_4], [TypeDocument_float_5], [TypeDocument_float_6], [TypeDocument_float_7], [TypeDocument_float_8], [TypeDocument_float_9], [TypeDocument_float_10], [TypeDocument_varchar_1], [TypeDocument_varchar_2], [TypeDocument_varchar_3], [TypeDocument_varchar_4], [TypeDocument_varchar_5], [TypeDocument_varchar_6], [TypeDocument_varchar_7], [TypeDocument_varchar_8], [TypeDocument_varchar_9], [TypeDocument_varchar_10], [TypeDocument_date_1], [TypeDocument_date_2], [TypeDocument_date_3], [TypeDocument_date_4], [TypeDocument_date_5], [TypeDocument_date_6], [TypeDocument_date_7], [TypeDocument_date_8], [TypeDocument_date_9], [TypeDocument_date_10], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected]) VALUES (N'O-SA', N'O-SA', N'Bon de commande', N'Bon de commande', N'Q-SA', 1, N'O', N'P', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0)
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [TypeDocument_int_1], [TypeDocument_int_2], [TypeDocument_int_3], [TypeDocument_int_4], [TypeDocument_int_5], [TypeDocument_int_6], [TypeDocument_int_7], [TypeDocument_int_8], [TypeDocument_int_9], [TypeDocument_int_10], [TypeDocument_bit_1], [TypeDocument_bit_2], [TypeDocument_bit_3], [TypeDocument_bit_4], [TypeDocument_bit_5], [TypeDocument_bit_6], [TypeDocument_bit_7], [TypeDocument_bit_8], [TypeDocument_bit_9], [TypeDocument_bit_10], [TypeDocument_float_1], [TypeDocument_float_2], [TypeDocument_float_3], [TypeDocument_float_4], [TypeDocument_float_5], [TypeDocument_float_6], [TypeDocument_float_7], [TypeDocument_float_8], [TypeDocument_float_9], [TypeDocument_float_10], [TypeDocument_varchar_1], [TypeDocument_varchar_2], [TypeDocument_varchar_3], [TypeDocument_varchar_4], [TypeDocument_varchar_5], [TypeDocument_varchar_6], [TypeDocument_varchar_7], [TypeDocument_varchar_8], [TypeDocument_varchar_9], [TypeDocument_varchar_10], [TypeDocument_date_1], [TypeDocument_date_2], [TypeDocument_date_3], [TypeDocument_date_4], [TypeDocument_date_5], [TypeDocument_date_6], [TypeDocument_date_7], [TypeDocument_date_8], [TypeDocument_date_9], [TypeDocument_date_10], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected]) VALUES (N'Q-PU', N'Q-PU', N'Purchase quotation', N'Devis', NULL, 0, N'I', NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [TypeDocument_int_1], [TypeDocument_int_2], [TypeDocument_int_3], [TypeDocument_int_4], [TypeDocument_int_5], [TypeDocument_int_6], [TypeDocument_int_7], [TypeDocument_int_8], [TypeDocument_int_9], [TypeDocument_int_10], [TypeDocument_bit_1], [TypeDocument_bit_2], [TypeDocument_bit_3], [TypeDocument_bit_4], [TypeDocument_bit_5], [TypeDocument_bit_6], [TypeDocument_bit_7], [TypeDocument_bit_8], [TypeDocument_bit_9], [TypeDocument_bit_10], [TypeDocument_float_1], [TypeDocument_float_2], [TypeDocument_float_3], [TypeDocument_float_4], [TypeDocument_float_5], [TypeDocument_float_6], [TypeDocument_float_7], [TypeDocument_float_8], [TypeDocument_float_9], [TypeDocument_float_10], [TypeDocument_varchar_1], [TypeDocument_varchar_2], [TypeDocument_varchar_3], [TypeDocument_varchar_4], [TypeDocument_varchar_5], [TypeDocument_varchar_6], [TypeDocument_varchar_7], [TypeDocument_varchar_8], [TypeDocument_varchar_9], [TypeDocument_varchar_10], [TypeDocument_date_1], [TypeDocument_date_2], [TypeDocument_date_3], [TypeDocument_date_4], [TypeDocument_date_5], [TypeDocument_date_6], [TypeDocument_date_7], [TypeDocument_date_8], [TypeDocument_date_9], [TypeDocument_date_10], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected]) VALUES (N'Q-SA', N'Q-SA', N'Devis', N'Devis', NULL, 0, N'I', NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0)
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [TypeDocument_int_1], [TypeDocument_int_2], [TypeDocument_int_3], [TypeDocument_int_4], [TypeDocument_int_5], [TypeDocument_int_6], [TypeDocument_int_7], [TypeDocument_int_8], [TypeDocument_int_9], [TypeDocument_int_10], [TypeDocument_bit_1], [TypeDocument_bit_2], [TypeDocument_bit_3], [TypeDocument_bit_4], [TypeDocument_bit_5], [TypeDocument_bit_6], [TypeDocument_bit_7], [TypeDocument_bit_8], [TypeDocument_bit_9], [TypeDocument_bit_10], [TypeDocument_float_1], [TypeDocument_float_2], [TypeDocument_float_3], [TypeDocument_float_4], [TypeDocument_float_5], [TypeDocument_float_6], [TypeDocument_float_7], [TypeDocument_float_8], [TypeDocument_float_9], [TypeDocument_float_10], [TypeDocument_varchar_1], [TypeDocument_varchar_2], [TypeDocument_varchar_3], [TypeDocument_varchar_4], [TypeDocument_varchar_5], [TypeDocument_varchar_6], [TypeDocument_varchar_7], [TypeDocument_varchar_8], [TypeDocument_varchar_9], [TypeDocument_varchar_10], [TypeDocument_date_1], [TypeDocument_date_2], [TypeDocument_date_3], [TypeDocument_date_4], [TypeDocument_date_5], [TypeDocument_date_6], [TypeDocument_date_7], [TypeDocument_date_8], [TypeDocument_date_9], [TypeDocument_date_10], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected]) VALUES (N'R-PU', N'R-PU', N'Bon de retour Achat', N'Bon de retour', NULL, 1, N'O', N'R', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [TypeDocument_int_1], [TypeDocument_int_2], [TypeDocument_int_3], [TypeDocument_int_4], [TypeDocument_int_5], [TypeDocument_int_6], [TypeDocument_int_7], [TypeDocument_int_8], [TypeDocument_int_9], [TypeDocument_int_10], [TypeDocument_bit_1], [TypeDocument_bit_2], [TypeDocument_bit_3], [TypeDocument_bit_4], [TypeDocument_bit_5], [TypeDocument_bit_6], [TypeDocument_bit_7], [TypeDocument_bit_8], [TypeDocument_bit_9], [TypeDocument_bit_10], [TypeDocument_float_1], [TypeDocument_float_2], [TypeDocument_float_3], [TypeDocument_float_4], [TypeDocument_float_5], [TypeDocument_float_6], [TypeDocument_float_7], [TypeDocument_float_8], [TypeDocument_float_9], [TypeDocument_float_10], [TypeDocument_varchar_1], [TypeDocument_varchar_2], [TypeDocument_varchar_3], [TypeDocument_varchar_4], [TypeDocument_varchar_5], [TypeDocument_varchar_6], [TypeDocument_varchar_7], [TypeDocument_varchar_8], [TypeDocument_varchar_9], [TypeDocument_varchar_10], [TypeDocument_date_1], [TypeDocument_date_2], [TypeDocument_date_3], [TypeDocument_date_4], [TypeDocument_date_5], [TypeDocument_date_6], [TypeDocument_date_7], [TypeDocument_date_8], [TypeDocument_date_9], [TypeDocument_date_10], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected]) VALUES (N'R-SA', N'R-SA', N'Bon de retour Vente', N'Bon de retour', NULL, 1, N'I', N'R', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0)
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [TypeDocument_int_1], [TypeDocument_int_2], [TypeDocument_int_3], [TypeDocument_int_4], [TypeDocument_int_5], [TypeDocument_int_6], [TypeDocument_int_7], [TypeDocument_int_8], [TypeDocument_int_9], [TypeDocument_int_10], [TypeDocument_bit_1], [TypeDocument_bit_2], [TypeDocument_bit_3], [TypeDocument_bit_4], [TypeDocument_bit_5], [TypeDocument_bit_6], [TypeDocument_bit_7], [TypeDocument_bit_8], [TypeDocument_bit_9], [TypeDocument_bit_10], [TypeDocument_float_1], [TypeDocument_float_2], [TypeDocument_float_3], [TypeDocument_float_4], [TypeDocument_float_5], [TypeDocument_float_6], [TypeDocument_float_7], [TypeDocument_float_8], [TypeDocument_float_9], [TypeDocument_float_10], [TypeDocument_varchar_1], [TypeDocument_varchar_2], [TypeDocument_varchar_3], [TypeDocument_varchar_4], [TypeDocument_varchar_5], [TypeDocument_varchar_6], [TypeDocument_varchar_7], [TypeDocument_varchar_8], [TypeDocument_varchar_9], [TypeDocument_varchar_10], [TypeDocument_date_1], [TypeDocument_date_2], [TypeDocument_date_3], [TypeDocument_date_4], [TypeDocument_date_5], [TypeDocument_date_6], [TypeDocument_date_7], [TypeDocument_date_8], [TypeDocument_date_9], [TypeDocument_date_10], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected], [FinancialCommitmentDirection], [IsActiveGeneration]) VALUES (N'B-PU', N'B-PU', N'Devis achat', N'Devis achat', NULL, 0, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0)

SET IDENTITY_INSERT [Sales].[DocumentTypeRelation] ON
INSERT INTO [Sales].[DocumentTypeRelation] ([id], [CodeDocumentType], [CodeDocumentTypeAssociated]) VALUES (2, N'D-PU', N'O-PU')
INSERT INTO [Sales].[DocumentTypeRelation] ([id], [CodeDocumentType], [CodeDocumentTypeAssociated]) VALUES (3, N'D-SA', N'O-SA')
INSERT INTO [Sales].[DocumentTypeRelation] ([id], [CodeDocumentType], [CodeDocumentTypeAssociated]) VALUES (4, N'I-PU', N'D-PU')
INSERT INTO [Sales].[DocumentTypeRelation] ([id], [CodeDocumentType], [CodeDocumentTypeAssociated]) VALUES (5, N'I-SA', N'D-SA')
INSERT INTO [Sales].[DocumentTypeRelation] ([id], [CodeDocumentType], [CodeDocumentTypeAssociated]) VALUES (6, N'O-PU', N'Q-PU')
INSERT INTO [Sales].[DocumentTypeRelation] ([id], [CodeDocumentType], [CodeDocumentTypeAssociated]) VALUES (7, N'O-SA', N'Q-SA')
INSERT INTO [Sales].[DocumentTypeRelation] ([id], [CodeDocumentType], [CodeDocumentTypeAssociated]) VALUES (8, N'A-PU', N'I-PU')
SET IDENTITY_INSERT [Sales].[DocumentTypeRelation] OFF
SET IDENTITY_INSERT [Sales].[TypeTiers] ON
INSERT INTO [Sales].[TypeTiers] ([Id], [Label], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Client', N'client', 0, 0, NULL)
INSERT INTO [Sales].[TypeTiers] ([Id], [Label], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Fournisseur', N'fournisseur', 0, 0, NULL)
INSERT INTO [Sales].[TypeTiers] ([Id], [Label], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Tier', N'Tier', 0, 0, NULL)
INSERT INTO [Sales].[TypeTiers] ([Id], [Label], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'Représentant', N'Représentant', 0, 0, NULL)
SET IDENTITY_INSERT [Sales].[TypeTiers] OFF

SET IDENTITY_INSERT [Sales].[DocumentStatus] ON
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Provisoire', N'Provisoire', 0, 0, NULL)
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Validé', N'Validé', 0, 0, NULL)
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Soldé', N'Soldé', 0, 0, NULL)
SET IDENTITY_INSERT [Sales].[DocumentStatus] OFF

SET IDENTITY_INSERT [Payment].[PaymentType] ON
INSERT INTO [Payment].[PaymentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [PaymentType_int_1], [PaymentType_int_2], [PaymentType_int_3], [PaymentType_int_4], [PaymentType_int_5], [PaymentType_int_6], [PaymentType_int_7], [PaymentType_int_8], [PaymentType_int_9], [PaymentType_int_10], [PaymentType_bit_1], [PaymentType_bit_2], [PaymentType_bit_3], [PaymentType_bit_4], [PaymentType_bit_5], [PaymentType_bit_6], [PaymentType_bit_7], [PaymentType_bit_8], [PaymentType_bit_9], [PaymentType_bit_10], [PaymentType_float_1], [PaymentType_float_2], [PaymentType_float_3], [PaymentType_float_4], [PaymentType_float_5], [PaymentType_float_6], [PaymentType_float_7], [PaymentType_float_8], [PaymentType_float_9], [PaymentType_float_10], [PaymentType_varchar_1], [PaymentType_varchar_2], [PaymentType_varchar_3], [PaymentType_varchar_4], [PaymentType_varchar_5], [PaymentType_varchar_6], [PaymentType_varchar_7], [PaymentType_varchar_8], [PaymentType_varchar_9], [PaymentType_varchar_10], [PaymentType_date_1], [PaymentType_date_2], [PaymentType_date_3], [PaymentType_date_4], [PaymentType_date_5], [PaymentType_date_6], [PaymentType_date_7], [PaymentType_date_8], [PaymentType_date_9], [PaymentType_date_10], [Deleted_Token], [Code]) VALUES (4, N'Espèce', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ESP')
INSERT INTO [Payment].[PaymentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [PaymentType_int_1], [PaymentType_int_2], [PaymentType_int_3], [PaymentType_int_4], [PaymentType_int_5], [PaymentType_int_6], [PaymentType_int_7], [PaymentType_int_8], [PaymentType_int_9], [PaymentType_int_10], [PaymentType_bit_1], [PaymentType_bit_2], [PaymentType_bit_3], [PaymentType_bit_4], [PaymentType_bit_5], [PaymentType_bit_6], [PaymentType_bit_7], [PaymentType_bit_8], [PaymentType_bit_9], [PaymentType_bit_10], [PaymentType_float_1], [PaymentType_float_2], [PaymentType_float_3], [PaymentType_float_4], [PaymentType_float_5], [PaymentType_float_6], [PaymentType_float_7], [PaymentType_float_8], [PaymentType_float_9], [PaymentType_float_10], [PaymentType_varchar_1], [PaymentType_varchar_2], [PaymentType_varchar_3], [PaymentType_varchar_4], [PaymentType_varchar_5], [PaymentType_varchar_6], [PaymentType_varchar_7], [PaymentType_varchar_8], [PaymentType_varchar_9], [PaymentType_varchar_10], [PaymentType_date_1], [PaymentType_date_2], [PaymentType_date_3], [PaymentType_date_4], [PaymentType_date_5], [PaymentType_date_6], [PaymentType_date_7], [PaymentType_date_8], [PaymentType_date_9], [PaymentType_date_10], [Deleted_Token], [Code]) VALUES (5, N'Chèque', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'CHQ')
INSERT INTO [Payment].[PaymentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [PaymentType_int_1], [PaymentType_int_2], [PaymentType_int_3], [PaymentType_int_4], [PaymentType_int_5], [PaymentType_int_6], [PaymentType_int_7], [PaymentType_int_8], [PaymentType_int_9], [PaymentType_int_10], [PaymentType_bit_1], [PaymentType_bit_2], [PaymentType_bit_3], [PaymentType_bit_4], [PaymentType_bit_5], [PaymentType_bit_6], [PaymentType_bit_7], [PaymentType_bit_8], [PaymentType_bit_9], [PaymentType_bit_10], [PaymentType_float_1], [PaymentType_float_2], [PaymentType_float_3], [PaymentType_float_4], [PaymentType_float_5], [PaymentType_float_6], [PaymentType_float_7], [PaymentType_float_8], [PaymentType_float_9], [PaymentType_float_10], [PaymentType_varchar_1], [PaymentType_varchar_2], [PaymentType_varchar_3], [PaymentType_varchar_4], [PaymentType_varchar_5], [PaymentType_varchar_6], [PaymentType_varchar_7], [PaymentType_varchar_8], [PaymentType_varchar_9], [PaymentType_varchar_10], [PaymentType_date_1], [PaymentType_date_2], [PaymentType_date_3], [PaymentType_date_4], [PaymentType_date_5], [PaymentType_date_6], [PaymentType_date_7], [PaymentType_date_8], [PaymentType_date_9], [PaymentType_date_10], [Deleted_Token], [Code]) VALUES (6, N'Virement', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'VIR')
INSERT INTO [Payment].[PaymentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [PaymentType_int_1], [PaymentType_int_2], [PaymentType_int_3], [PaymentType_int_4], [PaymentType_int_5], [PaymentType_int_6], [PaymentType_int_7], [PaymentType_int_8], [PaymentType_int_9], [PaymentType_int_10], [PaymentType_bit_1], [PaymentType_bit_2], [PaymentType_bit_3], [PaymentType_bit_4], [PaymentType_bit_5], [PaymentType_bit_6], [PaymentType_bit_7], [PaymentType_bit_8], [PaymentType_bit_9], [PaymentType_bit_10], [PaymentType_float_1], [PaymentType_float_2], [PaymentType_float_3], [PaymentType_float_4], [PaymentType_float_5], [PaymentType_float_6], [PaymentType_float_7], [PaymentType_float_8], [PaymentType_float_9], [PaymentType_float_10], [PaymentType_varchar_1], [PaymentType_varchar_2], [PaymentType_varchar_3], [PaymentType_varchar_4], [PaymentType_varchar_5], [PaymentType_varchar_6], [PaymentType_varchar_7], [PaymentType_varchar_8], [PaymentType_varchar_9], [PaymentType_varchar_10], [PaymentType_date_1], [PaymentType_date_2], [PaymentType_date_3], [PaymentType_date_4], [PaymentType_date_5], [PaymentType_date_6], [PaymentType_date_7], [PaymentType_date_8], [PaymentType_date_9], [PaymentType_date_10], [Deleted_Token], [Code]) VALUES (7, N'Carte bancaire', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'CB')
INSERT INTO [Payment].[PaymentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [PaymentType_int_1], [PaymentType_int_2], [PaymentType_int_3], [PaymentType_int_4], [PaymentType_int_5], [PaymentType_int_6], [PaymentType_int_7], [PaymentType_int_8], [PaymentType_int_9], [PaymentType_int_10], [PaymentType_bit_1], [PaymentType_bit_2], [PaymentType_bit_3], [PaymentType_bit_4], [PaymentType_bit_5], [PaymentType_bit_6], [PaymentType_bit_7], [PaymentType_bit_8], [PaymentType_bit_9], [PaymentType_bit_10], [PaymentType_float_1], [PaymentType_float_2], [PaymentType_float_3], [PaymentType_float_4], [PaymentType_float_5], [PaymentType_float_6], [PaymentType_float_7], [PaymentType_float_8], [PaymentType_float_9], [PaymentType_float_10], [PaymentType_varchar_1], [PaymentType_varchar_2], [PaymentType_varchar_3], [PaymentType_varchar_4], [PaymentType_varchar_5], [PaymentType_varchar_6], [PaymentType_varchar_7], [PaymentType_varchar_8], [PaymentType_varchar_9], [PaymentType_varchar_10], [PaymentType_date_1], [PaymentType_date_2], [PaymentType_date_3], [PaymentType_date_4], [PaymentType_date_5], [PaymentType_date_6], [PaymentType_date_7], [PaymentType_date_8], [PaymentType_date_9], [PaymentType_date_10], [Deleted_Token], [Code]) VALUES (8, N'Traite', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'TRT')
SET IDENTITY_INSERT [Payment].[PaymentType] OFF

SET IDENTITY_INSERT [Sales].[SettlementType] ON
INSERT INTO [Sales].[SettlementType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Comptant', N'Comptant', 0, NULL, NULL)
INSERT INTO [Sales].[SettlementType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Fin de mois', N'Fin de mois', 0, NULL, NULL)
INSERT INTO [Sales].[SettlementType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'Fin de mois le', N'Fin de mois le', 0, NULL, NULL)
INSERT INTO [Sales].[SettlementType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'Net', N'Net', 0, NULL, NULL)
INSERT INTO [Sales].[SettlementType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (6, N'Net le', N'Net le', 0, NULL, NULL)
SET IDENTITY_INSERT [Sales].[SettlementType] OFF
INSERT INTO [Inventory].[StockDocumentType] ([CodeType], [Type], [StockOperation], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (N'I', N'I', N'IN', N'Inventory', 0, 0, NULL)
INSERT INTO [Inventory].[StockDocumentType] ([CodeType], [Type], [StockOperation], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (N'IM', N'IM', N'I', N'Input Movement', 0, 0, NULL)
INSERT INTO [Inventory].[StockDocumentType] ([CodeType], [Type], [StockOperation], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (N'OM', N'OM', N'O', N'Output Movement', 0, 0, NULL)
INSERT INTO [Inventory].[StockDocumentType] ([CodeType], [Type], [StockOperation], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (N'TM', N'TM', N'T', N'Transfer Movement', 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[QualificationType] ON
INSERT INTO [Payroll].[QualificationType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Licence', N'Licence', 0, 0, NULL)
INSERT INTO [Payroll].[QualificationType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Maîtrise', N'Maîtrise', 0, 0, NULL)
INSERT INTO [Payroll].[QualificationType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Master', N'Master', 0, 0, NULL)
INSERT INTO [Payroll].[QualificationType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'Ingénieur', N'Ingénieur', 0, 0, NULL)
INSERT INTO [Payroll].[QualificationType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'PhD', N'PhD', 0, 0, NULL)
SET IDENTITY_INSERT [Payroll].[QualificationType] OFF

SET IDENTITY_INSERT [Shared].[TaxeType] ON
INSERT INTO [Shared].[TaxeType] ([Id], [TaxeTypeCode], [Description], [IdTaxeTypeCalculation], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'TVA', N'TVA', 0, 0, 0, NULL)
SET IDENTITY_INSERT [Shared].[TaxeType] OFF
ALTER TABLE [Sales].[PurchaseSettings]
    ADD CONSTRAINT [FK_PurchaseSetting_Company] FOREIGN KEY ([Id]) REFERENCES [Shared].[Company] ([Id])
ALTER TABLE [Administration].[EntityAxisValues]
    ADD CONSTRAINT [FK_EntityAxisValues_AxisValue] FOREIGN KEY ([IdAxisValue]) REFERENCES [Administration].[AxisValue] ([Id])
ALTER TABLE [Sales].[SaleSettings]
    ADD CONSTRAINT [FK_SaleSetting_Company] FOREIGN KEY ([Id]) REFERENCES [Shared].[Company] ([Id])
ALTER TABLE [Inventory].[TaxeItem]
    ADD CONSTRAINT [FK_TaxeItem_Taxe] FOREIGN KEY ([IdTaxe]) REFERENCES [Shared].[Taxe] ([Id])
ALTER TABLE [Inventory].[TaxeItem]
    ADD CONSTRAINT [FK_TaxeItem_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [FK_FunctionalityRole_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[ColumnMenuComponent]
    ADD CONSTRAINT [FK_ComponentColumnMenu] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Inventory].[ItemWarehouse]
    ADD CONSTRAINT [FK_ItemWarehouse_Warehouse] FOREIGN KEY ([IdWarehouse]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [Inventory].[ItemWarehouse]
    ADD CONSTRAINT [FK_ItemWarehouse_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[CheckBoxComponentDetails]
    ADD CONSTRAINT [FK_CheckBoxDetailsComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[MsgNotification]
    ADD CONSTRAINT [FK_MsgNotification_Message] FOREIGN KEY ([IdMsg]) REFERENCES [ERPSettings].[Message] ([Id])
ALTER TABLE [ERPSettings].[Message]
    ADD CONSTRAINT [FK_Information_Message] FOREIGN KEY ([IdInformation]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [Payment].[WithholdingTax]
    ADD CONSTRAINT [FK_WithholdingTax_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [ERPSettings].[CheckBoxComponent]
    ADD CONSTRAINT [FK_CheckBoxComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxDataSourceItems]
    ADD CONSTRAINT [FK_ComboBoxDataSourceItems_ComboBoxDataSource] FOREIGN KEY ([IdComboBoxDataSource]) REFERENCES [ERPSettings].[ComboBoxDataSource] ([IdComponent])
ALTER TABLE [ERPSettings].[InputDatePickerOptions]
    ADD CONSTRAINT [FK_InputDatePickerOptions_InputComponent] FOREIGN KEY ([IdDatePickerOptions]) REFERENCES [ERPSettings].[InputComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxDataSource]
    ADD CONSTRAINT [FK_ComboBoxDataSource_ComboBoxOptions] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[ComboBoxOptions] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxDataSource]
    ADD CONSTRAINT [FK_ComboBoxDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [FK_ModuleByRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[ButtonComponent]
    ADD CONSTRAINT [FK_ButtonComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ButtonComponent]
    ADD CONSTRAINT [FK_ButtonComponent_ServiceParameters] FOREIGN KEY ([IdServiceParameter]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ToolBarItem]
    ADD CONSTRAINT [FK_ToolBarItemToolBarOptions] FOREIGN KEY ([IdToolBarOptions]) REFERENCES [ERPSettings].[ToolBarOptions] ([IdToolBarOptions])
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[BarCodeComponent]
    ADD CONSTRAINT [FK_BarCodeComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[BarCodeComponent]
    ADD CONSTRAINT [FK_BarCodeComponent_InputComponent] FOREIGN KEY ([IdInputComponent]) REFERENCES [ERPSettings].[InputComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[OrderBy]
    ADD CONSTRAINT [FK_OrderBy_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[DropDownListOptions]
    ADD CONSTRAINT [FK_DropDownListOptions_DropDownListComponent] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListComponent] ([IdComponent])
ALTER TABLE [Payment].[WithholdingTaxLine]
    ADD CONSTRAINT [FK_WithholdingTaxLine_WithholdingTax] FOREIGN KEY ([IdWithholdingTax]) REFERENCES [Payment].[WithholdingTax] ([Id])

ALTER TABLE [Sales].[DocumentLineTaxe]
    ADD CONSTRAINT [FK_DocumentLineTaxe_Taxe] FOREIGN KEY ([IdTaxe]) REFERENCES [Shared].[Taxe] ([Id])
ALTER TABLE [Sales].[DocumentLineTaxe]
    ADD CONSTRAINT [FK_DocumentLineTaxe_DocumentLine] FOREIGN KEY ([IdDocumentLine]) REFERENCES [Sales].[DocumentLine] ([Id]) ON DELETE CASCADE
ALTER TABLE [Shared].[Taxe]
    ADD CONSTRAINT [FK_Taxe_TaxeType] FOREIGN KEY ([IdTaxeType]) REFERENCES [Shared].[TaxeType] ([Id])
ALTER TABLE [ERPSettings].[Relation]
    ADD CONSTRAINT [FK_Relation_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[ReportParameters]
    ADD CONSTRAINT [FK_ReportViewerParameters_ReportViewerComponent] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[ReportComponent] ([IdComponent])
ALTER TABLE [Payment].[SettlementCommitment]
    ADD CONSTRAINT [FK_SettlementCommitment_Settlement] FOREIGN KEY ([SettlementId]) REFERENCES [Payment].[Settlement] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payment].[SettlementCommitment]
    ADD CONSTRAINT [FK_SettlementCommitment_FinancialCommitment] FOREIGN KEY ([CommitmentId]) REFERENCES [Sales].[FinancialCommitment] ([Id])
ALTER TABLE [Stock].[TypeStockCalculation]
    ADD CONSTRAINT [FK_TYPESTOC_ASSOCIATI_STOCKCAL] FOREIGN KEY ([IdStockCalculation]) REFERENCES [Stock].[StockCalculation] ([Id])
ALTER TABLE [Sales].[DetailsSettlementMode]
    ADD CONSTRAINT [FK_DetailsSettlementMode_SettlementType] FOREIGN KEY ([IdSettlementType]) REFERENCES [Sales].[SettlementType] ([Id]) ON DELETE SET NULL
ALTER TABLE [Sales].[DetailsSettlementMode]
    ADD CONSTRAINT [FK_DetailsSettlementMode_PaymentMethod] FOREIGN KEY ([IdPaymentMethod]) REFERENCES [Payment].[PaymentMethod] ([Id]) ON DELETE SET NULL
ALTER TABLE [Sales].[DetailsSettlementMode]
    ADD CONSTRAINT [FK_DetailsSettlementMode_SettlementMode] FOREIGN KEY ([IdSettlementMode]) REFERENCES [Sales].[SettlementMode] ([Id]) ON DELETE SET NULL
ALTER TABLE [ERPSettings].[DialogComponent]
    ADD CONSTRAINT [FK_DialogComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Shared].[ZipCode]
    ADD CONSTRAINT [FK_ZipCode_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id])
ALTER TABLE [ERPSettings].[FieldSetComponent]
    ADD CONSTRAINT [FK_FieldSetComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[RoleInfo]
    ADD CONSTRAINT [FK_Information_RoleInfo] FOREIGN KEY ([IdInformation]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[RoleInfo]
    ADD CONSTRAINT [FK_Role_RoleInfo] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id])
ALTER TABLE [Administration].[CurrencyRate]
    ADD CONSTRAINT [FK_CurrencyRate_Currency] FOREIGN KEY ([IdCurrency]) REFERENCES [Administration].[Currency] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [Stock].[Article]
    ADD CONSTRAINT [FK_Article_StockManagementMethod] FOREIGN KEY ([IdStockManagementMethod]) REFERENCES [Stock].[StockManagementMethod] ([Id])
ALTER TABLE [Stock].[Article]
    ADD CONSTRAINT [FK_Article_SaleManagementMethod] FOREIGN KEY ([IdSaleManagementMethod]) REFERENCES [Stock].[SaleManagementMethod] ([IdSaleManagementMethod])
ALTER TABLE [Stock].[Article]
    ADD CONSTRAINT [FK_Article_AccountingAccount] FOREIGN KEY ([IdAccountingAccount]) REFERENCES [accounting].[AccountingAccount] ([Id])
ALTER TABLE [ERPSettings].[UserRole]
    ADD CONSTRAINT [FK_UserRole_Role] FOREIGN KEY ([IdRole]) REFERENCES [ERPSettings].[Role] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[UserRole]
    ADD CONSTRAINT [FK_UserRole_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[ComboBoxOptions]
    ADD CONSTRAINT [FK_ComboBoxOptions_ComboBoxComponent] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[ComboBoxComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[ComboBoxComponent]
    ADD CONSTRAINT [FK_ComboboxComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [Payroll].[IdentityPieces]
    ADD CONSTRAINT [FK_IdentityPieces_TypeIdentityPieces] FOREIGN KEY ([IdTypeIdentityPieces]) REFERENCES [Payroll].[TypeIdentityPieces] ([Id])
ALTER TABLE [Payroll].[IdentityPieces]
    ADD CONSTRAINT [FK_IdentityPieces_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_BankAccount] FOREIGN KEY ([IdBankAccount]) REFERENCES [Shared].[BankAccount] ([Id])
ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_DocumentStatus] FOREIGN KEY ([IdStatus]) REFERENCES [Sales].[DocumentStatus] ([Id])
ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_Currency] FOREIGN KEY ([IdUsedCurrency]) REFERENCES [Administration].[Currency] ([Id])
ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_PaymentMethod] FOREIGN KEY ([IdPaymentMethod]) REFERENCES [Payment].[PaymentMethod] ([Id])
ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Stock].[Storage]
    ADD CONSTRAINT [FK_STORAGE_ASSOCIATI_SECTION] FOREIGN KEY ([IdSection]) REFERENCES [Stock].[Section] ([IdSection])
ALTER TABLE [Stock].[Storage]
    ADD CONSTRAINT [FK_STORAGE_ASSOCIATI_ARTICLE] FOREIGN KEY ([IdArticle]) REFERENCES [Stock].[Article] ([Id])
ALTER TABLE [ERPSettings].[ComponentByUser]
    ADD CONSTRAINT [FK_ComponentByUser_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[ComponentByUser]
    ADD CONSTRAINT [FK_ComponentByUser_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent]) ON DELETE CASCADE
ALTER TABLE [Shared].[ContactTypeDocument]
    ADD CONSTRAINT [FK_ContactTypeDocument_Contact] FOREIGN KEY ([IdContact]) REFERENCES [Shared].[Contact] ([Id]) ON DELETE CASCADE
ALTER TABLE [Sales].[TaxeGroupTiersConfig]
    ADD CONSTRAINT [FK_TaxeTiersConfig_TaxeGroupTiers] FOREIGN KEY ([IdTaxeGroupTiers]) REFERENCES [Sales].[TaxeGroupTiers] ([Id]) ON DELETE CASCADE
ALTER TABLE [Sales].[TaxeGroupTiersConfig]
    ADD CONSTRAINT [FK_TaxeTiersConfig_Taxe] FOREIGN KEY ([IdTaxe]) REFERENCES [Shared].[Taxe] ([Id])
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
ALTER TABLE [Treasury].[Timetable]
    ADD CONSTRAINT [FK_Timetable_PaymentType] FOREIGN KEY ([IdPaymentType]) REFERENCES [Payment].[PaymentType] ([Id])
ALTER TABLE [Treasury].[Timetable]
    ADD CONSTRAINT [FK_Timetable_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])

ALTER TABLE [ERPSettings].[ImageComponent]
    ADD CONSTRAINT [FK_ImageComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Payroll].[CommercialsCustomerContract]
    ADD CONSTRAINT [FK_CommercialsCustomerContract_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Payroll].[CommercialsCustomerContract]
    ADD CONSTRAINT [FK_CommercialsCustomerContract_Prices] FOREIGN KEY ([IdPrices]) REFERENCES [Sales].[Prices] ([Id]) ON DELETE CASCADE
ALTER TABLE [Stock].[StockDocumentLineSerialNumber]
    ADD CONSTRAINT [FK_StockDocumentSerialNumber_SerialNumber] FOREIGN KEY ([IdSerialNumber]) REFERENCES [Stock].[SerialNumber] ([IdSerialNumber])
ALTER TABLE [Stock].[SerialNumber]
    ADD CONSTRAINT [FK_SerialNumber_Article1] FOREIGN KEY ([IdArticle]) REFERENCES [Stock].[Article] ([Id])
ALTER TABLE [Stock].[SerialNumber]
    ADD CONSTRAINT [FK_SerialNumber_Batch] FOREIGN KEY ([IdBatch]) REFERENCES [Stock].[Batch] ([IdBatch])
ALTER TABLE [ERPSettings].[GridComponent]
    ADD CONSTRAINT [FK_GridComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[FunctionnalityByUser]
    ADD CONSTRAINT [FK_FunctionnalityByUser_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityByUser]
    ADD CONSTRAINT [FK_FunctionnalityByUser_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payroll].[ConsultantsCustomerContract]
    ADD CONSTRAINT [FK_ConsultantsCustomerContract_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Payroll].[ConsultantsCustomerContract]
    ADD CONSTRAINT [FK_ConsultantsCustomerContract_Prices] FOREIGN KEY ([IdPrices]) REFERENCES [Sales].[Prices] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[LabelComponent]
    ADD CONSTRAINT [FK_LabelComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Administration].[AxisRelationShip]
    ADD CONSTRAINT [FK_AxisRelationShip_Axis1] FOREIGN KEY ([IdAxisParent]) REFERENCES [Administration].[Axis] ([Id])
ALTER TABLE [Administration].[AxisRelationShip]
    ADD CONSTRAINT [FK_AxisRelationShip_Axis] FOREIGN KEY ([IdAxis]) REFERENCES [Administration].[Axis] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[InputComponent]
    ADD CONSTRAINT [FK_InputComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Treasury].[DetailTimetable]
    ADD CONSTRAINT [FK_DetailTimetable_Timetable] FOREIGN KEY ([IdTimetable]) REFERENCES [Treasury].[Timetable] ([Id])
ALTER TABLE [Treasury].[DetailTimetable]
    ADD CONSTRAINT [FK_DetailTimetable_PaymentType] FOREIGN KEY ([IdPaymentType]) REFERENCES [Payment].[PaymentType] ([Id])
ALTER TABLE [Administration].[AxisValueRelationShip]
    ADD CONSTRAINT [FK_AxisValueRelationShip_AxisValue] FOREIGN KEY ([IdAxisValueParent]) REFERENCES [Administration].[AxisValue] ([Id])
ALTER TABLE [Administration].[AxisValueRelationShip]
    ADD CONSTRAINT [FK__AxisRelat__IdAxi__6A3191A0] FOREIGN KEY ([IdAxisValue]) REFERENCES [Administration].[AxisValue] ([Id]) ON DELETE CASCADE
ALTER TABLE [Administration].[AxisValue]
    ADD CONSTRAINT [FK__AxisValue__IdAxi__675524F5] FOREIGN KEY ([IdAxis]) REFERENCES [Administration].[Axis] ([Id]) ON DELETE CASCADE
ALTER TABLE [Shared].[Contact]
    ADD CONSTRAINT [FK_Contact_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[FormComponent]
    ADD CONSTRAINT [FK_FormComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[FormComponent]
    ADD CONSTRAINT [FK_FormComponent_ServiceParameters] FOREIGN KEY ([IdServiceParameter]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [Treasury].[ReceiptSpent]
    ADD CONSTRAINT [FK_ReceiptSpent_PaymentMethod] FOREIGN KEY ([IdPaymentMethod]) REFERENCES [Payment].[PaymentMethod] ([Id])
ALTER TABLE [Treasury].[ReceiptSpent]
    ADD CONSTRAINT [FK_RecipeSpent_PaymentDirection] FOREIGN KEY ([IdPaymentDirection]) REFERENCES [Treasury].[PaymentDirection] ([Id])
ALTER TABLE [Treasury].[ReceiptSpent]
    ADD CONSTRAINT [FK_RecipeSpent_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Administration].[AxisEntity]
    ADD CONSTRAINT [FK_AxisEntity_Entity] FOREIGN KEY ([IdTableEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [Administration].[AxisEntity]
    ADD CONSTRAINT [FK__AxisEntit__IdAxi__72C6D7A1] FOREIGN KEY ([IdAxis]) REFERENCES [Administration].[Axis] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[Filter]
    ADD CONSTRAINT [FK_Filter_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [Shared].[Company]
    ADD CONSTRAINT [FK_Company_ZipCode] FOREIGN KEY ([IdZipCode]) REFERENCES [Shared].[ZipCode] ([Id])
ALTER TABLE [Shared].[Company]
    ADD CONSTRAINT [FK_Company_Currency] FOREIGN KEY ([IdCurrency]) REFERENCES [Administration].[Currency] ([Id])
ALTER TABLE [Sales].[DocumentLinePrices]
    ADD CONSTRAINT [FK_DocumentLinePrices_Prices] FOREIGN KEY ([IdPrices]) REFERENCES [Sales].[Prices] ([Id])
ALTER TABLE [Sales].[DocumentLinePrices]
    ADD CONSTRAINT [FK_DocumentLinePrices_DocumentLine] FOREIGN KEY ([IdDocumentLine]) REFERENCES [Sales].[DocumentLine] ([Id]) ON DELETE CASCADE
ALTER TABLE [Sales].[DocumentLine]
    ADD CONSTRAINT [FK_DocumentLine_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id])
ALTER TABLE [Sales].[DocumentLine]
    ADD CONSTRAINT [FK_DocumentLine_Warehouse] FOREIGN KEY ([IdWarehouse]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [Sales].[DocumentLine]
    ADD CONSTRAINT [FK_DocumentLine_DocumentLine] FOREIGN KEY ([IdDocumentLineAssociated]) REFERENCES [Sales].[DocumentLine] ([Id])
ALTER TABLE [Sales].[DocumentLine]
    ADD CONSTRAINT [FK_DocumentLine_Prices] FOREIGN KEY ([IdPrices]) REFERENCES [Sales].[Prices] ([Id])
ALTER TABLE [Sales].[DocumentLine]
    ADD CONSTRAINT [FK_DocumentLine_Document] FOREIGN KEY ([IdDocument]) REFERENCES [Sales].[Document] ([Id]) ON DELETE CASCADE
ALTER TABLE [Sales].[DocumentLine]
    ADD CONSTRAINT [FK_DocumentLine_MeasureUnit] FOREIGN KEY ([IdMeasureUnit]) REFERENCES [Stock].[MeasureUnit] ([Id])
ALTER TABLE [Stock].[StockCalculation]
    ADD CONSTRAINT [FK_STOCKCAL_ASSOCIATI_DOCUMENT] FOREIGN KEY ([IdDocument]) REFERENCES [Sales].[Document] ([Id])
ALTER TABLE [Sales].[DocumentTypeRelation]
    ADD CONSTRAINT [FK_DocumentTypeRelation_DocumentTypeRelation] FOREIGN KEY ([CodeDocumentType]) REFERENCES [Sales].[DocumentType] ([CodeType])
ALTER TABLE [Sales].[DocumentTypeRelation]
    ADD CONSTRAINT [FK_DocumentTypeRelation_DocumentType] FOREIGN KEY ([CodeDocumentTypeAssociated]) REFERENCES [Sales].[DocumentType] ([CodeType])
ALTER TABLE [Sales].[DocumentType]
    ADD CONSTRAINT [FK_DocumentType_DocumentType] FOREIGN KEY ([DefaultCodeDocumentTypeAssociated]) REFERENCES [Sales].[DocumentType] ([CodeType])
ALTER TABLE [ERPSettings].[QrCodeComponent]
    ADD CONSTRAINT [FK_QrCodeComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[QrCodeComponent]
    ADD CONSTRAINT [FK_QrCodeComponent_InputComponent] FOREIGN KEY ([IdInputComponent]) REFERENCES [ERPSettings].[InputComponent] ([IdComponent])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id])
ALTER TABLE [Payroll].[Employee]
    ADD CONSTRAINT [FK_Employee_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id])
ALTER TABLE [Shared].[City]
    ADD CONSTRAINT [FK_City_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[ToolBarOptions]
    ADD CONSTRAINT [FK_ToolBarOptionsToolbarComponent] FOREIGN KEY ([IdToolBarOptions]) REFERENCES [ERPSettings].[ToolBarComponent] ([IdComponent])
ALTER TABLE [ERPSettings].[ToolBarComponent]
    ADD CONSTRAINT [FK_ComponentToolbarComponent] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[ModuleByUser]
    ADD CONSTRAINT [FK_ModuleByUser_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleByUser]
    ADD CONSTRAINT [FK_ModuleByUser_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE
ALTER TABLE [Sales].[Document]
    ADD CONSTRAINT [FK_Document_DocumentStatus] FOREIGN KEY ([IdDocumentStatus]) REFERENCES [Sales].[DocumentStatus] ([Id])
ALTER TABLE [Sales].[Document]
    ADD CONSTRAINT [FK_Document_PaymentMethod] FOREIGN KEY ([IdPaymentMethod]) REFERENCES [Payment].[PaymentMethod] ([Id])
ALTER TABLE [Sales].[Document]
    ADD CONSTRAINT [FK_Document_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Sales].[Document]
    ADD CONSTRAINT [FK_Document_SettlementMode] FOREIGN KEY ([IdSettlementMode]) REFERENCES [Sales].[SettlementMode] ([Id])
ALTER TABLE [Sales].[Document]
    ADD CONSTRAINT [FK_Document_Currency] FOREIGN KEY ([IdUsedCurrency]) REFERENCES [Administration].[Currency] ([Id])
ALTER TABLE [Sales].[Document]
    ADD CONSTRAINT [FK_Document_BankAccount] FOREIGN KEY ([IdBankAccount]) REFERENCES [Shared].[BankAccount] ([Id])
ALTER TABLE [Sales].[Document]
    ADD CONSTRAINT [FK_Document_Employee] FOREIGN KEY ([IdDecisionMaker]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [Inventory].[StockDocumentLine]
    ADD CONSTRAINT [FK_StockDocumentLine_StockDocument] FOREIGN KEY ([IdStockDocument]) REFERENCES [Inventory].[StockDocument] ([Id]) ON DELETE CASCADE
ALTER TABLE [Inventory].[StockDocumentLine]
    ADD CONSTRAINT [FK_StockDocumentLine_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id])
ALTER TABLE [Inventory].[StockDocument]
    ADD CONSTRAINT [FK_StockDocument_Warehouse] FOREIGN KEY ([IdWarehouseDestination]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [Inventory].[StockDocument]
    ADD CONSTRAINT [FK_StockDocument_Warehouse1] FOREIGN KEY ([IdWarehouseSource]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [Inventory].[StockDocument]
    ADD CONSTRAINT [FK_StockDocument_TypeStockDocument] FOREIGN KEY ([TypeStockDocument]) REFERENCES [Inventory].[StockDocumentType] ([CodeType])
ALTER TABLE [Inventory].[StockDocument]
    ADD CONSTRAINT [FK_StockDocument_DocumentStatus] FOREIGN KEY ([IdDocumentStatus]) REFERENCES [Sales].[DocumentStatus] ([Id])
ALTER TABLE [ERPSettings].[Traceability]
    ADD CONSTRAINT [FK_Traceability_User] FOREIGN KEY ([TransactionUserId]) REFERENCES [ERPSettings].[User] ([Id])
ALTER TABLE [ERPSettings].[RadioButtonComponentDetails]
    ADD CONSTRAINT [FK_RadioButtonComponentDetails_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[RadioButtonComponent]
    ADD CONSTRAINT [FK_RadioButtonComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [Stock].[StockMovement]
    ADD CONSTRAINT [FK_StockMovement_StockDocumentLine] FOREIGN KEY ([IdStockDocumentLine]) REFERENCES [Inventory].[StockDocumentLine] ([Id]) ON DELETE CASCADE
ALTER TABLE [Stock].[StockMovement]
    ADD CONSTRAINT [FK_StockMovement_Warehouse] FOREIGN KEY ([IdWarehouse]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [Stock].[StockMovement]
    ADD CONSTRAINT [FK_StockMovement_DocumentLine] FOREIGN KEY ([IdDocumentLine]) REFERENCES [Sales].[DocumentLine] ([Id]) ON DELETE CASCADE -- Mohamed BOUZIDI [FK_StockMovement_DocumentLine] CASCADE
ALTER TABLE [Stock].[StockMovement]
    ADD CONSTRAINT [FK_StockMovement_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id]) ON DELETE SET NULL
ALTER TABLE [Inventory].[Warehouse]
    ADD CONSTRAINT [FK_Warehouse_Warehouse] FOREIGN KEY ([IdWarehouseParent]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [Inventory].[Item]
    ADD CONSTRAINT [FK_Item_DiscountGroupItem] FOREIGN KEY ([IdDiscountGroupItem]) REFERENCES [Inventory].[DiscountGroupItem] ([Id])
ALTER TABLE [Inventory].[Item]
    ADD CONSTRAINT [FK_Item_UnitType] FOREIGN KEY ([IdUnitSales]) REFERENCES [Stock].[MeasureUnit] ([Id])
ALTER TABLE [Inventory].[Item]
    ADD CONSTRAINT [FK_Item_UnitType1] FOREIGN KEY ([IdUnitStock]) REFERENCES [Stock].[MeasureUnit] ([Id])
ALTER TABLE [Inventory].[Item]
    ADD CONSTRAINT [FK_Item_Nature] FOREIGN KEY ([IdNature]) REFERENCES [Inventory].[Nature] ([Id])
ALTER TABLE [ERPSettings].[GridDataSource]
    ADD CONSTRAINT [FK_GridDataSource_GridOptions] FOREIGN KEY ([IdGridOptions]) REFERENCES [ERPSettings].[GridOptions] ([IdGridOptions])
ALTER TABLE [ERPSettings].[GridDataSource]
    ADD CONSTRAINT [FK_GridDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[GridOptions]
    ADD CONSTRAINT [FK_GridOptions_GridComponent] FOREIGN KEY ([IdGridOptions]) REFERENCES [ERPSettings].[GridComponent] ([IdComponent])
ALTER TABLE [Sales].[FinancialCommitment]
    ADD CONSTRAINT [FK_FinancialCommitment_DocumentStatus] FOREIGN KEY ([IdStatus]) REFERENCES [Sales].[DocumentStatus] ([Id])
ALTER TABLE [Sales].[FinancialCommitment]
    ADD CONSTRAINT [FK_FinancialCommitment_PaymentMethod] FOREIGN KEY ([IdPaymentMethod]) REFERENCES [Payment].[PaymentMethod] ([Id])
ALTER TABLE [Sales].[FinancialCommitment]
    ADD CONSTRAINT [FK_FinancialCommitment_Document] FOREIGN KEY ([IdDocument]) REFERENCES [Sales].[Document] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payment].[PaymentMethod]
    ADD CONSTRAINT [FK_PayementMethod_PayementType] FOREIGN KEY ([IdPaymentType]) REFERENCES [Payment].[PaymentType] ([Id])
ALTER TABLE [ERPSettings].[ReportComponent]
    ADD CONSTRAINT [FK_ReportViewerComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[DropDownListDataSource]
    ADD CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions] FOREIGN KEY ([IdDropDownListOptions]) REFERENCES [ERPSettings].[DropDownListOptions] ([IdDropDownListOptions])
ALTER TABLE [ERPSettings].[DropDownListDataSource]
    ADD CONSTRAINT [FK_DropDownListDataSource_ServiceParameters] FOREIGN KEY ([IdServiceParameters]) REFERENCES [ERPSettings].[ServiceParameters] ([IdServiceParameters])
ALTER TABLE [ERPSettings].[ServiceParameters]
    ADD CONSTRAINT [FK_ServiceParameters_PredicateFormat] FOREIGN KEY ([IdPredicateFormat]) REFERENCES [ERPSettings].[PredicateFormat] ([IdPredicateFormat])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_Tiers_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_Tiers_Currency] FOREIGN KEY ([IdCurrency]) REFERENCES [Administration].[Currency] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_TIERS_ASSOCIATI_PAYEMENT] FOREIGN KEY ([IdPaymentCondition]) REFERENCES [Payment].[PaymentCondition] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_TIERS_ASSOCIATI_TYPETIER] FOREIGN KEY ([IdTypeTiers]) REFERENCES [Sales].[TypeTiers] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_Tiers_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_Tiers_AccountingAccount] FOREIGN KEY ([IdAccountingAccount]) REFERENCES [accounting].[AccountingAccount] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_Tiers_TaxeGroupTiers] FOREIGN KEY ([IdTaxeGroupTiers]) REFERENCES [Sales].[TaxeGroupTiers] ([Id])
ALTER TABLE [Sales].[Tiers]
    ADD CONSTRAINT [FK_Tiers_DiscountGroupTiers] FOREIGN KEY ([IdDiscountGroupTiers]) REFERENCES [Sales].[DiscountGroupTiers] ([Id])
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
ALTER TABLE [ERPSettings].[UserInfo]
    ADD CONSTRAINT [FK_Info_UserInfo] FOREIGN KEY ([IdInformation]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[UserInfo]
    ADD CONSTRAINT [FK_User_UserInfo] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])


ALTER TABLE [ERPSettings].[DropDownListComponent]
    ADD CONSTRAINT [FK_DropDownListComponent_Component] FOREIGN KEY ([IdComponent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component1] FOREIGN KEY ([IdComponentChangedBy]) REFERENCES [ERPSettings].[Component] ([IdComponent])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Component]
    ADD CONSTRAINT [FK_Component_Component] FOREIGN KEY ([IdComponentParent]) REFERENCES [ERPSettings].[Component] ([IdComponent])
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [Sales].[DocumentType] SET [IsFinancialCommitmentAffected]=1 WHERE [CodeType]=N'I-PU'
UPDATE [Sales].[DocumentType] SET [IsFinancialCommitmentAffected]=1 WHERE [CodeType]=N'I-SA'
COMMIT TRANSACTION


---- Nihel Financial Commitment Direction
BEGIN TRANSACTION
ALTER TABLE [Sales].[DocumentType] DROP CONSTRAINT [FK_DocumentType_DocumentType]
UPDATE [Sales].[DocumentType] SET [IsFinancialCommitmentAffected]=1, [FinancialCommitmentDirection]=1 WHERE [CodeType]=N'A-PU'
UPDATE [Sales].[DocumentType] SET [IsFinancialCommitmentAffected]=1, [FinancialCommitmentDirection]=2 WHERE [CodeType]=N'A-SA'
UPDATE [Sales].[DocumentType] SET [FinancialCommitmentDirection]=2 WHERE [CodeType]=N'I-PU'
UPDATE [Sales].[DocumentType] SET [FinancialCommitmentDirection]=1 WHERE [CodeType]=N'I-SA'
ALTER TABLE [Sales].[DocumentType]
    ADD CONSTRAINT [FK_DocumentType_DocumentType] FOREIGN KEY ([DefaultCodeDocumentTypeAssociated]) REFERENCES [Sales].[DocumentType] ([CodeType])
	
---- Update Financial Commitment
UPDATE [Sales].[FinancialCommitment]
   SET [Direction] = (Select FinancialCommitmentDirection From Sales.DocumentType
						Where Sales.DocumentType.CodeType = (Select DocumentTypeCode From Sales.Document Where Id = [Sales].[FinancialCommitment].IdDocument))

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

---- Marwa : Add DocumentTypeRelation ---

BEGIN TRANSACTION
SET IDENTITY_INSERT [Sales].[DocumentTypeRelation] ON
INSERT INTO [Sales].[DocumentTypeRelation] ([id], [CodeDocumentType], [CodeDocumentTypeAssociated]) VALUES (9, N'A-SA', N'I-SA')
SET IDENTITY_INSERT [Sales].[DocumentTypeRelation] OFF

COMMIT TRANSACTION

BEGIN TRANSACTION
---- devis achat
UPDATE [Sales].[DocumentTypeRelation] SET [CodeDocumentTypeAssociated]=N'B-PU' WHERE [id]=6
UPDATE [Sales].[DocumentType] SET [DefaultCodeDocumentTypeAssociated]=N'B-PU' WHERE [CodeType]=N'O-PU'
COMMIT TRANSACTION

BEGIN TRANSACTION
INSERT INTO Shared.Country (Code, Alpha2, Alpha3, NameEn, NameFr) VALUES
( 4, 'AF', 'AFG', 'Afghanistan', 'Afghanistan'),
( 8, 'AL', 'ALB', 'Albania', 'Albanie'),
( 10, 'AQ', 'ATA', 'Antarctica', 'Antarctique'),
( 12, 'DZ', 'DZA', 'Algeria', 'Algérie'),
( 16, 'AS', 'ASM', 'American Samoa', 'Samoa Américaines'),
( 20, 'AD', 'AND', 'Andorra', 'Andorre'),
( 24, 'AO', 'AGO', 'Angola', 'Angola'),
( 28, 'AG', 'ATG', 'Antigua and Barbuda', 'Antigua-et-Barbuda'),
( 31, 'AZ', 'AZE', 'Azerbaijan', 'Azerbaïdjan'),
( 32, 'AR', 'ARG', 'Argentina', 'Argentine'),
( 36, 'AU', 'AUS', 'Australia', 'Australie'),
( 40, 'AT', 'AUT', 'Austria', 'Autriche'),
( 44, 'BS', 'BHS', 'Bahamas', 'Bahamas'),
( 48, 'BH', 'BHR', 'Bahrain', 'Bahreïn'),
( 50, 'BD', 'BGD', 'Bangladesh', 'Bangladesh'),
( 51, 'AM', 'ARM', 'Armenia', 'Arménie'),
( 52, 'BB', 'BRB', 'Barbados', 'Barbade'),
( 56, 'BE', 'BEL', 'Belgium', 'Belgique'),
( 60, 'BM', 'BMU', 'Bermuda', 'Bermudes'),
( 64, 'BT', 'BTN', 'Bhutan', 'Bhoutan'),
( 68, 'BO', 'BOL', 'Bolivia', 'Bolivie'),
( 70, 'BA', 'BIH', 'Bosnia and Herzegovina', 'Bosnie-Herzégovine'),
( 72, 'BW', 'BWA', 'Botswana', 'Botswana'),
( 74, 'BV', 'BVT', 'Bouvet Island', 'Île Bouvet'),
( 76, 'BR', 'BRA', 'Brazil', 'Brésil'),
( 84, 'BZ', 'BLZ', 'Belize', 'Belize'),
( 86, 'IO', 'IOT', 'British Indian Ocean Territory', 'Territoire Britannique de l''Océan Indien'),
( 90, 'SB', 'SLB', 'Solomon Islands', 'Îles Salomon'),
( 92, 'VG', 'VGB', 'British Virgin Islands', 'Îles Vierges Britanniques'),
( 96, 'BN', 'BRN', 'Brunei Darussalam', 'Brunéi Darussalam'),
( 100, 'BG', 'BGR', 'Bulgaria', 'Bulgarie'),
( 104, 'MM', 'MMR', 'Myanmar', 'Myanmar'),
( 108, 'BI', 'BDI', 'Burundi', 'Burundi'),
( 112, 'BY', 'BLR', 'Belarus', 'Bélarus'),
( 116, 'KH', 'KHM', 'Cambodia', 'Cambodge'),
( 120, 'CM', 'CMR', 'Cameroon', 'Cameroun'),
( 124, 'CA', 'CAN', 'Canada', 'Canada'),
( 132, 'CV', 'CPV', 'Cape Verde', 'Cap-vert'),
( 136, 'KY', 'CYM', 'Cayman Islands', 'Îles Caïmanes'),
( 140, 'CF', 'CAF', 'Central African', 'République Centrafricaine'),
( 144, 'LK', 'LKA', 'Sri Lanka', 'Sri Lanka'),
( 148, 'TD', 'TCD', 'Chad', 'Tchad'),
( 152, 'CL', 'CHL', 'Chile', 'Chili'),
( 156, 'CN', 'CHN', 'China', 'Chine'),
( 158, 'TW', 'TWN', 'Taiwan', 'Taïwan'),
( 162, 'CX', 'CXR', 'Christmas Island', 'Île Christmas'),
( 166, 'CC', 'CCK', 'Cocos (Keeling) Islands', 'Îles Cocos (Keeling)'),
( 170, 'CO', 'COL', 'Colombia', 'Colombie'),
( 174, 'KM', 'COM', 'Comoros', 'Comores'),
( 175, 'YT', 'MYT', 'Mayotte', 'Mayotte'),
( 178, 'CG', 'COG', 'Republic of the Congo', 'République du Congo'),
( 180, 'CD', 'COD', 'The Democratic Republic Of The Congo', 'République Démocratique du Congo'),
( 184, 'CK', 'COK', 'Cook Islands', 'Îles Cook'),
( 188, 'CR', 'CRI', 'Costa Rica', 'Costa Rica'),
( 191, 'HR', 'HRV', 'Croatia', 'Croatie'),
( 192, 'CU', 'CUB', 'Cuba', 'Cuba'),
( 196, 'CY', 'CYP', 'Cyprus', 'Chypre'),
( 203, 'CZ', 'CZE', 'Czech Republic', 'République Tchèque'),
( 204, 'BJ', 'BEN', 'Benin', 'Bénin'),
( 208, 'DK', 'DNK', 'Denmark', 'Danemark'),
( 212, 'DM', 'DMA', 'Dominica', 'Dominique'),
( 214, 'DO', 'DOM', 'Dominican Republic', 'République Dominicaine'),
( 218, 'EC', 'ECU', 'Ecuador', 'Équateur'),
( 222, 'SV', 'SLV', 'El Salvador', 'El Salvador'),
( 226, 'GQ', 'GNQ', 'Equatorial Guinea', 'Guinée Équatoriale'),
( 231, 'ET', 'ETH', 'Ethiopia', 'Éthiopie'),
( 232, 'ER', 'ERI', 'Eritrea', 'Érythrée'),
( 233, 'EE', 'EST', 'Estonia', 'Estonie'),
( 234, 'FO', 'FRO', 'Faroe Islands', 'Îles Féroé'),
( 238, 'FK', 'FLK', 'Falkland Islands', 'Îles (malvinas) Falkland'),
( 239, 'GS', 'SGS', 'South Georgia and the South Sandwich Islands', 'Géorgie du Sud et les Îles Sandwich du Sud'),
( 242, 'FJ', 'FJI', 'Fiji', 'Fidji'),
( 246, 'FI', 'FIN', 'Finland', 'Finlande'),
( 248, 'AX', 'ALA', 'Åland Islands', 'Îles Åland'),
( 250, 'FR', 'FRA', 'France', 'France'),
( 254, 'GF', 'GUF', 'French Guiana', 'Guyane Française'),
( 258, 'PF', 'PYF', 'French Polynesia', 'Polynésie Française'),
( 260, 'TF', 'ATF', 'French Southern Territories', 'Terres Australes Françaises'),
( 262, 'DJ', 'DJI', 'Djibouti', 'Djibouti'),
( 266, 'GA', 'GAB', 'Gabon', 'Gabon'),
( 268, 'GE', 'GEO', 'Georgia', 'Géorgie'),
( 270, 'GM', 'GMB', 'Gambia', 'Gambie'),
( 275, 'PS', 'PSE', 'Occupied Palestinian Territory', 'Territoire Palestinien Occupé'),
( 276, 'DE', 'DEU', 'Germany', 'Allemagne'),
( 288, 'GH', 'GHA', 'Ghana', 'Ghana'),
( 292, 'GI', 'GIB', 'Gibraltar', 'Gibraltar'),
( 296, 'KI', 'KIR', 'Kiribati', 'Kiribati'),
( 300, 'GR', 'GRC', 'Greece', 'Grèce'),
( 304, 'GL', 'GRL', 'Greenland', 'Groenland'),
( 308, 'GD', 'GRD', 'Grenada', 'Grenade'),
( 312, 'GP', 'GLP', 'Guadeloupe', 'Guadeloupe'),
( 316, 'GU', 'GUM', 'Guam', 'Guam'),
( 320, 'GT', 'GTM', 'Guatemala', 'Guatemala'),
( 324, 'GN', 'GIN', 'Guinea', 'Guinée'),
( 328, 'GY', 'GUY', 'Guyana', 'Guyana'),
( 332, 'HT', 'HTI', 'Haiti', 'Haïti'),
( 334, 'HM', 'HMD', 'Heard Island and McDonald Islands', 'Îles Heard et Mcdonald'),
( 336, 'VA', 'VAT', 'Vatican City State', 'Saint-Siège (état de la Cité du Vatican)'),
( 340, 'HN', 'HND', 'Honduras', 'Honduras'),
( 344, 'HK', 'HKG', 'Hong Kong', 'Hong-Kong'),
( 348, 'HU', 'HUN', 'Hungary', 'Hongrie'),
( 352, 'IS', 'ISL', 'Iceland', 'Islande'),
( 356, 'IN', 'IND', 'India', 'Inde'),
( 360, 'ID', 'IDN', 'Indonesia', 'Indonésie'),
( 364, 'IR', 'IRN', 'Islamic Republic of Iran', 'République Islamique d''Iran'),
( 368, 'IQ', 'IRQ', 'Iraq', 'Iraq'),
( 372, 'IE', 'IRL', 'Ireland', 'Irlande'),
( 376, 'IL', 'ISR', 'Israel', 'Israël'),
( 380, 'IT', 'ITA', 'Italy', 'Italie'),
( 384, 'CI', 'CIV', 'Côte d''Ivoire', 'Côte d''Ivoire'),
( 388, 'JM', 'JAM', 'Jamaica', 'Jamaïque'),
( 392, 'JP', 'JPN', 'Japan', 'Japon'),
( 398, 'KZ', 'KAZ', 'Kazakhstan', 'Kazakhstan'),
( 400, 'JO', 'JOR', 'Jordan', 'Jordanie'),
( 404, 'KE', 'KEN', 'Kenya', 'Kenya'),
( 408, 'KP', 'PRK', 'Democratic People''s Republic of Korea', 'République Populaire Démocratique de Corée'),
( 410, 'KR', 'KOR', 'Republic of Korea', 'République de Corée'),
(414, 'KW', 'KWT', 'Kuwait', 'Koweït'),
( 417, 'KG', 'KGZ', 'Kyrgyzstan', 'Kirghizistan'),
( 418, 'LA', 'LAO', 'Lao People''s Democratic Republic', 'République Démocratique Populaire Lao'),
( 422, 'LB', 'LBN', 'Lebanon', 'Liban'),
( 426, 'LS', 'LSO', 'Lesotho', 'Lesotho'),
( 428, 'LV', 'LVA', 'Latvia', 'Lettonie'),
( 430, 'LR', 'LBR', 'Liberia', 'Libéria'),
( 434, 'LY', 'LBY', 'Libyan Arab Jamahiriya', 'Jamahiriya Arabe Libyenne'),
( 438, 'LI', 'LIE', 'Liechtenstein', 'Liechtenstein'),
( 440, 'LT', 'LTU', 'Lithuania', 'Lituanie'),
( 442, 'LU', 'LUX', 'Luxembourg', 'Luxembourg'),
( 446, 'MO', 'MAC', 'Macao', 'Macao'),
( 450, 'MG', 'MDG', 'Madagascar', 'Madagascar'),
( 454, 'MW', 'MWI', 'Malawi', 'Malawi'),
( 458, 'MY', 'MYS', 'Malaysia', 'Malaisie'),
( 462, 'MV', 'MDV', 'Maldives', 'Maldives'),
( 466, 'ML', 'MLI', 'Mali', 'Mali'),
( 470, 'MT', 'MLT', 'Malta', 'Malte'),
( 474, 'MQ', 'MTQ', 'Martinique', 'Martinique'),
( 478, 'MR', 'MRT', 'Mauritania', 'Mauritanie'),
( 480, 'MU', 'MUS', 'Mauritius', 'Maurice'),
( 484, 'MX', 'MEX', 'Mexico', 'Mexique'),
( 492, 'MC', 'MCO', 'Monaco', 'Monaco'),
( 496, 'MN', 'MNG', 'Mongolia', 'Mongolie'),
( 498, 'MD', 'MDA', 'Republic of Moldova', 'République de Moldova'),
( 500, 'MS', 'MSR', 'Montserrat', 'Montserrat'),
( 504, 'MA', 'MAR', 'Morocco', 'Maroc'),
( 508, 'MZ', 'MOZ', 'Mozambique', 'Mozambique'),
( 512, 'OM', 'OMN', 'Oman', 'Oman'),
( 516, 'NA', 'NAM', 'Namibia', 'Namibie'),
( 520, 'NR', 'NRU', 'Nauru', 'Nauru'),
( 524, 'NP', 'NPL', 'Nepal', 'Népal'),
( 528, 'NL', 'NLD', 'Netherlands', 'Pays-Bas'),
( 530, 'AN', 'ANT', 'Netherlands Antilles', 'Antilles Néerlandaises'),
( 533, 'AW', 'ABW', 'Aruba', 'Aruba'),
( 540, 'NC', 'NCL', 'New Caledonia', 'Nouvelle-Calédonie'),
( 548, 'VU', 'VUT', 'Vanuatu', 'Vanuatu'),
( 554, 'NZ', 'NZL', 'New Zealand', 'Nouvelle-Zélande'),
( 558, 'NI', 'NIC', 'Nicaragua', 'Nicaragua'),
( 562, 'NE', 'NER', 'Niger', 'Niger'),
( 566, 'NG', 'NGA', 'Nigeria', 'Nigéria'),
( 570, 'NU', 'NIU', 'Niue', 'Niué'),
( 574, 'NF', 'NFK', 'Norfolk Island', 'Île Norfolk'),
( 578, 'NO', 'NOR', 'Norway', 'Norvège'),
( 580, 'MP', 'MNP', 'Northern Mariana Islands', 'Îles Mariannes du Nord'),
( 581, 'UM', 'UMI', 'United States Minor Outlying Islands', 'Îles Mineures Éloignées des États-Unis'),
( 583, 'FM', 'FSM', 'Federated States of Micronesia', 'États Fédérés de Micronésie'),
( 584, 'MH', 'MHL', 'Marshall Islands', 'Îles Marshall'),
( 585, 'PW', 'PLW', 'Palau', 'Palaos'),
( 586, 'PK', 'PAK', 'Pakistan', 'Pakistan'),
( 591, 'PA', 'PAN', 'Panama', 'Panama'),
( 598, 'PG', 'PNG', 'Papua New Guinea', 'Papouasie-Nouvelle-Guinée'),
( 600, 'PY', 'PRY', 'Paraguay', 'Paraguay'),
( 604, 'PE', 'PER', 'Peru', 'Pérou'),
( 608, 'PH', 'PHL', 'Philippines', 'Philippines'),
( 612, 'PN', 'PCN', 'Pitcairn', 'Pitcairn'),
( 616, 'PL', 'POL', 'Poland', 'Pologne'),
( 620, 'PT', 'PRT', 'Portugal', 'Portugal'),
( 624, 'GW', 'GNB', 'Guinea-Bissau', 'Guinée-Bissau'),
( 626, 'TL', 'TLS', 'Timor-Leste', 'Timor-Leste'),
( 630, 'PR', 'PRI', 'Puerto Rico', 'Porto Rico'),
( 634, 'QA', 'QAT', 'Qatar', 'Qatar'),
( 638, 'RE', 'REU', 'Réunion', 'Réunion'),
( 642, 'RO', 'ROU', 'Romania', 'Roumanie'),
( 643, 'RU', 'RUS', 'Russian Federation', 'Fédération de Russie'),
( 646, 'RW', 'RWA', 'Rwanda', 'Rwanda'),
( 654, 'SH', 'SHN', 'Saint Helena', 'Sainte-Hélène'),
( 659, 'KN', 'KNA', 'Saint Kitts and Nevis', 'Saint-Kitts-et-Nevis'),
( 660, 'AI', 'AIA', 'Anguilla', 'Anguilla'),
( 662, 'LC', 'LCA', 'Saint Lucia', 'Sainte-Lucie'),
( 666, 'PM', 'SPM', 'Saint-Pierre and Miquelon', 'Saint-Pierre-et-Miquelon'),
( 670, 'VC', 'VCT', 'Saint Vincent and the Grenadines', 'Saint-Vincent-et-les Grenadines'),
( 674, 'SM', 'SMR', 'San Marino', 'Saint-Marin'),
( 678, 'ST', 'STP', 'Sao Tome and Principe', 'Sao Tomé-et-Principe'),
( 682, 'SA', 'SAU', 'Saudi Arabia', 'Arabie Saoudite'),
( 686, 'SN', 'SEN', 'Senegal', 'Sénégal'),
( 690, 'SC', 'SYC', 'Seychelles', 'Seychelles'),
( 694, 'SL', 'SLE', 'Sierra Leone', 'Sierra Leone'),
( 702, 'SG', 'SGP', 'Singapore', 'Singapour'),
( 703, 'SK', 'SVK', 'Slovakia', 'Slovaquie'),
( 704, 'VN', 'VNM', 'Vietnam', 'Viet Nam'),
( 705, 'SI', 'SVN', 'Slovenia', 'Slovénie'),
( 706, 'SO', 'SOM', 'Somalia', 'Somalie'),
( 710, 'ZA', 'ZAF', 'South Africa', 'Afrique du Sud'),
( 716, 'ZW', 'ZWE', 'Zimbabwe', 'Zimbabwe'),
( 724, 'ES', 'ESP', 'Spain', 'Espagne'),
( 732, 'EH', 'ESH', 'Western Sahara', 'Sahara Occidental'),
( 736, 'SD', 'SDN', 'Sudan', 'Soudan'),
( 740, 'SR', 'SUR', 'Suriname', 'Suriname'),
( 744, 'SJ', 'SJM', 'Svalbard and Jan Mayen', 'Svalbard etÎle Jan Mayen'),
( 748, 'SZ', 'SWZ', 'Swaziland', 'Swaziland'),
( 752, 'SE', 'SWE', 'Sweden', 'Suède'),
( 756, 'CH', 'CHE', 'Switzerland', 'Suisse'),
( 760, 'SY', 'SYR', 'Syrian Arab Republic', 'République Arabe Syrienne'),
( 762, 'TJ', 'TJK', 'Tajikistan', 'Tadjikistan'),
( 764, 'TH', 'THA', 'Thailand', 'Thaïlande'),
( 768, 'TG', 'TGO', 'Togo', 'Togo'),
( 772, 'TK', 'TKL', 'Tokelau', 'Tokelau'),
( 776, 'TO', 'TON', 'Tonga', 'Tonga'),
( 780, 'TT', 'TTO', 'Trinidad and Tobago', 'Trinité-et-Tobago'),
( 784, 'AE', 'ARE', 'United Arab Emirates', 'Émirats Arabes Unis'),
( 788, 'TN', 'TUN', 'Tunisia', 'Tunisie'),
( 792, 'TR', 'TUR', 'Turkey', 'Turquie'),
( 795, 'TM', 'TKM', 'Turkmenistan', 'Turkménistan'),
( 796, 'TC', 'TCA', 'Turks and Caicos Islands', 'Îles Turks et Caïques'),
( 798, 'TV', 'TUV', 'Tuvalu', 'Tuvalu'),
( 800, 'UG', 'UGA', 'Uganda', 'Ouganda'),
( 804, 'UA', 'UKR', 'Ukraine', 'Ukraine'),
( 807, 'MK', 'MKD', 'The Former Yugoslav Republic of Macedonia', 'L''ex-République Yougoslave de Macédoine'),
( 818, 'EG', 'EGY', 'Egypt', 'Égypte'),
( 826, 'GB', 'GBR', 'United Kingdom', 'Royaume-Uni'),
( 833, 'IM', 'IMN', 'Isle of Man', 'Île de Man'),
( 834, 'TZ', 'TZA', 'United Republic Of Tanzania', 'République-Unie de Tanzanie'),
( 840, 'US', 'USA', 'United States', 'États-Unis'),
( 850, 'VI', 'VIR', 'U.S. Virgin Islands', 'Îles Vierges des États-Unis'),
( 854, 'BF', 'BFA', 'Burkina Faso', 'Burkina Faso'),
( 858, 'UY', 'URY', 'Uruguay', 'Uruguay'),
( 860, 'UZ', 'UZB', 'Uzbekistan', 'Ouzbékistan'),
( 862, 'VE', 'VEN', 'Venezuela', 'Venezuela'),
( 876, 'WF', 'WLF', 'Wallis and Futuna', 'Wallis et Futuna'),
( 882, 'WS', 'WSM', 'Samoa', 'Samoa'),
( 887, 'YE', 'YEM', 'Yemen', 'Yémen'),
( 891, 'CS', 'SCG', 'Serbia and Montenegro', 'Serbie-et-Monténégro'),
( 894, 'ZM', 'ZMB', 'Zambia', 'Zambie');

COMMIT TRANSACTION

BEGIN TRANSACTION
SET IDENTITY_INSERT [Sales].[DocumentStatus] ON
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (9, N'Transferred', N'Transferred', 0, 0, NULL)
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (10, N'Received', N'Received', 0, 0, NULL)
SET IDENTITY_INSERT [Sales].[DocumentStatus] OFF
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [Administration].[Currency] SET [Code]=N'EUR' WHERE [Id]=3
UPDATE [Administration].[Currency] SET [Code]=N'USD' WHERE [Id]=5
Commit transaction

-- Mohamed BOUZIDI add Printed document status
SET IDENTITY_INSERT [Sales].[DocumentStatus] ON
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (11, N'Printed', N'Printed', 0, 0, NULL)
SET IDENTITY_INSERT [Sales].[DocumentStatus] OFF

--Mohamed BOUZIDI Documement NewStatus And Old In English
BEGIN TRANSACTION
UPDATE [Sales].[DocumentStatus] SET [Code]=N'Provisional', [Label]=N'Provisional' WHERE [Id]=1
UPDATE [Sales].[DocumentStatus] SET [Code]=N'Valid', [Label]=N'Valid' WHERE [Id]=2
UPDATE [Sales].[DocumentStatus] SET [Code]=N'Balanced', [Label]=N'Balanced' WHERE [Id]=3
UPDATE [Sales].[DocumentStatus] SET [Code]=N'Refused', [Label]=N'Refused' WHERE [Id]=4
UPDATE [Sales].[DocumentStatus] SET [Code]=N'ToOrder', [Label]=N'ToOrder' WHERE [Id]=5

SET IDENTITY_INSERT [Sales].[DocumentStatus] ON
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (6, N'TotallySatisfied', N'TotallySatisfied', 0, 0, NULL)
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (7, N'PartiallySatisfied', N'PartiallySatisfied', 0, 0, NULL)
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (8, N'NotSatisfied', N'NotSatisfied', 0, 0, NULL)
SET IDENTITY_INSERT [Sales].[DocumentStatus] OFF
COMMIT TRANSACTION
