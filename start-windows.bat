@echo off
REM Главный скрипт запуска приложения для Windows
REM Запускает backend и frontend в отдельных окнах

echo ====================================
echo  Time Track App - Запуск
echo ====================================
echo.

REM Проверка установки зависимостей backend
if not exist backend\venv (
    uv --version >nul 2>&1
    if %errorlevel% neq 0 (
        echo [ПРЕДУПРЕЖДЕНИЕ] Backend зависимости могут быть не установлены!
        echo Рекомендуется сначала запустить install-backend.bat
        echo.
        pause
    )
)

REM Проверка установки зависимостей frontend
if not exist frontend\node_modules (
    echo [ПРЕДУПРЕЖДЕНИЕ] Frontend зависимости не установлены!
    echo Рекомендуется сначала запустить install-frontend.bat
    echo.
    pause
)

echo [INFO] Запуск backend в новом окне...
start "Time Track Backend" cmd /k start-backend.bat

echo [INFO] Ожидание запуска backend (5 секунд)...
timeout /t 5 /nobreak >nul

echo [INFO] Запуск frontend в новом окне...
start "Time Track Frontend" cmd /k start-frontend.bat

echo.
echo ====================================
echo  Приложение запускается!
echo ====================================
echo.
echo Backend будет доступен по адресу:
echo   - API: http://localhost:8000
echo   - Документация: http://localhost:8000/docs
echo.
echo Frontend будет доступен по адресу:
echo   - UI: http://localhost:5173
echo.
echo Для остановки приложения закройте оба окна
echo или запустите stop-windows.bat
echo.
pause