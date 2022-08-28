--- Souhail El Kamel : add table bankDeposit

GO
PRINT N'Altering [Payment].[Settlement]...';


GO
ALTER TABLE [Payment].[Settlement]
    ADD [IdPaymentSlip] INT NULL;


GO
PRINT N'Creating [Payment].[PaymentSlip]...';


GO
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


GO
PRINT N'Creating [Payment].[FK_Settlement_PaymentSlip]...';


GO
ALTER TABLE [Payment].[Settlement] WITH NOCHECK
    ADD CONSTRAINT [FK_Settlement_PaymentSlip] FOREIGN KEY ([IdPaymentSlip]) REFERENCES [Payment].[PaymentSlip] ([Id])
    ON UPDATE  NO ACTION 
    ON DELETE  SET NULL;


GO
PRINT N'Creating [Treasury].[FK_PaymentSlip_BankAccount]...';


GO
ALTER TABLE [Payment].[PaymentSlip] WITH NOCHECK
    ADD CONSTRAINT [FK_PaymentSlip_BankAccount] FOREIGN KEY ([IdBankAccount]) REFERENCES [Shared].[BankAccount] ([Id]);

GO

--- Imen chaaben : Add Label to Settlement
GO
ALTER TABLE [Payment].[Settlement]
      ADD [Label] NVARCHAR (255)  NULL;

--- kossi add colum WithholdingTaxAttachmentUrl to settlement table
ALTER TABLE [Payment].[Settlement] 
	ADD [WithholdingTaxAttachmentUrl] NVARCHAR (MAX) NULL