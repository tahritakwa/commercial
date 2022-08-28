#!/bin/sh
#
# loop over the result of 'ls -1 *.sql'
#     'ls -1' sorts the file names based on the current locale 
#     and presents them in a single column

echo 'executing database script'


for i in *.sql; do 


	echo executing $i
    /opt/mssql-tools/bin/sqlcmd -S 192.168.1.203 -U sa -P Spark-It2020 -d Catalog_Recette -i $i
	echo completed $i

done