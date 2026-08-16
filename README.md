# ⚡ Mis Configuraciones PowerShell (`powershell-custom`)

¡Bienvenido a la suite personalizada, modular y 100% automatizada de **Windows PowerShell**!

Este repositorio contiene las configuraciones, utilidades, alias, autocompletado avanzado y temas visuales para **PowerShell Core (`pwsh`)** y **Windows PowerShell**, estructurados bajo las mejores prácticas de Microsoft y [ohmyposh.dev](https://ohmyposh.dev/).

---

## ⚡ Instalación en 2 Pasos Sencillos (Desde la Raíz de Usuario)

No necesitas recordar rutas complejas ni crear carpetas a mano. Cuando estés en cualquier computador nuevo con Windows 11, colócate en la carpeta raíz de tu usuario (`C:\Users\<TuUsuario>`) y sigue estos 2 pasos:

### 1️⃣ Paso 1: Clonar el repositorio
```powershell
git clone git@github.com:jdrestre/mis-configuraciones-powershell.git
```

### 2️⃣ Paso 2: Ejecutar el instalador automático
```powershell
.\mis-configuraciones-powershell\bootstrap.ps1
```

---

## 🧭 ¿Qué hace el instalador `bootstrap.ps1` automáticamente?

Una vez ejecutas `bootstrap.ps1`, el script toma el control y realiza todo de forma transparente:

1. **Relocalización Automática de Carpetas**: Detecta si estás ejecutando el script desde la raíz o desde la descarga inicial, crea la carpeta `.config` y mueve/ubica el repositorio en `$HOME\.config\powershell-custom`.
2. **Auto-instalación de Requisitos**: Instala **Git for Windows**, **Oh My Posh** o **Terminal-Icons** usando `winget` e `Install-Module` si no están en el equipo.
3. **Respaldo y Vinculación Novedosa de Perfil**: Detecta dónde está el `$PROFILE` nativo del sistema (OneDrive o Documentos local), crea un respaldo `.bak` si existía un perfil viejo y configura el puente hacia el perfil maestro.
4. **Habilitación de Políticas de Ejecución**: Configura `ExecutionPolicy RemoteSigned` automáticamente para evitar bloqueos de scripts.

---

## 🔑 Autenticación SSH con GitHub (Sin Contraseña)

Para poder realizar `git push` y `git pull` sin ingresar credenciales:

1. **Generar Clave SSH (Si el equipo no tiene una)**:
   ```powershell
   ssh-keygen -t ed25519 -C "jdrestre79@gmail.com"
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

## 🛠️ Herramienta de Salud y Diagnóstico (`pwsh-health`)

En cualquier momento puedes auditar el estado y la velocidad de tu terminal ejecutando:

```powershell
pwsh-health
```

---
*Desarrollado y mantenido por jdrestre.*
