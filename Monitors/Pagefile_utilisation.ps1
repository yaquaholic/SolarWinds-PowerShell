## SAM/APM Monitoring script
## 2021 05 13
## See: https://documentation.solarwinds.com/en/success_center/sam/content/sam-create-windows-powershell-script-monitor.htm
## Limitation: SAM will only accept 10 results, so if you have 10+ pagefiles you will need to rethink this

$pagefiles = Get-WmiObject -Class win32_PageFileUsage

ForEach ($pagefile in $pagefiles)
          {
            $util = [math]::Round(($pagefile.CurrentUsage/$pagefile.AllocatedBaseSize)*100,2)
            $name = $($pagefile.Caption).Replace(':\pagefile.sys','')
            $stat = "Statistic." + $name + ": $util"
            $msg = "Message." + $name + ": $($pagefile.Caption) utilisation is $util %"
            Write-Host $stat
            Write-Host $msg
          }
