
use Catalog

/*Pointer used for text / image updates. This might not be needed, but is declared here just in case*/
DECLARE @codecompany  nvarchar(16)

set @codecompany = CONCAT ('C',NEXT VALUE FOR CodeCompany_seq);

DECLARE @usercompany  nvarchar(60)
set @usercompany = CONCAT( @codecompany,N'-user@stark.tn');

DECLARE @idCompany  int
set @idCompany =0

DECLARE @idUser int
set @idUser =0


BEGIN TRANSACTION
ALTER TABLE [Master].[MasterUserCompany] DROP CONSTRAINT [FK_MasterUserCompany_MasterCompany]
ALTER TABLE [Master].[MasterUserCompany] DROP CONSTRAINT [FK_MasterUserCompany_MasterUser]


INSERT INTO [Master].[MasterUser] ([FirstName], [LastName], [Email], [Login], [Password], [Token], [LastConnectedCompany], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES ( N'admin', N'admin', @usercompany, N'Administrator', N'671efae529bbe9e27dc600fa56890a35cdf9d5915fd430f57eabfac9296f2733133e73b7decacc3d62eadb5bafe3691289f25aaaf835381cd83d12693dbcc3bf', NULL, @codecompany, 0, NULL, NULL)


INSERT INTO [Master].[MasterCompany] ( [Code], [Name], [Email], [IsDeleted], [TransactionUserId], [Deleted_Token], [DataBaseName], [IdMasterDbSettings]) VALUES (@codecompany, @codecompany , @usercompany, 0, NULL, NULL, Concat (@codecompany,'_Commercial'), 1)

set @idCompany = (select id from [Master].[MasterCompany] where [Code] = @codecompany)
set @idUser = (select id from [Master].[MasterUser] where [Email] = @usercompany)

INSERT INTO [Master].[MasterUserCompany] ([IdMasterUser], [IdMasterCompany], [IsDeleted], [TransactionUserId], [Deleted_Token]) VALUES ( @idUser, @idCompany, 0, NULL, NULL)

INSERT [Master].[CompanyLicence] ( [IdMasterCompany], [NombreERPUser], [NombreB2BUser], [ExpirationDate], [IntialDate], [IsDeleted], [Deleted_Token]) VALUES ( @idCompany, 10, 10, NULL, CAST( GETDATE() as DATE) , 0, NULL)


ALTER TABLE [Master].[MasterUserCompany]
    ADD CONSTRAINT [FK_MasterUserCompany_MasterCompany] FOREIGN KEY ([IdMasterCompany]) REFERENCES [Master].[MasterCompany] ([Id])

ALTER TABLE [Master].[MasterUserCompany]
    ADD CONSTRAINT [FK_MasterUserCompany_MasterUser] FOREIGN KEY ([IdMasterUser]) REFERENCES [Master].[MasterUser] ([Id])

COMMIT TRANSACTION

select @codecompany ,@usercompany, Concat (@codecompany,'_Commercial');

 DECLARE @SqlQuery NVARCHAR(150) = 'CREATE DATABASE ' +  Concat (@codecompany,'_Commercial')
    EXECUTE (@SqlQuery)


 


