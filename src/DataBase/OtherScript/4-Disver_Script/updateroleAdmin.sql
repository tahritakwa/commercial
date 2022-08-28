delete  from ERPSettings.RoleConfigByRole 
delete  from ERPSettings.Role where Code not like 'admin%'

INSERT INTO [ERPSettings].[RoleConfigByRole]([IdRoleConfig],[IdRole] ,[IsActive],[IsVisible],[TransactionUserId])
     select Id,1,1,1,Null from [ERPSettings].[RoleConfig] ;
GO