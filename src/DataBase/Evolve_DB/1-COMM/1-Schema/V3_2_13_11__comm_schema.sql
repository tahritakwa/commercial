-- Nesrin add UserWarehouse table and IdStorage in DocumentLine 31/01/2022

GO
ALTER TABLE [Sales].[DocumentLine]
    ADD [IdStorage] INT NULL;

GO
CREATE TABLE [Inventory].[UserWarehouse] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [UserMail]          NVARCHAR (50)  NULL,
    [IdWarehouse]       INT            NULL,
    CONSTRAINT [PK_UserWarehouse] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
ALTER TABLE [Inventory].[UserWarehouse]
    ADD CONSTRAINT [DF_UserWarehouse_TransactionUserId] DEFAULT ((0)) FOR [TransactionUserId];



GO
ALTER TABLE [Inventory].[UserWarehouse] WITH NOCHECK
    ADD CONSTRAINT [FK_UserWarehouse_Warehouse] FOREIGN KEY ([IdWarehouse]) REFERENCES [Inventory].[Warehouse] ([Id]);



GO
ALTER TABLE [Sales].[DocumentLine] WITH NOCHECK
    ADD CONSTRAINT [FK_DocumentLine_Storage] FOREIGN KEY ([IdStorage]) REFERENCES [Inventory].[Storage] ([Id]);

GO
ALTER TABLE [Inventory].[UserWarehouse] WITH CHECK CHECK CONSTRAINT [FK_UserWarehouse_Warehouse];

ALTER TABLE [Sales].[DocumentLine] WITH CHECK CHECK CONSTRAINT [FK_DocumentLine_Storage];