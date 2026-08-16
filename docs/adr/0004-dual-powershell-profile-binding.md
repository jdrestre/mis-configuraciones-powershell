# 4. Vinculación Dual de Perfiles (Windows PowerShell 5.1 y PowerShell Core 7+)

* **Estado**: Aprobado 🟢
* **Fecha**: 2026-08-16
* **Autores**: Juan David Restrepo (`jdrestre`) & Antigravity Assistant

## Contexto y Problema

Al abrir una nueva terminal estándar en Windows 11, se observaron dos problemas:
1. **Bloqueo por Política de Ejecución**: La política del usuario estaba en estado por defecto (`Restricted`), impidiendo la carga del perfil.
2. **Divergencia entre Ediciones de PowerShell**: Windows PowerShell 5.1 busca su perfil en la carpeta `WindowsPowerShell`, mientras que PowerShell Core 7+ busca en `PowerShell`. En sistemas donde coexisten ambas ediciones, una de las consolas quedaba sin personalizar.

## Decisión de Arquitectura

1. **Configuración Persistente de ExecutionPolicy**: En el paso de aprobación y aprovisionamiento, se establece `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser` para permitir que el usuario cargue sus scripts personales sin bloqueos.
2. **Vinculación Dual Automática en `bootstrap.ps1`**: El script recorre e inyecta el cargador shim tanto en las rutas de `WindowsPowerShell` como de `PowerShell`.
3. **Resolución Dinámica**: Ambas versiones de PowerShell apuntan al mismo `Profile.ps1` maestro ubicado dinámicamente en el repositorio.

## Consecuencias y Beneficios

* **Soporte Transparente Multi-Edición**: El usuario obtiene la misma experiencia visual (Oh My Posh, Terminal-Icons, autocompletado en lista) sin importar si lanza PowerShell nativo o PowerShell 7.
* **Cero Errores al Iniciar Consolas Nuevas**: Se elimina de raíz el mensaje rojo de error de permisos de ejecución.
