@echo off
REM Скрипт запуска frontend для Windows

echo ====================================
echo  Запуск Time Track Frontend
echo ====================================
echo.

cd frontend

REM Проверка наличия .env файла
if not exist .env (
    echo [INFO] Создание файла .env...
    echo VITE_API_BASE_URL=http://localhost:8000 > .env
)

REM Проверка наличия pnpm
pnpm --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [INFO] Запуск через pnpm...
    pnpm dev
) else (
    echo [INFO] Запуск через npm...
    npm run dev
)