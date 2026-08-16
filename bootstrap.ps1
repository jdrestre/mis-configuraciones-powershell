# Bootstrap Script for powershell-custom

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

# 2. Terminal-Icons Check
if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
    Write-Host "Instalando el modulo Terminal-Icons..." -ForegroundColor Yellow
    Install-Module -Name Terminal-Icons -Scope CurrentUser -Force -AllowClobber
}

# 3. Profile Binding
$configProfilePath = "$HOME\.config\powershell-custom\Profile.ps1"
$userProfilePath = "$HOME\OneDrive\Documentos\PowerShell\Microsoft.PowerShell_profile.ps1"

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

$shim = "# Cargador shim powershell-custom`nif (Test-Path '$configProfilePath') { . '$configProfilePath' }"
Set-Content -Path $userProfilePath -Value $shim -Encoding UTF8

Write-Host "Perfil vinculado correctamente en: $userProfilePath" -ForegroundColor Green
Write-Host "Aprovisionamiento completado con exito." -ForegroundColor Green
