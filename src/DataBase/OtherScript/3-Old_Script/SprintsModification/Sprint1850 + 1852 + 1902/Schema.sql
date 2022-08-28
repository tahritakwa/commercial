
-- Narcisse : Add RIB and BANK and poayement method

ALTER TABLE [Payroll].[Employee] ADD [Rib] NVARCHAR (50)  NULL

ALTER TABLE [Payroll].[Employee] ADD [Bank] NVARCHAR (50)  NULL

ALTER TABLE [Payroll].[Contract] ADD [IdPaymentType] INT  NULL

ALTER TABLE [Payroll].[Contract] ADD CONSTRAINT [FK_Contract_PaymentType] FOREIGN KEY ([IdPaymentType]) REFERENCES [Payment].[PaymentType] ([Id])


--Mohamed BOUZIDI : MAJ Team entity and fix managment strategy

	-- DeleteManagerTableBetweenTeamAndEmployee
	GO
	PRINT N'Dropping [Payroll].[FK_Manager_Team]...';


	GO
	ALTER TABLE [Payroll].[Manager] DROP CONSTRAINT [FK_Manager_Team];


	GO
	PRINT N'Dropping [Payroll].[FK_Manager_Employee]...';


	GO
	ALTER TABLE [Payroll].[Manager] DROP CONSTRAINT [FK_Manager_Employee];


	GO
	PRINT N'Dropping [Payroll].[Manager]...';


	GO
	DROP TABLE [Payroll].[Manager];


	GO
	PRINT N'Update complete.';

	-- AutorizeNullInIdDepartmentOfTableTeam
	GO
	PRINT N'Dropping [Payroll].[FK_Team_Department]...';


	GO
	ALTER TABLE [Payroll].[Team] DROP CONSTRAINT [FK_Team_Department];


	GO
	PRINT N'Altering [Payroll].[Team]...';


	GO
	ALTER TABLE [Payroll].[Team] ALTER COLUMN [IdDepartment] INT NULL;


	GO
	PRINT N'Creating [Payroll].[FK_Team_Department]...';


	GO
	ALTER TABLE [Payroll].[Team] WITH NOCHECK
		ADD CONSTRAINT [FK_Team_Department] FOREIGN KEY ([IdDepartment]) REFERENCES [Payroll].[Department] ([Id]);


	GO
	PRINT N'Checking existing data against newly created constraints';


	GO
	ALTER TABLE [Payroll].[Team] WITH CHECK CHECK CONSTRAINT [FK_Team_Department];


	GO
	PRINT N'Update complete.';

	-- DropIdLineMannagerFromEmpoyee
	GO
	PRINT N'Dropping [Payroll].[FK_Employee_Employee]...';


	GO
	ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Employee];


	GO
	PRINT N'Altering [Payroll].[Employee]...';


	GO
	ALTER TABLE [Payroll].[Employee] DROP COLUMN [IdLineManager];


	GO
	PRINT N'Update complete.';

	-- AddIdManagerInTeam
	GO
	PRINT N'Dropping [Payroll].[FK_Team_Department]...';


	GO
	ALTER TABLE [Payroll].[Team] DROP CONSTRAINT [FK_Team_Department];


	GO
	PRINT N'Dropping [Payroll].[FK_Employee_Team]...';


	GO
	ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_Team];


	GO
	PRINT N'Starting rebuilding table [Payroll].[Team]...';


	GO
	BEGIN TRANSACTION;

	ALTER TABLE [Payroll].[Team] ADD [IdManager] INT NOT NULL ; 
	ALTER TABLE [Payroll].[Team] ALTER COLUMN [TeamCode] NVARCHAR (255) NULL;

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


	GO
	PRINT N'Creating [Payroll].[FK_Team_Department]...';


	GO
	ALTER TABLE [Payroll].[Team] WITH NOCHECK
		ADD CONSTRAINT [FK_Team_Department] FOREIGN KEY ([IdDepartment]) REFERENCES [Payroll].[Department] ([Id]);


	GO
	PRINT N'Creating [Payroll].[FK_Employee_Team]...';


	GO
	ALTER TABLE [Payroll].[Employee] WITH NOCHECK
		ADD CONSTRAINT [FK_Employee_Team] FOREIGN KEY ([IdTeam]) REFERENCES [Payroll].[Team] ([Id]);


	GO
	PRINT N'Creating [Payroll].[FK_Team_Employee]...';


	GO
	ALTER TABLE [Payroll].[Team] WITH NOCHECK
		ADD CONSTRAINT [FK_Team_Employee] FOREIGN KEY ([IdManager]) REFERENCES [Payroll].[Employee] ([Id]);


-- Narcisse : Add Resignation date and resignation deposit date

ALTER TABLE [Payroll].[Employee] ADD [ResignationDate] DATE NULL, [ResignationDepositDate] DATE NULL

-- Narcisse : Link cnss with the bonus

ALTER  TABLE [Payroll].[Bonus] DROP COLUMN [IsContributory];

ALTER  TABLE [Payroll].[Bonus] ADD [IdCnss] INT NOT NULL;

ALTER  TABLE [Payroll].[Bonus] ADD CONSTRAINT [FK_Bonus_Cnss] FOREIGN KEY ([IdCnss]) REFERENCES [Payroll].[Cnss] ([Id]);
-- Slim : Add ContractAttached

ALTER TABLE [Payroll].[Contract] ADD [ContractAttached] NVARCHAR (500)  NULL;
GO
PRINT N'Modify Citizenship column...';
ALTER TABLE [Payroll].[Employee] DROP COLUMN  Citizenship ;
ALTER TABLE [Payroll].[Employee] ADD IdCitizenship INT NULL ;

GO
PRINT N'Creating [Payroll].[FK_Employee_Citizenship]...';


GO
ALTER TABLE [Payroll].[Employee] WITH NOCHECK
    ADD CONSTRAINT [FK_Employee_Citizenship] FOREIGN KEY ([IdCitizenship]) REFERENCES [Shared].[Country] ([Id]);


----- Marwa City / Country ----
GO
ALTER TABLE [Shared].[Country]
    ADD [Alpha2] NVARCHAR (2)   NULL,
        [Alpha3] NVARCHAR (3)   NULL,
        [NameEn] NVARCHAR (255) NULL,
        [NameFr] NVARCHAR (255) NULL;
		
		
		
GO
ALTER TABLE [Shared].[Country]
    ADD CONSTRAINT [UniqueAlpha2Country] UNIQUE NONCLUSTERED ([Alpha2] ASC, [Deleted_Token] ASC);
	
	
GO
ALTER TABLE [Shared].[Country]
    ADD CONSTRAINT [UniqueAlpha3Country] UNIQUE NONCLUSTERED ([Alpha3] ASC, [Deleted_Token] ASC);
	
	
	GO  
EXEC sp_rename 'Shared.City.PK_Ville', 'PK_City';

GO  
EXEC sp_rename 'Shared.Country.PK_Pays', 'PK_Country';


GO
ALTER TABLE [Shared].[City] DROP CONSTRAINT [FK_Ville_Pays];

GO
ALTER TABLE [Shared].[City] WITH NOCHECK
    ADD CONSTRAINT [FK_City_Country] FOREIGN KEY ([IdPays]) REFERENCES [Shared].[Country] ([Id]) ON DELETE CASCADE;
	
	GO
ALTER TABLE [Shared].[City] WITH CHECK CHECK CONSTRAINT [FK_City_Country];

GO  
EXEC sp_rename 'Shared.City.IdPays', 'IdCountry';

GO  
EXEC sp_rename 'Sales.Tiers.IdPays', 'IdCountry';



GO
ALTER TABLE [Sales].[Tiers] DROP CONSTRAINT [FK_Tiers_Pays];

GO
ALTER TABLE [Sales].[Tiers] WITH NOCHECK
    ADD CONSTRAINT [FK_Tiers_Country] FOREIGN KEY (IdCountry) REFERENCES [Shared].[Country] ([Id]);
	
GO
ALTER TABLE [Sales].[Tiers] WITH CHECK CHECK CONSTRAINT [FK_Tiers_Country];

GO
ALTER TABLE [Shared].[Country] DROP CONSTRAINT [ConstraintDesgination];

GO
ALTER TABLE [Shared].[City] DROP CONSTRAINT [IX_City_1];

GO
DROP INDEX [IX_City]
    ON [Shared].[City];
GO
ALTER TABLE [Shared].[Country]
    ADD CONSTRAINT [DF_Country_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];

-- Narcisse : Drop IsActive Constraint and column in table Employee


ALTER TABLE [Payroll].[Employee] DROP  CONSTRAINT [DF__Employee__IsActi__5C8CB268];
ALTER TABLE [Payroll].[Employee] DROP COLUMN [IsActive];
    

-- Mohamed BOUZIDI Qualification CRUD

	-- DROP COLUMNS [GraduationYear], [IdQualificationCountry], [IdQualificationType], [QualificationDescritpion] And [University] from Employee
	GO
	PRINT N'Dropping [Payroll].[FK_Employee_QualificationCountry]...';


	GO
	ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_QualificationCountry];


	GO
	PRINT N'Dropping [Payroll].[FK_Employee_QualificationType]...';


	GO
	ALTER TABLE [Payroll].[Employee] DROP CONSTRAINT [FK_Employee_QualificationType];


	GO
	PRINT N'Altering [Payroll].[Employee]...';


	GO
	ALTER TABLE [Payroll].[Employee] DROP COLUMN [GraduationYear], COLUMN [IdQualificationCountry], COLUMN [IdQualificationType], COLUMN [QualificationDescritpion], COLUMN [University];


	GO
	PRINT N'Update complete.';


	GO

	-- CreateQualificationTable
	GO
	PRINT N'Creating [Payroll].[Qualification]...';


	CREATE TABLE [Payroll].[Qualification] (
    [Id]                       INT            IDENTITY (1, 1) NOT NULL,
    [University]               NVARCHAR (255) NOT NULL,
    [QualificationDescritpion] NVARCHAR (MAX) NULL,
    [GraduationYear]           INT            NULL,
    [IdQualificationCountry]   INT            NULL,
    [IdQualificationType]      INT            NULL,
    [IdEmployee]               INT            NOT NULL,
    [QualificationAttached]    NVARCHAR (500) NULL,
    [IsDeleted]                BIT            NOT NULL,
    [TransactionUserId]        INT            NULL,
    [Deleted_Token]            NVARCHAR (255) NULL,
    CONSTRAINT [PK_Qualification_1] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Qualification_Country] FOREIGN KEY ([IdQualificationCountry]) REFERENCES [Shared].[Country] ([Id]),
    CONSTRAINT [FK_Qualification_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [FK_Qualification_QualificationType] FOREIGN KEY ([IdQualificationType]) REFERENCES [Payroll].[QualificationType] ([Id])
	);
	GO
	
	
--- Imen Chaaben: Create price request && prices request detail && TiersPriceRequest
GO
PRINT N'Creating [Sales].[PriceRequest]...';


GO
CREATE TABLE [Sales].[PriceRequest] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Code]              NVARCHAR (255) NOT NULL,
    [Reference]         NVARCHAR (500) NULL,
    [DocumentDate]      DATE           NOT NULL,
    [CreationDate]      DATETIME       NOT NULL,
    [TransactionUserId] INT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IsDeleted]         BIT            NOT NULL,
    CONSTRAINT [PK_PriceRequest] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Sales].[PriceRequestDetail]...';


GO
CREATE TABLE [Sales].[PriceRequestDetail] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdPriceRequest]    INT            NOT NULL,
    [IdItem]            INT            NOT NULL,
    [Designation]       NVARCHAR (300) NULL,
    [MovementQty]       FLOAT (53)     NOT NULL,
    [TransactionUserId] INT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IsDeleted]         BIT            NOT NULL,
    CONSTRAINT [PK_PriceRequestDetail] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Sales].[TiersPriceRequest]...';


GO
CREATE TABLE [Sales].[TiersPriceRequest] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdTiers]           INT            NOT NULL,
    [IdPriceRequest]    INT            NOT NULL,
    [TransactionUserId] INT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IsDeleted]         BIT            NOT NULL,
    CONSTRAINT [PK_TiersPriceRequest] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [Sales].[DF_PriceRequest_TransactionUserId]...';


GO
ALTER TABLE [Sales].[PriceRequest]
    ADD CONSTRAINT [DF_PriceRequest_TransactionUserId] DEFAULT ((0)) FOR [TransactionUserId];


GO
PRINT N'Creating [Sales].[DF_PriceRequestDetail_TransactionUserId]...';


GO
ALTER TABLE [Sales].[PriceRequestDetail]
    ADD CONSTRAINT [DF_PriceRequestDetail_TransactionUserId] DEFAULT ((0)) FOR [TransactionUserId];


GO
PRINT N'Creating [Sales].[DF_TiersPriceRequest_TransactionUserId]...';


GO
ALTER TABLE [Sales].[TiersPriceRequest]
    ADD CONSTRAINT [DF_TiersPriceRequest_TransactionUserId] DEFAULT ((0)) FOR [TransactionUserId];


GO
PRINT N'Creating [Sales].[FK_PriceRequestDetail_Item]...';


GO
ALTER TABLE [Sales].[PriceRequestDetail] WITH NOCHECK
    ADD CONSTRAINT [FK_PriceRequestDetail_Item] FOREIGN KEY ([IdItem]) REFERENCES [Inventory].[Item] ([Id]);


GO
PRINT N'Creating [Sales].[FK_PriceRequestDetail_PriceRequest]...';


GO
ALTER TABLE [Sales].[PriceRequestDetail] WITH NOCHECK
    ADD CONSTRAINT [FK_PriceRequestDetail_PriceRequest] FOREIGN KEY ([IdPriceRequest]) REFERENCES [Sales].[PriceRequest] ([Id]) ON DELETE CASCADE;


GO
PRINT N'Creating [Sales].[FK_TiersPriceRequest_Tiers]...';


GO
ALTER TABLE [Sales].[TiersPriceRequest] WITH NOCHECK
    ADD CONSTRAINT [FK_TiersPriceRequest_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id]);


GO
PRINT N'Creating [Sales].[FK_TiersPriceRequest_PriceRequest]...';


GO
ALTER TABLE [Sales].[TiersPriceRequest] WITH NOCHECK
    ADD CONSTRAINT [FK_TiersPriceRequest_PriceRequest] FOREIGN KEY ([IdPriceRequest]) REFERENCES [Sales].[PriceRequest] ([Id]) ON DELETE CASCADE;


GO
PRINT N'Checking existing data against newly created constraints';





GO
ALTER TABLE [Sales].[PriceRequestDetail] WITH CHECK CHECK CONSTRAINT [FK_PriceRequestDetail_Item];

ALTER TABLE [Sales].[PriceRequestDetail] WITH CHECK CHECK CONSTRAINT [FK_PriceRequestDetail_PriceRequest];

ALTER TABLE [Sales].[TiersPriceRequest] WITH CHECK CHECK CONSTRAINT [FK_TiersPriceRequest_Tiers];

ALTER TABLE [Sales].[TiersPriceRequest] WITH CHECK CHECK CONSTRAINT [FK_TiersPriceRequest_PriceRequest];


GO
PRINT N'Update complete.';

	PRINT('altering bonus table')
	GO
	ALTER  TABLE  [Payroll].[Bonus] ALTER COLUMN [Description] nvarchar(1000);
-- Narcisse: Add transfer order and transfer order details table

GO
PRINT N'Création de [Payroll].[TransferOrder]...';


GO
CREATE TABLE [Payroll].[TransferOrder] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Date]              DATE           NOT NULL,
    [Label]             NVARCHAR (125) NULL,
	[Total]             FLOAT (53)     NULL,
	[IdRib]             INT            NOT NULL,
	[IdSession]         INT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_TransferOrder] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_TransferOrder_Session] FOREIGN KEY ([IdSession]) REFERENCES [Payroll].[Session] ([Id])
);


GO
PRINT N'Création de [Payroll].[TransferOrderDetails]...';


GO
CREATE TABLE [Payroll].[TransferOrderDetails] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [IdEmployee]        INT            NOT NULL,
    [RIB]               NVARCHAR (50)  NULL,
    [Label]             NVARCHAR (50)  NOT NULL,
    [Amount]            FLOAT (53)     NOT NULL,
    [IdTransferOrder]   INT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [IsDeleted]         BIT            NOT NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_TransferOrderDetails] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_TransferOrderDetails_Employee] FOREIGN KEY ([IdEmployee]) REFERENCES [Payroll].[Employee] ([Id])
);


GO
PRINT N'Création de [Payroll].[FK_TransferOrderDetails_TransferOrder]...';


GO
ALTER TABLE [Payroll].[TransferOrderDetails] WITH NOCHECK
    ADD CONSTRAINT [FK_TransferOrderDetails_TransferOrder] FOREIGN KEY ([IdTransferOrder]) REFERENCES [Payroll].[TransferOrder] ([Id]);


GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';


GO
ALTER TABLE [Payroll].[TransferOrderDetails] WITH CHECK CHECK CONSTRAINT [FK_TransferOrderDetails_TransferOrder];


GO
PRINT N'Mise à jour terminée.';


GO


	ALTER  TABLE  [Payroll].[Bonus] ALTER COLUMN [Description] nvarchar(1000);
	
	
-- AHMED CHEBBI INTERNATIONALIZATION
GO
PRINT N'Altering [ERPSettings].[User]...';


GO
ALTER TABLE [ERPSettings].[User]
    ADD [Lang] NVARCHAR (10) NULL;


GO
PRINT N'Update complete.';

-- Narcisse : Alter payement type 

GO
PRINT N'Suppression de [Payroll].[FK_Contract_PaymentType]...';


GO
ALTER TABLE [Payroll].[Contract] DROP CONSTRAINT [FK_Contract_PaymentType];


GO
PRINT N'Modification de [Payroll].[Contract]...';


GO
ALTER TABLE [Payroll].[Contract] DROP COLUMN [IdPaymentType];


GO
PRINT N'Modification de [Payroll].[Employee]...';


GO
ALTER TABLE [Payroll].[Employee]
    ADD [IdPaymentType] INT NULL;


GO
PRINT N'Création de [Payroll].[FK_Employee_PaymentType]...';


GO
ALTER TABLE [Payroll].[Employee] WITH NOCHECK
    ADD CONSTRAINT [FK_Employee_PaymentType] FOREIGN KEY ([IdPaymentType]) REFERENCES [Payment].[PaymentType] ([Id]);


GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';


GO
ALTER TABLE [Payroll].[Employee] WITH CHECK CHECK CONSTRAINT [FK_Employee_PaymentType];


GO
PRINT N'Mise à jour terminée.';


GO
	ALTER  TABLE  [Payroll].[Bonus] ALTER COLUMN [Description] nvarchar(1000);


	--Equivalance Item

	alter  TABLE [Inventory].[Item]
	Add  [EquivalenceItem]   UNIQUEIDENTIFIER  NULL

-- Imen  

ALTER TABLE [Sales].[TiersPriceRequest] ADD [IdContact] INT NOT NULL

ALTER TABLE [Sales].[TiersPriceRequest] ADD CONSTRAINT [FK_TiersPriceRequest_Contact] FOREIGN KEY ([IdContact]) REFERENCES [Shared].[Contact] ([Id])

---- Nihel
-- rename column in settlement table
EXEC sp_rename '[Payment].[Settlement].[PaymentMeans]', 'IdPaymentMethod', 'COLUMN';
-- change constraint in settlement commitment table
ALTER TABLE Payment.SettlementCommitment
DROP CONSTRAINT PK_SettlementCommitment;

ALTER TABLE Payment.SettlementCommitment
ADD CONSTRAINT PK_SettlementCommitment_1 PRIMARY KEY (Id);

GO
ALTER TABLE [Payment].[SettlementCommitment]
    ADD CONSTRAINT [IX_SettlementCommitment] UNIQUE NONCLUSTERED ([CommitmentId] ASC, [SettlementId] ASC);

-- delete columns from settlement table
GO
PRINT N'Altering [Sales].[FinancialCommitment]...';


GO
ALTER TABLE [Sales].[FinancialCommitment] DROP COLUMN [AllocatedAmount], COLUMN [AllocatedAmountWithCurrency];


GO
PRINT N'Update complete.';


-- Narcisse : Bank Account 

GO
PRINT N'Suppression de [Shared].[FK_Company_BankAccount]...';


GO
ALTER TABLE [Shared].[Company] DROP CONSTRAINT [FK_Company_BankAccount];


GO
PRINT N'Modification de [Shared].[Company]...';


GO
ALTER TABLE [Shared].[Company] DROP COLUMN [IdBankAccount];


GO
PRINT N'Mise à jour terminée.';


GO

ALTER TABLE [Shared].[BankAccount] ADD [IdCountry] INT NULL
ALTER TABLE [Shared].[BankAccount] DROP COLUMN [Country]
ALTER TABLE [Shared].[BankAccount] ADD [IdCompany] INT NULL
ALTER TABLE [Shared].[BankAccount] ADD CONSTRAINT [FK_BankAccount_Company] FOREIGN KEY ([IdCompany]) REFERENCES [Shared].[Company] ([Id]),
 CONSTRAINT [FK_BankAccount_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id])
 ALTER TABLE [Shared].[BankAccount] DROP CONSTRAINT [UniqueCodeBankAccount]
ALTER TABLE [Shared].[BankAccount] DROP CONSTRAINT [UniqueIBANBankAccount]
ALTER TABLE [Shared].[BankAccount] DROP CONSTRAINT [UniqueRIBBankAccount]
ALTER TABLE [Shared].[BankAccount] ALTER COLUMN [Rib] NVARCHAR (50)  NOT NULL
ALTER TABLE [Shared].[BankAccount] ALTER COLUMN [IBAN] NVARCHAR (50)  NOT NULL
ALTER TABLE [Shared].[BankAccount] ALTER COLUMN [Code] NVARCHAR (50)  NOT NULL
ALTER TABLE [Shared].[BankAccount] ADD  CONSTRAINT [UniqueCodeBankAccount] UNIQUE NONCLUSTERED ([Deleted_Token] ASC, [Code] ASC),
 CONSTRAINT [UniqueIBANBankAccount] UNIQUE NONCLUSTERED ([IBAN] ASC, [Deleted_Token] ASC),
 CONSTRAINT [UniqueRIBBankAccount] UNIQUE NONCLUSTERED ([Rib] ASC, [Deleted_Token] ASC)

  
--- Nihel: set isstockmanaged columns in nature table as not null 

GO
PRINT N'Creating [Inventory].[DF_Nature_IsStockManaged]...';


GO
ALTER TABLE [Inventory].[Nature]
    ADD CONSTRAINT [DF_Nature_IsStockManaged] DEFAULT ((0)) FOR [IsStockManaged];


GO
PRINT N'Altering [Inventory].[Nature]...';


GO
ALTER TABLE [Inventory].[Nature] ALTER COLUMN [IsStockManaged] BIT NOT NULL;

GO
PRINT N'Update complete.';


GO

  ---Slim : edit city and pays column
  PRINT N'Modify Pays column...';
ALTER TABLE [Shared].[Company] DROP COLUMN  Pays ;
ALTER TABLE [Shared].[Company] ADD IdCountry INT NULL ;

GO
PRINT N'Creating [Shared].[FK_Company_Country]...';


GO
ALTER TABLE [Shared].[Company] WITH NOCHECK
    ADD CONSTRAINT [FK_Company_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id]);

	 PRINT N'Modify City column...';
ALTER TABLE [Shared].[Company] DROP COLUMN  City ;
ALTER TABLE [Shared].[Company] ADD IdCity INT NULL ;

GO
PRINT N'Creating [Shared].[FK_Company_City]...';


GO
ALTER TABLE [Shared].[Company] WITH NOCHECK
    ADD CONSTRAINT [FK_Company_City] FOREIGN KEY ([IdCity]) REFERENCES [Shared].[City] ([Id]);

		 PRINT N'Add IdCompany column...';

ALTER TABLE [Shared].[Contact] ADD IdCompany INT NULL ;

GO
PRINT N'Creating [Shared].[FK_Contact_Company]...';


GO
ALTER TABLE [Shared].[Contact] WITH NOCHECK
    ADD CONSTRAINT [FK_Contact_Company] FOREIGN KEY ([IdCompany]) REFERENCES [Shared].[Company] ([Id]);