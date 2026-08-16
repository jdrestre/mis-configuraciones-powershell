# ==============================================================================
# 🎯 PERFIL MAESTRO DE POWERSHELL (`mis-configuraciones-powershell`)
# ==============================================================================
# Autores: Juan David Restrepo (jdrestre)
# ==============================================================================

# Evitar recarga innecesaria si ya se ejecutó en la misma sesión
if ($env:PWSH_CUSTOM_LOADED -eq 'true') { return }
$env:PWSH_CUSTOM_LOADED = 'true'

# Determinar la carpeta raíz del repositorio de forma robusta
if ($PSScriptRoot) {
    $script:ConfigRoot = $PSScriptRoot
} elseif ($MyInvocation.MyCommand.Definition) {
    $script:ConfigRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
} else {
    $script:ConfigRoot = "$HOME\mis-configuraciones-powershell"
}

# Cargador modular defensivo
$modulesToLoad = @(
    "Environment.ps1",
    "Autocomplete.ps1",
    "Aliases.ps1",
    "GitUtils.ps1",
    "HealthCheck.ps1"
)

foreach ($module in $modulesToLoad) {
    $modulePath = Join-Path $script:ConfigRoot "modules\$module"
    if (Test-Path $modulePath) {
        try {
            . $modulePath
        } catch {
            Write-Warning "No se pudo cargar el módulo: $module. Error: $_"
        }
    }
}

# Inicializar Oh My Posh de forma defensiva
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    $themePath = Join-Path $script:ConfigRoot "config\oh-my-posh-theme.json"
    if ((Test-Path $themePath) -and ((Get-Item $themePath).Length -gt 0)) {
        oh-my-posh init pwsh --config $themePath | Invoke-Expression
    } else {
        oh-my-posh init pwsh --config pure | Invoke-Expression
    }
}

# Inicializar Terminal-Icons de forma defensiva
if (Get-Module -ListAvailable -Name Terminal-Icons) {
    try {
        Import-Module Terminal-Icons -ErrorAction SilentlyContinue
    } catch {
        # Silently ignore if fails
    }
}
