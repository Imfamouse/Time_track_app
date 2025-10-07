@echo off
chcp 65001 >nul
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║        Проверка требований для запуска приложения            ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

set /a errors=0

echo Проверка установленного ПО...
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo.

REM Check Docker
echo [1/5] Проверка Docker...
docker --version >nul 2>&1
if %errorlevel% equ 0 (
    docker --version
    echo ✅ Docker установлен
) else (
    echo ❌ Docker НЕ найден
    echo    Скачать: https://www.docker.com/products/docker-desktop/
    set /a errors+=1
)
echo.

REM Check Python
echo [2/5] Проверка Python...
python --version >nul 2>&1
if %errorlevel% equ 0 (
    python --version
    echo ✅ Python установлен
) else (
    py --version >nul 2>&1
    if %errorlevel% equ 0 (
        py --version
        echo ✅ Python установлен ^(используйте 'py' вместо 'python'^)
    ) else (
        echo ❌ Python НЕ найден
        echo    Скачать: https://www.python.org/downloads/
        set /a errors+=1
    )
)
echo.

REM Check pip
echo [3/5] Проверка pip...
pip --version >nul 2>&1
if %errorlevel% equ 0 (
    pip --version
    echo ✅ pip установлен
) else (
    echo ❌ pip НЕ найден
    set /a errors+=1
)
echo.

REM Check Node.js
echo [4/5] Проверка Node.js...
node --version >nul 2>&1
if %errorlevel% equ 0 (
    node --version
    echo ✅ Node.js установлен
) else (
    echo ❌ Node.js НЕ найден
    echo    Скачать: https://nodejs.org/
    set /a errors+=1
)
echo.

REM Check pnpm
echo [5/5] Проверка pnpm...
pnpm --version >nul 2>&1
if %errorlevel% equ 0 (
    pnpm --version
    echo ✅ pnpm установлен
) else (
    echo ⚠️  pnpm НЕ найден
    echo    Установить: npm install -g pnpm
)
echo.

echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo.

if %errors% equ 0 (
    echo ╔══════════════════════════════════════════════════════════════╗
    echo ║              ✅ ВСЕ ТРЕБОВАНИЯ ВЫПОЛНЕНЫ!                    ║
    echo ╚══════════════════════════════════════════════════════════════╝
    echo.
    echo Вы можете запустить приложение:
    echo.
    echo   С Docker:     WINDOWS_QUICKSTART.bat
    echo   Без Docker:   start-backend.bat ^(+ start-frontend.bat^)
) else (
    echo ╔══════════════════════════════════════════════════════════════╗
    echo ║              ❌ НАЙДЕНЫ ПРОБЛЕМЫ                             ║
    echo ╚══════════════════════════════════════════════════════════════╝
    echo.
    echo Установите недостающие компоненты и запустите проверку снова.
    echo.
    echo Подробные инструкции: WINDOWS_SETUP.md
)

echo.
pause