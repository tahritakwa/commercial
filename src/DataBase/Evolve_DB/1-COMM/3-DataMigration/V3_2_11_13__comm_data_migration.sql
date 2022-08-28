--Ghazoua : Update  OemNumberModified 28/12/2021
update [Inventory].[OemItem] set [OemNumberModified] =replace( [OemNumber] , ' ','')
 go
update [Inventory].[OemItem] set [OemNumberModified] =replace( [OemNumberModified] , '.','')
 go
 update [Inventory].[OemItem] set [OemNumberModified] =replace( [OemNumberModified] , '-','')
 go
