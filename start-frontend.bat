@echo off
chcp 65001 >nul
echo.
echo 🎨 Запуск Frontend UI...
echo.

cd frontend

if not exist .env (
    echo Копируем файл окружения...
    copy .env.example .env
)

if not exist node_modules (
    echo Установка зависимостей...
    call pnpm install
)

echo.
echo ✅ Frontend запускается на http://localhost:5173
echo.
echo Нажмите Ctrl+C для остановки
echo.

call pnpm dev

pause