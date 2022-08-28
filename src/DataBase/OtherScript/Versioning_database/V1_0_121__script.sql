--- 07/10/2020 Youssef add IdUserResponsable column in warehouse
GO
ALTER TABLE [Inventory].[Warehouse]
    ADD [IdUserResponsable] INT NULL;
	
--- 07/10/2020 Youssef add foreign key constraint in warehouse
GO
ALTER TABLE [Inventory].[Warehouse] WITH NOCHECK
    ADD CONSTRAINT [FK_Warehouse_User] FOREIGN KEY ([IdUserResponsable]) REFERENCES [ERPSettings].[User] ([Id]);
ALTER TABLE [Inventory].[Warehouse] WITH CHECK CHECK CONSTRAINT [FK_Warehouse_User];

--- 14/10/2020 Youssef add AllowEditionItemDesignation column in Company
GO
ALTER TABLE [Shared] . [Company] ADD 
[AllowEditionItemDesignation] BIT DEFAULT ((1)) NOT NULL