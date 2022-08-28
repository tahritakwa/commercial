--03/12/2020 Ahmed Add purchase settings 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (70004, N'Purchase_Settings', N'Paramétrage achat', 0, NULL,77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES ( N'fd671f2f-5b90-4de3-9a07-177b4a3c8477', 70004, 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES ( 70004, N'fd671f2f-5b90-4de3-9a07-177b4a3c8466', 1)

--20/11/2020 Ahmed 
--reporting category
SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] ON
INSERT INTO [ERPSettings].[RoleConfigCategory] ([Id], [Code], [Label], [TranslationCode], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES
(100406, N'Reporting', N'Reporting', N'Reporting', 0, NULL, NULL)
SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] OFF

--Stock Valuation
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES 
(104155, N'StockValuation_config', N'Valorisation de stock', 0, NULL, 100406)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'f98575ba-890d-47c1-a3e8-4c28c9cdb660', N'StockValuation', 4, N'Valorisation de stock', N'Stock Valuation', NULL, NULL, NULL, NULL, N'rh/Reporting', 0, N'Stock-valuation')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 104155, N'f98575ba-890d-47c1-a3e8-4c28c9cdb660', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'1a71f793-9019-4651-af0a-ac691faf60bc',N'Reporting',NULL, 12,N'Reporting',N'Reporting',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'1a71f793-9019-4651-af0a-ac691faf60bc', 104155, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'20b1954b-7565-421d-ae3e-eaae19660b9c', N'f98575ba-890d-47c1-a3e8-4c28c9cdb660', N'1a71f793-9019-4651-af0a-ac691faf60bc')

--Tier Extract
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES 
(104156, N'TierExtract_config', N'Extrait tiers', 0, NULL, 100406)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'f98575ba-890d-47c1-a3e8-4c28c9cdb661', N'TierExtract', 4, N'Extrait tier', N'tier extract', NULL, NULL, NULL, NULL, N'rh/Reporting', 0, N'Tier-Extract')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 104156, N'f98575ba-890d-47c1-a3e8-4c28c9cdb661', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'1a71f793-9019-4651-af0a-ac691faf60bc', 104156, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'20b1954b-7565-421d-ae3e-eaae19661b9c', N'f98575ba-890d-47c1-a3e8-4c28c9cdb661', N'1a71f793-9019-4651-af0a-ac691faf60bc')

--Vat declaration 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES 
(104157, N'VatDeclaration_config', N'Déclaration TVA', 0, NULL, 100406)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'f98575ba-890d-47c1-a3e8-4c28c9cdb662', N'VatDeclaration', 4, N'déclaration TVA', N'vat declarartion', NULL, NULL, NULL, NULL, N'rh/Reporting', 0, N'Vat-Declarartion')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 104157, N'f98575ba-890d-47c1-a3e8-4c28c9cdb662', 1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'1a71f793-9019-4651-af0a-ac691faf60bc', 104157, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'20b1954b-7565-421d-ae3e-eaae19662b9c', N'f98575ba-890d-47c1-a3e8-4c28c9cdb662', N'1a71f793-9019-4651-af0a-ac691faf60bc')

--document control into reporting category
update ERPSettings.RoleConfig set IdRoleConfigCategory = 100406 where Id = 100058
update ERPSettings.RoleConfig set IsDeleted=1 where id = 33333


-- Narcisse: Add company [DaysWorkedInTheWeek] default settings in Session
ALTER TABLE [Payroll].[Session] ADD [DaysWorkedInTheWeek] NVARCHAR (255) NULL;

-- Amine: Add IsAssigned state column in empoyeeTeam 26/11/2020
ALTER TABLE [Payroll].[EmployeeTeam] ADD [IsAssigned] bit not null default(0)


--- Narcisse: Session bonus value cannot be null

ALTER TABLE [Payroll].[SessionBonus] ALTER COLUMN [Value] FLOAT (53) NOT NULL;

-- 25/11/2020 : Ghazoua: delete [Adress] , [IdCity],[IdCountry],[Region] from company table
GO
ALTER TABLE [Shared].[Address] DROP COLUMN [City] ;
ALTER TABLE [Shared].[Address] DROP COLUMN [Country] ;
GO
ALTER TABLE [Shared].[Company] DROP CONSTRAINT [FK_Company_City];
GO
ALTER TABLE [Shared].[Company] DROP CONSTRAINT [FK_Company_Country];

GO
ALTER TABLE [Shared].[Company] DROP COLUMN [Adress], COLUMN [IdCity], COLUMN [IdCountry], COLUMN [Region];

GO
ALTER TABLE [Shared].[Address]  ADD [IdZipCode] INT  NULL
        
GO
ALTER TABLE [Shared].[Address] WITH NOCHECK
    ADD CONSTRAINT [FK_Address_ZipCode] FOREIGN KEY ([IdZipCode]) REFERENCES [Shared].[ZipCode] ([Id]);
ALTER TABLE [Shared].[Address] WITH CHECK CHECK CONSTRAINT [FK_Address_ZipCode];
GO
ALTER TABLE [Shared].[Company] DROP CONSTRAINT [FK_Company_ZipCode];
GO
ALTER TABLE [Shared].[Company] DROP COLUMN [IdZipCode];

GO
ALTER TABLE [Shared].[Address] DROP COLUMN [Region];

--- Donia add recovered material to ExitEmployee and change IdEmployeeExit to IdExitEmployee in Interview 02/12/2020
ALTER TABLE [Payroll].[ExitEmployee] ADD [RecoveredMaterial] BIT DEFAULT ((0)) NOT NULL;

ALTER TABLE [RH].[Interview] DROP CONSTRAINT [FK_Interview_EmployeeExit];
ALTER TABLE [RH].[Interview] DROP COLUMN [IdEmployeeExit];

ALTER TABLE [RH].[Interview] ADD IdExitEmployee INT NULL;
ALTER TABLE [RH].[Interview] WITH NOCHECK
    ADD CONSTRAINT [FK_Interview_ExitEmployee] FOREIGN KEY ([IdExitEmployee]) REFERENCES [Payroll].[ExitEmployee] ([Id]);


--chedi: 16-12-2020 multi-supplier 

/****** Object:  Table [dbo].[ItemTiers]    Script Date: 08/09/2020 15:09:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Inventory].[ItemTiers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdItem] [int] NOT NULL,
	[IdTiers] [int] NOT NULL,
	[DeletedToken] [nchar](250) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ItemTiers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Inventory].[ItemTiers]  WITH CHECK ADD  CONSTRAINT [FK_ItemTiers_Item] FOREIGN KEY([IdItem])
REFERENCES [Inventory].[Item] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [Inventory].[ItemTiers] CHECK CONSTRAINT [FK_ItemTiers_Item]
GO

ALTER TABLE [Inventory].[ItemTiers]  WITH CHECK ADD  CONSTRAINT [FK_ItemTiers_Tiers] FOREIGN KEY([IdTiers])
REFERENCES [Sales].[Tiers] ([Id])
GO

ALTER TABLE [Inventory].[ItemTiers] CHECK CONSTRAINT [FK_ItemTiers_Tiers]
GO

INSERT INTO [Inventory].[ItemTiers]
           ([IdItem]
           ,[IdTiers]
           ,[DeletedToken]
           ,[IsDeleted])
SELECT Id, IdTiers, null, 0 FROM Inventory.Item
where IdTiers is not null


alter table inventory.item drop constraint  UC_Item

alter table inventory.item drop constraint  FK_Item_Tiers


DROP INDEX index_name ON inventory.item;

alter table inventory.item drop column idtiers

CREATE NONCLUSTERED INDEX [index_name]
    ON [Inventory].[Item]([Id] ASC, [Code] ASC, [IdNature] ASC);


GO

GO
PRINT N'Altering [Inventory].[ItemTiers]...';


GO
ALTER TABLE [Inventory].[ItemTiers]
    ADD [PurchasePrice] FLOAT (53) NULL,
        [ExchangeRate]  FLOAT (53) NULL,
        [Margin]        FLOAT (53) NULL,
        [Cost]          FLOAT (53) NULL;
--chedi 17-01-2021 fix edit company profile
PRINT N'Altering [Shared].[Company]...';


GO
ALTER TABLE [Shared].[Company]
    ADD [IdDefaultTax] INT NULL,
        [IdZipCode]    INT NULL;


GO
PRINT N'Creating [Shared].[FK_Company_Taxe]...';


GO
ALTER TABLE [Shared].[Company] WITH NOCHECK
    ADD CONSTRAINT [FK_Company_Taxe] FOREIGN KEY ([IdDefaultTax]) REFERENCES [Shared].[Taxe] ([Id]);


GO
PRINT N'Creating [Shared].[FK_Company_ZipCode]...';


GO
ALTER TABLE [Shared].[Company] WITH NOCHECK
    ADD CONSTRAINT [FK_Company_ZipCode] FOREIGN KEY ([IdZipCode]) REFERENCES [Shared].[ZipCode] ([Id]);

-- Youssef : add TaxeAmount to DocumentLine and add IsCalculable to Taxe 25/03/2021
ALTER TABLE [Sales].[DocumentLine]
    ADD [TaxeAmount] FLOAT (53) NULL;
	
ALTER TABLE [Shared].[Taxe]
    ADD [IsCalculable] BIT NOT NULL DEFAULT 0;

-- Nesrin : update IX_Nature constraint in [Inventory].[Nature] 06/04/2021
ALTER TABLE [Inventory].[Nature] DROP CONSTRAINT [IX_Nature];
ALTER TABLE [Inventory].[Nature] ADD CONSTRAINT [IX_Nature] UNIQUE NONCLUSTERED ([Label] ASC, [Deleted_Token] ASC);

-- Nesrin : add Priority column in Docuemnt table 07/004/2021
ALTER TABLE [Sales].[Document]
    ADD [Priority] INT NULL;
-- Youssef : add TaxeAmount to ExpenseDocumentLine  16/04/2021
ALTER TABLE [Sales].[DocumentExpenseLine]
    ADD [TaxeAmount] FLOAT (53) NULL;
