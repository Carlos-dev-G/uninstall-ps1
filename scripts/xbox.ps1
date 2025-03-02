# Ejecutar como administrador
$apps = @("Microsoft.XboxApp", "Microsoft.GamingServices", "Microsoft.Xbox.TCUI", "Microsoft.XboxGameOverlay", "Microsoft.XboxGamingOverlay", "Microsoft.XboxIdentityProvider", "Microsoft.XboxSpeechToTextOverlay")

foreach ($app in $apps) {
    Get-AppxPackage -AllUsers -Name $app | Remove-AppxPackage
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like "$app*" | ForEach-Object {
        Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName
    }
}

Write-Host "Todas las aplicaciones de Xbox han sido desinstaladas."
