--Ghazoua add CostPrice to item table 23/11/2021
GO
ALTER TABLE [Inventory].[Item]
ADD [CostPrice] FLOAT (53) NULL;