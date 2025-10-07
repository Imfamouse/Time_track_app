# PowerShell скрипт исправления 404 ошибки frontend

Write-Host "====================================" -ForegroundColor Cyan
Write-Host " Исправление 404 ошибки frontend" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "[INFO] Копирование index.html в корень frontend..." -ForegroundColor Green

if (Test-Path "frontend\public\index.html") {
    Copy-Item -Path "frontend\public\index.html" -Destination "frontend\index.html" -Force
    
    if (Test-Path "frontend\index.html") {
        Write-Host "[УСПЕХ] Файл index.html скопирован" -ForegroundColor Green
        Write-Host ""
        Write-Host "Теперь перезапустите frontend:" -ForegroundColor White
        Write-Host "  .\Start-Frontend.ps1" -ForegroundColor Yellow
    } else {
        Write-Host "[ОШИБКА] Не удалось скопировать файл" -ForegroundColor Red
    }
} else {
    Write-Host "[ОШИБКА] Файл frontend\public\index.html не найден" -ForegroundColor Red
}

Write-Host ""
Read-Host "Нажмите Enter для завершения"