@echo off
chcp 65001 >nul
echo.
echo 🚀 Запуск Backend API...
echo.

cd backend

echo Установка зависимостей...
pip install fastapi uvicorn pydantic

echo.
echo ✅ Backend запускается на http://localhost:8000
echo 📖 API Документация: http://localhost:8000/docs
echo.
echo Нажмите Ctrl+C для остановки
echo.

python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

pause