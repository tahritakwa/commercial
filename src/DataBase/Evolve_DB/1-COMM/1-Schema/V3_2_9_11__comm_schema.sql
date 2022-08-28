--- Ghazoua add usersBtob table 15/12/2021
GO
CREATE TABLE [Sales].[UsersBtob] (
    [Id]                   INT            IDENTITY (1, 1) NOT NULL,
    [FirstName]            NVARCHAR (50)  NULL,
    [LastName]             NVARCHAR (50)  NULL,
    [Email]                NVARCHAR (50)  NULL,
    [ClientMail]           NVARCHAR (50)  NOT NULL,
    [IsDeleted]            BIT            NOT NULL,
    [Deleted_Token]        NVARCHAR (255) NULL,
    [TransactionUserEmail] NVARCHAR (250) NULL,
    CONSTRAINT [PK_UsersBtob] PRIMARY KEY CLUSTERED ([Id] ASC)
);      

---Ghazoua add UpdatedDatePicture to item table 10/12/2021
ALTER TABLE [Inventory].[Item]
    ADD UpdatedDatePicture DATETIME NULL;
