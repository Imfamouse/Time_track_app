# Time Track App

Корпоративная система учёта рабочего времени. Репозиторий содержит рабочий демо прототип с функциональным UI и API.

## 🚀 Быстрый старт

**Для запуска демо прототипа выберите один из способов:**

### Способ 1: Docker (Linux, macOS, Windows)

См. подробные инструкции в [DEMO_SETUP.md](DEMO_SETUP.md)

```bash
# Клонируйте репозиторий
git clone <repository-url>
cd time-track-app

# Запустите с помощью Docker Compose
docker compose up --build

# Откройте в браузере
# Frontend: http://localhost:5173
# API Docs: http://localhost:8000/docs
```

### Способ 2: Нативный запуск на Windows (без Docker)

См. подробные инструкции в **[WINDOWS_SETUP.md](WINDOWS_SETUP.md)**

```cmd
# Установка зависимостей
install-all.bat

# Запуск приложения
start-windows.bat
```

Или используя PowerShell:
```powershell
.\Install-All.ps1
.\Start-Windows.ps1
```

## ✨ Возможности демо

- ✅ Dashboard со статистикой (сегодня/неделя/месяц)
- ✅ Создание и удаление записей времени
- ✅ Таймер для отслеживания текущей работы
- ✅ 5 предустановленных проектов с цветовой кодировкой
- ✅ История всех записей в таблице
- ✅ Адаптивный дизайн (работает на мобильных)
- ✅ Swagger документация API

## 🏗️ Технологический стек

**Backend:**
- FastAPI (Python 3.12)
- Pydantic для валидации
- In-memory хранилище (демо)

**Frontend:**
- React 18 + TypeScript
- Redux Toolkit
- Ant Design
- Vite

**DevOps:**
- Docker & Docker Compose (опционально)
- Нативная поддержка Windows (Batch и PowerShell скрипты)
- GitHub Actions CI

## 📁 Структура репозитория

- `backend/` — FastAPI backend с REST API
- `frontend/` — React frontend с TypeScript
- `docs/` — Документация проекта
- `.github/workflows/` — CI конфигурация
- `docker-compose.yml` — Docker окружение
- `*.bat` — Batch скрипты для Windows
- `*.ps1` — PowerShell скрипты для Windows
- `DEMO_SETUP.md` — Инструкция по запуску демо (Docker)
- `WINDOWS_SETUP.md` — Инструкция по запуску на Windows (без Docker)

## 🔄 Этапы разработки

1. ✅ **Фаза 1:** Определение технологической основы и подготовка окружения
2. ✅ **Фаза 2:** Демо прототип с базовым функционалом
3. 🔄 **Фаза 3:** Интеграция базы данных и аутентификации
4. 📋 **Фаза 4:** Расширение функциональности для всех ролей
5. 📋 **Фаза 5:** Отчётность и аналитика

## 🧪 Тестирование

**Linux/macOS:**
```bash
# Backend тесты
cd backend
uv run pytest

# Frontend тесты
cd frontend
pnpm test
```

**Windows:**
```cmd
# Backend тесты
cd backend
uv run pytest

# Frontend тесты
cd frontend
pnpm test
```

*Примечание: Если не используете uv, активируйте venv перед запуском pytest*

## 📖 Дополнительная документация

- `WINDOWS_SETUP.md` — **Запуск на Windows без Docker**
- `DEMO_SETUP.md` — Запуск демо с Docker
- `docs/requirements/` — Требования и спецификации
- `docs/architecture/` — Архитектурные решения
- `docs/roadmap/` — План развития
- `backend/README.md` — Backend документация
- `frontend/README.md` — Frontend документация

## 🤝 Вклад в проект

1. Создайте ветку для вашей фичи
2. Убедитесь, что тесты проходят
3. Создайте Pull Request

## 📝 Лицензия

Лицензия будет добавлена после согласования с заказчиком.
