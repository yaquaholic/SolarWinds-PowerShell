<# 
.TITLE	File age monitor
.DATE		2015/04/14
.USE		This script will retrieve the oldest file from the folder, if it has been there for more than 15 minutes.
        This should prove a good test to see if the queue is stuck.
        Pass the full path to the folder in question in the Script Arguments. 
.URL		https://documentation.solarwinds.com/en/success_center/sam/content/sam-create-windows-powershell-script-monitor.htm
#>

#Variables
$olddate = [DateTime]::MaxValue;
$now = Get-Date;
$oldfn = "";
$path = $args.get(0);

#Test path exists, if not exit with error
if ( $path -eq $null )  { exit 1 }

#Test that the folder has files, if empty exit cleanly
$filesfound = Get-ChildItem $path | Measure-Object
$filesfound.count                                    #Returns the count of all of the files in the directory
If ($directoryInfo.count -eq 0) {exit 0}

#So files exist, how old is the oldest file?
get-childitem $path | ForEach-Object
  {
    if ($_.LastWriteTime -lt $olddate -and -not $_.PSIsContainer) 
      {
        $oldfn = $_.Name
        $olddate = $_.LastWriteTime
      }
  }

#More than 15 minutes, tell SolarWinds
if ($olddate -gt $now.AddMinutes(-15)) 
     { 
       Write-Host "Message: $oldfn"
       Write-Host "Statistic: 1"
       exit 0 
     }

exit 0
