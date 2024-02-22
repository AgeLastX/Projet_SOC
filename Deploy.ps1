$dossierScriptsBureau = "C:\Users\$env:USERNAME\Bureau\Projet_SOC-main"

$nouvelEmplacement = "C:\"

Move-Item -Path $dossierScriptsBureau -Destination $nouvelEmplacement -Force

$dossierDeplace = Join-Path $nouvelEmplacement "Projet_SOC-main"

Rename-Item -Path $dossierDeplace -NewName "Scripts" -Force


#ENROLEMENT
$script1 = "C:\Scripts\enrol.ps1"
#Logs Extract
$script2 = "C:\Scripts\task_log.ps1"
#Dump memory
$script3 = "C:\Scripts\task_memory.ps1.ps1"

Set-Location -Path "C:\Scripts"

& $script1
& $script2
& $script3
