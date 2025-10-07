@echo off
REM Исправление 404 ошибки frontend

echo ====================================
echo  Исправление 404 ошибки frontend
echo ====================================
echo.

echo [INFO] Копирование index.html в корень frontend...
copy frontend\public\index.html frontend\index.html >nul 2>&1

if %errorlevel% equ 0 (
    echo [УСПЕХ] Файл index.html скопирован
    echo.
    echo Теперь перезапустите frontend:
    echo   start-frontend.bat
) else (
    echo [ОШИБКА] Не удалось скопировать файл
    echo Убедитесь, что файл frontend\public\index.html существует
)

echo.
pause