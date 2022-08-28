--Rahma add dSessionCounterSales in document table 05/11/2021
ALTER TABLE  [Sales].[Document] add [IdSessionCounterSales] int null;
ALTER TABLE [Sales].[Document] WITH NOCHECK
    ADD CONSTRAINT [FK_Document_SessionCash] FOREIGN KEY ([IdSessionCounterSales]) REFERENCES [Payment].[SessionCash] ([Id]);

ALTER TABLE [Sales].[Document] WITH CHECK CHECK CONSTRAINT [FK_Document_SessionCash];