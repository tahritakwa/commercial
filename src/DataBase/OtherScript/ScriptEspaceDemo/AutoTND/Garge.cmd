@Echo Off

SQLCMD  -S 10.10.10.46 -U dev -P Spark-It2020  -i C:\scriptt\AutoTND\S2-Garage.sql

del C:\backupdatabase\Ref_Garge_TND

Echo Completed %1
pause
:RunScript
:END