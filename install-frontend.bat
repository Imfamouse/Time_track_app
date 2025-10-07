@echo off
REM Скрипт установки зависимостей frontend для Windows

echo ====================================
echo  Установка frontend зависимостей
echo ====================================
echo.

cd frontend

REM Проверка наличия Node.js
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ОШИБКА] Node.js не найден! Установите Node.js 20 или выше.
    echo Скачать можно здесь: https://nodejs.org/
    pause
    exit /b 1
)

echo [INFO] Node.js найден
node --version

REM Проверка наличия pnpm
pnpm --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [INFO] Используется pnpm для управления зависимостями
    pnpm install
    if %errorlevel% neq 0 (
        echo [ОШИБКА] Не удалось установить зависимости через pnpm
        pause
        exit /b 1
    )
    echo [УСПЕХ] Frontend зависимости установлены через pnpm
) else (
    echo [INFO] pnpm не найден, используется npm
    
    REM Проверка наличия npm
    npm --version >nul 2>&1
    if %errorlevel% neq 0 (
        echo [ОШИБКА] npm не найден!
        pause
        exit /b 1
    )
    
    echo [INFO] Установка зависимостей через npm...
    npm install
    
    if %errorlevel% neq 0 (
        echo [ОШИБКА] Не удалось установить зависимости через npm
        pause
        exit /b 1
    )
    
    echo [УСПЕХ] Frontend зависимости установлены через npm
)

REM Создание .env файла если его нет
if not exist .env (
    echo [INFO] Создание файла .env...
    echo VITE_API_BASE_URL=http://localhost:8000 > .env
    echo [УСПЕХ] Файл .env создан
)

cd ..
echo.
echo ====================================
echo  Установка завершена!
echo ====================================
pause