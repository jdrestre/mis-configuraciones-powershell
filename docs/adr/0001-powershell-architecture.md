# 1. Ubicación Estándar XDG y Arquitectura Modular de Dotfiles en PowerShell

* **Estado**: Aprobado 🟢
* **Fecha**: 2026-08-15
* **Autores**: Juan David Restrepo (`jdrestre`) & Antigravity Assistant

## Contexto y Problema

Anteriormente, la configuración de PowerShell en el equipo residía directamente en un solo archivo monolítico dentro de la carpeta de OneDrive (`C:\Users\jdres\OneDrive\Documentos\PowerShell\Microsoft.PowerShell_profile.ps1`). 

Esto presentaba tres inconvenientes:
1. Propenso a errores al no estar modularizado ni probado defensivamente.
2. Conflictos de sincronización potenciales con OneDrive al almacenar repositorios Git dentro de carpetas sincronizadas en la nube.
3. Falta de portabilidad limpia para clonar la configuración en nuevas máquinas con Windows 11.

## Decisión de Arquitectura

1. **Ubicación Centralizada del Repositorio**: Se define `C:\Users\jdres\.config\powershell-custom` (siguiendo el estándar XDG Base Directory) como la ubicación exclusiva del repositorio Git de dotfiles.
2. **Cargador Maestro en `$PROFILE`**: El archivo oficial `$PROFILE` en OneDrive solo actuará como un *bootstrap shim* liviano que invoca `C:\Users\jdres\.config\powershell-custom\Profile.ps1`.
3. **Desacoplamiento Modular**: Las responsabilidades se dividen en módulos dentro de `modules/` (`Aliases.ps1`, `Autocomplete.ps1`, `Environment.ps1`, `HealthCheck.ps1`).
4. **Programación Defensiva**: La carga de cualquier módulo (Terminal-Icons, PSReadLine, Oh My Posh) se envuelve en chequeos previos con `Get-Command` o `Get-Module` para garantizar 0 errores en pantalla.

## Consecuencias y Beneficios

* **Rendimiento**: Carga del perfil ultra rápida (< 100ms).
* **Seguridad**: Identidad de Git y claves SSH permanecen aisladas en el sistema de archivos local (`$HOME\.gitconfig` y `$HOME\.ssh\`).
* **Portabilidad**: Despliegue en 1 solo comando en cualquier máquina nueva mediante `bootstrap.ps1`.
