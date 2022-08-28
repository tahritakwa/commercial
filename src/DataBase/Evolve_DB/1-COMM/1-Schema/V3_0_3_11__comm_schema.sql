--- Donia add on delete cascade to shelf and storage 10/05/2021
ALTER TABLE [Inventory].[Shelf] DROP CONSTRAINT [FK_Shelf_Warehouse];
ALTER TABLE [Inventory].[Storage] DROP CONSTRAINT [FK_Storage_Shelf];
ALTER TABLE [Inventory].[Shelf] WITH NOCHECK
    ADD CONSTRAINT [FK_Shelf_Warehouse] FOREIGN KEY ([IdWharehouse]) REFERENCES [Inventory].[Warehouse] ([Id]) ON DELETE CASCADE;
ALTER TABLE [Inventory].[Storage] WITH NOCHECK
    ADD CONSTRAINT [FK_Storage_Shelf] FOREIGN KEY ([IdShelf]) REFERENCES [Inventory].[Shelf] ([Id]) ON DELETE CASCADE;
ALTER TABLE [Inventory].[Shelf] WITH CHECK CHECK CONSTRAINT [FK_Shelf_Warehouse];
ALTER TABLE [Inventory].[Storage] WITH CHECK CHECK CONSTRAINT [FK_Storage_Shelf];

---Ghazoua : delete IdZipCode column in company 10/05/2021
ALTER TABLE [Shared].[Company] DROP CONSTRAINT [FK_Company_ZipCode];
ALTER TABLE [Shared].[Company] DROP COLUMN [IdZipCode];

--- kossi add IsFromGarage to Document and DocumentLine 11/05/2021
ALTER TABLE [Sales].[Document] ADD [IsFromGarage] bit NULL;
ALTER TABLE [Sales].[DocumentLine] ADD [IsFromGarage] bit NULL;
