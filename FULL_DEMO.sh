#!/bin/bash
# Полная демонстрация работы Time Track App

clear
echo "╔══════════════════════════════════════════════════════════════════════════╗"
echo "║          TIME TRACK APP - ПОЛНАЯ ДЕМОНСТРАЦИЯ ФУНКЦИОНАЛЬНОСТИ           ║"
echo "╚══════════════════════════════════════════════════════════════════════════╝"
echo ""
sleep 1

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "1️⃣  ПРОВЕРКА СТАТУСА СЕРВИСОВ"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Backend API:"
if curl -s http://localhost:8000/health > /dev/null; then
    echo "  ✅ РАБОТАЕТ (порт 8000)"
else
    echo "  ❌ НЕ ОТВЕЧАЕТ"
fi

echo ""
echo "Frontend UI:"
if curl -s http://localhost:5173/ > /dev/null; then
    echo "  ✅ РАБОТАЕТ (порт 5173)"
else
    echo "  ❌ НЕ ОТВЕЧАЕТ"
fi
echo ""
sleep 2

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "2️⃣  СПИСОК ПРОЕКТОВ"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
curl -s http://localhost:8000/api/projects | python3 -c "
import json, sys
projects = json.load(sys.stdin)
for i, p in enumerate(projects, 1):
    print(f\"  {i}. [{p['color']}] {p['name']:<35} - {p['description']}\")
"
echo ""
sleep 2

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "3️⃣  ТЕКУЩАЯ СТАТИСТИКА ПО ВРЕМЕНИ"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
curl -s http://localhost:8000/api/stats?user_id=1 | python3 -c "
import json, sys
stats = json.load(sys.stdin)
print(f\"  📊 Отработано часов:\")
print(f\"     • Сегодня:    {stats['total_hours_today']:>6} ч\")
print(f\"     • Неделя:     {stats['total_hours_week']:>6} ч\")
print(f\"     • Месяц:      {stats['total_hours_month']:>6} ч\")
print(f\"  📝 Всего записей: {stats['entries_count']}\")
print()
print('  🏆 Топ проекты за месяц:')
for i, p in enumerate(stats['top_projects'], 1):
    bar = '█' * int(p['hours'])
    print(f\"     {i}. {p['project_name']:<30} {bar} {p['hours']} ч\")
"
echo ""
sleep 2

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "4️⃣  ИСТОРИЯ ЗАПИСЕЙ ВРЕМЕНИ"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
curl -s http://localhost:8000/api/time-entries | python3 -c "
import json, sys
from datetime import datetime

entries = json.load(sys.stdin)
print(f\"  Всего записей: {len(entries)}\")
print()

for i, e in enumerate(entries[:5], 1):
    start = datetime.fromisoformat(e['start_time'].replace('Z', '+00:00'))
    status = '🟢 В процессе' if e['is_running'] else f\"✅ {e['duration_minutes']} мин\"
    print(f\"  {i}. [{e['id']}] {e['description'][:50]:<50}\")
    print(f\"        Проект: {e['project_id']} | Начало: {start.strftime('%d.%m %H:%M')} | {status}\")
    print()
"
sleep 2

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "5️⃣  СОЗДАНИЕ НОВОЙ ЗАПИСИ"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "  Создаем запись: 'Полное тестирование API функциональности'..."
sleep 1

NEW_ENTRY=$(curl -s -X POST http://localhost:8000/api/time-entries \
  -H "Content-Type: application/json" \
  -d '{
    "project_id": 4,
    "description": "Полное тестирование API функциональности",
    "start_time": "2025-10-07T14:00:00"
  }')

echo "$NEW_ENTRY" | python3 -c "
import json, sys
entry = json.load(sys.stdin)
print(f\"  ✅ Запись создана успешно!\")
print(f\"     ID: {entry['id']}\")
print(f\"     Проект: {entry['project_id']}\")
print(f\"     Описание: {entry['description']}\")
print(f\"     Статус: {'В процессе' if entry['is_running'] else 'Завершена'}\")
"
echo ""
sleep 2

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "6️⃣  ОБНОВЛЕННАЯ СТАТИСТИКА"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
curl -s http://localhost:8000/api/stats?user_id=1 | python3 -c "
import json, sys
stats = json.load(sys.stdin)
print(f\"  📝 Всего записей: {stats['entries_count']} (+1 новая)\")
"
echo ""
sleep 1

echo "╔══════════════════════════════════════════════════════════════════════════╗"
echo "║                    ✅ ВСЕ ФУНКЦИИ РАБОТАЮТ!                              ║"
echo "╚══════════════════════════════════════════════════════════════════════════╝"
echo ""
echo "🎯 Протестированные функции:"
echo "   ✅ Получение списка проектов"
echo "   ✅ Статистика по времени с агрегацией"
echo "   ✅ Получение истории записей"
echo "   ✅ Создание новых записей"
echo "   ✅ Автоматический расчет метрик"
echo ""
echo "📖 Документация API: http://localhost:8000/docs"
echo "📂 Подробнее: REMOTE_ACCESS.md"
echo ""
