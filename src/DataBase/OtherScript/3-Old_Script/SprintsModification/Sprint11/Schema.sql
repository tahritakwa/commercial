---- Nihel: Add unique Constraint in tables : ComponentByRole, FunctionalityByRole, ModuleByRole
---- Delete duplicate from ComponentByRole
DELETE FROM ERPSettings.ComponentByRole
WHERE ERPSettings.ComponentByRole.Id In (Select RowId from (SELECT
   MAX(Id) as RowId, IdComponent, IdRole
FROM
    ERPSettings.ComponentByRole
GROUP BY
    IdComponent, IdRole
HAVING 
    COUNT(*) > 1
) as KeepRows)

---- Delete duplicate from FunctionalityByRole
DELETE FROM ERPSettings.FunctionalityByRole
WHERE ERPSettings.FunctionalityByRole.Id In (Select RowId from (SELECT
   MAX(Id) as RowId, IdFunctionality, IdRole
FROM
    ERPSettings.FunctionalityByRole
GROUP BY
    IdFunctionality, IdRole
HAVING 
    COUNT(*) > 1
) as KeepRows)

---- Delete duplicate from ModuleByRole
DELETE FROM ERPSettings.ModuleByRole
WHERE ERPSettings.ModuleByRole.Id In (Select RowId from (SELECT
   MAX(Id) as RowId, IdModule, IdRole
FROM
    ERPSettings.ModuleByRole
GROUP BY
    IdModule, IdRole
HAVING 
    COUNT(*) > 1
) as KeepRows)



GO
PRINT N'Creating [ERPSettings].[UniqueIdxCompByRole]...';


GO
ALTER TABLE [ERPSettings].[ComponentByRole]
    ADD CONSTRAINT [UniqueIdxCompByRole] UNIQUE NONCLUSTERED ([IdComponent] ASC, [IdRole] ASC);


GO
PRINT N'Creating [ERPSettings].[UniqueIdxFunctByRole]...';


GO
ALTER TABLE [ERPSettings].[FunctionalityByRole]
    ADD CONSTRAINT [UniqueIdxFunctByRole] UNIQUE NONCLUSTERED ([IdFunctionality] ASC, [IdRole] ASC);


GO
PRINT N'Creating [ERPSettings].[UniqueIdxModuleByRole]...';


GO
ALTER TABLE [ERPSettings].[ModuleByRole]
    ADD CONSTRAINT [UniqueIdxModuleByRole] UNIQUE NONCLUSTERED ([IdModule] ASC, [IdRole] ASC);


GO
PRINT N'Update complete.';


GO

---- Houssem: Payroll
alter table Payroll.ContractType
drop column  Label
GO

alter table Payroll.ContractType
add Fr nvarchar(250) null,
 En nvarchar(250) null
 GO

---- rename constraint
EXEC sp_rename N'FK_ViewConfigurationRole_ViewConfiguration', N'FK_ComponentByRole_Component'
EXEC sp_rename N'ERPSettings.FK_ViewConfigurationRole_Role', N'FK_ComponentByRole_Role'


