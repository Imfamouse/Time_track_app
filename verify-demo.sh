#!/bin/bash
# Скрипт проверки готовности демо прототипа

echo "🔍 Проверка структуры демо прототипа Time Track App"
echo "=================================================="
echo ""

# Цвета для вывода
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} $1"
        return 0
    else
        echo -e "${RED}✗${NC} $1 (отсутствует)"
        return 1
    fi
}

check_dir() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✓${NC} $1/"
        return 0
    else
        echo -e "${RED}✗${NC} $1/ (отсутствует)"
        return 1
    fi
}

echo "📁 Backend файлы:"
check_file "backend/app/main.py"
check_file "backend/app/models.py"
check_file "backend/app/database.py"
check_file "backend/Dockerfile"
check_file "backend/pyproject.toml"
echo ""

echo "📁 Frontend файлы:"
check_file "frontend/src/App.tsx"
check_file "frontend/src/main.tsx"
check_file "frontend/src/api/client.ts"
check_dir "frontend/src/components"
check_dir "frontend/src/store"
check_file "frontend/Dockerfile"
check_file "frontend/package.json"
echo ""

echo "📁 Конфигурационные файлы:"
check_file "docker-compose.yml"
check_file ".env"
check_file "frontend/.env"
echo ""

echo "📁 Документация:"
check_file "README.md"
check_file "DEMO_SETUP.md"
check_file "CHECKLIST.md"
echo ""

echo "📊 Статистика проекта:"
echo "--------------------------------------"
echo "Backend Python файлы: $(find backend/app -name "*.py" | wc -l)"
echo "Frontend TypeScript файлы: $(find frontend/src -name "*.ts" -o -name "*.tsx" | wc -l)"
echo "Компоненты React: $(find frontend/src/components -name "*.tsx" | wc -l)"
echo "Redux slices: $(find frontend/src/store -name "*Slice.ts" | wc -l)"
echo ""

echo "🚀 Команды для запуска:"
echo "--------------------------------------"
echo "Docker Compose: ${YELLOW}docker compose up --build${NC}"
echo "Frontend URL:   ${YELLOW}http://localhost:5173${NC}"
echo "Backend API:    ${YELLOW}http://localhost:8000/docs${NC}"
echo ""

echo "✅ Проверка завершена!"