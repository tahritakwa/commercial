CREATE TABLE [Payment].[PaymentSlip] (
    [Id]                     INT            IDENTITY (1, 1) NOT NULL,
    [Reference]              INT            NULL,
    [Agency]                 NVARCHAR (50)  NULL,
    [Deposer]                NVARCHAR (50)  NULL,
    [Date]                   DATE           NULL,
    [IdBankAccount]          INT            NULL,
    [NumberOfSettlement]     INT            NULL,
    [TotalAmountWithNumbers] FLOAT (53)     NULL,
    [TotalAmountWithLetters] NVARCHAR (100) NULL,
    [State]                  INT            NULL,
    [Type]                   NVARCHAR (50)  NULL,
    [Deleted_Token]          NVARCHAR (255) NULL,
    [IsDeleted]              BIT            NOT NULL,
    CONSTRAINT [PK_PaymentSlip] PRIMARY KEY CLUSTERED ([Id] ASC)
);
ALTER TABLE [Payment].[PaymentSlip] WITH NOCHECK
    ADD CONSTRAINT [FK_PaymentSlip_BankAccount] FOREIGN KEY ([IdBankAccount]) REFERENCES [Shared].[BankAccount] ([Id]);
ALTER TABLE [Payment].[PaymentSlip] WITH CHECK CHECK CONSTRAINT [FK_PaymentSlip_BankAccount];


GO
ALTER TABLE [Payment].[Settlement]
    ADD [IdPaymentSlip] INT NULL;

	GO
ALTER TABLE [Payment].[Settlement] WITH NOCHECK
    ADD CONSTRAINT [FK_Settlement_PaymentSlip] FOREIGN KEY ([IdPaymentSlip]) REFERENCES [Payment].[PaymentSlip] ([Id])
    ON UPDATE  NO ACTION 
    ON DELETE  SET NULL;

ALTER TABLE [Payment].[Settlement] 
	   ADD [Label] NVARCHAR (255)  NULL;




GO
ALTER TABLE [Shared].[DayOff] DROP CONSTRAINT [FK_DayOff_Period];

GO
ALTER TABLE [Shared].[DayOff] WITH NOCHECK
    ADD CONSTRAINT [FK_DayOff_Period] FOREIGN KEY ([IdPeriod]) REFERENCES [Shared].[Period] ([Id]) ON DELETE CASCADE;


	ALTER TABLE [Shared].[Hours] DROP CONSTRAINT [FK_Hours_Period];
	ALTER TABLE [Shared].[Hours] WITH NOCHECK
    ADD CONSTRAINT [FK_Hours_Period] FOREIGN KEY ([IdPeriod]) REFERENCES [Shared].[Period] ([Id]) ON DELETE CASCADE;
	ALTER TABLE [Shared].[Hours] WITH CHECK CHECK CONSTRAINT [FK_Hours_Period];