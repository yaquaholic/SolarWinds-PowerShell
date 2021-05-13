<# 
.TITLE	Pagefle utilisation monitor
.DATE	2021 05 13
.USE	This script will retrieve the pagefile utilisation.
.LIMITS   SAM will only accept 10 results, so if you have 10+ pagefiles you will need to rethink this
.URL	https://documentation.solarwinds.com/en/success_center/sam/content/sam-create-windows-powershell-script-monitor.htm
#>

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
