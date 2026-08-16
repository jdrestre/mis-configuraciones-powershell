# Módulo de Entorno y Variables de Configuración

# Soporte de Color de 24 bits (True Color)
$env:COLORTERM = 'truecolor'

# Codificación UTF-8 preferida
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Mantener título dinámico de ventana
$Host.UI.RawUI.WindowTitle = "PowerShell - $(Get-Location)"
