#!/bin/bash
# Пример создания новой записи через API

echo "🆕 Создаем новую запись времени..."
echo ""

RESPONSE=$(curl -s -X POST http://localhost:8000/api/time-entries \
  -H "Content-Type: application/json" \
  -d '{
    "project_id": 1,
    "description": "Демонстрация работы API",
    "start_time": "2025-10-07T12:00:00"
  }')

echo "Ответ сервера:"
echo "$RESPONSE" | python3 -m json.tool
echo ""

echo "✅ Запись создана!"
echo ""
echo "Проверяем обновленную статистику:"
curl -s http://localhost:8000/api/stats?user_id=1 | python3 -c "
import json, sys
stats = json.load(sys.stdin)
print(f\"  Всего записей: {stats['entries_count']}\")
print(f\"  Сегодня: {stats['total_hours_today']} часов\")
"
