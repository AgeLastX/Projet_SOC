$scriptPath = "C:\Scripts\Memory_dump.ps1"
$taskAction = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument $scriptPath
$taskTrigger = New-ScheduledTaskTrigger -At 9am -Once -RepetitionDuration (New-TimeSpan -Days 999) -RepetitionInterval (New-TimeSpan -Hours 1)
$taskUser = "NT AUTHORITY\SYSTEM"
$taskName = "Dump Memory"

if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
} else {
    Register-ScheduledTask -Action $taskAction -Trigger $taskTrigger -User $taskUser -TaskName $taskName -Force
}