$connString = "Data Source=SQL5098.site4now.net;Initial Catalog=db_a70847_fast;User Id=db_a70847_fast_admin;Password=123456shreef"
$conn = New-Object System.Data.SqlClient.SqlConnection($connString)
$conn.Open()
$cmd = $conn.CreateCommand()

Write-Host "--- User 61 View Details ---"
$cmd.CommandText = "SELECT Id, Name, Email, Ocounts FROM dbo.vw_Users WHERE Id = 61"
$reader = $cmd.ExecuteReader()
if ($reader.Read()) {
    Write-Host ("Id: " + $reader["Id"] + ", Name: " + $reader["Name"] + ", Email: " + $reader["Email"] + ", Ocounts: " + $reader["Ocounts"])
}
$reader.Close()

$conn.Close()
