@Echo Off

SQLCMD  -S 10.10.10.46 -U dev -P Spark-It2020 -v Email='import@sagap.tn' FirstName='Becem'  -v SecondName ='Bouaziz' -i C:\scriptt\AutoTND\S1-Commercial.sql

del C:\backupdatabase\Ref_Commercil_Auto_TND

Echo Completed %1
pause
:RunScript
:END