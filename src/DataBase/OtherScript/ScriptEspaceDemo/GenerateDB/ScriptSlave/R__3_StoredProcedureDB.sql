create procedure dbo.ADD_COMMUN_COLUMN as
 DECLARE @COLUMN as NVARCHAR(255), @columntype as NVARCHAR(255)
 BEGIN

declare @sql nvarchar(max) =''

SELECT  @sql = @sql + 'ALTER TABLE '+ QUOTENAME(ss.name) + '.' + QUOTENAME(st.name) +' ADD ' + @COLUMN +' ' + @columntype + ' NULL;'
FROM sys.tables st
INNER JOIN sys.schemas ss on st.[schema_id] = ss.[schema_id]
where st.name IN (select TABLE_NAME from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME='IsDeleted')
AND NOT EXISTS (
    SELECT 1
    FROM sys.columns sc
    WHERE sc.[object_id] = st.[object_id]
    AND sc.name = 'Deleted_Token'
);

exec sp_executesql @sql

 END
GO
/****** Object:  StoredProcedure [dbo].[SearchAllTables]    Script Date: 05/11/2021 20:27:09 ******/
 
create procedure dbo.SearchAllTables as  declare @SearchStr as nvarchar(100)
BEGIN

    CREATE TABLE #Results (ColumnName nvarchar(370), ColumnValue nvarchar(3630))

    SET NOCOUNT ON

    DECLARE @TableName nvarchar(256), @ColumnName nvarchar(128), @SearchStr2 nvarchar(110)
    SET  @TableName = ''
    SET @SearchStr2 = QUOTENAME('%' + @SearchStr + '%','''')

    WHILE @TableName IS NOT NULL

    BEGIN
        SET @ColumnName = ''
        SET @TableName = 
        (
            SELECT MIN(QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME))
            FROM     INFORMATION_SCHEMA.TABLES
            WHERE         TABLE_TYPE = 'BASE TABLE'
                AND    QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) > @TableName
                AND    OBJECTPROPERTY(
                        OBJECT_ID(
                            QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME)
                             ), 'IsMSShipped'
                               ) = 0
        )

        WHILE (@TableName IS NOT NULL) AND (@ColumnName IS NOT NULL)

        BEGIN
            SET @ColumnName =
            (
                SELECT MIN(QUOTENAME(COLUMN_NAME))
                FROM     INFORMATION_SCHEMA.COLUMNS
                WHERE         TABLE_SCHEMA    = PARSENAME(@TableName, 2)
                    AND    TABLE_NAME    = PARSENAME(@TableName, 1)
                    AND    DATA_TYPE IN ('char', 'varchar', 'nchar', 'nvarchar', 'int', 'decimal')
                    AND    QUOTENAME(COLUMN_NAME) > @ColumnName
            )

            IF @ColumnName IS NOT NULL

            BEGIN
                INSERT INTO #Results
                EXEC
                (
                    'SELECT ''' + @TableName + '.' + @ColumnName + ''', LEFT(' + @ColumnName + ', 3630) 
                    FROM ' + @TableName + ' (NOLOCK) ' +
                    ' WHERE ' + @ColumnName + ' LIKE ' + @SearchStr2
                )
            END
        END    
    END

    SELECT ColumnName, ColumnValue FROM #Results
END
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Accounting Schema' , @level0type=N'SCHEMA',@level0name=N'accounting'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'CRM Schema' , @level0type=N'SCHEMA',@level0name=N'CRM'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Immobilisation Schema' , @level0type=N'SCHEMA',@level0name=N'Immobilisation'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Payment Schema' , @level0type=N'SCHEMA',@level0name=N'Payment'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'RH Schema' , @level0type=N'SCHEMA',@level0name=N'RH'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sales Schema' , @level0type=N'SCHEMA',@level0name=N'Sales'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shared Schema' , @level0type=N'SCHEMA',@level0name=N'Shared'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Stock Schema' , @level0type=N'SCHEMA',@level0name=N'Stock'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Treasury Schema' , @level0type=N'SCHEMA',@level0name=N'Treasury'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Axis Identifier' , @level0type=N'SCHEMA',@level0name=N'Administration', @level1type=N'TABLE',@level1name=N'Axis', @level2type=N'COLUMN',@level2name=N'Id'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Axis code' , @level0type=N'SCHEMA',@level0name=N'Administration', @level1type=N'TABLE',@level1name=N'Axis', @level2type=N'COLUMN',@level2name=N'Code'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Axis label' , @level0type=N'SCHEMA',@level0name=N'Administration', @level1type=N'TABLE',@level1name=N'Axis', @level2type=N'COLUMN',@level2name=N'Label'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key' , @level0type=N'SCHEMA',@level0name=N'Administration', @level1type=N'TABLE',@level1name=N'Axis', @level2type=N'CONSTRAINT',@level2name=N'PK_Axis'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Analytical axes table' , @level0type=N'SCHEMA',@level0name=N'Administration', @level1type=N'TABLE',@level1name=N'Axis'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Axis identifier' , @level0type=N'SCHEMA',@level0name=N'Administration', @level1type=N'TABLE',@level1name=N'AxisEntity', @level2type=N'COLUMN',@level2name=N'IdAxis'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Entity identifier' , @level0type=N'SCHEMA',@level0name=N'Administration', @level1type=N'TABLE',@level1name=N'AxisEntity', @level2type=N'COLUMN',@level2name=N'IdTableEntity'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'This table defines which entity uses which axes' , @level0type=N'SCHEMA',@level0name=N'Administration', @level1type=N'TABLE',@level1name=N'AxisEntity'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AxisValue identifier' , @level0type=N'SCHEMA',@level0name=N'Administration', @level1type=N'TABLE',@level1name=N'AxisValue', @level2type=N'COLUMN',@level2name=N'Id'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AxisValue code' , @level0type=N'SCHEMA',@level0name=N'Administration', @level1type=N'TABLE',@level1name=N'AxisValue', @level2type=N'COLUMN',@level2name=N'Code'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AxisValue label' , @level0type=N'SCHEMA',@level0name=N'Administration', @level1type=N'TABLE',@level1name=N'AxisValue', @level2type=N'COLUMN',@level2name=N'Label'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Axis identifier' , @level0type=N'SCHEMA',@level0name=N'Administration', @level1type=N'TABLE',@level1name=N'AxisValue', @level2type=N'COLUMN',@level2name=N'IdAxis'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key' , @level0type=N'SCHEMA',@level0name=N'Administration', @level1type=N'TABLE',@level1name=N'AxisValue', @level2type=N'CONSTRAINT',@level2name=N'PK_AxisValue'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'This table defines value of axis' , @level0type=N'SCHEMA',@level0name=N'Administration', @level1type=N'TABLE',@level1name=N'AxisValue'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AxisRelationShip identifier' , @level0type=N'SCHEMA',@level0name=N'Administration', @level1type=N'TABLE',@level1name=N'AxisValueRelationShip', @level2type=N'COLUMN',@level2name=N'Id'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Axis value identifier' , @level0type=N'SCHEMA',@level0name=N'Administration', @level1type=N'TABLE',@level1name=N'AxisValueRelationShip', @level2type=N'COLUMN',@level2name=N'IdAxisValue'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Parent identifier' , @level0type=N'SCHEMA',@level0name=N'Administration', @level1type=N'TABLE',@level1name=N'AxisValueRelationShip', @level2type=N'COLUMN',@level2name=N'IdAxisValueParent'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key' , @level0type=N'SCHEMA',@level0name=N'Administration', @level1type=N'TABLE',@level1name=N'AxisValueRelationShip', @level2type=N'CONSTRAINT',@level2name=N'PK_AxisRelationShip'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'This table defines relationship between axis values' , @level0type=N'SCHEMA',@level0name=N'Administration', @level1type=N'TABLE',@level1name=N'AxisValueRelationShip'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique identifier of the table entity' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'Entity', @level2type=N'COLUMN',@level2name=N'Id'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Plan of database where entitées allocated to him' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'Entity', @level2type=N'COLUMN',@level2name=N'TableSchema'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of entity (In the database)' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'Entity', @level2type=N'COLUMN',@level2name=N'EntityName'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The user can change the names of the static tables in this column, just to differentiate the entities' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'Entity', @level2type=N'COLUMN',@level2name=N'TableName'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key of table Entity' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'Entity', @level2type=N'CONSTRAINT',@level2name=N'PK_TableEntity'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Table which contains all the entities existing in the database of the ERP' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'Entity'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique identifier of Functionaity table' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'Functionality', @level2type=N'COLUMN',@level2name=N'IdFunctionality'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of Functionality ' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'Functionality', @level2type=N'COLUMN',@level2name=N'FunctionalityName'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key on the table RequestType (Contains every type of the features)' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'Functionality', @level2type=N'COLUMN',@level2name=N'IdRequestType'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of the name modulates in Drench language ' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'Functionality', @level2type=N'COLUMN',@level2name=N'FR'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of the name modulates in English language ' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'Functionality', @level2type=N'COLUMN',@level2name=N'EN'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of the name modulates in Arabic language ' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'Functionality', @level2type=N'COLUMN',@level2name=N'AR'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of the name modulates in Deutsche language ' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'Functionality', @level2type=N'COLUMN',@level2name=N'DE'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of the name modulates in Chine language ' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'Functionality', @level2type=N'COLUMN',@level2name=N'CH'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of the name modulates in Spanich language ' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'Functionality', @level2type=N'COLUMN',@level2name=N'ES'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key of table Functionality' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'Functionality', @level2type=N'CONSTRAINT',@level2name=N'PK_Functionality_1'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique name in the table Functionality' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'Functionality', @level2type=N'CONSTRAINT',@level2name=N'AK_FunctionalityName_Unique'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'This table contains all the features existing in our ERP (Ajouter_Article, Edit_Article, List_Article, Confirm_Article....)' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'Functionality'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique identifier for Request type' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'RequestType', @level2type=N'COLUMN',@level2name=N'Id'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of request type' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'RequestType', @level2type=N'COLUMN',@level2name=N'RequestName'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key in table RequestType' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'RequestType', @level2type=N'CONSTRAINT',@level2name=N'PK_RequestType'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Table contains all the types of the features' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'RequestType'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique identifier' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Id'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'FIrst name of user' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'FirstName'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last name of user' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'LastName'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Login of user' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Login'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Password of user' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Password'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Phone number' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Phone'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Work phone number' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'WorkPhone'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mobile phone numer' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'MobilePhone'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Email of user' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Email'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Day birth user' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Birthday'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Picture of user' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Picture'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key of table user' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'User', @level2type=N'CONSTRAINT',@level2name=N'PK_dbo.t_user'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Table contains list of the users' , @level0type=N'SCHEMA',@level0name=N'ERPSettings', @level1type=N'TABLE',@level1name=N'User'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Décalage de paye' , @level0type=N'SCHEMA',@level0name=N'Shared', @level1type=N'TABLE',@level1name=N'Company', @level2type=N'COLUMN',@level2name=N'PaymentOffset'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Heures de références' , @level0type=N'SCHEMA',@level0name=N'Shared', @level1type=N'TABLE',@level1name=N'Company', @level2type=N'COLUMN',@level2name=N'HeuRef'
 
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mode de régularisation' , @level0type=N'SCHEMA',@level0name=N'Shared', @level1type=N'TABLE',@level1name=N'Company', @level2type=N'COLUMN',@level2name=N'RegularisationMode'
GO