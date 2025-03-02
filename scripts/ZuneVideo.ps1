# Ejecutar como administrador
$app = "Microsoft.ZuneVideo"

Get-AppxPackage -AllUsers -Name $app | Remove-AppxPackage

Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like "$app*" | ForEach-Object {
    Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName
}

Write-Host "La aplicación 'Películas y TV' ha sido desinstalada."
