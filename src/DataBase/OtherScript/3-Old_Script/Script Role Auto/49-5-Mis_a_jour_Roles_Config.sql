BEGIN TRANSACTION

UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Historique d''achat' WHERE [Id]=100005
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Demande d''achat' WHERE [Id]=100017
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Bon de réception' WHERE [Id]=100031
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Modification Bon de réception Validé' WHERE [Id]=100043
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Modification Facture Achat Validée' WHERE [Id]=100045
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Modification Commande Achat Validée' WHERE [Id]=100046
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Modification Commande final Achat Validée' WHERE [Id]=100047
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Modification Demande Achat Validée' WHERE [Id]=100049
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Modification Demande Achat Validée' WHERE [Id]=100051
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Impression Bon de réception' WHERE [Id]=100052
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Validation Bon de réception' WHERE [Id]=100053
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Gestion du stock' WHERE [Id]=22222
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Dépôt' WHERE [Id]=100013
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'État de Contrôle' WHERE [Id]=100058
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Comptabilité' WHERE [Id]=100008
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'Correction du stock' WHERE [Id]=100006

UPDATE [ERPSettings].[RoleConfigCategory] SET [Label]=N'Comptabilité' WHERE [Id]=100008
UPDATE [ERPSettings].[RoleConfigCategory] SET [Label]=N'Correction du stock' WHERE [Id]=100100

COMMIT TRANSACTION