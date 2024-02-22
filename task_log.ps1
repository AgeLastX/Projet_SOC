$scriptPath = "C:\Scripts\Extrac log.ps1"
$taskAction = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument $scriptPath
$taskTrigger = New-ScheduledTaskTrigger -Daily -At 9am
$taskUser = "NT AUTHORITY\SYSTEM"
$taskName = "Extraclog"

if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
} else {
    Register-ScheduledTask -Action $taskAction -Trigger $taskTrigger -User $taskUser -TaskName $taskName -Force
}

