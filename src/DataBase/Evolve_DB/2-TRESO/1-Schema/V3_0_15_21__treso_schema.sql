drop table IF EXISTS  [Payment].[FundsTransfer]
drop table IF EXISTS  [Payment].[CashRegister]
--- Rafik: Add CashRegister + FundsTransfer 22/04/2021
GO
CREATE TABLE [Payment].[CashRegister] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Code]              NVARCHAR (50)  NOT NULL,
    [Name]              NVARCHAR (100) NOT NULL,
    [Type]              INT            NOT NULL,
    [Address]           NCHAR (255)    NULL,
    [IdResponsible]     INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IdParentCash]      INT            NULL,
    [IdCity]            INT            NULL,
    [IdCountry]         INT            NULL,
    CONSTRAINT [PK_CashRegister] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_CashRegister_CashRegister] FOREIGN KEY ([IdParentCash]) REFERENCES [Payment].[CashRegister] ([Id]),
	CONSTRAINT [FK_CashRegister_User] FOREIGN KEY ([IdResponsible]) REFERENCES [ERPSettings].[User] ([Id]),
	CONSTRAINT [FK_CashRegister_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id]),
	CONSTRAINT [FK_CashRegister_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id])
);

GO
CREATE TABLE [Payment].[FundsTransfer] (
    [Id]                 INT            IDENTITY (1, 1) NOT NULL,
    [Code]               NVARCHAR (50)  NOT NULL,
    [TransfertDate]      DATE           NOT NULL,
    [Type]               INT            NOT NULL,
    [IdSourceCash]       INT            NOT NULL,
    [IdDestinationCash]  INT            NOT NULL,
    [Status]             INT            NOT NULL,
    [Amount]             FLOAT (53)     NOT NULL,
    [AmountWithCurrency] FLOAT (53)     NOT NULL,
    [IdCurrency]         INT            NOT NULL,
    [IsDeleted]          BIT            NOT NULL,
    [TransactionUserId]  INT            NULL,
    [Deleted_Token]      NVARCHAR (255) NULL,
    CONSTRAINT [PK_FundsTransfer] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_FundsTransfer_SourceCashRegister] FOREIGN KEY ([IdSourceCash]) REFERENCES [Payment].[CashRegister] ([Id]),
	CONSTRAINT [FK_FundsTransfer_DestinationCashRegister] FOREIGN KEY ([IdDestinationCash]) REFERENCES [Payment].[CashRegister] ([Id]),
	CONSTRAINT [FK_FundsTransfer_Currency] FOREIGN KEY ([IdCurrency]) REFERENCES [Administration].[Currency] ([Id])
);
-- Rafik add IdCashier column to FundsTransfer table 30/04/2021
ALTER TABLE [Payment].[FundsTransfer] ADD [IdCashier] INT NULL;
ALTER TABLE [Payment].[FundsTransfer] WITH NOCHECK
    ADD CONSTRAINT [FK_FundsTransfer_Cashier] FOREIGN KEY ([IdCashier]) REFERENCES [ERPSettings].[User] ([Id]);

-- Rafik update TransferDate column of FundsTransfer table 07/05/2021
ALTER TABLE [Payment].[FundsTransfer] DROP COLUMN [TransfertDate];
ALTER TABLE [Payment].[FundsTransfer] ADD [TransferDate] DATETIME NOT NULL;