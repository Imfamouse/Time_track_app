@echo off
REM Скрипт остановки приложения для Windows

echo ====================================
echo  Остановка Time Track App
echo ====================================
echo.

echo [INFO] Остановка процессов uvicorn (backend)...
taskkill /F /IM python.exe /FI "WINDOWTITLE eq Time Track Backend*" 2>nul
if %errorlevel% equ 0 (
    echo [УСПЕХ] Backend остановлен
) else (
    echo [INFO] Процессы backend не найдены
)

echo [INFO] Остановка процессов node (frontend)...
taskkill /F /IM node.exe /FI "WINDOWTITLE eq Time Track Frontend*" 2>nul
if %errorlevel% equ 0 (
    echo [УСПЕХ] Frontend остановлен
) else (
    echo [INFO] Процессы frontend не найдены
)

echo.
echo ====================================
echo  Остановка завершена
echo ====================================
pause