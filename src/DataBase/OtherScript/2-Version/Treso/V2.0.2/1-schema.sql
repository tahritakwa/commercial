-- Imen chaaben: Add [Sales].[DocumentWithholdingTax]
GO
ALTER TABLE [Payment].[WithholdingTax] DROP CONSTRAINT [FK_WithholdingTax_Tiers];	
ALTER TABLE [Payment].[WithholdingTax] DROP CONSTRAINT [DF_WithholdingTax_StateFlag];	

Go 
ALTER TABLE [Payment].[WithholdingTax]
DROP    COLUMN  [CodeWithHolding],
	    COLUMN  [Description],
		COLUMN	[Rate],
		COLUMN	[TotalHoldingPrice],
		COLUMN  [TotalTTCPrice],
		COLUMN	[TotalNetAmount],
		COLUMN	[Date],
		COLUMN	[IdTiers],
		COLUMN	[StateFlag],
		COLUMN	[WithholdingTax_int_1],
		COLUMN	[WithholdingTax_int_2],
		COLUMN	[WithholdingTax_int_3],
		COLUMN 	[WithholdingTax_int_4],
		COLUMN 	[WithholdingTax_int_5],
		COLUMN 	[WithholdingTax_int_6],
		COLUMN 	[WithholdingTax_int_7],
		COLUMN 	[WithholdingTax_int_8],
		COLUMN 	[WithholdingTax_int_9],
		COLUMN 	[WithholdingTax_int_10],
		COLUMN 	[WithholdingTax_bit_1],
		COLUMN 	[WithholdingTax_bit_2],
		COLUMN 	[WithholdingTax_bit_3],
		COLUMN 	[WithholdingTax_bit_4],
		COLUMN 	[WithholdingTax_bit_5],
		COLUMN 	[WithholdingTax_bit_6],
		COLUMN 	[WithholdingTax_bit_7],
		COLUMN 	[WithholdingTax_bit_8],
		COLUMN 	[WithholdingTax_bit_9],
		COLUMN 	[WithholdingTax_bit_10],
		COLUMN 	[WithholdingTax_float_1],
		COLUMN 	[WithholdingTax_float_2],
		COLUMN 	[WithholdingTax_float_3],
		COLUMN 	[WithholdingTax_float_4],
		COLUMN 	[WithholdingTax_float_5],
		COLUMN 	[WithholdingTax_float_6],
		COLUMN 	[WithholdingTax_float_7],
		COLUMN 	[WithholdingTax_float_8],
		COLUMN 	[WithholdingTax_float_9],
		COLUMN 	[WithholdingTax_float_10],
		COLUMN 	[WithholdingTax_varchar_1],
		COLUMN 	[WithholdingTax_varchar_2],
		COLUMN 	[WithholdingTax_varchar_3],
		COLUMN 	[WithholdingTax_varchar_4],
		COLUMN 	[WithholdingTax_varchar_5],
		COLUMN 	[WithholdingTax_varchar_6],
		COLUMN 	[WithholdingTax_varchar_7],
		COLUMN 	[WithholdingTax_varchar_8],
		COLUMN 	[WithholdingTax_varchar_9],
		COLUMN 	[WithholdingTax_varchar_10],
		COLUMN 	[WithholdingTax_date_1],
		COLUMN 	[WithholdingTax_date_2],
		COLUMN 	[WithholdingTax_date_3],
		COLUMN 	[WithholdingTax_date_4],
		COLUMN 	[WithholdingTax_date_5],
		COLUMN 	[WithholdingTax_date_6],
		COLUMN 	[WithholdingTax_date_7],
		COLUMN 	[WithholdingTax_date_8],
		COLUMN 	[WithholdingTax_date_9],
		COLUMN 	[WithholdingTax_date_10];
GO
ALTER TABLE [Payment].[WithholdingTax]
ADD  [Code]              NVARCHAR (50)  NULL,
     [Designation]       NVARCHAR (50)  NULL,
     [Percentage]        FLOAT (53)     NOT NULL;
	
GO
PRINT N'Création de [Sales].[DocumentWithholdingTax]...';

GO
CREATE TABLE [Sales].[DocumentWithholdingTax] (
    [Id]                         INT            IDENTITY (1, 1) NOT NULL,
    [IdDocument]                 INT            NOT NULL,
    [IdWithholdingTax]           INT            NOT NULL,
    [AmountWithCurrency]         FLOAT (53)     CONSTRAINT [DF_DocumentWithholdingTax_AmountWithCurrency] DEFAULT ((0)) NOT NULL,
    [Amount]                     FLOAT (53)     CONSTRAINT [DF_DocumentWithholdingTax_Amount] DEFAULT ((0)) NOT NULL,
    [WithholdingTaxWithCurrency] FLOAT (53)     CONSTRAINT [DF_DocumentWithholdingTax_WithholdingTaxWithCurrency] DEFAULT ((0)) NOT NULL,
    [WithholdingTax]             FLOAT (53)     CONSTRAINT [DF_DocumentWithholdingTax_withholdingTax] DEFAULT ((0)) NOT NULL,
    [IsDeleted]                  BIT            NOT NULL,
    [TransactionUserId]          INT            NULL,
    [Deleted_Token]              NVARCHAR (255) NULL,
    CONSTRAINT [PK_DocumentWithholdingTax] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
ALTER TABLE [Sales].[DocumentWithholdingTax] WITH NOCHECK
    ADD CONSTRAINT [FK_DocumentWithholdingTax_Document] FOREIGN KEY ([IdDocument]) REFERENCES [Sales].[Document] ([Id]);
GO
ALTER TABLE [Sales].[DocumentWithholdingTax] WITH NOCHECK
    ADD CONSTRAINT [FK_DocumentWithholdingTax_WithholdingTax] FOREIGN KEY ([IdWithholdingTax]) REFERENCES [Payment].[WithholdingTax] ([Id]);

--- kossi add colum label WithholdingTaxAttachmentUrl to settlement table
ALTER TABLE [Payment].[Settlement] 
    ADD [WithholdingTaxAttachmentUrl] NVARCHAR (MAX) NULL

GO
ALTER TABLE [Shared].[BankAccount] ALTER COLUMN [Agence] NVARCHAR (250) NOT NULL;

 


GO
ALTER TABLE [Shared].[BankAccount]
    ADD [Entitled]    NVARCHAR (50) NOT NULL,
        [Email]       NVARCHAR (50) NULL,
        [Telephone]   INT           NULL,
        [Fax]         INT           NULL,
        [Pic]         VARCHAR (50)  NULL,
        [TypeAccount] INT           NULL,
        [IdCountry]   INT           NOT NULL,
        [IdCity]      INT           NOT NULL,
        [ZipCode]     NVARCHAR (50) NULL,
        [IdCurrency]  INT           NOT NULL;

GO

ALTER TABLE [Shared].[BankAccount] WITH NOCHECK
    ADD CONSTRAINT [FK_BankAccount_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id]);


GO
ALTER TABLE [Shared].[BankAccount] WITH NOCHECK
    ADD CONSTRAINT [FK_BankAccount_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id]);

 

GO
ALTER TABLE [Shared].[BankAccount] WITH NOCHECK
    ADD CONSTRAINT [FK_BankAccount_Currency] FOREIGN KEY ([IdCurrency]) REFERENCES [Administration].[Currency] ([Id]);

--- Imen chaaben: change Financial commtment properties for withholding Tax
GO
ALTER TABLE [Sales].[FinancialCommitment]
ADD  [WithholdingTaxWithCurrency]   float   NULL,
     [WithholdingTax]   float   NULL,
     [RemainingWithholdingTax]   float   NULL,
     [RemainingWithholdingTaxWithCurrency]   float   NULL,
     [AmountWithoutWithholdingTax]   float   NULL,
     [AmountWithoutWithholdingTaxWithCurrency]   float   NULL;


alter table  [Sales].[FinancialCommitment] drop CONSTRAINT [DF_FinancialCommitment_WithholdingTaxHasBeenToken]
ALTER TABLE [Sales].[FinancialCommitment] DROP COLUMN [WithholdingTaxHasBeenToken];


--- Youssef maaloul : delete and change reflectiveSettlement properties
GO
ALTER TABLE [Payment].[ReflectiveSettlement]
drop column  [AssignedAmount],[AssignedAmountWithCurrency],[ExchangeRate];
	 
GO
sp_rename 'Payment.ReflectiveSettlement.IdSettlementReplaced', 'IdGapSettlement', 'COLUMN';

--- Imen Chaaben: [SettlementCommitment] --
GO
ALTER TABLE [Payment].[Settlement] DROP COLUMN [Note];

GO
ALTER TABLE [Payment].[SettlementCommitment] DROP CONSTRAINT [DF_SettlementCommitment_RemplacedBy];
ALTER TABLE [Payment].[SettlementCommitment] DROP COLUMN [RemplacedBy];

ALTER TABLE [Payment].[SettlementCommitment]
        ADD [AssignedWithholdingTax]   float    NULL,
		    [AssignedWithholdingTaxWithCurrency]   float  NULL;

--- Kossi alter table [Shared].[BankAccount]
ALTER TABLE [Shared].[BankAccount] DROP CONSTRAINT [FK_BankAccount_Country];
ALTER TABLE [Shared].[BankAccount] DROP CONSTRAINT [FK_BankAccount_City];
ALTER TABLE [Shared].[BankAccount] DROP COLUMN [IdCountry];
ALTER TABLE [Shared].[BankAccount] DROP COLUMN [IdCity];
ALTER TABLE [Shared].[BankAccount] 
		ADD [IdCountry] int NULL,
			[IdCity] int NULL;
ALTER TABLE [Shared].[BankAccount] 
		ADD CONSTRAINT [FK_BankAccount_Country] 
		FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country]([Id]);

ALTER TABLE [Shared].[BankAccount] 
		ADD CONSTRAINT [FK_BankAccount_City] 
		FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City]([Id]);

--- Imen Chaaben: Add [SettlementDocumentWithholdingTax] table and [RemainingWithholdingTax] column to [DocumentWithholdingTax]
GO
CREATE TABLE [Payment].[SettlementDocumentWithholdingTax] (
    [Id]                                 INT            IDENTITY (1, 1) NOT NULL,
    [IdSettlement]                       INT            NOT NULL,
    [IdDocumentWithholdingTax]           INT            NOT NULL,
    [AssignedWithholdingTax]             FLOAT (53)     NULL,
    [AssignedWithholdingTaxWithCurrency] FLOAT (53)     NOT NULL,
    [IsDeleted]                          BIT            NOT NULL,
    [Deleted_Token]                      NVARCHAR (255) NULL,
    CONSTRAINT [PK_SettlementDocumentWithholdingTax] PRIMARY KEY CLUSTERED ([Id] ASC)
);

Go 
ALTER TABLE [Sales].[DocumentWithholdingTax]
    Add [RemainingWithholdingTaxWithCurrency] FLOAT (53)     NULL,
        [RemainingWithholdingTax]             FLOAT (53)     NULL;

--- Imen Chaaben: Add totalAmount to SettlementDocumentWithholdingTax
Go 
ALTER TABLE [Payment].[SettlementDocumentWithholdingTax]
    Add     [TotalAmount]    FLOAT (53)  NULL,
            [TotalAmountWithCurrency]    FLOAT (53) NOT NULL;
	
--- kossi alter table [Shared][BankAccount] 08/07/2020
GO
ALTER TABLE [Shared].[BankAccount] DROP CONSTRAINT [DF__BankAccou__Initi__20CCCE1C];

GO
ALTER TABLE [Shared].[BankAccount] DROP CONSTRAINT [DF__BankAccou__Curre__21C0F255];

GO
ALTER TABLE [Shared].[BankAccount]
	DROP COLUMN [BankAccount_bit_1], 
	COLUMN [BankAccount_bit_10], COLUMN [BankAccount_bit_2], 
	COLUMN [BankAccount_bit_3], COLUMN [BankAccount_bit_4], 
	COLUMN [BankAccount_bit_5], COLUMN [BankAccount_bit_6], 
	COLUMN [BankAccount_bit_7], COLUMN [BankAccount_bit_8], 
	COLUMN [BankAccount_bit_9], COLUMN [BankAccount_date_1], 
	COLUMN [BankAccount_date_10], COLUMN [BankAccount_date_2], 
	COLUMN [BankAccount_date_3], COLUMN [BankAccount_date_4], 
	COLUMN [BankAccount_date_5], COLUMN [BankAccount_date_6], 
	COLUMN [BankAccount_date_7], COLUMN [BankAccount_date_8], 
	COLUMN [BankAccount_date_9], COLUMN [BankAccount_float_1], 
	COLUMN [BankAccount_float_10], COLUMN [BankAccount_float_2], 
	COLUMN [BankAccount_float_3], COLUMN [BankAccount_float_4], 
	COLUMN [BankAccount_float_5], COLUMN [BankAccount_float_6], 
	COLUMN [BankAccount_float_7], COLUMN [BankAccount_float_8], 
	COLUMN [BankAccount_float_9], COLUMN [BankAccount_int_1], 
	COLUMN [BankAccount_int_10], COLUMN [BankAccount_int_2], 
	COLUMN [BankAccount_int_3], COLUMN [BankAccount_int_4], 
	COLUMN [BankAccount_int_5], COLUMN [BankAccount_int_6], 
	COLUMN [BankAccount_int_7], COLUMN [BankAccount_int_8], 
	COLUMN [BankAccount_int_9], COLUMN [BankAccount_varchar_1], 
	COLUMN [BankAccount_varchar_10], COLUMN [BankAccount_varchar_2], 
	COLUMN [BankAccount_varchar_3], COLUMN [BankAccount_varchar_4], 
	COLUMN [BankAccount_varchar_5], COLUMN [BankAccount_varchar_6], 
	COLUMN [BankAccount_varchar_7], COLUMN [BankAccount_varchar_8], 
	COLUMN [BankAccount_varchar_9];


GO
ALTER TABLE [Shared].[BankAccount]
    ADD CONSTRAINT [DF__BankAccou__Curre__5FA91635] DEFAULT ((0)) FOR [CurrentBalance];

GO
ALTER TABLE [Shared].[BankAccount]
    ADD CONSTRAINT [DF__BankAccou__Initi__5EB4F1FC] DEFAULT ((0)) FOR [InitialBalance];


--- Kossi alter table [Treasury].[Reconciliation] 10/07/2020
GO
ALTER TABLE [Treasury].[Reconciliation]
	DROP COLUMN [IdReconciliationAxis_1], COLUMN [IdReconciliationAxis_10], 
	COLUMN [IdReconciliationAxis_11], COLUMN [IdReconciliationAxis_12], 
	COLUMN [IdReconciliationAxis_13], COLUMN [IdReconciliationAxis_14], 
	COLUMN [IdReconciliationAxis_15], COLUMN [IdReconciliationAxis_16], 
	COLUMN [IdReconciliationAxis_17], COLUMN [IdReconciliationAxis_18], 
	COLUMN [IdReconciliationAxis_19], COLUMN [IdReconciliationAxis_2], 
	COLUMN [IdReconciliationAxis_20], COLUMN [IdReconciliationAxis_21], 
	COLUMN [IdReconciliationAxis_22], COLUMN [IdReconciliationAxis_23],
	COLUMN [IdReconciliationAxis_24], COLUMN [IdReconciliationAxis_25], 
	COLUMN [IdReconciliationAxis_26], COLUMN [IdReconciliationAxis_27], 
	COLUMN [IdReconciliationAxis_28], COLUMN [IdReconciliationAxis_29], 
	COLUMN [IdReconciliationAxis_3], COLUMN [IdReconciliationAxis_30], 
	COLUMN [IdReconciliationAxis_4], COLUMN [IdReconciliationAxis_5],
	COLUMN [IdReconciliationAxis_6], COLUMN [IdReconciliationAxis_7], 
	COLUMN [IdReconciliationAxis_8], COLUMN [IdReconciliationAxis_9];

GO
ALTER TABLE [Treasury].[Reconciliation]
    ADD [AttachmentUrl] NVARCHAR (MAX) NULL;

--- Kossi alter table [Treasury][DetailReconciliation]
GO
ALTER TABLE [Treasury].[DetailReconciliation] 
	DROP COLUMN [IdDetailReconciliationAxis_1], COLUMN [IdDetailReconciliationAxis_10],
	COLUMN [IdDetailReconciliationAxis_11], COLUMN [IdDetailReconciliationAxis_12], 
	COLUMN [IdDetailReconciliationAxis_13], COLUMN [IdDetailReconciliationAxis_14], 
	COLUMN [IdDetailReconciliationAxis_15], COLUMN [IdDetailReconciliationAxis_16], 
	COLUMN [IdDetailReconciliationAxis_17], COLUMN [IdDetailReconciliationAxis_18], 
	COLUMN [IdDetailReconciliationAxis_19], COLUMN [IdDetailReconciliationAxis_2], 
	COLUMN [IdDetailReconciliationAxis_20], COLUMN [IdDetailReconciliationAxis_21], 
	COLUMN [IdDetailReconciliationAxis_22], COLUMN [IdDetailReconciliationAxis_23], 
	COLUMN [IdDetailReconciliationAxis_24], COLUMN [IdDetailReconciliationAxis_25],
	COLUMN [IdDetailReconciliationAxis_26], COLUMN [IdDetailReconciliationAxis_27], 
	COLUMN [IdDetailReconciliationAxis_28], COLUMN [IdDetailReconciliationAxis_29], 
	COLUMN [IdDetailReconciliationAxis_3], COLUMN [IdDetailReconciliationAxis_30], 
	COLUMN [IdDetailReconciliationAxis_4], COLUMN [IdDetailReconciliationAxis_5], 
	COLUMN [IdDetailReconciliationAxis_6], COLUMN [IdDetailReconciliationAxis_7], 
	COLUMN [IdDetailReconciliationAxis_8], COLUMN [IdDetailReconciliationAxis_9];

--- kossi alter table [Treasury].[Reconciliation] 14/07/2020
ALTER TABLE [Treasury].[Reconciliation]
    ADD CONSTRAINT [FK_Reconciliation_BankAccount] FOREIGN KEY ([IdBankAccount]) REFERENCES [Shared].[BankAccount] ([Id]);


	
---- Imen chaaben : add FOREIGN KEY to [SettlementDocumentWithholdingTax]

GO
ALTER TABLE [Payment].[SettlementDocumentWithholdingTax] WITH NOCHECK
    ADD CONSTRAINT [FK_SettlementDocumentWithholdingTax_DocumentWithholdingTax] FOREIGN KEY ([IdDocumentWithholdingTax]) REFERENCES [Sales].[DocumentWithholdingTax] ([Id]);

GO
ALTER TABLE [Payment].[SettlementDocumentWithholdingTax] WITH NOCHECK
    ADD CONSTRAINT [FK_SettlementDocumentWithholdingTax_Settlement] FOREIGN KEY ([IdSettlement]) REFERENCES [Payment].[Settlement] ([Id]);

GO
ALTER TABLE [Payment].[SettlementDocumentWithholdingTax] WITH CHECK CHECK CONSTRAINT [FK_SettlementDocumentWithholdingTax_DocumentWithholdingTax];

ALTER TABLE [Payment].[SettlementDocumentWithholdingTax] WITH CHECK CHECK CONSTRAINT [FK_SettlementDocumentWithholdingTax_Settlement];