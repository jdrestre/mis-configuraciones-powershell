# 3. Arquitectura de Ubicación Dinámica (Opción 1 - Cero Duplicados)

* **Estado**: Aprobado 🟢
* **Fecha**: 2026-08-16
* **Autores**: Juan David Restrepo (`jdrestre`) & Antigravity Assistant

## Contexto y Problema

Anteriormente, el script de instalación `bootstrap.ps1` intentaba copiar el repositorio a la carpeta `$HOME\.config\powershell-custom`.

Esto generaba dos problemas:
1. **Duplicidad de Carpetas**: La carpeta clonada originalmente en la raíz del usuario quedaba huérfana en el disco duro.
2. **Confusión en Git**: Si el usuario editaba sus archivos dentro de la carpeta clonada en la raíz, los cambios no se veían reflejados en PowerShell porque el sistema leía la copia alojada en `.config`.

## Decisión de Arquitectura

1. **Ubicación Dinámica vía `$PSScriptRoot`**: El script `bootstrap.ps1` obtiene automáticamente la ruta física donde fue clonado el repositorio y conecta el perfil de usuario `$PROFILE` directamente a dicha ubicación.
2. **Cero Duplicados**: El repositorio funciona directamente desde donde el usuario decida clonarlo (por defecto en `C:\Users\<Usuario>\mis-configuraciones-powershell`).
3. **Flujo de 2 Pasos Limpio**:
   - Paso 1: `git clone git@github.com:jdrestre/mis-configuraciones-powershell.git`
   - Paso 2: `.\mis-configuraciones-powershell\bootstrap.ps1`

## Consecuencias y Beneficios

* **Control de Versiones Limpio**: Cualquier cambio o mejora que haga el usuario en su repositorio local puede ser guardado con `git commit` y subido a GitHub con `git push` de forma inmediata sin archivos duplicados.
* **Flexibilidad**: Mantiene compatibilidad total sin importar en qué carpeta o disco se ubique el proyecto.
