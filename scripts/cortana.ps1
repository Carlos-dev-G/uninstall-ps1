# Desinstalar Cortana para el usuario actual
Get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage

# Desinstalar Cortana para todos los usuarios (opcional)
Get-AppxPackage -AllUsers *Microsoft.549981C3F5F10* | Remove-AppxPackage
