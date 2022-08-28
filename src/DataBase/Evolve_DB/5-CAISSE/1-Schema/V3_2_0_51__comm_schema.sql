--- Imen chaaben: add TICKET 27/07/2021
CREATE TABLE [Treasury].[Ticket] (
    [Id]                INT         IDENTITY (1, 1) NOT NULL,
    [Code]              NVARCHAR (255) NULL,
    [CreationDate]      DATETIME        NOT NULL,
    [Status]            INT         NOT NULL,
    [IdDeliveryForm]    INT         NOT NULL,
	[IdSessionCash]		INT			NOT NULL,
    [IsDeleted]         BIT         NOT NULL,
    [TransactionUserId] INT         NOT NULL,
    CONSTRAINT [PK_Ticket] PRIMARY KEY CLUSTERED ([Id] ASC)
);
ALTER TABLE [Treasury].[Ticket]
    ADD CONSTRAINT [DF_Ticket_TransactionUserId] DEFAULT ((0)) FOR [TransactionUserId];
ALTER TABLE [Treasury].[Ticket] WITH NOCHECK
    ADD CONSTRAINT [FK_Ticket_Document] FOREIGN KEY ([IdDeliveryForm]) REFERENCES [Sales].[Document] ([Id]);
ALTER TABLE [Treasury].[Ticket] WITH CHECK CHECK CONSTRAINT [FK_Ticket_Document];

 
 --- Youssef add SessionCash 04/08/2021
 CREATE TABLE [Payment].[SessionCash] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Code]              NVARCHAR (50)  NOT NULL,
    [IdCashRegister]    INT            NOT NULL,
    [Date]              DATETIME           NOT NULL,
    [LastCounter]       NVARCHAR (255) NOT NULL DEFAULT '0000',
    [IdSeller]          INT            NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [State]             INT            NOT NULL,
    CONSTRAINT [PK_SessionCash] PRIMARY KEY CLUSTERED ([Id] ASC)
);
ALTER TABLE [Payment].[SessionCash] WITH NOCHECK
    ADD CONSTRAINT [FK_SessionCash_CashRegister] FOREIGN KEY ([IdCashRegister]) REFERENCES [Payment].[CashRegister] ([Id]);
ALTER TABLE [Payment].[SessionCash] WITH CHECK CHECK CONSTRAINT [FK_SessionCash_CashRegister];	
ALTER TABLE [Payment].[SessionCash] WITH NOCHECK
    ADD CONSTRAINT [FK_SessionCash_User] FOREIGN KEY ([IdSeller]) REFERENCES [ERPSettings].[User] ([Id]);
ALTER TABLE [Payment].[SessionCash] WITH CHECK CHECK CONSTRAINT [FK_SessionCash_User];

ALTER TABLE [Treasury].[Ticket] WITH NOCHECK
    ADD CONSTRAINT [FK_Ticket_SessionCash] FOREIGN KEY ([IdSessionCash]) REFERENCES [Payment].[SessionCash] ([Id]);
ALTER TABLE [Treasury].[Ticket] WITH CHECK CHECK CONSTRAINT [FK_Ticket_SessionCash];

--- Imen chaaben 06/08/2021: add column status in cash register 
ALTER TABLE [Payment].[CashRegister] ADD [Status] INT NOT NULL

--- Youssef maaloul 06/08/2021: update column address in cash register 
ALTER TABLE [Payment].[CashRegister] ALTER COLUMN [Address] NVARCHAR (255) NULL;

--- Youssef maaloul 11/08/2021: add sessionCASH properties
EXEC sp_rename 'Payment.SessionCash.Date', 'OpeningDate', 'COLUMN';
alter table [Payment].[SessionCash] add ClosingDate DateTime null
alter table [Payment].[SessionCash] add OpeningAmount float not null
alter table [Payment].[SessionCash] add ClosingAmount float not null
alter table [Payment].[SessionCash] add IdResponsible int not null
ALTER TABLE [Payment].[SessionCash] WITH NOCHECK
    ADD CONSTRAINT [FK_UserResponsible_SessionCash] FOREIGN KEY ([IdResponsible]) REFERENCES [ERPSettings].[User] ([Id]);
ALTER TABLE [Payment].[SessionCash] WITH CHECK CHECK CONSTRAINT [FK_UserResponsible_SessionCash];

--- Imen chaaben 12/08/2021: add column IdWarehouse in cash register 
ALTER TABLE [Payment].[CashRegister] ADD IdWarehouse INT NOT NULL;
ALTER TABLE [Payment].[CashRegister] WITH NOCHECK ADD CONSTRAINT [FK_CashRegister_Warehouse] FOREIGN KEY ([IdWarehouse]) REFERENCES [Inventory].[Warehouse] ([Id]);
ALTER TABLE [Payment].[CashRegister] WITH CHECK CHECK CONSTRAINT [FK_CashRegister_Warehouse];
ALTER TABLE [Payment].[CashRegister] ALTER COLUMN [IdResponsible] INT NOT NULL

--- Imen chaaben 13/08/2021: delete column Id
ALTER TABLE [Payment].[SessionCash] DROP CONSTRAINT [FK_UserResponsible_SessionCash];
ALTER TABLE [Payment].[SessionCash] DROP COLUMN IdResponsible;

--- Youssef maaloul 18/08/2021: add idInvoice to ticket
ALTER TABLE [Treasury].[Ticket] ADD [IdInvoice] INT NULL;
ALTER TABLE [Treasury].[Ticket] WITH NOCHECK ADD CONSTRAINT [FK_Ticket_Document1] FOREIGN KEY ([IdInvoice]) REFERENCES [Sales].[Document] ([Id]);
ALTER TABLE [Treasury].[Ticket] WITH CHECK CHECK CONSTRAINT [FK_Ticket_Document1];

--- Imen chaaben 18/08/2021: add TicketPayment
CREATE TABLE [Treasury].[TicketPayment] (
    [Id]                INT        IDENTITY (1, 1) NOT NULL,
    [CreationDate]      DATETIME   NOT NULL,
    [IdTicket]          INT        NOT NULL,
    [IdPaymentType]     INT        NOT NULL,
    [Amount]            FLOAT (53) NOT NULL,
    [ReceivedAmount]    FLOAT (53) NULL,
    [AmountReturned]    FLOAT (53) NULL,
    [IsDeleted]         BIT        NOT NULL,
    [TransactionUserId] INT        NOT NULL,
    CONSTRAINT [PK_TicketPayment] PRIMARY KEY CLUSTERED ([Id] ASC)
);

ALTER TABLE [Treasury].[TicketPayment]
    ADD CONSTRAINT [DF_TicketPayment_TransactionUserId] DEFAULT ((0)) FOR [TransactionUserId];
ALTER TABLE [Treasury].[TicketPayment] WITH NOCHECK
    ADD CONSTRAINT [FK_TicketPayment_PaymentType] FOREIGN KEY ([IdPaymentType]) REFERENCES [Payment].[PaymentType] ([Id]);
ALTER TABLE [Treasury].[TicketPayment] WITH NOCHECK
    ADD CONSTRAINT [FK_TicketPayment_Ticket] FOREIGN KEY ([IdTicket]) REFERENCES [Treasury].[Ticket] ([Id]);
ALTER TABLE [Treasury].[TicketPayment] WITH CHECK CHECK CONSTRAINT [FK_TicketPayment_PaymentType];
ALTER TABLE [Treasury].[TicketPayment] WITH CHECK CHECK CONSTRAINT [FK_TicketPayment_Ticket];

GO

--- Youssef maaloul 01/09/2021: add Deleted_Token to TicketPayment
ALTER TABLE [Treasury].[TicketPayment]      ADD [Deleted_Token] NVARCHAR (255) NULL;
--- Youssef maaloul 13/09/2021: add Status to TicketPayment
GO
ALTER TABLE [Treasury].[TicketPayment]
    ADD [Status] INT NULL;

--- Youssef maaloul 14/09/2021: add IdSessionCash to Settlement
GO
ALTER TABLE [Payment].[Settlement]
    ADD [IdSessionCash] INT NULL;

GO
ALTER TABLE [Payment].[Settlement] WITH NOCHECK
    ADD CONSTRAINT [FK_Settlement_SessionCash] FOREIGN KEY ([IdSessionCash]) REFERENCES [Payment].[SessionCash] ([Id]);

GO
ALTER TABLE [Payment].[Settlement] WITH CHECK CHECK CONSTRAINT [FK_Settlement_SessionCash];

--- Kossi add closing cash amount to SessionCash 14/09/2021
ALTER TABLE [Payment].[SessionCash]
    ADD [ClosingCashAmount] FLOAT(53) NOT NULL DEFAULT(0);

--- Youssef maaloul 15/09/2021: add CalculatedTotalAmount to Settlement
ALTER TABLE [Payment].[SessionCash]
    ADD [CalculatedTotalAmount] FLOAT(53) NOT NULL DEFAULT(0);