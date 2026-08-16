# Module Git Utils

function gcheck {
    if (Get-Command git -ErrorAction SilentlyContinue) {
        Write-Host "Estado del repositorio Git actual:" -ForegroundColor Yellow
        git status -s -b
    } else {
        Write-Warning "Git no esta instalado o no se encuentra en el PATH."
    }
}

function gsl {
    if (Get-Command git -ErrorAction SilentlyContinue) {
        git log --oneline --graph --decorate -n 10
    }
}
