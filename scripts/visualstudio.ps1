$vsInstallerPath = "C:\Program Files (x86)\Microsoft Visual Studio\Installer\vs_installer.exe"

if (Test-Path $vsInstallerPath) {
    $installedProducts = & $vsInstallerPath list --quiet
    $vsProducts = $installedProducts | Where-Object { $_ -like "*Visual Studio*" }

    if ($vsProducts.Count -gt 0) {
        foreach ($product in $vsProducts) {
            & $vsInstallerPath uninstall --product-id $product --quiet --remove-all
        }
    }
}
