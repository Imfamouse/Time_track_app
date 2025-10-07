@echo off
REM Скрипт запуска backend для Windows

echo ====================================
echo  Запуск Time Track Backend
echo ====================================
echo.

cd backend

REM Проверка наличия uv
uv --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [INFO] Запуск через uv...
    uv run uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
) else (
    echo [INFO] Запуск через venv...
    
    REM Проверка существования виртуального окружения
    if not exist venv (
        echo [ОШИБКА] Виртуальное окружение не найдено!
        echo Запустите install-backend.bat для установки зависимостей
        pause
        exit /b 1
    )
    
    REM Активация виртуального окружения и запуск
    call venv\Scripts\activate.bat
    python -m uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
)