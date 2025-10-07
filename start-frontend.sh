#!/bin/bash
# Скрипт запуска frontend

cd /workspace/frontend

echo "🎨 Запуск Frontend на http://localhost:5173"
echo ""

pnpm dev --host 0.0.0.0 --port 5173