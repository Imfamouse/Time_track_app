#!/bin/bash
# Скрипт остановки демо приложения

echo "🛑 Остановка демо приложения..."

# Остановка процессов
pkill -f "uvicorn app.main:app" 2>/dev/null
pkill -f "vite.*5173" 2>/dev/null

sleep 2

# Проверка
if pgrep -f "uvicorn" > /dev/null || pgrep -f "vite" > /dev/null; then
    echo "⚠️  Некоторые процессы все еще работают"
    ps aux | grep -E "uvicorn|vite" | grep -v grep
else
    echo "✅ Все процессы остановлены"
fi
