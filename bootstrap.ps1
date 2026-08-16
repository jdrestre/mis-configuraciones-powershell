# 🚀 Script de Aprovisionamiento Automatizado (powershell-custom)

[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

Write-Host "`n🚀 Iniciando el Aprovisionamiento de PowerShell Dotfiles..." -ForegroundColor Cyan

# 1. Verificar/Habilitar Execution Policy
$currentPolicy = Get-ExecutionPolicy
if ($currentPolicy -notmatch "RemoteSigned|Unrestricted|Bypass") {
    Write-Host "⚙️ Configurando ExecutionPolicy a RemoteSigned..." -ForegroundColor Yellow
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
}

# 2. Relocalización Inteligente del Repositorio a $HOME\.config\powershell-custom
$currentScriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$targetDir = "$HOME\.config\powershell-custom"

if ($currentScriptDir -ne $targetDir) {
    Write-Host "📦 Relocalizando el repositorio a la ubicación estándar: $targetDir ..." -ForegroundColor Yellow
    
    $configParent = "$HOME\.config"
    if (-not (Test-Path -Path $configParent)) {
        New-Item -ItemType Directory -Path $configParent -Force | Out-Null
    }
    
    if (Test-Path -Path $targetDir) {
        Write-Host "⚠️ Ya existe una versión anterior en $targetDir. Reemplazando..." -ForegroundColor Yellow
        Remove-Item -Path $targetDir -Recurse -Force
    }
    
    Copy-Item -Path $currentScriptDir -Destination $targetDir -Recurse -Force
    Write-Host "✅ Repositorio relocalizado exitosamente en $targetDir." -ForegroundColor Green
    
    # Continuar la ejecución desde el destino final
    $finalBootstrap = Join-Path $targetDir "bootstrap.ps1"
    Write-Host "🔄 Reanudando aprovisionamiento desde $targetDir ..." -ForegroundColor Cyan
    & $finalBootstrap
    return
}

# 3. Verificar/Instalar Git for Windows
if (-not (Get-Command git -ErrorAction SilentlyContinue) -and -not (Test-Path 'C:\Program Files\Git\cmd\git.exe')) {
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "📦 Instalando Git for Windows via Winget..." -ForegroundColor Yellow
        winget install --id Git.Git -e --source winget --accept-source-agreements --accept-package-agreements
    } else {
        Write-Warning "Winget no está disponible. Por favor instala Git for Windows desde https://git-scm.com/"
    }
}

# 4. Verificar/Instalar Oh My Posh Engine
if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "📦 Instalando Oh My Posh via Winget..." -ForegroundColor Yellow
        winget install JanDeDobbeleer.OhMyPosh -s winget --accept-source-agreements --accept-package-agreements
    } else {
        Write-Warning "Winget no está disponible. Por favor instala Oh My Posh desde https://ohmyposh.dev/"
    }
}

# 5. Verificar/Instalar Módulo Terminal-Icons
if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
    Write-Host "📦 Instalando el módulo Terminal-Icons..." -ForegroundColor Yellow
    Install-Module -Name Terminal-Icons -Scope CurrentUser -Force -AllowClobber
}

# 6. Detectar la ruta del perfil de usuario y realizar la vinculación maestro-shim
$configProfilePath = Join-Path $targetDir "Profile.ps1"

if ($PROFILE) {
    $userProfilePath = $PROFILE
} else {
    $userProfilePath = "$HOME\OneDrive\Documentos\PowerShell\Microsoft.PowerShell_profile.ps1"
}

$userProfileDir = Split-Path -Parent -Path $userProfilePath
if (-not (Test-Path -Path $userProfileDir)) {
    New-Item -ItemType Directory -Path $userProfileDir -Force | Out-Null
}

# Respaldar perfil anterior si existe y no está vinculado a este repo
if (Test-Path -Path $userProfilePath) {
    $existingContent = Get-Content -Path $userProfilePath -Raw -ErrorAction SilentlyContinue
    if ($existingContent -and ($existingContent -notmatch "powershell-custom")) {
        $backupPath = "$userProfilePath.bak.$(Get-Date -Format 'yyyyMMddHHmmss')"
        Write-Host "📦 Creando copia de seguridad del perfil anterior en $backupPath..." -ForegroundColor Yellow
        Copy-Item -Path $userProfilePath -Destination $backupPath -Force
    }
}

# Escribir cargador shim dinámico
$shim = "# Cargador shim powershell-custom`nif (Test-Path '$configProfilePath') { . '$configProfilePath' }"
Set-Content -Path $userProfilePath -Value $shim -Encoding UTF8

Write-Host "✅ Perfil vinculado correctamente en: $userProfilePath" -ForegroundColor Green
Write-Host "🎉 Aprovisionamiento completado con éxito. Reinicia tu terminal o ejecuta '. `$PROFILE'." -ForegroundColor Green
