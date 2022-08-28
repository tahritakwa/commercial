try
{
    $connectionString = "Data Source=192.168.1.133;Initial Catalog=master;Integrated Security=false; User Id=sa; Password=Spark-It2020;"
    $connection = New-Object System.Data.SqlClient.SqlConnection($ConnectionString)
    $getDatabasesQuery = 
@"
SELECT DataBaseName
FROM ITG_Catalog.Master.MasterCompany
WHERE IsDeleted = 0;
"@

    $command = New-Object System.Data.SqlClient.SqlCommand($getDatabasesQuery, $connection)
	$localScriptRoot = "."
	$scripts = Get-ChildItem $localScriptRoot | Where-Object {$_.Extension -eq ".sql"}
    $connection.Open()
    $reader = $command.ExecuteReader()
    while($reader.Read()) {
		$CommDatabaseName = $reader["DataBaseName"]
		foreach ($s in $scripts)
		{
			$script = $s.FullName
			
			if ($s.Name -cmatch "\d-delete-sp.sql")
			{
				Write-Host "Running Script :$s.Name in < $CommDatabaseName > database "  -BackgroundColor DarkGreen -ForegroundColor White
				& SQLCMD -S 192.168.1.133 -U sa -P Spark-It2020 -d $CommDatabaseName -v db = "'$CommDatabaseName'" -I -b -i $script
				
			}
			elseif ($s.Name -cmatch "\d-create-and-exec-comm-sp.sql")
			{
				Write-Host "Running Script :$s.Name in < $CommDatabaseName > database "  -BackgroundColor DarkGreen -ForegroundColor White
				& SQLCMD -S 192.168.1.133 -U sa -P Spark-It2020 -d $CommDatabaseName -I -b -i $script
				
			}
			elseif ($s.Name -cmatch "\d-run-jobs.sql")
			{
				Write-Host "Running Script : $s.Name in < $CommDatabaseName >"  -BackgroundColor DarkGreen -ForegroundColor White
				& SQLCMD -S 192.168.1.133 -U sa -P Spark-It2020 -d $CommDatabaseName -v db = "'$CommDatabaseName'" -I -b -i $script
				
			}
			elseif ($s.Name -cmatch "\d-check-jobs-status.sql")
			{
				Write-Host "Running Script : $s.Name in < $CommDatabaseName >"  -BackgroundColor DarkGreen -ForegroundColor White
				& SQLCMD -S 192.168.1.133 -U sa -P Spark-It2020 -d $CommDatabaseName -v db = "'$CommDatabaseName'" -I -b -i $script
				
				
			}			
			
			if($LASTEXITCODE -ne 0 -and (($s.Name -cmatch "\d-delete-sp.sql") -or ($s.Name -cmatch "\d-create-and-exec-comm-sp.sql") -or ($s.Name -cmatch "\d-run-jobs.sql") -or ($s.Name -cmatch "\d-check-jobs-status.sql"))) {
				Write-Host "non-zero SQLCMD exit code $LASTEXITCODE for database $CommDatabaseName" -ForegroundColor Red
			}
			
        }
    }
    $connection.Close()
}
catch [Exception]
{
	throw;
}