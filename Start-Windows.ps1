# PowerShell скрипт для запуска Time Track App на Windows
# Запуск: .\Start-Windows.ps1

Write-Host "====================================" -ForegroundColor Cyan
Write-Host " Time Track App - Запуск" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

# Проверка установки зависимостей
if (-not (Test-Path "backend\venv") -and -not (Get-Command uv -ErrorAction SilentlyContinue)) {
    Write-Host "[ПРЕДУПРЕЖДЕНИЕ] Backend зависимости могут быть не установлены!" -ForegroundColor Yellow
    Write-Host "Рекомендуется сначала запустить Install-Backend.ps1" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Нажмите Enter для продолжения или Ctrl+C для отмены"
}

if (-not (Test-Path "frontend\node_modules")) {
    Write-Host "[ПРЕДУПРЕЖДЕНИЕ] Frontend зависимости не установлены!" -ForegroundColor Yellow
    Write-Host "Рекомендуется сначала запустить Install-Frontend.ps1" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Нажмите Enter для продолжения или Ctrl+C для отмены"
}

# Запуск Backend в новом окне PowerShell
Write-Host "[INFO] Запуск backend..." -ForegroundColor Green
Start-Process powershell -ArgumentList "-NoExit", "-File", ".\Start-Backend.ps1"

# Ожидание запуска backend
Write-Host "[INFO] Ожидание запуска backend (5 секунд)..." -ForegroundColor Green
Start-Sleep -Seconds 5

# Запуск Frontend в новом окне PowerShell
Write-Host "[INFO] Запуск frontend..." -ForegroundColor Green
Start-Process powershell -ArgumentList "-NoExit", "-File", ".\Start-Frontend.ps1"

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host " Приложение запускается!" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Backend будет доступен по адресу:" -ForegroundColor White
Write-Host "  - API: http://localhost:8000" -ForegroundColor Yellow
Write-Host "  - Документация: http://localhost:8000/docs" -ForegroundColor Yellow
Write-Host ""
Write-Host "Frontend будет доступен по адресу:" -ForegroundColor White
Write-Host "  - UI: http://localhost:5173" -ForegroundColor Yellow
Write-Host ""
Write-Host "Для остановки приложения закройте оба окна" -ForegroundColor White
Write-Host "или запустите Stop-Windows.ps1" -ForegroundColor White
Write-Host ""
Read-Host "Нажмите Enter для завершения"