# Bootstrap Script for powershell-custom (Dynamic Location & Dual Profile Binding)

[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

Write-Host "Iniciando Aprovisionamiento de PowerShell Dotfiles..." -ForegroundColor Cyan

# 1. Execution Policy Configuration for CurrentUser
try {
    $currentPolicy = Get-ExecutionPolicy -Scope CurrentUser
    if ($currentPolicy -notmatch "RemoteSigned|Unrestricted|Bypass") {
        Write-Host "Configurando ExecutionPolicy a RemoteSigned en CurrentUser..." -ForegroundColor Yellow
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force -ErrorAction SilentlyContinue
    }
} catch {
    # Continuar de forma defensiva si no se puede cambiar
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

# 6. Dual Profile Binding (Windows PowerShell 5.1 & PowerShell Core 7+)
$profileTargets = @(
    "$HOME\OneDrive\Documentos\WindowsPowerShell\Microsoft.PowerShell_profile.ps1",
    "$HOME\OneDrive\Documentos\PowerShell\Microsoft.PowerShell_profile.ps1",
    "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1",
    "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
)

$shim = "# Cargador shim powershell-custom`nif (Test-Path '$configProfilePath') { . '$configProfilePath' }"

foreach ($targetPath in $profileTargets) {
    $parentDir = Split-Path -Parent -Path $targetPath
    if (Test-Path -Path $parentDir) {
        # Respaldar si el archivo existe y no tiene el shim
        if (Test-Path -Path $targetPath) {
            $existingContent = Get-Content -Path $targetPath -Raw -ErrorAction SilentlyContinue
            if ($existingContent -and ($existingContent -notmatch "powershell-custom")) {
                $backupPath = "$targetPath.bak.$(Get-Date -Format 'yyyyMMddHHmmss')"
                Write-Host "Creando copia de seguridad en $backupPath..." -ForegroundColor Yellow
                Copy-Item -Path $targetPath -Destination $backupPath -Force
            }
        }
        Set-Content -Path $targetPath -Value $shim -Encoding UTF8
        Write-Host "Perfil vinculado correctamente en: $targetPath" -ForegroundColor Green
    }
}

Write-Host "Apuntando dinamicamente a: $configProfilePath" -ForegroundColor Cyan
Write-Host "Aprovisionamiento completado con exito. Abre una nueva terminal para disfrutar de tu entorno." -ForegroundColor Green
