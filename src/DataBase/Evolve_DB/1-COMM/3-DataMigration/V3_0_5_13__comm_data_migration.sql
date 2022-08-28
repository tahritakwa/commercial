INSERT INTO [Inventory].[Shelf]
           ([Label]
           ,[IsDeleted]
           ,[IdWharehouse]
           ,[IsDefault])
	 select distinct Shelf,0,IdWarehouse,0   from [Inventory].ItemWarehouse where Shelf is not null and LEN(Shelf)>0	 
GO

UPDATE
    Table_A
SET
     Table_A.IdShelf = Table_B.Id
FROM
    Inventory.ItemWarehouse AS Table_A
    INNER JOIN [Inventory].[Shelf] AS Table_B
        ON Table_A.Shelf = Table_B.Label
Go 

INSERT INTO [Inventory].Storage
           ([Label]
           ,[IsDeleted]
           ,IdShelf
           ,[IsDefault])
	 select distinct Storage,0,IdShelf,0   from [Inventory].ItemWarehouse where Storage is not null and LEN(Storage)>0
GO

UPDATE
    Table_A
SET
     Table_A.IdStorage = Table_B.Id
FROM
    Inventory.ItemWarehouse AS Table_A
    INNER JOIN [Inventory].[Storage] AS Table_B
        ON Table_A.Storage = Table_B.Label
		and Table_A.IdShelf = Table_B.IdShelf

Go

UPDATE
Table_A
SET
Table_A.[PurchasePrice] = Table_B.HtAmountWithCurrency,
Table_A.[Margin] = Table_B.PercentageMargin,
Table_A.[Cost] = Table_B.CostPrice
FROM
Inventory.[ItemTiers] AS Table_A
INNER JOIN Sales.DocumentLine AS Table_B
ON Table_A.IdItem = Table_B.IdItem
and Table_B. CostPrice>0

Go