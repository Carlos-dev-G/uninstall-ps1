# Ejecutar como administrador
$app = "Microsoft.BingWeather"

Get-AppxPackage -AllUsers -Name $app | Remove-AppxPackage
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like "$app*" | ForEach-Object {
    Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName
}

Write-Host "La aplicación 'El Tiempo' ha sido desinstalada."
