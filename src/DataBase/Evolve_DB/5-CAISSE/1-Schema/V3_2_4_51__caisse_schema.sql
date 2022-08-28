--- Youssef Maaloul update fundsTransfer table table 25/10/2021	
GO
ALTER TABLE [Payment].[FundsTransfer] DROP CONSTRAINT [FK_FundsTransfer_DestinationCashRegister];

ALTER TABLE [Payment].[FundsTransfer] DROP CONSTRAINT [FK_FundsTransfer_SourceCashRegister];

GO
ALTER TABLE [Payment].[FundsTransfer] ALTER COLUMN [IdDestinationCash] INT NULL;

ALTER TABLE [Payment].[FundsTransfer] ALTER COLUMN [IdSourceCash] INT NULL;

GO
ALTER TABLE [Payment].[FundsTransfer] WITH NOCHECK
    ADD CONSTRAINT [FK_FundsTransfer_DestinationCashRegister] FOREIGN KEY ([IdDestinationCash]) REFERENCES [Payment].[CashRegister] ([Id]);

GO
ALTER TABLE [Payment].[FundsTransfer] WITH NOCHECK
    ADD CONSTRAINT [FK_FundsTransfer_SourceCashRegister] FOREIGN KEY ([IdSourceCash]) REFERENCES [Payment].[CashRegister] ([Id]);

GO
ALTER TABLE [Payment].[FundsTransfer] WITH CHECK CHECK CONSTRAINT [FK_FundsTransfer_DestinationCashRegister];

ALTER TABLE [Payment].[FundsTransfer] WITH CHECK CHECK CONSTRAINT [FK_FundsTransfer_SourceCashRegister];

--- Youssef Maaloul add Amount to cashRegister table 25/10/2021
ALTER TABLE [Payment].[CashRegister]
    ADD Amount float NOT NULL 
    CONSTRAINT DF_CashRegister_Amount DEFAULT 0;

--- Imen chaaben: add IdBankAccount 25/10/2021
ALTER TABLE [Payment].[FundsTransfer] ADD IdBankAccount int NULL;
GO
ALTER TABLE [Payment].[FundsTransfer] WITH NOCHECK
    ADD CONSTRAINT [FK_FundsTransfer_BankAccount] FOREIGN KEY ([IdBankAccount]) REFERENCES [Shared].[BankAccount] ([Id]);

--- Youssef Maaloul add TransportCompany to FundsTransfer table and Reference to OperationCash 27/10/2021	
GO
ALTER TABLE [Payment].[FundsTransfer]
    ADD [TransportCompany] NVARCHAR (MAX) NULL;
GO
ALTER TABLE [Treasury].[OperationCash]
    ADD [Reference] NVARCHAR (MAX) NOT NULL;
	
--- Youssef Maaloul add IsAccounted and EmailCreator to FundsTransfer table 02/11/2021	
ALTER TABLE [Payment].[FundsTransfer]
	ADD  [IsAccounted]	BIT	CONSTRAINT [DF_FundsTransfer_IsAccounted] DEFAULT ((0)) NOT NULL
ALTER TABLE [Payment].[FundsTransfer]
	ADD  [EmailCreator]	NVARCHAR(255) NULL