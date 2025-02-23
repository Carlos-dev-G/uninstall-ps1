# Verificar si el script se ejecuta con privilegios de administrador
$adminRole = [System.Security.Principal.WindowsPrincipal][System.Security.WindowsIdentity]::GetCurrent()
if (-not ($adminRole.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator))) {
    Write-Host "El script necesita permisos de administrador"
    Start-Process powershell -ArgumentList "-NoExit", "-File", $PSCommandPath -Verb RunAs
    exit
}
