#!/bin/bash
# Скрипт запуска всего демо приложения

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║        TIME TRACK APP - Запуск демо прототипа               ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# Проверка зависимостей
echo "🔍 Проверка установки зависимостей..."
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 не найден"
    exit 1
fi

if ! command -v pnpm &> /dev/null; then
    echo "❌ pnpm не найден"
    exit 1
fi

echo "✅ Все зависимости на месте"
echo ""

# Запуск backend
echo "🚀 Запуск Backend..."
cd /workspace/backend
export PATH="/home/ubuntu/.local/bin:$PATH"
nohup python3 -m uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload > /tmp/backend.log 2>&1 &
BACKEND_PID=$!
echo "   Backend PID: $BACKEND_PID"
echo "   Логи: /tmp/backend.log"

# Ждем запуска backend
sleep 3

# Запуск frontend
echo ""
echo "🎨 Запуск Frontend..."
cd /workspace/frontend
nohup pnpm dev --host 0.0.0.0 --port 5173 > /tmp/frontend.log 2>&1 &
FRONTEND_PID=$!
echo "   Frontend PID: $FRONTEND_PID"
echo "   Логи: /tmp/frontend.log"

# Ждем запуска frontend
sleep 5

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                    ✅ ДЕМО ЗАПУЩЕНО!                         ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "🌐 Откройте в браузере:"
echo "   Frontend:  http://localhost:5173"
echo "   API Docs:  http://localhost:8000/docs"
echo ""
echo "📊 Управление:"
echo "   Логи backend:   tail -f /tmp/backend.log"
echo "   Логи frontend:  tail -f /tmp/frontend.log"
echo "   Остановить:     pkill -f uvicorn && pkill -f vite"
echo ""
echo "💡 Нажмите Ctrl+C для выхода (сервисы продолжат работать в фоне)"
echo ""

# Показываем логи
tail -f /tmp/backend.log /tmp/frontend.log
