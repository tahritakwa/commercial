-- Narcisse: Add DependNumberDaysWorked column to bonus and benefitInKind

ALTER TABLE [Payroll].[BenefitInKind] ADD [DependNumberDaysWorked] BIT CONSTRAINT [DF_BenefitInKind_DependNumberDaysWorked] DEFAULT ((0)) NOT NULL;

ALTER TABLE [Payroll].[Bonus] ADD [DependNumberDaysWorked] BIT CONSTRAINT [DF_Bonus_DependNumberDaysWorked] DEFAULT ((0)) NOT NULL;


-- Narcisse: Add DaysNotWorked column to Company

ALTER TABLE Shared.Company ADD DaysNotWorked nvarchar(255) NULL 

ALTER TABLE Shared.Company DROP COLUMN DaysNotWorked

ALTER TABLE Shared.Company ADD DaysWorkedInTheWeek nvarchar(255) NULL

-- 03/11/2020 : Ahmed 
Alter Table [Sales].[Tiers] 
	ADD [IdDeliveryType] INT NULL;

--Amine update Skills Matrix data 
UPDATE [ERPSettings].[RoleConfig] SET Code = 'Skills_Matrix' where Id = 102104
UPDATE [ERPSettings].[RoleConfig] SET RoleName = 'Matrice de compétences' where Id = 102104


