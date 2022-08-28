-- Youssef : delete empty space from transferType 11/05/2021
update [Inventory].[StockDocument] set TransferType = LTRIM(RTRIM(TransferType)) where TypeStockDocument = 'TShSt'
