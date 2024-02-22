
$defenderEnabled = (Get-MpPreference).DisableRealtimeMonitoring
if ($defenderEnabled -eq $null) {
    $defenderEnabled = $true 
}

$scanResult = Start-MpScan -ScanType QuickScan -ScanPath C:\ -AsJob

Wait-Job $scanResult -Timeout 600

$scanResult = Receive-Job $scanResult

if ($scanResult.DetectedThreats.Count -gt 0) {
    $dateStamp = Get-Date -Format "yyyyMMdd"
    $backupFileName = "extracmemory_$dateStamp.raw"
    $backupFilePath = Join-Path -Path $env:TEMP -ChildPath $backupFileName
    
    Start-Process -FilePath "C:\Scripts\winpmem_mini_x64_rc2.exe" -ArgumentList "-o $backupFilePath" -Wait
    #SHAREPOINT
    Install-Module -Name Microsoft.Online.SharePoint.PowerShell -Force -Scope CurrentUser

    Connect-SPOService -Url https://agesoc.sharepoint.com

    $siteUrl = "https://agesoc.sharepoint.com"
    $libraryName = "Documents" 
    $backupFileName = "extracmemory_$dateStamp.raw"
    $backupFilePath = Join-Path -Path $env:TEMP -ChildPath $backupFileName
    $destinationFolder = "Partage"

    Add-SPOFile -Path $backupFilePath -Folder $destinationFolder -Web $siteUrl -DocumentLibrary $libraryName
  
    $fileUrl = "$siteUrl/$libraryName/$destinationFolder/$backupFileName"
    # NOTIFICATION
    $Outlook = New-Object -ComObject Outlook.Application
    $MailItem = $Outlook.CreateItem(0)

    $MailItem.Subject = "Alerte Virus "
    $MailItem.To = "7b4cedce.olaqin.fr@fr.teams.ms"  

    $MachineName = $env:COMPUTERNAME

    $MailItem.Body += "VIRUS detecté par Windows sur la vm : $MachineName`r`n"
    $MailItem.Body += "$fileUrl `r`n"
    $MailItem.Send()

    $Outlook = New-Object -ComObject Outlook.Application
    $MailItem = $Outlook.CreateItem(0)

    $MailItem.Subject = "Alerte Virus "
    $MailItem.To = "support@age-projetm2.atlassian.net"  

    $MailItem.Body += "VIRUS detecté par Windows sur la vm : $MachineName`r`n"
    $MailItem.Body += "$fileUrl `r`n"

    $MailItem.Send()

}

Remove-Job -State Completed -Force

