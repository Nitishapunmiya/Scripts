$events=import-csv ./password_spray.csv

$byip=$events |where-object {$_.eventid -eq "4625"} | group-object ipaddress
foreach ($group in $byip){
    $uniqueusers= $group.group | select-object -expandproperty targetusername -unique 

    if ($uniqueusers.count -gt 5){
        Write-Host "POSSIBLE PASSWORD SPRAY DETECTED" -ForegroundColor Red
        Write-Host "Source IP        : $($group.Name)"
        Write-Host "Total attempts   : $($group.Count)"
        Write-Host "Distinct users   : $($uniqueUsers.Count)"
        Write-Host "Usernames tried  : $($uniqueUsers -join ', ')"
        Write-Host "-----------------------------"
    }
}
