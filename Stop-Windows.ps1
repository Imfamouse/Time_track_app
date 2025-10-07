# PowerShell скрипт остановки приложения

Write-Host "====================================" -ForegroundColor Cyan
Write-Host " Остановка Time Track App" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

# Остановка процессов Python (backend)
Write-Host "[INFO] Остановка процессов backend..." -ForegroundColor Green
$pythonProcesses = Get-Process python -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowTitle -like "*uvicorn*" -or $_.CommandLine -like "*uvicorn*" }
if ($pythonProcesses) {
    $pythonProcesses | Stop-Process -Force
    Write-Host "[УСПЕХ] Backend остановлен" -ForegroundColor Green
} else {
    Write-Host "[INFO] Процессы backend не найдены" -ForegroundColor Yellow
}

# Остановка процессов Node.js (frontend)
Write-Host "[INFO] Остановка процессов frontend..." -ForegroundColor Green
$nodeProcesses = Get-Process node -ErrorAction SilentlyContinue | Where-Object { $_.CommandLine -like "*vite*" }
if ($nodeProcesses) {
    $nodeProcesses | Stop-Process -Force
    Write-Host "[УСПЕХ] Frontend остановлен" -ForegroundColor Green
} else {
    Write-Host "[INFO] Процессы frontend не найдены" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host " Остановка завершена" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Read-Host "Нажмите Enter для завершения"