/*
This script was created by Visual Studio on 16/04/2020 at 12:05.
Run this script on DESKTOP-ERP6.MasterGuidtest (SPARKIT\hregaieg) to make it the same as DESKTOP-ERP6.MasterGuid (SPARKIT\hregaieg).
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
DECLARE @usercompany  nvarchar(60)
set @usercompany = 'demo@spark-it.fr';

DECLARE @firstname  nvarchar(60)
set @firstname = 'Stark';

DECLARE @lastname  nvarchar(60)
set @lastname =  'Stark';

DECLARE @codecompany  nvarchar(60)
set @codecompany =  'C001';
---set @codecompany = 'C001';

BEGIN TRANSACTION
ALTER TABLE [Shared].[ContactTypeDocument] DROP CONSTRAINT [FK_ContactTypeDocument_Contact]
ALTER TABLE [Inventory].[ItemKit] DROP CONSTRAINT [FK_ItemKit_Item1]
ALTER TABLE [Inventory].[ItemKit] DROP CONSTRAINT [FK_ItemKit_Item]
ALTER TABLE [Payment].[ReflectiveSettlement] DROP CONSTRAINT [FK_ReflectiveSettlement_Settlement]
ALTER TABLE [Payment].[ReflectiveSettlement] DROP CONSTRAINT [FK_ReflectiveSettlement_SettlementRelated]
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
ALTER TABLE [Sales].[DocumentLinePrices] DROP CONSTRAINT [FK_DocumentLinePrices_Prices]
ALTER TABLE [Sales].[DocumentLinePrices] DROP CONSTRAINT [FK_DocumentLinePrices_DocumentLine]
ALTER TABLE [Payment].[WithholdingTaxLine] DROP CONSTRAINT [FK_WithholdingTaxLine_WithholdingTax]
ALTER TABLE [Sales].[SearchItem] DROP CONSTRAINT [FK_SearchItem_Tiers]
ALTER TABLE [Sales].[SearchItem] DROP CONSTRAINT [FK_SearchItem_User]
ALTER TABLE [ERPSettings].[ReportTemplate] DROP CONSTRAINT [FK_ReportTemplate_Entity]
ALTER TABLE [Treasury].[DetailTimetable] DROP CONSTRAINT [FK_DetailTimetable_Timetable]
ALTER TABLE [Treasury].[DetailTimetable] DROP CONSTRAINT [FK_DetailTimetable_PaymentType]
ALTER TABLE [Shared].[Hours] DROP CONSTRAINT [FK_Hours_Period]
ALTER TABLE [Shared].[Bank] DROP CONSTRAINT [FK_Bank_Country]
ALTER TABLE [Payment].[SettlementCommitment] DROP CONSTRAINT [FK_SettlementCommitment_Settlement]
ALTER TABLE [Payment].[SettlementCommitment] DROP CONSTRAINT [FK_SettlementCommitment_FinancialCommitment]
ALTER TABLE [Inventory].[StockDocument] DROP CONSTRAINT [FK_StockDocument_Warehouse1]
ALTER TABLE [Inventory].[StockDocument] DROP CONSTRAINT [FK_StockDocument_TypeStockDocument]
ALTER TABLE [Inventory].[StockDocument] DROP CONSTRAINT [FK_StockDocument_DocumentStatus]
ALTER TABLE [Inventory].[StockDocument] DROP CONSTRAINT [FK_StockDocument_Tiers]
ALTER TABLE [Inventory].[StockDocument] DROP CONSTRAINT [FK_StockDocument_User]
ALTER TABLE [Inventory].[StockDocument] DROP CONSTRAINT [FK_StockDocument_Warehouse]
ALTER TABLE [Sales].[ProvisioningDetails] DROP CONSTRAINT [FK_ProvisioningDetails_Item]
ALTER TABLE [Sales].[ProvisioningDetails] DROP CONSTRAINT [FK_ProvisioningDetails_Tiers]
ALTER TABLE [Sales].[ProvisioningDetails] DROP CONSTRAINT [FK_ProvisioningDetails_Provisioning]
ALTER TABLE [Administration].[EntityAxisValues] DROP CONSTRAINT [FK_EntityAxisValues_AxisValue]
ALTER TABLE [Administration].[EntityAxisValues] DROP CONSTRAINT [FK_EntityAxisValues_Entity]
ALTER TABLE [Inventory].[SubFamily] DROP CONSTRAINT [FK_SubFamily_Family]
ALTER TABLE [Sales].[TaxeGroupTiersConfig] DROP CONSTRAINT [FK_TaxeTiersConfig_TaxeGroupTiers]
ALTER TABLE [Sales].[TaxeGroupTiersConfig] DROP CONSTRAINT [FK_TaxeTiersConfig_Taxe]
ALTER TABLE [Sales].[SaleSettings] DROP CONSTRAINT [FK_SaleSetting_Company]
ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [FK_Settlement_BankAccount]
ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [FK_Settlement_DocumentStatus]
ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [FK_Settlement_PaymentStatus]
ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [FK_Settlement_Currency]
ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [FK_Settlement_PaymentMethod]
ALTER TABLE [Payment].[Settlement] DROP CONSTRAINT [FK_Settlement_Tiers]
ALTER TABLE [Sales].[DetailsSettlementMode] DROP CONSTRAINT [FK_DetailsSettlementMode_SettlementType]
ALTER TABLE [Sales].[DetailsSettlementMode] DROP CONSTRAINT [FK_DetailsSettlementMode_PaymentMethod]
ALTER TABLE [Sales].[DetailsSettlementMode] DROP CONSTRAINT [FK_DetailsSettlementMode_SettlementMode]
ALTER TABLE [Payment].[PaymentMethod] DROP CONSTRAINT [FK_PayementMethod_PayementType]
ALTER TABLE [Immobilisation].[History] DROP CONSTRAINT [FK_History_Active]
ALTER TABLE [Immobilisation].[History] DROP CONSTRAINT [FK_History_Employee]
ALTER TABLE [Treasury].[Timetable] DROP CONSTRAINT [FK_Timetable_PaymentType]
ALTER TABLE [Treasury].[Timetable] DROP CONSTRAINT [FK_Timetable_Tiers]
ALTER TABLE [Helpdesk].[ClaimInteraction] DROP CONSTRAINT [FK_ClaimInteraction_Claim]
ALTER TABLE [Shared].[ZipCode] DROP CONSTRAINT [FK_ZipCode_City]
ALTER TABLE [Shared].[DayOff] DROP CONSTRAINT [FK_DayOff_Period]
ALTER TABLE [Inventory].[MovementHistory] DROP CONSTRAINT [FK_MovementHistory_Item]
ALTER TABLE [Treasury].[DetailReconciliation] DROP CONSTRAINT [FK_DetailReconciliation3]
ALTER TABLE [Treasury].[DetailReconciliation] DROP CONSTRAINT [FK_DetailReconciliation]
ALTER TABLE [Sales].[FinancialCommitment] DROP CONSTRAINT [FK_FinancialCommitment_Currency]
ALTER TABLE [Sales].[FinancialCommitment] DROP CONSTRAINT [FK_FinancialCommitment_Tiers]
ALTER TABLE [Sales].[FinancialCommitment] DROP CONSTRAINT [FK_FinancialCommitment_DocumentStatus]
ALTER TABLE [Sales].[FinancialCommitment] DROP CONSTRAINT [FK_FinancialCommitment_PaymentMethod]
ALTER TABLE [Sales].[FinancialCommitment] DROP CONSTRAINT [FK_FinancialCommitment_Document]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Codification]
ALTER TABLE [ERPSettings].[EntityCodification] DROP CONSTRAINT [FK_EntityCodification_Entity]
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
ALTER TABLE [Inventory].[ModelOfItem] DROP CONSTRAINT [FK_Model_Brand]
ALTER TABLE [Shared].[Company] DROP CONSTRAINT [FK_Company_Currency]
ALTER TABLE [Immobilisation].[Active] DROP CONSTRAINT [FK_Active_DocumentLine1]
ALTER TABLE [Immobilisation].[Active] DROP CONSTRAINT [FK_Active_Warehouse]
ALTER TABLE [Immobilisation].[Active] DROP CONSTRAINT [FK_Active_Category1]
ALTER TABLE [Sales].[DocumentLineNegotiationOptions] DROP CONSTRAINT [FK_DocumentLineNegotiationOptions_Item]
ALTER TABLE [Sales].[DocumentLineNegotiationOptions] DROP CONSTRAINT [FK_DocumentLineNegotiationOptions_User]
ALTER TABLE [Sales].[DocumentLineNegotiationOptions] DROP CONSTRAINT [FK_DocumentLineNegotiationOptions_DocumentLineNegotiationOptions]
ALTER TABLE [Shared].[NewUserEmail] DROP CONSTRAINT [FK_NewUserEmail]
ALTER TABLE [Shared].[NewUserEmail] DROP CONSTRAINT [FK_Mail]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
ALTER TABLE [Inventory].[StockDocumentLine] DROP CONSTRAINT [FK_StockDocumentLine_StockDocument]
ALTER TABLE [Inventory].[StockDocumentLine] DROP CONSTRAINT [FK_StockDocumentLine_Item]
ALTER TABLE [Inventory].[StockDocumentLine] DROP CONSTRAINT [FK_StockDocumentLine_Warehouse]
ALTER TABLE [Sales].[Tiers_Provisioning] DROP CONSTRAINT [FK_Tiers_Provisioning_Provisioning]
ALTER TABLE [Sales].[Tiers_Provisioning] DROP CONSTRAINT [FK_Tiers_Provisioning_Tiers_Provisioning]
ALTER TABLE [Sales].[Provisioning] DROP CONSTRAINT [FK_Provisioning_ProvisioningOption]
ALTER TABLE [Helpdesk].[Claim] DROP CONSTRAINT [FK_Claim_PurchaseDocument]
ALTER TABLE [Helpdesk].[Claim] DROP CONSTRAINT [FK_Claim_ReceiptDocument]
ALTER TABLE [Helpdesk].[Claim] DROP CONSTRAINT [FK_Claim_SalesDocument]
ALTER TABLE [Helpdesk].[Claim] DROP CONSTRAINT [FK_Claim_DeliveryDocument]
ALTER TABLE [Helpdesk].[Claim] DROP CONSTRAINT [FK_Claim_ClaimStatus]
ALTER TABLE [Helpdesk].[Claim] DROP CONSTRAINT [FK_Claim_SalesAssetDocument]
ALTER TABLE [Helpdesk].[Claim] DROP CONSTRAINT [FK_Claim_PurchaseAssetDocument]
ALTER TABLE [Helpdesk].[Claim] DROP CONSTRAINT [FK_Claim_ClaimType]
ALTER TABLE [Helpdesk].[Claim] DROP CONSTRAINT [FK_Claim_Contact]
ALTER TABLE [Helpdesk].[Claim] DROP CONSTRAINT [FK_Claim_Client]
ALTER TABLE [Helpdesk].[Claim] DROP CONSTRAINT [FK_Claim_Fournisseur]
ALTER TABLE [Helpdesk].[Claim] DROP CONSTRAINT [FK_Claim_Document]
ALTER TABLE [Helpdesk].[Claim] DROP CONSTRAINT [FK_Claim_DocumentLine]
ALTER TABLE [Helpdesk].[Claim] DROP CONSTRAINT [FK_Claim_Warehouse]
ALTER TABLE [Helpdesk].[Claim] DROP CONSTRAINT [FK_Claim_Item]
ALTER TABLE [Helpdesk].[Claim] DROP CONSTRAINT [FK_Claim_MovementIn]
ALTER TABLE [Helpdesk].[Claim] DROP CONSTRAINT [FK_Claim_MovementOut]
ALTER TABLE [Inventory].[ItemVehicleBrandModelSubModel] DROP CONSTRAINT [FK_ItemVehicleBrandModelSubModel_Item]
ALTER TABLE [Inventory].[ItemVehicleBrandModelSubModel] DROP CONSTRAINT [FK_ItemVehicleBrandModelSubModel_ModelOfItem]
ALTER TABLE [Inventory].[ItemVehicleBrandModelSubModel] DROP CONSTRAINT [FK_ItemVehicleBrandModelSubModel_SubModel]
ALTER TABLE [Inventory].[ItemVehicleBrandModelSubModel] DROP CONSTRAINT [FK_ItemVehicleBrandModelSubModel_VehicleBrand]
ALTER TABLE [Inventory].[SubModel] DROP CONSTRAINT [FK_SubModel_Model]
ALTER TABLE [ERPSettings].[Comment] DROP CONSTRAINT [FK_Comment_Entity]
ALTER TABLE [Sales].[PriceRequestDetail] DROP CONSTRAINT [FK_PriceRequestDetail_Contact]
ALTER TABLE [Sales].[PriceRequestDetail] DROP CONSTRAINT [FK_PriceRequestDetail_Tiers]
ALTER TABLE [Sales].[PriceRequestDetail] DROP CONSTRAINT [FK_PriceRequestDetail_Item]
ALTER TABLE [Sales].[PriceRequestDetail] DROP CONSTRAINT [FK_PriceRequestDetail_PriceRequest]
ALTER TABLE [Shared].[Taxe] DROP CONSTRAINT [FK_Taxe_TaxeType]
ALTER TABLE [Sales].[DocumentExpenseLine] DROP CONSTRAINT [FK_DocumentExpenseLine_Tiers]
ALTER TABLE [Sales].[DocumentExpenseLine] DROP CONSTRAINT [FK_DocumentExpenseLine_Taxe]
ALTER TABLE [Sales].[DocumentExpenseLine] DROP CONSTRAINT [FK_DocumentExpenseLine_Expense]
ALTER TABLE [Sales].[DocumentExpenseLine] DROP CONSTRAINT [FK_DocumentExpenseLine_Document]
ALTER TABLE [Sales].[DocumentExpenseLine] DROP CONSTRAINT [FK_DocumentExpenseLine_Currency]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
ALTER TABLE [Sales].[PurchaseSettings] DROP CONSTRAINT [FK_PurchaseSetting_Company]
ALTER TABLE [Sales].[PurchaseSettings] DROP CONSTRAINT [FK_PurchaseSettings_User]
ALTER TABLE [ERPSettings].[UserInfo] DROP CONSTRAINT [FK_Info_UserInfo]
ALTER TABLE [ERPSettings].[UserInfo] DROP CONSTRAINT [FK_User_UserInfo]
ALTER TABLE [ERPSettings].[User] DROP CONSTRAINT [FK_User_Employee]
ALTER TABLE [ERPSettings].[User] DROP CONSTRAINT [FK_User_User]
ALTER TABLE [ERPSettings].[User] DROP CONSTRAINT [FK_User_Tiers]
ALTER TABLE [Shared].[BankAccount] DROP CONSTRAINT [FK_BankAccount_Bank]
ALTER TABLE [Shared].[City] DROP CONSTRAINT [FK_City_Country]
ALTER TABLE [Sales].[DocumentTypeRelation] DROP CONSTRAINT [FK_DocumentTypeRelation_DocumentTypeRelation]
ALTER TABLE [Sales].[DocumentTypeRelation] DROP CONSTRAINT [FK_DocumentTypeRelation_DocumentType]
ALTER TABLE [Sales].[DocumentType] DROP CONSTRAINT [FK_DocumentType_DocumentType]
ALTER TABLE [Treasury].[ReceiptSpent] DROP CONSTRAINT [FK_ReceiptSpent_PaymentMethod]
ALTER TABLE [Treasury].[ReceiptSpent] DROP CONSTRAINT [FK_RecipeSpent_PaymentDirection]
ALTER TABLE [Treasury].[ReceiptSpent] DROP CONSTRAINT [FK_RecipeSpent_Tiers]

INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected], [FinancialCommitmentDirection], [IsActiveGeneration], [LabelEn]) VALUES (N'A-PU', N'A-PU', N'Avoir', N'Avoir Fournisseur', NULL, 1, N'O', N'R', 0, 0, 0, NULL, 0, 1, 1, 0, N'Asset')
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected], [FinancialCommitmentDirection], [IsActiveGeneration], [LabelEn]) VALUES (N'A-SA', N'A-SA', N'Avoir', N'Avoir Client', N'I-SA', 1, N'I', N'R', 0, 0, 0, NULL, 1, 0, NULL, 0, N'Asset')
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected], [FinancialCommitmentDirection], [IsActiveGeneration], [LabelEn]) VALUES (N'BE-PU', N'BE-PU', N'Bon d''entrée', N'Bon d''entrée', NULL, 1, N'I', N'R', 0, 0, 0, NULL, 0, 0, NULL, 0, N'Admission vouchers')
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected], [FinancialCommitmentDirection], [IsActiveGeneration], [LabelEn]) VALUES (N'B-PU', N'B-PU', N'Devis', N'Devis achat', NULL, 0, NULL, NULL, 0, 0, 0, NULL, 0, 0, NULL, 0, N'Quotation')
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected], [FinancialCommitmentDirection], [IsActiveGeneration], [LabelEn]) VALUES (N'BS-SA', N'BS-SA', N'Bon de sortie', N'Bon de sortie', NULL, 1, N'O', N'R', 0, 0, 0, NULL, 1, 0, NULL, 0, N'Exit vouchers')
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected], [FinancialCommitmentDirection], [IsActiveGeneration], [LabelEn]) VALUES (N'D-PU', N'D-PU', N'Bon de reception', N'Bon de reception', N'FO-PU', 1, N'I', N'R', 0, 0, 0, NULL, 0, 0, NULL, 0, N'Receipt')
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected], [FinancialCommitmentDirection], [IsActiveGeneration], [LabelEn]) VALUES (N'D-SA', N'D-SA', N'Bon de livraison', N'Bon de livraison', N'O-SA', 1, N'O', N'R', 0, 0, 0, NULL, 1, 0, NULL, 0, N'Delivery form')
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected], [FinancialCommitmentDirection], [IsActiveGeneration], [LabelEn]) VALUES (N'FO-PU', N'FO-PU', N'Facture achat', N'Facture achat', N'O-PU', 1, N'I', N'P', 0, 0, 0, NULL, 0, 0, NULL, 0, N'Purchase invoice')
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected], [FinancialCommitmentDirection], [IsActiveGeneration], [LabelEn]) VALUES (N'IA-SA', N'IA-SA', N'Facture Avoir Client', N'Facture Avoir Client', N'A-SA', 0, NULL, NULL, 1, 0, 0, NULL, 1, 1, 2, 0, N'Client invoice asset')
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected], [FinancialCommitmentDirection], [IsActiveGeneration], [LabelEn]) VALUES (N'I-PU', N'I-PU', N'Facture', N'Facture d''achat', N'D-PU', 0, NULL, NULL, 0, 0, 0, NULL, 0, 1, 2, 1,N'Invoice')
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected], [FinancialCommitmentDirection], [IsActiveGeneration], [LabelEn]) VALUES (N'I-SA', N'I-SA', N'Facture', N'Facture de vente', N'D-SA', 0, NULL, NULL, 1, 0, 0, NULL, 1, 1, 1, 0, N'Invoice')
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected], [FinancialCommitmentDirection], [IsActiveGeneration], [LabelEn]) VALUES (N'O-PU', N'O-PU', N'Bon de commande', N'Bon de commande  achat', N'B-PU', 0, NULL, NULL, 0, 0, 0, NULL, 0, 0, NULL, 0,N'Order')
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected], [FinancialCommitmentDirection], [IsActiveGeneration], [LabelEn]) VALUES (N'O-SA', N'O-SA', N'Bon de commande', N'Bon de commande vente', N'Q-SA', 0, N'O', N'P', 0, 0, 0, NULL, 1, 0, NULL, 0, N'Order')
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected], [FinancialCommitmentDirection], [IsActiveGeneration], [LabelEn]) VALUES (N'Q-PU', N'Q-PU', N'Demande de prix', N'Demande de prix', NULL, 0, N'I', NULL, 0, 0, 0, NULL, 0, 0, NULL, 0, N'Price requests')
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected], [FinancialCommitmentDirection], [IsActiveGeneration], [LabelEn]) VALUES (N'Q-SA', N'Q-SA', N'Devis', N'Devis', NULL, 0, N'I', NULL, 0, 0, 0, NULL, 1, 0, NULL, 0, N'Quotation')
INSERT INTO [Sales].[DocumentType] ([CodeType], [Code], [Label], [Description], [DefaultCodeDocumentTypeAssociated], [IsStockAffected], [StockOperation], [StockOperationStatus], [CreateAssociatedDocument], [IsDeleted], [TransactionUserId], [Deleted_Token], [IsSaleDocumentType], [IsFinancialCommitmentAffected], [FinancialCommitmentDirection], [IsActiveGeneration], [LabelEn]) VALUES (N'RQ-PU', N'RQ-PU', N'Demande d''achat', N'Demande d''achat', N'O-PU', 0, NULL, NULL, 0, 0, 0, NULL, 0, 0, NULL, 0, N'Purchase requests')
SET IDENTITY_INSERT [Sales].[DocumentTypeRelation] ON
INSERT INTO [Sales].[DocumentTypeRelation] ([id], [CodeDocumentType], [CodeDocumentTypeAssociated]) VALUES (2, N'D-PU', N'FO-PU')
INSERT INTO [Sales].[DocumentTypeRelation] ([id], [CodeDocumentType], [CodeDocumentTypeAssociated]) VALUES (3, N'D-SA', N'O-SA')
INSERT INTO [Sales].[DocumentTypeRelation] ([id], [CodeDocumentType], [CodeDocumentTypeAssociated]) VALUES (4, N'I-PU', N'D-PU')
INSERT INTO [Sales].[DocumentTypeRelation] ([id], [CodeDocumentType], [CodeDocumentTypeAssociated]) VALUES (5, N'I-SA', N'D-SA')
INSERT INTO [Sales].[DocumentTypeRelation] ([id], [CodeDocumentType], [CodeDocumentTypeAssociated]) VALUES (6, N'O-PU', N'B-PU')
INSERT INTO [Sales].[DocumentTypeRelation] ([id], [CodeDocumentType], [CodeDocumentTypeAssociated]) VALUES (7, N'O-SA', N'Q-SA')
INSERT INTO [Sales].[DocumentTypeRelation] ([id], [CodeDocumentType], [CodeDocumentTypeAssociated]) VALUES (8, N'A-PU', N'I-PU')
INSERT INTO [Sales].[DocumentTypeRelation] ([id], [CodeDocumentType], [CodeDocumentTypeAssociated]) VALUES (9, N'A-SA', N'I-SA')
INSERT INTO [Sales].[DocumentTypeRelation] ([id], [CodeDocumentType], [CodeDocumentTypeAssociated]) VALUES (10, N'FO-PU', N'O-PU')
INSERT INTO [Sales].[DocumentTypeRelation] ([id], [CodeDocumentType], [CodeDocumentTypeAssociated]) VALUES (15, N'BS-SA', N'D-SA')
INSERT INTO [Sales].[DocumentTypeRelation] ([id], [CodeDocumentType], [CodeDocumentTypeAssociated]) VALUES (17, N'IA-SA', N'A-SA')
SET IDENTITY_INSERT [Sales].[DocumentTypeRelation] OFF
SET IDENTITY_INSERT [Shared].[City] ON
INSERT INTO [Shared].[City] ([Id], [Code], [Label], [IdCountry], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (84, N'PARIS', N'PARIS', 91, 0, 0, NULL)
INSERT INTO [Shared].[City] ([Id], [Code], [Label], [IdCountry], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (85, N'Tunis', N'Tunis', 235, 0, 0, NULL)
SET IDENTITY_INSERT [Shared].[City] OFF
SET IDENTITY_INSERT [ERPSettings].[User] ON
INSERT INTO [ERPSettings].[User] ([Id], [FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee], [IsBToB], [IdTiers], [Role]) VALUES (2, @firstname, @lastname, N'Administrator', N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, NULL, NULL, NULL, @usercompany, NULL, NULL, 0, 0, NULL, NULL, N'fr', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[User] OFF
SET IDENTITY_INSERT [Sales].[PurchaseSettings] ON
INSERT INTO [Sales].[PurchaseSettings] ([Id], [PurchaseOtherTaxes], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdPurchasingManager], [PurchaseAllowItemManagedInStock], [PurchaseAllowItemRelatedToSupplier]) VALUES (2, 0, 0, 0, NULL, 2, 0, 1)
SET IDENTITY_INSERT [Sales].[PurchaseSettings] OFF
SET IDENTITY_INSERT [ERPSettings].[Information] ON
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500009, N'78dfa306-e1a5-4530-9be4-fea0cc1cc31f', N'/inventory/inputmovement/show', N'Un mouvement d''entrée {CODE} a été ajouté', N'An input movement {CODE} has been added', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_INPUT_MVT', N'INVENTORY_INTPUT_MVT_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500010, N'01bdc9eb-8f37-4b28-96f5-e661259e9291', N'/inventory/outputmovement/show', N'Un mouvement de sortie {CODE} a été ajouté', N'An output movement {CODE} has been added', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_OUTPUT_MVT', N'INVENTORY_OUTPUT_MVT_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500011, N'34a0f7d3-7f88-4de8-8c29-a1827670a940', N'/inventory/stockDocuments/transfertMovement/show', N'Un mouvement de transfert {CODE} a été ajouté', N'A transfer movement {CODE} has been added', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_TRANSAFER_MVT', N'INVENTORY_TRANSFER_MVT_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500012, N'c0916b52-e9a6-40a6-a00a-02c8aa4522c8', N'/inventory/inventorymovement/show', N'Un mouvement d''inventaire {CODE} a été ajouté', N'An inventory movement {CODE} has been added', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_INVENTORY_MVT', N'INVENTORY_INVENTORY_MVT_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500013, N'02268ec7-c879-47b8-b174-de3c359eff7a', N'/purchase/invoice/show', N'Une facture {CODE} a été ajoutée', N'An invoice {CODE} has been added', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_INVOICE', N'PURCHASE_INVOICE_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500014, N'88888a3e-9ecb-43d6-9fce-099336b2a534', N'/purchase/asset/show', N'Un avoir {CODE} a été ajouté', N'An asset {CODE} has been added', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_ASSET', N'PURCHASE_PURCHASE_ASSET_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500015, N'dd748a92-303d-45fa-82c5-cb6697329f29', N'/purchase/purchaseorder/show', N'Un bon de commande {CODE} a été ajouté', N'An order form {CODE} has been added', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_ORDER_FORM', N'PURCHASE_PURCHASE_ORDER_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500016, N'0c2413e5-e633-4d8f-94f8-56574ed1cc05', N'/purchase/delivery/show', N'Un bon de reception {CODE} a été ajouté', N'A receipt {CODE} has been added', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_RECEIPT', N'PURCHASE_RECEIPT_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500017, N'16cc4069-dc25-49d7-b272-dcfc28549301', N'/sales/order/show', N'Un bon de commande {CODE} a été ajouté', N'An order form {CODE} has been added', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_ORDER_FORM', N'SALES_ORDER_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500018, N'2e40ab73-0553-47b0-9eb5-d9eb534e05b1', N'/sales/delivery/show', N'Un bon de livraison {CODE} a été ajouté', N'A delivery note {CODE} has been added', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_DELIVERY_NOTE', N'SALES_DELEVERY_NOTE_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500019, N'86ef34f3-b62f-4d0a-a673-bfecd5a8730e', N'/sales/invoice/show', N'Une facture {CODE} a été ajoutée', N'An invoice {CODE} has been added', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_INVOICE', N'SALES_INVOICE_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500020, N'0cca5b44-467a-4807-a0e0-d583c693d776', N'/sales/asset/show', N'Un avoir {CODE} a été ajouté', N'An asset {CODE} has been added', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_ASSET', N'SALES_ASSET_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500022, N'5f410902-9c3b-47db-b648-e154b97b09d6', N'/sales/quotation/show', N'Un devis {CODE} a été ajouté', N'A quotation {CODE} has been added', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_QUOTATION', N'SALES_QUOTATION_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500023, N'646a1da2-f25a-4782-8430-a7c7e8762da3', N'/purchase/purchasequotation/show', N'Merci de nous communiquer votre offre de prix pour le(s) article(s) suivant(s) :', N'Please give us your price offer for the following item(s) :', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_PRICE_REQUEST', N'SALES_PRICE_REQUEST_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500024, N'f40d9aec-9f39-4e4b-a73d-6fcec5f73c32', N'/sales/clientfinancialcommitment/list', N'Vous avez une échéance non soldée de date {DATE} pour le client  {CODE}', N'You have an unresolved financial commitment dated {DATE} for the customer {CODE}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_REMIND_CUSTOMER_FINANTIAL_COMMITEMENT', N'SALES_CUSTOMER_FINANCIAL_COMMITEMENT_REMIND')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500025, N'0233afff-931a-48cc-86d9-c8a83b415efa', N'/sales/supplierfinancialcommitment/list', N'Vous avez une échéance non soldée de date {DATE} pour le fournisseur {CODE}', N'You have an unresolved financial commitment dated {DATE} for the supplier {CODE}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_REMIND_SUPPLIER_FINANTIAL_COMMITEMENT', N'SALES_SUPPLIER_FINANCIAL_COMMITEMENT_REMIND')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500026, N'a35adf1d-f4f6-494f-975a-0492fffa70db', N'/sales/invoice/show', N'La facture  {CODE} a été validée', N'The invoice {CODE} has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, 1000500019, N'NOTIFICATION_VALIDATION_INVOICE', N'SALES_INVOICE_VALIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500029, N'd473bcce-1332-47fb-95a0-1bf7b479b5ae', N'/sales/order/show', N'Le bon de commande  {CODE} a été validé', N'The order form {CODE} has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, 1000500017, N'NOTIFICATION_VALIDATION_ORDER_FORM', N'SALES_ORDER_VALIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500033, N'5c6b6ad9-1b90-4d2b-b36e-2ba2cf5075fc', N'/sales/delivery/show', N'Le bon de livraison  {CODE} a été validé', N'The delivery note {CODE} has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, 1000500018, N'NOTIFICATION_VALIDATION_DELIVERY_NOTE', N'SALES_DELEVERY_NOTE_VALIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500035, N'5281d288-b1b4-4e3e-9a00-5d5ab4437019', N'/sales/quotation/show', N'Le devis  {CODE} a été validé', N'The quotation {CODE} has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, 1000500022, N'NOTIFICATION_VALIDATION_QUOTATION', N'SALES_QUOTATION_VALIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500039, N'a359eaa9-7f55-4f64-aaa7-bcb07115cfc3', N'/sales/asset/show', N'L''avoir  {CODE} a été validé', N'The asset {CODE} has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, 1000500020, N'NOTIFICATION_VALIDATION_ASSET', N'SALES_ASSET_VALIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500041, N'a4b6168d-3589-4dfa-8a92-523ac1d03d99', N'/purchase/delivery/show', N'Le bon de reception {CODE} a été validé', N'The receipt {CODE} has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, 1000500016, N'NOTIFICATION_VALIDATION_RECEIPT', N'PURCHASE_RECEIPT_VALIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500043, N'7ae52d61-2e8f-40c1-9b16-55a1b016a286', N'/purchase/invoice/show', N'La facture {CODE} a été validée', N'The invoice {CODE} has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, 1000500013, N'NOTIFICATION_VALIDATION_INVOICE', N'PURCHASE_INVOICE_VALIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500045, N'b7e30a6e-02bb-4b23-8762-a0121459bf94', N'/purchase/asset/show', N'L''avoir {CODE} a été validé', N'The asset {CODE} has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, 1000500014, N'NOTIFICATION_VALIDATION_ASSET', N'PURCHASE_ASSET_VALIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500047, N'd04bdd1c-7ba9-4552-a50c-a8c30ec313f2', N'/purchase/purchasequotation/show', N'La demande de prix  {CODE} a été validée', N'The quotation {CODE} has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, 1000500023, N'NOTIFICATION_VALIDATION_QUOTATION', N'PURCHASE_QUOTATION_VALIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500048, N'30ed6b09-268f-4e07-9bdf-d003d7d32502', N'/purchase/purchaseorder/show', N'Le bon de commande  {CODE} a été validé', N'The order form {CODE} has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, 1000500015, N'NOTIFICATION_VALIDATION_ORDER_FORM', N'PURCHASE_ORDER_VLIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500050, N'a0fa8cb4-a958-4237-87c0-194c59f15a0c', N'/inventory/inputmovement/show', N'Le mouvement d''entrée  {CODE} a été validé', N'The input movement {CODE} has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, 1000500009, N'NOTIFICATION_VALIDATION_INPUT_MVT', N'INVENTORY_INTPUT_MVT_VALIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500052, N'baca0b66-1cfd-469f-8eed-5442857d76b5', N'/inventory/stockDocuments/transfertMovement/show', N'Le mouvement de transfert  {CODE} a été validé', N'The transfer movement {CODE} has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, 1000500011, N'NOTIFICATION_VALIDATION_TRANSFER_MVT', N'INVENTORY_TRANSFER_MVT_VALIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500054, N'933e29fd-f6fb-4317-b0c7-5cbb7655a06e', N'/inventory/inventorymovement/show', N'Le mouvement d''inventaire  {CODE} a été validé', N'The inventory movement {CODE} has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, 1000500012, N'NOTIFICATION_VALIDATION_INVENTORY_MVT', N'INVENTORY_INVENTORY_MVT_VALIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500056, N'c62e61c1-16ae-463c-8de8-fcc0516df031', N'/inventory/outputmovement/show', N'Le mouvement de sortie  {CODE} a été validé', N'The output movement {CODE} has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, 1000500010, N'NOTIFICATION_VALIDATION_OUTPUT_MVT', N'INVENTORY_OUTPUT_MVT_VALIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500060, N'66754c61-6ecd-44cf-9ae4-543635e0d460', N'/purchase/purchaserequest/show', N'Une demande d''achat {CODE} a été ajoutée', N'A purchase request {CODE} has been added', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_ADD_PURCHASE_REQUEST', N'PURCHASE_PURCHASE_REQUEST_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500065, N'45eccc6e-6a8e-4a00-aee1-b046e94f7b68', N'/purchase/purchaserequest/show', N'la demande d''achat  {CODE} a été validée', N'The purchase request {CODE} has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, 1000500060, N'NOTIFICATION_VALIDATION_PURCHASE_REQUEST', N'PURCHASE_PURCHASE_REQUEST_VALIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000500066, N'45eccc6e-6a8e-4a00-aee1-b046e94f7b68', N'/purchase/purchaserequest/show', N'la demande d''achat  {CODE} a été refusée', N'The purchase request {CODE} has been refused', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, 1000500060, N'NOTIFICATION_REFUSE_PURCHASE_REQUEST', N'PURCHASE_PURCHASE_REQUEST_REFUSE')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501065, N'b6875160-0302-4d15-9bd9-3431e21aeb24', N'/payment/suppliersettlement/show', N'Un règlement fournisseur a été ajouté', N'A supplier settlement has been added', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_ADD_SUPPLIER_SETTLEMENT', N'PAYMENT_SUPPLIER_SETTELEMENT_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501066, N'681c3f06-93ec-4d82-928a-21425d6dbb91', N'/payment/suppliersettlement/show', N'Un règlement fournisseur a été validé', N'A supplier settlement has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, 1000501065, N'NOTIFICATION_VALIDATION_SUPPLIER_SETTLEMENT', N'PAYMENT_SUPPLIER_SETTELEMENT_VALIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501067, N'1c969e3f-5fb9-42c1-8a39-8c84122aded1', N'/payment/customersettlement/show', N'Un règlement client a été ajouté', N'A customer settlement has been added', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_ADD_CUSTOMERR_SETTLEMENT', N'PAYMENT_CUSTOMER_SETTELEMENT_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501068, N'93481abc-8bc8-4b26-b02b-d2eb935903d6', N'/payment/customersettlement/show', N'Un règlement client a été validé', N'A customer settlement has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, 1000501067, N'NOTIFICATION_VALIDATION_CUSTOMERR_SETTLEMENT', N'PAYMENT_CUSTOMER_SETTELEMENT_VALIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501069, N'bb95f2a9-8ee5-415e-8b24-2447e6ba4dcb', N'/purchase/purchaserequest/show', N'{CREATOR} a ajouté un commentaire pour la demande d''achat {CODE}', N'{CREATOR} added a comment for the purchase request {CODE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_COMMENT_PURCHASE_REQUEST_SHOW', N'ADD_COMMENT_PURCHASE_REQUEST_SHOW')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501070, N'bb95f2a9-8ee5-415e-8b24-2447e6ba4dcb', N'/purchase/purchaserequest/edit', N'{CREATOR} a ajouté un commentaire pour la demande d''achat {CODE}', N'{CREATOR} added a comment for the purchase request {CODE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_COMMENT_PURCHASE_REQUEST_UPDATE', N'ADD_COMMENT_PURCHASE_REQUEST_UPDATE')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501071, N'baca0b66-1cfd-469f-8eed-5442857d76b5', N'/inventory/stockDocuments/transfertMovement/show', N'Le mouvement de transfert  {CODE} a été transféré', N'The transfer movement {CODE} has been transferred', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, 1000500011, N'NOTIFICATION_TRANSFERT_TRANSFER_MVT', N'INVENTORY_TRANSFER_MVT_TRANSFERT')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501072, N'baca0b66-1cfd-469f-8eed-5442857d76b5', N'/inventory/stockDocuments/transfertMovement/show', N'Le mouvement de transfert  {CODE} a été reçu', N'The transfer movement {CODE} has been received', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, 1000500011, N'NOTIFICATION_RECEIVE_TRANSFER_MVT', N'INVENTORY_TRANSFER_MVT_RECEIVE')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501074, N'4915c87a-4c0a-4635-beb4-6626d46415c2', N'/payroll/employee/edit', N'Le contrat de {FullName} prendra fin le {DateEndContract}', N'{FullName}''s contract will end on {DateEndContract}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_END_CONTRACT', N'PAYROLL_END_CONTRACT')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501075, N'0cee8cd0-1ebf-48fc-a517-ea387ea80b9f', N'/sales/delivery/show', N'L''article {CODE} est disponible', N'The product {CODE} is available', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_AVAILABLE_PRODUCT_IN_CENTRAL_WAREHOUCE', N'SALES_DELIVERY_AVAILABLE_PRODUCT_IN_CENTRAL_WAREHOUCE')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501076, N'0cee8cd0-1ebf-48fc-a517-ea387ea80b9f', N'/sales/delivery/show', N'L''article {CODE} est disponible', N'The product {CODE} is available', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_AVAILABLE_PRODUCT_IN_WAREHOUCE', N'SALES_DELIVERY_AVAILABLE_PRODUCT_IN_WAREHOUCE')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501078, N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', N'/payroll/expenseReport/edit', N'{CREATOR} a ajouté un commentaire pour la demande de note de frais {CODE}', N'{CREATOR} added a comment for the expense report request {CODE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_COMMENT_EXPENSE_REPORT_REQUEST', N'ADD_COMMENT_EXPENSE_REPORT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501079, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/leave/edit', N'{CREATOR} a ajouté un commentaire pour la demande du congés {CODE}', N'{CREATOR} added a comment for the leave request {CODE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_COMMENT_LEAVE_REQUEST', N'ADD_COMMENT_LEAVE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501080, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/document/edit', N'{CREATOR} a ajouté un commentaire pour la demande du document {CODE}', N'{CREATOR} added a comment for the document request {CODE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_COMMENT_DOCUMENT_REQUEST', N'ADD_COMMENT_DOCUMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501081, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/leave/edit', N'{CREATOR} a ajouté une demande de congé {DOC_CODE} {PROFIL}', N'{CREATOR} added a new leave request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_ADD_LEAVE_REQUEST', N'ADD_LEAVE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501082, N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', N'/payroll/expenseReport/edit', N'{CREATOR} a ajouté demande de note de frais {DOC_CODE} {PROFIL}', N'{CREATOR} added a new expense report {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_ADD_EXPENSE_REPORT', N'ADD_EXPENSE_REPORT')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501083, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/document/edit', N'{CREATOR} a ajouté une demande de document {DOC_CODE} {PROFIL}', N'{CREATOR} added a new document request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_ADD_DOCUMENT_REQUEST', N'ADD_DOCUMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501084, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/leave/edit', N'{CREATOR} a modifié la demande de congé {DOC_CODE} {PROFIL}', N'{CREATOR} updated the leave request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_UPDATE_LEAVE_REQUEST', N'UPDATE_LEAVE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501085, N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', N'/payroll/expenseReport/edit', N'{CREATOR} a modifié la demande de note de frais {DOC_CODE} {PROFIL}', N'{CREATOR} updated the expense report {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_UPDATE_EXPENSE_REPORT', N'UPDATE_EXPENSE_REPORT')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501086, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/document/edit', N'{CREATOR} a modifié la demande de document {DOC_CODE} {PROFIL}', N'{CREATOR} updated the document request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_UPDATE_DOCUMENT_REQUEST', N'UPDATE_DOCUMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501087, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/leave/edit', N'{CREATOR} a validé la demande de congé {DOC_CODE}  {PROFIL}', N'{CREATOR} validated the leave request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_VALIDATE_LEAVE_REQUEST', N'VALIDATE_LEAVE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501088, N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', N'/payroll/expenseReport/edit', N'{CREATOR} a validé la demande de note de frais {DOC_CODE} {PROFIL}', N'{CREATOR} validated the expense report {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_VALIDATE_EXPENSE_REPORT', N'VALIDATE_EXPENSE_REPORT')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501089, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/document/edit', N'{CREATOR} a validé la demande de document {DOC_CODE} {PROFIL}', N'{CREATOR} validated the document request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_VALIDATE_DOCUMENT_REQUEST', N'VALIDATE_DOCUMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501090, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/leave/edit', N'{CREATOR} a refusé la demande de congé {DOC_CODE}  {PROFIL}', N'{CREATOR} refused the leave request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_REFUSE_LEAVE_REQUEST', N'REFUSE_LEAVE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501091, N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', N'/payroll/expenseReport/edit', N'{CREATOR} a refusé la demande de note de frais {DOC_CODE} {PROFIL}', N'{CREATOR} refused the expense report {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_REFUSE_EXPENSE_REPORT', N'REFUSE_EXPENSE_REPORT')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501092, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/document/edit', N'{CREATOR} a refusé la demande de document {DOC_CODE} {PROFIL}', N'{CREATOR} refused the document request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_REFUSE_DOCUMENT_REQUEST', N'REFUSE_DOCUMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501093, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/leave/edit', N'{CREATOR} a annulé la demande de congé {DOC_CODE}  {PROFIL}', N'{CREATOR} canceled the leave request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_CANCEL_LEAVE_REQUEST', N'CANCEL_LEAVE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501094, N'a94a17a2-60ed-4bde-a307-22787ea95b96', N'/payroll/leave', N'{CREATOR} a supprimé une demande de congé {DOC_CODE} {PROFIL}', N'{CREATOR} removed the leave request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_DELETE_LEAVE_REQUEST', N'DELETE_LEAVE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501095, N'c7035a5e-7d19-4041-93e6-11dec3d4ae79', N'/payroll/expenseReport', N'{CREATOR} a supprimé une demande de note de frais {DOC_CODE} {PROFIL}', N'{CREATOR} removed the expense report {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_DELETE_EXPENSE_REPORT', N'DELETE_EXPENSE_REPORT')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501096, N'788872dc-bdd0-4558-b3c8-37af3fda8a42', N'/payroll/document', N'{CREATOR} a supprimé une demande de document {DOC_CODE} {PROFIL}', N'{CREATOR} removed the document request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_DELETE_DOCUMENT_REQUEST', N'DELETE_DOCUMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501097, N'3a396a34-e1f0-4c47-93db-394bc5f4c557', N'/rh/recruitment/edit', N'{INTERVIEW_CREATOR} vous a ajouté en tant qu''intervieweur requis pour l''entretien du candidat {CANDIDATE_NAME} le {INTERVIEW_DATE} à {INTERVIEW_TIME}', N'{INTERVIEW_CREATOR} has added you as a required interviewer to the interview of the candidate {CANDIDATE_NAME} on {INTERVIEW_DATE} at {INTERVIEW_TIME}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_ADD_REQUIRED_INTERVIEWER', N'ADDED_AS_REQUIRED_INTERVIEWER')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501098, N'3a396a34-e1f0-4c47-93db-394bc5f4c557', N'/rh/recruitment/edit', N'{INTERVIEW_CREATOR} vous a ajouté en tant qu''intervieweur optionnel pour l''entretien du candidat {CANDIDATE_NAME} le {INTERVIEW_DATE} à {INTERVIEW_TIME}', N'{INTERVIEW_CREATOR} has added you as a optional interviewer to the interview of the candidate {CANDIDATE_NAME} on {INTERVIEW_DATE} at {INTERVIEW_TIME}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_ADD_OPTIONAL_INTERVIEWER', N'ADDED_AS_OPTIONAL_INTERVIEWER')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501099, N'3a396a34-e1f0-4c47-93db-394bc5f4c557', N'/rh/recruitment/edit', N'{INTERVIEW_CREATOR} vous a ajouté en tant qu''intervieweur optionnel pour l''entretien du candidat {CANDIDATE_NAME} le {INTERVIEW_DATE} à {INTERVIEW_TIME}', N'{INTERVIEW_CREATOR} has added you as a optional interviewer to the interview of the candidate {CANDIDATE_NAME} on {INTERVIEW_DATE} at {INTERVIEW_TIME}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_DELETE_INTERVIEWER', N'DELETED_FROM_INTERVIEWER_LIST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501100, N'65f51079-a03f-4d49-879a-d14fdfd94f7f', N'/rh/sharedDocument', N'La Bulletin de paie de la Session {SESSION_TITLE} a été partagé avec vous ', N'The payslip associated for the payslip session {SESSION_TITLE} has been shared with you ', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_SHARING_PAYSLIP', N'SHARING_PAYSLIP')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501101, N'65f51079-a03f-4d49-879a-d14fdfd94f7f', N'/rh/sharedDocument', N'Un nouveau document a été partagé avec vous ', N'A new Document has been shared with you', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_SHARING_DOCUMENT', N'SHARING_DOCUMENT')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501102, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/sales/billingSession/ValidateCRA', N'Un email a été envoyé à {EMPLOYEE} pour remplir son CRA de {MONTH}', N'An email was sent to {EMPLOYEE} to fill his timesheet of {MONTH}.', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_TIMESHEET_FILL_REQUEST', N'TIMESHEET_FILL_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501103, N'73b2bfbd-8cfc-4211-b027-629ca2a98e16', N'/sales/billingSession/ValidateCRA', N'Un email a été envoyé à {EMPLOYEE} pour soumettre son CRA de {MONTH}', N'An email was sent to {EMPLOYEE} to submit his timesheet of {MONTH}.', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_TIMESHEET_SUBMISSION_REQUEST', N'TIMESHEET_SUBMISSION_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501104, N'5931328a-4842-4a55-ab4a-4ecc135dc411', N'/sales/billingSession/ValidateCRA', N'Un email a été envoyé aux supérieur hiérarchique de {EMPLOYEE} pour valider le CRA de {MONTH}', N'An email has been sent to {EMPLOYEE} ''s superiors to validate the timesheet of {MONTH}.', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_TIMESHEET_VALIDATION_REQUEST', N'TIMESHEET_VALIDATION_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501105, N'73b2bfbd-8cfc-4211-b027-629ca2a98e16', N'/sales/billingSession/ValidateCRA', N'Un email a été envoyé à {EMPLOYEE} pour corriger son CRA de {MONTH}', N'An email was sent to {EMPLOYEE} to correct his timesheet of {MONTH}.', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_TIMESHEET_CORRECTION_REQUEST', N'TIMESHEET_CORRECTION_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501194, N'cb81ff12-6d18-4566-8f70-8d78e483b9bc', N'/administration/user/Add', N'{INTERVIEW_CREATOR} vous a ajouté en tant qu''intervieweur optionnel pour l''entretien du candidat {CANDIDATE_NAME} le {INTERVIEW_DATE} à {INTERVIEW_TIME}', N'{INTERVIEW_CREATOR} has added you as a optional interviewer to the interview of the candidate {CANDIDATE_NAME} on {INTERVIEW_DATE} at {INTERVIEW_TIME}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_ADD_NEW_USER', N'ADD_NEW_USER')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501195, N'ebe5d62c-129d-42a3-8097-809cd113944f', N'/purchase/purchasefinalorder/show', N'Un bon de commande définitif {CODE} a été validé', N'A final order form {CODE} has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, 1000501196, N'NOTIFICATION_VALIDATE_FINAL_ORDER_FORM', N'PURCHASE_FINAL_ORDER_VALIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501196, N'cc9e11cb-ce75-4b13-9453-87de0759b42a', N'/purchase/purchasefinalorder/add', N'Un bon de commande définitif {CODE} a été ajouté', N'A final order form {CODE} has been added', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_FINAL_ORDER_FORM', N'PURCHASE_FINAL_ORDER_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501197, N'cfe2d3c0-a510-463b-8d36-af09931373bf', N'/stockCorrection/be/add', N'Un bon d''entrée {CODE} a été ajouté', N'An entry voucher{CODE} has been added', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_BE', N'BE_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501198, N'91f6af0a-3880-47e9-a91c-99a2e6b9aa74', N'/stockCorrection/be/show', N'Un bon d''entrée {CODE} a été validé', N'An entry voucher {CODE} has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, 1000501197, N'NOTIFICATION_VALIDATE_BE', N'BE_VALIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501199, N'35b9c1dd-a489-46b2-82b1-dbbe1a60ba46', N'/stockCorrection/bs/add', N'Un bon de sortie {CODE} a été ajouté', N'An exit voucher{CODE} has been added', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_BS', N'BS_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501200, N'85305898-2b4a-4d27-a392-d48415f0184a', N'/stockCorrection/bs/show', N'Un bon de sortie {CODE} a été validé', N'An exit voucher {CODE} has been validated', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 0, 1000501199, N'NOTIFICATION_VALIDATE_BS', N'BS_VALIDATION')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501201, N'3c41d05b-69ec-43f2-897e-8057896e0b62', N'/sales/invoiceasset/add', N'Une facture-avoir  {CODE} a été ajoutée', N'An Invoice-asset {CODE} has been added', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_INVOICE_ASSET', N'INVOICE_ASSET_ADD')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501203, N'd0d08b53-a029-4683-acbc-1e2ab75ea3ad', N'/sales/invoiceasset/show', N'Une facture-avoir  {CODE} a été validé', N'An Invoice-asset {CODE} has been validated', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 0, 1000501201, N'NOTIFICATION_ADD_INVOICE_ASSET', N'INVOICE_ASSET_VALIDATE')
SET IDENTITY_INSERT [ERPSettings].[Information] OFF
SET IDENTITY_INSERT [Shared].[Taxe] ON
INSERT INTO [Shared].[Taxe] ([Id], [Label], [CodeTaxe], [TaxeValue], [IdTaxeType], [IsDeleted], [TransactionUserId], [Deleted_Token], [TaxeType], [IdAccountingAccountSales], [IdAccountingAccountPurchase], [IsCalculable]) VALUES (1, N'TVA0%', N'TVA0%', 0, 1, 0, 0, NULL, 1, NULL, NULL, 1)
INSERT INTO [Shared].[Taxe] ([Id], [Label], [CodeTaxe], [TaxeValue], [IdTaxeType], [IsDeleted], [TransactionUserId], [Deleted_Token], [TaxeType], [IdAccountingAccountSales], [IdAccountingAccountPurchase], [IsCalculable]) VALUES (2, N'TVA10%', N'TVA10%', 10, 1, 0, 0, NULL, 1, NULL, NULL, 1)
INSERT INTO [Shared].[Taxe] ([Id], [Label], [CodeTaxe], [TaxeValue], [IdTaxeType], [IsDeleted], [TransactionUserId], [Deleted_Token], [TaxeType], [IdAccountingAccountSales], [IdAccountingAccountPurchase], [IsCalculable]) VALUES (3, N'TVA12%', N'TVA12%', 12, 1, 0, 0, NULL, 1, NULL, NULL, 1)
INSERT INTO [Shared].[Taxe] ([Id], [Label], [CodeTaxe], [TaxeValue], [IdTaxeType], [IsDeleted], [TransactionUserId], [Deleted_Token], [TaxeType], [IdAccountingAccountSales], [IdAccountingAccountPurchase], [IsCalculable]) VALUES (4, N'TVA5%', N'TVA5%', 5, 1, 0, 0, NULL, 1, NULL, NULL, 1)
INSERT INTO [Shared].[Taxe] ([Id], [Label], [CodeTaxe], [TaxeValue], [IdTaxeType], [IsDeleted], [TransactionUserId], [Deleted_Token], [TaxeType], [IdAccountingAccountSales], [IdAccountingAccountPurchase], [IsCalculable]) VALUES (5, N'TVA18%', N'TVA18%', 18, 1, 0, 0, NULL, 1, NULL, NULL, 1)
INSERT INTO [Shared].[Taxe] ([Id], [Label], [CodeTaxe], [TaxeValue], [IdTaxeType], [IsDeleted], [TransactionUserId], [Deleted_Token], [TaxeType], [IdAccountingAccountSales], [IdAccountingAccountPurchase], [IsCalculable]) VALUES (6, N'TVA20%', N'TVA20%', 20, 1, 0, 0, NULL, 1, NULL, NULL, 1)
INSERT INTO [Shared].[Taxe] ([Id], [Label], [CodeTaxe], [TaxeValue], [IdTaxeType], [IsDeleted], [TransactionUserId], [Deleted_Token], [TaxeType], [IdAccountingAccountSales], [IdAccountingAccountPurchase], [IsCalculable]) VALUES (7, N'TVA19%', N'TVA19%', 19, 1, 0, 0, NULL, 1, NULL, NULL, 1)
INSERT INTO [Shared].[Taxe] ([Id], [Label], [CodeTaxe], [TaxeValue], [IdTaxeType], [IsDeleted], [TransactionUserId], [Deleted_Token], [TaxeType], [IdAccountingAccountSales], [IdAccountingAccountPurchase], [IsCalculable]) VALUES (8, N'TVA7%', N'TVA7%', 7, 1, 0, 0, NULL, 1, NULL, NULL, 1)
SET IDENTITY_INSERT [Shared].[Taxe] OFF
INSERT INTO [Helpdesk].[ClaimType] ([CodeType], [Type], [StockOperation], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [TranslationCode]) VALUES (N'D', N'D', N'IN', N'Defective', 0, 0, NULL, N'DEFECTIVE_CLAIM')
INSERT INTO [Helpdesk].[ClaimType] ([CodeType], [Type], [StockOperation], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [TranslationCode]) VALUES (N'E', N'E', N'T', N'Extra', 0, 0, NULL, N'EXTRA_CLAIM')
INSERT INTO [Helpdesk].[ClaimType] ([CodeType], [Type], [StockOperation], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [TranslationCode]) VALUES (N'M', N'M', N'I', N'Missing', 0, 0, NULL, N'MISSING_CLAIM')

SET IDENTITY_INSERT [ERPSettings].[RequestType] ON
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (1, N'ADD', N'form.html', NULL, 0, NULL)
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (2, N'UPDATE', N'form.html', NULL, 0, NULL)
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (3, N'DELETE', N'form.html', NULL, 0, NULL)
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (4, N'LIST', N'form.html', NULL, 0, NULL)
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (5, N'BACK_TO_LIST', N'form.html', NULL, 0, NULL)
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (6, N'SAVE', N'form.html', NULL, 0, NULL)
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (7, N'CONFIRM', N'form.html', NULL, 0, NULL)
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (8, N'VALIDATE', N'form.html', NULL, 0, NULL)
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9, N'Print', N'form.html', NULL, 0, NULL)
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (10, N'REFRESH', N'form.html', NULL, 0, NULL)
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (11, N'PROVISIONAL_COMMITMENT', N'form.html', NULL, 0, NULL)
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (12, N'Cancel', N'form.html', NULL, 0, NULL)
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (13, N'Generate', N'form.html', NULL, 0, NULL)
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (14, N'Close', N'form.html', NULL, 0, NULL)
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (15, N'Show', N'form.html', NULL, 0, NULL)
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (16, N'AxisManage', N'axis.html', NULL, 0, NULL)
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (17, N'Reporting', N'form.html', NULL, 0, NULL)
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (19, N'IMPORT', N'form.html', NULL, 0, NULL)
INSERT INTO [ERPSettings].[RequestType] ([Id], [RequestName], [RequestFile], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (1021, N'DROPDOWNLIST', N'form.html', NULL, 0, NULL)
SET IDENTITY_INSERT [ERPSettings].[RequestType] OFF
SET IDENTITY_INSERT [Shared].[Country] ON
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (17, N'4', NULL, 0, 0, NULL, N'AF', N'AFG', N'Afghanistan', N'Afghanistan')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (18, N'8', NULL, 0, 0, NULL, N'AL', N'ALB', N'Albania', N'Albanie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (19, N'10', NULL, 0, 0, NULL, N'AQ', N'ATA', N'Antarctica', N'Antarctique')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (20, N'12', NULL, 0, 0, NULL, N'DZ', N'DZA', N'Algeria', N'Algérie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (21, N'16', NULL, 0, 0, NULL, N'AS', N'ASM', N'American Samoa', N'Samoa Américaines')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (22, N'20', NULL, 0, 0, NULL, N'AD', N'AND', N'Andorra', N'Andorre')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (23, N'24', NULL, 0, 0, NULL, N'AO', N'AGO', N'Angola', N'Angola')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (24, N'28', NULL, 0, 0, NULL, N'AG', N'ATG', N'Antigua and Barbuda', N'Antigua-et-Barbuda')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (25, N'31', NULL, 0, 0, NULL, N'AZ', N'AZE', N'Azerbaijan', N'Azerbaïdjan')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (26, N'32', NULL, 0, 0, NULL, N'AR', N'ARG', N'Argentina', N'Argentine')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (27, N'36', NULL, 0, 0, NULL, N'AU', N'AUS', N'Australia', N'Australie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (28, N'40', NULL, 0, 0, NULL, N'AT', N'AUT', N'Austria', N'Autriche')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (29, N'44', NULL, 0, 0, NULL, N'BS', N'BHS', N'Bahamas', N'Bahamas')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (30, N'48', NULL, 0, 0, NULL, N'BH', N'BHR', N'Bahrain', N'Bahreïn')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (31, N'50', NULL, 0, 0, NULL, N'BD', N'BGD', N'Bangladesh', N'Bangladesh')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (32, N'51', NULL, 0, 0, NULL, N'AM', N'ARM', N'Armenia', N'Arménie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (33, N'52', NULL, 0, 0, NULL, N'BB', N'BRB', N'Barbados', N'Barbade')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (34, N'56', NULL, 0, 0, NULL, N'BE', N'BEL', N'Belgium', N'Belgique')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (35, N'60', NULL, 0, 0, NULL, N'BM', N'BMU', N'Bermuda', N'Bermudes')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (36, N'64', NULL, 0, 0, NULL, N'BT', N'BTN', N'Bhutan', N'Bhoutan')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (37, N'68', NULL, 0, 0, NULL, N'BO', N'BOL', N'Bolivia', N'Bolivie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (38, N'70', NULL, 0, 0, NULL, N'BA', N'BIH', N'Bosnia and Herzegovina', N'Bosnie-Herzégovine')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (39, N'72', NULL, 0, 0, NULL, N'BW', N'BWA', N'Botswana', N'Botswana')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (40, N'74', NULL, 0, 0, NULL, N'BV', N'BVT', N'Bouvet Island', N'Île Bouvet')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (41, N'76', NULL, 0, 0, NULL, N'BR', N'BRA', N'Brazil', N'Brésil')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (42, N'84', NULL, 0, 0, NULL, N'BZ', N'BLZ', N'Belize', N'Belize')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (43, N'86', NULL, 0, 0, NULL, N'IO', N'IOT', N'British Indian Ocean Territory', N'Territoire Britannique de l''Océan Indien')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (44, N'90', NULL, 0, 0, NULL, N'SB', N'SLB', N'Solomon Islands', N'Îles Salomon')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (45, N'92', NULL, 0, 0, NULL, N'VG', N'VGB', N'British Virgin Islands', N'Îles Vierges Britanniques')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (46, N'96', NULL, 0, 0, NULL, N'BN', N'BRN', N'Brunei Darussalam', N'Brunéi Darussalam')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (47, N'100', NULL, 0, 0, NULL, N'BG', N'BGR', N'Bulgaria', N'Bulgarie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (48, N'104', NULL, 0, 0, NULL, N'MM', N'MMR', N'Myanmar', N'Myanmar')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (49, N'108', NULL, 0, 0, NULL, N'BI', N'BDI', N'Burundi', N'Burundi')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (50, N'112', NULL, 0, 0, NULL, N'BY', N'BLR', N'Belarus', N'Bélarus')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (51, N'116', NULL, 0, 0, NULL, N'KH', N'KHM', N'Cambodia', N'Cambodge')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (52, N'120', NULL, 0, 0, NULL, N'CM', N'CMR', N'Cameroon', N'Cameroun')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (53, N'124', NULL, 0, 0, NULL, N'CA', N'CAN', N'Canada', N'Canada')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (54, N'132', NULL, 0, 0, NULL, N'CV', N'CPV', N'Cape Verde', N'Cap-vert')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (55, N'136', NULL, 0, 0, NULL, N'KY', N'CYM', N'Cayman Islands', N'Îles Caïmanes')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (56, N'140', NULL, 0, 0, NULL, N'CF', N'CAF', N'Central African', N'République Centrafricaine')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (57, N'144', NULL, 0, 0, NULL, N'LK', N'LKA', N'Sri Lanka', N'Sri Lanka')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (58, N'148', NULL, 0, 0, NULL, N'TD', N'TCD', N'Chad', N'Tchad')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (59, N'152', NULL, 0, 0, NULL, N'CL', N'CHL', N'Chile', N'Chili')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (60, N'156', NULL, 0, 0, NULL, N'CN', N'CHN', N'China', N'Chine')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (61, N'158', NULL, 0, 0, NULL, N'TW', N'TWN', N'Taiwan', N'Taïwan')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (62, N'162', NULL, 0, 0, NULL, N'CX', N'CXR', N'Christmas Island', N'Île Christmas')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (63, N'166', NULL, 0, 0, NULL, N'CC', N'CCK', N'Cocos (Keeling) Islands', N'Îles Cocos (Keeling)')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (64, N'170', NULL, 0, 0, NULL, N'CO', N'COL', N'Colombia', N'Colombie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (65, N'174', NULL, 0, 0, NULL, N'KM', N'COM', N'Comoros', N'Comores')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (66, N'175', NULL, 0, 0, NULL, N'YT', N'MYT', N'Mayotte', N'Mayotte')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (67, N'178', NULL, 0, 0, NULL, N'CG', N'COG', N'Republic of the Congo', N'République du Congo')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (68, N'180', NULL, 0, 0, NULL, N'CD', N'COD', N'The Democratic Republic Of The Congo', N'République Démocratique du Congo')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (69, N'184', NULL, 0, 0, NULL, N'CK', N'COK', N'Cook Islands', N'Îles Cook')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (70, N'188', NULL, 0, 0, NULL, N'CR', N'CRI', N'Costa Rica', N'Costa Rica')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (71, N'191', NULL, 0, 0, NULL, N'HR', N'HRV', N'Croatia', N'Croatie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (72, N'192', NULL, 0, 0, NULL, N'CU', N'CUB', N'Cuba', N'Cuba')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (73, N'196', NULL, 0, 0, NULL, N'CY', N'CYP', N'Cyprus', N'Chypre')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (74, N'203', NULL, 0, 0, NULL, N'CZ', N'CZE', N'Czech Republic', N'République Tchèque')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (75, N'204', NULL, 0, 0, NULL, N'BJ', N'BEN', N'Benin', N'Bénin')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (76, N'208', NULL, 0, 0, NULL, N'DK', N'DNK', N'Denmark', N'Danemark')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (77, N'212', NULL, 0, 0, NULL, N'DM', N'DMA', N'Dominica', N'Dominique')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (78, N'214', NULL, 0, 0, NULL, N'DO', N'DOM', N'Dominican Republic', N'République Dominicaine')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (79, N'218', NULL, 0, 0, NULL, N'EC', N'ECU', N'Ecuador', N'Équateur')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (80, N'222', NULL, 0, 0, NULL, N'SV', N'SLV', N'El Salvador', N'El Salvador')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (81, N'226', NULL, 0, 0, NULL, N'GQ', N'GNQ', N'Equatorial Guinea', N'Guinée Équatoriale')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (82, N'231', NULL, 0, 0, NULL, N'ET', N'ETH', N'Ethiopia', N'Éthiopie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (83, N'232', NULL, 0, 0, NULL, N'ER', N'ERI', N'Eritrea', N'Érythrée')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (84, N'233', NULL, 0, 0, NULL, N'EE', N'EST', N'Estonia', N'Estonie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (85, N'234', NULL, 0, 0, NULL, N'FO', N'FRO', N'Faroe Islands', N'Îles Féroé')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (86, N'238', NULL, 0, 0, NULL, N'FK', N'FLK', N'Falkland Islands', N'Îles (malvinas) Falkland')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (87, N'239', NULL, 0, 0, NULL, N'GS', N'SGS', N'South Georgia and the South Sandwich Islands', N'Géorgie du Sud et les Îles Sandwich du Sud')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (88, N'242', NULL, 0, 0, NULL, N'FJ', N'FJI', N'Fiji', N'Fidji')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (89, N'246', NULL, 0, 0, NULL, N'FI', N'FIN', N'Finland', N'Finlande')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (90, N'248', NULL, 0, 0, NULL, N'AX', N'ALA', N'Åland Islands', N'Îles Åland')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (91, N'250', NULL, 0, 0, NULL, N'FR', N'FRA', N'France', N'France')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (92, N'254', NULL, 0, 0, NULL, N'GF', N'GUF', N'French Guiana', N'Guyane Française')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (93, N'258', NULL, 0, 0, NULL, N'PF', N'PYF', N'French Polynesia', N'Polynésie Française')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (94, N'260', NULL, 0, 0, NULL, N'TF', N'ATF', N'French Southern Territories', N'Terres Australes Françaises')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (95, N'262', NULL, 0, 0, NULL, N'DJ', N'DJI', N'Djibouti', N'Djibouti')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (96, N'266', NULL, 0, 0, NULL, N'GA', N'GAB', N'Gabon', N'Gabon')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (97, N'268', NULL, 0, 0, NULL, N'GE', N'GEO', N'Georgia', N'Géorgie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (98, N'270', NULL, 0, 0, NULL, N'GM', N'GMB', N'Gambia', N'Gambie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (99, N'275', NULL, 0, 0, NULL, N'PS', N'PSE', N'Occupied Palestinian Territory', N'Territoire Palestinien Occupé')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (100, N'276', NULL, 0, 0, NULL, N'DE', N'DEU', N'Germany', N'Allemagne')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (101, N'288', NULL, 0, 0, NULL, N'GH', N'GHA', N'Ghana', N'Ghana')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (102, N'292', NULL, 0, 0, NULL, N'GI', N'GIB', N'Gibraltar', N'Gibraltar')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (103, N'296', NULL, 0, 0, NULL, N'KI', N'KIR', N'Kiribati', N'Kiribati')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (104, N'300', NULL, 0, 0, NULL, N'GR', N'GRC', N'Greece', N'Grèce')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (105, N'304', NULL, 0, 0, NULL, N'GL', N'GRL', N'Greenland', N'Groenland')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (106, N'308', NULL, 0, 0, NULL, N'GD', N'GRD', N'Grenada', N'Grenade')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (107, N'312', NULL, 0, 0, NULL, N'GP', N'GLP', N'Guadeloupe', N'Guadeloupe')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (108, N'316', NULL, 0, 0, NULL, N'GU', N'GUM', N'Guam', N'Guam')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (109, N'320', NULL, 0, 0, NULL, N'GT', N'GTM', N'Guatemala', N'Guatemala')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (110, N'324', NULL, 0, 0, NULL, N'GN', N'GIN', N'Guinea', N'Guinée')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (111, N'328', NULL, 0, 0, NULL, N'GY', N'GUY', N'Guyana', N'Guyana')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (112, N'332', NULL, 0, 0, NULL, N'HT', N'HTI', N'Haiti', N'Haïti')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (113, N'334', NULL, 0, 0, NULL, N'HM', N'HMD', N'Heard Island and McDonald Islands', N'Îles Heard et Mcdonald')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (114, N'336', NULL, 0, 0, NULL, N'VA', N'VAT', N'Vatican City State', N'Saint-Siège (état de la Cité du Vatican)')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (115, N'340', NULL, 0, 0, NULL, N'HN', N'HND', N'Honduras', N'Honduras')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (116, N'344', NULL, 0, 0, NULL, N'HK', N'HKG', N'Hong Kong', N'Hong-Kong')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (117, N'348', NULL, 0, 0, NULL, N'HU', N'HUN', N'Hungary', N'Hongrie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (118, N'352', NULL, 0, 0, NULL, N'IS', N'ISL', N'Iceland', N'Islande')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (119, N'356', NULL, 0, 0, NULL, N'IN', N'IND', N'India', N'Inde')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (120, N'360', NULL, 0, 0, NULL, N'ID', N'IDN', N'Indonesia', N'Indonésie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (121, N'364', NULL, 0, 0, NULL, N'IR', N'IRN', N'Islamic Republic of Iran', N'République Islamique d''Iran')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (122, N'368', NULL, 0, 0, NULL, N'IQ', N'IRQ', N'Iraq', N'Iraq')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (123, N'372', NULL, 0, 0, NULL, N'IE', N'IRL', N'Ireland', N'Irlande')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (124, N'376', NULL, 0, 0, NULL, N'IL', N'ISR', N'Israel', N'Israël')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (125, N'380', NULL, 0, 0, NULL, N'IT', N'ITA', N'Italy', N'Italie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (126, N'384', NULL, 0, 0, NULL, N'CI', N'CIV', N'Côte d''Ivoire', N'Côte d''Ivoire')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (127, N'388', NULL, 0, 0, NULL, N'JM', N'JAM', N'Jamaica', N'Jamaïque')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (128, N'392', NULL, 0, 0, NULL, N'JP', N'JPN', N'Japan', N'Japon')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (129, N'398', NULL, 0, 0, NULL, N'KZ', N'KAZ', N'Kazakhstan', N'Kazakhstan')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (130, N'400', NULL, 0, 0, NULL, N'JO', N'JOR', N'Jordan', N'Jordanie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (131, N'404', NULL, 0, 0, NULL, N'KE', N'KEN', N'Kenya', N'Kenya')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (132, N'408', NULL, 0, 0, NULL, N'KP', N'PRK', N'Democratic People''s Republic of Korea', N'République Populaire Démocratique de Corée')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (133, N'410', NULL, 0, 0, NULL, N'KR', N'KOR', N'Republic of Korea', N'République de Corée')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (134, N'414', NULL, 0, 0, NULL, N'KW', N'KWT', N'Kuwait', N'Koweït')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (135, N'417', NULL, 0, 0, NULL, N'KG', N'KGZ', N'Kyrgyzstan', N'Kirghizistan')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (136, N'418', NULL, 0, 0, NULL, N'LA', N'LAO', N'Lao People''s Democratic Republic', N'République Démocratique Populaire Lao')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (137, N'422', NULL, 0, 0, NULL, N'LB', N'LBN', N'Lebanon', N'Liban')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (138, N'426', NULL, 0, 0, NULL, N'LS', N'LSO', N'Lesotho', N'Lesotho')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (139, N'428', NULL, 0, 0, NULL, N'LV', N'LVA', N'Latvia', N'Lettonie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (140, N'430', NULL, 0, 0, NULL, N'LR', N'LBR', N'Liberia', N'Libéria')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (141, N'434', NULL, 0, 0, NULL, N'LY', N'LBY', N'Libyan Arab Jamahiriya', N'Jamahiriya Arabe Libyenne')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (142, N'438', NULL, 0, 0, NULL, N'LI', N'LIE', N'Liechtenstein', N'Liechtenstein')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (143, N'440', NULL, 0, 0, NULL, N'LT', N'LTU', N'Lithuania', N'Lituanie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (144, N'442', NULL, 0, 0, NULL, N'LU', N'LUX', N'Luxembourg', N'Luxembourg')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (145, N'446', NULL, 0, 0, NULL, N'MO', N'MAC', N'Macao', N'Macao')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (146, N'450', NULL, 0, 0, NULL, N'MG', N'MDG', N'Madagascar', N'Madagascar')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (147, N'454', NULL, 0, 0, NULL, N'MW', N'MWI', N'Malawi', N'Malawi')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (148, N'458', NULL, 0, 0, NULL, N'MY', N'MYS', N'Malaysia', N'Malaisie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (149, N'462', NULL, 0, 0, NULL, N'MV', N'MDV', N'Maldives', N'Maldives')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (150, N'466', NULL, 0, 0, NULL, N'ML', N'MLI', N'Mali', N'Mali')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (151, N'470', NULL, 0, 0, NULL, N'MT', N'MLT', N'Malta', N'Malte')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (152, N'474', NULL, 0, 0, NULL, N'MQ', N'MTQ', N'Martinique', N'Martinique')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (153, N'478', NULL, 0, 0, NULL, N'MR', N'MRT', N'Mauritania', N'Mauritanie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (154, N'480', NULL, 0, 0, NULL, N'MU', N'MUS', N'Mauritius', N'Maurice')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (155, N'484', NULL, 0, 0, NULL, N'MX', N'MEX', N'Mexico', N'Mexique')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (156, N'492', NULL, 0, 0, NULL, N'MC', N'MCO', N'Monaco', N'Monaco')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (157, N'496', NULL, 0, 0, NULL, N'MN', N'MNG', N'Mongolia', N'Mongolie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (158, N'498', NULL, 0, 0, NULL, N'MD', N'MDA', N'Republic of Moldova', N'République de Moldova')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (159, N'500', NULL, 0, 0, NULL, N'MS', N'MSR', N'Montserrat', N'Montserrat')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (160, N'504', NULL, 0, 0, NULL, N'MA', N'MAR', N'Morocco', N'Maroc')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (161, N'508', NULL, 0, 0, NULL, N'MZ', N'MOZ', N'Mozambique', N'Mozambique')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (162, N'512', NULL, 0, 0, NULL, N'OM', N'OMN', N'Oman', N'Oman')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (163, N'516', NULL, 0, 0, NULL, N'NA', N'NAM', N'Namibia', N'Namibie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (164, N'520', NULL, 0, 0, NULL, N'NR', N'NRU', N'Nauru', N'Nauru')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (165, N'524', NULL, 0, 0, NULL, N'NP', N'NPL', N'Nepal', N'Népal')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (166, N'528', NULL, 0, 0, NULL, N'NL', N'NLD', N'Netherlands', N'Pays-Bas')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (167, N'530', NULL, 0, 0, NULL, N'AN', N'ANT', N'Netherlands Antilles', N'Antilles Néerlandaises')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (168, N'533', NULL, 0, 0, NULL, N'AW', N'ABW', N'Aruba', N'Aruba')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (169, N'540', NULL, 0, 0, NULL, N'NC', N'NCL', N'New Caledonia', N'Nouvelle-Calédonie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (170, N'548', NULL, 0, 0, NULL, N'VU', N'VUT', N'Vanuatu', N'Vanuatu')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (171, N'554', NULL, 0, 0, NULL, N'NZ', N'NZL', N'New Zealand', N'Nouvelle-Zélande')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (172, N'558', NULL, 0, 0, NULL, N'NI', N'NIC', N'Nicaragua', N'Nicaragua')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (173, N'562', NULL, 0, 0, NULL, N'NE', N'NER', N'Niger', N'Niger')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (174, N'566', NULL, 0, 0, NULL, N'NG', N'NGA', N'Nigeria', N'Nigéria')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (175, N'570', NULL, 0, 0, NULL, N'NU', N'NIU', N'Niue', N'Niué')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (176, N'574', NULL, 0, 0, NULL, N'NF', N'NFK', N'Norfolk Island', N'Île Norfolk')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (177, N'578', NULL, 0, 0, NULL, N'NO', N'NOR', N'Norway', N'Norvège')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (178, N'580', NULL, 0, 0, NULL, N'MP', N'MNP', N'Northern Mariana Islands', N'Îles Mariannes du Nord')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (179, N'581', NULL, 0, 0, NULL, N'UM', N'UMI', N'United States Minor Outlying Islands', N'Îles Mineures Éloignées des États-Unis')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (180, N'583', NULL, 0, 0, NULL, N'FM', N'FSM', N'Federated States of Micronesia', N'États Fédérés de Micronésie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (181, N'584', NULL, 0, 0, NULL, N'MH', N'MHL', N'Marshall Islands', N'Îles Marshall')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (182, N'585', NULL, 0, 0, NULL, N'PW', N'PLW', N'Palau', N'Palaos')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (183, N'586', NULL, 0, 0, NULL, N'PK', N'PAK', N'Pakistan', N'Pakistan')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (184, N'591', NULL, 0, 0, NULL, N'PA', N'PAN', N'Panama', N'Panama')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (185, N'598', NULL, 0, 0, NULL, N'PG', N'PNG', N'Papua New Guinea', N'Papouasie-Nouvelle-Guinée')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (186, N'600', NULL, 0, 0, NULL, N'PY', N'PRY', N'Paraguay', N'Paraguay')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (187, N'604', NULL, 0, 0, NULL, N'PE', N'PER', N'Peru', N'Pérou')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (188, N'608', NULL, 0, 0, NULL, N'PH', N'PHL', N'Philippines', N'Philippines')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (189, N'612', NULL, 0, 0, NULL, N'PN', N'PCN', N'Pitcairn', N'Pitcairn')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (190, N'616', NULL, 0, 0, NULL, N'PL', N'POL', N'Poland', N'Pologne')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (191, N'620', NULL, 0, 0, NULL, N'PT', N'PRT', N'Portugal', N'Portugal')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (192, N'624', NULL, 0, 0, NULL, N'GW', N'GNB', N'Guinea-Bissau', N'Guinée-Bissau')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (193, N'626', NULL, 0, 0, NULL, N'TL', N'TLS', N'Timor-Leste', N'Timor-Leste')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (194, N'630', NULL, 0, 0, NULL, N'PR', N'PRI', N'Puerto Rico', N'Porto Rico')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (195, N'634', NULL, 0, 0, NULL, N'QA', N'QAT', N'Qatar', N'Qatar')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (196, N'638', NULL, 0, 0, NULL, N'RE', N'REU', N'Réunion', N'Réunion')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (197, N'642', NULL, 0, 0, NULL, N'RO', N'ROU', N'Romania', N'Roumanie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (198, N'643', NULL, 0, 0, NULL, N'RU', N'RUS', N'Russian Federation', N'Fédération de Russie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (199, N'646', NULL, 0, 0, NULL, N'RW', N'RWA', N'Rwanda', N'Rwanda')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (200, N'654', NULL, 0, 0, NULL, N'SH', N'SHN', N'Saint Helena', N'Sainte-Hélène')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (201, N'659', NULL, 0, 0, NULL, N'KN', N'KNA', N'Saint Kitts and Nevis', N'Saint-Kitts-et-Nevis')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (202, N'660', NULL, 0, 0, NULL, N'AI', N'AIA', N'Anguilla', N'Anguilla')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (203, N'662', NULL, 0, 0, NULL, N'LC', N'LCA', N'Saint Lucia', N'Sainte-Lucie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (204, N'666', NULL, 0, 0, NULL, N'PM', N'SPM', N'Saint-Pierre and Miquelon', N'Saint-Pierre-et-Miquelon')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (205, N'670', NULL, 0, 0, NULL, N'VC', N'VCT', N'Saint Vincent and the Grenadines', N'Saint-Vincent-et-les Grenadines')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (206, N'674', NULL, 0, 0, NULL, N'SM', N'SMR', N'San Marino', N'Saint-Marin')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (207, N'678', NULL, 0, 0, NULL, N'ST', N'STP', N'Sao Tome and Principe', N'Sao Tomé-et-Principe')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (208, N'682', NULL, 0, 0, NULL, N'SA', N'SAU', N'Saudi Arabia', N'Arabie Saoudite')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (209, N'686', NULL, 0, 0, NULL, N'SN', N'SEN', N'Senegal', N'Sénégal')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (210, N'690', NULL, 0, 0, NULL, N'SC', N'SYC', N'Seychelles', N'Seychelles')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (211, N'694', NULL, 0, 0, NULL, N'SL', N'SLE', N'Sierra Leone', N'Sierra Leone')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (212, N'702', NULL, 0, 0, NULL, N'SG', N'SGP', N'Singapore', N'Singapour')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (213, N'703', NULL, 0, 0, NULL, N'SK', N'SVK', N'Slovakia', N'Slovaquie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (214, N'704', NULL, 0, 0, NULL, N'VN', N'VNM', N'Vietnam', N'Viet Nam')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (215, N'705', NULL, 0, 0, NULL, N'SI', N'SVN', N'Slovenia', N'Slovénie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (216, N'706', NULL, 0, 0, NULL, N'SO', N'SOM', N'Somalia', N'Somalie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (217, N'710', NULL, 0, 0, NULL, N'ZA', N'ZAF', N'South Africa', N'Afrique du Sud')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (218, N'716', NULL, 0, 0, NULL, N'ZW', N'ZWE', N'Zimbabwe', N'Zimbabwe')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (219, N'724', NULL, 0, 0, NULL, N'ES', N'ESP', N'Spain', N'Espagne')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (220, N'732', NULL, 0, 0, NULL, N'EH', N'ESH', N'Western Sahara', N'Sahara Occidental')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (221, N'736', NULL, 0, 0, NULL, N'SD', N'SDN', N'Sudan', N'Soudan')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (222, N'740', NULL, 0, 0, NULL, N'SR', N'SUR', N'Suriname', N'Suriname')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (223, N'744', NULL, 0, 0, NULL, N'SJ', N'SJM', N'Svalbard and Jan Mayen', N'Svalbard etÎle Jan Mayen')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (224, N'748', NULL, 0, 0, NULL, N'SZ', N'SWZ', N'Swaziland', N'Swaziland')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (225, N'752', NULL, 0, 0, NULL, N'SE', N'SWE', N'Sweden', N'Suède')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (226, N'756', NULL, 0, 0, NULL, N'CH', N'CHE', N'Switzerland', N'Suisse')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (227, N'760', NULL, 0, 0, NULL, N'SY', N'SYR', N'Syrian Arab Republic', N'République Arabe Syrienne')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (228, N'762', NULL, 0, 0, NULL, N'TJ', N'TJK', N'Tajikistan', N'Tadjikistan')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (229, N'764', NULL, 0, 0, NULL, N'TH', N'THA', N'Thailand', N'Thaïlande')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (230, N'768', NULL, 0, 0, NULL, N'TG', N'TGO', N'Togo', N'Togo')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (231, N'772', NULL, 0, 0, NULL, N'TK', N'TKL', N'Tokelau', N'Tokelau')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (232, N'776', NULL, 0, 0, NULL, N'TO', N'TON', N'Tonga', N'Tonga')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (233, N'780', NULL, 0, 0, NULL, N'TT', N'TTO', N'Trinidad and Tobago', N'Trinité-et-Tobago')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (234, N'784', NULL, 0, 0, NULL, N'AE', N'ARE', N'United Arab Emirates', N'Émirats Arabes Unis')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (235, N'788', NULL, 0, 0, NULL, N'TN', N'TUN', N'Tunisia', N'Tunisie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (236, N'792', NULL, 0, 0, NULL, N'TR', N'TUR', N'Turkey', N'Turquie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (237, N'795', NULL, 0, 0, NULL, N'TM', N'TKM', N'Turkmenistan', N'Turkménistan')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (238, N'796', NULL, 0, 0, NULL, N'TC', N'TCA', N'Turks and Caicos Islands', N'Îles Turks et Caïques')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (239, N'798', NULL, 0, 0, NULL, N'TV', N'TUV', N'Tuvalu', N'Tuvalu')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (240, N'800', NULL, 0, 0, NULL, N'UG', N'UGA', N'Uganda', N'Ouganda')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (241, N'804', NULL, 0, 0, NULL, N'UA', N'UKR', N'Ukraine', N'Ukraine')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (242, N'807', NULL, 0, 0, NULL, N'MK', N'MKD', N'The Former Yugoslav Republic of Macedonia', N'L''ex-République Yougoslave de Macédoine')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (243, N'818', NULL, 0, 0, NULL, N'EG', N'EGY', N'Egypt', N'Égypte')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (244, N'826', NULL, 0, 0, NULL, N'GB', N'GBR', N'United Kingdom', N'Royaume-Uni')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (245, N'833', NULL, 0, 0, NULL, N'IM', N'IMN', N'Isle of Man', N'Île de Man')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (246, N'834', NULL, 0, 0, NULL, N'TZ', N'TZA', N'United Republic Of Tanzania', N'République-Unie de Tanzanie')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (247, N'840', NULL, 0, 0, NULL, N'US', N'USA', N'United States', N'États-Unis')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (248, N'850', NULL, 0, 0, NULL, N'VI', N'VIR', N'U.S. Virgin Islands', N'Îles Vierges des États-Unis')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (249, N'854', NULL, 0, 0, NULL, N'BF', N'BFA', N'Burkina Faso', N'Burkina Faso')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (250, N'858', NULL, 0, 0, NULL, N'UY', N'URY', N'Uruguay', N'Uruguay')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (251, N'860', NULL, 0, 0, NULL, N'UZ', N'UZB', N'Uzbekistan', N'Ouzbékistan')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (252, N'862', NULL, 0, 0, NULL, N'VE', N'VEN', N'Venezuela', N'Venezuela')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (253, N'876', NULL, 0, 0, NULL, N'WF', N'WLF', N'Wallis and Futuna', N'Wallis et Futuna')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (254, N'882', NULL, 0, 0, NULL, N'WS', N'WSM', N'Samoa', N'Samoa')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (255, N'887', NULL, 0, 0, NULL, N'YE', N'YEM', N'Yemen', N'Yémen')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (256, N'891', NULL, 0, 0, NULL, N'CS', N'SCG', N'Serbia and Montenegro', N'Serbie-et-Monténégro')
INSERT INTO [Shared].[Country] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token], [Alpha2], [Alpha3], [NameEn], [NameFr]) VALUES (257, N'894', NULL, 0, 0, NULL, N'ZM', N'ZMB', N'Zambia', N'Zambie')
SET IDENTITY_INSERT [Shared].[Country] OFF

SET IDENTITY_INSERT [Shared].[Email] ON
EXEC(N'INSERT INTO [Shared].[Email] ([Id], [Subject], [Body], [Status], [Sender], [Receivers], [AttemptsToSendNumber], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (1, N''Creation de compte Stark-ERP'', N''<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Stark-Erp mail</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="style.css">
    <style>
        .ql-font-serif {
            font-family: Times, "Times New Roman", Georgia, serif;
            font-size: 17px;
        }
    </style>
</head>
<body bgcolor="#FFFFFF" cz-shortcut-listen="true">
    <div id="div-container">
        <p>
            <span class="ql-font-serif">Hello, Hammadi Moalla </span>
        </p>
        <p>
            <span class="ql-font-serif"></span>
        </p>
        <p><br></p>
        <p>
            <span class="ql-font-serif">Nous vous informons de la création avec succées de votre compte STARK-ERP </span>
        </p>
        <p>
            <span class="ql-font-serif"> Identifiant: daf@qualityparts.tn </span>
        </p>
        <p>
            <span class="ql-font-serif"> MOT DE PASSE: <b> 9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8 </b>  </span>
        </p>
        <p><br></p>
        <p>
            <span class="ql-font-serif">Cordialement ,</span>
        </p>
        <p>
            <span class="ql-font-serif">L''''equipe Administrative</span>
        </p>
        <p><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFoAAAAqCAYAAAAzikzDAAAMVUlEQVRoQ+2Ze3QU1RnAv3vv7M7u7Gw2JEBiElAEbBW1VQ9YH7UgLYqtNjWZmWXBKp6qnLZ6bIVqqxwpxeMp4PHI8e2xxfLIzky2ioL4bG1BrVaLlWrREHyQFyEBsruzO897eyawHMAEEosrtJmT/SPZ73V/97vf/b4JgqGnKARQUbwMOYEh0EVKgiHQQ6CLRKBIboYy+ngH3b7slyPElk9O79i8+7Xx69dbRVrPMevmqGc0YwxlflJ3Lc1b82M5+8SOti7phA2bGo9ZAkUK7KiC7r7q0kuw7c4Pm/YF/J48dO7ObQaGays2b95WpPUcs26OCugddVPPJLZ5BzE9ic9aQNI27DadlzI70onx2Y6dx+zqixjYfwV624xzK0p3sluo5f00YnrhbI8JogPQ47grMy3wo/Gw9f++Nhf28nOBbrpxOh/b1HEDdug80WE16bQNYHsQZgjSjC2tbmmaV8RkOS5cDRp0x7lnfB87cKfosLPMnAs52+0FDAwgT9nPa9q33ntcrLzIQQ4YdPvECRO5HNwR8NgV2KaQsV1gDEAEBA5j+Tywa0e3NScHGr8syxdhjKcwxsoxwHaX0hd1XX9noPpHW06WZTkYDF5sWdZjuq6/PRj7nSMmiF7AmkeZ92p1+0cvKIoyLRgI1DmmqSUbG1/2bR0RdPOECaNFl96GPfYjwYNA2nGBUj+BGcQQhjxjnQZ15TEdH/9lIMFJkkQQQsv4YPDHPM8DY6w3CNOywHWcXyc1bcFA7BxtmbgsrxhWVjZrV1fXtWpj4+8HY7+9ctxplRx5r9V1tZqOZkVRlEXlZWW3d+/adaeqqgsPC7pp3DheZOgmwtC8KMMj0o4HDmV7/TMGpZhAjtEtaY9J43Y0/2uggcUlKREWhFWmZRmM0mWYsY89gElcMDjDdd15qqo+OFBbR1NOkeWHI5HIDblsdmZS11cP1jYD8VSAbBsC6JFl+Y6oKP4mm8ncqOr6/f2C9o+CI9hPjURkatr1/Nrr0+398Z8IQkAZrC9rN+sQtOQHE5Qiy7+LRqOzM+n0faqu31zQra2tHTty+/ZPH337bedAe4qinEIAplLGRmKEPtjNcc+uX7Uq3ZfPeDx+FmLsW4iQqOd571JK1+u6bvclO0OSLiQ8f5FjmpvUxsb1fYGWJCkWCATmuK4bYow9qOt6n62qJEnVaUGYyXnelnUrVz6tKMrt4VBoUT6XewEw/jMhJNBn6WirGXPdCBx8dKfr+kAPeggAdGEKm5H3PAVYGfbIhrr2jz4ZKGxZlpdERXGukcu95XmerOv6R/3pKpJ0GyZkQUQQePA3l1K/xGyltj2nUPt83QULFuD333//Xo6Qm4RwGHxZz/N82bcppdeoqrr/xM2cObPEc91HA4GAUlJSAl1dXUlV02b0A3pxeVnZvD27d78eEoSLly9fbvYVqyRJF5bGYhvS6fRLqqZ9JxGP/woTchfGGAKBQK9Kn6Bbq8YuLkdk3k7qHSTgC2cwgx2YgYARcID88pHhELzKAV3rEvLiudu2fXg46H6GIoC/RASh0sjlehDGj4NtP9GQSr17oF5clq8LC8Kj+XyeMUofBow/BEqnhQVhumWaGdt1J6VSqS2+jiRJd5dEo7dls9ksA3gYY7yDUnplNBI5L2sYH2FCJjU0NHT5snJ9vVYSi0mZbLYVY7zK87x1mqb9tQDazGTqVjc2/lFRlFMDhGyiAMiyrLNTqdR7/SaEonyDDwZfNy3rSU3TrlQk6XYhEvEzeh143gu0v4xuqTz5u6WErDUZA/9T2BEbAViYAd7n0b/GCAIIItS7IVlGTQD0Bg907R5wV5+9fXtbX8H1wkZoMcH4++FwGAzDoJTSB8KC8As/a6666qqIZZpbeJ6vdixLTur6/ncliqI8EhXF69OZzGOapl0/e/bsUflcrokQ4mYNY+qaNWve8H1OnjyZq6ioeFqMRKZnstlbNU1brCjKN4Ic97rreS0M4JvJZPLjQnw+aEEQbjByuVsRQs8CwOJe3XR6qdbYeNi5wLd7KGgxGl10xBrtO//0hLGLIgj9LISw4AGDHGNgFYr03vtw77O3he4FTQBBCCPgAUEPoy2Wy6Yf7qKUJGkSR8iPEUJXh0IhMLLZ+1Vdv7Guru7MUCj0T8e239F0/awDN0uSpK8EA4EtrutuVjXtTKW+/nuCKD5j5HIpTdPqD6nv04Rw+PmcYaxRdb1Wqa+/MRqLLUtnMvdomjb3QFlZlh/ig0G/HoN/5P2PbdufBnn+tBUrVhgF2ZYTTp4jYnK1B0Dy1NtY3b7tlh8kEhNLCHmjkNGJeHx+WBAWZrLZuZqm3dNv6SgYba4++ZQIRZd6CH2PAZxfglDEJ5pnzO+dD8B+cN764EcSAjs9qo9q2yofqX4nEonrOUIeMU2zu3PnzsqqESNOx8HgJse231V1/WuHgD6NDwbfcxznn6qmfT0hy5fxgrAuaxhrdF2vPQTeZZFweF0un39W1bTvxu'', 1, N''Demo@spark-it.fr'', N''daf@qualityparts.tn'', 1, 0, 0, NULL)')
UPDATE [Shared].[Email] SET [Body].WRITE(N'PxuRFBWJI1jP1tV0HeBx3i+Tm2bTcBY10I40kIoT2WbZ+XSqWa9oOuHLumOhC4wv+91XVaq9ubR12SSJxdSchbBdC+HzESWZLOZO7WNO1XRwR9YNAdFV8Z42D72xihyxmgbwqAS33Ybm9H/dknijFkGP1HTVvzOQfVXkm6AhNyKWdZ8//w5JPd/nfxePx8jpBXbcfp7uzsrKyoqJiAAd7BhFDqutc2aNoTBRt+vytGo7OymcwDSU37aTwer2KUNgU4jliOc5mu63/yZf3yY1vWM4IgTMnlcs+omnaFLMu3REVxadYwFqqqeudB2b+vvcsbhtKgaZpcX7+kJBab29PTs1ZvbLy8IJsRx440YngSZZTzMHtvVMu2pkNLhyRJ54V4/jXXdVuR40xZnUo1HXFg6SsbWfVXyzcza4YDcE854CDH9paOAnC/hlcSDto8976a9ub9LZxfYRRJ+lPpsGGTe/bs8evkOgZgIYB6URSrsoaxQlXVHyYSiXOo675FOK53oHE9rwEAtgJjU8RI5MK8aXbbjuNfhr2vX+Px+HwhHF6Yz+cdj9LlGKCLAVzO8/zpfqfiOM7AQafTiYZUqqG2trY0xPP/8u8J07IuV1V1bX8n81DQvpxcX7+6JBabkclmu4CxlZ8L9PVVVcMnY+6JcoynlzOEYhRBiO69ECMIg980Zih7zsPcrJrWLb1ZW3iUK6+ciAOB33KBwJRgMNirYzsO2Jb1YoDnZ61YsaJTUZSJGKE3GaXdDIBGIpERfs30WzbLst4xcrk5hUvvgKO/kCPk1nA4HEQIQd40/Unz04ggjDYM4xVV16f4/W15Wdmi7l27lqiq+ouDTtq+ybCnu3v2al1f7n+XkKRrIrHY7zPpdKfH2OmH6aMvjJWUbEhnMi9qmjatcKIc276fEHKNf/8MGvTqmpozhyOusZKQ8dhjwFMEfkYLCIEIGAzmfeAhuPuE1ub9x72vTJBl+QIMcAZDiMOUvt+w78j7sj7oAMe96dj2y5jjZgLAxZTSkQihrT09PS+t7+dfY4m6uvHA8xcwz4t6jP2DMbadECKD532Y1HV/kDibw3iaS+krqqr+7ZB6/u0AIedSgFRDQ0Nv2wgAWKmvvw4IqQCAVaqqNve1FkmSKgOEzKIA/04mk+sO2sC9Q9SkQYF+snr01HJCkiMRHs72Qfb3KoYxZCndxRi7N2OhZeN3be1zcuvv6B369wNAb1B1/aKB6h3LcgMG/dLoMbNiCD02DFCIuQA8AyhFGExGPZeh5TZ17jppxyf9TnmDgeC3feFQ6A3TNF/XdP38wegeq7IDAr3xxDHzSgEvFigAeHsB+xeexdhzrst+U93Z/NrRXKAkSefwweBGx3E2+iPt0bT9Zdk6Iui/jz753uEI3wwe633BL6LeMrEZMfTrivam1BcR+PTp03lRFEcRQnLJZLLP6fKL8PtF2uwXtFZTE/4qCT4+HMgMcBmUIAwGpR0UeUtd5Dw4qmVwb+2+yEUcD7b7BP3mSSdVRilZXQFkCkcBDEYtQuEhy8ZLR3V/2Ho8LOxYi/EzoN8dPXoYTwMbx+HAabs8DxxGn2KAFla3bd10rAV/PMXzGdAfVJ0yPMi8jRGEDIronZWt2/qdiI6nhX7ZsfZZOlhVlfBK2yn2FHjF/bID/F/xf8Su439loV/2OoZAF2kHhkAPgS4SgSK5GcroIdBFIlAkN0MZXSTQ/wH1VATRX8vzXAAAAABJRU5ErkJggg=="></p>
    </div>
</body>
</html>',NULL,NULL) WHERE [Id]=1
EXEC(N'INSERT INTO [Shared].[Email] ([Id], [Subject], [Body], [Status], [Sender], [Receivers], [AttemptsToSendNumber], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (2, N''Creation de compte Stark-ERP'', N''<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Stark-Erp mail</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="style.css">
    <style>
        .ql-font-serif {
            font-family: Times, "Times New Roman", Georgia, serif;
            font-size: 17px;
        }
    </style>
</head>
<body bgcolor="#FFFFFF" cz-shortcut-listen="true">
    <div id="div-container">
        <p>
            <span class="ql-font-serif">Hello, demo Dem </span>
        </p>
        <p>
            <span class="ql-font-serif"></span>
        </p>
        <p><br></p>
        <p>
            <span class="ql-font-serif">Nous vous informons de la création avec succées de votre compte STARK-ERP </span>
        </p>
        <p>
            <span class="ql-font-serif"> Identifiant: demo@spark-it.tn </span>
        </p>
        <p>
            <span class="ql-font-serif"> MOT DE PASSE: <b> 9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8 </b>  </span>
        </p>
        <p><br></p>
        <p>
            <span class="ql-font-serif">Cordialement ,</span>
        </p>
        <p>
            <span class="ql-font-serif">L''''equipe Administrative</span>
        </p>
        <p><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFoAAAAqCAYAAAAzikzDAAAMVUlEQVRoQ+2Ze3QU1RnAv3vv7M7u7Gw2JEBiElAEbBW1VQ9YH7UgLYqtNjWZmWXBKp6qnLZ6bIVqqxwpxeMp4PHI8e2xxfLIzky2ioL4bG1BrVaLlWrREHyQFyEBsruzO897eyawHMAEEosrtJmT/SPZ73V/97vf/b4JgqGnKARQUbwMOYEh0EVKgiHQQ6CLRKBIboYy+ngH3b7slyPElk9O79i8+7Xx69dbRVrPMevmqGc0YwxlflJ3Lc1b82M5+8SOti7phA2bGo9ZAkUK7KiC7r7q0kuw7c4Pm/YF/J48dO7ObQaGays2b95WpPUcs26OCugddVPPJLZ5BzE9ic9aQNI27DadlzI70onx2Y6dx+zqixjYfwV624xzK0p3sluo5f00YnrhbI8JogPQ47grMy3wo/Gw9f++Nhf28nOBbrpxOh/b1HEDdug80WE16bQNYHsQZgjSjC2tbmmaV8RkOS5cDRp0x7lnfB87cKfosLPMnAs52+0FDAwgT9nPa9q33ntcrLzIQQ4YdPvECRO5HNwR8NgV2KaQsV1gDEAEBA5j+Tywa0e3NScHGr8syxdhjKcwxsoxwHaX0hd1XX9noPpHW06WZTkYDF5sWdZjuq6/PRj7nSMmiF7AmkeZ92p1+0cvKIoyLRgI1DmmqSUbG1/2bR0RdPOECaNFl96GPfYjwYNA2nGBUj+BGcQQhjxjnQZ15TEdH/9lIMFJkkQQQsv4YPDHPM8DY6w3CNOywHWcXyc1bcFA7BxtmbgsrxhWVjZrV1fXtWpj4+8HY7+9ctxplRx5r9V1tZqOZkVRlEXlZWW3d+/adaeqqgsPC7pp3DheZOgmwtC8KMMj0o4HDmV7/TMGpZhAjtEtaY9J43Y0/2uggcUlKREWhFWmZRmM0mWYsY89gElcMDjDdd15qqo+OFBbR1NOkeWHI5HIDblsdmZS11cP1jYD8VSAbBsC6JFl+Y6oKP4mm8ncqOr6/f2C9o+CI9hPjURkatr1/Nrr0+398Z8IQkAZrC9rN+sQtOQHE5Qiy7+LRqOzM+n0faqu31zQra2tHTty+/ZPH337bedAe4qinEIAplLGRmKEPtjNcc+uX7Uq3ZfPeDx+FmLsW4iQqOd571JK1+u6bvclO0OSLiQ8f5FjmpvUxsb1fYGWJCkWCATmuK4bYow9qOt6n62qJEnVaUGYyXnelnUrVz6tKMrt4VBoUT6XewEw/jMhJNBn6WirGXPdCBx8dKfr+kAPeggAdGEKm5H3PAVYGfbIhrr2jz4ZKGxZlpdERXGukcu95XmerOv6R/3pKpJ0GyZkQUQQePA3l1K/xGyltj2nUPt83QULFuD333//Xo6Qm4RwGHxZz/N82bcppdeoqrr/xM2cObPEc91HA4GAUlJSAl1dXUlV02b0A3pxeVnZvD27d78eEoSLly9fbvYVqyRJF5bGYhvS6fRLqqZ9JxGP/woTchfGGAKBQK9Kn6Bbq8YuLkdk3k7qHSTgC2cwgx2YgYARcID88pHhELzKAV3rEvLiudu2fXg46H6GIoC/RASh0sjlehDGj4NtP9GQSr17oF5clq8LC8Kj+XyeMUofBow/BEqnhQVhumWaGdt1J6VSqS2+jiRJd5dEo7dls9ksA3gYY7yDUnplNBI5L2sYH2FCJjU0NHT5snJ9vVYSi0mZbLYVY7zK87x1mqb9tQDazGTqVjc2/lFRlFMDhGyiAMiyrLNTqdR7/SaEonyDDwZfNy3rSU3TrlQk6XYhEvEzeh143gu0v4xuqTz5u6WErDUZA/9T2BEbAViYAd7n0b/GCAIIItS7IVlGTQD0Bg907R5wV5+9fXtbX8H1wkZoMcH4++FwGAzDoJTSB8KC8As/a6666qqIZZpbeJ6vdixLTur6/ncliqI8EhXF69OZzGOapl0/e/bsUflcrokQ4mYNY+qaNWve8H1OnjyZq6ioeFqMRKZnstlbNU1brCjKN4Ic97rreS0M4JvJZPLjQnw+aEEQbjByuVsRQs8CwOJe3XR6qdbYeNi5wLd7KGgxGl10xBrtO//0hLGLIgj9LISw4AGDHGNgFYr03vtw77O3he4FTQBBCCPgAUEPoy2Wy6Yf7qKUJGkSR8iPEUJXh0IhMLLZ+1Vdv7Guru7MUCj0T8e239F0/awDN0uSpK8EA4EtrutuVjXtTKW+/nuCKD5j5HIpTdPqD6nv04Rw+PmcYaxRdb1Wqa+/MRqLLUtnMvdomjb3QFlZlh/ig0G/HoN/5P2PbdufBnn+tBUrVhgF2ZYTTp4jYnK1B0Dy1NtY3b7tlh8kEhNLCHmjkNGJeHx+WBAWZrLZuZqm3dNv6SgYba4++ZQIRZd6CH2PAZxfglDEJ5pnzO+dD8B+cN764EcSAjs9qo9q2yofqX4nEonrOUIeMU2zu3PnzsqqESNOx8HgJse231V1/WuHgD6NDwbfcxznn6qmfT0hy5fxgrAuaxhrdF2vPQTeZZFweF0un39W1bTvxuPxuRFBWJI'', 1, N''Demo@spark-it.fr'', N''demo@spark-it.tn'', 1, 0, 0, NULL)')
UPDATE [Shared].[Email] SET [Body].WRITE(N'1jP1tV0HeBx3i+Tm2bTcBY10I40kIoT2WbZ+XSqWa9oOuHLumOhC4wv+91XVaq9ubR12SSJxdSchbBdC+HzESWZLOZO7WNO1XRwR9YNAdFV8Z42D72xihyxmgbwqAS33Ybm9H/dknijFkGP1HTVvzOQfVXkm6AhNyKWdZ8//w5JPd/nfxePx8jpBXbcfp7uzsrKyoqJiAAd7BhFDqutc2aNoTBRt+vytGo7OymcwDSU37aTwer2KUNgU4jliOc5mu63/yZf3yY1vWM4IgTMnlcs+omnaFLMu3REVxadYwFqqqeudB2b+vvcsbhtKgaZpcX7+kJBab29PTs1ZvbLy8IJsRx440YngSZZTzMHtvVMu2pkNLhyRJ54V4/jXXdVuR40xZnUo1HXFg6SsbWfVXyzcza4YDcE854CDH9paOAnC/hlcSDto8976a9ub9LZxfYRRJ+lPpsGGTe/bs8evkOgZgIYB6URSrsoaxQlXVHyYSiXOo675FOK53oHE9rwEAtgJjU8RI5MK8aXbbjuNfhr2vX+Px+HwhHF6Yz+cdj9LlGKCLAVzO8/zpfqfiOM7AQafTiYZUqqG2trY0xPP/8u8J07IuV1V1bX8n81DQvpxcX7+6JBabkclmu4CxlZ8L9PVVVcMnY+6JcoynlzOEYhRBiO69ECMIg980Zih7zsPcrJrWLb1ZW3iUK6+ciAOB33KBwJRgMNirYzsO2Jb1YoDnZ61YsaJTUZSJGKE3GaXdDIBGIpERfs30WzbLst4xcrk5hUvvgKO/kCPk1nA4HEQIQd40/Unz04ggjDYM4xVV16f4/W15Wdmi7l27lqiq+ouDTtq+ybCnu3v2al1f7n+XkKRrIrHY7zPpdKfH2OmH6aMvjJWUbEhnMi9qmjatcKIc276fEHKNf/8MGvTqmpozhyOusZKQ8dhjwFMEfkYLCIEIGAzmfeAhuPuE1ub9x72vTJBl+QIMcAZDiMOUvt+w78j7sj7oAMe96dj2y5jjZgLAxZTSkQihrT09PS+t7+dfY4m6uvHA8xcwz4t6jP2DMbadECKD532Y1HV/kDibw3iaS+krqqr+7ZB6/u0AIedSgFRDQ0Nv2wgAWKmvvw4IqQCAVaqqNve1FkmSKgOEzKIA/04mk+sO2sC9Q9SkQYF+snr01HJCkiMRHs72Qfb3KoYxZCndxRi7N2OhZeN3be1zcuvv6B369wNAb1B1/aKB6h3LcgMG/dLoMbNiCD02DFCIuQA8AyhFGExGPZeh5TZ17jppxyf9TnmDgeC3feFQ6A3TNF/XdP38wegeq7IDAr3xxDHzSgEvFigAeHsB+xeexdhzrst+U93Z/NrRXKAkSefwweBGx3E2+iPt0bT9Zdk6Iui/jz753uEI3wwe633BL6LeMrEZMfTrivam1BcR+PTp03lRFEcRQnLJZLLP6fKL8PtF2uwXtFZTE/4qCT4+HMgMcBmUIAwGpR0UeUtd5Dw4qmVwb+2+yEUcD7b7BP3mSSdVRilZXQFkCkcBDEYtQuEhy8ZLR3V/2Ho8LOxYi/EzoN8dPXoYTwMbx+HAabs8DxxGn2KAFla3bd10rAV/PMXzGdAfVJ0yPMi8jRGEDIronZWt2/qdiI6nhX7ZsfZZOlhVlfBK2yn2FHjF/bID/F/xf8Su439loV/2OoZAF2kHhkAPgS4SgSK5GcroIdBFIlAkN0MZXSTQ/wH1VATRX8vzXAAAAABJRU5ErkJggg=="></p>
    </div>
</body>
</html>',NULL,NULL) WHERE [Id]=2
EXEC(N'INSERT INTO [Shared].[Email] ([Id], [Subject], [Body], [Status], [Sender], [Receivers], [AttemptsToSendNumber], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (3, N''Creation de compte Stark-ERP'', N''<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Stark-Erp mail</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="style.css">
    <style>
        .ql-font-serif {
            font-family: Times, "Times New Roman", Georgia, serif;
            font-size: 17px;
        }
    </style>
</head>
<body bgcolor="#FFFFFF" cz-shortcut-listen="true">
    <div id="div-container">
        <p>
            <span class="ql-font-serif">Hello, Admin1 A </span>
        </p>
        <p>
            <span class="ql-font-serif"></span>
        </p>
        <p><br></p>
        <p>
            <span class="ql-font-serif">Nous vous informons de la création avec succées de votre compte STARK-ERP </span>
        </p>
        <p>
            <span class="ql-font-serif"> Identifiant: demo@spark-it.tn </span>
        </p>
        <p>
            <span class="ql-font-serif"> MOT DE PASSE: <b> 9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8 </b>  </span>
        </p>
        <p><br></p>
        <p>
            <span class="ql-font-serif">Cordialement ,</span>
        </p>
        <p>
            <span class="ql-font-serif">L''''equipe Administrative</span>
        </p>
        <p><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFoAAAAqCAYAAAAzikzDAAAMVUlEQVRoQ+2Ze3QU1RnAv3vv7M7u7Gw2JEBiElAEbBW1VQ9YH7UgLYqtNjWZmWXBKp6qnLZ6bIVqqxwpxeMp4PHI8e2xxfLIzky2ioL4bG1BrVaLlWrREHyQFyEBsruzO897eyawHMAEEosrtJmT/SPZ73V/97vf/b4JgqGnKARQUbwMOYEh0EVKgiHQQ6CLRKBIboYy+ngH3b7slyPElk9O79i8+7Xx69dbRVrPMevmqGc0YwxlflJ3Lc1b82M5+8SOti7phA2bGo9ZAkUK7KiC7r7q0kuw7c4Pm/YF/J48dO7ObQaGays2b95WpPUcs26OCugddVPPJLZ5BzE9ic9aQNI27DadlzI70onx2Y6dx+zqixjYfwV624xzK0p3sluo5f00YnrhbI8JogPQ47grMy3wo/Gw9f++Nhf28nOBbrpxOh/b1HEDdug80WE16bQNYHsQZgjSjC2tbmmaV8RkOS5cDRp0x7lnfB87cKfosLPMnAs52+0FDAwgT9nPa9q33ntcrLzIQQ4YdPvECRO5HNwR8NgV2KaQsV1gDEAEBA5j+Tywa0e3NScHGr8syxdhjKcwxsoxwHaX0hd1XX9noPpHW06WZTkYDF5sWdZjuq6/PRj7nSMmiF7AmkeZ92p1+0cvKIoyLRgI1DmmqSUbG1/2bR0RdPOECaNFl96GPfYjwYNA2nGBUj+BGcQQhjxjnQZ15TEdH/9lIMFJkkQQQsv4YPDHPM8DY6w3CNOywHWcXyc1bcFA7BxtmbgsrxhWVjZrV1fXtWpj4+8HY7+9ctxplRx5r9V1tZqOZkVRlEXlZWW3d+/adaeqqgsPC7pp3DheZOgmwtC8KMMj0o4HDmV7/TMGpZhAjtEtaY9J43Y0/2uggcUlKREWhFWmZRmM0mWYsY89gElcMDjDdd15qqo+OFBbR1NOkeWHI5HIDblsdmZS11cP1jYD8VSAbBsC6JFl+Y6oKP4mm8ncqOr6/f2C9o+CI9hPjURkatr1/Nrr0+398Z8IQkAZrC9rN+sQtOQHE5Qiy7+LRqOzM+n0faqu31zQra2tHTty+/ZPH337bedAe4qinEIAplLGRmKEPtjNcc+uX7Uq3ZfPeDx+FmLsW4iQqOd571JK1+u6bvclO0OSLiQ8f5FjmpvUxsb1fYGWJCkWCATmuK4bYow9qOt6n62qJEnVaUGYyXnelnUrVz6tKMrt4VBoUT6XewEw/jMhJNBn6WirGXPdCBx8dKfr+kAPeggAdGEKm5H3PAVYGfbIhrr2jz4ZKGxZlpdERXGukcu95XmerOv6R/3pKpJ0GyZkQUQQePA3l1K/xGyltj2nUPt83QULFuD333//Xo6Qm4RwGHxZz/N82bcppdeoqrr/xM2cObPEc91HA4GAUlJSAl1dXUlV02b0A3pxeVnZvD27d78eEoSLly9fbvYVqyRJF5bGYhvS6fRLqqZ9JxGP/woTchfGGAKBQK9Kn6Bbq8YuLkdk3k7qHSTgC2cwgx2YgYARcID88pHhELzKAV3rEvLiudu2fXg46H6GIoC/RASh0sjlehDGj4NtP9GQSr17oF5clq8LC8Kj+XyeMUofBow/BEqnhQVhumWaGdt1J6VSqS2+jiRJd5dEo7dls9ksA3gYY7yDUnplNBI5L2sYH2FCJjU0NHT5snJ9vVYSi0mZbLYVY7zK87x1mqb9tQDazGTqVjc2/lFRlFMDhGyiAMiyrLNTqdR7/SaEonyDDwZfNy3rSU3TrlQk6XYhEvEzeh143gu0v4xuqTz5u6WErDUZA/9T2BEbAViYAd7n0b/GCAIIItS7IVlGTQD0Bg907R5wV5+9fXtbX8H1wkZoMcH4++FwGAzDoJTSB8KC8As/a6666qqIZZpbeJ6vdixLTur6/ncliqI8EhXF69OZzGOapl0/e/bsUflcrokQ4mYNY+qaNWve8H1OnjyZq6ioeFqMRKZnstlbNU1brCjKN4Ic97rreS0M4JvJZPLjQnw+aEEQbjByuVsRQs8CwOJe3XR6qdbYeNi5wLd7KGgxGl10xBrtO//0hLGLIgj9LISw4AGDHGNgFYr03vtw77O3he4FTQBBCCPgAUEPoy2Wy6Yf7qKUJGkSR8iPEUJXh0IhMLLZ+1Vdv7Guru7MUCj0T8e239F0/awDN0uSpK8EA4EtrutuVjXtTKW+/nuCKD5j5HIpTdPqD6nv04Rw+PmcYaxRdb1Wqa+/MRqLLUtnMvdomjb3QFlZlh/ig0G/HoN/5P2PbdufBnn+tBUrVhgF2ZYTTp4jYnK1B0Dy1NtY3b7tlh8kEhNLCHmjkNGJeHx+WBAWZrLZuZqm3dNv6SgYba4++ZQIRZd6CH2PAZxfglDEJ5pnzO+dD8B+cN764EcSAjs9qo9q2yofqX4nEonrOUIeMU2zu3PnzsqqESNOx8HgJse231V1/WuHgD6NDwbfcxznn6qmfT0hy5fxgrAuaxhrdF2vPQTeZZFweF0un39W1bTvxuPxuRFBWJI'', 1, N''Demo@spark-it.fr'', N''demo@spark-it.tn'', 1, 0, 0, NULL)')
UPDATE [Shared].[Email] SET [Body].WRITE(N'1jP1tV0HeBx3i+Tm2bTcBY10I40kIoT2WbZ+XSqWa9oOuHLumOhC4wv+91XVaq9ubR12SSJxdSchbBdC+HzESWZLOZO7WNO1XRwR9YNAdFV8Z42D72xihyxmgbwqAS33Ybm9H/dknijFkGP1HTVvzOQfVXkm6AhNyKWdZ8//w5JPd/nfxePx8jpBXbcfp7uzsrKyoqJiAAd7BhFDqutc2aNoTBRt+vytGo7OymcwDSU37aTwer2KUNgU4jliOc5mu63/yZf3yY1vWM4IgTMnlcs+omnaFLMu3REVxadYwFqqqeudB2b+vvcsbhtKgaZpcX7+kJBab29PTs1ZvbLy8IJsRx440YngSZZTzMHtvVMu2pkNLhyRJ54V4/jXXdVuR40xZnUo1HXFg6SsbWfVXyzcza4YDcE854CDH9paOAnC/hlcSDto8976a9ub9LZxfYRRJ+lPpsGGTe/bs8evkOgZgIYB6URSrsoaxQlXVHyYSiXOo675FOK53oHE9rwEAtgJjU8RI5MK8aXbbjuNfhr2vX+Px+HwhHF6Yz+cdj9LlGKCLAVzO8/zpfqfiOM7AQafTiYZUqqG2trY0xPP/8u8J07IuV1V1bX8n81DQvpxcX7+6JBabkclmu4CxlZ8L9PVVVcMnY+6JcoynlzOEYhRBiO69ECMIg980Zih7zsPcrJrWLb1ZW3iUK6+ciAOB33KBwJRgMNirYzsO2Jb1YoDnZ61YsaJTUZSJGKE3GaXdDIBGIpERfs30WzbLst4xcrk5hUvvgKO/kCPk1nA4HEQIQd40/Unz04ggjDYM4xVV16f4/W15Wdmi7l27lqiq+ouDTtq+ybCnu3v2al1f7n+XkKRrIrHY7zPpdKfH2OmH6aMvjJWUbEhnMi9qmjatcKIc276fEHKNf/8MGvTqmpozhyOusZKQ8dhjwFMEfkYLCIEIGAzmfeAhuPuE1ub9x72vTJBl+QIMcAZDiMOUvt+w78j7sj7oAMe96dj2y5jjZgLAxZTSkQihrT09PS+t7+dfY4m6uvHA8xcwz4t6jP2DMbadECKD532Y1HV/kDibw3iaS+krqqr+7ZB6/u0AIedSgFRDQ0Nv2wgAWKmvvw4IqQCAVaqqNve1FkmSKgOEzKIA/04mk+sO2sC9Q9SkQYF+snr01HJCkiMRHs72Qfb3KoYxZCndxRi7N2OhZeN3be1zcuvv6B369wNAb1B1/aKB6h3LcgMG/dLoMbNiCD02DFCIuQA8AyhFGExGPZeh5TZ17jppxyf9TnmDgeC3feFQ6A3TNF/XdP38wegeq7IDAr3xxDHzSgEvFigAeHsB+xeexdhzrst+U93Z/NrRXKAkSefwweBGx3E2+iPt0bT9Zdk6Iui/jz753uEI3wwe633BL6LeMrEZMfTrivam1BcR+PTp03lRFEcRQnLJZLLP6fKL8PtF2uwXtFZTE/4qCT4+HMgMcBmUIAwGpR0UeUtd5Dw4qmVwb+2+yEUcD7b7BP3mSSdVRilZXQFkCkcBDEYtQuEhy8ZLR3V/2Ho8LOxYi/EzoN8dPXoYTwMbx+HAabs8DxxGn2KAFla3bd10rAV/PMXzGdAfVJ0yPMi8jRGEDIronZWt2/qdiI6nhX7ZsfZZOlhVlfBK2yn2FHjF/bID/F/xf8Su439loV/2OoZAF2kHhkAPgS4SgSK5GcroIdBFIlAkN0MZXSTQ/wH1VATRX8vzXAAAAABJRU5ErkJggg=="></p>
    </div>
</body>
</html>',NULL,NULL) WHERE [Id]=3
SET IDENTITY_INSERT [Shared].[Email] OFF
SET IDENTITY_INSERT [Shared].[Company] ON
INSERT INTO [Shared].[Company] ([Id], [Code], [MatriculeFisc], [Name], [Description], [CommercialRegister], [TaxIdentNumber], [Picture], [Email], [WebSite], [SIRET], [IsDeleted], [TransactionUserId], [Tel1], [Tel2], [Fax], [FiscalStamp], [NIC], [IdNAF], [Capital], [PaymentOffset], [IdATRate], [HeuRef], [RegularisationMode], [IdCurrency], [Culture], [Deleted_Token], [AttachmentUrl], [DataLogoCompany], [VatNumber], [CnssAffiliation],  [WithholdingTax])
VALUES (2, @codecompany, N'16000000AAA000', N'Demo', N'Demo', N'BBBBBBBBBB', N'2545414', NULL, N'demo', N'www.aaaaaaaa.tn', NULL, 0, 0, N'(+331) 84204500000', N'', N'(+456)     4654564', NULL, NULL, NULL, 1245487984, NULL, NULL, NULL, NULL, 2, N'fr', NULL, NULL, NULL, N'1603422', N'0000000-00', 1)
SET IDENTITY_INSERT [Shared].[Company] OFF
SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (1, N'accounting', N'AccountingAccount', N'AccountingAccount', NULL, 0, N'Compte comptable', N'AccountingAccount_AR', N'Accounting account', N'AccountingAccount_DE', N'AccountingAccount_CH', N'AccountingAccount_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (7, N'Administration', N'Currency', N'Currency', NULL, 0, N'Devise', N'Currency_AR', N'Currency', N'Currency_DE', N'Currency_CH', N'Currency_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (25, N'Immobilisation', N'Amortization', N'Amortization', NULL, 0, N'Amortissement', N'Amortization_AR', N'Amortization', N'Amortization_DE', N'Amortization_CH', N'Amortization_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (26, N'Immobilisation', N'AmortizationMethod', N'AmortizationMethod', NULL, 0, N'Méthode d''amortissement', N'AmortizationMethod_AR', N'Amortization method', N'AmortizationMethod_DE', N'AmortizationMethod_CH', N'AmortizationMethod_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (27, N'Immobilisation', N'AmortizationPost', N'AmortizationPost', NULL, 0, N'Poste d''amortissement', N'AmortizationPost_AR', N'Amortization post', N'AmortizationPost_DE', N'AmortizationPost_CH', N'AmortizationPost_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (28, N'Immobilisation', N'CalculationMethod', N'CalculationMethod', NULL, 0, N'Méthode de calcul', N'CalculationMethod_AR', N'Calculation method', N'CalculationMethod_DE', N'CalculationMethod_CH', N'CalculationMethod_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (29, N'Immobilisation', N'Immobilisation', N'Immobilisation', NULL, 0, N'Immobilisation', N'Immobilisation_AR', N'Immobilization', N'Immobilisation_DE', N'Immobilisation_CH', N'Immobilisation_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (30, N'Payment', N'DocumentPayment', N'DocumentPayment', NULL, 0, N'Document de Paiement', N'DocumentPayment_AR', N'Document payment_EN', N'DocumentPayment_DE', N'DocumentPayment_CH', N'DocumentPayment_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (31, N'Payment', N'Payment', N'Payment', NULL, 0, N'Paiement', N'Payment_AR', N'Payment', N'Payment_DE', N'Payment_CH', N'Payment_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (32, N'Payment', N'PaymentCondition', N'PaymentCondition', NULL, 0, N'Condition de Paiement', N'PaymentCondition_AR', N'Payment condition', N'PaymentCondition_DE', N'PaymentCondition_CH', N'PaymentCondition_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (33, N'Payment', N'PaymentMethod', N'PaymentMethod', NULL, 0, N'Méthode de calcul', N'PaymentMethod_AR', N'Payment method', N'PaymentMethod_DE', N'PaymentMethod_CH', N'PaymentMethod_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (34, N'Payment', N'PaymentType', N'PaymentType', NULL, 0, N'Type de paiement', N'PaymentType_AR', N'Payment type', N'PaymentType_DE', N'PaymentType_CH', N'PaymentType_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (35, N'Payment', N'WithholdingTax', N'WithholdingTax', NULL, 0, N'Retenue d''impôt', N'WithholdingTax_AR', N'Withholding tax', N'WithholdingTax_DE', N'WithholdingTax_CH', N'WithholdingTax_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (36, N'Payment', N'WithholdingTaxLine', N'WithholdingTaxLine', NULL, 0, N'Ligne de retenue d''impôt', N'WithholdingTaxLine_AR', N'Withholding Tax-Line', N'WithholdingTaxLine_DE', N'WithholdingTaxLine_CH', N'WithholdingTaxLine_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (86, N'Sales', N'CategoryTiers', N'CategoryTiers', NULL, 0, N'Catégorie de tiers', N'CategoryTiers_AR', N'CategoryTiers', N'CategoryTiers_DE', N'CategoryTiers_CH', N'CategoryTiers_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (87, N'Sales', N'Document', N'Document', NULL, 0, N'Document', N'Document_AR', N'Document', N'Document_DE', N'Document_CH', N'Document_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (88, N'Sales', N'DocumentCategory', N'DocumentCategory', NULL, 0, N'Catégorie de document', N'DocumentCategory_AR', N'Document category', N'DocumentCategory_DE', N'DocumentCategory_CH', N'DocumentCategory_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (89, N'Sales', N'DocumentConfiguration', N'DocumentConfiguration', NULL, 0, N'Configuration de document', N'DocumentConfiguration_AR', N'Document configuration', N'DocumentConfiguration_DE', N'DocumentConfiguration_CH', N'DocumentConfiguration_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (90, N'Sales', N'DocumentLine', N'DocumentLine', NULL, 0, N'Ligne document', N'DocumentLine_AR', N'Document line', N'DocumentLine_DE', N'DocumentLine_CH', N'DocumentLine_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (91, N'Sales', N'DocumentLineSerialNumber', N'DocumentLineSerialNumber', NULL, 0, N'Numéro de serie ligne document', N'DocumentLineSerialNumber_AR', N'Document-Line serialNumber', N'DocumentLineSerialNumber_DE', N'DocumentLineSerialNumber_CH', N'DocumentLineSerialNumber_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (92, N'Sales', N'DocumentLineTaxe', N'DocumentLineTaxe', NULL, 0, N'Taxe ligne document', N'DocumentLineTaxe_AR', N'DocumentLine tax', N'DocumentLineTaxe_DE', N'DocumentLineTaxe_CH', N'DocumentLineTaxe_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (93, N'Sales', N'PriceByTiers', N'PriceByTiers', NULL, 0, N'Prix par tiers', N'PriceByTiers_AR', N'Price by tiers', N'PriceByTiers_DE', N'PriceByTiers_CH', N'PriceByTiers_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (94, N'Sales', N'TaxeGroupTiersConfig', N'TaxeGroupTiersConfig', NULL, 0, N'Configuration de groupe de taxe par tiers', N'TaxeGroupTiersConfig_AR', N'Tiers tax group configuration', N'TaxeGroupTiersConfig_DE', N'TaxeGroupTiersConfig_CH', N'TaxeGroupTiersConfig_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (95, N'Sales', N'Tiers', N'Tiers', NULL, 0, N'Tiers', N'Tiers_AR', N'Tiers', N'Tiers_DE', N'Tiers_CH', N'Tiers_ES', 1, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (96, N'Sales', N'TypeDocument', N'TypeDocument', NULL, 0, N'Type de document', N'TypeDocument_AR', N'Document type', N'TypeDocument_DE', N'TypeDocument_CH', N'TypeDocument_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (97, N'Sales', N'TypeTiers', N'TypeTiers', NULL, 0, N'Type de tiers', N'TypeTiers_AR', N'Tiers type', N'TypeTiers_DE', N'TypeTiers_CH', N'TypeTiers_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (98, N'Shared', N'Bank', N'Bank', NULL, 0, N'Banque', N'Bank_AR', N'Bank', N'Bank_DE', N'Bank_CH', N'Bank_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (99, N'Shared', N'BankAccount', N'BankAccount', NULL, 0, N'Compte bancaire', N'BankAccount_AR', N'Bank account
', N'BankAccount_DE', N'BankAccount_CH', N'BankAccount_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (100, N'Shared', N'City', N'City', NULL, 0, N'Ville', N'City_AR', N'City', N'City_DE', N'City_CH', N'City_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (101, N'Shared', N'Civility', N'Civility', NULL, 0, N'Civilité', N'Civility_AR', N'Civility', N'Civility_DE', N'Civility_CH', N'Civility_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (102, N'Shared', N'ColumnType', N'ColumnType', NULL, 0, N'Type de colonne', N'ColumnType_AR', N'Column type', N'ColumnType_DE', N'ColumnType_CH', N'ColumnType_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (103, N'Shared', N'Company', N'Company', NULL, 0, N'société', N'Company_AR', N'Company', N'Company_DE', N'Company_CH', N'Company_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (104, N'Shared', N'CompanyUsers', N'CompanyUsers', NULL, 0, N'Utilisateur de la société', N'CompanyUsers_AR', N'Company users', N'CompanyUsers_DE', N'CompanyUsers_CH', N'CompanyUsers_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (105, N'Shared', N'Contact', N'Contact', NULL, 0, N'Contact', N'Contact_AR', N'Contact', N'Contact_DE', N'Contact_CH', N'Contact_ES', NULL, 95, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (106, N'Shared', N'Counter', N'Counter', NULL, 0, N'Compteur', N'Counter_AR', N'Counter', N'Counter_DE', N'Counter_CH', N'Counter_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (107, N'Shared', N'Functionality', N'Functionality', NULL, 0, N'Fonctionnalité', N'Functionality_AR', N'Functionality', N'Functionality_DE', N'Functionality_CH', N'Functionality_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (108, N'Shared', N'FunctionalityRole', N'FunctionalityRole', NULL, 0, N'Fonctionnalité par rôle', N'FunctionalityRole_AR', N'Functionality role', N'FunctionalityRole_DE', N'FunctionalityRole_CH', N'FunctionalityRole_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (109, N'Shared', N'Log', N'Log', NULL, 0, N'Logeur', N'Log_AR', N'Log', N'Log_DE', N'Log_CH', N'Log_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (110, N'Shared', N'Country', N'Country', NULL, 0, N'Pays', N'Pays_AR', N'Country', N'Pays_DE', N'Pays_CH', N'Pays_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (111, N'Shared', N'RequestType', N'RequestType', NULL, 0, N'Type de requête', N'RequestType_AR', N'Request type', N'RequestType_DE', N'RequestType_CH', N'RequestType_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (112, N'Shared', N'Right', N'Right', NULL, 0, N'Droit', N'Right_AR', N'Right', N'Right_DE', N'Right_CH', N'Right_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (113, N'Shared', N'Role', N'Role', NULL, 0, N'Role', N'Role_AR', N'Role', N'Role_DE', N'Role_CH', N'Role_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (114, N'Shared', N'RoleRight', N'RoleRight', NULL, 0, N'Droit de dôle', N'RoleRight_AR', N'Role right', N'RoleRight_DE', N'RoleRight_CH', N'RoleRight_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (115, N'Shared', N'Status', N'Status', NULL, 0, N'Status', N'Status_AR', N'Status', N'Status_DE', N'Status_CH', N'Status_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (116, N'Shared', N'Taxe', N'Taxe', NULL, 0, N'Taxe', N'Taxe_AR', N'Tax', N'Taxe_DE', N'Taxe_CH', N'Taxe_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (117, N'Shared', N'TaxeType', N'TaxeType', NULL, 0, N'Type de taxe', N'TaxeType_AR', N'Taxe type', N'TaxeType_DE', N'TaxeType_CH', N'TaxeType_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (118, N'Shared', N'Translation', N'Translation', NULL, 0, N'Traduction', N'Translation_AR', N'Translation', N'Translation_DE', N'Translation_CH', N'Translation_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (119, N'Shared', N'TypeTranslation', N'TypeTranslation', NULL, 0, N'Type de traduction', N'TypeTranslation_AR', N'Translation type', N'TypeTranslation_DE', N'TypeTranslation_CH', N'TypeTranslation_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (120, N'Shared', N'User', N'User', NULL, 0, N'Utilisateur', N'User_AR', N'User', N'User_DE', N'User_CH', N'User_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (121, N'Shared', N'UserConfiguration', N'UserConfiguration', NULL, 0, N'Configuration de l''utilisateur', N'UserConfiguration_AR', N'User configuration', N'UserConfiguration_DE', N'UserConfiguration_CH', N'UserConfiguration_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (122, N'Shared', N'UserTranslation', N'UserTranslation', NULL, 0, N'Traduction de l''utilisateur', N'UserTranslation_AR', N'User translation', N'UserTranslation_DE', N'UserTranslation_CH', N'UserTranslation_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (123, N'Shared', N'ViewConfiguration', N'ViewConfiguration', NULL, 0, N'Configuration de vue', N'ViewConfiguration_AR', N'View configuration', N'ViewConfiguration_DE', N'ViewConfiguration_CH', N'ViewConfiguration_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (124, N'Shared', N'ViewConfigurationRole', N'ViewConfigurationRole', NULL, 0, N'Configuration de vue par rôle', N'ViewConfigurationRole_AR', N'View configuration role', N'ViewConfigurationRole_DE', N'ViewConfigurationRole_CH', N'ViewConfigurationRole_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (125, N'Shared', N'ZipCode', N'ZipCode', NULL, 0, N'Code ZIP', N'ZipCode_AR', N'Zip code', N'ZipCode_DE', N'ZipCode_CH', N'ZipCode_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (126, N'Inventory', N'Item', N'Item', NULL, 0, N'Article', N'Item_AR', N'Item', N'Item_DE', N'Item_CH', N'Item_ES', 1, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (127, N'Stock', N'ArticleFeatures', N'ArticleFeatures', NULL, 0, N'Fonctionnalité d''article', N'ArticleFeatures_AR', N'Article features', N'ArticleFeatures_DE', N'ArticleFeatures_CH', N'ArticleFeatures_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (128, N'Stock', N'Batch', N'Batch', NULL, 0, N'Modification par lots', N'Batch_AR', N'Batch', N'Batch_DE', N'Batch_CH', N'Batch_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (129, N'Stock', N'CategoryArticle', N'CategoryArticle', NULL, 0, N'Categorie d''article', N'CategoryArticle_AR', N'Item category ', N'CategoryArticle_DE', N'CategoryArticle_CH', N'CategoryArticle_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (130, N'Stock', N'FamilyArticle', N'FamilyArticle', NULL, 0, N'Famille d''article', N'FamilyArticle_AR', N'Item family', N'FamilyArticle_DE', N'FamilyArticle_CH', N'FamilyArticle_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (131, N'Stock', N'Feature', N'Feature', NULL, 0, N'Fonctionnalité', N'Feature_AR', N'Feature', N'Feature_DE', N'Feature_CH', N'Feature_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (132, N'Stock', N'Group', N'Group', NULL, 0, N'Groupe', N'Group_AR', N'Group', N'Group_DE', N'Group_CH', N'Group_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (133, N'Stock', N'Location', N'Location', NULL, 0, N'
Emplacement', N'Location_AR', N'Location', N'Location_DE', N'Location_CH', N'Location_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (134, N'Stock', N'SaleManagementMethod', N'SaleManagementMethod', NULL, 0, N'Méthode de gestion de vente', N'SaleManagementMethod_AR', N'Sale management method', N'SaleManagementMethod_DE', N'SaleManagementMethod_CH', N'SaleManagementMethod_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (135, N'Stock', N'Section', N'Section', NULL, 0, N'Section', N'Section_AR', N'Section', N'Section_DE', N'Section_CH', N'Section_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (136, N'Stock', N'SerialNumber', N'SerialNumber', NULL, 0, N'Numéro de série', N'SerialNumber_AR', N'SerialNumber', N'SerialNumber_DE', N'SerialNumber_CH', N'SerialNumber_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (137, N'Inventory', N'StockDocument', N'StockDocument', NULL, 0, N'Stock de document', N'StockDocument_AR', N'Stock document', N'StockDocument_DE', N'StockDocument_CH', N'StockDocument_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (138, N'Inventory', N'StockDocumentLine', N'StockDocumentLine', NULL, 0, N'Stock de ligne document', N'StockDocumentLine_AR', N'Stock documentLine', N'StockDocumentLine_DE', N'StockDocumentLine_CH', N'StockDocumentLine_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (139, N'Stock', N'StockDocumentLineSerialNumber', N'StockDocumentLineSerialNumber', NULL, 0, N'Numéro de serie de ligne document de stock', N'StockDocumentLineSerialNumber_AR', N'Stock documentLine serialNumber', N'StockDocumentLineSerialNumber_DE', N'StockDocumentLineSerialNumber_CH', N'StockDocumentLineSerialNumber_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (140, N'Stock', N'StockManagementMethod', N'StockManagementMethod', NULL, 0, N'Méthode de gestion de stock', N'StockManagementMethod_AR', N'Stock management method', N'StockManagementMethod_DE', N'StockManagementMethod_CH', N'StockManagementMethod_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (141, N'Stock', N'StockMovement', N'StockMovement', NULL, 0, N'Mouvement de stock', N'StockMovement_AR', N'Stock movement', N'StockMovement_DE', N'StockMovement_CH', N'StockMovement_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (142, N'Stock', N'Storage', N'Storage', NULL, 0, N'Stockage', N'Storage_AR', N'Storage', N'Storage_DE', N'Storage_CH', N'Storage_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (143, N'Stock', N'SubCategory', N'SubCategory', NULL, 0, N'Sous catégorie', N'SubCategory_AR', N'Sub-category', N'SubCategory_DE', N'SubCategory_CH', N'SubCategory_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (144, N'Stock', N'TaxeArticle', N'TaxeArticle', NULL, 0, N'Taxe d''article', N'TaxeArticle_AR', N'Item tax', N'TaxeArticle_DE', N'TaxeArticle_CH', N'TaxeArticle_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (145, N'Stock', N'UnitType', N'UnitType', NULL, 0, N'Type unitaire', N'UnitType_AR', N'Unit type', N'UnitType_DE', N'UnitType_CH', N'UnitType_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (146, N'Stock', N'Warehouse', N'Warehouse', NULL, 0, N'Dépôt', N'Warehouse_AR', N'Warehouse', N'Warehouse_DE', N'Warehouse_CH', N'Warehouse_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (147, N'Treasury', N'DetailReconciliation', N'DetailReconciliation', NULL, 0, N'Détails de réconciliation', N'DetailReconciliation_AR', N'Detail reconciliation', N'DetailReconciliation_DE', N'DetailReconciliation_CH', N'DetailReconciliation_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (148, N'Treasury', N'DetailTimetable', N'DetailTimetable', NULL, 0, N'Détails de table de temps', N'DetailTimetable_AR', N'Detail timetable', N'DetailTimetable_DE', N'DetailTimetable_CH', N'DetailTimetable_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (149, N'Treasury', N'PaymentDirection', N'PaymentDirection', NULL, 0, N'Direction de paiement', N'PaymentDirection_AR', N'Payment direction', N'PaymentDirection_DE', N'PaymentDirection_CH', N'PaymentDirection_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (150, N'Treasury', N'ReceiptSpent', N'ReceiptSpent', NULL, 0, N'Reçu dépensé', N'ReceiptSpent_AR', N'Receipt spent', N'ReceiptSpent_DE', N'ReceiptSpent_CH', N'ReceiptSpent_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (151, N'Treasury', N'Reconciliation', N'Reconciliation', NULL, 0, N'Réconciliation', N'Reconciliation_AR', N'Reconciliation', N'Reconciliation_DE', N'Reconciliation_CH', N'Reconciliation_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (152, N'Treasury', N'Timetable', N'Timetable', NULL, 0, N'Table de temps', N'Timetable_AR', N'Timetable', N'Timetable_DE', N'Timetable_CH', N'Timetable_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (153, N'Sales', N'Prices', N'Prices', NULL, 0, N'Prix', N'Prices_AR', N'Prices', N'Prices_DE', N'Prices_CH', N'Prices_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (156, N'Administration', N'CurrencyRate', N'CurrencyRate', NULL, 0, N'Taux de devises', N'CurrencyRate_AR', N'Currency rate', N'CurrencyRate_DE', N'CurrencyRate_CH', N'CurrencyRate_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (157, N'Sales', N'TaxeGroupTiers', N'TaxeGroupTiers', NULL, 0, N'Taxe de groupe tiers', N'TaxeGroupTiers_AR', N'Tax group tiers', N'TaxeGroupTiers_DE', N'TaxeGroupTiers_CH', N'TaxeGroupTiers_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (158, N'Inventory', N'DiscountGroupItem', N'DiscountGroupItem', NULL, 0, N'Remise de groupe articles', N'DiscountGroupItem_AR', N'Discount GroupItem', N'DiscountGroupItem_DE', N'DiscountGroupItem_CH', N'DiscountGroupItem_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (159, N'Sales', N'DiscountGroupTiers', N'DiscountGroupTiers', NULL, 0, N'Remise de groupe tiers', N'DiscountGroupTiers_AR', N'Discount groupTiers', N'DiscountGroupTiers_DE', N'DiscountGroupTiers_CH', N'DiscountGroupTiers_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (160, N'Stock', N'MeasureUnit', N'MeasureUnit', NULL, 0, N'Mesure unitaire', N'MeasureUnit_AR', N'Measure unit', N'MeasureUnit_DE', N'MeasureUnit_CH', N'MeasureUnit_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (163, N'Administration', N'Axis', N'Axis', NULL, 0, N'Axe', N'Axis_AR', N'Axis', N'Axis_DE', N'Axis_CH', N'Axis_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (166, N'Administration', N'AxisEntity', N'AxisEntity', NULL, 0, N'Entité d''axe', N'AxisEntity_AR', N'Axis entity', N'AxisEntity_DE', N'AxisEntity_CH', N'AxisEntity_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (167, N'Administration', N'AxisRelationShip', N'AxisRelationShip', NULL, 0, N'Relation d''axe', N'AxisRelationShip_AR', N'Axis relationShip', N'AxisRelationShip_DE', N'AxisRelationShip_CH', N'AxisRelationShip_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (168, N'Administration', N'AxisValue', N'AxisValue', NULL, 0, N'Valeur d''axe', N'AxisValue_AR', N'Axis value', N'AxisValue_DE', N'AxisValue_CH', N'AxisValue_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (169, N'Administration', N'AxisValueRelationShip', N'AxisValueRelationShip', NULL, 0, N'Relation de valeur d''axe', N'AxisValueRelationShip_AR', N'AxisValue relationShip', N'AxisValueRelationShip_DE', N'AxisValueRelationShip_CH', N'AxisValueRelationShip_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (172, N'Administration', N'EntityAxisValues', N'EntityAxisValues', NULL, 0, N'Entité de valeur d''axe', N'EntityAxisValues_AR', N'Entity axisValues', N'EntityAxisValues_DE', N'EntityAxisValues_CH', N'EntityAxisValues_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (174, N'ERPSettings', N'BarCodeComponent', N'BarCodeComponent', NULL, 0, N'Composant code à barre', N'BarCodeComponent_AR', N'BarCodeComponent_EN', N'BarCodeComponent_DE', N'BarCodeComponent_CH', N'BarCodeComponent_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (175, N'ERPSettings', N'ButtonComponent', N'ButtonComponent', NULL, 0, N'Composent bouton', N'ButtonComponent_AR', N'ButtonComponent_EN', N'ButtonComponent_DE', N'ButtonComponent_CH', N'ButtonComponent_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (176, N'ERPSettings', N'CheckBoxComponent', N'CheckBoxComponent', NULL, 0, N'Composant checkbox', N'CheckBoxComponent_AR', N'CheckBoxComponent_EN', N'CheckBoxComponent_DE', N'CheckBoxComponent_CH', N'CheckBoxComponent_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (177, N'ERPSettings', N'CheckBoxComponentDetails', N'CheckBoxComponentDetails', NULL, 0, N'Composant détails checkbox', N'CheckBoxComponentDetails_AR', N'CheckBoxComponentDetails_EN', N'CheckBoxComponentDetails_DE', N'CheckBoxComponentDetails_CH', N'CheckBoxComponentDetails_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (178, N'ERPSettings', N'Codification', N'Codification', NULL, 0, N'Codification', N'Codification_AR', N'Codification_EN', N'Codification_DE', N'Codification_CH', N'Codification_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (179, N'ERPSettings', N'ComboBoxComponent', N'ComboBoxComponent', NULL, 0, N'Composant combobox', N'ComboBoxComponent_AR', N'ComboBoxComponent_EN', N'ComboBoxComponent_DE', N'ComboBoxComponent_CH', N'ComboBoxComponent_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (180, N'ERPSettings', N'ComboBoxDataSource', N'ComboBoxDataSource', NULL, 0, N'Datasource de combobox', N'ComboBoxDataSource_AR', N'ComboBoxDataSource_EN', N'ComboBoxDataSource_DE', N'ComboBoxDataSource_CH', N'ComboBoxDataSource_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (181, N'ERPSettings', N'ComboBoxDataSourceItems', N'ComboBoxDataSourceItems', NULL, 0, N'Element de datasource de combobox', N'ComboBoxDataSourceItems_AR', N'ComboBoxDataSourceItems_EN', N'ComboBoxDataSourceItems_DE', N'ComboBoxDataSourceItems_CH', N'ComboBoxDataSourceItems_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (182, N'ERPSettings', N'ComboBoxOptions', N'ComboBoxOptions', NULL, 0, N'Options de combobox', N'ComboBoxOptions_AR', N'ComboBoxOptions_EN', N'ComboBoxOptions_DE', N'ComboBoxOptions_CH', N'ComboBoxOptions_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (183, N'ERPSettings', N'Component', N'Component', NULL, 0, N'Composant', N'Component_AR', N'Component_EN', N'Component_DE', N'Component_CH', N'Component_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (184, N'ERPSettings', N'ComponentByRole', N'ComponentByRole', NULL, 0, N'Composant par rôle', N'ComponentByRole_AR', N'ComponentByRole_EN', N'ComponentByRole_DE', N'ComponentByRole_CH', N'ComponentByRole_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (185, N'ERPSettings', N'ComponentByUser', N'ComponentByUser', NULL, 0, N'Composant par utilisateur', N'ComponentByUser_AR', N'ComponentByUser_EN', N'ComponentByUser_DE', N'ComponentByUser_CH', N'ComponentByUser_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (186, N'ERPSettings', N'DialogComponent', N'DialogComponent', NULL, 0, N'Composant diâlogue', N'DialogComponent_AR', N'DialogComponent_EN', N'DialogComponent_DE', N'DialogComponent_CH', N'DialogComponent_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (187, N'ERPSettings', N'DropDownListComponent', N'DropDownListComponent', NULL, 0, N'Composant menu déroulant', N'DropDownListComponent_AR', N'DropDownListComponent_EN', N'DropDownListComponent_DE', N'DropDownListComponent_CH', N'DropDownListComponent_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (188, N'ERPSettings', N'DropDownListDataSource', N'DropDownListDataSource', NULL, 0, N'Datasource de menu déroulant', N'DropDownListDataSource_AR', N'DropDownListDataSource_EN', N'DropDownListDataSource_DE', N'DropDownListDataSource_CH', N'DropDownListDataSource_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (189, N'ERPSettings', N'DropDownListOptions', N'DropDownListOptions', NULL, 0, N'Options de menu déroulant', N'DropDownListOptions_AR', N'DropDownListOptions_EN', N'DropDownListOptions_DE', N'DropDownListOptions_CH', N'DropDownListOptions_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (190, N'ERPSettings', N'Entity', N'Entity', NULL, 0, N'Entité', N'Entity_AR', N'Entity', N'Entity_DE', N'Entity_CH', N'Entity_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (191, N'ERPSettings', N'EntityCodification', N'EntityCodification', NULL, 0, N'Entité de codification', N'EntityCodification_AR', N'EntityCodification', N'EntityCodification_DE', N'EntityCodification_CH', N'EntityCodification_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (192, N'ERPSettings', N'Filter', N'Filter', NULL, 0, N'Filtre', N'Filter_AR', N'Filter', N'Filter_DE', N'Filter_CH', N'Filter_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (193, N'ERPSettings', N'FormComponent', N'FormComponent', NULL, 0, N'Composant formulaire', N'FormComponent_AR', N'FormComponent', N'FormComponent_DE', N'FormComponent_CH', N'FormComponent_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (195, N'ERPSettings', N'FunctionalityByRole', N'FunctionalityByRole', NULL, 0, N'Fonctionnalité par role', N'FunctionalityByRole_AR', N'FunctionalityByRole_EN', N'FunctionalityByRole_DE', N'FunctionalityByRole_CH', N'FunctionalityByRole_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (196, N'ERPSettings', N'FunctionnalityByUser', N'FunctionnalityByUser', NULL, 0, N'Fonctionnalité par utilisateur', N'FunctionnalityByUser_AR', N'FunctionnalityByUser_EN', N'FunctionnalityByUser_DE', N'FunctionnalityByUser_CH', N'FunctionnalityByUser_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (197, N'ERPSettings', N'FunctionnalityModule', N'FunctionnalityModule', NULL, 0, N'Fonctionnalité par module', N'FunctionnalityModule_AR', N'FunctionnalityModule_EN', N'FunctionnalityModule_DE', N'FunctionnalityModule_CH', N'FunctionnalityModule_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (198, N'ERPSettings', N'GridButtonComponent', N'GridButtonComponent', NULL, 0, N'Composant bouton de grid', N'GridButtonComponent_AR', N'GridButtonComponent_EN', N'GridButtonComponent_DE', N'GridButtonComponent_CH', N'GridButtonComponent_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (199, N'ERPSettings', N'GridColumnComponent', N'GridColumnComponent', NULL, 0, N'Composant colonne de grid', N'GridColumnComponent_AR', N'GridColumnComponent_EN', N'GridColumnComponent_DE', N'GridColumnComponent_CH', N'GridColumnComponent_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (200, N'ERPSettings', N'GridComponent', N'GridComponent', NULL, 0, N'Composant grid', N'GridComponent_AR', N'GridComponent_EN', N'GridComponent_DE', N'GridComponent_CH', N'GridComponent_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (201, N'ERPSettings', N'GridDataSource', N'GridDataSource', NULL, 0, N'Datasource de grid', N'GridDataSource_AR', N'GridDataSource_EN', N'GridDataSource_DE', N'GridDataSource_CH', N'GridDataSource_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (202, N'ERPSettings', N'GridOptions', N'GridOptions', NULL, 0, N'Options de grid', N'GridOptions_AR', N'GridOptions_EN', N'GridOptions_DE', N'GridOptions_CH', N'GridOptions_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (203, N'ERPSettings', N'InputComponent', N'InputComponent', NULL, 0, N'Composant input', N'InputComponent_AR', N'InputComponent_EN', N'InputComponent_DE', N'InputComponent_CH', N'InputComponent_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (204, N'ERPSettings', N'LabelComponent', N'LabelComponent', NULL, 0, N'Composant étiquette', N'LabelComponent_AR', N'LabelComponent_EN', N'LabelComponent_DE', N'LabelComponent_CH', N'LabelComponent_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (206, N'ERPSettings', N'Logs', N'Logs', NULL, 0, N'Logs', N'Logs_AR', N'Logs', N'Logs_DE', N'Logs_CH', N'Logs_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (207, N'ERPSettings', N'Menu', N'Menu', NULL, 0, N'Menu', N'Menu_AR', N'Menu', N'Menu_DE', N'Menu_CH', N'Menu_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (208, N'ERPSettings', N'Module', N'Module', NULL, 0, N'Module', N'Module_AR', N'Module_EN', N'Module_DE', N'Module_CH', N'Module_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (209, N'ERPSettings', N'ModuleByRole', N'ModuleByRole', NULL, 0, N'Module par role', N'ModuleByRole_AR', N'ModuleByRole_EN', N'ModuleByRole_DE', N'ModuleByRole_CH', N'ModuleByRole_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (210, N'ERPSettings', N'ModuleByUser', N'ModuleByUser', NULL, 0, N'Module  par utilisateur', N'ModuleByUser_AR', N'ModuleByUser_EN', N'ModuleByUser_DE', N'ModuleByUser_CH', N'ModuleByUser_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (211, N'ERPSettings', N'ModuleParameters', N'ModuleParameters', NULL, 0, N'Paramétres de module', N'ModuleParameters_AR', N'ModuleParameters_EN', N'ModuleParameters_DE', N'ModuleParameters_CH', N'ModuleParameters_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (212, N'ERPSettings', N'Notification', N'Notification', NULL, 0, N'Notification', N'Notification_AR', N'Notification_EN', N'Notification_DE', N'Notification_CH', N'Notification_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (213, N'ERPSettings', N'OrderBy', N'OrderBy', NULL, 0, N'OrderBy', N'OrderBy_AR', N'OrderBy_EN', N'OrderBy_DE', N'OrderBy_CH', N'OrderBy_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (214, N'ERPSettings', N'PredicateFormat', N'PredicateFormat', NULL, 0, N'PredicateFormat', N'PredicateFormat_AR', N'PredicateFormat_EN', N'PredicateFormat_DE', N'PredicateFormat_CH', N'PredicateFormat_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (215, N'ERPSettings', N'QrCodeComponent', N'QrCodeComponent', NULL, 0, N'Composant QrCode', N'QrCodeComponent_AR', N'QrCodeComponent_EN', N'QrCodeComponent_DE', N'QrCodeComponent_CH', N'QrCodeComponent_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (216, N'ERPSettings', N'RadioButtonComponent', N'RadioButtonComponent', NULL, 0, N'Composant bouton radio', N'RadioButtonComponent_AR', N'RadioButtonComponent_EN', N'RadioButtonComponent_DE', N'RadioButtonComponent_CH', N'RadioButtonComponent_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (217, N'ERPSettings', N'RadioButtonComponentDetails', N'RadioButtonComponentDetails', NULL, 0, N'Composant détails de bouton radio', N'RadioButtonComponentDetails_AR', N'RadioButtonComponentDetails_EN', N'RadioButtonComponentDetails_DE', N'RadioButtonComponentDetails_CH', N'RadioButtonComponentDetails_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (218, N'ERPSettings', N'Relation', N'Relation', NULL, 0, N'Relation', N'Relation_AR', N'Relation_EN', N'Relation_DE', N'Relation_CH', N'Relation_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (219, N'ERPSettings', N'ReportComponent', N'ReportComponent', NULL, 0, N'Composant rapport', N'ReportComponent_AR', N'ReportComponent_EN', N'ReportComponent_DE', N'ReportComponent_CH', N'ReportComponent_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (220, N'ERPSettings', N'ReportParameters', N'ReportParameters', NULL, 0, N'Parametres de rapport', N'ReportParameters_AR', N'ReportParameters_EN', N'ReportParameters_DE', N'ReportParameters_CH', N'ReportParameters_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (223, N'ERPSettings', N'ServiceParameters', N'ServiceParameters', NULL, 0, N'Paramétres de service', N'ServiceParameters_AR', N'ServiceParameters_EN', N'ServiceParameters_DE', N'ServiceParameters_CH', N'ServiceParameters_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (224, N'ERPSettings', N'Traceability', N'Traceability', NULL, 0, N'Traçabilité', N'Traceability_AR', N'Traceability_EN', N'Traceability_DE', N'Traceability_CH', N'Traceability_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (234, N'Inventory', N'ItemWarehouse', N'ItemWarehouse', NULL, 0, N'Dépôt article', N'ItemWarehouse_AR', N'ItemWarehouse_EN', N'ItemWarehouse_DE', N'ItemWarehouse_CH', N'ItemWarehouse_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (235, N'Inventory', N'TaxeItem', N'TaxeItem', NULL, 0, N'Taxe d''article', N'TaxeItem_AR', N'TaxeItem_EN', N'TaxeItem_DE', N'TaxeItem_CH', N'TaxeItem_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (251, N'Sales', N'DocumentStatus', N'DocumentStatus', NULL, 0, N'Status de document', N'DocumentStatus_AR', N'DocumentStatus_EN', N'DocumentStatus_DE', N'DocumentStatus_CH', N'DocumentStatus_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (252, N'Sales', N'DocumentType', N'DocumentType', NULL, 0, N'Type de document', N'DocumentType_AR', N'DocumentType_EN', N'DocumentType_DE', N'DocumentType_CH', N'DocumentType_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (253, N'Sales', N'OperationType', N'OperationType', NULL, 0, N'Type d''opération', N'OperationType_AR', N'OperationType_EN', N'OperationType_DE', N'OperationType_CH', N'OperationType_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (259, N'Sales', N'TypePrices', N'TypePrices', NULL, 0, N'Type de prix', N'TypePrices_AR', N'TypePrices_EN', N'TypePrices_DE', N'TypePrices_CH', N'TypePrices_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (267, N'Shared', N'ComponentTypeOld', N'ComponentTypeOld', NULL, 0, N'Composant ancien type', N'ComponentTypeOld_AR', N'ComponentTypeOld_EN', N'ComponentTypeOld_DE', N'ComponentTypeOld_CH', N'ComponentTypeOld_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (269, N'Shared', N'ContactTypeDocument', N'ContactTypeDocument', NULL, 0, N'Contact type de document', N'ContactTypeDocument_AR', N'ContactTypeDocument_EN', N'ContactTypeDocument_DE', N'ContactTypeDocument_CH', N'ContactTypeDocument_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (272, N'Shared', N'Table1', N'Table1', NULL, 0, N'Table1', N'Table1_AR', N'Table1_EN', N'Table1_DE', N'Table1_CH', N'Table1_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (273, N'Shared', N'Table10', N'Table10', NULL, 0, N'Table10', N'Table10_AR', N'Table10_EN', N'Table10_DE', N'Table10_CH', N'Table10_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (274, N'Shared', N'Table2', N'Table2', NULL, 0, N'Table2', N'Table2_AR', N'Table2_EN', N'Table2_DE', N'Table2_CH', N'Table2_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (275, N'Shared', N'Table3', N'Table3', NULL, 0, N'Table3', N'Table3_AR', N'Table3_EN', N'Table3_DE', N'Table3_CH', N'Table3_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (276, N'Shared', N'Table4', N'Table4', NULL, 0, N'Table4', N'Table4_AR', N'Table4_EN', N'Table4_DE', N'Table4_CH', N'Table4_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (277, N'Shared', N'Table5', N'Table5', NULL, 0, N'Table5', N'Table5_AR', N'Table5_EN', N'Table5_DE', N'Table5_CH', N'Table5_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (278, N'Shared', N'Table6', N'Table6', NULL, 0, N'Table6', N'Table6_AR', N'Table6_EN', N'Table6_DE', N'Table6_CH', N'Table6_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (279, N'Shared', N'Table7', N'Table7', NULL, 0, N'Table7', N'Table7_AR', N'Table7_EN', N'Table7_DE', N'Table7_CH', N'Table7_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (280, N'Shared', N'Table8', N'Table8', NULL, 0, N'Table8', N'Table8_AR', N'Table8_EN', N'Table8_DE', N'Table8_CH', N'Table8_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (281, N'Shared', N'Table9', N'Table9', NULL, 0, N'Table9', N'Table9_AR', N'Table9_EN', N'Table9_DE', N'Table9_CH', N'Table9_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (312, N'Inventory', N'StockDocumentType', N'StockDocumentType', NULL, 0, N'Type de document stock', N'StockDocumentType', N'StockDocumentType', N'StockDocumentType', N'StockDocumentType', N'StockDocumentType', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (313, N'Sales', N'FinancialCommitment', N'FinancialCommitment', NULL, 0, N'Echéances', NULL, N'Commitments', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (314, N'Payment', N'Settlement', N'Settlement', NULL, 0, N'Réglement', NULL, N'Settlements', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (315, N'Sales', N'SettlementCommitment', N'SettlementCommitment', NULL, 0, N'EchéancesRéglement', NULL, N'SettlementCommitment', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (316, N'Sales', N'DetailsSettlementMode', N'DetailsSettlementMode', NULL, 0, N'Détails mode de réglement', N'DetailsSettlementMode', N'DetailsSettlementMode', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (317, N'Sales', N'SettlementMode', N'SettlementMode', NULL, 0, N'Mode de réglement ', N'SettlementMode', N'SettlementMode', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (318, N'Sales', N'SettlementType', N'SettlementType', NULL, 0, N'type de réglement', N'SettlementType', N'SettlementType', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (319, N'Administration', N'Report', N'Report', NULL, 0, N'Report', N'Report', N'Report', N'Report', N'Report', N'Report', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (322, N'Stock', N'Nature', N'Nature', NULL, 0, N'Nature', NULL, N'Nature', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (323, N'Sales', N'SaleSettings', N'SaleSettings', NULL, 0, N'Paramétrage de vente', N'Sale settings', N'Sale settings', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (324, N'Sales', N'PurchaseSettings', N'PurchaseSettings', NULL, 0, N'Paramétrage d''achat', N'Purchase Settings', N'Purchase Settings', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (339, N'Payroll', N'Employee', N'Employee', NULL, 0, N'Employé', N'Employee', N'Employee', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (342, N'ERPSettings', N'Information', N'Information', NULL, 0, N'Information', N'Information', N'Information', N'Information', N'Information', N'Information', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (343, N'Payroll', N'Variable', N'Variable', NULL, 0, N'Variable', N'Variable', N'Variable', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (344, N'Payroll', N'ConstantRate', N'ConstantRate', NULL, 0, N'ConstantRate', N'ConstantRate', N'ConstantRate', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (345, N'Payroll', N'ConstantValue', N'ConstantValue', NULL, 0, N'ConstantValue', N'ConstantValue', N'ConstantValue', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (346, N'Payroll', N'SalaryRule', N'SalaryRule', NULL, 0, N'SalaryRule', N'SalaryRule', N'SalaryRule', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (347, N'Payroll', N'SalaryStructure', N'SalaryStructure', NULL, 0, N'SalaryStructure', N'SalaryStructure', N'SalaryStructure', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (348, N'Payroll', N'ConstantRateValidityPeriod', N'ConstantRateValidityPeriod', NULL, 0, N'ConstantRateValidityPeriod', N'ConstantRateValidityPeriod', N'ConstantRateValidityPeriod', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (349, N'Payroll', N'ConstantValueValidityPeriod', N'ConstantValueValidityPeriod', NULL, 0, N'ConstantValueValidityPeriod', N'ConstantValueValidityPeriod', N'ConstantValueValidityPeriod', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (350, N'Payroll', N'RuleCategory', N'RuleCategory', NULL, 0, N'RuleCategory', N'RuleCategory', N'RuleCategory', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (351, N'Payroll', N'Applicability', N'Applicability', NULL, 0, N'Applicability', N'Applicability', N'Applicability', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (352, N'Payroll', N'RuleType', N'RuleType', NULL, 0, N'RuleType', N'RuleType', N'RuleType', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (353, N'Payroll', N'Payslip', N'Payslip', NULL, 0, N'Payslip', N'Payslip', N'Payslip', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (354, N'Payroll', N'Grade', N'Grade', NULL, 0, N'Grade', N'Grade', N'Grade', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (355, N'Payroll', N'Echellon', N'Echellon', NULL, 0, N'Echellon', N'Echellon', N'Echellon', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (356, N'Payroll', N'Contract', N'Contract', NULL, 0, N'Contrat', N'Contract', N'Contract', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (357, N'Payroll', N'Job', N'Job', NULL, 0, N'Poste', N'Job', N'Job', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (358, N'Sales', N'ContractServiceType', N'ContractServiceType', NULL, 0, N'Type de prestation', N'Contract service type', N'Type de prestation', N'Type de prestation', N'Type de prestation', N'TaxeGroupTiers_ES', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (359, N'Immoblisation', N'Active', N'Active', NULL, 0, N'Actif', NULL, N'Active', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (360, N'Immoblisation', N'Category', N'Category', NULL, 0, N'Catégory', NULL, N'Category', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (361, N'Immoblisation', N'History', N'History', NULL, 0, N'Historique', N'History', N'History', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (362, N'Payroll', N'Premium', N'Premium', NULL, 0, N'Prime', N'Premium', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (367, N'Payroll', N'PaySlipPremium', N'PaySlip_Premium', NULL, 0, N'Bulletin Prime', N'PaySlip Premium', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (368, N'Payroll', N'Team', N'Team', NULL, 0, N'Team', N'Equipe', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (369, N'Sales', N'PriceRequest', N'PriceRequest', NULL, 0, N'PriceRequest', N'PriceRequest', N'PriceRequest', N'PriceRequest', N'PriceRequest', N'PriceRequest', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (373, N'Sales', N'PriceRequestDetail', N'PriceRequestDetail', NULL, 0, N'PriceRequestDetail', N'PriceRequestDetail', N'PriceRequestDetail', N'PriceRequestDetail', N'PriceRequestDetail', N'PriceRequestDetail', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (374, N'Sales', N'TiersPriceRequest', N'TiersPriceRequest', NULL, 0, N'TiersPriceRequest', N'TiersPriceRequest', N'TiersPriceRequest', N'TiersPriceRequest', N'TiersPriceRequest', N'TiersPriceRequest', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (375, N'Sales', N'Expense', N'Expense', NULL, 0, N'Expense', N'Expense', N'Expense', N'Expense', N'Expense', N'Expense', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (376, N'Sales', N'DocumentExpenseLine', N'DocumentExpenseLine', NULL, 0, N'DocumentExpenseLine', N'DocumentExpenseLine', N'DocumentExpenseLine', N'DocumentExpenseLine', N'DocumentExpenseLine', N'DocumentExpenseLine', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (377, N'Payroll', N'Skills', N'Skills', NULL, 0, N'Skills', N'Skills', N'Skills', N'Skills', N'Skills', N'Skills', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (378, N'RH', N'Candidate', N'Candidate', NULL, 0, N'Candidate', N'Candidate', N'Candidate', N'Candidate', N'Candidate', N'Candidate', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (379, N'Payroll', N'ExpenseReportRequest', N'ExpenseReportRequest', NULL, 0, N'ExpenseReportRequest', N'ExpenseReportRequest', N'ExpenseReportRequest', N'ExpenseReportRequest', N'ExpenseReportRequest', N'ExpenseReportRequest', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (381, N'Payroll', N'LeaveRequest', N'LeaveRequest', NULL, 0, N'LeaveRequest', N'LeaveRequest', N'LeaveRequest', N'LeaveRequest', N'LeaveRequest', N'LeaveRequest', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (382, N'Payroll', N'DocumentRequest', N'DocumentRequest', NULL, 0, N'DocumentRequest', N'DocumentRequest', N'DocumentRequest', N'DocumentRequest', N'DocumentRequest', N'DocumentRequest', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (384, N'Payroll', N'ExpenseReport', N'ExpenseReport', NULL, 0, N'ExpenseReport', N'ExpenseReport', N'ExpenseReport', N'ExpenseReport', N'ExpenseReport', N'ExpenseReport', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (390, N'Payroll', N'Leave', N'Leave', NULL, 0, N'Leave', N'Leave', N'Leave', N'Leave', N'Leave', N'Leave', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (391, N'Helpdesk', N'Claim', N'Claim', NULL, 0, N'Claim', N'Claim', N'Claim', N'Claim', N'Claim', N'Claim', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (392, N'Helpdesk', N'ClaimInteraction', N'ClaimInteraction', NULL, 0, N'ClaimInteraction', N'ClaimInteraction', N'ClaimInteraction', N'ClaimInteraction', N'ClaimInteraction', N'ClaimInteraction', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (393, N'Helpdesk', N'ClaimType', N'ClaimType', NULL, 0, N'ClaimType', N'ClaimType', N'ClaimType', N'ClaimType', N'ClaimType', N'ClaimType', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (394, N'Helpdesk', N'ClaimStatus', N'ClaimStatus', NULL, 0, N'ClaimStatus', N'ClaimStatus', N'ClaimStatus', N'ClaimStatus', N'ClaimStatus', N'ClaimStatus', NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (395, N'Sales', N'Provisioning', N'Provisioning', NULL, 0, N'Provisioning', N'Provisioning', N'Provisioning', N'Provisioning', N'Provisioning', N'Provisioning', NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (1, 126, NULL, NULL, 1)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (2, 87, N'DocumentTypeCode', N'Q-SA', 10)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (3, 87, N'DocumentTypeCode', N'O-SA', 15)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (4, 87, N'DocumentTypeCode', N'D-SA', 20)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (5, 87, N'DocumentTypeCode', N'I-SA', 25)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (6, 87, N'DocumentTypeCode', N'A-A-SA', 30)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (7, 95, N'IdTypeTiers', N'1', 35)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (8, 153, NULL, NULL, 37)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (9, 146, NULL, NULL, 39)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (10, 137, N'TypeStockDocument', N'IM', 41)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (11, 137, N'TypeStockDocument', N'OM', 46)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (12, 137, N'TypeStockDocument', N'TM', 51)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (13, 137, N'TypeStockDocument', N'INV', 41)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (14, 87, N'DocumentTypeCode', N'Q-PU', 61)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (15, 87, N'DocumentTypeCode', N'O-PU', 66)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (16, 87, N'DocumentTypeCode', N'D-PU', 71)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (17, 87, N'DocumentTypeCode', N'I-PU', 76)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (18, 95, N'IdTypeTiers', N'2', 81)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (19, 87, N'DocumentTypeCode', N'A-PU', 83)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (20, 87, N'DocumentTypeCode', N'RQ-PU', 93)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (21, 359, NULL, NULL, 88)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (22, 339, NULL, NULL, 98)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (23, 356, NULL, NULL, 104)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (24, 353, NULL, NULL, 100)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (25, 87, N'DocumentTypeCode', N'A-I-SA', 107)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (26, 87, N'DocumentTypeCode', N'B-PU', 112)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (27, 369, NULL, NULL, 117)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (28, 375, NULL, NULL, 122)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (29, 376, N'CodeExpenseLine', NULL, 126)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (30, 87, N'DocumentTypeCode', N'A-D-SA', 130)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (31, 377, NULL, NULL, 137)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (32, 382, NULL, NULL, 159)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (33, 384, NULL, NULL, 155)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (34, 390, NULL, NULL, 140)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (35, 391, N'ClaimType', N'D', 166)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (36, 391, N'ClaimType', N'E', 167)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (37, 391, N'ClaimType', N'M', 168)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (38, 391, N'ClaimType', N'R', 169)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (39, 395, NULL, NULL, 186)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (40, 87, N'DocumentTypeCode', N'FO-PU', 189)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (41, 87, N'DocumentTypeCode', N'BS-SA', 199)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (42, 87, N'DocumentTypeCode', N'BE-PU', 194)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (43, 87, N'IdTiers', NULL, 204)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (44, 87, N'IdTiers', NULL, 209)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (45, 87, N'DocumentTypeCode', N'A-BS-SA', 214)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (46, 87, N'DocumentTypeCode', N'A-SA', 219)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (47, 87, N'DocumentTypeCode', N'A-IA-SA', 240)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (48, 87, N'DocumentTypeCode', N'IA-SA', 234)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (49, 87, N'DocumentTypeCode', N'RE-BS-SA', 241)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (50, 87, N'DocumentTypeCode', N'RE-BE-PU', 246)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (51, 87, N'DocumentTypeCode', N'A-Q-PU', 251)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (52, 87, N'DocumentTypeCode', N'A-O-PU', 256)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (53, 87, N'DocumentTypeCode', N'A-FO-PU', 261)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (54, 87, N'DocumentTypeCode', N'A-I-PU', 266)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (55, 87, N'DocumentTypeCode', N'A-D-PU', 271)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (56, 314, NULL, NULL, 276)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (57, 313, N'IdDocument', NULL, 280)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (58, 87, N'DocumentTypeCode', N'A-A-PU', 285)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
SET IDENTITY_INSERT [Administration].[Currency] ON
INSERT INTO [Administration].[Currency] ([Id], [Code], [Symbole], [Description], [CurrencyInLetter], [FloatInLetter], [Precision], [IsActive], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'TND', N'TND', N'Dinar Tunisien', N'Dinar', N'Millime', 3, 1, 0, 0, NULL)
INSERT INTO [Administration].[Currency] ([Id], [Code], [Symbole], [Description], [CurrencyInLetter], [FloatInLetter], [Precision], [IsActive], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'EUR', N'€', N'Euro', N'Euros', N'Centime', 2, 1, 0, 0, NULL)
INSERT INTO [Administration].[Currency] ([Id], [Code], [Symbole], [Description], [CurrencyInLetter], [FloatInLetter], [Precision], [IsActive], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'USD', N'$', N'Dollar', N'Dollar', N'Penny', 3, 1, 0, 0, NULL)
SET IDENTITY_INSERT [Administration].[Currency] OFF
SET IDENTITY_INSERT [Shared].[Period] ON
INSERT INTO [Shared].[Period] ([Id], [Label], [StartDate], [EndDate], [FirstDayOfWork], [LastDayOfWork], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Printemps 2019', '20190320', '20190505', 1, 5, 0, 0, NULL)
INSERT INTO [Shared].[Period] ([Id], [Label], [StartDate], [EndDate], [FirstDayOfWork], [LastDayOfWork], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Ramadan', '20190506', '20190604', 1, 5, 0, 0, NULL)
INSERT INTO [Shared].[Period] ([Id], [Label], [StartDate], [EndDate], [FirstDayOfWork], [LastDayOfWork], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Ete 2019', '20190605', '20190922', 1, 5, 0, 0, NULL)
INSERT INTO [Shared].[Period] ([Id], [Label], [StartDate], [EndDate], [FirstDayOfWork], [LastDayOfWork], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'Hiver 2019', '20180922', '20190319', 1, 5, 0, 0, NULL)
SET IDENTITY_INSERT [Shared].[Period] OFF
SET IDENTITY_INSERT [Shared].[DayOff] ON
INSERT INTO [Shared].[DayOff] ([Id], [Label], [Date], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdPeriod]) VALUES (1, N'Fête des travailleurs', '20190501', 0, 0, NULL, 1)
INSERT INTO [Shared].[DayOff] ([Id], [Label], [Date], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdPeriod]) VALUES (2, N'Fête de l''indépendance', '20190320', 0, 0, NULL, 1)
SET IDENTITY_INSERT [Shared].[DayOff] OFF
SET IDENTITY_INSERT [Shared].[ZipCode] ON
INSERT INTO [Shared].[ZipCode] ([Id], [Region], [Code], [IdCity], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Paris', N'75000     ', 84, 0, 0, NULL)
SET IDENTITY_INSERT [Shared].[ZipCode] OFF

SET IDENTITY_INSERT [Sales].[SettlementMode] ON
INSERT INTO [Sales].[SettlementMode] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Comptant', N'Comptant', 0, 0, NULL)
SET IDENTITY_INSERT [Sales].[SettlementMode] OFF
SET IDENTITY_INSERT [Payment].[PaymentMethod] ON
INSERT INTO [Payment].[PaymentMethod] ([Id], [Code], [MethodName], [Description], [AuthorizedForExpenses], [AuthorizedForRecipes], [Immediate], [IsDeleted], [TransactionUserId], [IdPaymentType], [PaymentMethod_int_1], [PaymentMethod_int_2], [PaymentMethod_int_3], [PaymentMethod_int_4], [PaymentMethod_int_5], [PaymentMethod_int_6], [PaymentMethod_int_7], [PaymentMethod_int_8], [PaymentMethod_int_9], [PaymentMethod_int_10], [PaymentMethod_bit_1], [PaymentMethod_bit_2], [PaymentMethod_bit_3], [PaymentMethod_bit_4], [PaymentMethod_bit_5], [PaymentMethod_bit_6], [PaymentMethod_bit_7], [PaymentMethod_bit_8], [PaymentMethod_bit_9], [PaymentMethod_bit_10], [PaymentMethod_float_1], [PaymentMethod_float_2], [PaymentMethod_float_3], [PaymentMethod_float_4], [PaymentMethod_float_5], [PaymentMethod_float_6], [PaymentMethod_float_7], [PaymentMethod_float_8], [PaymentMethod_float_9], [PaymentMethod_float_10], [PaymentMethod_varchar_1], [PaymentMethod_varchar_2], [PaymentMethod_varchar_3], [PaymentMethod_varchar_4], [PaymentMethod_varchar_5], [PaymentMethod_varchar_6], [PaymentMethod_varchar_7], [PaymentMethod_varchar_8], [PaymentMethod_varchar_9], [PaymentMethod_varchar_10], [PaymentMethod_date_1], [PaymentMethod_date_2], [PaymentMethod_date_3], [PaymentMethod_date_4], [PaymentMethod_date_5], [PaymentMethod_date_6], [PaymentMethod_date_7], [PaymentMethod_date_8], [PaymentMethod_date_9], [PaymentMethod_date_10], [Deleted_Token], [Fr], [En]) VALUES (1, N'VIR', N'Virement', NULL, 1, 1, 1, 0, 0, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [Payment].[PaymentMethod] ([Id], [Code], [MethodName], [Description], [AuthorizedForExpenses], [AuthorizedForRecipes], [Immediate], [IsDeleted], [TransactionUserId], [IdPaymentType], [PaymentMethod_int_1], [PaymentMethod_int_2], [PaymentMethod_int_3], [PaymentMethod_int_4], [PaymentMethod_int_5], [PaymentMethod_int_6], [PaymentMethod_int_7], [PaymentMethod_int_8], [PaymentMethod_int_9], [PaymentMethod_int_10], [PaymentMethod_bit_1], [PaymentMethod_bit_2], [PaymentMethod_bit_3], [PaymentMethod_bit_4], [PaymentMethod_bit_5], [PaymentMethod_bit_6], [PaymentMethod_bit_7], [PaymentMethod_bit_8], [PaymentMethod_bit_9], [PaymentMethod_bit_10], [PaymentMethod_float_1], [PaymentMethod_float_2], [PaymentMethod_float_3], [PaymentMethod_float_4], [PaymentMethod_float_5], [PaymentMethod_float_6], [PaymentMethod_float_7], [PaymentMethod_float_8], [PaymentMethod_float_9], [PaymentMethod_float_10], [PaymentMethod_varchar_1], [PaymentMethod_varchar_2], [PaymentMethod_varchar_3], [PaymentMethod_varchar_4], [PaymentMethod_varchar_5], [PaymentMethod_varchar_6], [PaymentMethod_varchar_7], [PaymentMethod_varchar_8], [PaymentMethod_varchar_9], [PaymentMethod_varchar_10], [PaymentMethod_date_1], [PaymentMethod_date_2], [PaymentMethod_date_3], [PaymentMethod_date_4], [PaymentMethod_date_5], [PaymentMethod_date_6], [PaymentMethod_date_7], [PaymentMethod_date_8], [PaymentMethod_date_9], [PaymentMethod_date_10], [Deleted_Token], [Fr], [En]) VALUES (2, N'ESP', N'Espèce', NULL, 1, 1, 1, 0, 0, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [Payment].[PaymentMethod] ([Id], [Code], [MethodName], [Description], [AuthorizedForExpenses], [AuthorizedForRecipes], [Immediate], [IsDeleted], [TransactionUserId], [IdPaymentType], [PaymentMethod_int_1], [PaymentMethod_int_2], [PaymentMethod_int_3], [PaymentMethod_int_4], [PaymentMethod_int_5], [PaymentMethod_int_6], [PaymentMethod_int_7], [PaymentMethod_int_8], [PaymentMethod_int_9], [PaymentMethod_int_10], [PaymentMethod_bit_1], [PaymentMethod_bit_2], [PaymentMethod_bit_3], [PaymentMethod_bit_4], [PaymentMethod_bit_5], [PaymentMethod_bit_6], [PaymentMethod_bit_7], [PaymentMethod_bit_8], [PaymentMethod_bit_9], [PaymentMethod_bit_10], [PaymentMethod_float_1], [PaymentMethod_float_2], [PaymentMethod_float_3], [PaymentMethod_float_4], [PaymentMethod_float_5], [PaymentMethod_float_6], [PaymentMethod_float_7], [PaymentMethod_float_8], [PaymentMethod_float_9], [PaymentMethod_float_10], [PaymentMethod_varchar_1], [PaymentMethod_varchar_2], [PaymentMethod_varchar_3], [PaymentMethod_varchar_4], [PaymentMethod_varchar_5], [PaymentMethod_varchar_6], [PaymentMethod_varchar_7], [PaymentMethod_varchar_8], [PaymentMethod_varchar_9], [PaymentMethod_varchar_10], [PaymentMethod_date_1], [PaymentMethod_date_2], [PaymentMethod_date_3], [PaymentMethod_date_4], [PaymentMethod_date_5], [PaymentMethod_date_6], [PaymentMethod_date_7], [PaymentMethod_date_8], [PaymentMethod_date_9], [PaymentMethod_date_10], [Deleted_Token], [Fr], [En]) VALUES (3, N'CB', N'Carte bancaire', NULL, 1, 1, 1, 0, 0, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [Payment].[PaymentMethod] ([Id], [Code], [MethodName], [Description], [AuthorizedForExpenses], [AuthorizedForRecipes], [Immediate], [IsDeleted], [TransactionUserId], [IdPaymentType], [PaymentMethod_int_1], [PaymentMethod_int_2], [PaymentMethod_int_3], [PaymentMethod_int_4], [PaymentMethod_int_5], [PaymentMethod_int_6], [PaymentMethod_int_7], [PaymentMethod_int_8], [PaymentMethod_int_9], [PaymentMethod_int_10], [PaymentMethod_bit_1], [PaymentMethod_bit_2], [PaymentMethod_bit_3], [PaymentMethod_bit_4], [PaymentMethod_bit_5], [PaymentMethod_bit_6], [PaymentMethod_bit_7], [PaymentMethod_bit_8], [PaymentMethod_bit_9], [PaymentMethod_bit_10], [PaymentMethod_float_1], [PaymentMethod_float_2], [PaymentMethod_float_3], [PaymentMethod_float_4], [PaymentMethod_float_5], [PaymentMethod_float_6], [PaymentMethod_float_7], [PaymentMethod_float_8], [PaymentMethod_float_9], [PaymentMethod_float_10], [PaymentMethod_varchar_1], [PaymentMethod_varchar_2], [PaymentMethod_varchar_3], [PaymentMethod_varchar_4], [PaymentMethod_varchar_5], [PaymentMethod_varchar_6], [PaymentMethod_varchar_7], [PaymentMethod_varchar_8], [PaymentMethod_varchar_9], [PaymentMethod_varchar_10], [PaymentMethod_date_1], [PaymentMethod_date_2], [PaymentMethod_date_3], [PaymentMethod_date_4], [PaymentMethod_date_5], [PaymentMethod_date_6], [PaymentMethod_date_7], [PaymentMethod_date_8], [PaymentMethod_date_9], [PaymentMethod_date_10], [Deleted_Token], [Fr], [En]) VALUES (4, N'CHQ', N'Chèque', NULL, 1, 1, 0, 0, 0, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [Payment].[PaymentMethod] ([Id], [Code], [MethodName], [Description], [AuthorizedForExpenses], [AuthorizedForRecipes], [Immediate], [IsDeleted], [TransactionUserId], [IdPaymentType], [PaymentMethod_int_1], [PaymentMethod_int_2], [PaymentMethod_int_3], [PaymentMethod_int_4], [PaymentMethod_int_5], [PaymentMethod_int_6], [PaymentMethod_int_7], [PaymentMethod_int_8], [PaymentMethod_int_9], [PaymentMethod_int_10], [PaymentMethod_bit_1], [PaymentMethod_bit_2], [PaymentMethod_bit_3], [PaymentMethod_bit_4], [PaymentMethod_bit_5], [PaymentMethod_bit_6], [PaymentMethod_bit_7], [PaymentMethod_bit_8], [PaymentMethod_bit_9], [PaymentMethod_bit_10], [PaymentMethod_float_1], [PaymentMethod_float_2], [PaymentMethod_float_3], [PaymentMethod_float_4], [PaymentMethod_float_5], [PaymentMethod_float_6], [PaymentMethod_float_7], [PaymentMethod_float_8], [PaymentMethod_float_9], [PaymentMethod_float_10], [PaymentMethod_varchar_1], [PaymentMethod_varchar_2], [PaymentMethod_varchar_3], [PaymentMethod_varchar_4], [PaymentMethod_varchar_5], [PaymentMethod_varchar_6], [PaymentMethod_varchar_7], [PaymentMethod_varchar_8], [PaymentMethod_varchar_9], [PaymentMethod_varchar_10], [PaymentMethod_date_1], [PaymentMethod_date_2], [PaymentMethod_date_3], [PaymentMethod_date_4], [PaymentMethod_date_5], [PaymentMethod_date_6], [PaymentMethod_date_7], [PaymentMethod_date_8], [PaymentMethod_date_9], [PaymentMethod_date_10], [Deleted_Token], [Fr], [En]) VALUES (5, N'TRT', N'Traite', NULL, 1, 1, 0, 0, 0, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [Payment].[PaymentMethod] OFF
SET IDENTITY_INSERT [Sales].[DetailsSettlementMode] ON
INSERT INTO [Sales].[DetailsSettlementMode] ([Id], [IdSettlementMode], [IdSettlementType], [IdPaymentMethod], [Percentage], [NumberDays], [SettlementDay], [IsDeleted], [TransactionUserId], [Deleted_Token], [CompletePrinting]) VALUES (1, 1, 2, 1, 100, NULL, NULL, 0, 0, NULL, N'')
SET IDENTITY_INSERT [Sales].[DetailsSettlementMode] OFF

SET IDENTITY_INSERT [Inventory].[Nature] ON
INSERT INTO [Inventory].[Nature] ([Id], [Code], [Label], [IsStockManaged], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Service', N'Service', 0, 0, 0, NULL)
INSERT INTO [Inventory].[Nature] ([Id], [Code], [Label], [IsStockManaged], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Produit', N'Produit', 1, 0, 0, NULL)
INSERT INTO [Inventory].[Nature] ([Id], [Code], [Label], [IsStockManaged], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Expense', N'Expense', 0, 0, 0, NULL)
SET IDENTITY_INSERT [Inventory].[Nature] OFF
SET IDENTITY_INSERT [Sales].[SaleSettings] ON
INSERT INTO [Sales].[SaleSettings] ([Id], [SaleOtherTaxes], [IsDeleted], [TransactionUserId], [Deleted_Token], [InvoicingDay], [InvoicingEndMonth], [SaleAllowItemManagedInStock]) VALUES (2, 0.6, 0, 0, NULL, NULL, 0, 0)
SET IDENTITY_INSERT [Sales].[SaleSettings] OFF
SET IDENTITY_INSERT [Sales].[SettlementType] ON
INSERT INTO [Sales].[SettlementType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Comptant', N'Comptant', 0, NULL, NULL)
INSERT INTO [Sales].[SettlementType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Fin de mois', N'Fin de mois', 0, NULL, NULL)
INSERT INTO [Sales].[SettlementType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'Fin de mois le', N'Fin de mois le', 0, NULL, NULL)
INSERT INTO [Sales].[SettlementType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'Net', N'Net', 0, NULL, NULL)
INSERT INTO [Sales].[SettlementType] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (6, N'Net le', N'Net le', 0, NULL, NULL)
SET IDENTITY_INSERT [Sales].[SettlementType] OFF
SET IDENTITY_INSERT [Sales].[TaxeGroupTiers] ON
INSERT INTO [Sales].[TaxeGroupTiers] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Exonéré', N'exonéré', 0, 0, NULL)
INSERT INTO [Sales].[TaxeGroupTiers] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'NonExo', N'Non exonéré', 0, 0, NULL)
SET IDENTITY_INSERT [Sales].[TaxeGroupTiers] OFF
SET IDENTITY_INSERT [Sales].[TaxeGroupTiersConfig] ON
INSERT INTO [Sales].[TaxeGroupTiersConfig] ([Id], [IdTaxeGroupTiers], [IdTaxe], [Value], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (1, 1, 1, 0, 0, 0, NULL)
INSERT INTO [Sales].[TaxeGroupTiersConfig] ([Id], [IdTaxeGroupTiers], [IdTaxe], [Value], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (2, 1, 2, 0, 0, 0, NULL)
INSERT INTO [Sales].[TaxeGroupTiersConfig] ([Id], [IdTaxeGroupTiers], [IdTaxe], [Value], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (3, 1, 3, 0, 0, 0, NULL)
INSERT INTO [Sales].[TaxeGroupTiersConfig] ([Id], [IdTaxeGroupTiers], [IdTaxe], [Value], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (4, 1, 4, 0, 0, 0, NULL)
INSERT INTO [Sales].[TaxeGroupTiersConfig] ([Id], [IdTaxeGroupTiers], [IdTaxe], [Value], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (5, 1, 5, 0, 0, 0, NULL)
INSERT INTO [Sales].[TaxeGroupTiersConfig] ([Id], [IdTaxeGroupTiers], [IdTaxe], [Value], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (6, 1, 6, 0, 0, 0, NULL)
INSERT INTO [Sales].[TaxeGroupTiersConfig] ([Id], [IdTaxeGroupTiers], [IdTaxe], [Value], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (7, 2, 1, 0, 0, 0, NULL)
INSERT INTO [Sales].[TaxeGroupTiersConfig] ([Id], [IdTaxeGroupTiers], [IdTaxe], [Value], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (8, 2, 2, 10, 0, 0, NULL)
INSERT INTO [Sales].[TaxeGroupTiersConfig] ([Id], [IdTaxeGroupTiers], [IdTaxe], [Value], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9, 2, 3, 12, 0, 0, NULL)
INSERT INTO [Sales].[TaxeGroupTiersConfig] ([Id], [IdTaxeGroupTiers], [IdTaxe], [Value], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (10, 2, 4, 5, 0, 0, NULL)
INSERT INTO [Sales].[TaxeGroupTiersConfig] ([Id], [IdTaxeGroupTiers], [IdTaxe], [Value], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (11, 2, 5, 18, 0, 0, NULL)
INSERT INTO [Sales].[TaxeGroupTiersConfig] ([Id], [IdTaxeGroupTiers], [IdTaxe], [Value], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (12, 2, 6, 20, 0, 0, NULL)
INSERT INTO [Sales].[TaxeGroupTiersConfig] ([Id], [IdTaxeGroupTiers], [IdTaxe], [Value], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (13, 1, 7, 0, 0, 0, NULL)
INSERT INTO [Sales].[TaxeGroupTiersConfig] ([Id], [IdTaxeGroupTiers], [IdTaxe], [Value], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (14, 1, 8, 0, 0, 0, NULL)
INSERT INTO [Sales].[TaxeGroupTiersConfig] ([Id], [IdTaxeGroupTiers], [IdTaxe], [Value], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (15, 2, 7, 19, 0, 0, NULL)
INSERT INTO [Sales].[TaxeGroupTiersConfig] ([Id], [IdTaxeGroupTiers], [IdTaxe], [Value], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (16, 2, 8, 7, 0, 0, NULL)
SET IDENTITY_INSERT [Sales].[TaxeGroupTiersConfig] OFF
SET IDENTITY_INSERT [Sales].[DocumentStatus] ON
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Provisional', N'Provisional', 0, 0, NULL)
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Valid', N'Valid', 0, 0, NULL)
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Balanced', N'Balanced', 0, 0, NULL)
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'Refused', N'Refused', 0, 0, NULL)
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'ToOrder', N'ToOrder', 0, 0, NULL)
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (6, N'TotallySatisfied', N'TotallySatisfied', 0, 0, NULL)
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (7, N'PartiallySatisfied', N'PartiallySatisfied', 0, 0, NULL)
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (8, N'NotSatisfied', N'NotSatisfied', 0, 0, NULL)
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (9, N'Transferred', N'Transferred', 0, 0, NULL)
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (10, N'Received', N'Received', 0, 0, NULL)
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (11, N'Printed', N'Printed', 0, 0, NULL)
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (12, N'Accounted', N'Accounted', 0, 0, NULL)
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (13, N'Draft', N'Draf', 0, 0, NULL)
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (14, N'Ecommerce', N'Ecommerce', 0, 0, NULL)
SET IDENTITY_INSERT [Sales].[DocumentStatus] OFF

SET IDENTITY_INSERT [Payment].[PaymentStatus] ON
INSERT INTO [Payment].[PaymentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'NotCashed', N'Non encaissé', 0, 0, NULL)
INSERT INTO [Payment].[PaymentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Cashed', N'Encaissé', 0, 0, NULL)
INSERT INTO [Payment].[PaymentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Unpaid', N'Impayé', 0, 0, NULL)
INSERT INTO [Payment].[PaymentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'Handed', N'Remis', 0, 0, NULL)
INSERT INTO [Payment].[PaymentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'RemittanceSlip', N'Bordereau de remise', 0, 0, NULL)
SET IDENTITY_INSERT [Payment].[PaymentStatus] OFF
SET IDENTITY_INSERT [Inventory].[MeasureUnit] ON
INSERT INTO [Inventory].[MeasureUnit] ([Id], [MeasureUnitCode], [Label], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [IsDecomposable], [DigitsAfterComma]) VALUES (2, N'Pce', N'Pce', N'PCE', 0, 0, NULL, 0, 0)
SET IDENTITY_INSERT [Inventory].[MeasureUnit] OFF

INSERT INTO [Inventory].[StockDocumentType] ([CodeType], [Type], [StockOperation], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (N'IM', N'IM', N'I', N'Input Movement', 0, 0, NULL)
INSERT INTO [Inventory].[StockDocumentType] ([CodeType], [Type], [StockOperation], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (N'INV', N'INV', N'INV', N'Inventory', 0, 0, NULL)
INSERT INTO [Inventory].[StockDocumentType] ([CodeType], [Type], [StockOperation], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (N'OM', N'OM', N'O', N'Output Movement', 0, 0, NULL)
INSERT INTO [Inventory].[StockDocumentType] ([CodeType], [Type], [StockOperation], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (N'TM', N'TM', N'T', N'Transfer Movement', 0, 0, NULL)
SET IDENTITY_INSERT [Sales].[DeliveryType] ON
INSERT INTO [Sales].[DeliveryType] ([Id], [Code], [Label], [IsDeleted], [Deleted_Token]) VALUES (1, N'001', N'Transporteur', 0, NULL)
INSERT INTO [Sales].[DeliveryType] ([Id], [Code], [Label], [IsDeleted], [Deleted_Token]) VALUES (2, N'002', N'Comptoir', 0, NULL)
INSERT INTO [Sales].[DeliveryType] ([Id], [Code], [Label], [IsDeleted], [Deleted_Token]) VALUES (3, N'003', N'Louage', 0, NULL)
INSERT INTO [Sales].[DeliveryType] ([Id], [Code], [Label], [IsDeleted], [Deleted_Token]) VALUES (4, N'004', N'Avec nous', 0, NULL)
SET IDENTITY_INSERT [Sales].[DeliveryType] OFF

SET IDENTITY_INSERT [Shared].[Hours] ON
INSERT INTO [Shared].[Hours] ([Id], [Label], [StartTime], [EndTime], [IdPeriod], [WorkTimeTable], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Matin', '08:00:00.0000000', '11:30:00.0000000', 1, 1, 0, 0, NULL)
INSERT INTO [Shared].[Hours] ([Id], [Label], [StartTime], [EndTime], [IdPeriod], [WorkTimeTable], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Pause déjeuner', '11:30:00.0000000', '13:00:00.0000000', 1, 0, 0, 0, NULL)
INSERT INTO [Shared].[Hours] ([Id], [Label], [StartTime], [EndTime], [IdPeriod], [WorkTimeTable], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Après-midi', '13:00:00.0000000', '17:00:00.0000000', 1, 1, 0, 0, NULL)
INSERT INTO [Shared].[Hours] ([Id], [Label], [StartTime], [EndTime], [IdPeriod], [WorkTimeTable], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'Matin', '08:00:00.0000000', '12:00:00.0000000', 2, 1, 0, 0, NULL)
INSERT INTO [Shared].[Hours] ([Id], [Label], [StartTime], [EndTime], [IdPeriod], [WorkTimeTable], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'Pause', '12:00:00.0000000', '12:30:00.0000000', 2, 0, 0, 0, NULL)
INSERT INTO [Shared].[Hours] ([Id], [Label], [StartTime], [EndTime], [IdPeriod], [WorkTimeTable], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (6, N'Après-midi', '12:30:00.0000000', '16:00:00.0000000', 2, 1, 0, 0, NULL)
INSERT INTO [Shared].[Hours] ([Id], [Label], [StartTime], [EndTime], [IdPeriod], [WorkTimeTable], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (7, N'Matin', '08:00:00.0000000', '11:30:00.0000000', 3, 1, 0, 0, NULL)
INSERT INTO [Shared].[Hours] ([Id], [Label], [StartTime], [EndTime], [IdPeriod], [WorkTimeTable], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (8, N'Pause', '11:30:00.0000000', '13:00:00.0000000', 3, 0, 0, 0, NULL)
INSERT INTO [Shared].[Hours] ([Id], [Label], [StartTime], [EndTime], [IdPeriod], [WorkTimeTable], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (9, N'Après-midi', '13:00:00.0000000', '17:00:00.0000000', 3, 1, 0, 0, NULL)
INSERT INTO [Shared].[Hours] ([Id], [Label], [StartTime], [EndTime], [IdPeriod], [WorkTimeTable], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (10, N'Matin', '08:45:00.0000000', '12:30:00.0000000', 4, 1, 0, 0, NULL)
INSERT INTO [Shared].[Hours] ([Id], [Label], [StartTime], [EndTime], [IdPeriod], [WorkTimeTable], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (11, N'Pause', '12:45:00.0000000', '14:00:00.0000000', 4, 0, 0, 0, NULL)
INSERT INTO [Shared].[Hours] ([Id], [Label], [StartTime], [EndTime], [IdPeriod], [WorkTimeTable], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (12, N'Après-midi', '14:00:00.0000000', '18:00:00.0000000', 4, 1, 0, 0, NULL)
SET IDENTITY_INSERT [Shared].[Hours] OFF
SET IDENTITY_INSERT [Payment].[PaymentType] ON
INSERT INTO [Payment].[PaymentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [PaymentType_int_1], [PaymentType_int_2], [PaymentType_int_3], [PaymentType_int_4], [PaymentType_int_5], [PaymentType_int_6], [PaymentType_int_7], [PaymentType_int_8], [PaymentType_int_9], [PaymentType_int_10], [PaymentType_bit_1], [PaymentType_bit_2], [PaymentType_bit_3], [PaymentType_bit_4], [PaymentType_bit_5], [PaymentType_bit_6], [PaymentType_bit_7], [PaymentType_bit_8], [PaymentType_bit_9], [PaymentType_bit_10], [PaymentType_float_1], [PaymentType_float_2], [PaymentType_float_3], [PaymentType_float_4], [PaymentType_float_5], [PaymentType_float_6], [PaymentType_float_7], [PaymentType_float_8], [PaymentType_float_9], [PaymentType_float_10], [PaymentType_varchar_1], [PaymentType_varchar_2], [PaymentType_varchar_3], [PaymentType_varchar_4], [PaymentType_varchar_5], [PaymentType_varchar_6], [PaymentType_varchar_7], [PaymentType_varchar_8], [PaymentType_varchar_9], [PaymentType_varchar_10], [PaymentType_date_1], [PaymentType_date_2], [PaymentType_date_3], [PaymentType_date_4], [PaymentType_date_5], [PaymentType_date_6], [PaymentType_date_7], [PaymentType_date_8], [PaymentType_date_9], [PaymentType_date_10], [Deleted_Token], [Code]) VALUES (4, N'Espèce', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ESP')
INSERT INTO [Payment].[PaymentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [PaymentType_int_1], [PaymentType_int_2], [PaymentType_int_3], [PaymentType_int_4], [PaymentType_int_5], [PaymentType_int_6], [PaymentType_int_7], [PaymentType_int_8], [PaymentType_int_9], [PaymentType_int_10], [PaymentType_bit_1], [PaymentType_bit_2], [PaymentType_bit_3], [PaymentType_bit_4], [PaymentType_bit_5], [PaymentType_bit_6], [PaymentType_bit_7], [PaymentType_bit_8], [PaymentType_bit_9], [PaymentType_bit_10], [PaymentType_float_1], [PaymentType_float_2], [PaymentType_float_3], [PaymentType_float_4], [PaymentType_float_5], [PaymentType_float_6], [PaymentType_float_7], [PaymentType_float_8], [PaymentType_float_9], [PaymentType_float_10], [PaymentType_varchar_1], [PaymentType_varchar_2], [PaymentType_varchar_3], [PaymentType_varchar_4], [PaymentType_varchar_5], [PaymentType_varchar_6], [PaymentType_varchar_7], [PaymentType_varchar_8], [PaymentType_varchar_9], [PaymentType_varchar_10], [PaymentType_date_1], [PaymentType_date_2], [PaymentType_date_3], [PaymentType_date_4], [PaymentType_date_5], [PaymentType_date_6], [PaymentType_date_7], [PaymentType_date_8], [PaymentType_date_9], [PaymentType_date_10], [Deleted_Token], [Code]) VALUES (5, N'Chèque', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'CHQ')
INSERT INTO [Payment].[PaymentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [PaymentType_int_1], [PaymentType_int_2], [PaymentType_int_3], [PaymentType_int_4], [PaymentType_int_5], [PaymentType_int_6], [PaymentType_int_7], [PaymentType_int_8], [PaymentType_int_9], [PaymentType_int_10], [PaymentType_bit_1], [PaymentType_bit_2], [PaymentType_bit_3], [PaymentType_bit_4], [PaymentType_bit_5], [PaymentType_bit_6], [PaymentType_bit_7], [PaymentType_bit_8], [PaymentType_bit_9], [PaymentType_bit_10], [PaymentType_float_1], [PaymentType_float_2], [PaymentType_float_3], [PaymentType_float_4], [PaymentType_float_5], [PaymentType_float_6], [PaymentType_float_7], [PaymentType_float_8], [PaymentType_float_9], [PaymentType_float_10], [PaymentType_varchar_1], [PaymentType_varchar_2], [PaymentType_varchar_3], [PaymentType_varchar_4], [PaymentType_varchar_5], [PaymentType_varchar_6], [PaymentType_varchar_7], [PaymentType_varchar_8], [PaymentType_varchar_9], [PaymentType_varchar_10], [PaymentType_date_1], [PaymentType_date_2], [PaymentType_date_3], [PaymentType_date_4], [PaymentType_date_5], [PaymentType_date_6], [PaymentType_date_7], [PaymentType_date_8], [PaymentType_date_9], [PaymentType_date_10], [Deleted_Token], [Code]) VALUES (6, N'Virement', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'VIR')
INSERT INTO [Payment].[PaymentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [PaymentType_int_1], [PaymentType_int_2], [PaymentType_int_3], [PaymentType_int_4], [PaymentType_int_5], [PaymentType_int_6], [PaymentType_int_7], [PaymentType_int_8], [PaymentType_int_9], [PaymentType_int_10], [PaymentType_bit_1], [PaymentType_bit_2], [PaymentType_bit_3], [PaymentType_bit_4], [PaymentType_bit_5], [PaymentType_bit_6], [PaymentType_bit_7], [PaymentType_bit_8], [PaymentType_bit_9], [PaymentType_bit_10], [PaymentType_float_1], [PaymentType_float_2], [PaymentType_float_3], [PaymentType_float_4], [PaymentType_float_5], [PaymentType_float_6], [PaymentType_float_7], [PaymentType_float_8], [PaymentType_float_9], [PaymentType_float_10], [PaymentType_varchar_1], [PaymentType_varchar_2], [PaymentType_varchar_3], [PaymentType_varchar_4], [PaymentType_varchar_5], [PaymentType_varchar_6], [PaymentType_varchar_7], [PaymentType_varchar_8], [PaymentType_varchar_9], [PaymentType_varchar_10], [PaymentType_date_1], [PaymentType_date_2], [PaymentType_date_3], [PaymentType_date_4], [PaymentType_date_5], [PaymentType_date_6], [PaymentType_date_7], [PaymentType_date_8], [PaymentType_date_9], [PaymentType_date_10], [Deleted_Token], [Code]) VALUES (7, N'Carte bancaire', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'CB')
INSERT INTO [Payment].[PaymentType] ([Id], [Label], [IsDeleted], [TransactionUserId], [PaymentType_int_1], [PaymentType_int_2], [PaymentType_int_3], [PaymentType_int_4], [PaymentType_int_5], [PaymentType_int_6], [PaymentType_int_7], [PaymentType_int_8], [PaymentType_int_9], [PaymentType_int_10], [PaymentType_bit_1], [PaymentType_bit_2], [PaymentType_bit_3], [PaymentType_bit_4], [PaymentType_bit_5], [PaymentType_bit_6], [PaymentType_bit_7], [PaymentType_bit_8], [PaymentType_bit_9], [PaymentType_bit_10], [PaymentType_float_1], [PaymentType_float_2], [PaymentType_float_3], [PaymentType_float_4], [PaymentType_float_5], [PaymentType_float_6], [PaymentType_float_7], [PaymentType_float_8], [PaymentType_float_9], [PaymentType_float_10], [PaymentType_varchar_1], [PaymentType_varchar_2], [PaymentType_varchar_3], [PaymentType_varchar_4], [PaymentType_varchar_5], [PaymentType_varchar_6], [PaymentType_varchar_7], [PaymentType_varchar_8], [PaymentType_varchar_9], [PaymentType_varchar_10], [PaymentType_date_1], [PaymentType_date_2], [PaymentType_date_3], [PaymentType_date_4], [PaymentType_date_5], [PaymentType_date_6], [PaymentType_date_7], [PaymentType_date_8], [PaymentType_date_9], [PaymentType_date_10], [Deleted_Token], [Code]) VALUES (8, N'Traite', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'TRT')
SET IDENTITY_INSERT [Payment].[PaymentType] OFF
SET IDENTITY_INSERT [ERPSettings].[ReportTemplate] ON
INSERT INTO [ERPSettings].[ReportTemplate] ([Id], [IdEntity], [TemplateCode], [TemplateNameFr], [TemplateNameEn], [ReportCode], [ReportName]) VALUES (1, 87, N'DocumentSparkFr', N' document Fr', N'Document Fr1', N'Spark-Fr', N'SparkFr')
SET IDENTITY_INSERT [ERPSettings].[ReportTemplate] OFF
SET IDENTITY_INSERT [Sales].[TypeTiers] ON
INSERT INTO [Sales].[TypeTiers] ([Id], [Label], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Client', N'client', 0, 0, NULL)
INSERT INTO [Sales].[TypeTiers] ([Id], [Label], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Fournisseur', N'fournisseur', 0, 0, NULL)
INSERT INTO [Sales].[TypeTiers] ([Id], [Label], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Tier', N'Tier', 0, 0, NULL)
INSERT INTO [Sales].[TypeTiers] ([Id], [Label], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'Représentant', N'Représentant', 0, 0, NULL)
SET IDENTITY_INSERT [Sales].[TypeTiers] OFF


SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (1, N'Code', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (2, N'compteur', 1, NULL, NULL, NULL, 1, 1, 1, N'00000003', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (4, N'-', 2, NULL, NULL, N'-', NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (7, N'IdUnitStockNavigation', 5, N'IdUnitStockNavigation.Label', NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (8, N'compteur', 3, NULL, NULL, NULL, NULL, 1, 1, N'000000000000000000', 18)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (9, N'date', 3, N'return DateTime.Now;', N'DateTime', NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (10, N'CodeDevis', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (11, N'CaractereD', 1, NULL, NULL, N'D', 10, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (12, N'Annee', 2, NULL, N'string', N'20', 10, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (13, N'Caractere/', 3, NULL, NULL, N'/', 10, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (14, N'compteurDevis', 4, NULL, NULL, NULL, 10, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (15, N'CodeCommdClient', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (16, N'CaractereC', 1, NULL, NULL, N'C', 15, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (17, N'Annee', 2, NULL, N'string', N'20', 15, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (18, N'Caractere/', 3, NULL, NULL, N'/', 15, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (19, N'compteurCommdClient', 4, NULL, NULL, NULL, 15, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (20, N'CodeLivraisonClient', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (21, N'CaractereL', 1, NULL, NULL, N'L', 20, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (22, N'Annee', 2, NULL, N'string', N'20', 20, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (23, N'Caractere/', 3, NULL, NULL, N'/', 20, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (24, N'compteurLivraisonClient', 4, NULL, NULL, NULL, 20, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (25, N'CodeFactureClient', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (26, N'CaractereF', 1, NULL, NULL, N'F', 25, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (27, N'Annee', 2, NULL, N'string', N'20', 25, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (28, N'Caractere/', 3, NULL, NULL, N'/', 25, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (29, N'compteurFactureClient', 4, NULL, NULL, NULL, 25, 1, 1, N'0000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (30, N'CodeAvoirClient', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (31, N'CaractereA', 1, NULL, NULL, N'A', 30, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (32, N'Annee', 2, NULL, N'string', N'20', 30, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (33, N'Caractere/', 3, NULL, NULL, N'/', 30, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (34, N'compteurAvoirClient', 4, NULL, NULL, NULL, 30, 1, 1, NULL, 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (35, N'CodeTiers', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (36, N'counterTiers', 2, NULL, NULL, NULL, 35, 1, 1, N'41100001', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (37, N'CodePrices', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (38, N'counterPrices', 1, NULL, NULL, NULL, 37, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (39, N'CodeDepot', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (40, N'CodeDepotCounter', NULL, NULL, NULL, NULL, 39, 1, 1, N'0001', 4)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (41, N'CodeStockDocument-IM', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (42, N'CaractereID', 1, NULL, NULL, N'ID', 41, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (43, N'Annee', 2, NULL, N'string', N'20', 41, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (44, N'Caractere/', 3, NULL, NULL, N'/', 41, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (45, N'compteurIM', 4, NULL, NULL, NULL, 41, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (46, N'CodeStockDocument-OM', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (47, N'CaractereOD', 1, NULL, NULL, N'OD', 46, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (48, N'Annee', 2, NULL, N'string', N'20', 46, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (49, N'Caractere/', 3, NULL, NULL, N'/', 46, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (50, N'compteurOM', 4, NULL, NULL, NULL, 46, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (51, N'CodeStockDocument-TM', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (52, N'CaractereTD', 1, NULL, NULL, N'TD', 51, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (53, N'Annee', 2, NULL, N'string', N'20', 51, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (54, N'Caractere/', 3, NULL, NULL, N'/', 51, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (55, N'compteurTM', 4, NULL, NULL, NULL, 51, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (56, N'CodeStockDocument-I', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (57, N'CaractereI', 1, NULL, NULL, N'I', 56, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (58, N'Annee', 2, NULL, N'string', N'20', 56, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (59, N'Caractere/', 3, NULL, NULL, N'/', 56, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (60, N'compteurTM', 4, NULL, NULL, NULL, 56, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (61, N'CodeDevisPurchase', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (62, N'CaractereD', 1, NULL, NULL, N'D', 61, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (63, N'Annee', 2, NULL, N'string', N'20', 61, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (64, N'Caractere/', 3, NULL, NULL, N'/', 61, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (65, N'compteurDevis', 4, NULL, NULL, NULL, 61, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (66, N'CodeCommdPurchase', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (67, N'CaractereC', 1, NULL, NULL, N'C', 66, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (68, N'Annee', 2, NULL, N'string', N'20', 66, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (69, N'Caractere/', 3, NULL, NULL, N'/', 66, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (70, N'compteurCommdPurchase', 4, NULL, NULL, NULL, 66, 1, 1, N'00000004', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (71, N'CodeLivraisonPurchase', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (72, N'CaractereL', 1, NULL, NULL, N'L', 71, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (73, N'Annee', 2, NULL, N'string', N'20', 71, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (74, N'Caractere/', 3, NULL, NULL, N'/', 71, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (75, N'compteurLivraisonPurchase', 4, NULL, NULL, NULL, 71, 1, 1, N'00000003', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (76, N'CodeFacturePurchase', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (77, N'CaractereF', 1, NULL, NULL, N'F', 76, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (78, N'Annee', 2, NULL, N'string', N'20', 76, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (79, N'Caractere/', 3, NULL, NULL, N'/', 76, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (80, N'compteurFacturePurchase', 4, NULL, NULL, NULL, 76, 1, 1, N'00000003', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (81, N'CodeTiers', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (82, N'counterTiers', 1, NULL, NULL, NULL, 81, 1, 1, N'0005', 4)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (83, N'CodeAssetPurchase', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (84, N'CaractereF', 1, NULL, NULL, N'A', 83, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (85, N'Annee', 2, NULL, N'string', N'20', 83, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (86, N'Caractere/', 3, NULL, NULL, N'/', 83, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (87, N'compteurFacturePurchase', 4, NULL, NULL, NULL, 83, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (88, N'CodeActive', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (89, N'Prefixe-Actif', 1, NULL, NULL, N'AC-', 88, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (90, N'Counter-Active', 2, NULL, NULL, NULL, 88, 1, 1, N'0000', 4)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (91, N'CaractereC-for customer', 1, NULL, NULL, N'C-', 35, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (92, N'CaractereF-for supplier', 1, NULL, NULL, N'F-', 81, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (93, N'CodePurchaseRequest', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (94, N'CaractereF', 1, NULL, NULL, N'RQ-', 93, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (95, N'Annee', 2, NULL, N'string', N'20', 93, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (96, N'Caractere/', 3, NULL, NULL, N'-', 93, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (97, N'compteurPurchaseRequest', 4, NULL, NULL, NULL, 93, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (98, N'CodeEmployee', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (99, N'EmployeeCounter', 1, NULL, NULL, NULL, 98, 1, 1, N'0000', 4)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (100, N'CodePaySlip', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (101, N'PaySlipYear', 1, N'return (DateTime.Now.Year.ToString());', N'string', NULL, 100, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (102, N'PayslipCaractere-', 2, NULL, NULL, N'-', 100, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (103, N'PaySlipCounter', 3, NULL, NULL, NULL, 100, 1, 1, N'0000', 4)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (104, N'CodeContract', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (105, N'ContractConstant', 1, NULL, NULL, N'Contract-', 104, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (106, N'ContractCounter', 2, NULL, NULL, NULL, 104, 1, 1, N'0000', 4)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (107, N'CodeFactureClient-Approved', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (108, N'CaractereFA', 1, NULL, NULL, N'FA', 107, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (109, N'Annee', 2, NULL, N'string', N'20', 107, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (111, N'compteurFactureClient', 4, NULL, NULL, NULL, 107, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (112, N'CodeDevisAchat', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (113, N'CaractereDevisAchat', 1, NULL, NULL, N'DE', 112, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (114, N'Annee', 2, NULL, N'string', N'20', 112, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (115, N'Caractere/', 3, NULL, NULL, N'/', 112, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (116, N'compteurDevis', 4, NULL, NULL, NULL, 112, 1, 1, N'00000005', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (117, N'PriceRequestCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (118, N'CaracterePR', 1, NULL, NULL, N'PR', 117, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (119, N'Annee', 2, NULL, N'string', N'20', 117, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (120, N'Caractere/', 3, NULL, NULL, N'/', 117, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (121, N'compteurPurchaseRequest', 4, NULL, NULL, NULL, 117, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (122, N'ExpenseCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (123, N'CaractereEXP', 1, NULL, NULL, N'EXP', 122, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (124, N'Caractere-', 3, NULL, NULL, N'-', 122, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (125, N'compteurPurchaseRequest', 4, NULL, NULL, NULL, 122, 1, 1, N'00000003', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (126, N'DocumentExpenseLineCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (127, N'CaractereEXPLine', 1, NULL, NULL, N'EXP-LINE', 126, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (128, N'Caractere-', 3, NULL, NULL, N'-', 126, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (129, N'compteurPurchaseDeliveryExpenseLine', 4, NULL, NULL, NULL, 126, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (130, N'CodeBLClient-Approved', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (131, N'CaractereBL', 1, NULL, NULL, N'BL', 130, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (132, N'Annee', 2, NULL, N'string', N'20', 130, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (133, N'compteurFactureClient', 3, NULL, NULL, NULL, 130, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (137, N'SkillsCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (138, N'CaractereSK', 1, NULL, NULL, N'SK', 137, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (140, N'LeaveCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (142, N'CaractereL', 1, NULL, NULL, N'L', 140, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (143, N'Caractere-', 2, NULL, NULL, N'-', 140, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (144, N'compteurLeave', 3, NULL, NULL, NULL, 140, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (155, N'ExpenseReportCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (156, N'CaractereER', 1, NULL, NULL, N'ER', 155, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (157, N'Caractere-', 2, NULL, NULL, N'-', 155, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (158, N'compteurExpenseReport', 3, NULL, NULL, NULL, 155, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (159, N'DocumentRequestCodification', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (160, N'CaractereDR', 1, NULL, NULL, N'DR', 159, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (161, N'Caractere-', 2, NULL, NULL, N'-', 159, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (162, N'compteurDocumentRequest', 3, NULL, NULL, NULL, 159, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (163, N'Caractere-', 3, NULL, NULL, N'-', 107, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (165, N'Claim-', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (166, N'CodeClaim-D', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (167, N'CodeClaim-E', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (168, N'CodeClaim-M', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (169, N'CodeClaim-R', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (170, N'CaractereDF', 1, NULL, NULL, N'C-DF', 166, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (171, N'Annee', 2, NULL, N'string', N'20', 166, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (172, N'Caractere/', 3, NULL, NULL, N'/', 166, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (173, N'compteurClaimDF', 4, NULL, NULL, NULL, 166, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (174, N'CaractereSP', 1, NULL, NULL, N'C-SP', 167, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (175, N'Annee', 2, NULL, N'string', N'20', 167, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (176, N'Caractere/', 3, NULL, NULL, N'/', 167, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (177, N'compteurClaimDF', 4, NULL, NULL, NULL, 167, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (178, N'CaractereMQ', 1, NULL, NULL, N'C-MQ', 168, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (179, N'Annee', 2, NULL, N'string', N'20', 168, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (180, N'Caractere/', 3, NULL, NULL, N'/', 168, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (181, N'compteurClaimDF', 4, NULL, NULL, NULL, 168, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (182, N'CaractereRG', 1, NULL, NULL, N'C-RG', 169, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (183, N'Annee', 2, NULL, N'string', N'20', 169, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (184, N'Caractere/', 3, NULL, NULL, N'/', 169, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (185, N'compteurClaimDF', 4, NULL, NULL, NULL, 169, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (186, N'ProvisioningCode', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (187, N'CaracterePr', 1, NULL, NULL, N'PR', 186, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (188, N'compteurProvisioning', 2, NULL, NULL, NULL, 186, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (189, N'CodeFinalCommdPurchase', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (190, N'CaractereCF', 1, NULL, NULL, N'CF', 189, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (191, N'Annee', 2, NULL, N'string', N'20', 189, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (192, N'Caractere/', 3, NULL, NULL, N'/', 189, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (193, N'compteurFinalCommdPurchase', 4, NULL, NULL, NULL, 189, 1, 1, N'00000009', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (194, N'CodeBE', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (195, N'CaractereBE', 1, NULL, NULL, N'BE', 194, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (196, N'Annee', 2, NULL, NULL, N'20', 194, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (197, N'Caractere/', 3, NULL, NULL, N'/', 194, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (198, N'compteurBE', 4, NULL, NULL, NULL, 194, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (199, N'CodeBS', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (200, N'CaractereBS', 1, NULL, NULL, N'BS', 199, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (201, N'Annee', 2, NULL, NULL, N'20', 199, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (202, N'Caractere/', 3, NULL, NULL, N'/', 199, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (203, N'compteurBS', 4, NULL, NULL, NULL, 199, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (204, N'CodeBSCopim', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (205, N'CaractereBSCopim', 1, NULL, NULL, N'BS-CO', 204, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (206, N'Annee', 2, NULL, NULL, N'20', 204, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (207, N'Caractere/', 3, NULL, NULL, N'/', 204, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (208, N'compteurBSCopim', 4, NULL, NULL, NULL, 204, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (209, N'CodeBSCopimValid', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (210, N'CaractereBSCopimValid', 1, NULL, NULL, N'BS-CO', 209, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (211, N'AnneeValid', 2, NULL, NULL, N'19', 209, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (212, N'Caractere-Valid', 3, NULL, NULL, N'-', 209, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (213, N'compteurBSCopimValid', 4, NULL, NULL, NULL, 209, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (214, N'CodeBSValid', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (215, N'CaractereBSValid', 1, NULL, NULL, N'BS', 214, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (216, N'AnneeValid', 2, NULL, NULL, N'19', 214, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (217, N'CaractereValid', 3, NULL, NULL, N'-', 214, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (218, N'compteurBSValid', 4, NULL, NULL, NULL, 214, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (219, N'CodeAvoirClientValid', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (220, N'CaractereAV', 1, NULL, NULL, N'AV', 219, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (221, N'Annee', 2, NULL, N'string', N'20', 219, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (222, N'Caractere/', 3, NULL, NULL, N'/', 219, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (223, N'compteurAvoirClientValid', 4, NULL, NULL, NULL, 219, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (230, N'compteurIAClient', 4, NULL, NULL, NULL, 234, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (231, N'Caractere/', 3, NULL, NULL, N'/', 234, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (232, N'Annee', 2, NULL, NULL, N'20', 234, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (233, N'CaractereIA', 1, NULL, NULL, N'IA', 234, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (234, N'CodeIAClient', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (235, N'compteurIAClientValid', 4, NULL, NULL, NULL, 240, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (236, N'Caractere/', 3, NULL, NULL, N'/', 240, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (237, N'Annee', 2, NULL, NULL, N'20', 240, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (238, N'CaractereIAV', 1, NULL, NULL, N'IAV', 240, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (240, N'CodeIAClientValid', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (241, N'CodeBS-Reclamation', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (242, N'CaractereBS-Reclamation', 1, NULL, NULL, N'BS-RE', 241, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (243, N'Annee', 2, NULL, NULL, N'20', 241, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (244, N'Caractere/', 3, NULL, NULL, N'-', 241, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (245, N'compteurBS-Reclamation', 4, NULL, NULL, NULL, 241, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (246, N'CodeBE-Reclamation', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (247, N'CaractereBE-Reclamation', 1, NULL, NULL, N'BE-RE', 246, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (248, N'Annee', 2, NULL, NULL, N'20', 246, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (249, N'Caractere/', 3, NULL, NULL, N'-', 246, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (250, N'compteurBE-Reclamation', 4, NULL, NULL, NULL, 246, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (251, N'CodeQuotationSuppValid', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (252, N'compteurQuotationSuppValid', 4, NULL, NULL, NULL, 251, 1, 1, NULL, 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (253, N'Caractere-', 3, NULL, NULL, N'-', 251, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (254, N'Annee', 2, NULL, NULL, N'20', 251, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (255, N'CaractereQPUV', 1, NULL, NULL, N'D', 251, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (256, N'CodeOrderSuppValid', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (257, N'compteurOrderSuppValid', 4, NULL, NULL, NULL, 256, 1, 1, N'00000004', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (258, N'Caractere-', 3, NULL, NULL, N'-', 256, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (259, N'Annee', 2, NULL, NULL, N'20', 256, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (260, N'CaractereOPUV', 1, NULL, NULL, N'C', 256, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (261, N'CodeFOrderSuppValid', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (262, N'compteurFOrderSuppValid', 4, NULL, NULL, NULL, 261, 1, 1, N'00000004', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (263, N'Caractere-', 3, NULL, NULL, N'-', 261, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (264, N'Annee', 2, NULL, NULL, N'20', 261, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (265, N'CaractereFOPUV', 1, NULL, NULL, N'CF', 261, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (266, N'CodeInvoiceSuppValid', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (267, N'compteurInvoiceSuppValid', 4, NULL, NULL, NULL, 266, 1, 1, NULL, 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (268, N'Caractere-', 3, NULL, NULL, N'-', 266, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (269, N'Annee', 2, NULL, NULL, N'20', 266, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (270, N'CaractereIPUV', 1, NULL, NULL, N'F', 266, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (271, N'CodeDeliverySuppValid', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (272, N'compteurDeliverySuppValid', 4, NULL, NULL, NULL, 271, 1, 1, N'00000003', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (273, N'Caractere-', 3, NULL, NULL, N'-', 271, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (274, N'Annee', 2, NULL, NULL, N'20', 271, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (275, N'CaractereDPUV', 1, NULL, NULL, N'L', 271, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (276, N'CodeSettlement', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (277, N'CaractereSET', 1, NULL, NULL, N'SET', 276, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (278, N'Caractere-', 2, NULL, NULL, N'-', 276, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (279, N'compteurSettlement', 3, NULL, NULL, NULL, 276, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (280, N'CodeFC', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (281, N'CaractereFC', 1, NULL, NULL, N'FC', 280, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (282, N'AnneeFC', 2, NULL, NULL, N'20', 280, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (283, N'Caractere-', 3, NULL, NULL, N'-', 280, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (284, N'compteur FC', 4, NULL, NULL, NULL, 280, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (285, N'CodeAssetSuppValid', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (286, N'compteurAssetSuppValid', 4, NULL, NULL, NULL, 285, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (287, N'Caractere-', 3, NULL, NULL, N'-', 285, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (288, N'Annee', 2, NULL, NULL, N'20', 285, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (289, N'CaractereAPUV', 1, NULL, NULL, N'A', 285, 0, NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
SET IDENTITY_INSERT [Helpdesk].[ClaimStatus] ON
INSERT INTO [Helpdesk].[ClaimStatus] ([IdStatus], [Id], [CodeStatus], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, 1, N'NC', N'Nouvelle Réclamation', N'Nouvelle Réclamation', N'NEW_CLAIM', 0, 0, NULL)
INSERT INTO [Helpdesk].[ClaimStatus] ([IdStatus], [Id], [CodeStatus], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, 2, N'SC', N'Soumise au fournisseur', N'Soumise au fournisseur', N'SUBMITTED_CLAIM', 0, 0, NULL)
INSERT INTO [Helpdesk].[ClaimStatus] ([IdStatus], [Id], [CodeStatus], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, 3, N'AC', N'Accepté', N'Acceptée', N'ACCEPTED_CLAIM', 0, 0, NULL)
SET IDENTITY_INSERT [Helpdesk].[ClaimStatus] OFF
SET IDENTITY_INSERT [Shared].[TaxeType] ON
INSERT INTO [Shared].[TaxeType] ([Id], [TaxeTypeCode], [Description], [IdTaxeTypeCalculation], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'TVA', N'TVA', 0, 0, 0, NULL)
SET IDENTITY_INSERT [Shared].[TaxeType] OFF

INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (10, N'OK', N'OK', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (11, N'Annuler', N'Cancel', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (12, N'Veuillez indiquer le prix d''achat', N'Please indicate the purchase price', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (13, N'La date de mise en service doit être postérieure à la date d''aquisition', N'Date of commissioning must be greater than the date of aquisition', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (14, N'Veuillez choisir un employé', N'Please choose an employee', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (106, N'Veuillez vérifier que vos mots de passe correspondent', N'Please make sure your passwords match', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (107, N'La date de fin doit être postérieure à la date de début', N'The end date must be greater than the start date', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (108, N'Fomat invalide', N'Invalid format', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (109, N'La quantité maximale doit être plus grande que la quantité Minimale', N'Maximum quantity must be greater than Minimum quantity', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (110, N'Pourcentage dépassée', N'Exceeded percent', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (210, N'Ajout effectué avec succès', N'Added done successfully', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (211, N'Mise à jour effectuée avec succès', N'Update successfully completed', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (212, N'Suppression effectuée avec succès', N'Deletion successfully completed', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (216, N'Validation terminée avec succès', N'Validation successfully completed', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (218, N'Vos changements vont être pris en considération lors de la prochaine connexion.', N'Your changes will be taken into consideration at the next login.', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (219, N'Refus terminée avec succès', N'Reject successfully completed', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (418, N'Echec de suppression : entité validé', N'Validated entity', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (500, N'Erreur interne au serveur', N'Erreur interne au serveur', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (516, N'Chevauchement de date avec le client et l''article saisi', N'
Date overlap with the customer and the item entered', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (518, N'Ligne document déjà soldé', N'Document line already settled', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (519, N'Dépôt obligatoire', N'Warehouse required', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (520, N'Entité déjà utilisée', N'Entity already used', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (522, N'Tiers obligatoire', N'Tiers required', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (523, N'Date obligatoire', N'Date required', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (526, N'Le dépôt est obligatoire pour les articles gérés en stock.', N'The deposit is mandatory for inventory managed items.', N'', NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (550, N'existe déjà', N'already exist', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (551, N'existent déjà', N'already exists ', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (552, N'existent déjà', N'already exists ', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (553, N'Veuillez vérifier votre ancien mot de passe', N'
Please check your old password', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (554, N'✓ Mot de passe valide', N'✓ Valid password', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (555, N'Le mot de passe doit contenir 8 caractéres au minimum', N'The password must contain at least 8 characters', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (610, N'Voulez vous supprimer cette ligne? ', N'Do you want to delete this line?', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (611, N'En cours de modification..Voulez vous les supprimer?', N'Updating in progress, are you sure to delete those data ?', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (803, N'Taux de devise existe déjà', N'Currency Rate exist', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (805, N'Ajouter axe', N'Add axis', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (806, N'Veuillez indiquer un prix unitaire supérieur à zéro ', N'Please indicate an unit price upper to zero', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (807, N'Quantité insuffisante', N'Insufficient quantity', N'Quantité insuffisante', N'Quantité insuffisante', NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (808, N'Voulez vous valider ce document?', N'Do you want to validate this document?', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (809, N'Voulez vous valider ce règlement?', N'Do you want to validate this settlement?', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (811, N'Inventaire lancé avec succés', N'Inventory successfully launched', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (813, N'Article ajouté avec succés', N'Item successfully added', N'Article ajouté avec succés', NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (814, N'Article déjà sélectionné', N'Item already selected', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (815, N'Toutes les quantités actuelles sont recalculés', N'All current quantities are recalculated', N'Toutes les quantités actuelles sont recalculés', NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (816, N'Une erreur s''est produite', N'An error occurred', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (817, N'Ligne associée déjà soldée', N'Associated line already settled', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (818, N'Voulez-vous vraiment changer le dépôt ?/ Tous les articles séléctionnés vont être désélectionnés.', N'Do you really want to change the deposit? \r  All selected articles will be deselected.', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (819, N'Aucune ligne n''est ajoutée', N'No lines are added', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (820, N'Certains fichiers ne sont pas chargés car les extensions ne sont pas autorisées', N'Some files are not loaded because extensions are not allowed', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (821, N'Le fichier logo de l''entreprise n''est pas chargé car l''extension n''est pas autorisée', N'Company logo file is not loaded because the extension  is not allowed', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (822, N'Veuillez svp séléctionner l''unité de stock!', N'Select the stock unit plz!', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (823, N'Format de code IBAN est invalide ', N'IBAN format is not valid', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (824, N'Format de BBAN (RIB) n''est pas valide', N'BBAN format is not valid', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (825, N'Veuillez indiquer une quantité minimale supérieure à zéro', N'Please indicate a minimal quantity upper to zero', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (826, N'Veuillez indiquer une quantité maximale supérieure à zéro ', N'Please indicate a maximal quantity upper to zero', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (827, N'Ce document ne peut être validé car le montant total autorisé est dépassé', N'This document can not be validated because the total authorized amount is exceeded', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (828, N'Le tarif est utilisé dans un document, Vous ne pouvez pas le modifier!', N'The price is used in a document, you can not modify it!', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (829, N'Nombre de jours obligatoire', N'Number of days required', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (830, N'Jours de règlement obligatoire', N'Settlement day required', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (831, N'le pourcentage total ne doit pas dépasser 100%', N'the all percentage must not exceed than 100%', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (832, N'le pourcentage total doit être de 100%', N'the all percentage must be 100%', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (833, N'Le règlement n''est pas totalement soldé. ', N'The settlement is not totally settled.', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (834, N'Veuillez indiquer un montant du règlement supérieur à zéro', N'Please indicate a settlement amount upper to zero', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (835, N'Vous devez affecter des échéances aux réglement.', N'You should affect commitments to settlement', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (836, N'Règlement contient des échéances soldées', N'Settlement contains cleared financial commitment
', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (840, N'Pièce(s) jointe(s) non valide(s)', N'Invalid attachment(s)', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (850, N'Veuillez indiquer un IBAN valide. Format requis: Code Pays + Clé IBAN + RIB', N'Please indicate a valid IBAN. Required format: code Country + Key IBAN + RIB', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (851, N'Veuillez indiquer le nombre d''enfants', N'Please indicate the childrens number', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (852, N'La date de fin de contrat doit être postérieure à la date du recrutement', N'The end contract date must be greater than the recruitmenet date', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (853, N'La date de recrutement doit être postérieure à la date de naissance', N'The recruitment date must be greater than the birth date', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (854, N'Veuillez vérifier le format de l''année d''obtention de diplôme', N'Please verify the graduation year format', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (855, N'La date de naissance ne peut pas être postérieure à la date actuelle', N'The birth date can not be greater than the current date', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (856, N'Insertion Interdite! Montant échéance restant négatif.', N'Prohibated Insertion! Negative remaining amount of commitment.', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (857, N'Montant insuffisant', N'Insufficient Amount', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (858, N'L''échéance est déjà soldé!', N'The settlement is settled', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (859, N'Le montant restant du règlement est inférieur ou égale à zéro!', N'The settlement remaining amount is less or equal to zero!', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (860, N'Veuillez confirmer votre refus de la demande d''achat', N'Please confirm your refusal of the purchase request', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (870, N'Veuillez affecter des fournisseurs à tous les articles sélectionnés', N'Set supplier to selected items', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (890, N'Un utilisateur doit avoir au moins un rôle', N'A user must have at least one role', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (891, N'Le manager sélectionné est l''un de vos collaborateurs', N'The selected manager is one of your employees', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (892, N'Il faut valider tous les factures antérieures. ', N'You must validate all previous invoices.', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (893, N'Il y a de(s) facture(s) postérieure(s) validée(s).', N'
There are approved subsequent invoice(s).', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (894, N'Erreur sécurité: vous essayez de modifier le mot de passe d''un autre utilisateur!', N'Security Error: You are trying to change another user''s password!', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (895, N'Erreur sécurité: vous essayez de modifier le profil d''un autre utilisateur!', N'Security Error: You are trying to change another user''s profile!', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (896, N'Client est requis!', N'Customer is required!', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (897, N'Fournisseur est requis!', N'Supplier is required!', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (898, N'Article est invalid!', N'Item is invalid!', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (899, N'La valeur de taux tva est invalide!. Merci de vérifier la configuration des taxs.', N'The VAT rate value is invalid !. Please check the tax configuration.', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (900, N'La devise du client est requise! Merci de vérifier la devise du client.', N'The customer currency  is required !. Thank you to check the customer currency.', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (901, N'La devise du fournisseur est requise! Merci de vérifier la devise du fournisseur.', N'The supplier currency is required !. Thank you to check the supplier currency.', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (1000, N'L''actif est déjà affecté durant cette période', N'The asset is already affected during this period', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (4060, N'La connexion à la base de données a échoué. Essayez de vous reconnecter. Si le problème persiste, contactez l''administrateur du site.', N'The connection to the database failed.Try to reconnect.If the problem persists, contact the administrator of the site.', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (6000, N'La formule de la règle salariale est lexicalement erronée', N'The salary rule formula is lexically wrong', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (6001, N'La formule de la règle salariale est syntaxiquement erronée', N'The salary rule formula is syntactically wrong', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (6002, N'Erreur d''éxécution de la règle salariale', N'Error in the execution of the salary rule', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9000, N'Vous devez saisir le montant du contrat avant!', N'You should set the contract value!', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9001, N'Vous devez saisir le total du prime avant!', N'You should set the bonus value!', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9002, N'La somme des pourcentages de commerciaux est différente du 100% durant la période :', N'The commercials percentage must be 100% 
during the period:', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9003, N'La somme des pourcentages de consultants est différente du 100% durant la période :', N'The consultants percentage must be 100% 
during the period:', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9004, N'La somme des montants de prime est différente du total du prime durant la période :', N'Commrcials bonus must be equal to total bonus during the period:', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9007, N'Ce type de prestation nécessite un seul consultant!', N'You should set only one consultant for this service type!', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9008, N'Vous devez sélectionner le type de prestation!', N'You should select service type!', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9009, N'Date début période doit être supérieure ou égale à la date début contrat', N'Start date should be greeter than contract start date', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9010, N'Date fin période doit être inférieure ou égale à la date fin contrat', N'End date should be less than contract end date', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9011, N'Veuillez indiquer la date du début contrat', N'Please indicate the contract start date', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9012, N'Veuillez indiquer la date de fin contrat', N'Please indicate the contract end date', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9013, N'La somme des pourcentages de commerciaux est différente du 100% à partir de :', N'The commercials percentage must be 100% from:', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9014, N'La somme des pourcentages de consultants est différente du 100% à partir de :', N'The consultants percentage must be 100% from:', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9015, N'La somme des montants de prime est différente du total du prime à partir de :', N'Commrcials bonus must be equal to total bonus from:', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9016, N'Oui', N'Yes', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9017, N'Non', N'No', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9018, N'Prime', N'Premium', NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT INTO [ERPSettings].[Notification] ([IdNotification], [FR], [EN], [AR], [DE], [CH], [ES], [TransactionUserId], [IsDeleted], [Deleted_Token]) VALUES (9019, N'Dépôt', N'Warehouse', NULL, NULL, NULL, NULL, NULL, 0, NULL)
ALTER TABLE [Shared].[ContactTypeDocument]
    ADD CONSTRAINT [FK_ContactTypeDocument_Contact] FOREIGN KEY ([IdContact]) REFERENCES [Shared].[Contact] ([Id]) ON DELETE CASCADE
ALTER TABLE [Inventory].[ItemKit]
    ADD CONSTRAINT [FK_ItemKit_Item1] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id])
ALTER TABLE [Inventory].[ItemKit]
    ADD CONSTRAINT [FK_ItemKit_Item] FOREIGN KEY ([IdKit]) REFERENCES [Inventory].[Item] ([Id])
ALTER TABLE [Payment].[ReflectiveSettlement]
    ADD CONSTRAINT [FK_ReflectiveSettlement_Settlement] FOREIGN KEY ([IdSettlement]) REFERENCES [Payment].[Settlement] ([Id])
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [Sales].[DocumentLinePrices]
    ADD CONSTRAINT [FK_DocumentLinePrices_Prices] FOREIGN KEY ([IdPrices]) REFERENCES [Sales].[Prices] ([Id])
ALTER TABLE [Sales].[DocumentLinePrices]
    ADD CONSTRAINT [FK_DocumentLinePrices_DocumentLine] FOREIGN KEY ([IdDocumentLine]) REFERENCES [Sales].[DocumentLine] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payment].[WithholdingTaxLine]
    ADD CONSTRAINT [FK_WithholdingTaxLine_WithholdingTax] FOREIGN KEY ([IdWithholdingTax]) REFERENCES [Payment].[WithholdingTax] ([Id])
ALTER TABLE [Sales].[SearchItem]
    ADD CONSTRAINT [FK_SearchItem_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Sales].[SearchItem]
    ADD CONSTRAINT [FK_SearchItem_User] FOREIGN KEY ([IdCashier]) REFERENCES [ERPSettings].[User] ([Id])
ALTER TABLE [ERPSettings].[ReportTemplate]
    ADD CONSTRAINT [FK_ReportTemplate_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [Treasury].[DetailTimetable]
    ADD CONSTRAINT [FK_DetailTimetable_Timetable] FOREIGN KEY ([IdTimetable]) REFERENCES [Treasury].[Timetable] ([Id])
ALTER TABLE [Treasury].[DetailTimetable]
    ADD CONSTRAINT [FK_DetailTimetable_PaymentType] FOREIGN KEY ([IdPaymentType]) REFERENCES [Payment].[PaymentType] ([Id])
ALTER TABLE [Shared].[Hours]
    ADD CONSTRAINT [FK_Hours_Period] FOREIGN KEY ([IdPeriod]) REFERENCES [Shared].[Period] ([Id]) ON DELETE CASCADE
ALTER TABLE [Shared].[Bank]
    ADD CONSTRAINT [FK_Bank_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id])
ALTER TABLE [Payment].[SettlementCommitment]
    ADD CONSTRAINT [FK_SettlementCommitment_Settlement] FOREIGN KEY ([SettlementId]) REFERENCES [Payment].[Settlement] ([Id]) ON DELETE CASCADE
ALTER TABLE [Payment].[SettlementCommitment]
    ADD CONSTRAINT [FK_SettlementCommitment_FinancialCommitment] FOREIGN KEY ([CommitmentId]) REFERENCES [Sales].[FinancialCommitment] ([Id])
ALTER TABLE [Inventory].[StockDocument]
    ADD CONSTRAINT [FK_StockDocument_Warehouse1] FOREIGN KEY ([IdWarehouseSource]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [Inventory].[StockDocument]
    ADD CONSTRAINT [FK_StockDocument_TypeStockDocument] FOREIGN KEY ([TypeStockDocument]) REFERENCES [Inventory].[StockDocumentType] ([CodeType])
ALTER TABLE [Inventory].[StockDocument]
    ADD CONSTRAINT [FK_StockDocument_DocumentStatus] FOREIGN KEY ([IdDocumentStatus]) REFERENCES [Sales].[DocumentStatus] ([Id])
ALTER TABLE [Inventory].[StockDocument]
    ADD CONSTRAINT [FK_StockDocument_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Inventory].[StockDocument]
    ADD CONSTRAINT [FK_StockDocument_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id])
ALTER TABLE [Inventory].[StockDocument]
    ADD CONSTRAINT [FK_StockDocument_Warehouse] FOREIGN KEY ([IdWarehouseDestination]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [Sales].[ProvisioningDetails]
    ADD CONSTRAINT [FK_ProvisioningDetails_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id])
ALTER TABLE [Sales].[ProvisioningDetails]
    ADD CONSTRAINT [FK_ProvisioningDetails_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Sales].[ProvisioningDetails]
    ADD CONSTRAINT [FK_ProvisioningDetails_Provisioning] FOREIGN KEY ([IdProvisioning]) REFERENCES [Sales].[Provisioning] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [Administration].[EntityAxisValues]
    ADD CONSTRAINT [FK_EntityAxisValues_AxisValue] FOREIGN KEY ([IdAxisValue]) REFERENCES [Administration].[AxisValue] ([Id])
ALTER TABLE [Administration].[EntityAxisValues]
    ADD CONSTRAINT [FK_EntityAxisValues_Entity] FOREIGN KEY ([Entity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [Inventory].[SubFamily]
    ADD CONSTRAINT [FK_SubFamily_Family] FOREIGN KEY ([IdFamily]) REFERENCES [Inventory].[Family] ([Id])
ALTER TABLE [Sales].[TaxeGroupTiersConfig]
    ADD CONSTRAINT [FK_TaxeTiersConfig_TaxeGroupTiers] FOREIGN KEY ([IdTaxeGroupTiers]) REFERENCES [Sales].[TaxeGroupTiers] ([Id]) ON DELETE CASCADE
ALTER TABLE [Sales].[TaxeGroupTiersConfig]
    ADD CONSTRAINT [FK_TaxeTiersConfig_Taxe] FOREIGN KEY ([IdTaxe]) REFERENCES [Shared].[Taxe] ([Id])
ALTER TABLE [Sales].[SaleSettings]
    ADD CONSTRAINT [FK_SaleSetting_Company] FOREIGN KEY ([Id]) REFERENCES [Shared].[Company] ([Id])
ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_BankAccount] FOREIGN KEY ([IdBankAccount]) REFERENCES [Shared].[BankAccount] ([Id])
ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_DocumentStatus] FOREIGN KEY ([IdStatus]) REFERENCES [Sales].[DocumentStatus] ([Id])
ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_PaymentStatus] FOREIGN KEY ([IdPaymentStatus]) REFERENCES [Payment].[PaymentStatus] ([Id])
ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_Currency] FOREIGN KEY ([IdUsedCurrency]) REFERENCES [Administration].[Currency] ([Id])
ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_PaymentMethod] FOREIGN KEY ([IdPaymentMethod]) REFERENCES [Payment].[PaymentMethod] ([Id])
ALTER TABLE [Payment].[Settlement]
    ADD CONSTRAINT [FK_Settlement_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Sales].[DetailsSettlementMode]
    ADD CONSTRAINT [FK_DetailsSettlementMode_SettlementType] FOREIGN KEY ([IdSettlementType]) REFERENCES [Sales].[SettlementType] ([Id]) ON DELETE SET NULL
ALTER TABLE [Sales].[DetailsSettlementMode]
    ADD CONSTRAINT [FK_DetailsSettlementMode_PaymentMethod] FOREIGN KEY ([IdPaymentMethod]) REFERENCES [Payment].[PaymentMethod] ([Id]) ON DELETE SET NULL
ALTER TABLE [Sales].[DetailsSettlementMode]
    ADD CONSTRAINT [FK_DetailsSettlementMode_SettlementMode] FOREIGN KEY ([IdSettlementMode]) REFERENCES [Sales].[SettlementMode] ([Id]) ON DELETE SET NULL
ALTER TABLE [Payment].[PaymentMethod]
    ADD CONSTRAINT [FK_PayementMethod_PayementType] FOREIGN KEY ([IdPaymentType]) REFERENCES [Payment].[PaymentType] ([Id])
ALTER TABLE [Immobilisation].[History]
    ADD CONSTRAINT [FK_History_Active] FOREIGN KEY ([IdActive]) REFERENCES [Immobilisation].[Active] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [Immobilisation].[History]
    ADD CONSTRAINT [FK_History_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [Treasury].[Timetable]
    ADD CONSTRAINT [FK_Timetable_PaymentType] FOREIGN KEY ([IdPaymentType]) REFERENCES [Payment].[PaymentType] ([Id])
ALTER TABLE [Treasury].[Timetable]
    ADD CONSTRAINT [FK_Timetable_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Helpdesk].[ClaimInteraction]
    ADD CONSTRAINT [FK_ClaimInteraction_Claim] FOREIGN KEY ([IdClaim]) REFERENCES [Helpdesk].[Claim] ([Id])

ALTER TABLE [Shared].[ZipCode]
    ADD CONSTRAINT [FK_ZipCode_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id])
ALTER TABLE [Shared].[DayOff]
    ADD CONSTRAINT [FK_DayOff_Period] FOREIGN KEY ([IdPeriod]) REFERENCES [Shared].[Period] ([Id]) ON DELETE CASCADE
ALTER TABLE [Inventory].[MovementHistory]
    WITH NOCHECK ADD CONSTRAINT [FK_MovementHistory_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id])
ALTER TABLE [Treasury].[DetailReconciliation]
    ADD CONSTRAINT [FK_DetailReconciliation3] FOREIGN KEY ([IdDetailTimetable]) REFERENCES [Treasury].[DetailTimetable] ([Id])
ALTER TABLE [Treasury].[DetailReconciliation]
    ADD CONSTRAINT [FK_DetailReconciliation] FOREIGN KEY ([IdReconciliation]) REFERENCES [Treasury].[Reconciliation] ([Id])
ALTER TABLE [Sales].[FinancialCommitment]
    ADD CONSTRAINT [FK_FinancialCommitment_Currency] FOREIGN KEY ([IdCurrency]) REFERENCES [Administration].[Currency] ([Id])
ALTER TABLE [Sales].[FinancialCommitment]
    ADD CONSTRAINT [FK_FinancialCommitment_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Sales].[FinancialCommitment]
    ADD CONSTRAINT [FK_FinancialCommitment_DocumentStatus] FOREIGN KEY ([IdStatus]) REFERENCES [Sales].[DocumentStatus] ([Id])
ALTER TABLE [Sales].[FinancialCommitment]
    ADD CONSTRAINT [FK_FinancialCommitment_PaymentMethod] FOREIGN KEY ([IdPaymentMethod]) REFERENCES [Payment].[PaymentMethod] ([Id])
ALTER TABLE [Sales].[FinancialCommitment]
    ADD CONSTRAINT [FK_FinancialCommitment_Document] FOREIGN KEY ([IdDocument]) REFERENCES [Sales].[Document] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Codification] FOREIGN KEY ([IdCodification]) REFERENCES [ERPSettings].[Codification] ([Id])
ALTER TABLE [ERPSettings].[EntityCodification]
    ADD CONSTRAINT [FK_EntityCodification_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [Inventory].[ModelOfItem]
    ADD CONSTRAINT [FK_Model_Brand] FOREIGN KEY ([IdVehicleBrand]) REFERENCES [Inventory].[VehicleBrand] ([Id])
ALTER TABLE [Shared].[Company]
    ADD CONSTRAINT [FK_Company_Currency] FOREIGN KEY ([IdCurrency]) REFERENCES [Administration].[Currency] ([Id])
ALTER TABLE [Immobilisation].[Active]
    ADD CONSTRAINT [FK_Active_DocumentLine1] FOREIGN KEY ([IdDocumentLine]) REFERENCES [Sales].[DocumentLine] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [Immobilisation].[Active]
    ADD CONSTRAINT [FK_Active_Warehouse] FOREIGN KEY ([IdWarehouse]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [Immobilisation].[Active]
    ADD CONSTRAINT [FK_Active_Category1] FOREIGN KEY ([IdCategory]) REFERENCES [Immobilisation].[Category] ([Id])
ALTER TABLE [Sales].[DocumentLineNegotiationOptions]
    ADD CONSTRAINT [FK_DocumentLineNegotiationOptions_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id])
ALTER TABLE [Sales].[DocumentLineNegotiationOptions]
    ADD CONSTRAINT [FK_DocumentLineNegotiationOptions_User] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id])
ALTER TABLE [Sales].[DocumentLineNegotiationOptions]
    ADD CONSTRAINT [FK_DocumentLineNegotiationOptions_DocumentLineNegotiationOptions] FOREIGN KEY ([IdDocumentLine]) REFERENCES [Sales].[DocumentLine] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [Shared].[NewUserEmail]
    ADD CONSTRAINT [FK_NewUserEmail] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id]) ON DELETE CASCADE
ALTER TABLE [Shared].[NewUserEmail]
    ADD CONSTRAINT [FK_Mail] FOREIGN KEY ([IdEmail]) REFERENCES [Shared].[Email] ([Id]) ON DELETE CASCADE
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
ALTER TABLE [Inventory].[StockDocumentLine]
    ADD CONSTRAINT [FK_StockDocumentLine_StockDocument] FOREIGN KEY ([IdStockDocument]) REFERENCES [Inventory].[StockDocument] ([Id]) ON DELETE CASCADE
ALTER TABLE [Inventory].[StockDocumentLine]
    ADD CONSTRAINT [FK_StockDocumentLine_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id])
ALTER TABLE [Inventory].[StockDocumentLine]
    ADD CONSTRAINT [FK_StockDocumentLine_Warehouse] FOREIGN KEY ([IdWarehouse]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [Sales].[Tiers_Provisioning]
    ADD CONSTRAINT [FK_Tiers_Provisioning_Provisioning] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Sales].[Tiers_Provisioning]
    ADD CONSTRAINT [FK_Tiers_Provisioning_Tiers_Provisioning] FOREIGN KEY ([IdProvisioning]) REFERENCES [Sales].[Provisioning] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [Sales].[Provisioning]
    ADD CONSTRAINT [FK_Provisioning_ProvisioningOption] FOREIGN KEY ([IdProvisioningOption]) REFERENCES [Sales].[ProvisioningOption] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE [Helpdesk].[Claim]
    ADD CONSTRAINT [FK_Claim_PurchaseDocument] FOREIGN KEY ([IdPurchaseDocument]) REFERENCES [Sales].[Document] ([Id])
ALTER TABLE [Helpdesk].[Claim]
    ADD CONSTRAINT [FK_Claim_ReceiptDocument] FOREIGN KEY ([IdReceiptDocument]) REFERENCES [Sales].[Document] ([Id])
ALTER TABLE [Helpdesk].[Claim]
    ADD CONSTRAINT [FK_Claim_SalesDocument] FOREIGN KEY ([IdSalesDocument]) REFERENCES [Sales].[Document] ([Id])
ALTER TABLE [Helpdesk].[Claim]
    ADD CONSTRAINT [FK_Claim_DeliveryDocument] FOREIGN KEY ([IdDeliveryDocument]) REFERENCES [Sales].[Document] ([Id])
ALTER TABLE [Helpdesk].[Claim]
    ADD CONSTRAINT [FK_Claim_ClaimStatus] FOREIGN KEY ([IdClaimStatus]) REFERENCES [Helpdesk].[ClaimStatus] ([IdStatus])
ALTER TABLE [Helpdesk].[Claim]
    ADD CONSTRAINT [FK_Claim_SalesAssetDocument] FOREIGN KEY ([IdSalesAssetDocument]) REFERENCES [Sales].[Document] ([Id])
ALTER TABLE [Helpdesk].[Claim]
    ADD CONSTRAINT [FK_Claim_PurchaseAssetDocument] FOREIGN KEY ([IdPurchaseAssetDocument]) REFERENCES [Sales].[Document] ([Id])
ALTER TABLE [Helpdesk].[Claim]
    ADD CONSTRAINT [FK_Claim_ClaimType] FOREIGN KEY ([ClaimType]) REFERENCES [Helpdesk].[ClaimType] ([CodeType])
ALTER TABLE [Helpdesk].[Claim]
    ADD CONSTRAINT [FK_Claim_Contact] FOREIGN KEY ([IdContact]) REFERENCES [Shared].[Contact] ([Id])
ALTER TABLE [Helpdesk].[Claim]
    ADD CONSTRAINT [FK_Claim_Client] FOREIGN KEY ([IdClient]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Helpdesk].[Claim]
    ADD CONSTRAINT [FK_Claim_Fournisseur] FOREIGN KEY ([IdFournisseur]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Helpdesk].[Claim]
    ADD CONSTRAINT [FK_Claim_Document] FOREIGN KEY ([IdDocument]) REFERENCES [Sales].[Document] ([Id])
ALTER TABLE [Helpdesk].[Claim]
    ADD CONSTRAINT [FK_Claim_DocumentLine] FOREIGN KEY ([IdDocumentLine]) REFERENCES [Sales].[DocumentLine] ([Id])
ALTER TABLE [Helpdesk].[Claim]
    ADD CONSTRAINT [FK_Claim_Warehouse] FOREIGN KEY ([IdWarehouse]) REFERENCES [Inventory].[Warehouse] ([Id])
ALTER TABLE [Helpdesk].[Claim]
    ADD CONSTRAINT [FK_Claim_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id])
ALTER TABLE [Helpdesk].[Claim]
    ADD CONSTRAINT [FK_Claim_MovementIn] FOREIGN KEY ([IdMovementIn]) REFERENCES [Sales].[Document] ([Id])
ALTER TABLE [Helpdesk].[Claim]
    ADD CONSTRAINT [FK_Claim_MovementOut] FOREIGN KEY ([IdMovementOut]) REFERENCES [Sales].[Document] ([Id])
ALTER TABLE [Inventory].[ItemVehicleBrandModelSubModel]
    ADD CONSTRAINT [FK_ItemVehicleBrandModelSubModel_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id])
ALTER TABLE [Inventory].[ItemVehicleBrandModelSubModel]
    ADD CONSTRAINT [FK_ItemVehicleBrandModelSubModel_ModelOfItem] FOREIGN KEY ([IdModel]) REFERENCES [Inventory].[ModelOfItem] ([Id])
ALTER TABLE [Inventory].[ItemVehicleBrandModelSubModel]
    ADD CONSTRAINT [FK_ItemVehicleBrandModelSubModel_SubModel] FOREIGN KEY ([IdSubModel]) REFERENCES [Inventory].[SubModel] ([Id])
ALTER TABLE [Inventory].[ItemVehicleBrandModelSubModel]
    ADD CONSTRAINT [FK_ItemVehicleBrandModelSubModel_VehicleBrand] FOREIGN KEY ([IdVehicleBrand]) REFERENCES [Inventory].[VehicleBrand] ([Id])
ALTER TABLE [Inventory].[SubModel]
    ADD CONSTRAINT [FK_SubModel_Model] FOREIGN KEY ([IdModel]) REFERENCES [Inventory].[ModelOfItem] ([Id])
ALTER TABLE [ERPSettings].[Comment]
    ADD CONSTRAINT [FK_Comment_Entity] FOREIGN KEY ([IdEntityReference]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [Sales].[PriceRequestDetail]
    ADD CONSTRAINT [FK_PriceRequestDetail_Contact] FOREIGN KEY ([IdContact]) REFERENCES [Shared].[Contact] ([Id])
ALTER TABLE [Sales].[PriceRequestDetail]
    ADD CONSTRAINT [FK_PriceRequestDetail_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Sales].[PriceRequestDetail]
    ADD CONSTRAINT [FK_PriceRequestDetail_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id])
ALTER TABLE [Sales].[PriceRequestDetail]
    ADD CONSTRAINT [FK_PriceRequestDetail_PriceRequest] FOREIGN KEY ([IdPriceRequest]) REFERENCES [Sales].[PriceRequest] ([Id]) ON DELETE CASCADE
ALTER TABLE [Shared].[Taxe]
    ADD CONSTRAINT [FK_Taxe_TaxeType] FOREIGN KEY ([IdTaxeType]) REFERENCES [Shared].[TaxeType] ([Id])
ALTER TABLE [Sales].[DocumentExpenseLine]
    ADD CONSTRAINT [FK_DocumentExpenseLine_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Sales].[DocumentExpenseLine]
    ADD CONSTRAINT [FK_DocumentExpenseLine_Taxe] FOREIGN KEY ([IdTaxe]) REFERENCES [Shared].[Taxe] ([Id])
ALTER TABLE [Sales].[DocumentExpenseLine]
    ADD CONSTRAINT [FK_DocumentExpenseLine_Expense] FOREIGN KEY ([IdExpense]) REFERENCES [Sales].[Expense] ([Id])
ALTER TABLE [Sales].[DocumentExpenseLine]
    ADD CONSTRAINT [FK_DocumentExpenseLine_Document] FOREIGN KEY ([IdDocument]) REFERENCES [Sales].[Document] ([Id]) ON DELETE CASCADE
ALTER TABLE [Sales].[DocumentExpenseLine]
    ADD CONSTRAINT [FK_DocumentExpenseLine_Currency] FOREIGN KEY ([IdCurrency]) REFERENCES [Administration].[Currency] ([Id])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [Sales].[PurchaseSettings]
    ADD CONSTRAINT [FK_PurchaseSetting_Company] FOREIGN KEY ([Id]) REFERENCES [Shared].[Company] ([Id])
ALTER TABLE [Sales].[PurchaseSettings]
    ADD CONSTRAINT [FK_PurchaseSettings_User] FOREIGN KEY ([IdPurchasingManager]) REFERENCES [ERPSettings].[User] ([Id])
ALTER TABLE [ERPSettings].[UserInfo]
    ADD CONSTRAINT [FK_Info_UserInfo] FOREIGN KEY ([IdInformation]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[UserInfo]
    ADD CONSTRAINT [FK_User_UserInfo] FOREIGN KEY ([IdUser]) REFERENCES [ERPSettings].[User] ([Id])
ALTER TABLE [ERPSettings].[User]
    ADD CONSTRAINT [FK_User_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
ALTER TABLE [ERPSettings].[User]
    ADD CONSTRAINT [FK_User_User] FOREIGN KEY ([IdUserParent]) REFERENCES [ERPSettings].[User] ([Id])
ALTER TABLE [ERPSettings].[User]
    ADD CONSTRAINT [FK_User_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
ALTER TABLE [Shared].[BankAccount]
    ADD CONSTRAINT [FK_BankAccount_Bank] FOREIGN KEY ([IdBank]) REFERENCES [Shared].[Bank] ([Id])
ALTER TABLE [Shared].[City]
    ADD CONSTRAINT [FK_City_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id]) ON DELETE CASCADE
ALTER TABLE [Sales].[DocumentTypeRelation]
    ADD CONSTRAINT [FK_DocumentTypeRelation_DocumentTypeRelation] FOREIGN KEY ([CodeDocumentType]) REFERENCES [Sales].[DocumentType] ([CodeType])
ALTER TABLE [Sales].[DocumentTypeRelation]
    ADD CONSTRAINT [FK_DocumentTypeRelation_DocumentType] FOREIGN KEY ([CodeDocumentTypeAssociated]) REFERENCES [Sales].[DocumentType] ([CodeType])
ALTER TABLE [Sales].[DocumentType]
    ADD CONSTRAINT [FK_DocumentType_DocumentType] FOREIGN KEY ([DefaultCodeDocumentTypeAssociated]) REFERENCES [Sales].[DocumentType] ([CodeType])
ALTER TABLE [Treasury].[ReceiptSpent]
    ADD CONSTRAINT [FK_ReceiptSpent_PaymentMethod] FOREIGN KEY ([IdPaymentMethod]) REFERENCES [Payment].[PaymentMethod] ([Id])
ALTER TABLE [Treasury].[ReceiptSpent]
    ADD CONSTRAINT [FK_RecipeSpent_PaymentDirection] FOREIGN KEY ([IdPaymentDirection]) REFERENCES [Treasury].[PaymentDirection] ([Id])
ALTER TABLE [Treasury].[ReceiptSpent]
    ADD CONSTRAINT [FK_RecipeSpent_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id])
COMMIT TRANSACTION


--Fatma role and codification  financial asset
BEGIN TRANSACTION
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (290, N'InvoiceFinancialRestaurn', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (291, N'InvoiceFinancialRestaurCode', 1, NULL, NULL, N'AF-R', 290, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (292, N'InvoiceFinancialRestaurnAnnee', 2, NULL, NULL, N'20', 290, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (293, N'InvoiceFinancialRestaurnCaratere', 3, NULL, NULL, N'/', 290, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (294, N'InvoiceFinancialRestaurnCompteur', 4, NULL, NULL, NULL, 290, 1, 1, N'00000000', 8)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (295, N'InvoiceFinancialRestaurnValid', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (296, N'InvoiceFinancialRestaurCodeValid', 1, NULL, NULL, N'A-AF-R', 295, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (297, N'InvoiceFinancialRestaurnAnneeValid', 2, NULL, NULL, N'20', 295, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (298, N'InvoiceFinancialRestaurnCaratereValid', 3, NULL, NULL, N'/', 295, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (299, N'InvoiceFinancialRestaurnCompteurValid', 4, NULL, NULL, NULL, 295, 1, 1, N'00000000', 8)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (59, 87, N'DocumentTypeCode', N'AF-R', 290)
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (60, 87, N'DocumentTypeCode', N'A-AF-R', 295)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
SET IDENTITY_INSERT [Inventory].[Nature] ON
INSERT INTO [Inventory].[Nature] ([Id], [Code], [Label], [IsStockManaged], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'Ristourne', N'Ristourne', 0, 0, 0, NULL)
SET IDENTITY_INSERT [Inventory].[Nature] OFF
COMMIT TRANSACTION


BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
UPDATE [ERPSettings].[Codification] SET [InitValue]=N'AF' WHERE [Id]=291
UPDATE [ERPSettings].[Codification] SET [InitValue]=N'AF' WHERE [Id]=296
UPDATE [ERPSettings].[Codification] SET [InitValue]=N'-' WHERE [Id]=298
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
COMMIT TRANSACTION 



BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
GO
SET IDENTITY_INSERT [ERPSettings].[Information] ON
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501202, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'Le CRA du mois de {MONTH} de l''employé {EMPLOYEE} nécessite une correction', N'The timesheet of {MONTH} of {EMPLOYEE} requires a correction', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_CORRECTION_REQUEST_TIMESHEET', N'CORRECTION_REQUEST_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501204, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'{VALIDATOR} a validé le CRA {MONTH} de {EMPLOYEE}', N'{VALIDATOR} validated the timesheet {MONTH} of {EMPLOYEE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_VALIDATION_TIMESHEET', N'VALIDATION_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501207, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/review', N' votre entretien annuel sera dans {REVIEW_DAYS_NUMBER} le  {REVIEW_DATE}', N' your annual review will be in {REVIEW_DAYS_NUMBER} days time on {REVIEW_DATE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP-Notification', 0, 0, NULL, N'NOTIFICATION_REVIEW', N'ANNUAL_REVIEW')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501209, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/recruitment-request/edit', N'{CREATOR} a validé la demande de recrutement {DOC_CODE} {PROFIL}', N'{CREATOR} validated the recruitment request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_VALIDATE_RECRUITMENT_REQUEST', N'VALIDATE_RECRUITMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501213, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/recruitment-request/edit', N'{CREATOR} a refusé la demande de recrutement {DOC_CODE} {PROFIL}', N'{CREATOR} refused the recruitment request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_REFUSE_RECRUITMENT_REQUEST', N'REFUSE_RECRUITMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501214, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/recruitment-request/edit', N'{CREATOR} a annulé la demande de recrutement {DOC_CODE} {PROFIL}', N'{CREATOR} canceled the recruitment request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_CANCEL_RECRUITMENT_REQUEST', N'CANCEL_RECRUITMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501215, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/recruitment-request/edit', N'{CREATOR} a ajouté un commentaire pour la demande de recrutement{CODE}', N'{CREATOR} added a comment for the recruitment request {CODE}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_COMMENT_RECRUITMENT_REQUEST', N'ADD_COMMENT_RECRUITMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501226, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/exit-employee', N'{CREATOR} a refusé la demande de sortie employee {DOC_CODE} {PROFIL}', N'{CREATOR} refused the exit employee request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_VALIDATE_EXIT_EMPLOYEE_REQUEST', N'VALIDATE_EXIT_EMPLOYEE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501227, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/exit-employee', N'{CREATOR} a refusé la demande de sortie employé {DOC_CODE} {PROFIL}', N'{CREATOR} refused the exit employee request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_REFUSE_EXIT_EMPLOYEE_REQUEST', N'REFUSE_EXIT_EMPLOYEE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501230, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/exit-employee', N'{CREATOR} a annulé la demande de sortie employé {DOC_CODE} {PROFIL}', N'{CREATOR} canceled the exit employee request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_CANCEL_EXIT_EMPLOYEE_REQUEST', N'CANCEL_EXIT_EMPLOYEE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501231, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/exit-employee/show', N'{CREATOR} a ajouté  une demande de sortie employé {DOC_CODE} {PROFIL}', N'{CREATOR} added a new exit employee request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_ADD_EXIT_EMPLOYEE_REQUEST', N'ADD_EXIT_EMPLOYEE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501232, N'8d30ee0f-9dba-47cd-a84c-4fd9fa771d0d', N'/rh/mobility-request/edit', N'Une demande de mobilité a été ajouté pour {EMPLOYEE_FULLNAME} (depuis son bureau actuel {CURRENT_OFFICE_NAME} vers le bureau {DESTINATION_OFFICE_NAME})', N'A mobility request has been added for{EMPLOYEE_FULLNAME} (from his current office {CURRENT_OFFICE_NAME} to the office {DESTINATION_OFFICE_NAME})', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_ADD_MOBILITY_REQUEST', N'ADD_MOBILITY_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501233, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'{CREATOR} a partiellement validé le CRA de {MONTH} {PROFIL}', N'{CREATOR} has partially validated the timesheet of {MONTH} {PROFILE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_PARTTIALLY_VALIDATED_TIMESHEET', N'PARTTIALLY_VALIDATED_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501234, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'{CREATOR} a soumis le CRA de {MONTH} {PROFIL}', N'{CREATOR} has submited the timesheet of {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_SUBMIT_TIMESHEET', N'SUBMIT_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501235, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'{CREATOR} a validé le CRA de {MONTH} {PROFIL}', N'{CREATOR} has validated the timesheet of {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_VALIDATE_TIMESHEET', N'VALIDATE_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501238, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'{CREATOR} a fait une correction du CRA de {MONTH} {PROFIL}', N'{CREATOR} made a correction of the timesheet of {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_CORRECTE_TIMESHEET', N'CORRECTE_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501239, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'Le CRA du mois de {MONTH} de l''employé {EMPLOYEE} nécessite une correction', N'The timesheet of {MONTH} of {EMPLOYEE} requires a correction', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_CORRECTION_REQUEST_TIMESHEET', N'CORRECTION_REQUEST_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501240, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'{VALIDATOR} a soumis le CRA {MONTH} de {EMPLOYEE}', N'{VALIDATOR} a submitted the timesheet {MONTH} of {EMPLOYEE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_SUBMISSION_TIMESHEET', N'SUBMISSION_TIMESHEET')
SET IDENTITY_INSERT [ERPSettings].[Information] OFF
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
COMMIT TRANSACTION


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
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (400, N'Payroll', N'ExitEmployee', N'ExitEmployee', NULL, 0, N'ExitEmployee', N'ExitEmployee', N'ExitEmployee', N'ExitEmployee', N'ExitEmployee', N'ExitEmployee', NULL, NULL, NULL)
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







--- 04-06-2020 : Marwa : update codification financial asset ---
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Codification] DROP CONSTRAINT [FK_Codification_Codification]
UPDATE [ERPSettings].[Codification] SET [InitValue]=N'AF-R' WHERE [Id]=291
UPDATE [ERPSettings].[Codification] SET [InitValue]=N'A-AF-R' WHERE [Id]=296
UPDATE [ERPSettings].[Codification] SET [InitValue]=N'/' WHERE [Id]=298
ALTER TABLE [ERPSettings].[Codification]
    ADD CONSTRAINT [FK_Codification_Codification] FOREIGN KEY ([IdCodificationParent]) REFERENCES [ERPSettings].[Codification] ([Id])
COMMIT TRANSACTION 


-- Mohamed BOUZIDI add documentReportData
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



--- kossi insert into [sales].[paymentStatus] 16/07/2020
BEGIN TRANSACTION
SET IDENTITY_INSERT [Payment].[PaymentStatus] ON
INSERT INTO [Payment].[PaymentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (6, N'Paid', N'Payé', 0, 0, NULL)
SET IDENTITY_INSERT [Payment].[PaymentStatus] OFF
COMMIT TRANSACTION

--- Donia update timesheet entity and add information  of add timesheet comment 23/07/2020
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Entity] DROP CONSTRAINT [FK_Entity_Entity]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
UPDATE [ERPSettings].[Entity] SET [EntityName]=N'TimeSheet', [TableName]=N'TimeSheet', [Fr]=N'TimeSheet', [Ar]=N'TimeSheet', [En]=N'TimeSheet', [De]=N'TimeSheet', [Ch]=N'TimeSheet', [Es]=N'TimeSheet' WHERE [Id]=396
GO
SET IDENTITY_INSERT [ERPSettings].[Information] ON
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501241, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/rh/timesheet', N'{CREATOR}  a ajouté un commentaire pour votre CRA', N'{CREATOR} has added a note to your timesheet', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_ADD_COMMENT_TIMESHEET', N'ADD_COMMENT_TIMESHEET')
SET IDENTITY_INSERT [ERPSettings].[Information] OFF
ALTER TABLE [ERPSettings].[Entity]
    ADD CONSTRAINT [FK_Entity_Entity] FOREIGN KEY ([IdRelatedEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
COMMIT TRANSACTION

BEGIN TRANSACTION
UPDATE [Payment].[PaymentStatus] SET [Code]=N'Settled', [Label]=N'Réglé' WHERE [Id]=1
UPDATE [Payment].[PaymentStatus] SET [Code]=N'RemittanceSlip', [Label]=N'Bordereau' WHERE [Id]=2
UPDATE [Payment].[PaymentStatus] SET [Code]=N'Issued', [Label]=N'Emis' WHERE [Id]=3
UPDATE [Payment].[PaymentStatus] SET [Code]=N'InBank', [Label]=N'En banque' WHERE [Id]=4
UPDATE [Payment].[PaymentStatus] SET [Code]=N'Cashed', [Label]=N'Encaissé' WHERE [Id]=5
UPDATE [Payment].[PaymentStatus] SET [Code]=N'Unpaid', [Label]=N'Impayé' WHERE [Id]=6
COMMIT TRANSACTION

 --- Rabeb 28/07/2020: Add TranferOrder codification
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

--- Donia add Code to Payslip session 28/07/2020
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


--- Amine Ben Ayed 28/07/2020

ALTER TABLE [ERPSettings].[User]
DROP CONSTRAINT FK_User_Employee;

ALTER TABLE [ERPSettings].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [Payroll].[Employee] ([Id]) ON UPDATE CASCADE ON DELETE CASCADE;

--- Donia add Code to Cnss declaration 29/07/2020
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

--- Rabeb 06/08/2020: Add SourceDeductionSession codification

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

---Amine Ben Ayed 25/08/2020 : codification team

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

---Rabeb: modify Information Fr and En message: 03/09/2020

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a ajouté un commentaire pour la demande de note de frais {CODE}' WHERE [IdInfo]=1000501078
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a ajouté demande de note de frais {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501082
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a modifié la demande de note de frais {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501085
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a validé la demande de note de frais {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501088
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a refusé la demande de note de frais {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501091
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a supprimé une demande de note de frais {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501095
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
COMMIT TRANSACTION

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
UPDATE [ERPSettings].[Information] SET [EN]=N'{DOC_CREATOR} added a comment for the expense report request {CODE}' WHERE [IdInfo]=1000501078
UPDATE [ERPSettings].[Information] SET [EN]=N'{DOC_CREATOR} added a new expense report {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501082
UPDATE [ERPSettings].[Information] SET [EN]=N'{DOC_CREATOR} updated the expense report {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501085
UPDATE [ERPSettings].[Information] SET [EN]=N'{DOC_CREATOR} validated the expense report {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501088
UPDATE [ERPSettings].[Information] SET [EN]=N'{DOC_CREATOR} refused the expense report {DOC_CODE} {PROFIL}' WHERE [IdInfo]=1000501091
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
COMMIT TRANSACTION
 


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

--- 09/10/2020
SET IDENTITY_INSERT [Inventory].[Warehouse] ON
INSERT INTO [Inventory].[Warehouse] ([Id], [WarehouseCode], [WarehouseName], [WarehouseAdresse], [IsDeleted], [TransactionUserId], [IdWarehouseParent], [Deleted_Token], [IsCentral], [IsWarehouse], [IdResponsable]) VALUES (1, N'0001', N'Central', N'Central', 0, 0, NULL, NULL, 1, 1, NULL)
SET IDENTITY_INSERT [Inventory].[Warehouse] OFF

--- Imen chaaben WithholdingTax data config
BEGIN TRANSACTION
SET IDENTITY_INSERT [Payment].[WithholdingTax] ON
INSERT INTO [Payment].[WithholdingTax] ([Id], [Code], [Designation], [Percentage], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, N'Honoraire', N'Honoraire (5%)', 5, 0, NULL, NULL)
INSERT INTO [Payment].[WithholdingTax] ([Id], [Code], [Designation], [Percentage], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2, N'Honoraires commissions loyers et redevances', N'Honoraires commissions loyers et redevances (15%)', 15, 0, NULL, NULL)
INSERT INTO [Payment].[WithholdingTax] ([Id], [Code], [Designation], [Percentage], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (3, N'Retenue sur montant > 1000 DT', N'Retenue sur montant > 1000 DT (1.5%)', 1.5, 0, NULL, NULL)
INSERT INTO [Payment].[WithholdingTax] ([Id], [Code], [Designation], [Percentage], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, N'Retenues des capitaux mobiliers ', N'Retenues des capitaux mobiliers (20%)', 20, 0, NULL, NULL)
INSERT INTO [Payment].[WithholdingTax] ([Id], [Code], [Designation], [Percentage], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'Montant exononéré des retenues ', N'Montant exononéré des retenues (0%)', 0, 0, NULL, NULL)
SET IDENTITY_INSERT [Payment].[WithholdingTax] OFF
COMMIT TRANSACTION

--chedi : add storagtransert add and list functionalities
INSERT INTO [Inventory].[StockDocumentType] ([CodeType], [Type], [StockOperation], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (N'TShSt', N'TShSt', N'T', N'TransferShelfStorage', 0, 0, NULL)


-- Narcisse: update exit employee config data

DELETE FROM [ERPSettings].[Entity] where Id = 400

INSERT INTO [ERPSettings].[Entity] ([TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (N'Payroll', N'ExitEmployee', N'ExitEmployee', NULL, 0, N'ExitEmployee', N'ExitEmployee', N'ExitEmployee', N'ExitEmployee', N'ExitEmployee', N'ExitEmployee', NULL, NULL, NULL)


-- Youssef update documentLineTaxe 11/01/2021
GO
DECLARE @idTaxe int;
DECLARE @taxeAmount float;
DECLARE @taxeAmountWithCurrency float;
DECLARE @taxeBase float;
DECLARE @IdDocumentLine int;
DECLARE @taxeBaseWithCurrency float;
DECLARE @HtTotalLine float;
DECLARE @HtTotalLineWithCurrency float;
DECLARE @ExcVatTaxAmount float;
DECLARE @ExcVatTaxAmountWithCurrency float;
DECLARE @VatTaxAmount float;
DECLARE @VatTaxAmountWithCurrency float;
DECLARE @TaxeType int;
DECLARE @TaxeValue int;

 

DECLARE dlt_cursor CURSOR
    FOR SELECT IdTaxe,IdDocumentLine, TaxeValue, TaxeValueWithCurrency,TaxeBase, TaxeBaseWithCurrency FROM [Sales].[DocumentLineTaxe] 
    WHERE IsDeleted = 0 ;

 

    OPEN dlt_cursor;

 

    FETCH NEXT FROM dlt_cursor INTO @idTaxe ,@IdDocumentLine, @taxeAmount , @taxeAmountWithCurrency , @taxeBase , @taxeBaseWithCurrency;

 

    WHILE @@FETCH_STATUS = 0

 

    BEGIN

 

    SELECT @HtTotalLine = HtTotalLine , @HtTotalLineWithCurrency = HtTotalLineWithCurrency,
    @ExcVatTaxAmount=ExcVatTaxAmount, @ExcVatTaxAmountWithCurrency = ExcVatTaxAmountWithCurrency,
    @VatTaxAmount = VatTaxAmount , @VatTaxAmountWithCurrency = VatTaxAmountWithCurrency
     FROM Sales.DocumentLine 
    WHERE Id = @IdDocumentLine;

 

    SELECT @TaxeType = TaxeType ,@TaxeValue = TaxeValue FROM Shared.Taxe
    WHERE Id = @idTaxe;

 

    IF @HtTotalLine is not null and @ExcVatTaxAmount is not null
        IF @TaxeType = 1
            SET @taxeBase = @HtTotalLine + @ExcVatTaxAmount
        ELSE SET @taxeBase = @HtTotalLine
    ELSE SET @taxeBase = 0;    
        
    IF @VatTaxAmount > 0 and @taxeBase is not null
        SET @taxeAmount = @taxeBase * (CAST(@TaxeValue as float) / 100.0)
    ELSE SET @taxeAmount = 0;

 

    IF @HtTotalLineWithCurrency is not null and @ExcVatTaxAmountWithCurrency is not null
        IF @TaxeType = 1
            SET @taxeBaseWithCurrency = @HtTotalLineWithCurrency + @ExcVatTaxAmountWithCurrency
        ELSE SET @taxeBaseWithCurrency = @HtTotalLineWithCurrency
    ELSE SET @taxeBaseWithCurrency = 0;    
        
    IF @VatTaxAmountWithCurrency > 0 and @taxeBaseWithCurrency is not null
        SET @taxeAmountWithCurrency = @taxeBaseWithCurrency * (@TaxeValue / 100)
    ELSE SET @taxeAmountWithCurrency = 0;

 

    UPDATE Sales.DocumentLineTaxe 
    SET TaxeValue = @taxeAmount, TaxeValueWithCurrency = @taxeAmountWithCurrency,
    TaxeBase = @taxeBase , TaxeBaseWithCurrency = @taxeBaseWithCurrency  where CURRENT OF dlt_cursor
    
    FETCH NEXT FROM dlt_cursor INTO @idTaxe ,@IdDocumentLine, @taxeAmount , @taxeAmountWithCurrency , @taxeBase , @taxeBaseWithCurrency;
    END;
CLOSE dlt_cursor;
DEALLOCATE dlt_cursor;


-- Youssef update documentTaxResume 11/01/2021
GO
DECLARE @id int;
DECLARE @exchangeRate float = 1;
DECLARE @DocumentTtcprice float;
DECLARE @DocumentHtprice float;
DECLARE @DocumentOtherTaxes float;
DECLARE @idTaxe int;
DECLARE @taxeValue float;
DECLARE @taxeValueWithCurrency float;
DECLARE @taxeBase float;
DECLARE @taxeBaseWithCurrency float,@message VARCHAR(800);
DECLARE @idUsedCurrency int;
DECLARE @TiersPrecision int;
DECLARE @CompanyPrecision int;
DECLARE @DiscountAmount float;
DECLARE @DiscountAmountWithCurrency float;
DECLARE @ExcVatTaxAmount float;
DECLARE @ExcVatTaxAmountWithCurrency float;

 



DECLARE dc_cursor CURSOR  FAST_FORWARD 
    FOR SELECT Id, ExchangeRate,DocumentTtcprice,DocumentHTPrice,DocumentOtherTaxes, IdUsedCurrency FROM [Sales].[Document] 
    WHERE IsDeleted = 0 ;

 

OPEN dc_cursor;

 

FETCH NEXT FROM dc_cursor INTO @id , @exchangeRate,@DocumentTtcprice,@DocumentHtprice,@DocumentOtherTaxes, @idUsedCurrency;

 

WHILE @@FETCH_STATUS = 0

 

BEGIN
/*
    set exchangeRate
*/
IF @exchangeRate  is Null
    SET @exchangeRate = 1
    

 

IF @DocumentOtherTaxes  is Null
    SET @DocumentOtherTaxes = 0

 

SET @DocumentTtcprice = @DocumentHtprice + @DocumentOtherTaxes;
    /*
    update taxeValueWithCurrency et taxeBaseWithCurrency into documentLineTaxe
*/
    
    /*
    getTiersPrecision
*/
    SELECT @TiersPrecision= Precision FROM Administration.Currency
    WHERE id = @idUsedCurrency;

 

    /*
    get CompanyPrecision
*/
    SELECT @CompanyPrecision = Precision FROM Administration.Currency 
    WHERE id = (SELECT IdCurrency FROM Shared.Company LIMIT1)

 

    DECLARE dlt_cursor CURSOR  FAST_FORWARD 
    FOR SELECT IdTaxe, sum(d.TaxeValue), sum(d.TaxeValueWithCurrency),sum(TaxeBase), sum(d.TaxeBaseWithCurrency),
    sum(ROUND((dl.DiscountPercentage /100) * dl.HtUnitAmountWithCurrency,@TiersPrecision) * @exchangeRate * dl.MovementQty),sum((dl.DiscountPercentage /100) * dl.HtUnitAmountWithCurrency * dl.MovementQty),
    sum(dl.ExcVatTaxAmount), sum(dl.ExcVatTaxAmountWithCurrency) FROM [Sales].[DocumentLineTaxe] d,
    [Sales].[DocumentLine] dl
        WHERE d.IsDeleted = 0 and d.IdDocumentLine = dl.Id and d.IdDocumentLine IN (SELECT Id FROM [Sales].[DocumentLine] WHERE IdDocument = @id and IsDeleted = 0)
    group by IdTaxe;

 

    OPEN dlt_cursor;

 

    FETCH NEXT FROM dlt_cursor INTO @idTaxe , @taxeValue , @taxeValueWithCurrency , @taxeBase , @taxeBaseWithCurrency ,@DiscountAmount , @DiscountAmountWithCurrency , @ExcVatTaxAmount,@ExcVatTaxAmountWithCurrency;

 

    WHILE @@FETCH_STATUS = 0

 

    BEGIN
    
    INSERT INTO [Sales].[DocumentTaxsResume] (Id_Tax,HtAmount,HtAmountWithCurrency,TaxAmount,TaxAmountWithCurrency,IsDeleted,IdDocument,DiscountAmount,DiscountAmountWithCurrency ,ExcVatTaxAmount, ExcVatTaxAmountWithCurrency) VALUES(@idTaxe,ROUND(@taxeBase,@CompanyPrecision),ROUND(@taxeBaseWithCurrency,@TiersPrecision),ROUND(@taxeValue,@CompanyPrecision),ROUND(@taxeValueWithCurrency,@TiersPrecision),0, @id, ROUND(@DiscountAmount,@CompanyPrecision),ROUND(@DiscountAmountWithCurrency,@TiersPrecision),ROUND(@ExcVatTaxAmount,@CompanyPrecision),ROUND(@ExcVatTaxAmountWithCurrency,@TiersPrecision));
    
    
    
    FETCH NEXT FROM dlt_cursor INTO @idTaxe , @taxeValue , @taxeValueWithCurrency , @taxeBase , @taxeBaseWithCurrency ,@DiscountAmount , @DiscountAmountWithCurrency , @ExcVatTaxAmount,@ExcVatTaxAmountWithCurrency;
    END;

 


    CLOSE dlt_cursor;
	DEALLOCATE dlt_cursor;
FETCH NEXT FROM dc_cursor INTO @id , @exchangeRate,@DocumentTtcprice,@DocumentHtprice,@DocumentOtherTaxes, @idUsedCurrency;
END;

 

CLOSE dc_cursor;
DEALLOCATE dc_cursor;



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
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (402, N'Annee', 2, NULL, N'string', N'20', 400, 0, NULL, NULL, NULL)
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

--- Donia Update interview notifications 08/02/2020
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
UPDATE [ERPSettings].[Information] SET [FR]=N'{INTERVIEW_CREATOR} vous a ajouté en tant qu''intervieweur requis pour l''entretien du candidat {NAME} le {INTERVIEW_DATE} à {INTERVIEW_TIME}', [EN]=N'{INTERVIEW_CREATOR} has added you as a required interviewer to the interview of the candidate {NAME} on {INTERVIEW_DATE} at {INTERVIEW_TIME}', [Type]=N'ADDED_AS_REQUIRED_INTERVIEWER_FOR_CANDIDACY' WHERE [IdInfo]=1000501097
UPDATE [ERPSettings].[Information] SET [FR]=N'{INTERVIEW_CREATOR} vous a ajouté en tant qu''intervieweur optionnel pour l''entretien du candidat {NAME} le {INTERVIEW_DATE} à {INTERVIEW_TIME}', [EN]=N'{INTERVIEW_CREATOR} has added you as a optional interviewer to the interview of the candidate {NAME} on {INTERVIEW_DATE} at {INTERVIEW_TIME}', [Type]=N'ADDED_AS_OPTIONAL_INTERVIEWER_FOR_CANDIDACY' WHERE [IdInfo]=1000501098
UPDATE [ERPSettings].[Information] SET [FR]=N'{INTERVIEW_CREATOR} vous a ajouté en tant qu''intervieweur optionnel pour l''entretien du candidat {NAME} le {INTERVIEW_DATE} à {INTERVIEW_TIME}', [EN]=N'{INTERVIEW_CREATOR} has added you as a optional interviewer to the interview of the candidate {NAME} on {INTERVIEW_DATE} at {INTERVIEW_TIME}', [Type]=N'DELETED_FROM_INTERVIEWER_LIST_FOR_CANDIDACY' WHERE [IdInfo]=1000501099
GO
SET IDENTITY_INSERT [ERPSettings].[Information] ON
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501246, N'3a396a34-e1f0-4c47-93db-394bc5f4c557', N'/payroll/exit-employee/edit', N'{INTERVIEW_CREATOR} vous a ajouté en tant qu''intervieweur requis pour la réunion de sortie de {NAME} le {INTERVIEW_DATE} à {INTERVIEW_TIME}', N'{INTERVIEW_CREATOR} has added you as a required interviewer to the exit employee meeting of {NAME} on {INTERVIEW_DATE} at {INTERVIEW_TIME}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_ADD_REQUIRED_INTERVIEWER_FOR_EXIT_EMPLOYEE', N'ADDED_AS_REQUIRED_INTERVIEWER_FOR_EXIT_EMPLOYEE')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501247, N'3a396a34-e1f0-4c47-93db-394bc5f4c557', N'/payroll/exit-employee/edit', N'{INTERVIEW_CREATOR} vous a ajouté en tant qu''intervieweur optionnel pour la réunion de sortie de {NAME} le {INTERVIEW_DATE} à {INTERVIEW_TIME}', N'{INTERVIEW_CREATOR} has added you as a optional interviewer to the exit employee meeting of NAME} on {INTERVIEW_DATE} at {INTERVIEW_TIME}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_ADD_OPTIONAL_INTERVIEWER_FOR_EXIT_EMPLOYEE', N'ADDED_AS_OPTIONAL_INTERVIEWER_FOR_EXIT_EMPLOYEE')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501248, N'3a396a34-e1f0-4c47-93db-394bc5f4c557', N'/payroll/exit-employee/edit', N'{INTERVIEW_CREATOR} vous a ajouté en tant qu''intervieweur optionnel pour la réunion de sortie de {NAME} le {INTERVIEW_DATE} à {INTERVIEW_TIME}', N'{INTERVIEW_CREATOR} has added you as a optional interviewer  to the exit employee meeting of  NAME} on {INTERVIEW_DATE} at {INTERVIEW_TIME}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_DELETE_INTERVIEWER_FOR_EXIT_EMPLOYEE', N'DELETED_FROM_INTERVIEWER_LIST_FOR_EXIT_EMPLOYEE')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501249, N'3a396a34-e1f0-4c47-93db-394bc5f4c557', N'/rh/review', N'{INTERVIEW_CREATOR} vous a ajouté en tant qu''intervieweur requis pour l''entretien de {NAME} le {INTERVIEW_DATE} à {INTERVIEW_TIME}', N'{INTERVIEW_CREATOR} has added you as a required interviewer to the interview of {NAME} on {INTERVIEW_DATE} at {INTERVIEW_TIME}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_ADD_REQUIRED_INTERVIEWER_FOR_REVIEW', N'ADDED_AS_REQUIRED_INTERVIEWER_FOR_REVIEW')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501250, N'3a396a34-e1f0-4c47-93db-394bc5f4c557', N'/rh/review', N'{INTERVIEW_CREATOR} vous a ajouté en tant qu''intervieweur optionnel pour l''entretien de {NAME} le {INTERVIEW_DATE} à {INTERVIEW_TIME}', N'{INTERVIEW_CREATOR} has added you as a optional interviewer to the interview of {NAME} on {INTERVIEW_DATE} at {INTERVIEW_TIME}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_ADD_OPTIONAL_INTERVIEWER_FOR_REVIEW', N'ADDED_AS_OPTIONAL_INTERVIEWER_FOR_REVIEW')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501251, N'3a396a34-e1f0-4c47-93db-394bc5f4c557', N'/rh/review', N'{INTERVIEW_CREATOR} vous a ajouté en tant qu''intervieweur optionnel pour l''entretien de {NAME} le {INTERVIEW_DATE} à {INTERVIEW_TIME}', N'{INTERVIEW_CREATOR} has added you as a optional interviewer to the interview of {NAME} on {INTERVIEW_DATE} at {INTERVIEW_TIME}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_DELETE_INTERVIEWER_FOR_REVIEW', N'DELETED_FROM_INTERVIEWER_LIST_FOR_REVIEW')
SET IDENTITY_INSERT [ERPSettings].[Information] OFF
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
COMMIT TRANSACTION

 -- Rafik add codification to FundsTransfer table 30/04/2021
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT [ERPSettings].[Entity] ON
INSERT INTO [ERPSettings].[Entity] ([Id], [TableSchema], [EntityName], [TableName], [TransactionUserId], [IsDeleted], [Fr], [Ar], [En], [De], [Ch], [Es], [IsReference], [IdRelatedEntity], [Deleted_Token]) VALUES (409, N'Payment', N'FundsTransfer', N'FundsTransfer', NULL, 0, N'FundsTransfer', N'FundsTransfer', N'FundsTransfer', N'FundsTransfer', N'FundsTransfer', N'FundsTransfer', NULL, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[Entity] OFF

SET IDENTITY_INSERT [ERPSettings].[Codification] ON
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (406, N'CodeFundsTransfer', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (407, N'CaractereFT', 1, NULL, NULL, N'FT', 406, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (408, N'Annee', 2, N'return (DateTime.Now.Year.ToString().Substring(2,2));', N'string', NULL, 406, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (409, N'CaractereTIRET', 3, NULL, NULL, N'-', 406, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Codification] ([Id], [Name], [Rank], [Path], [Format], [InitValue], [IdCodificationParent], [IsCounter], [Step], [LastCounterValue], [CounterLength]) VALUES (410, N'compteurFundsTransfer', 4, NULL, NULL, NULL, 406, 1, 1, N'00000008', 8)
SET IDENTITY_INSERT [ERPSettings].[Codification] OFF

SET IDENTITY_INSERT [ERPSettings].[EntityCodification] ON
INSERT INTO [ERPSettings].[EntityCodification] ([Id], [IdEntity], [Property], [Value], [IdCodification]) VALUES (84, 409, NULL, NULL, 406)
SET IDENTITY_INSERT [ERPSettings].[EntityCodification] OFF
COMMIT TRANSACTION


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

-- Ahmed : update report template 12/10/2021
update [ERPSettings].[ReportTemplate] SET [TemplateNameFr]=N'genericDocumentReport_fr',[TemplateNameEn]=N'genericDocumentReport_en',[ReportName] =N'genericDocumentReport' where [ReportCode] in ('BE-PU', 'BS-SA'); 
update [ERPSettings].[ReportTemplate] SET [TemplateNameFr]=N'documentReport_fr',[TemplateNameEn]=N'documentReport_en',[ReportName] =N'documentReport' where [ReportCode] in ('Q-SA', 'O-SA', 'D-SA') ;
update [ERPSettings].[ReportTemplate] SET [IdEntity] = 87 where [ReportCode] like 'D-SA';




--- marwa : change label and desc of FO-PU type of document ----
update Sales.DocumentType set Label='Commande définitive',Description='Commande définitive' where Code='FO-PU'

-- Ameni : update CostPrice value 18/11/2021
update Inventory.Item
set CostPrice =t2.CostPrice
from Inventory.Item
INNER join Sales.DocumentLine as t2
on Inventory.Item.Id = t2.Iditem
where t2.CostPrice >0

update Sales.DocumentLine
set CostPrice = t2.CostPrice
from Sales.DocumentLine
INNER join Inventory.Item as t2
on Sales.DocumentLine.IdItem = t2.Id
INNER join Sales.Document as t3
on Sales.DocumentLine.IdDocument = t3.Id
where t3.DocumentTypeCode like '%SA%'

-- Ameni : add documentBLDetails 08/12/2021
SET IDENTITY_INSERT [ERPSettings].[ReportTemplate] ON
INSERT INTO [ERPSettings].[ReportTemplate] ([Id], [IdEntity], [TemplateCode], [TemplateNameFr], [TemplateNameEn], [ReportCode], [ReportName]) VALUES (18, NULL, N'DETAILED', N'documentSalesDetails_fr', N'documentSalesDetails_en', N'I-SA', N'documentSalesDetails')
SET IDENTITY_INSERT [ERPSettings].[ReportTemplate] OFF


--- Ahmed deposit invoice script 13/12/2021
---------add avance nature to item  
INSERT INTO [Inventory].[Nature] ([Code],[Label],[IsStockManaged],[IsDeleted],[TransactionUserId],[Deleted_Token],[UrlPicture]) VALUES ( N'Avance', N'Avance',0,0,0,NULL,NULL)
---------add codification of deposit invoice 
 GO
SET IDENTITY_INSERT [ERPSettings].[Codification] ON
  INSERT INTO [ERPSettings].[Codification] ([Id],[Name],[Rank],[Path],[Format],[InitValue],[IdCodificationParent],[IsCounter],[Step],[LastCounterValue],[CounterLength]) VALUES 
  (426,N'CodeFactureFermeClient',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL);
  INSERT INTO [ERPSettings].[Codification] ([Id],[Name],[Rank],[Path],[Format],[InitValue],[IdCodificationParent],[IsCounter],[Step],[LastCounterValue],[CounterLength]) VALUES 
  (427,N'CodeFactureFermeClient-Approved',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL);
  --Codification for provisonal deposit invoice sales
  INSERT INTO [ERPSettings].[Codification] ([Id],[Name],[Rank],[Path],[Format],[InitValue],[IdCodificationParent],[IsCounter],[Step],[LastCounterValue],[CounterLength]) VALUES 
  (428,N'CaratctereAC',1,NULL,NULL,N'AC',426,0,NULL,NULL,NULL);
  INSERT INTO [ERPSettings].[Codification] ([Id],[Name],[Rank],[Path],[Format],[InitValue],[IdCodificationParent],[IsCounter],[Step],[LastCounterValue],[CounterLength]) VALUES 
  (429,N'Annee',2,NULL,N'string',N'21',426,0,NULL,NULL,NULL);
  INSERT INTO [ERPSettings].[Codification] ([Id],[Name],[Rank],[Path],[Format],[InitValue],[IdCodificationParent],[IsCounter],[Step],[LastCounterValue],[CounterLength]) VALUES 
  (430,N'Caractere/',3,NULL,NULL,N'/',426,0,NULL,NULL,NULL);
  INSERT INTO [ERPSettings].[Codification] ([Id],[Name],[Rank],[Path],[Format],[InitValue],[IdCodificationParent],[IsCounter],[Step],[LastCounterValue],[CounterLength]) VALUES 
  (431,N'CompteurFactureFermeClient',4,NULL,NULL,NULL,426,1,1,N'0000',8);
  --Codification for valid deposit invoice sales
  INSERT INTO [ERPSettings].[Codification] ([Id],[Name],[Rank],[Path],[Format],[InitValue],[IdCodificationParent],[IsCounter],[Step],[LastCounterValue],[CounterLength]) VALUES 
  (432,N'CaratctereFAC',1,NULL,NULL,N'FAC',427,0,NULL,NULL,NULL);
  INSERT INTO [ERPSettings].[Codification] ([Id],[Name],[Rank],[Path],[Format],[InitValue],[IdCodificationParent],[IsCounter],[Step],[LastCounterValue],[CounterLength]) VALUES 
  (433,N'Annee',2,NULL,N'string',N'21',427,0,NULL,NULL,NULL);
  INSERT INTO [ERPSettings].[Codification] ([Id],[Name],[Rank],[Path],[Format],[InitValue],[IdCodificationParent],[IsCounter],[Step],[LastCounterValue],[CounterLength]) VALUES 
  (434,N'Caractere-',3,NULL,NULL,N'-',427,0,NULL,NULL,NULL);
  INSERT INTO [ERPSettings].[Codification] ([Id],[Name],[Rank],[Path],[Format],[InitValue],[IdCodificationParent],[IsCounter],[Step],[LastCounterValue],[CounterLength]) VALUES 
  (435,N'CompteurFactureFermeClient-Approved',4,NULL,NULL,NULL,427,1,1,N'00000000',8);
  SET IDENTITY_INSERT [ERPSettings].[Codification] OFF
    ------Add entityCodification for deposit invoice 
  INSERT INTO [ERPSettings].[EntityCodification] ([IdEntity],[Property],[Value],[IdCodification]) VALUES (87,N'DocumentTypeCode',N'AC-I-SA',426);
  INSERT INTO [ERPSettings].[EntityCodification] ([IdEntity],[Property],[Value],[IdCodification]) VALUES (87,N'DocumentTypeCode',N'A-AC-I-SA',427);

   --Ahmed add advance Tax and advance payement type 24/12/2021
   INSERT INTO [Shared].[Taxe] 
  ([Label], [CodeTaxe], [TaxeValue], [IdTaxeType], [IsDeleted], [TransactionUserId], [Deleted_Token], [TaxeType], [IdAccountingAccountSales], [IdAccountingAccountPurchase], [IsCalculable]) 
  VALUES (N'TVA_Avance0%', N'TVA_Avance0%', 0, 1, 0, 0, NULL, 1, NULL, NULL, 1);
  GO
  -- insert taxe avance into taxeGroupTier
  INSERT INTO [Sales].[TaxeGroupTiersConfig] ([IdTaxeGroupTiers], [IdTaxe], [Value], [TransactionUserId], [IsDeleted], [Deleted_Token]) 
  VALUES (1, (SELECT Id from [Shared].[Taxe] where CodeTaxe like 'TVA_Avance0%'), 0, 0, 0, NULL);
  INSERT INTO [Sales].[TaxeGroupTiersConfig] ([IdTaxeGroupTiers], [IdTaxe], [Value], [TransactionUserId], [IsDeleted], [Deleted_Token]) 
  VALUES (2, (SELECT Id from [Shared].[Taxe] where CodeTaxe like 'TVA_Avance0%'), 0, 0, 0, NULL);
  GO


  --insert settlement mode for advance paymenet
  INSERT INTO [Sales].[SettlementMode] ([Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token])
  VALUES (N'Paiement_Avance', N'Paiement_Avance', 0, 0, NULL);
  
  -- insert settlement details for advance payment settlement
  GO
  INSERT INTO [Sales].[DetailsSettlementMode] 
  ([IdSettlementMode], [IdSettlementType], [IdPaymentMethod], [Percentage], [NumberDays], [SettlementDay], [IsDeleted], [TransactionUserId], [Deleted_Token], [CompletePrinting]) 
  VALUES ((SELECT Id from [Sales].[SettlementMode] where Code like 'Paiement_Avance'), 2, 1, 100, NULL, NULL, 0, 0, NULL, N'');
  GO


 --Calcul inverse: Ahmed 03/02/2022
 -- insert remise nature 
INSERT INTO [Inventory].[Nature] ([Code],[Label],[IsStockManaged],[IsDeleted],[TransactionUserId],[Deleted_Token],[UrlPicture]) 
VALUES ( N'Remise', N'Remise',0,0,0,NULL,NULL);
-- insert remise item 
 INSERT INTO [Inventory].[Item] ( [Code], [Description], [BarCode1D], [BarCode2D], [IdUnitStock], [IdUnitSales], [CoeffConversion], [UnitHTPurchasePrice], [UnitHTSalePrice], [UnitTTCPurchasePrice], [UnitTTCSalePrice], [TVARate], [FixedMargin], [VariableMargin], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdNature], [EquivalenceItem], [IdFamily], [IdSubFamily], [OnOrder], [Note], [IdPolicyValorization], [AverageSalesPerDay], [IdAccountingAccountSales], [IdAccountingAccountPurchase], [TecDocId], [TecDocRef], [TecDocIdSupplier], [IdEmployee], [IsForPurchase], [IsForSales], [IsKit], [IdItemReplacement], [IdProductItem], [HaveClaims], [DefaultUnitHTPurchasePrice],[IsEcommerce],[ExistInEcommerce],[OnlineSynchonizationStatus],[SynchonizationStatus],[LastUpdateEcommerce],[TecDocImageUrl],[TecDocBrandName],[UrlPicture],[ProvInventory],[IsFromGarage],[CreationDate],[UpdatedDate],[CostPrice],[UpdatedDatePicture]) 
  VALUES (N'Remise', N'Remise', N'Remise', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, (Select TOP(1) Id from [Inventory].[Nature] where Code = 'Remise'), NULL, NULL, NULL, 0, N'', NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, 0, 1, 0, NULL, NULL, 0, NULL,0,0,NULL,NULL, NULL,NULL,NULL,NULL,0,NULL, NULL, NULL,NULL,NULL)
-- insert tax into remise item 
INSERT INTO [Inventory].[TaxeItem] ([IdTaxe], [IdItem], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES 
  ((SELECT TOP(1) IdDefaultTax from [Shared].[Company]),(Select TOP(1) Id from [Inventory].[Item] where Code = 'Remise' and Description ='Remise'), 0, 0, NULL)


-- Script to modify ItemTier price: Ahmed 03/02/2022
GO
DECLARE @idTier int;
DECLARE @idProduct float;
DECLARE @newPrice float;
DECLARE @idLine int;


DECLARE itemTier_cursor CURSOR
FOR SELECT IdItem,IdTiers FROM [Inventory].[ItemTiers] where (PurchasePrice is null or PurchasePrice = 0) and IsDeleted = 0 ;

    OPEN itemTier_cursor;
    FETCH NEXT FROM itemTier_cursor INTO @idProduct ,@idTier;
    WHILE @@FETCH_STATUS = 0
    BEGIN
 
	SELECT  TOP(1) @idLine = sales.DocumentLine.Id, @newPrice = HtUnitAmountWithCurrency from sales.Document 
	FULL JOIN Sales.DocumentLine on sales.DocumentLine.IdDocument = Sales.Document.Id 
	WHERE sales.Document.DocumentTypeCode = 'D-PU' and sales.Document.IsDeleted = 0 and sales.Document.IdTiers = @idTier and sales.Document.IdDocumentStatus != 1
        and sales.DocumentLine.IdItem = @idProduct order by sales.DocumentLine.Id DESC;
 
    IF @newPrice is not null and @newPrice !=0
    UPDATE [Inventory].[ItemTiers]
    SET PurchasePrice = @newPrice WHERE IdItem = @idProduct and IdTiers =@idTier;
    
    FETCH NEXT FROM itemTier_cursor INTO @idProduct ,@idTier;
    END;
CLOSE itemTier_cursor;
DEALLOCATE itemTier_cursor;