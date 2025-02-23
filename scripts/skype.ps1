# Cerrar Skype si está en ejecución
taskkill /F /IM Skype.exe /T 2> $null

# Desinstalar Skype para usuarios actuales
Get-AppxPackage *Skype* | Remove-AppxPackage

# Desinstalar Skype para todos los usuarios (opcional)
Get-AppxPackage -AllUsers *Skype* | Remove-AppxPackage

# Eliminar carpetas residuales
Remove-Item "$env:APPDATA\Skype" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:LOCALAPPDATA\Microsoft\Skype" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:PROGRAMFILES\Skype" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:PROGRAMFILES(X86)\Skype" -Recurse -Force -ErrorAction SilentlyContinue

# Eliminar claves de registro de Skype
reg delete "HKCU\Software\Skype" /f 2> $null
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Skype" /f 2> $null

Write-Host "Skype ha sido desinstalado correctamente."
