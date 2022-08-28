-- Bachir: Update Roles Delete Super Admin Functionnalities from other roles

BEGIN TRANSACTION

DELETE FROM [ERPSettings].[FunctionalityConfig]
WHERE [ERPSettings].[FunctionalityConfig].[IdFunctionality] IN 
(N'be512744-b639-4f8a-ab84-e7f568ff5289' ,
N'4c727392-f0f3-4ea7-893d-123648e831cf',
N'7b1e7ccb-fd1e-4271-b7b3-5f8d5efb5cec',
N'a6204969-3848-412d-80e1-c596eb740f36',
N'a291e34e-5db0-4835-bad7-f88cc7d5d3aa',
N'ae99aa0c-146f-4b4f-81d2-a95fb077a367',
N'd482c274-39ec-4dad-a850-fc692fb38c62',
N'fd671f2f-5b90-4de3-9a07-19ab4a3c8466',
N'60510b13-e60f-4802-a0df-2f96e3ddd31b',
N'ff7e3955-bea4-4ff8-8d54-b50c358a6b64',
N'03bd4fe6-a503-47b4-b67f-9fb1efc1b11d',
N'2f70b149-321e-48cd-8c01-daa0125bc7e5',
N'd6deb272-9e33-430e-bebd-77b8d131d624',
N'71cd9d72-3dfb-4577-a350-99a2cf36b146',
N'1de55d52-1dcd-44ec-9938-54edb726274f',
N'5b45e026-a699-4bd6-8b72-7e6eb93a7976',
N'9872c5e7-c954-465d-ae44-5b5f25acbe6c',
N'885a848d-b8d2-4811-9013-373a5e539183',
N'c48591bf-ac03-4d47-9a86-dc0824a1e7aa',
N'c2c8274f-d78a-49ce-9fc4-a654fd6fb200',
N'78a46c87-7a2d-4afc-98a8-c73ed2510f31',
N'7d3e9af7-c97e-41f3-bbe0-1f7f763460cd',
N'127a7f62-1605-44be-b6a0-113d76e8d172',
N'c822c8ea-b523-4f7e-b501-5835bb798a7e',
N'c8d2a578-8893-4567-adb0-5a7aa636e6ac',
N'afb5a8fb-744f-4525-b799-707c3d070763',
N'147118cf-5dcf-4aa8-8577-1f28a610ca4a')
AND [ERPSettings].[FunctionalityConfig].[IdRoleConfig] <> 90000


COMMIT TRANSACTION



-- Bachir: Update role config super admin

BEGIN TRANSACTION

ALTER TABLE [ERPSettings].[ModuleConfig] DROP CONSTRAINT [FK_ModuleConfig_Module]
ALTER TABLE [ERPSettings].[ModuleConfig] DROP CONSTRAINT [FK_ModuleConfig_RoleConfig]
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_Functionality]
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_RoleConfig]
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [DF_FonctionalityConfig_IdFunctionality]

DELETE FROM [ERPSettings].[FunctionalityConfig]  WHERE [ERPSettings].[FunctionalityConfig].[IdRoleConfig] = 90000
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [ERPSettings].[ModuleConfig].[IdRoleConfig] = 90000


INSERT INTO [ERPSettings].[FunctionalityConfig] ([IdFunctionality],[IdRoleConfig])
SELECT DISTINCT x.IdFunctionality,90000
FROM [ERPSettings].[Functionality] as x

INSERT INTO [ERPSettings].[ModuleConfig] ([IdModule], [IdRoleConfig])
SELECT DISTINCT x.IdModule,90000
FROM [ERPSettings].[Module] as x


ALTER TABLE [ERPSettings].[FunctionalityConfig]
    ADD CONSTRAINT [DF_FonctionalityConfig_IdFunctionality] DEFAULT (newid()) FOR [IdFunctionality];
ALTER TABLE [ERPSettings].[FunctionalityConfig] WITH NOCHECK
    ADD CONSTRAINT [FK_FonctionalityConfig_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality]);
ALTER TABLE [ERPSettings].[FunctionalityConfig] WITH NOCHECK
    ADD CONSTRAINT [FK_FonctionalityConfig_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id]);
ALTER TABLE [ERPSettings].[ModuleConfig] WITH NOCHECK
    ADD CONSTRAINT [FK_ModuleConfig_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule]);
ALTER TABLE [ERPSettings].[ModuleConfig] WITH NOCHECK
    ADD CONSTRAINT [FK_ModuleConfig_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id]);

COMMIT TRANSACTION
