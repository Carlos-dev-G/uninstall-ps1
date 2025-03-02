# Ejecutar como administrador
$app = "Microsoft.MixedReality.Portal"

# Desinstalar la aplicación para el usuario actual
Get-AppxPackage -AllUsers -Name $app | Remove-AppxPackage

# Eliminar la aplicación provisionada para nuevos usuarios
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like "$app*" | ForEach-Object {
    Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName
}

Write-Host "La aplicación 'Portal de Realidad Mixta' ha sido desinstalada."
