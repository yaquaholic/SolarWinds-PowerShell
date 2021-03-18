#Select NodeID From Nodes Where Status = 1 and dump it into $file
$date = Get-Date -Format yyMMdd
$file = "C:\tmp\managed_$($date).txt"
#$managed = Get-Content $file

#Load SwisSnapin if required
if ( (Get-PSSnapin -Name SwisSnapin -ErrorAction SilentlyContinue) -eq $null )
      { Add-PSSnapin SwisSnapin }

#Variables
$server = 'orion.fqdn'
#Swis connection
$user = "username"
$password ="password"
$swis = Connect-Swis -Hostname $server -UserName $user -Password $password

#Get all up managed nodes and create a list, by NodeID
$managed = Get-SwisData $swis "SELECT NodeID FROM Orion.Nodes WHERE Unmanaged = 0 AND STATUS != 2"
$managed | Out-File -FilePath $file -Append

#Close the connection
$Swis.Close()  
Remove-Variable -Name Swis -ErrorAction SilentlyContinue 
