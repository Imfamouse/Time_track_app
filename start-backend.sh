#!/bin/bash
# Скрипт запуска backend

cd /workspace/backend

echo "🚀 Запуск Backend API на http://localhost:8000"
echo "📖 Swagger документация: http://localhost:8000/docs"
echo ""

export PATH="/home/ubuntu/.local/bin:$PATH"

python3 -m uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload