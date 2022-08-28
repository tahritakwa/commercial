SET NUMERIC_ROUNDABORT OFF
GO
SET XACT_ABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
/*Pointer used for text / image updates. This might not be needed, but is declared here just in case*/
DECLARE @pv binary(16)
BEGIN TRANSACTION
ALTER TABLE [Master].[MasterUserCompany] DROP CONSTRAINT [FK_MasterUserCompany_MasterCompany]
ALTER TABLE [Master].[MasterUserCompany] DROP CONSTRAINT [FK_MasterUserCompany_MasterUser]

SET IDENTITY_INSERT [Master].[MasterUser] ON
INSERT INTO [Master].[MasterUser] ([Id], [FirstName], [LastName], [Email], [Login], [Password], [Token], [LastConnectedCompany], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (5, N'admin', N'admin', N'demo@spark-it.fr', N'Administrator', N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, N'C001', 0, NULL, NULL)
SET IDENTITY_INSERT [Master].[MasterUser] OFF

SET IDENTITY_INSERT [Master].[MasterDbSettings] ON
INSERT INTO [Master].[MasterDbSettings] ([Id], [Server], [UserId], [UserPassword]) VALUES (1, N'.', N'dev', N'Spark-It2016')
SET IDENTITY_INSERT [Master].[MasterDbSettings] OFF

SET IDENTITY_INSERT [Master].[MasterUserCompany] ON
INSERT INTO [Master].[MasterUserCompany] ([Id], [IdMasterUser], [IdMasterCompany], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (1, 5, 2, 0, NULL, NULL)
INSERT INTO [Master].[MasterUserCompany] ([Id], [IdMasterUser], [IdMasterCompany], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (228, 5, 4, 0, NULL, NULL)
INSERT INTO [Master].[MasterUserCompany] ([Id], [IdMasterUser], [IdMasterCompany], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (229, 5, 5, 0, NULL, NULL)
SET IDENTITY_INSERT [Master].[MasterUserCompany] OFF


SET IDENTITY_INSERT [Master].[MasterCompany] ON
INSERT INTO [Master].[MasterCompany] ([Id], [Code], [Name], [Email], [IsDeleted], [TransactionUserId], [Deleted_Token], [DataBaseName], [IdMasterDbSettings]) VALUES (2, N'C001', N'Spark-TN', N'demo@spark.fr', 0, NULL, NULL, N'MasterGuidTN', 1)
INSERT INTO [Master].[MasterCompany] ([Id], [Code], [Name], [Email], [IsDeleted], [TransactionUserId], [Deleted_Token], [DataBaseName], [IdMasterDbSettings]) VALUES (4, N'C002', N'Spark-UK', N'demo@spark.fr', 0, NULL, NULL, N'MasterGuidUK', 1)
INSERT INTO [Master].[MasterCompany] ([Id], [Code], [Name], [Email], [IsDeleted], [TransactionUserId], [Deleted_Token], [DataBaseName], [IdMasterDbSettings]) VALUES (5, N'C003', N'Spark-FR', N'demo@spark.fr', 0, NULL, NULL, N'MasterGuidFR', 1)
SET IDENTITY_INSERT [Master].[MasterCompany] OFF

ALTER TABLE [Master].[MasterUserCompany]
    ADD CONSTRAINT [FK_MasterUserCompany_MasterCompany] FOREIGN KEY ([IdMasterCompany]) REFERENCES [Master].[MasterCompany] ([Id])

ALTER TABLE [Master].[MasterUserCompany]
    ADD CONSTRAINT [FK_MasterUserCompany_MasterUser] FOREIGN KEY ([IdMasterUser]) REFERENCES [Master].[MasterUser] ([Id])

COMMIT TRANSACTION

-- Narcisse : Add Houssem ben moustapha CRM user 16/06/2020
BEGIN TRANSACTION
SET IDENTITY_INSERT [Master].[MasterUser] ON
INSERT INTO [Master].[MasterUser] ([Id], [FirstName], [LastName], [Email], [Login], [Password], [Token], [LastConnectedCompany], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES (2006, N'Houssem', N'Ben Mustapha', N'houssem.benmustapha@spark-it.tn', NULL, N'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8', NULL, N'C003', 0, 0, NULL)
SET IDENTITY_INSERT [Master].[MasterUser] OFF
GO
SET IDENTITY_INSERT [Master].[MasterUserCompany] ON
INSERT INTO [Master].[MasterUserCompany] ([Id], [IdMasterUser], [IdMasterCompany], [IsDeleted], [TransactionUserId], [Deleted_Token], [IsActif]) VALUES (2230, 2006, 2, 0, 0, NULL, 1)
SET IDENTITY_INSERT [Master].[MasterUserCompany] OFF
COMMIT TRANSACTION

GO

--houssem 28-08-2020 add Nomber of licence
SET IDENTITY_INSERT [Master].[CompanyLicence] ON 
INSERT [Master].[CompanyLicence] ([Id], [IdMasterCompany], [NombreERPUser], [NombreB2BUser], [ExpirationDate], [IntialDate], [IsDeleted], [Deleted_Token]) VALUES (1, 2, 50, 10, NULL, CAST(N'2020-08-28' AS Date), 0, NULL)
INSERT [Master].[CompanyLicence] ([Id], [IdMasterCompany], [NombreERPUser], [NombreB2BUser], [ExpirationDate], [IntialDate], [IsDeleted], [Deleted_Token]) VALUES (2, 4, 50, 10, NULL, CAST(N'2020-08-28' AS Date), 0, NULL)
INSERT [Master].[CompanyLicence] ([Id], [IdMasterCompany], [NombreERPUser], [NombreB2BUser], [ExpirationDate], [IntialDate], [IsDeleted], [Deleted_Token]) VALUES (3, 5, 50, 10, CAST(N'2020-09-01' AS Date), CAST(N'2020-08-28' AS Date), 0, NULL)
SET IDENTITY_INSERT [Master].[CompanyLicence] OFF

update Master.MasterUser set IsBToB = 0 where IsBToB is null
alter table Master.MasterUser alter  column IsBToB  bit not null

---Imen chaaben: add GarageDataBaseName column to MasterCompany: 15/03/2021
update [Master].[MasterCompany] set GarageDataBaseName = 'StarkGarageTN' where DataBaseName = 'MasterGuidTN'
update [Master].[MasterCompany] set GarageDataBaseName = 'StarkGarageFR' where DataBaseName = 'MasterGuidFR'
update [Master].[MasterCompany] set GarageDataBaseName = 'StarkGarageUK' where DataBaseName = 'MasterGuidUK'