<# 
.TITLE	    Disk queue monitor
.DATE		2021 05 13
.USE		This script will retrieve the _Total disk queue length, anyhting above zero is noteworthy.
            _Total is a WMI catchall for all disks. Check the output of `Get-WmiObject -Class win32_perfformatteddata_perfdisk_physicaldisk`
            to see all the individual disks. 
.URL		https://documentation.solarwinds.com/en/success_center/sam/content/sam-create-windows-powershell-script-monitor.htm
#>

$diskinfo = Get-WmiObject -Class win32_perfformatteddata_perfdisk_physicaldisk -Filter "Name LIKE '_Total'"
$diskqueue = $diskinfo.AvgDisksecPerTransfer * $diskinfo.DiskTransfersPersec

If ( $diskqueue -gt 0 )
    { Write-Host "Statistic: $diskqueue"
      Write-Host "Message: Disk queue is above zero"
    }
Else
    { Write-Host "Statistic: $diskqueue"
      Write-Host "Message: Disk queue is zero"
    }
