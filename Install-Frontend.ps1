# PowerShell скрипт установки Frontend зависимостей

Write-Host "====================================" -ForegroundColor Cyan
Write-Host " Установка frontend зависимостей" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

Set-Location frontend

# Проверка наличия Node.js
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "[ОШИБКА] Node.js не найден! Установите Node.js 20 или выше." -ForegroundColor Red
    Write-Host "Скачать можно здесь: https://nodejs.org/" -ForegroundColor Yellow
    Read-Host "Нажмите Enter для выхода"
    exit 1
}

Write-Host "[INFO] Node.js найден" -ForegroundColor Green
node --version

# Проверка наличия pnpm
if (Get-Command pnpm -ErrorAction SilentlyContinue) {
    Write-Host "[INFO] Используется pnpm для управления зависимостями" -ForegroundColor Green
    pnpm install
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[ОШИБКА] Не удалось установить зависимости через pnpm" -ForegroundColor Red
        Read-Host "Нажмите Enter для выхода"
        exit 1
    }
    
    Write-Host "[УСПЕХ] Frontend зависимости установлены через pnpm" -ForegroundColor Green
} else {
    Write-Host "[INFO] pnpm не найден, используется npm" -ForegroundColor Yellow
    
    # Проверка наличия npm
    if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
        Write-Host "[ОШИБКА] npm не найден!" -ForegroundColor Red
        Read-Host "Нажмите Enter для выхода"
        exit 1
    }
    
    Write-Host "[INFO] Установка зависимостей через npm..." -ForegroundColor Green
    npm install
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[ОШИБКА] Не удалось установить зависимости через npm" -ForegroundColor Red
        Read-Host "Нажмите Enter для выхода"
        exit 1
    }
    
    Write-Host "[УСПЕХ] Frontend зависимости установлены через npm" -ForegroundColor Green
}

# Создание .env файла если его нет
if (-not (Test-Path ".env")) {
    Write-Host "[INFO] Создание файла .env..." -ForegroundColor Green
    "VITE_API_BASE_URL=http://localhost:8000" | Out-File -FilePath ".env" -Encoding utf8
    Write-Host "[УСПЕХ] Файл .env создан" -ForegroundColor Green
}

# Копирование index.html в корень если его там нет
if (-not (Test-Path "index.html")) {
    if (Test-Path "public\index.html") {
        Write-Host "[INFO] Копирование index.html в корень..." -ForegroundColor Green
        Copy-Item -Path "public\index.html" -Destination "index.html" -Force
        Write-Host "[УСПЕХ] Файл index.html скопирован" -ForegroundColor Green
    }
}

Set-Location ..
Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host " Установка завершена!" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Read-Host "Нажмите Enter для продолжения"