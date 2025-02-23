<#
INDICE DE SECCIONES:
1. Configuracion de colores
2. Variables globales
3. Funciones principales
4. Verificacion de permisos
5. Flujo de desinstalacion
6. Salida controlada
#>

# 1. Configuracion de colores
$ColorTheme = @{
    Success    = @{Foreground = "Green"; Background = "Black"}
    Error      = @{Foreground = "Red"; Background = "Black"}
    Warning    = @{Foreground = "Yellow"; Background = "Black"}
    Info       = @{Foreground = "Cyan"; Background = "Black"}
    Header     = @{Foreground = "White"; Background = "DarkBlue"}
    Progress   = @{Foreground = "Magenta"; Background = "Black"}
    Default    = @{Foreground = "White"; Background = "Black"}
}

# 2. Variables globales
$EDGE_DIR = Join-Path ${env:ProgramFiles(x86)} "Microsoft\Edge\Application\"
$USER_PROFILE = [System.Environment]::GetFolderPath('UserProfile')
$REGISTROS = @(
    "HKLM:\SOFTWARE\Microsoft\Edge",
    "HKLM:\SOFTWARE\Microsoft\EdgeUpdate",
    "HKLM:\SOFTWARE\Policies\Microsoft\Edge",
    "HKCU:\SOFTWARE\Microsoft\Edge",
    "HKCU:\SOFTWARE\Microsoft\EdgeUpdate"
)
$RUTAS = @(
    "C:\Program Files (x86)\Microsoft\Edge",
    "$USER_PROFILE\AppData\Local\Microsoft\Edge",
    "$USER_PROFILE\AppData\Local\Microsoft\EdgeUpdate"
)

# 3. Funciones principales
function MostrarMensaje {
    param(
        [string]$TipoMensaje,
        [string]$Texto
    )
    $colors = $ColorTheme[$TipoMensaje]
    Write-Host $Texto -ForegroundColor $colors.Foreground -BackgroundColor $colors.Background
}

function LimpiarPantalla {
    param ([string]$mensaje, [string]$tipo = "Default")
    Clear-Host
    MostrarMensaje -TipoMensaje $tipo -Texto "`n$mensaje`n"
}

function CuentaRegresiva {
    param (
        [string]$mensajeBase,
        [int]$segundos,
        [string]$tipo = "Progress"
    )
    for ($i = $segundos; $i -gt 0; $i--) {
        LimpiarPantalla -mensaje "$mensajeBase`nFaltan $i segundos..." -tipo $tipo
        Start-Sleep -Seconds 1
    }
}

# 4. Verificacion de permisos
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    MostrarMensaje -TipoMensaje "Error" -Texto "EJECUTAR COMO ADMINISTRADOR"
    Exit
}

# 5. Flujo de desinstalacion
try {
    LimpiarPantalla -mensaje "=== DESINSTALADOR DE MICROSOFT EDGE ===" -tipo "Header"
    
    # Detener procesos
    MostrarMensaje -TipoMensaje "Warning" -Texto "DETENIENDO PROCESOS..."
    Get-Process msedge*, edge* -ErrorAction SilentlyContinue | Stop-Process -Force
    
    # Ejecutar desinstalador
    if (Test-Path "$EDGE_DIR\Installer\setup.exe") {
        Set-Location "$EDGE_DIR\Installer"
        Start-Process -FilePath .\setup.exe -ArgumentList "--uninstall --system-level --force-uninstall" -Wait
        CuentaRegresiva -mensajeBase "Finalizando desinstalador" -segundos 5 -tipo "Progress"
    }
    
    # Eliminar registros
    LimpiarPantalla -mensaje "ELIMINANDO REGISTROS..." -tipo "Warning"
    $REGISTROS | ForEach-Object { 
        if (Test-Path $_) { Remove-Item $_ -Recurse -Force } 
    }
    
    # Eliminar archivos
    LimpiarPantalla -mensaje "ELIMINANDO ARCHIVOS RESIDUALES..." -tipo "Warning"
    $RUTAS | ForEach-Object { 
        if (Test-Path $_) { Remove-Item $_ -Recurse -Force } 
    }
}
catch { 
    MostrarMensaje -TipoMensaje "Error" -Texto "ERROR CRITICO: $($_.Exception.Message)"
    Exit 1
}

# 6. Salida controlada
$EdgeInstalado = Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe"

if (-not $EdgeInstalado) {
    LimpiarPantalla -mensaje "DESINSTALACION COMPLETADA CON EXITO" -tipo "Success"
    CuentaRegresiva -mensajeBase "Saliendo del programa" -segundos 4 -tipo "Info"
    
    # Mensaje final
    MostrarMensaje -TipoMensaje "Header" -Texto "== RECOMENDACION =="
    MostrarMensaje -TipoMensaje "Info" -Texto "Ejecuta una limpieza con herramientas como:"
    MostrarMensaje -TipoMensaje "Progress" -Texto "1. CCleaner"
    MostrarMensaje -TipoMensaje "Progress" -Texto "2. Wise Disk Cleaner"
    MostrarMensaje -TipoMensaje "Progress" -Texto "3. BleachBit"
    
    CuentaRegresiva -mensajeBase "Cerrando automaticamente" -segundos 5 -tipo "Progress"
}
else {
    MostrarMensaje -TipoMensaje "Error" -Texto "FALLO LA DESINSTALACION!"
    Exit 1
}