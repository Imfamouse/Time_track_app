@echo off
REM Полная установка всех зависимостей для Windows

echo ====================================
echo  Time Track App - Полная установка
echo ====================================
echo.

echo [ЭТАП 1/2] Установка backend зависимостей...
echo.
call install-backend.bat
if %errorlevel% neq 0 (
    echo [ОШИБКА] Ошибка установки backend
    pause
    exit /b 1
)

echo.
echo [ЭТАП 2/2] Установка frontend зависимостей...
echo.
call install-frontend.bat
if %errorlevel% neq 0 (
    echo [ОШИБКА] Ошибка установки frontend
    pause
    exit /b 1
)

echo.
echo ====================================
echo  Установка успешно завершена!
echo ====================================
echo.
echo Для запуска приложения выполните:
echo   start-windows.bat
echo.
pause