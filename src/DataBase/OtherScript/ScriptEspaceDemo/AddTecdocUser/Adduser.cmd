@Echo Off

SQLCMD  -S 10.10.10.26 -U sa -P Spark-It2020 -v Email='import@sagap.tn'   -i C:\scriptt\AddTecdocUser\AddUser.sql


Echo Completed %1
pause
:RunScript
:END