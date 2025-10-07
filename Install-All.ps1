# PowerShell скрипт полной установки

Write-Host "====================================" -ForegroundColor Cyan
Write-Host " Time Track App - Полная установка" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "[ЭТАП 1/2] Установка backend зависимостей..." -ForegroundColor Yellow
Write-Host ""
& .\Install-Backend.ps1
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ОШИБКА] Ошибка установки backend" -ForegroundColor Red
    Read-Host "Нажмите Enter для выхода"
    exit 1
}

Write-Host ""
Write-Host "[ЭТАП 2/2] Установка frontend зависимостей..." -ForegroundColor Yellow
Write-Host ""
& .\Install-Frontend.ps1
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ОШИБКА] Ошибка установки frontend" -ForegroundColor Red
    Read-Host "Нажмите Enter для выхода"
    exit 1
}

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host " Установка успешно завершена!" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Для запуска приложения выполните:" -ForegroundColor White
Write-Host "  .\Start-Windows.ps1" -ForegroundColor Yellow
Write-Host ""
Read-Host "Нажмите Enter для завершения"