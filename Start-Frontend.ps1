# PowerShell скрипт запуска Frontend

Write-Host "====================================" -ForegroundColor Cyan
Write-Host " Запуск Time Track Frontend" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

Set-Location frontend

# Проверка наличия .env файла
if (-not (Test-Path ".env")) {
    Write-Host "[INFO] Создание файла .env..." -ForegroundColor Green
    "VITE_API_BASE_URL=http://localhost:8000" | Out-File -FilePath ".env" -Encoding utf8
}

# Проверка наличия pnpm
if (Get-Command pnpm -ErrorAction SilentlyContinue) {
    Write-Host "[INFO] Запуск через pnpm..." -ForegroundColor Green
    pnpm dev
} else {
    Write-Host "[INFO] Запуск через npm..." -ForegroundColor Green
    npm run dev
}