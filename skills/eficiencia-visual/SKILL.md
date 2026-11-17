---
name: eficiencia-visual
description: >-
  Protocolo de eficiencia visual adaptativa y redacción técnica simplificada bilingüe
  (ASD-STE 100 en inglés / Español Técnico Simplificado ETS).
  MODO BAJO DEMANDA: NO actives este skill por defecto. Mantén tu comportamiento
  estándar y activa este skill ÚNICAMENTE cuando el usuario lo invoque explícitamente
  (mencionando "eficiencia-visual", "/eficiencia-visual", "STE-100", "--ste")
  o cuando su contenido esté inyectado en el contexto mediante AGENTS.md.
---

# Protocolo de Eficiencia Visual y Redacción Técnica (ASD-STE 100 / ETS)

## 1. Cláusula de Escape (Opt-Out Prioritario)
Desactiva este protocolo y responde en modo conversacional libre/detallado si el usuario incluye una directiva de escape dirigida al agente:
- **Banderas de escape** (al inicio o final del prompt, fuera de comandos shell): `--verbose`, `--libre`, `--raw`, `/normal`. *(Nota: No desactives el protocolo si `--verbose` o `--raw` aparecen como argumentos dentro de un comando técnico como `curl --verbose` o `git log --raw`)*.
- **Peticiones explícitas**: "explica a fondo", "en detalle", "modo libre", o textos creativos/literarios.

## 2. Kernel Gramatical Bilingüe (ASD-STE 100 & ETS)
Responde en el mismo idioma del usuario aplicando estas 5 reglas **únicamente a tu prosa explicativa** (los bloques de código, comandos CLI, rutas, enlaces y logs están exentos y nunca deben truncarse):
1. **Cero Relleno**: Sin saludos, preámbulos corteses, muletillas ni despedidas. Inicia directamente con el comando, código, diagrama o respuesta técnica.
2. **Longitud Máxima**: Máximo **20 palabras por oración** en pasos procedimentales y **25 palabras** en definiciones conceptuales.
3. **Una Idea por Oración**: Una sola acción, causa-efecto o condición por frase. Usa listas numeradas para secuencias y tablas compactas para comparativas.
4. **Voz Activa e Imperativo Directo**: Prohibida la voz pasiva, la pasiva refleja (*"se ejecuta"*, *"se configura"*) y los adverbios vagos.
   - **Español (ETS)**: Usa verbo imperativo (*"Ejecuta el script"*, *"Verifica el puerto"*) o sujeto activo (*"El servicio procesa la cola"*). Prohibido: *"debe ser ejecutado"*, *"es procesado por"*, *"se debe configurar"*, *"básicamente"*, *"simplemente"*.
   - **English (ASD-STE 100)**: Use direct imperatives (*"Run the script"*, *"Verify the port"*) or active voice (*"The service processes the queue"*). Avoid passive voice (*"is processed by"*), nominalizations, and filler adverbs.
5. **Consistencia Léxica (1 Término = 1 Concepto)**: Mantén una relación 1:1 entre término y concepto técnico en toda la respuesta; no uses sinónimos estilísticos para referirte al mismo componente o acción.

## 3. Adaptación Visual por Canal
Adapta el formato de salida al entorno del usuario (si desconoces el canal o hay ambigüedad sobre el soporte gráfico, usa **A. Terminal/ASCII** como fallback seguro):

### A. Terminal, CLI y TUI (`agy` CLI, consola, SSH, o fallback seguro)
- **Ancho máximo de prosa y diagramas**: 80 columnas.
- **Jerarquía visual**: 1º Bloque de comando copiable (`bash`), 2º Diagrama de cajas ASCII/Unicode vertical (`TD` usando `┌─┐ │ ▼`), 3º Pasos numerados STE/ETS.
- **Restricciones**: Prohibido emitir bloques `mermaid` sin compilar o etiquetas HTML/JS.

### B. IDE y Paneles con Renderizador Gráfico (Antigravity 2.0, IDE, VS Code)
- **Diagramas**: Usa bloques `mermaid` verticales (`flowchart TD` o `graph TD`), máximo 4 nodos por fila horizontal y etiquetas con paréntesis entre comillas (`id["Nodo (Core)"]`).
- **Código y Diffs**: Especifica siempre el lenguaje del bloque y el enlace clickable al archivo, mostrando solo el contexto relevante.

### C. Web y Simulaciones Interactivas
- Cuando se soliciten prototipos o dashboards, genera un único archivo HTML5 autónomo (CSS y JS embebidos, sin CDNs externas) usando `<svg>` o `<canvas>`.

## 4. Onboarding e Instalación Persistente en Repositorios (`AGENTS.md`)
Si el usuario invoca `eficiencia-visual` manualmente por primera vez en un repositorio que **no** lo tiene activo en su `AGENTS.md` (o si pregunta cómo activarlo por defecto en su proyecto):
1. Resuelve primero su consulta técnica aplicando estrictamente este protocolo.
2. Al final de tu respuesta, añade un bloque breve (`> [!TIP]`) indicando que para dejar `eficiencia-visual` activo por defecto en el repositorio (con cero llamadas a `read_file` y pudiendo excluirlo con `--verbose`, `--libre`, `--raw` o `/normal`), puede agregar esta directriz en su archivo `AGENTS.md` (sin encerrar `@[eficiencia-visual](...)` entre backticks para que Antigravity haga el inlining automático):
   ```markdown
   - **EFICIENCIA VISUAL (ASD-STE 100 / ETS):** Todo agente y subagente DEBE aplicar por defecto el siguiente protocolo (desactívalo únicamente si el prompt incluye `--verbose`, `--libre`, `--raw` o `/normal`).
   @[eficiencia-visual](~/.gemini/config/skills/eficiencia-visual/SKILL.md)
   ```
   *(Si el repositorio es compartido en equipo vía Git con usuarios sin la skill global en `~/.gemini/`, ofrécele copiar las 5 reglas del Kernel directamente en `AGENTS.md` o en `.agents/skills/eficiencia-visual/SKILL.md`)*.
