BACKUP DATABASE Ref_Garge_TND
TO DISK = 'C:\backupdatabase\Ref_Garge_TND'
GO



use Catalog_Pre
DECLARE @codecompany  nvarchar(16)
set @codecompany =  CONCAT('C', CAST((SELECT current_value FROM Catalog_Pre.sys.sequences WHERE name = 'CodeCompany_seq' ) AS VARCHAR), '_StarkGarage')

DECLARE @Back1  nvarchar(150)
set @Back1 = CONCAT('C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\',@codecompany,'.mdf');

DECLARE @Back2  nvarchar(150)
set @Back2 = concat ('C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\',@codecompany,'.ldf');

select @Back1 , @Back2,@codecompany


RESTORE DATABASE @codecompany FROM DISK = 'C:\backupdatabase\Ref_Garge_TND'
 WITH MOVE 'C4_StarkGarage' TO @Back1 ,
    MOVE 'C4_StarkGarage_Log' TO @Back2
Go

DECLARE @Lastcodecompany  nvarchar(16)
set @Lastcodecompany =  CONCAT('C', CAST((SELECT current_value FROM Catalog_Pre.sys.sequences WHERE name = 'CodeCompany_seq' ) AS VARCHAR))


DECLARE @idCompany  int
set @idCompany =0
DECLARE @idrole  int
set @idrole =0

set @idCompany = (select id from [Master].[MasterCompany] where [Code] = @Lastcodecompany)
set @idrole = (select top 1 id from [Master].MasterRole where IdCompany = @idCompany)

INSERT INTO [Master].[MasterRolePermission] ([IdRole],[IdPermission] ,[IsDeleted])select
           @idrole,Id,0 from [Master].MasterPermission where id in 
		   (819,820,821,822,823,824,825,826,827,828,829,830,831,832,833,834,835,836,837,838,839,840,841,842,843,844,845,846,847,848,849,850,851,852,853,854,855,856,857,858,859,860,861,862,863,864,865,866,867,868,869,870,871,872,914,926,927,928,929,930,931,932,933,934,935,945,946,947,948,949,950,951,952,960,961,962,963,964,975,976,977,978,979,980,981,983,984,985,986,987)

update Master.MasterCompany set GarageDataBaseName =CONCAT(@Lastcodecompany,'_StarkGarage') where DataBaseName =CONCAT  (@Lastcodecompany,'_Commercial')

DECLARE @DatabaseName NVARCHAR(MAX)
SET @DatabaseName = CONCAT  (@Lastcodecompany,'_Commercial')
select @idrole ,@idCompany 

GO