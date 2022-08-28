DECLARE @idCompany  int
set @idCompany =0

DECLARE @idrole  int
set @idrole =0

DECLARE @idroleB2B  int
set @idroleB2B =0

DECLARE @idUser int
DECLARE @idUser1 int
DECLARE @idUser2 int
set @idUser =0


BEGIN TRANSACTION
ALTER TABLE [Master].[MasterUserCompany] DROP CONSTRAINT [FK_MasterUserCompany_MasterCompany]
ALTER TABLE [Master].[MasterUserCompany] DROP CONSTRAINT [FK_MasterUserCompany_MasterUser]
INSERT INTO [Master].[MasterUser]
           ([FirstName]
           ,[LastName]
           ,[Email]
           ,[Login]
           ,[Password]
           ,[Token]
           ,[LastConnectedCompany]
           ,[IsDeleted]
           ,[TransactionUserId]
           ,[Deleted_Token]
           ,[IsBToB])
     VALUES
           (@firstname
           ,@lastname
           ,'btob'+@usercompany
           ,NULL
           ,'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8'
           ,NULL
           ,NULL
           ,0
           ,NULL
           ,NULL
           ,1)

set @idCompany = (select  MAX(id) from [Master].[MasterCompany] where [Code] = @codecompany)
set @idUser = (select  MAX(id) from [Master].[MasterUser] where [Email] = @usercompany)


INSERT INTO [Master].[MasterRole] ([Code],[Label],[IdCompany])VALUES('B2B_ADMIN', 'B2B_ADMIN',@idCompany)
set @idroleB2B = (select id from [Master].MasterRole where IdCompany = @idCompany and Code='B2B_ADMIN' )
INSERT INTO [Master].[MasterRolePermission] ([IdRole],[IdPermission] ,[IsDeleted])select
           @idroleB2B,Id,0 from [Master].MasterPermission where id in (473,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505)


INSERT INTO [Master].[MasterRoleUser] ([IdMasterUser]  ,[IdRole] ,[IsDeleted] ,[IdMasterCompany])
     VALUES(@idUser, @idroleB2B,0 ,@idCompany)

ALTER TABLE [Master].[MasterUserCompany]
    ADD CONSTRAINT [FK_MasterUserCompany_MasterCompany] FOREIGN KEY ([IdMasterCompany]) REFERENCES [Master].[MasterCompany] ([Id])

ALTER TABLE [Master].[MasterUserCompany]
    ADD CONSTRAINT [FK_MasterUserCompany_MasterUser] FOREIGN KEY ([IdMasterUser]) REFERENCES [Master].[MasterUser] ([Id])


DECLARE @SQL1 nvarchar(1000)
SET @SQL1 = 'USE ' + @DatabaseName + '; INSERT INTO [ERPSettings].[User] ([FirstName], [LastName], [Login], [Password], [Token], [Phone], [WorkPhone], [MobilePhone], [Email], [Birthday], [Picture], [IsDeleted], [TransactionUserId], [Deleted_Token], [IdUserParent], [Lang], [IdEmployee], [IsBToB], [IdTiers], [Role]) VALUES ( '''+@firstname+''' , '''+@lastname+''' , ''Administrator'',''9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8'', NULL, NULL, NULL, NULL, ''btob'+@usercompany+'''  , NULL, NULL, 0, 0, NULL, NULL, ''fr'', NULL, 1, NULL, NULL);'

print @SQL1
EXEC (@SQL1)


COMMIT TRANSACTION