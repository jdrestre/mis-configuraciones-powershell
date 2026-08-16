# Module HealthCheck (pwsh-health)

function pwsh-health {
    Write-Host "`nAuditando la salud del entorno PowerShell..." -ForegroundColor Cyan
    Write-Host "--------------------------------------------------------" -ForegroundColor Gray

    # 1. PowerShell Version
    Write-Host "  * Edicion de PowerShell : " -NoNewline
    Write-Host "$($PSVersionTable.PSVersion) ($($PSVersionTable.PSEdition))" -ForegroundColor Green

    # 2. Execution Policy
    $policy = Get-ExecutionPolicy
    Write-Host "  * Politica de Ejecucion  : " -NoNewline
    if ($policy -match "RemoteSigned|Unrestricted|Bypass") {
        Write-Host "$policy" -ForegroundColor Green
    } else {
        Write-Host "$policy (Se recomienda RemoteSigned)" -ForegroundColor Yellow
    }

    # 3. Git for Windows
    Write-Host "  * Git for Windows        : " -NoNewline
    if (Get-Command git -ErrorAction SilentlyContinue) {
        $gitVer = git --version
        Write-Host "$gitVer" -ForegroundColor Green
    } elseif (Test-Path 'C:\Program Files\Git\cmd\git.exe') {
        Write-Host "Instalado en C:\Program Files\Git\cmd\git.exe" -ForegroundColor Green
    } else {
        Write-Host "No instalado / No en PATH" -ForegroundColor Red
    }

    # 4. Oh My Posh
    Write-Host "  * Oh My Posh Engine      : " -NoNewline
    if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
        $ompVer = oh-my-posh version
        Write-Host "v$ompVer" -ForegroundColor Green
    } else {
        Write-Host "No instalado / No en PATH" -ForegroundColor Red
    }

    # 5. Terminal-Icons
    Write-Host "  * Modulo Terminal-Icons  : " -NoNewline
    if (Get-Module -ListAvailable -Name Terminal-Icons) {
        Write-Host "Instalado" -ForegroundColor Green
    } else {
        Write-Host "No instalado" -ForegroundColor Yellow
    }

    # 6. SSH GitHub Test
    Write-Host "  * Conexion SSH a GitHub  : " -NoNewline
    try {
        $sshTest = & ssh -i "$HOME\.ssh\id_ed25519" -o ConnectTimeout=5 -o StrictHostKeyChecking=no git@github.com 2>&1
        if ($sshTest -match "successfully authenticated") {
            Write-Host "Autenticado Exitosamente" -ForegroundColor Green
        } else {
            Write-Host "Permiso Denegado / Clave no registrada" -ForegroundColor Red
        }
    } catch {
        Write-Host "Error al probar conexion SSH" -ForegroundColor Red
    }

    Write-Host "--------------------------------------------------------`n" -ForegroundColor Gray
}

Set-Alias -Name health -Value pwsh-health -ErrorAction SilentlyContinue
