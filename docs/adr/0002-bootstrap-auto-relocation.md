# 2. Reubicación Automática del Repositorio vía Bootstrap y Flujo de 2 Pasos

* **Estado**: Aprobado 🟢
* **Fecha**: 2026-08-16
* **Autores**: Juan David Restrepo (`jdrestre`) & Antigravity Assistant

## Contexto y Problema

Inicialmente, el proceso de instalación en equipos nuevos requería que el usuario especificara manualmente rutas complejas dentro de la terminal al clonar el repositorio (ej. `git clone ... $HOME\.config\powershell-custom`).

Esto introducía dos riesgos principales:
1. **Errores Tipográficos**: El usuario podía cometer errores al tipear rutas largas en PowerShell antes de tener habilitado el autocompletado avanzado.
2. **Fricción de Instalación**: Incomodidad de tener que recordar o copiar comandos multilínea en consolas limpias recién instaladas.

## Decisión de Arquitectura

1. **Flujo de Clonación Directa**: Permitir que el usuario simplemente clone el repositorio en la raíz de su perfil de usuario (`C:\Users\<Usuario>\mis-configuraciones-powershell`).
2. **Auto-Relocalización Inteligente en `bootstrap.ps1`**: El script `bootstrap.ps1` detecta la ruta actual de ejecución. Si se ejecuta desde la raíz de usuario o fuera de `$HOME\.config\powershell-custom`, el script:
   - Crea la estructura `.config` automáticamente si no existe.
   - Mueve/copia los archivos a `$HOME\.config\powershell-custom`.
   - Reanuda y completa la vinculación del perfil desde la ubicación final estándar.
3. **Cero Comandos Complejos**: El usuario solo necesita ejecutar `.\mis-configuraciones-powershell\bootstrap.ps1`.

## Consecuencias y Beneficios

* **Experiencia de Usuario (UX)**: Instalación extremadamente limpia e intuitiva en 2 pasos simples.
* **Prevención de Errores de Configuración**: Se evita que queden carpetas mal ubicadas o desorganizadas en el sistema del usuario.
* **Mantenibilidad e IA**: El archivo `AGENTS.md` y este ADR le recuerdan a cualquier asistente de código o colaborador que `bootstrap.ps1` posee lógica de auto-relocalización para no romper este comportamiento en futuras versiones.
