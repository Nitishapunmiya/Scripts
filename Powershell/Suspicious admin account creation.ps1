
$events = Import-Csv ./acc_creation.csv

$events = $events | ForEach-Object {
    $_ | Add-Member -NotePropertyName ParsedTime -NotePropertyValue ([datetime]$_.TimeCreated) -Force
    $_
} | Sort-Object ParsedTime

$users = $events | Where-Object {
    $_.EventID -eq "4720"
}

foreach ($user in $users) {

    $newacc = $user.TargetUsername
    $time = $user.ParsedTime

    $groups = $events | Where-Object {
        $_.EventID -eq "4732" -and
        $_.TargetUsername -eq $newacc -and
        $_.ParsedTime -gt $time -and
        $_.ParsedTime -lt $time.AddMinutes(10)
    }

    foreach ($group in $groups) {

        $isPrivl = $group.GroupName -like "*admin*"
        $isoffhrs = ($time.Hour -lt 6) -or ($time.Hour -ge 20)

        if ($isPrivl) {

            $flag = if ($isoffhrs) { "HIGH" } else { "MEDIUM" }
            $color = if ($isoffhrs) { "Red" } else { "Yellow" }

            Write-Host "SUSPICIOUS ACCOUNT CREATION [$flag]" -ForegroundColor $color
            Write-Host "New account    : $newacc"
            Write-Host "Created by     : $($user.SubjectUserName)"
            Write-Host "Created at     : $time"
            Write-Host "Added to       : $($group.GroupName)"
            Write-Host "Time to escalate: $([math]::Round(($group.ParsedTime - $time).TotalMinutes, 1)) min"
            Write-Host "Off hours?     : $isoffhrs"
            Write-Host "-----------------------------"
        }
    }
}

