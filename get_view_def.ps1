$connString = "Data Source=SQL5098.site4now.net;Initial Catalog=db_a70847_fast;User Id=db_a70847_fast_admin;Password=123456shreef"
$conn = New-Object System.Data.SqlClient.SqlConnection($connString)
$conn.Open()
$cmd = $conn.CreateCommand()

$cmd.CommandText = "SELECT definition FROM sys.sql_modules WHERE object_id = OBJECT_ID('dbo.vw_Users')"
$def = $cmd.ExecuteScalar()
Write-Host "--- vw_Users Definition ---"
Write-Host $def

$conn.Close()
