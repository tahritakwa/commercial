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
