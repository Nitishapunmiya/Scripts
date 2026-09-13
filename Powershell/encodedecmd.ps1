$events = Import-Csv .\scriptblog.csv

foreach ($event in $events) {
    if ($event.ScriptBlockText -match '-enc(?:odedcommand)?\s+([A-Za-z0-9+/=]+)') {
        $encoded = $matches[1]
        $decodedBytes = [System.Convert]::FromBase64String($encoded)
        $decodedText  = [System.Text.Encoding]::Unicode.GetString($decodedBytes)

        Write-Host "SUSPICIOUS ENCODED COMMAND FOUND" -ForegroundColor Red
        Write-Host "Time     : $($event.TimeCreated)"
        Write-Host "Computer : $($event.Computer)"
        Write-Host "Decoded  : $decodedText"
        Write-Host "-----------------------------"
    }
}
