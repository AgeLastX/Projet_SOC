$dossierScriptsBureau = "C:\Users\$env:USERNAME\Bureau\Projet_SOC-main"

$nouvelEmplacement = "C:\"

Move-Item -Path $dossierScriptsBureau -Destination $nouvelEmplacement -Force

$dossierDeplace = Join-Path $nouvelEmplacement "Projet_SOC-main"

Rename-Item -Path $dossierDeplace -NewName "Scripts" -Force


#ENROLEMENT
$script1 = "C:\Scripts\enrole.ps1"
#Logs Extract
$script2 = "C:\Scripts\Extrac log.ps1"
#Dump memory
$script3 = "C:\Scripts\Script2.ps1"

Set-Location -Path "C:\Scripts"

& $script1
& $script2
& $script3