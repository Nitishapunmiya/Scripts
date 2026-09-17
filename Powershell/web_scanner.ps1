$lines = Get-Content .\web_access.log


$requests = foreach ($line in $lines) {
    if ($line -match '^(?<time>\S+ \S+) (?<ip>\S+) (?<method>\S+) (?<path>\S+) (?<status>\d+)$') {
        [PSCustomObject]@{
            Time   = [datetime]$matches['time']
            Ip     = $matches['ip']
            Method = $matches['method']
            Path   = $matches['path']
            Status = $matches['status']
        }
    }
}

$byIp = $requests | Group-Object Ip

foreach ($group in $byIp) {

    $sorted = $group.Group | Sort-Object Time
    $span = ($sorted[-1].Time - $sorted[0].Time).TotalSeconds

   
    if ($group.Count -ge 15 -and $span -lt 120) {
        $uniquePaths = $sorted.Path | Select-Object -Unique

        Write-Host "POSSIBLE SCANNER DETECTED" -ForegroundColor Red
        Write-Host "IP              : $($group.Name)"
        Write-Host "Total requests  : $($group.Count)"
        Write-Host "Time span       : $([math]::Round($span,1)) sec"
        Write-Host "Unique paths hit:"
        $uniquePaths | ForEach-Object { Write-Host "   $_" }
        Write-Host "-----------------------------"
    }
}
