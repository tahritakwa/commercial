---Ghazoua : add OemNumberModified to oemItem table 28/12/2021
ALTER TABLE [Inventory].[OemItem]
 ADD [OemNumberModified] [nvarchar](20)  NULL;
---Ghazoua add IdCreatorBtob to document 29/12/2021
	ALTER TABLE [Sales].[Document]
 ADD [IdCreatorBtob] [int] NULL;

 ---Ghazoua add FullName to UsersBtob 29/12/2021
ALTER TABLE [Sales].[UsersBtob]
 ADD [FullName]     NVARCHAR (50)  NULL;