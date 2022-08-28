USE [TecDocLogs]
GO
DECLARE @usercompany  nvarchar(60)
set @usercompany = $(Email);


INSERT INTO [dbo].[Users]
           ([email]
           ,[Env])
     VALUES
           (@usercompany
           ,'PreProd')
GO