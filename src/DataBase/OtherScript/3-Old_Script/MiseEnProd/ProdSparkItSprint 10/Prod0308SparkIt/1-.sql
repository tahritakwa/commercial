---- Nihel: Set IdTiers to accept null value in Document table
---- + add requirement column in DocumentLine table
GO
PRINT N'Dropping [Sales].[FK_Document_Tiers]...';


GO
ALTER TABLE [Sales].[Document] DROP CONSTRAINT [FK_Document_Tiers];


GO
PRINT N'Altering [Sales].[Document]...';


GO
ALTER TABLE [Sales].[Document] ALTER COLUMN [IdTiers] INT NULL;


GO
PRINT N'Altering [Sales].[DocumentLine]...';


GO
ALTER TABLE [Sales].[DocumentLine]
    ADD [Requirement] NVARCHAR (255) NULL;


GO
PRINT N'Creating [Sales].[FK_Document_Tiers]...';


GO
ALTER TABLE [Sales].[Document] WITH NOCHECK
    ADD CONSTRAINT [FK_Document_Tiers] FOREIGN KEY ([IdTiers]) REFERENCES [Sales].[Tiers] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
ALTER TABLE [Sales].[Document] WITH CHECK CHECK CONSTRAINT [FK_Document_Tiers];


GO
PRINT N'Update complete.';


GO
---- Nihel add userManager in table user
GO
PRINT N'Altering [ERPSettings].[User]...';


GO
ALTER TABLE [ERPSettings].[User]
    ADD [IdUserParent] INT NULL;


GO
PRINT N'Creating [ERPSettings].[FK_User_User]...';


GO
ALTER TABLE [ERPSettings].[User] WITH NOCHECK
    ADD CONSTRAINT [FK_User_User] FOREIGN KEY ([IdUserParent]) REFERENCES [ERPSettings].[User] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
ALTER TABLE [ERPSettings].[User] WITH CHECK CHECK CONSTRAINT [FK_User_User];


GO
PRINT N'Update complete.';


GO

--AC GLOBALIZATION DROPDOWNLIST & COMBOBOX

PRINT N'Altering [ERPSettings].[ComboBoxComponent]...';


GO
ALTER TABLE [ERPSettings].[ComboBoxComponent]
    ADD [globalization] BIT CONSTRAINT [DF_ComboBoxComponent_globalization] DEFAULT ((0)) NULL;


GO
PRINT N'Altering [ERPSettings].[DropDownListComponent]...';


GO
ALTER TABLE [ERPSettings].[DropDownListComponent]
    ADD [globalization] BIT CONSTRAINT [DF_DropDownListComponent_globalization] DEFAULT ((0)) NULL;


GO
PRINT N'Altering [Payment].[PaymentMethod]...';


GO
ALTER TABLE [Payment].[PaymentMethod]
    ADD [Fr] NVARCHAR (255) NULL,
        [En] NVARCHAR (255) NULL;


GO
PRINT N'Update complete.';


GO
--Template--
GO
/*
Table [ERPSettings].[Menu] is being dropped.  Deployment will halt if the table contains data.
*/

--IF EXISTS (select top 1 1 from [ERPSettings].[Menu])
--    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Dropping [ERPSettings].[Menu].[IdMenu].[MS_Description]...';


GO
EXECUTE sp_dropextendedproperty @name = N'MS_Description', @level0type = N'SCHEMA', @level0name = N'ERPSettings', @level1type = N'TABLE', @level1name = N'Menu', @level2type = N'COLUMN', @level2name = N'IdMenu';


GO
PRINT N'Dropping [ERPSettings].[Menu].[Picture].[MS_Description]...';


GO
EXECUTE sp_dropextendedproperty @name = N'MS_Description', @level0type = N'SCHEMA', @level0name = N'ERPSettings', @level1type = N'TABLE', @level1name = N'Menu', @level2type = N'COLUMN', @level2name = N'Picture';


GO
PRINT N'Dropping [ERPSettings].[Menu].[Rank].[MS_Description]...';


GO
EXECUTE sp_dropextendedproperty @name = N'MS_Description', @level0type = N'SCHEMA', @level0name = N'ERPSettings', @level1type = N'TABLE', @level1name = N'Menu', @level2type = N'COLUMN', @level2name = N'Rank';


GO
PRINT N'Dropping [ERPSettings].[Menu].[FR].[MS_Description]...';


GO
EXECUTE sp_dropextendedproperty @name = N'MS_Description', @level0type = N'SCHEMA', @level0name = N'ERPSettings', @level1type = N'TABLE', @level1name = N'Menu', @level2type = N'COLUMN', @level2name = N'FR';


GO
PRINT N'Dropping [ERPSettings].[Menu].[EN].[MS_Description]...';


GO
EXECUTE sp_dropextendedproperty @name = N'MS_Description', @level0type = N'SCHEMA', @level0name = N'ERPSettings', @level1type = N'TABLE', @level1name = N'Menu', @level2type = N'COLUMN', @level2name = N'EN';


GO
PRINT N'Dropping [ERPSettings].[Menu].[AR].[MS_Description]...';


GO
EXECUTE sp_dropextendedproperty @name = N'MS_Description', @level0type = N'SCHEMA', @level0name = N'ERPSettings', @level1type = N'TABLE', @level1name = N'Menu', @level2type = N'COLUMN', @level2name = N'AR';


GO
PRINT N'Dropping [ERPSettings].[Menu].[DE].[MS_Description]...';


GO
EXECUTE sp_dropextendedproperty @name = N'MS_Description', @level0type = N'SCHEMA', @level0name = N'ERPSettings', @level1type = N'TABLE', @level1name = N'Menu', @level2type = N'COLUMN', @level2name = N'DE';


GO
PRINT N'Dropping [ERPSettings].[Menu].[CH].[MS_Description]...';


GO
EXECUTE sp_dropextendedproperty @name = N'MS_Description', @level0type = N'SCHEMA', @level0name = N'ERPSettings', @level1type = N'TABLE', @level1name = N'Menu', @level2type = N'COLUMN', @level2name = N'CH';


GO
PRINT N'Dropping [ERPSettings].[Menu].[ES].[MS_Description]...';


GO
EXECUTE sp_dropextendedproperty @name = N'MS_Description', @level0type = N'SCHEMA', @level0name = N'ERPSettings', @level1type = N'TABLE', @level1name = N'Menu', @level2type = N'COLUMN', @level2name = N'ES';


GO
PRINT N'Dropping [ERPSettings].[PK_Right].[MS_Description]...';


GO
EXECUTE sp_dropextendedproperty @name = N'MS_Description', @level0type = N'SCHEMA', @level0name = N'ERPSettings', @level1type = N'TABLE', @level1name = N'Menu', @level2type = N'CONSTRAINT', @level2name = N'PK_Right';


GO
PRINT N'Dropping [ERPSettings].[DF_Menu_IdMenu]...';


GO
ALTER TABLE [ERPSettings].[Menu] DROP CONSTRAINT [DF_Menu_IdMenu];


GO
PRINT N'Dropping [ERPSettings].[FK_Menu_Functionality]...';


GO
ALTER TABLE [ERPSettings].[Menu] DROP CONSTRAINT [FK_Menu_Functionality];


GO
PRINT N'Dropping [ERPSettings].[Menu]...';


GO
DROP TABLE [ERPSettings].[Menu];


GO
PRINT N'Altering [ERPSettings].[Functionality]...';


GO
ALTER TABLE [ERPSettings].[Functionality]
    ADD [DefaultRoute]   NVARCHAR (255) NULL,
        [isDefaultRoute] BIT            NULL;


GO
PRINT N'Update complete.';


GO


---- Updates of sprint 10

---- Document
GO
ALTER TABLE sales.document
ALTER COLUMN DocumentMonthDate int;
GO

ALTER TABLE Sales.Document ALTER COLUMN DocumentDate date not null


----- Delete ROLES
DELETE FROM [ERPSettings].[ModuleByRole]
GO

DELETE FROM [ERPSettings].[FunctionalityByRole]
GO

DELETE FROM [ERPSettings].[ComponentByRole]   

DELETE FROM [ERPSettings].[ComponentByUser]     
GO
