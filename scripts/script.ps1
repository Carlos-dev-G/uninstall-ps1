# 1 -  verificar permisos de administrador
$isAdmin = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
if (-not $isAdmin.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {

    Write-Host "No tienes permisos de administrador. Intentando ejecutar el script como administrador..."    
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File $PSCommandPath" -Verb RunAs
    exit
}

Write-Host "Tienes permisos de administrador. Continuando con el script..."
