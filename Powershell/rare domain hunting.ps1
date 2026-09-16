$events = Import-Csv .\proxy_log.csv

$byDomain = $events | Group-Object Domain

$flagged = foreach ($group in $byDomain) {

    
    $uniqueIps = $group.Group | Select-Object -ExpandProperty ClientIp -Unique

    if ($group.Count -eq 1 -and $uniqueIps.Count -eq 1) {
        [PSCustomObject]@{
            Domain    = $group.Name
            ClientIp  = $group.Group[0].ClientIp
            BytesSent = [int]$group.Group[0].BytesSent
            Time      = $group.Group[0].TimeCreated
        }
    }
}

$flagged | Sort-Object BytesSent -Descending | ForEach-Object {
    Write-Host "RARE DOMAIN - worth reviewing" -ForegroundColor Yellow
    Write-Host "Domain     : $($_.Domain)"
    Write-Host "Client IP  : $($_.ClientIp)"
    Write-Host "Bytes sent : $($_.BytesSent)"
    Write-Host "Time       : $($_.Time)"
    Write-Host "-----------------------------"
}
