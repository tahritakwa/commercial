@Echo Off

chcp 65001

for %%a in (.\1-Create-DataBase\*.sql) do call :RunScript  %%a master
for %%a in (.\3-ERP\*.sql) do call :RunScript  %%a MasterGuidTN
for %%a in (.\4-Hangfire\*.sql) do call :RunScript  %%a HangFire
for %%a in (.\5-Stored-Procedure\*.sql) do call :RunScript  %%a MasterGuidTN


pause

:RunScript

Echo Executing %1 in %2

SQLCMD -S . -U dev -P Spark-It2016 -d %2 -i %1 -f 65001

Echo Completed %1

:END

