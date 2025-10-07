@echo off
REM Quick start script for Windows users
chcp 65001 >nul
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║          TIME TRACK APP - Windows Quick Start                ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

REM Check for Docker
docker --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Docker найден
    echo.
    echo Запускаем через Docker Compose...
    echo.
    docker compose up --build
) else (
    echo ❌ Docker не найден
    echo.
    echo Установите Docker Desktop:
    echo https://www.docker.com/products/docker-desktop/
    echo.
    echo Или следуйте инструкции в WINDOWS_SETUP.md
    echo для запуска без Docker
    pause
)