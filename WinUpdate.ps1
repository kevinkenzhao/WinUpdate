[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -ErrorAction SilentlyContinue
Stop-Service -Name "wuauserv"
Start-Sleep -Seconds 15
DISM /Online /Cleanup-Image /RestoreHealth
Remove-Item -Recurse -Force "C:\Windows\SoftwareDistribution\" #remove Windows Updates in the event of corruption
Start-Service -Name "wuauserv"
Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module PSWindowsUpdate
Get-WindowsUpdate
Install-WindowsUpdate -AcceptAll -Install -IgnoreReboot | Out-File "C:\temp\WindowsUpdate-$(get-date -f yyyy-MM-dd).log" -force