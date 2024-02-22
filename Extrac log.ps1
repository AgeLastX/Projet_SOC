Connect-ExchangeOnline

#################### EXTRACT LOGS ##########################
$hostname = $env:COMPUTERNAME
$currentDate = Get-Date -Format "yyyy-MM-dd"

$excelFileName = "Extraclogs_${hostname}_$currentDate.xlsx"
$excelFilePath = Join-Path -Path "C:\Scripts" -ChildPath $excelFileName

$events = Get-WinEvent -LogName "Application" -MaxEvents 1000

$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false 

$workbook = $excel.Workbooks.Add()
$worksheet = $workbook.Worksheets.Item(1)
$worksheet.Cells.Item(1, 1) = "Temps"
$worksheet.Cells.Item(1, 2) = "Niveau"
$worksheet.Cells.Item(1, 3) = "Source"
$worksheet.Cells.Item(1, 4) = "ID de l'événement"
$worksheet.Cells.Item(1, 5) = "Message"

$row = 2
foreach ($event in $events) {
    $worksheet.Cells.Item($row, 1) = $event.TimeGenerated
    $worksheet.Cells.Item($row, 2) = $event.LevelDisplayName
    $worksheet.Cells.Item($row, 3) = $event.ProviderName
    $worksheet.Cells.Item($row, 4) = $event.Id
    $worksheet.Cells.Item($row, 5) = $event.Message
    $row++
}

$workbook.SaveAs($excelFilePath)

$excel.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel)

$Outlook = New-Object -ComObject Outlook.Application
$MailItem = $Outlook.CreateItem(0)

#################### MAIL ##########################
$MailItem.Subject = "Save_$currentDate"
$MailItem.To = "7b4cedce.olaqin.fr@fr.teams.ms"  

$Username = $env:USERNAME
$DateInfo = Get-Date
$MachineName = $env:COMPUTERNAME

$MailItem.Body += "Nom de l'utilisateur : $Username`r`n"
$MailItem.Body += "Date : $DateInfo`r`n"
$MailItem.Body += "Machine : $MachineName`r`n"

$ScriptDirectory = Get-Location
$Attachment1 = Join-Path $ScriptDirectory "Extraclogs_${hostname}_$currentDate.xlsx"

$MailItem.Attachments.Add($Attachment1)
$MailItem.Send()
