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
  ----add id of order and id of deposit invoice in document 
  Alter TABLE [Sales].[Document] ADD [IdSalesDepositInvoice] INT NULL;
  ALTER TABLE [Sales].[Document] ADD [IdSalesOrder] INT NULL;
  -----add settlement type 
   ALTER TABLE [Payment].[Settlement] ADD [IsDepositSettlement] BIT  DEFAULT ('false') NOT NULL;

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
