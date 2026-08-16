# Módulo de Alias Personalizados y Accesos Rápidos

# Alias de Python y Ejecución
Set-Alias -Name py -Value python -ErrorAction SilentlyContinue

# Función para actualizar paquetes del sistema
function supd {
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "🚀 Buscando actualizaciones de paquetes con Winget..." -ForegroundColor Cyan
        winget upgrade --all
    }
}

# Alias para recargar el perfil de PowerShell
function reload-profile {
    $env:PWSH_CUSTOM_LOADED = $null
    if (Test-Path $PROFILE) {
        . $PROFILE
        Write-Host "✨ Perfil de PowerShell recargado correctamente." -ForegroundColor Green
    }
}

Set-Alias -Name rprof -Value reload-profile -ErrorAction SilentlyContinue
