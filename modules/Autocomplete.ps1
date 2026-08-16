# Módulo de Autocompletado Avanzado (PSReadLine + Predictors)

if (Get-Module -ListAvailable -Name PSReadLine) {
    try {
        # Configurar Origen de Predicciones por Historial
        Set-PSReadLineOption -PredictionSource History -ErrorAction SilentlyContinue

        # Configurar Vista Desplegable (ListView)
        Set-PSReadLineOption -PredictionViewStyle ListView -ErrorAction SilentlyContinue

        # Colores de predicción
        Set-PSReadLineOption -Colors @{ InlinePrediction = '#586e75' } -ErrorAction SilentlyContinue

        # Atajo Ctrl+Space para activar completado por menú
        Set-PSReadLineKeyHandler -Chord 'Ctrl+Space' -Function MenuComplete -ErrorAction SilentlyContinue
    } catch {
        # Fallback defensivo silencioso
    }
}
