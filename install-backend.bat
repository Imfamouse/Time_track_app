@echo off
REM Скрипт установки зависимостей backend для Windows

echo ====================================
echo  Установка backend зависимостей
echo ====================================
echo.

cd backend

REM Проверка наличия Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ОШИБКА] Python не найден! Установите Python 3.12 или выше.
    echo Скачать можно здесь: https://www.python.org/downloads/
    pause
    exit /b 1
)

echo [INFO] Python найден
python --version

REM Проверка наличия uv (рекомендуется)
uv --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [INFO] Используется uv для управления зависимостями
    uv sync --extra dev
    if %errorlevel% neq 0 (
        echo [ОШИБКА] Не удалось установить зависимости через uv
        pause
        exit /b 1
    )
    echo [УСПЕХ] Backend зависимости установлены через uv
) else (
    echo [INFO] uv не найден, используется pip
    
    REM Создание виртуального окружения
    if not exist venv (
        echo [INFO] Создание виртуального окружения...
        python -m venv venv
    )
    
    REM Активация виртуального окружения и установка зависимостей
    call venv\Scripts\activate.bat
    
    echo [INFO] Установка зависимостей через pip...
    pip install --upgrade pip
    pip install fastapi uvicorn[standard] pydantic
    pip install ruff black pytest pytest-asyncio httpx
    
    if %errorlevel% neq 0 (
        echo [ОШИБКА] Не удалось установить зависимости через pip
        pause
        exit /b 1
    )
    
    echo [УСПЕХ] Backend зависимости установлены через pip
)

cd ..
echo.
echo ====================================
echo  Установка завершена!
echo ====================================
pause