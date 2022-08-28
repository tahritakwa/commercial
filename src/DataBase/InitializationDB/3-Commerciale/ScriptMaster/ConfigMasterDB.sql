DECLARE @idCompany  int
set @idCompany =0

DECLARE @idrole  int
set @idrole =0

DECLARE @idroleB2B  int
set @idroleB2B =0

DECLARE @idUser int
set @idUser =0


BEGIN TRANSACTION
set @idUser = (select  MAX(id) from [Master].[MasterUser] where [Email] = @EmailUser)


ALTER TABLE [Master].[MasterUserCompany] DROP CONSTRAINT [FK_MasterUserCompany_MasterCompany]
ALTER TABLE [Master].[MasterUserCompany] DROP CONSTRAINT [FK_MasterUserCompany_MasterUser]

IF @idUser is null   
BEGIN
    
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
           (@FirstName
           ,@SecondName
           ,@EmailUser
           ,@EmailUser
           ,'9fd3ce560c85f097b2be8784844ad05da15132cfe1f1696e3e220f4a79cde33c9972dbe2aa750775b053ed12c723969f13e880ac66199a02e4d368b38cbdaeb8'
           ,NULL
           ,NULL
           ,0
           ,NULL
           ,NULL
           ,0)

set @idUser = (select  MAX(id) from [Master].[MasterUser] where [Email] = @EmailUser)

	
END


INSERT INTO [Master].[MasterCompany] ( [Code], [Name], [Email], [IsDeleted], [TransactionUserId], [Deleted_Token], [DataBaseName], [IdMasterDbSettings]) VALUES (@codecompany, @organisationName , @EmailUser, 0, NULL, NULL, @DatabaseName, 1)


set @idCompany = (select  MAX(id) from [Master].[MasterCompany] where [Code] = @codecompany)
INSERT INTO [Master].[MasterRole] ([Code],[Label],[IdCompany])VALUES('admin', 'admin',@idCompany)
set @idrole = (select id from [Master].MasterRole where IdCompany = @idCompany)

INSERT INTO [Master].[MasterUserCompany] ([IdMasterUser], [IdMasterCompany], [IsDeleted], [TransactionUserId], [Deleted_Token],IsActif) VALUES ( @idUser, @idCompany, 0, NULL, NULL,1)
INSERT [Master].[CompanyLicence] ( [IdMasterCompany], [NombreERPUser], [NombreB2BUser], [ExpirationDate], [IntialDate], [IsDeleted], [Deleted_Token]) VALUES ( @idCompany, @NumberOfUsers, 10, @EndDate, @StartDate , 0, NULL)

INSERT INTO [Master].[MasterRolePermission] ([IdRole],[IdPermission] ,[IsDeleted])select
           @idrole,Id,0 from [Master].MasterPermission where id in (92,93,94,95,96,270,312,328,329,330,331,332,333,334,335,336,337,338,339,340,341,344,345,366,379,380,394,395,396,398,399,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513,514,515,516,517,518,519,520,521,522,523,524,525,526,527,528,529,530,531,532,533,534,535,536,537,538,539,540,541,542,543,544,545,546,547,548,549,550,551,552,553,554,555,556,558,559,560,561,562,563,564,565,566,567,568,569,570,571,572,573,574,575,576,577,578,579,580,581,582,583,584,585,586,587,588,589,590,591,592,593,594,595,596,597,598,599,600,601,602,603,604,605,606,607,608,609,610,611,612,613,614,615,616,617,618,619,620,621,622,623,624,625,626,627,628,629,630,631,632,633,634,635,636,637,638,639,640,641,642,643,644,645,646,647,648,649,650,651,652,653,654,655,656,657,658,659,660,661,662,663,664,665,666,667,668,669,670,671,672,673,674,675,676,677,678,679,680,681,682,683,684,685,686,687,688,689,690,691,694,695,696,697,698,699,700,701,702,703,740,747,750,751,752,794,795,796,797,798,873,874,875,876,877,878,879,880,881,882,883,884,885,886,887,888,889,890,891,892,893,894,895,896,897,898,899,900,901,902,903,904,905,910,911,912,913,915,916,917,918,919,920,921,922,923,924,925,936,937,938,939,940,941,942,943,953,954,955,956,957,958,959,965,973,974)


INSERT INTO [Master].[MasterRoleUser] ([IdMasterUser]  ,[IdRole] ,[IsDeleted] ,[IdMasterCompany])
     VALUES(@idUser, @idrole,0 ,@idCompany)

ALTER TABLE [Master].[MasterUserCompany]
    ADD CONSTRAINT [FK_MasterUserCompany_MasterCompany] FOREIGN KEY ([IdMasterCompany]) REFERENCES [Master].[MasterCompany] ([Id])

ALTER TABLE [Master].[MasterUserCompany]
    ADD CONSTRAINT [FK_MasterUserCompany_MasterUser] FOREIGN KEY ([IdMasterUser]) REFERENCES [Master].[MasterUser] ([Id])

	DECLARE @SQL nvarchar(1000)
SET @SQL = 'USE ' + @DatabaseName + '; update Shared.Company set  Code = '''+@codecompany+''', MatriculeFisc='''+@taxRegistrationNumber+''' , Name='''+@organisationName+''', WebSite='''+@OrganisationWebsite+''' , SIRET='''+@siret+''' , Tel1='''+@organisationPhone+'''  , IdCurrency = (select Id from Administration.Currency where  Code='''+@codeCurrency+''') , ActivityArea = '+@activityArea+' '
print @SQL
EXEC (@SQL)

DECLARE @SQL1 nvarchar(1000)
SET @SQL1 = 'USE ' + @DatabaseName + '; update ERPSettings.[User] set Email = '''+@EmailUser+''' , FirstName= '''+@FirstName+''' , LastName = ''' +@SecondName+''' , IsTecDoc = ' +@isWithTecDoc+' , Phone='''+@Phone+''' , Lang ='''+@Language+''' , FullName='''+@FirstName+' '+@SecondName+''' where id = 2 ;'
print @SQL1
EXEC (@SQL1)

COMMIT TRANSACTION