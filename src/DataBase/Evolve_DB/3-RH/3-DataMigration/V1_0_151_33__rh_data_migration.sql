-- Narcisse: Update Heures supp labels 15/01/2020
BEGIN TRANSACTION
UPDATE [Payroll].[AdditionalHour] SET [Name]=N'Heures supplémentaires majorées à 100%' WHERE [Id]=14
UPDATE [Payroll].[AdditionalHour] SET [Name]=N'Heures supplémentaires majorées à 75%' WHERE [Id]=15
UPDATE [Payroll].[AdditionalHour] SET [Name]=N'Heures supplémentaires majorées à 50%' WHERE [Id]=16
UPDATE [Payroll].[AdditionalHour] SET [Name]=N'Heures supplémentaires majorées à 25%' WHERE [Id]=17
COMMIT TRANSACTION

-- Narcisse: Update Heures supp percentage value 15/01/2020
BEGIN TRANSACTION
UPDATE [Payroll].[AdditionalHour] SET [IncreasePercentage]=100 WHERE [Id]=14
UPDATE [Payroll].[AdditionalHour] SET [IncreasePercentage]=75 WHERE [Id]=15
UPDATE [Payroll].[AdditionalHour] SET [IncreasePercentage]=50 WHERE [Id]=16
UPDATE [Payroll].[AdditionalHour] SET [IncreasePercentage]=25 WHERE [Id]=17
COMMIT TRANSACTION

--- Amine delete Role only 20/01/2021
  --employee read only
  DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [IdRoleConfig] = 101015;
  DELETE FROM [ERPSettings].[ModuleConfig] WHERE [IdRoleConfig] = 101015;
  DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [IdRoleConfig] = 101015;
  DELETE FROM [ERPSettings].[RoleConfig] WHERE Id = 101015;
  --paie role read only
  DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [IdRoleConfig] = 104134;
  DELETE FROM [ERPSettings].[ModuleConfig] WHERE [IdRoleConfig] = 104134;
  DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [IdRoleConfig] = 104134;
  DELETE FROM [ERPSettings].[RoleConfig] WHERE Id = 104134;
  --paie setting read only
  DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [IdRoleConfig] = 103133;
  DELETE FROM [ERPSettings].[ModuleConfig] WHERE [IdRoleConfig] = 103133;
  DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [IdRoleConfig] = 103133;
  DELETE FROM [ERPSettings].[RoleConfig] WHERE Id = 103133;
  --G administrative read only
 DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [IdRoleConfig] = 103140;
  DELETE FROM [ERPSettings].[ModuleConfig] WHERE [IdRoleConfig] = 103140;
  DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [IdRoleConfig] = 103140;
  DELETE FROM [ERPSettings].[RoleConfig] WHERE Id = 103140;
  --G carrer read only
  DELETE FROM [ERPSettings].[RoleConfigByRole] WHERE [IdRoleConfig] = 103144;
  DELETE FROM [ERPSettings].[ModuleConfig] WHERE [IdRoleConfig] = 103144;
  DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [IdRoleConfig] = 103144;
  DELETE FROM [ERPSettings].[RoleConfig] WHERE Id = 103144;