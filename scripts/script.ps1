# 1 - Solicitar permisos de administrador
if (-not ([System.Security.Principal.WindowsPrincipal] [System.Security.WindowsIdentity]::GetCurrent()).IsInRole("Administrador")) {
    Write-Host "El script necesita permisos de administrador"
    Start-Process powershell -ArgumentList "-NoExit", "-File", $PSCommandPath -Verb RunAs
}
