# PowerShell скрипт запуска Backend

Write-Host "====================================" -ForegroundColor Cyan
Write-Host " Запуск Time Track Backend" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

Set-Location backend

# Проверка наличия uv
if (Get-Command uv -ErrorAction SilentlyContinue) {
    Write-Host "[INFO] Запуск через uv..." -ForegroundColor Green
    uv run uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
} else {
    Write-Host "[INFO] Запуск через venv..." -ForegroundColor Green
    
    # Проверка существования виртуального окружения
    if (-not (Test-Path "venv")) {
        Write-Host "[ОШИБКА] Виртуальное окружение не найдено!" -ForegroundColor Red
        Write-Host "Запустите Install-Backend.ps1 для установки зависимостей" -ForegroundColor Red
        Read-Host "Нажмите Enter для выхода"
        exit 1
    }
    
    # Активация виртуального окружения и запуск
    & .\venv\Scripts\Activate.ps1
    python -m uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
}