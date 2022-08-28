---Ghazoua add UpdatedDate to tiers table 15/09/2021
ALTER TABLE [Sales].[Tiers]
    ADD [UpdatedDate] DATETIME NULL;
--Ahmed add vehicle to document 20/09/2021
GO
ALTER TABLE [Sales].[Document] ADD [IdVehicle] INT NULL;
ALTER TABLE [Sales].[Document] WITH NOCHECK
ADD CONSTRAINT [FK_Document_Vehicle] FOREIGN KEY ([IdVehicle]) REFERENCES [Sales].[Vehicle] ([Id]);
--Ahmed add note is required to company table : 27/09/2021
ALTER TABLE [Shared].[Company]
    ADD  NoteIsRequired BIT  DEFAULT ('false') NOT NULL;
    

---Ghazoua add IsSynchronizedBToB 29/09/2021
GO
ALTER TABLE [Sales].[Tiers]
    ADD  IsSynchronizedBToB BIT            DEFAULT ('false') NOT NULL;

ALTER TABLE [Sales].[Document]
    ADD  IsSynchronizedBToB BIT            DEFAULT ('false') NOT NULL;

--- Donia delete rh document relation 05/10/2021
ALTER TABLE [Sales].[Document] DROP CONSTRAINT [FK_Document_Employee];
ALTER TABLE [Sales].[Document] DROP CONSTRAINT [FK_Document_Project];
ALTER TABLE [Sales].[Document] DROP CONSTRAINT [FK_Document_TimeSheet];
---- Ghazoua update  IsSynchronizedBToB default value 
DECLARE @Command nvarchar(max), @ConstraintName nvarchar(max), @TableName nvarchar(max), @ColumnName nvarchar(max)
SET @TableName = 'Sales.Tiers'
SET @ColumnName = 'IsSynchronizedBToB'
SELECT @ConstraintName = name
FROM sys.default_constraints
WHERE parent_object_id = object_id(@TableName)
AND parent_column_id = columnproperty(object_id(@TableName), @ColumnName, 'ColumnId')
SELECT @Command = 'ALTER TABLE ' + @TableName + ' DROP CONSTRAINT ' + @ConstraintName
EXECUTE sp_executeSQL @Command
ALTER TABLE [Sales].[Tiers]
ADD CONSTRAINT [DF_Tiers_IsSynchronizedBToB] DEFAULT ((0)) FOR IsSynchronizedBToB;

DECLARE @CommandDocument nvarchar(max), @ConstraintNameDocument nvarchar(max), @TableName1 nvarchar(max), @ColumnName1 nvarchar(max)
SET @TableName1 = 'Sales.Document'
SET @ColumnName1 = 'IsSynchronizedBToB'
SELECT @ConstraintNameDocument = name
FROM sys.default_constraints
WHERE parent_object_id = object_id(@TableName1)
AND parent_column_id = columnproperty(object_id(@TableName1), @ColumnName1, 'ColumnId')
SELECT @CommandDocument = 'ALTER TABLE ' + @TableName1 + ' DROP CONSTRAINT ' + @ConstraintNameDocument
EXECUTE sp_executeSQL @CommandDocument
ALTER TABLE [Sales].[Document]
ADD CONSTRAINT [DF_Document_IsSynchronizedBToB] DEFAULT ((0)) FOR IsSynchronizedBToB;

---- Youssef update  WasLead default value 12/10/2021
UPDATE Sales.Tiers SET WasLead=0 where WasLead is null
DECLARE @CommandTiers nvarchar(max), @ConstraintNameTiers nvarchar(max), @TableNameTiers nvarchar(max), @ColumnNameTiers nvarchar(max)
SET @TableNameTiers = 'Sales.Tiers'
SET @ColumnNameTiers = 'WasLead'
SELECT @ConstraintNameTiers = name
FROM sys.default_constraints
WHERE parent_object_id = object_id(@TableNameTiers)
AND parent_column_id = columnproperty(object_id(@TableNameTiers), @ColumnNameTiers, 'ColumnId')
SELECT @CommandTiers = 'ALTER TABLE ' + @TableNameTiers + ' DROP CONSTRAINT ' + @ConstraintNameTiers
EXECUTE sp_executeSQL @CommandTiers
ALTER TABLE [Sales].[Tiers] 
ALTER COLUMN WasLead bit NOT NULL
ALTER TABLE [Sales].[Tiers]
ADD CONSTRAINT [DF_Tiers_WasLead] DEFAULT ((0)) FOR WasLead;


UPDATE Shared.Contact SET WasLead=0 where WasLead is null
DECLARE @CommandContact nvarchar(max), @ConstraintNameContact nvarchar(max), @TableNameContact nvarchar(max), @ColumnNameContact nvarchar(max)
SET @TableNameContact = 'Shared.Contact'
SET @ColumnNameContact = 'WasLead'
SELECT @ConstraintNameContact = name
FROM sys.default_constraints
WHERE parent_object_id = object_id(@TableNameContact)
AND parent_column_id = columnproperty(object_id(@TableNameContact), @ColumnNameContact, 'ColumnId')
SELECT @CommandContact = 'ALTER TABLE ' + @TableNameContact + ' DROP CONSTRAINT ' + @ConstraintNameContact
EXECUTE sp_executeSQL @CommandContact
ALTER TABLE [Shared].[Contact]
ALTER COLUMN WasLead bit NOT NULL
ALTER TABLE [Shared].[Contact]
ADD CONSTRAINT [DF_Contact_WasLead] DEFAULT ((0)) FOR WasLead;