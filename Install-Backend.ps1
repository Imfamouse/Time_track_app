# PowerShell скрипт установки Backend зависимостей

Write-Host "====================================" -ForegroundColor Cyan
Write-Host " Установка backend зависимостей" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

Set-Location backend

# Проверка наличия Python
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "[ОШИБКА] Python не найден! Установите Python 3.12 или выше." -ForegroundColor Red
    Write-Host "Скачать можно здесь: https://www.python.org/downloads/" -ForegroundColor Yellow
    Read-Host "Нажмите Enter для выхода"
    exit 1
}

Write-Host "[INFO] Python найден" -ForegroundColor Green
python --version

# Проверка наличия uv (рекомендуется)
if (Get-Command uv -ErrorAction SilentlyContinue) {
    Write-Host "[INFO] Используется uv для управления зависимостями" -ForegroundColor Green
    uv sync --extra dev
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[ОШИБКА] Не удалось установить зависимости через uv" -ForegroundColor Red
        Read-Host "Нажмите Enter для выхода"
        exit 1
    }
    
    Write-Host "[УСПЕХ] Backend зависимости установлены через uv" -ForegroundColor Green
} else {
    Write-Host "[INFO] uv не найден, используется pip" -ForegroundColor Yellow
    
    # Создание виртуального окружения
    if (-not (Test-Path "venv")) {
        Write-Host "[INFO] Создание виртуального окружения..." -ForegroundColor Green
        python -m venv venv
    }
    
    # Активация виртуального окружения и установка зависимостей
    & .\venv\Scripts\Activate.ps1
    
    Write-Host "[INFO] Установка зависимостей через pip..." -ForegroundColor Green
    python -m pip install --upgrade pip
    pip install "fastapi>=0.110" "uvicorn[standard]>=0.30" "pydantic>=2.6"
    pip install "ruff>=0.3" "black>=24.4" "pytest>=8.1" "pytest-asyncio>=0.23" "httpx>=0.27"
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[ОШИБКА] Не удалось установить зависимости через pip" -ForegroundColor Red
        Read-Host "Нажмите Enter для выхода"
        exit 1
    }
    
    Write-Host "[УСПЕХ] Backend зависимости установлены через pip" -ForegroundColor Green
}

Set-Location ..
Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host " Установка завершена!" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Read-Host "Нажмите Enter для продолжения"