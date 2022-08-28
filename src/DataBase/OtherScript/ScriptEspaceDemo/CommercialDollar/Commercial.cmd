@Echo Off

SQLCMD  -S 10.10.10.46 -U dev -P Spark-It2020 -v Email='Joey.Cohen@PetsQ.com' FirstName='Joey'  -v SecondName ='Cohen' -i C:\Users\Spark\Desktop\scriptt\CommercialDollar\S1-Commercial.sql

del C:\backupdatabase\Ref_Commercil_Euro

Echo Completed %1
pause
:RunScript
:END