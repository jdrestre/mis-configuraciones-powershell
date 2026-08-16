# Bootstrap Script for powershell-custom (Dynamic Location Architecture)

[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

Write-Host "Iniciando Aprovisionamiento de PowerShell Dotfiles..." -ForegroundColor Cyan

# 1. Execution Policy
$currentPolicy = Get-ExecutionPolicy
if ($currentPolicy -notmatch "RemoteSigned|Unrestricted|Bypass") {
    Write-Host "Configurando ExecutionPolicy a RemoteSigned..." -ForegroundColor Yellow
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
}

# 2. Git for Windows Check
if (-not (Get-Command git -ErrorAction SilentlyContinue) -and -not (Test-Path 'C:\Program Files\Git\cmd\git.exe')) {
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "Instalando Git for Windows via Winget..." -ForegroundColor Yellow
        winget install --id Git.Git -e --source winget --accept-source-agreements --accept-package-agreements
    }
}

# 3. Oh My Posh Engine Check
if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "Instalando Oh My Posh via Winget..." -ForegroundColor Yellow
        winget install JanDeDobbeleer.OhMyPosh -s winget --accept-source-agreements --accept-package-agreements
    }
}

# 4. Terminal-Icons Module Check
if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
    try {
        Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted -ErrorAction SilentlyContinue
        Write-Host "Instalando el modulo Terminal-Icons..." -ForegroundColor Yellow
        Install-Module -Name Terminal-Icons -Scope CurrentUser -Force -AllowClobber
    } catch {
        Write-Warning "No se pudo instalar Terminal-Icons automaticamente."
    }
}

# 5. Dynamic Repository Location ($PSScriptRoot)
$scriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$configProfilePath = Join-Path $scriptDir "Profile.ps1"

# 6. Profile Binding
$userProfilePath = if ($PROFILE) { $PROFILE } else { "$HOME\OneDrive\Documentos\PowerShell\Microsoft.PowerShell_profile.ps1" }
$userProfileDir = Split-Path -Parent -Path $userProfilePath

if (-not (Test-Path -Path $userProfileDir)) {
    New-Item -ItemType Directory -Path $userProfileDir -Force | Out-Null
}

if (Test-Path -Path $userProfilePath) {
    $existingContent = Get-Content -Path $userProfilePath -Raw -ErrorAction SilentlyContinue
    if ($existingContent -and ($existingContent -notmatch "powershell-custom")) {
        $backupPath = "$userProfilePath.bak.$(Get-Date -Format 'yyyyMMddHHmmss')"
        Write-Host "Creando copia de seguridad del perfil en $backupPath..." -ForegroundColor Yellow
        Copy-Item -Path $userProfilePath -Destination $backupPath -Force
    }
}

# Write Dynamic Shim Loader
$shim = "# Cargador shim powershell-custom`nif (Test-Path '$configProfilePath') { . '$configProfilePath' }"
Set-Content -Path $userProfilePath -Value $shim -Encoding UTF8

Write-Host "Perfil vinculado dinamicamente en: $userProfilePath" -ForegroundColor Green
Write-Host "Apuntando directamente a: $configProfilePath" -ForegroundColor Cyan
Write-Host "Aprovisionamiento completado con exito." -ForegroundColor Green
