CREATE SCHEMA [Ecommerce] AUTHORIZATION [dbo];

BEGIN TRANSACTION

ALTER TABLE [Inventory].[Item]
    ADD [IsEcommerce]                BIT      DEFAULT ((0)) NOT NULL,
        [ExistInEcommerce]           BIT      DEFAULT ((0)) NOT NULL,
        [OnlineSynchonizationStatus] INT      NULL,
        [SynchonizationStatus]       INT      NULL,
        [LastUpdateEcommerce]        DATETIME DEFAULT (getutcdate()) NULL;
		
		
		
		ALTER TABLE [Inventory].[Warehouse]
    ADD [IsEcommerce]        BIT DEFAULT ((0)) NOT NULL,
        [ForEcommerceModule] BIT DEFAULT ((0)) NOT NULL;
		
		
ALTER TABLE [Sales].[Tiers]
    ADD [IdEcommerceCustomer] INT NULL;

ALTER TABLE [Sales].[Document]
    ADD [IdInvoiceEcommerce] INT NULL;
	
	
	CREATE TABLE [Ecommerce].[TriggerItemLog] (
    [Id]      INT            IDENTITY (1, 1) NOT NULL,
    [IdItem]  INT            NOT NULL,
    [Code]    INT            NULL,
    [Message] NVARCHAR (MAX) NULL,
    [DateLog] DATETIME       NULL,
    CONSTRAINT [PK_TriggerItemlOG] PRIMARY KEY CLUSTERED ([Id] ASC)
);



CREATE TABLE [Ecommerce].[JobTable] (
    [Id]              INT      IDENTITY (1, 1) NOT NULL,
    [LastExecuteDate] DATETIME NULL,
    [NextExecuteDate] DATETIME NULL,
    CONSTRAINT [PK_JobTable] PRIMARY KEY CLUSTERED ([Id] ASC)
);


CREATE TABLE [Ecommerce].[Delivery] (
    [Id]     INT IDENTITY (1, 1) NOT NULL,
    [IdItem] INT NOT NULL,
    CONSTRAINT [PK_Delivery] PRIMARY KEY CLUSTERED ([Id] ASC)
);


ALTER TABLE [Ecommerce].[JobTable]
    ADD CONSTRAINT [DF_JobTable_LastExecuteDate] DEFAULT (datetimefromparts(datepart(year,getutcdate()),datepart(month,getutcdate()),datepart(day,getutcdate()),(0),(0),(0),(0))) FOR [LastExecuteDate];

ALTER TABLE [Ecommerce].[JobTable]
    ADD CONSTRAINT [DF_JobTable_NextExecuteDate] DEFAULT (dateadd(day,(1),datetimefromparts(datepart(year,getutcdate()),datepart(month,getutcdate()),datepart(day,getutcdate()),(0),(0),(0),(0)))) FOR [NextExecuteDate];



ALTER TABLE [Ecommerce].[TriggerItemLog] WITH NOCHECK
    ADD CONSTRAINT [FK_TriggerItemLog_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id]);
	
	ALTER TABLE [Ecommerce].[Delivery] WITH NOCHECK
    ADD CONSTRAINT [FK_Delivery_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id]);
	



ALTER TABLE [Ecommerce].[TriggerItemLog] WITH CHECK CHECK CONSTRAINT [FK_TriggerItemLog_Item];

ALTER TABLE [Ecommerce].[Delivery] WITH CHECK CHECK CONSTRAINT [FK_Delivery_Item];


COMMIT TRANSACTION