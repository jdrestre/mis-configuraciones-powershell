# 🤖 AGENTS.md — Guardarraíles y Memoria de Arquitectura para IA (PowerShell Dotfiles)

---

## 🎯 1. Misión del Entorno
Mantener y desplegar un entorno de PowerShell (`pwsh` / `powershell.exe`) altamente productivo, estético y portable en Windows 11, basado en **Oh My Posh**, **PSReadLine** y **Terminal-Icons**, permitiendo su restauración completa en cualquier máquina en menos de 2 minutos.

---

## 🗺️ 2. Mapa del Directorio `mis-configuraciones-powershell`

El repositorio reside localmente en la ubicación elegida por el usuario (por defecto `C:\Users\jdres\mis-configuraciones-powershell\`, remoto `git@github.com:jdrestre/mis-configuraciones-powershell.git`).

- **`Profile.ps1`**: Perfil maestro cargado desde `$PROFILE`.
- **`config/`**: `oh-my-posh-theme.json` (Tema de Oh My Posh optimizado).
- **`modules/`**:
  - `Aliases.ps1`: Alias personalizados y funciones de ayuda (`supd`, `py`, `gcheck`, etc.).
  - `Autocomplete.ps1`: Configuración defensiva de PSReadLine (ListView + History Predictor).
  - `Environment.ps1`: Variables de entorno (`$env:COLORTERM`, UTF-8, etc.).
  - `HealthCheck.ps1`: Auditoría de salud ejecutada con el comando `pwsh-health`.
- **`bootstrap.ps1`**: Script de aprovisionamiento automatizado dinámico ($PSScriptRoot).
- **`docs/adr/`**: Registro Histórico de Decisiones de Arquitectura (ADR).

---

## 🛡️ 3. Guardarraíles Inviolables para Asistentes de Código (AI Code Rules)

Cualquier agente de IA o desarrollador que modifique este repositorio **DEBE** respetar estrictamente los siguientes guardarraíles:

1. **Guardarraíl 1 (Programación Defensiva en Módulos)**:
   - Todo módulo o función cargado en `$PROFILE` debe comprobar la existencia de comandos y módulos externos con `Get-Command` o `Get-Module -ListAvailable` antes de invocarlos.
   - Usar fallbacks limpios para evitar cualquier mensaje de error rojo en la consola durante el inicio de sesión.

2. **Guardarraíl 2 (Privacidad de Identidad Git & SSH)**:
   - Datos personales sensibles (`user.email`, `user.name`, llaves privadas SSH/GPG) **NUNCA** se versionan en Git.
   - Residen exclusivamente en los archivos locales del sistema (`C:\Users\jdres\.gitconfig` y `C:\Users\jdres\.ssh\`).

3. **Guardarraíl 3 (Preservar Ubicación Dinámica PSScriptRoot)**:
   - `bootstrap.ps1` **NUNCA** debe forzar copias ni mover carpetas a rutas rígidas. Debe resolver la ubicación del repositorio dinámicamente usando `$PSScriptRoot` para evitar duplicados en el disco duro.

4. **Guardarraíl 4 (Vinculación Dual de Perfiles)**:
   - `bootstrap.ps1` debe asegurar la vinculación del perfil en **ambas ediciones de PowerShell** (Windows PowerShell 5.1 y PowerShell Core 7+) para garantizar el soporte multiplataforma en cualquier consola de Windows.

5. **Guardarraíl 5 (Cero Excepciones en Perfil)**:
   - El archivo `Profile.ps1` debe capturar posibles errores de carga sin interrumpir la sesión interactiva del usuario.

6. **Guardarraíl 6 (Tiempo de Inicio Ultra Rápido)**:
   - Mantener el tiempo de carga total del perfil por debajo de **100ms**.

7. **Guardarraíl 7 (Commits en Español)**:
   - Todos los mensajes de commit en Git y los registros ADR deben redactarse profesionalmente en **español**.

---

## 📚 4. Historial de Decisiones de Arquitectura (ADR)

- [ADR 0001: Ubicación Estándar XDG en `~/.config/powershell-custom`](file:///C:/Users/jdres/mis-configuraciones-powershell/docs/adr/0001-powershell-architecture.md)
- [ADR 0002: Reubicación Automática del Repositorio vía Bootstrap y Flujo de 2 Pasos](file:///C:/Users/jdres/mis-configuraciones-powershell/docs/adr/0002-bootstrap-auto-relocation.md)
- [ADR 0003: Arquitectura de Ubicación Dinámica (Opción 1 - Cero Duplicados)](file:///C:/Users/jdres/mis-configuraciones-powershell/docs/adr/0003-dynamic-location-architecture.md)
- [ADR 0004: Vinculación Dual de Perfiles (Windows PowerShell 5.1 y PowerShell Core 7+)](file:///C:/Users/jdres/mis-configuraciones-powershell/docs/adr/0004-dual-powershell-profile-binding.md)
