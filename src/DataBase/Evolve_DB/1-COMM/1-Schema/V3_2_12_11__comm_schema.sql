---Ghazoua : drop clientMail column and add idClient to usersbtob 06/01/2022

GO
ALTER TABLE [Sales].[UsersBtob] 
ADD  [IdClient] INT  NOT NULL 
CONSTRAINT DF_UsersBtob_IdClient DEFAULT 0;
GO
DECLARE @i int
DECLARE @numrows int
SET @i = (SELECT min(id) FROM [Sales].[UsersBtob])
DECLARE @ROWNAME varchar(50)
SET @numrows = (SELECT max(id) FROM [Sales].[UsersBtob])
IF @numrows > 0
    WHILE (@i <= @numrows)
    BEGIN
	 SELECT  @ROWNAME =[ClientMail]
    FROM [Sales].[UsersBtob]
	 WHERE Id = @i
	Update [Sales].[UsersBtob] SET [IdClient] = (SELECT Id FROM [Sales].[Tiers] WHERE Email = @ROWNAME) WHERE Id = @i;
    SET @i = @i + 1
    END
GO
ALTER TABLE [Sales].[UsersBtob] DROP COLUMN[ClientMail] ;
GO 
ALTER TABLE [Sales].[UsersBtob]   WITH CHECK ADD  CONSTRAINT [FK_UsersBtob_Tiers] FOREIGN KEY([IdClient])
REFERENCES [Sales].[Tiers] ([Id])
 
ALTER TABLE [Sales].[UsersBtob] CHECK CONSTRAINT [FK_UsersBtob_Tiers]