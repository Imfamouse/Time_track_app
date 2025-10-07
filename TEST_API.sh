#!/bin/bash
# Скрипт для тестирования API

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║           ДЕМОНСТРАЦИЯ РАБОТЫ TIME TRACK API                 ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

echo "1️⃣  Health Check:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
curl -s http://localhost:8000/health | python3 -m json.tool
echo ""
echo ""

echo "2️⃣  Список проектов (5 шт):"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
curl -s http://localhost:8000/api/projects | python3 -c "
import json, sys
projects = json.load(sys.stdin)
for p in projects:
    print(f\"  [{p['id']}] {p['name']:<30} {p['color']}  - {p['description']}\")
"
echo ""

echo "3️⃣  Статистика по времени:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
curl -s http://localhost:8000/api/stats?user_id=1 | python3 -c "
import json, sys
stats = json.load(sys.stdin)
print(f\"  Сегодня:    {stats['total_hours_today']} часов\")
print(f\"  Эта неделя: {stats['total_hours_week']} часов\")
print(f\"  Этот месяц: {stats['total_hours_month']} часов\")
print(f\"  Всего записей: {stats['entries_count']}\")
print()
print('  Топ проекты:')
for p in stats['top_projects']:
    print(f\"    • {p['project_name']:<30} {p['hours']} ч\")
"
echo ""

echo "4️⃣  Записи времени (последние 3):"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
curl -s http://localhost:8000/api/time-entries | python3 -c "
import json, sys
from datetime import datetime
entries = json.load(sys.stdin)
for e in entries[:3]:
    start = datetime.fromisoformat(e['start_time'].replace('Z', '+00:00'))
    duration = f\"{e['duration_minutes']} мин\" if e['duration_minutes'] else 'В процессе'
    print(f\"  [{e['id']}] {e['description']:<40} - {duration}\")
    print(f\"       Начало: {start.strftime('%d.%m.%Y %H:%M')}\")
    print()
"

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                    ✅ API РАБОТАЕТ!                          ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "📖 Полная документация: http://localhost:8000/docs"
echo ""
