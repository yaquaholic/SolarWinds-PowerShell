#Select NodeID From Nodes Where Status = 1 and dump it into $file
$date = Get-Date -Format yyMMdd
$file = "C:\tmp\managed_$($date).txt"
$managed = Get-Content $file

#Load SwisSnapin if required
if ( (Get-PSSnapin -Name SwisSnapin -ErrorAction SilentlyContinue) -eq $null )
      { Add-PSSnapin SwisSnapin }

#Variables
$server = 'orion.fqdn'
$now = [DateTime]::UtcNow
$later = $now.AddDays(1)


#Trusted connection
$user = "username"
$password ="password"
$swis = Connect-Swis -Hostname $server -UserName $user -Password $password

ForEach ($nodeid in $managed)
   { 
     #Details - commented out to speed things up
     #$name = Get-SwisData $swis "SELECT Caption FROM Orion.Nodes WHERE NodeId = $($nodeid)"
     #Write-host "Unmanaging $name"

     #Unmanage
     Invoke-SwisVerb $swis Orion.Nodes Unmanage @("N:$($nodeid)",$now,$later,"false")
    }

#Close the connection
$Swis.Close()  
Remove-Variable -Name Swis -ErrorAction SilentlyContinue 
