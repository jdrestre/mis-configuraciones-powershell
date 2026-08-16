# ⚡ Mis Configuraciones PowerShell (`powershell-custom`)

¡Bienvenido a la suite personalizada y modular de **Windows PowerShell**!

Este repositorio contiene las configuraciones, utilidades, alias, autocompletado avanzado y temas visuales para **PowerShell Core (`pwsh`)** y **Windows PowerShell**, estructurados bajo las mejores prácticas de Microsoft y [ohmyposh.dev](https://ohmyposh.dev/).

---

## 📋 Prerrequisitos de Entorno

Para que PowerShell funcione al 100% de su capacidad sin errores en cualquier equipo con Windows 11, se requiere cumplir con las siguientes herramientas previas:

| Componente | Comando de Instalación / Verificación | Función en la Terminal |
| :--- | :--- | :--- |
| **Git for Windows** | `winget install --id Git.Git -e` | Renderizado de estado de repositorios y soporte SSH/Git. |
| **Oh My Posh** | `winget install JanDeDobbeleer.OhMyPosh -s winget` | Engine visual para el prompt inteligente multilínea. |
| **Terminal-Icons** | `Install-Module Terminal-Icons -Scope CurrentUser` | Inyección de íconos gráficos para carpetas y archivos en `ls`. |
| **Nerd Font** | *CaskaydiaCove Nerd Font* o *FiraCode Nerd Font* | Tipografía con glifos para visualizar íconos sin caracteres rotos. |
| **Politica de Ejecución** | `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser` | Permite la carga del perfil `$PROFILE` de usuario. |

---

## 🔑 Autenticación SSH con GitHub (Portabilidad sin Contraseña)

Para realizar `git push` y `git pull` de forma segura sin ingresar credenciales manualmente:

1. **Generar Clave SSH (Si no existe)**:
   ```powershell
   ssh-keygen -t ed25519 -C "tu_correo@ejemplo.com"
   ```
2. **Copiar Clave Pública al Portapapeles**:
   ```powershell
   Get-Content $HOME\.ssh\id_ed25519.pub | Set-Clipboard
   ```
3. **Registrar en GitHub**:
   * Ir a [https://github.com/settings/keys](https://github.com/settings/keys).
   * Añadir como **`Authentication Key`**.
4. **Validar Conexión**:
   ```powershell
   ssh -T git@github.com
   ```

---

## 💻 Instalación Rápida en un Equipo Nuevo

Si estás configurando un computador nuevo desde cero:

```powershell
# 1. Habilitar ejecución de scripts
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# 2. Clonar este repositorio en la ubicación estándar
New-Item -ItemType Directory -Path "$HOME\.config" -Force
git clone git@github.com:jdrestre/mis-configuraciones-powershell.git "$HOME\.config\powershell-custom"

# 3. Ejecutar el script de aprovisionamiento automatizado
& "$HOME\.config\powershell-custom\bootstrap.ps1"
```

---

## 🛠️ Herramienta de Salud y Diagnóstico (`pwsh-health`)

En cualquier momento puedes auditar el estado y la velocidad de tu terminal ejecutando:

```powershell
pwsh-health
```

---
*Desarrollado y mantenido por jdrestre.*
