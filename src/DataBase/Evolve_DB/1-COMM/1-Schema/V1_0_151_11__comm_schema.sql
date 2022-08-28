--- Youssef add new table documentTaxeResume and add two column TaxeValueWithCurrency and TaxeValueWithCurrency into DocumentTaxeLine
ALTER TABLE [Sales].[DocumentLineTaxe]
    ADD [TaxeBaseWithCurrency]  FLOAT (53) NULL,
        [TaxeValueWithCurrency] FLOAT (53) NULL;


CREATE TABLE [Sales].[DocumentTaxsResume] (
    [Id]                          INT            IDENTITY (1, 1) NOT NULL,
    [Id_Tax]                      INT            NULL,
    [HtAmount]                    FLOAT (53)     NULL,
    [HtAmountWithCurrency]        FLOAT (53)     NULL,
    [TaxAmount]                   FLOAT (53)     NULL,
    [TaxAmountWithCurrency]       FLOAT (53)     NULL,
    [IsDeleted]                   BIT            NOT NULL,
    [Deleted_Token]               NVARCHAR (255) NULL,
    [IdDocument]                  INT            NOT NULL,
    [DiscountAmount]              FLOAT (53)     NULL,
    [DiscountAmountWithCurrency]  FLOAT (53)     NULL,
    [ExcVatTaxAmount]             FLOAT (53)     NULL,
    [ExcVatTaxAmountWithCurrency] FLOAT (53)     NULL,
    CONSTRAINT [PK_DocumentTaxsResume] PRIMARY KEY CLUSTERED ([Id] ASC)
);


ALTER TABLE [Sales].[DocumentTaxsResume] WITH NOCHECK
    ADD CONSTRAINT [FK_DocumentTaxsResume_Document] FOREIGN KEY ([IdDocument]) REFERENCES [Sales].[Document] ([Id]);


ALTER TABLE [Sales].[DocumentTaxsResume] WITH NOCHECK
    ADD CONSTRAINT [FK_DocumentTaxsResume_Taxe] FOREIGN KEY ([Id_Tax]) REFERENCES [Shared].[Taxe] ([Id]);

ALTER TABLE [Sales].[DocumentTaxsResume] WITH CHECK CHECK CONSTRAINT [FK_DocumentTaxsResume_Document];

ALTER TABLE [Sales].[DocumentTaxsResume] WITH CHECK CHECK CONSTRAINT [FK_DocumentTaxsResume_Taxe];