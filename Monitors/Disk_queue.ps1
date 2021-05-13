## SAM(APM) PowerShell monitor for Disk Queues
## 2021 05 13
## _Total is a WMI catchall for all disks.

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
