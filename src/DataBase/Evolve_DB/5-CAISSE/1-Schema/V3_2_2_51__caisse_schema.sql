--- Youssef add isForPos to Document 23/07/2021
alter TABLE [Sales].[Document] add IsForPos bit NULL DEFAULT (0) ;

--- Youssef Maaloul add agentCode to cashRegister 21/10/2021
ALTER TABLE [Payment].[CashRegister]
    ADD AgentCode nvarchar(255) NOT NULL 
    CONSTRAINT DF_CashRegister_AgentCode DEFAULT '';

--- Youssef Maaloul add oerationCash table 21/10/2021	
GO
CREATE TABLE [Treasury].[OperationCash] (
    [Id]                 INT            IDENTITY (1, 1) NOT NULL,
    [Type]               INT            NOT NULL,
    [AgentCode]          NVARCHAR (MAX) NOT NULL,
    [IdSession]          INT            NOT NULL,
    [OperationDate]      DATETIME       NOT NULL,
    [Amount]             FLOAT (53)     NOT NULL,
    [AmountWithCurrency] FLOAT (53)     NOT NULL,
    [IsDeleted]          BIT            NOT NULL,
    [Deleted_Token]      NVARCHAR (255) NULL,
    [TransactionUserId]  INT            NOT NULL,
    CONSTRAINT [PK_OperationCash] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
ALTER TABLE [Treasury].[OperationCash] WITH NOCHECK
    ADD CONSTRAINT [FK_Operation_SessionCash] FOREIGN KEY ([IdSession]) REFERENCES [Payment].[SessionCash] ([Id]);

GO
ALTER TABLE [Treasury].[OperationCash] WITH CHECK CHECK CONSTRAINT [FK_Operation_SessionCash];