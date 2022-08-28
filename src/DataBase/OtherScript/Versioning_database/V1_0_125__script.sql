--13/10/2020  Ahmed : add settelement column in tiers table 
Alter Table [Sales].[Tiers] 
	ADD [IdSettlementMode] INT NULL;
--Ahmed 13/10/2020 : Add fucntionaliy 
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100015, N'D84DD72D-7B49-42A8-8C05-F7AC1B89E292', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ( [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100015, N'C0916B52-E9A6-40A6-A00A-02C8AA4522C8', 1)

--Ahmed 14/10/2020 
--Purchase responsible
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(104130,N'PurchaseResponsable_Config',N'Responsable achat',0,null, 77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c5550', N'Purchase Responsible', 4, N'Responsable achat', N'Purchase Responsible', NULL, NULL, NULL, NULL, N'/Company', 0, N'Purchase-Responsible')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 104130, N'fd101f2f-5b91-4de3-9a07-337b4a3c5550', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227555D',N'Purchase-Resoubsible',NULL, 12,N'Responsable achat',N'Purchase responsible',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227555D', 104130, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7555', N'fd101f2f-5b91-4de3-9a07-337b4a3c5550', N'51BF3865-133E-4E97-9F99-10562227555D')

--Tresaury Settings 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(104131,N'treasury_settings',N'Paramétrage trésorerie',0,null, 77777)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c5560', N'treasury settings', 4, N'paramétrage trésorerie', N'treasury settings', NULL, NULL, NULL, NULL, N'/treasury', 0, N'Treasury-settings')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 104131, N'fd101f2f-5b91-4de3-9a07-337b4a3c5560', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227556D',N'Treasury-settings',NULL, 12,N'Treasury-settings',N'Treasury-settings',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227556D', 104131, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7556', N'fd101f2f-5b91-4de3-9a07-337b4a3c5560', N'51BF3865-133E-4E97-9F99-10562227556D')


--Ahmed 15/10/2020
--Employee read
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c7110', N'Employe-read', 4, N'Employe read', N'employée sans modif', NULL, NULL, NULL, NULL, N'/Emplyee', 0, N'Employe-read')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101014, N'fd101f2f-5b91-4de3-9a07-337b4a3c7110', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227711D',N'Employe-read',NULL, 12,N'Employe-read',N'Employe-read',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227711D', 101014, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7711', N'fd101f2f-5b91-4de3-9a07-337b4a3c7110', N'51BF3865-133E-4E97-9F99-10562227711D')

--Emplyee read write
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c7120', N'Employe-read-write', 4, N'Employe read write', N'employée avec modif', NULL, NULL, NULL, NULL, N'/Emplyee', 0, N'Employe-read-write')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101015, N'fd101f2f-5b91-4de3-9a07-337b4a3c7120', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227712D',N'Employe-read-write',NULL, 12,N'Employe-read-write',N'Employe-read-write',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227712D', 101015, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7712', N'fd101f2f-5b91-4de3-9a07-337b4a3c7120', N'51BF3865-133E-4E97-9F99-10562227712D')

--Order transfert 
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c7130', N'Order-Transfer', 4, N'Ordre-Virement', N'Order-Transfer', NULL, NULL, NULL, NULL, N'/Order_Transfer', 0, N'Order-Transfer')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101012, N'fd101f2f-5b91-4de3-9a07-337b4a3c7130', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227713D',N'Order-Transfer',NULL, 12,N'Order-Transfer',N'Ordre-Virement',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227713D', 101012, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7713', N'fd101f2f-5b91-4de3-9a07-337b4a3c7130', N'51BF3865-133E-4E97-9F99-10562227713D')
--Payroll read
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(104134,N'Payroll_read_config',N'Paie sans modification',0,null, 100300)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c5590', N'Payroll read', 4, N'Paie sans modification', N'Payroll read', NULL, NULL, NULL, NULL, N'/Payroll', 0, N'Payroll_read')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 104134, N'fd101f2f-5b91-4de3-9a07-337b4a3c5590', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227559D',N'Payroll_read',NULL, 12,N'Paie sans modification',N'Payroll read',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227559D', 104134, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7559', N'fd101f2f-5b91-4de3-9a07-337b4a3c5590', N'51BF3865-133E-4E97-9F99-10562227559D')

--Payroll read and write 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(104135,N'Payroll_read_write_config',N'Paie avec modification',0,null, 100300)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c5600', N'Payroll read write', 4, N'Paie avec modification', N'Payroll read write', NULL, NULL, NULL, NULL, N'/Payroll', 0, N'Payroll_read_write')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 104135, N'fd101f2f-5b91-4de3-9a07-337b4a3c5600', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227560D',N'Payroll_read_write',NULL, 12,N'Paie avec modification',N'Payroll read write',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227560D', 104135, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7560', N'fd101f2f-5b91-4de3-9a07-337b4a3c5600', N'51BF3865-133E-4E97-9F99-10562227560D')
-- 23/10/2020 kossi update bank and bankAccount values
DECLARE @id int;
DECLARE @id_country int;
DECLARE @id_bank int;
DECLARE @id_bank_account int;
--   Get default country
DECLARE defaul_country_cursor	CURSOR  FAST_FORWARD 
									FOR SELECT Id from [Shared].[Country] WHERE upper(NameFr) = 'TUNISIE' AND IsDeleted = 0;
		OPEN defaul_country_cursor;
		FETCH NEXT FROM defaul_country_cursor into @id_country;
			
CLOSE defaul_country_cursor;
DEALLOCATE defaul_country_cursor; 

--- Update IdCountry of Bank which IdCountry value doesn't exist
DECLARE bank_cursor CURSOR  FAST_FORWARD 
		FOR SELECT Id FROM [Shared].[Bank] 
		WHERE IsDeleted = 0 AND IdCountry IS NULL;

	OPEN bank_cursor;

	FETCH NEXT FROM bank_cursor INTO @id_bank;

	WHILE @@FETCH_STATUS = 0

	BEGIN
	 
		UPDATE [Shared].[Bank]  SET IdCountry = @id_country
		WHERE Id = @id_bank;		
		FETCH NEXT FROM bank_cursor INTO @id_bank;

	END;
	 
CLOSE bank_cursor;
DEALLOCATE bank_cursor;

--- Update IdCountry of BankAccount which IdCountry value doesn't exist
DECLARE bank_account_cursor CURSOR  FAST_FORWARD 
		FOR SELECT Id, IdBank FROM [Shared].[BankAccount] 
		WHERE IsDeleted = 0 AND IdCountry IS NULL;

	OPEN bank_account_cursor;

	FETCH NEXT FROM bank_account_cursor INTO @id_bank_account, @id_bank;

	WHILE @@FETCH_STATUS = 0

	BEGIN
		--   Get Bank of the BankAccount
		DECLARE bank_cursor	CURSOR  FAST_FORWARD 
				FOR SELECT IdCountry from [Shared].[Bank] WHERE Id = @id_bank AND IsDeleted = 0;
		OPEN bank_cursor;
		FETCH NEXT FROM bank_cursor into @id_country;
		CLOSE bank_cursor;
		DEALLOCATE bank_cursor;

		--- Update the bankAccount
		UPDATE [Shared].[BankAccount]  SET IdCountry = @id_country, IdCity = NULL
		WHERE Id = @id_bank_account;		

		FETCH NEXT FROM bank_account_cursor INTO @id_bank_account, @id_bank;

	END;
	 
CLOSE bank_account_cursor;
DEALLOCATE bank_account_cursor;


-- kossi alter table Bank  14/10/2020


ALTER TABLE [Shared].[Bank] DROP CONSTRAINT [FK_Bank_Country];

ALTER TABLE [Shared].[Bank] ALTER COLUMN [IdCountry] INT NOT NULL ;

ALTER TABLE [Shared].[Bank]  
    ADD CONSTRAINT [FK_Bank_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id]); 

-- kossi alter table BankAccount 14/10/2020

--Accounting read
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(104132,N'Accounting_read_config',N'Comptabilité sans modification',0,null, 100008)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c5570', N'Accounting read', 4, N'Comptabilité sans modification', N'Accounting read', NULL, NULL, NULL, NULL, N'/Accounting', 0, N'Accounting_read')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 104132, N'fd101f2f-5b91-4de3-9a07-337b4a3c5570', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227557D',N'Accounting_read',NULL, 12,N'Comptabilité sans modification',N'Accounting read',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227557D', 104132, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7557', N'fd101f2f-5b91-4de3-9a07-337b4a3c5570', N'51BF3865-133E-4E97-9F99-10562227557D')

--Accounting read and write 
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
insert into ERPSettings.RoleConfig ([Id],[Code],[RoleName],[IsDeleted],[Deleted_Token],[IdRoleConfigCategory]) values 
(104133,N'Accounting_read_write_config',N'Comptabilité avec modification',0,null, 100008)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'fd101f2f-5b91-4de3-9a07-337b4a3c5580', N'Accounting read write', 4, N'Comptabilité avec modification', N'Accounting read write', NULL, NULL, NULL, NULL, N'/Accounting', 0, N'Accounting_read_write')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 104133, N'fd101f2f-5b91-4de3-9a07-337b4a3c5580', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'51BF3865-133E-4E97-9F99-10562227558D',N'Accounting_read_write',NULL, 12,N'Comptabilité avec modification',N'Accounting read write',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'51BF3865-133E-4E97-9F99-10562227558D', 104133, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'fd671f2f-5b91-4de3-9a07-810b4a3c7558', N'fd101f2f-5b91-4de3-9a07-337b4a3c5580', N'51BF3865-133E-4E97-9F99-10562227558D')

--- 13/10/2020 : Amine ==> Add status column defaut value in SalaryStructureValidityPeriod
ALTER TABLE [Payroll].[SalaryStructureValidityPeriod]
ADD [State] int DEFAULT 1
--- 13/10/2020 : Amine ==> Add status column defaut value in SalaryRuleValidityPeriod
ALTER TABLE [Payroll].[SalaryRuleValidityPeriod]
ADD [State] int DEFAULT 1
--- 13/10/2020 : Amine ==> Add status column defaut value in VariableValidityPeriod
ALTER TABLE [Payroll].[VariableValidityPeriod]
ADD [State] int DEFAULT 1
-- Narcisse 14/10/2020: Add IsCheckedP property and [IdTimeSheet], [IdProject] not null

ALTER TABLE [Sales].[BillingEmployee] ADD  [IsChecked] BIT CONSTRAINT [DF_BillingEmployee_Checked] DEFAULT ((0)) NOT NULL

ALTER TABLE [Sales].[BillingEmployee] ALTER COLUMN [IdTimeSheet] INT NOT NULL

ALTER TABLE [Sales].[BillingEmployee] ALTER COLUMN [IdProject] INT NOT NULL


-- kossi alter table Bank  14/10/2020

ALTER TABLE [Shared].[Bank] DROP CONSTRAINT [FK_Bank_Country];
 
ALTER TABLE [Shared].[Bank] ALTER COLUMN [IdCountry] INT NOT NULL;

ALTER TABLE [Shared].[Bank]  
    ADD CONSTRAINT [FK_Bank_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id]); 

-- kossi alter table BankAccount 14/10/2020

ALTER TABLE [Shared].[BankAccount] DROP CONSTRAINT [FK_BankAccount_Country];

ALTER TABLE [Shared].[BankAccount] ALTER COLUMN [IdCountry] INT NOT NULL;

ALTER TABLE [Shared].[BankAccount]  
    ADD CONSTRAINT [FK_BankAccount_Country] FOREIGN KEY ([IdCountry]) REFERENCES [Shared].[Country] ([Id]);


-- Narcisse: Last connection informations

ALTER TABLE [ERPSettings].[User] ADD LastConnection DATETIME NULL, LastConnectedIpAdress nvarchar(100) NULL



---- Amine 21/10/2020
---OrderTransfer Settings
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'9b51499b-aecd-4e93-b0d4-ce0388b1dddd', N'TransferOrder', 4, N'TransferOrder', N'TransferOrder', NULL, NULL, NULL, NULL, N'payroll/transferorder', 0, N'TransferOrder')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101012, N'9b51499b-aecd-4e93-b0d4-ce0388b1dddd', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'6c19c4e4-1496-4e32-b407-fdad008a1fa3',N'TransferOrder',NULL, 12,N'TransferOrder',N'TransferOrder',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'6c19c4e4-1496-4e32-b407-fdad008a1fa3', 101012, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'9a3383c2-557d-4018-9c03-fcb278403197', N'9b51499b-aecd-4e93-b0d4-ce0388b1dddd', N'6c19c4e4-1496-4e32-b407-fdad008a1fa3')
 UPDATE [ERPSettings].[RoleConfig] SET Code = 'Declaration_Employee' where Id = 101019
  -----Employe Read Write Role
  INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'4019d096-18c5-415c-9f99-ef02f871cab0', N'EmployeReadWrite', 4, N'EmployeReadWrite', N'EmployeReadWrite', NULL, NULL, NULL, NULL, N'payroll/employee', 0, N'EmployeReadWrite')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101014, N'4019d096-18c5-415c-9f99-ef02f871cab0', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'2690a5e0-3d35-4884-9d75-5fcf150fe6d1',N'EmployeReadWrite',NULL, 12,N'EmployeReadWrite',N'EmployeReadWrite',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'2690a5e0-3d35-4884-9d75-5fcf150fe6d1', 101014, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'f1f7fa1b-e37d-4537-ad78-12c58e5f53e3', N'4019d096-18c5-415c-9f99-ef02f871cab0', N'2690a5e0-3d35-4884-9d75-5fcf150fe6d1')
-------EmployeRead Role
 INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'1e8dd250-cd34-4795-9bbb-3c85562dbe90', N'EmployeRead', 4, N'EmployeRead', N'EmployeRead', NULL, NULL, NULL, NULL, N'payroll/employee', 0, N'EmployeRead')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 101015, N'1e8dd250-cd34-4795-9bbb-3c85562dbe90', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'12961e9b-ef24-4a7d-bd42-64b927affcd5',N'EmployeRead',NULL, 12,N'EmployeRead',N'EmployeRead',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'12961e9b-ef24-4a7d-bd42-64b927affcd5', 101015, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'79422ed7-a1e7-4a19-993e-8e0ecd618ee1', N'1e8dd250-cd34-4795-9bbb-3c85562dbe90', N'12961e9b-ef24-4a7d-bd42-64b927affcd5')
UPDATE [ERPSettings].[RoleConfig] SET Code = 'Declaration_Employee' where Id = 101019
UPDATE [ERPSettings].[RoleConfig] SET Code = 'Employe_Write_Read' where Id = 101014
----Setting Paie Read Role
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103133, N'Settings_Paie_RO', N'Pramètrage paie sans modification', 0, NULL, 100300)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'b0b7dfc2-cc59-4065-a359-63036eae1592', N'SettingsPaieRO', 4, N'SettingsPaieRO', N'SettingsPaieRO', NULL, NULL, NULL, NULL, N'payroll/paie', 0, N'SettingsPaieRO')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103133, N'b0b7dfc2-cc59-4065-a359-63036eae1592', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'cdcd7b53-3463-4b94-bbd5-36f206c0fbc4',N'SettingsPaieRO',NULL, 12,N'SettingsPaieRO',N'SettingsPaieRO',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'cdcd7b53-3463-4b94-bbd5-36f206c0fbc4', 103133, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'011e0ade-ecaa-4394-9024-b237ead3b505', N'b0b7dfc2-cc59-4065-a359-63036eae1592', N'cdcd7b53-3463-4b94-bbd5-36f206c0fbc4')
----Setting Paie Read Write  Role
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103134, N'Settings_Paie_RW', N'Pramètrage paie avec modification', 0, NULL, 100300)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'f56d098c-2c39-41b5-9c75-efd827702417', N'SettingsPaieRW', 4, N'SettingsPaieRW', N'SettingsPaieRW', NULL, NULL, NULL, NULL, N'payroll/paie', 0, N'SettingsPaieRW')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103134, N'f56d098c-2c39-41b5-9c75-efd827702417', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'7c84b895-4383-46df-aaa5-1e6ba1a016d4',N'SettingsPaieRW',NULL, 12,N'SettingsPaieRW',N'SettingsPaieRW',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'7c84b895-4383-46df-aaa5-1e6ba1a016d4', 103134, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'e84f75d7-d168-4ac4-a962-fe58b441363f', N'f56d098c-2c39-41b5-9c75-efd827702417', N'7c84b895-4383-46df-aaa5-1e6ba1a016d4')
-- Imen chaaben
ALTER TABLE [Payment].[WithholdingTax] ALTER COLUMN [Designation] nvarchar(255);  
ALTER TABLE [Shared].[BankAccount] ALTER COLUMN [Entitled] nvarchar(255);
ALTER TABLE [Shared].[BankAccount] ALTER COLUMN [Email] nvarchar(255);


-- Narcisse 23/10/2020 : Update base rule validity startDate to min value 
UPDATE [Payroll].[SalaryRuleValidityPeriod] SET [StartDate]='19700101' WHERE [Id]=1158
UPDATE [Payroll].[SalaryRuleValidityPeriod] SET [StartDate]='19700101' WHERE [Id]=1159
UPDATE [Payroll].[SalaryRuleValidityPeriod] SET [StartDate]='19700101' WHERE [Id]=1160
UPDATE [Payroll].[SalaryRuleValidityPeriod] SET [StartDate]='19700101' WHERE [Id]=1161
--Amine 26/10/2020 add Role G adminstrative(Leave, timeSheet, documentRequest) + role read only
SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] ON
  INSERT INTO [ERPSettings].[RoleConfigCategory]
           ([Id]
		   ,[Code]
           ,[Label]
           ,[TranslationCode]
           ,[IsDeleted]
           ,[TransactionUserId]
           ,[Deleted_Token])
     VALUES
           (100303
           ,'G.administratives'
           ,'G.administratives'
           ,'G.administratives'
           ,0
           ,NULL
		   ,NULL)
SET IDENTITY_INSERT [ERPSettings].[RoleConfigCategory] OFF
--CRA role
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103135, N'Cra', N'CRA', 0, NULL, 100303)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'6547c48d-5565-4232-82c9-b4c7eb716669', N'Cra', 4, N'Cra', N'Cra', NULL, NULL, NULL, NULL, N'payroll/Cra', 0, N'Cra')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103135, N'6547c48d-5565-4232-82c9-b4c7eb716669', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'65c7e9fe-6edb-43c6-a70a-ff6ae1d4bf9c',N'Cra',NULL, 12,N'Cra',N'Cra',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'65c7e9fe-6edb-43c6-a70a-ff6ae1d4bf9c', 103135, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'02708673-47c3-408a-9c0b-d41d2ad52cc0', N'6547c48d-5565-4232-82c9-b4c7eb716669', N'65c7e9fe-6edb-43c6-a70a-ff6ae1d4bf9c')
--Congé role
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103136, N'Leave_config', N'Congé', 0, NULL, 100303)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'be09fcaa-a418-4ba8-ae48-ac9ef834043c', N'Leave', 4, N'Leave', N'Leave', NULL, NULL, NULL, NULL, N'payroll/Leave', 0, N'Leave')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103136, N'be09fcaa-a418-4ba8-ae48-ac9ef834043c', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'bc328e7d-069a-4cb5-a9ff-2bb4596e9124',N'Leave',NULL, 12,N'Leave',N'Leave',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'bc328e7d-069a-4cb5-a9ff-2bb4596e9124', 103136, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'5e373a7e-20bd-4ff2-a89a-944f174d8be3', N'be09fcaa-a418-4ba8-ae48-ac9ef834043c', N'bc328e7d-069a-4cb5-a9ff-2bb4596e9124')
--Note de frait
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103137, N'Expense_Report', N'Notes de frais', 0, NULL, 100303)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'add5ccad-4f55-400c-831c-50f67d259078', N'ExpenseReport', 4, N'ExpenseReport', N'ExpenseReport', NULL, NULL, NULL, NULL, N'payroll/ExpenseReport', 0, N'ExpenseReport')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103137, N'add5ccad-4f55-400c-831c-50f67d259078', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'63ab2fae-37dd-4928-bdba-8d089f1a7735',N'ExpenseReport',NULL, 12,N'ExpenseReport',N'ExpenseReport',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'63ab2fae-37dd-4928-bdba-8d089f1a7735', 103137, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'bd1d675f-cb98-4310-9b42-e54f45b511c1', N'add5ccad-4f55-400c-831c-50f67d259078', N'63ab2fae-37dd-4928-bdba-8d089f1a7735')
--Document role
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103138, N'Document', N'Documents', 0, NULL, 100303)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'd758117a-3db4-47a8-80dd-c48043105124', N'Documents', 4, N'Documents', N'Documents', NULL, NULL, NULL, NULL, N'payroll/document', 0, N'Documents')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103138, N'd758117a-3db4-47a8-80dd-c48043105124', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'0d9d9ac1-a2b6-4264-8172-ad65b5a103bc',N'Documents',NULL, 12,N'Documents',N'Documents',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'0d9d9ac1-a2b6-4264-8172-ad65b5a103bc', 103138, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'85b2314b-11ab-4af2-98b2-14fd60e5eab9', N'd758117a-3db4-47a8-80dd-c48043105124', N'0d9d9ac1-a2b6-4264-8172-ad65b5a103bc')
--sharedDocument role
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103139, N'shared_Document', N'Documents partagés', 0, NULL, 100303)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'6973c6f3-6c60-4eb8-a667-c05e3384d994', N'sharedDocuments', 4, N'sharedDocuments', N'sharedDocuments', NULL, NULL, NULL, NULL, N'payroll/sharedDocuments', 0, N'sharedDocuments')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103139, N'6973c6f3-6c60-4eb8-a667-c05e3384d994', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'ac498e11-e88a-48fd-bc12-1971b8346505',N'sharedDocuments',NULL, 12,N'sharedDocuments',N'sharedDocuments',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'ac498e11-e88a-48fd-bc12-1971b8346505', 103139, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'0f32a406-c2f2-4fa6-80af-d21b93cb824d', N'6973c6f3-6c60-4eb8-a667-c05e3384d994', N'ac498e11-e88a-48fd-bc12-1971b8346505')
--Read Only administrative role
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103140, N'administrative_RO', N'G.administrative sans modification', 0, NULL, 100303)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'3aeec57d-0471-49ab-b148-7fcc90a5cbf1', N'administrativeRO', 4, N'administrativeRO', N'administrativeRO', NULL, NULL, NULL, NULL, N'payroll/administrativeRO', 0, N'administrativeRO')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103140, N'3aeec57d-0471-49ab-b148-7fcc90a5cbf1', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'cd8f85cf-467f-4bc5-b2e8-187e5a1062ed',N'administrativeRO',NULL, 12,N'administrativeRO',N'administrativeRO',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'cd8f85cf-467f-4bc5-b2e8-187e5a1062ed', 103140, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'474c8158-9680-4da2-984d-bee79b7cd0f5', N'3aeec57d-0471-49ab-b148-7fcc90a5cbf1', N'cd8f85cf-467f-4bc5-b2e8-187e5a1062ed')
---Read and Write administrative role
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103141, N'administrative_RW', N'G.administrative avec modification', 0, NULL, 100303)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'2e92c4e6-4ddd-4cc9-8478-29c1b802804d', N'administrativeRW', 4, N'administrativeRW', N'administrativeRW', NULL, NULL, NULL, NULL, N'payroll/administrativeRW', 0, N'administrativeRW')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103141, N'2e92c4e6-4ddd-4cc9-8478-29c1b802804d', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'14ef9dec-0d1d-48c5-8738-70a0a775ad79',N'administrativeRW',NULL, 12,N'administrativeRW',N'administrativeRW',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'14ef9dec-0d1d-48c5-8738-70a0a775ad79', 103141, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'7287f762-a335-47f9-a652-7036b4cac55d', N'2e92c4e6-4ddd-4cc9-8478-29c1b802804d', N'14ef9dec-0d1d-48c5-8738-70a0a775ad79')
UPDATE [ERPSettings].[RoleConfig] SET Code = 'G_administrative_RW' where Id = 103141
UPDATE [ERPSettings].[RoleConfig] SET Code = 'G_administrative_RO' where Id = 103140

--- Donia add Worked column to leavetype and timesheetline 26/10/2020
ALTER TABLE [Payroll].[LeaveType] ADD [Worked] BIT NOT NULL DEFAULT ((0));
ALTER TABLE [RH].[TimeSheetLine] ADD [Worked] BIT NULL;

---28/10/2020 Amine update data notification add user and validate exit-employee 
UPDATE [ERPSettings].[Information] SET [URL] = '/payroll/exit-employee/edit' WHERE [IdInfo] = '1000501226';
UPDATE [ERPSettings].[Information] SET [FR]= '{CREATOR} a ajouté  une demande de sortie employé {DOC_CODE} {PROFIL}' WHERE [IdInfo] = '1000501226';
UPDATE [ERPSettings].[Information] SET [EN]='{CREATOR} added a new exit employee request {DOC_CODE} {PROFIL}' WHERE [IdInfo] = '1000501226';
UPDATE [ERPSettings].[Information] SET [URL] = '/administration/user/Edit' WHERE [IdInfo] = '1000501194';
---Training role
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103142, N'Formations_config', N'Formations', 0, NULL, 100403)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'67c2a2dc-ebaa-4a08-b33e-a2f0f1c66b44', N'Formations', 4, N'Formations', N'Formations', NULL, NULL, NULL, NULL, N'payroll/Formations', 0, N'Formations')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103142, N'67c2a2dc-ebaa-4a08-b33e-a2f0f1c66b44', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'8b172577-59e4-4d4e-8731-4917694c7ede',N'Formations',NULL, 12,N'Formations',N'Formations',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'8b172577-59e4-4d4e-8731-4917694c7ede', 103142, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'02bd2907-f241-41dd-b006-f2882164a198', N'67c2a2dc-ebaa-4a08-b33e-a2f0f1c66b44', N'8b172577-59e4-4d4e-8731-4917694c7ede')
--ANNUAL_INTERVIEWS  role
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103143, N'Annual_Interviews', N'Entretiens annuels', 0, NULL, 100403)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'df5e3c53-88b9-4fd0-a140-23e9d3f6d111', N'AnnualInterviews', 4, N'AnnualInterviews', N'AnnualInterviews', NULL, NULL, NULL, NULL, N'rh/review', 0, N'AnnualInterviews')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103143, N'df5e3c53-88b9-4fd0-a140-23e9d3f6d111', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'0803065b-eaa7-4b8e-9c9b-3ad217912084',N'AnnualInterviews',NULL, 12,N'AnnualInterviews',N'AnnualInterviews',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'0803065b-eaa7-4b8e-9c9b-3ad217912084', 103143, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'867d3b6c-d54e-4ba4-9b51-1a4e22d84da2', N'df5e3c53-88b9-4fd0-a140-23e9d3f6d111', N'0803065b-eaa7-4b8e-9c9b-3ad217912084')
---Add read only role career Management
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103144, N'Career_Management_RO', N'Gestion de carrières sans modification', 0, NULL, 100403)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'cfc38bf7-5812-4a8a-b2b5-5f46afd94cfa', N'CareerManagementRO', 4, N'CareerManagementRO', N'CareerManagementRO', NULL, NULL, NULL, NULL, N'rh/CareerManagementRO', 0, N'CareerManagementRO')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103144, N'cfc38bf7-5812-4a8a-b2b5-5f46afd94cfa', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'1965e537-845b-4f3c-9abe-c17373058d8c',N'CareerManagementRO',NULL, 12,N'CareerManagementRO',N'CareerManagementRO',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'1965e537-845b-4f3c-9abe-c17373058d8c', 103144, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'1473cc41-f44f-43af-a89a-3f888a749e8b', N'cfc38bf7-5812-4a8a-b2b5-5f46afd94cfa', N'1965e537-845b-4f3c-9abe-c17373058d8c')
---Add read write role career Management
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] ON
INSERT INTO [ERPSettings].[RoleConfig] ([Id], [Code], [RoleName], [IsDeleted], [Deleted_Token], [IdRoleConfigCategory]) VALUES (103145, N'Career_Management_RW', N'Gestion de carrières avec modification', 0, NULL, 100403)
SET IDENTITY_INSERT [ERPSettings].[RoleConfig] OFF
INSERT INTO [ERPSettings].[Functionality] ([IdFunctionality], [FunctionalityName], [IdRequestType], [FR], [EN], [AR], [DE], [CH], [ES], [DefaultRoute], [isDefaultRoute], [ApiRole]) VALUES 
(N'f98575ba-890d-47c1-a3e8-4c28c9cdb804', N'CareerManagementRW', 4, N'CareerManagementRW', N'CareerManagementRW', NULL, NULL, NULL, NULL, N'rh/CareerManagementRW', 0, N'CareerManagementRW')
INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdRoleConfig], [IdFunctionality], [IsActive]) VALUES 
( 103145, N'f98575ba-890d-47c1-a3e8-4c28c9cdb804', 1)
INSERT INTO [ERPSettings].[Module]([IdModule],[ModuleName],[IdModuleParent],[Rank],[FR],[EN],[AR],[DE],[CH],[ES],[class],[InMenuList]) VALUES
(N'1a71f793-9019-4651-af0a-ac691faf57bc',N'CareerManagementRW',NULL, 12,N'CareerManagementRW',N'CareerManagementRW',NULL,NULL,NULL,NULL,NULL,1)
INSERT INTO [ERPSettings].[ModuleConfig] ( [IdModule], [IdRoleConfig], [IsActive]) VALUES 
( N'1a71f793-9019-4651-af0a-ac691faf57bc', 103145, 1)
INSERT INTO [ERPSettings].[FunctionnalityModule] ([IdFunctionnalityModule], [IdFunctionnality], [IdModule]) VALUES 
(N'20b1954b-7565-421d-ae3e-eaae19752b9c', N'f98575ba-890d-47c1-a3e8-4c28c9cdb804', N'1a71f793-9019-4651-af0a-ac691faf57bc')
---Delete salary settings role
DELETE FROM [ERPSettings].[FunctionalityConfig] where [IdRoleConfig] =70013
DELETE FROM [ERPSettings].[ModuleConfig] where [IdRoleConfig] =70013
DELETE FROM [ERPSettings].[RoleConfigByRole] where [IdRoleConfig] =70013
DELETE FROM [ERPSettings].[RoleConfig] where Id =70013

--- Donia Update timesheet notifications urls in Information 03/11/2020
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
UPDATE [ERPSettings].[Information] SET [URL]=N'/rh/timesheet' WHERE [IdInfo]=1000501102
UPDATE [ERPSettings].[Information] SET [URL]=N'/rh/timesheet' WHERE [IdInfo]=1000501103
UPDATE [ERPSettings].[Information] SET [URL]=N'/rh/timesheet/add' WHERE [IdInfo]=1000501104
UPDATE [ERPSettings].[Information] SET [URL]=N'/rh/timesheet/add' WHERE [IdInfo]=1000501105
UPDATE [ERPSettings].[Information] SET [URL]=N'/rh/timesheet/add' WHERE [IdInfo]=1000501233
UPDATE [ERPSettings].[Information] SET [URL]=N'/rh/timesheet/add' WHERE [IdInfo]=1000501234
UPDATE [ERPSettings].[Information] SET [URL]=N'/rh/timesheet/add' WHERE [IdInfo]=1000501235
UPDATE [ERPSettings].[Information] SET [URL]=N'/rh/timesheet/add' WHERE [IdInfo]=1000501238
UPDATE [ERPSettings].[Information] SET [URL]=N'/rh/timesheet/add' WHERE [IdInfo]=1000501239
UPDATE [ERPSettings].[Information] SET [URL]=N'/rh/timesheet/add' WHERE [IdInfo]=1000501240
UPDATE [ERPSettings].[Information] SET [URL]=N'/rh/timesheet/add' WHERE [IdInfo]=1000501241
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
COMMIT TRANSACTION

-- chedi DERBALI: add shelf and storage tables 27/10/2020 


GO
ALTER TABLE [Inventory].[ItemWarehouse]
    ADD [IdShelf]   INT NULL,
        [IdStorage] INT NULL;



GO
CREATE TABLE [Inventory].[Shelf] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Label]             NVARCHAR (250) NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NOT NULL,
    [IdWharehouse]      INT            NULL,
    [IsDefault]         BIT            NULL,
    CONSTRAINT [PK_Shelf] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE TABLE [Inventory].[Storage] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Label]             NVARCHAR (250) NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NOT NULL,
    [IdShelf]           INT            NULL,
    [IsDefault]         BIT            NULL,
    CONSTRAINT [PK_Storage] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
ALTER TABLE [Inventory].[Shelf]
    ADD CONSTRAINT [DF_Shelf_TransactionUserId] DEFAULT ((0)) FOR [TransactionUserId];



GO
ALTER TABLE [Inventory].[Shelf]
    ADD CONSTRAINT [DF_Shelf_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];



GO
ALTER TABLE [Inventory].[Storage]
    ADD CONSTRAINT [DF_Storage_TransactionUserId] DEFAULT ((0)) FOR [TransactionUserId];



GO
ALTER TABLE [Inventory].[Storage]
    ADD CONSTRAINT [DF_Storage_IsDeleted] DEFAULT ((0)) FOR [IsDeleted];


GO
ALTER TABLE [Inventory].[Shelf] WITH NOCHECK
    ADD CONSTRAINT [FK_Shelf_Warehouse] FOREIGN KEY ([IdWharehouse]) REFERENCES [Inventory].[Warehouse] ([Id]);



GO
ALTER TABLE [Inventory].[Storage] WITH NOCHECK
    ADD CONSTRAINT [FK_Storage_Shelf] FOREIGN KEY ([IdShelf]) REFERENCES [Inventory].[Shelf] ([Id]);



GO
ALTER TABLE [Inventory].[ItemWarehouse] WITH NOCHECK
    ADD CONSTRAINT [FK_ItemWarehouse_Shelf] FOREIGN KEY ([IdShelf]) REFERENCES [Inventory].[Shelf] ([Id]);



GO
ALTER TABLE [Inventory].[ItemWarehouse] WITH NOCHECK
    ADD CONSTRAINT [FK_ItemWarehouse_Storage] FOREIGN KEY ([IdStorage]) REFERENCES [Inventory].[Storage] ([Id]);

-- Molka : add [Twitter,[Fax],[Facebook] and [Linkedin]  to [ERPSettings].[User] 28-10-2020

ALTER TABLE [ERPSettings].[User] ADD [Twitter] NVARCHAR (255) NULL
ALTER TABLE [ERPSettings].[User] ADD [Linkedin] NVARCHAR (255) NULL
ALTER TABLE [ERPSettings].[User] ADD [Fax] NVARCHAR (255) NULL
ALTER TABLE [ERPSettings].[User] ADD [Facebook] NVARCHAR (255) NULL


-- Mohamed BOUZIDI Office corrections

ALTER TABLE [Shared].[Office] drop CONSTRAINT [FK_Office_City] 
ALTER TABLE [Shared].[Office] drop CONSTRAINT [FK_Office_Country] 

ALTER TABLE [Shared].[Office] DROP COLUMN [IdCity]
ALTER TABLE [Shared].[Office] DROP COLUMN [IdCountry]


ALTER TABLE [Shared].[Address] ADD [IdOffice] INT CONSTRAINT [FK_Address_Office] FOREIGN KEY([IdOffice]) REFERENCES [Shared].[Office] ([Id]) NULL
ALTER TABLE [Shared].[Contact] ADD [IdOffice] INT CONSTRAINT [FK_Contact_Office] FOREIGN KEY([IdOffice]) REFERENCES [Shared].[Office] ([Id]) NULL
