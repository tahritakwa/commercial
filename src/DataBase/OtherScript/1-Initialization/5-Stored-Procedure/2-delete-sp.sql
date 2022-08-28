PRINT N'Deleting S.P under Reporting Schema in '+$(db)
declare @sql varchar(max)

set @sql = (
select
    'DROP PROCEDURE [' + routine_schema + '].[' + routine_name + '] ' 
from 
    information_schema.routines where routine_schema = 'Reporting' and routine_type = 'PROCEDURE'
FOR XML PATH ('')
)
if(@@ROWCOUNT > 0)
	BEGIN
		exec (@sql)
		PRINT N'All S.P under Reporting Schema are deleted'
	END 
ELSE
	BEGIN
		PRINT N'There is no SP under Reporting schema'
	END