---- traceability
ALTER TABLE [ERPSettings].[Traceability]
  ADD [TableName]         NVARCHAR (50)  NULL,
      [KeyValues]         NVARCHAR (100) NULL,
      [NewValues]         NVARCHAR (MAX) NULL,
      [OldValues]         NVARCHAR (MAX) NULL,
      [DateTime]          DATETIME       NULL;

GO

BEGIN TRANSACTION

UPDATE [ERPSettings].[Traceability]
   SET [TableName] = [EntityName]
	  ,[KeyValues] = CONCAT('{', SUBSTRING(Object,21, CHARINDEX(',', Object, 21) - 6 - CHARINDEX(',', Object, 1)+1), '}') 
	  ,[DateTime]  = CASE [RequestType] 
				WHEN 'ADD' THEN 
							(CASE WHEN [DateCreate] IS NULL THEN [DateDelete] 
							ELSE [DateCreate]
							END)
				WHEN 'UPDATE' THEN [DateUpdate]
				WHEN 'DELETE' THEN [DateDelete]
				ELSE [DateDelete] 
				END
	  ,[NewValues] = CONCAT('{', SUBSTRING(Object, CHARINDEX(',', Object, 21) + 5, LEN(Object)), '}') 
	  ,[OldValues] = CASE [RequestType] 
						WHEN 'UPDATE' THEN CONCAT('{', SUBSTRING(Object, CHARINDEX(',', OldObject, 21) + 5, LEN(OldObject)), '}') 
						ELSE NULL
				END
GO
COMMIT TRANSACTION

ALTER TABLE [ERPSettings].[Traceability]
DROP COLUMN [DateCreate], [DateDelete], [DateUpdate], [Deleted_Token], [EntityName], [IsDeleted], [Object], [OldObject];

ALTER TABLE [ERPSettings].[Traceability]
ALTER COLUMN [TableName]         NVARCHAR (50)  NOT NULL;

ALTER TABLE [ERPSettings].[Traceability]
ALTER COLUMN  [KeyValues]         NVARCHAR (100) NOT NULL;

ALTER TABLE [ERPSettings].[Traceability] 
ALTER COLUMN [NewValues]         NVARCHAR (MAX) NOT NULL;

ALTER TABLE [ERPSettings].[Traceability] 
ALTER COLUMN [DateTime]          DATETIME       NOT NULL;
