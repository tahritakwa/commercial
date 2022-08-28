PRINT N'InsertInto [JobTable Table]...';
GO
SET IDENTITY_INSERT [Ecommerce].[JobTable] ON 
INSERT [Ecommerce].[JobTable] ([Id], [LastExecuteDate],[NextExecuteDate]) VALUES (1, 
DATETIMEFROMPARTS (DATEPART(year, GETUTCDATE()),DATEPART(month, GETUTCDATE()),DATEPART(day, GETUTCDATE()),0,0,0,0), 
DATEADD(Day,1,DATETIMEFROMPARTS (DATEPART(year, GETUTCDATE()),DATEPART(month, GETUTCDATE()),DATEPART(day, GETUTCDATE()),0,0,0,0))
)
SET IDENTITY_INSERT [Ecommerce].[JobTable] OFF


PRINT N'InsertIntoAndUpdate [Inventory].[Warehouse] Very Important ...';
GO

UPDATE [Inventory].[Warehouse] SET [ForEcommerceModule] = 1 WHERE [IsCentral] = 1

declare @IDWarehouse AS INT;

set @IDWarehouse = (select [Id] from [Inventory].[Warehouse] where [IsCentral] = 1);

INSERT INTO [Inventory].[Warehouse] ([WarehouseCode], [WarehouseName], [WarehouseAdresse], [IsDeleted], [TransactionUserId], [IdWarehouseParent], [Deleted_Token], 
[IsCentral], [IsWarehouse], [IdResponsable], [IsEcommerce], [ForEcommerceModule]) VALUES (N'0013', N'Ecommerce', N'Ecommerce', 0, 0, @IDWarehouse, NULL, 0, 1, NULL, 1, 1)


INSERT INTO [Sales].[Tiers] ([IdLegalForme], [IdPaymentCondition], [IdTypeTiers], [IdCity], [IdCountry], 
[IdDiscountGroupTiers], [CodeTiers], [Name], [Logo], [Adress], [Region], [AuthorizedSettlement], [Status], [Rib], 
[CIN], [Discount], [MatriculeFiscale], [IdPaymentMethod], [IsDeleted], [TransactionUserId], [IdAccountingAccountTiers], 
[CounterPartyAccount], [CommercialRegister], [CP], [AuthorizedAmountOrder], [AuthorizedAmountDelivery], [AuthorizedAmountInvoice], 
[IdTaxeGroupTiers], [IdCurrency], [Deleted_Token], [DeleveryDelay]) 
VALUES (NULL, NULL, 2, NULL, NULL, NULL, N'F-00000002', N'Aramex', NULL, N'', N'', NULL, NULL, NULL, NULL, NULL, N'', NULL, 0, 0, 
NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL)

INSERT INTO [Inventory].[Item] ([Code], [Description], [BarCode1D], [BarCode2D], [IdUnitStock], [IdUnitSales], [CoeffConversion], [UnitHTPurchasePrice], [UnitHTSalePrice], 
[UnitTTCPurchasePrice], [UnitTTCSalePrice], [TVARate], [FixedMargin], [VariableMargin], [IsDeleted], [TransactionUserId], [IdDiscountGroupItem], [Deleted_Token], [IdNature], 
[IdTiers], [EquivalenceItem], [IdFamily], [IdSubFamily], [OnOrder], [Note], [IdPolicyValorization], [AverageSalesPerDay], [IdAccountingAccountSales], [IdAccountingAccountPurchase], 
[TecDocId], [TecDocRef], [TecDocIdSupplier], [IdEmployee], [IsForPurchase], [IsForSales], [IsKit], [IdItemReplacement], [IdProductItem]) 
VALUES (N'Liv_Ecommerce', N'Liv_Ecommerce', N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 1, NULL, NULL, 
NULL, NULL, 0, N'', NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, 1, 1, 0, NULL, NULL)

declare @ID AS INT;

set @ID = (select [Id] from [Inventory].[Item] where [Code] = 'Liv_Ecommerce');

INSERT INTO [Sales].[Prices] ([LabelPrices], [CodePrices], [IdTypePrices], [IdTiers], [IdItem], [IdDiscountGroupTiers], 
[IdDiscountGroupItem], [StartDate], [EndDate], [MinQuantity], [MaxQuantity], [TypeValue], [PricesValue], [Observations], 
[IsDeleted], [TransactionUserId], [IdUsedCurrency], [IsExclusive], [OrderDiscount], [Deleted_Token], [IsUsed], [AttachmentUrl], 
[ContractCode], [BonusTypeValue], [BonusValue], [BonusPercentage], [IdContractServiceType]) VALUES (N'Liv_Ecommerce', N'Liv_Ecommerce',
 NULL, NULL, @ID, NULL, NULL, '20190101', '20201231', 1, 1E+15, 1, 7, N'', 0, 0, 2, 0, NULL, NULL, NULL, N'Sales\Prices\Liv_Ecommerce\debb8ca0-112e-4cc1-a112-27db069047a7', N'', 
 NULL, NULL, NULL, NULL)

INSERT INTO [Inventory].[TaxeItem] ([IdTaxe], [IdItem], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (4, @ID, 0, 0, NULL)

-- Document Status
SET IDENTITY_INSERT [Sales].[DocumentStatus] ON
INSERT INTO [Sales].[DocumentStatus] ([Id], [Code], [Label], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (14, N'Ecommerce', N'Ecommerce', 0, 0, NULL)
SET IDENTITY_INSERT [Sales].[DocumentStatus] OFF