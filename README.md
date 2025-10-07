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

## ✨ Возможности демо (Фаза 2)

**Что работает сейчас:**
- ✅ Dashboard со статистикой (сегодня/неделя/месяц)
- ✅ Создание и удаление записей времени
- ✅ Таймер для отслеживания текущей работы
- ✅ 5 предустановленных проектов с цветовой кодировкой
- ✅ История всех записей в таблице
- ✅ Адаптивный дизайн (работает на мобильных)
- ✅ Swagger документация API

**Что будет в следующих фазах:**
- 📋 PostgreSQL база данных (сейчас: in-memory)
- 📋 SSO аутентификация (сейчас: mock пользователь)
- 📋 7 ролей с правами доступа (сейчас: 1 роль)
- 📋 Управление пользователями и подразделениями
- 📋 Иерархия задач со статусами и приоритетами
- 📋 Workflow утверждения отчетов руководителем
- 📋 6 типов отчетов с экспортом (Excel, CSV, PDF)
- 📋 Email уведомления
- 📋 Импорт проектов из MS Project
- 📋 Графическая аналитика и дашборды

> 📖 **Полное ТЗ** см. в [`docs/requirements/system-requirements.md`](docs/requirements/system-requirements.md)

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
2. ✅ **Фаза 2:** Демо прототип с базовым функционалом ← **ВЫ ЗДЕСЬ**
3. 🔄 **Фаза 3:** Интеграция базы данных и аутентификации (следующая)
4. 📋 **Фаза 4:** Расширение функциональности для всех ролей (7 ролей + полный функционал)
5. 📋 **Фаза 5:** Отчётность и аналитика (6 типов отчетов + экспорт)

> 💡 **Почему сейчас базовый функционал?** См. подробное объяснение в [ROADMAP_EXPLANATION.md](ROADMAP_EXPLANATION.md)

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

### Запуск и работа
- `WINDOWS_SETUP.md` — **Запуск на Windows без Docker**
- `TROUBLESHOOTING.md` — **Решение проблем при запуске**
- `DEMO_SETUP.md` — Запуск демо с Docker
- `SCRIPTS_README.md` — Описание всех скриптов

### План развития
- `ROADMAP_EXPLANATION.md` — **Почему демо простое и что будет дальше**
- `docs/requirements/system-requirements.md` — **Полное ТЗ (300+ строк)**
- `docs/roadmap/` — Детальный план фаз разработки

### Архитектура и код
- `docs/architecture/` — Архитектурные решения
- `backend/README.md` — Backend документация
- `frontend/README.md` — Frontend документация

## 🤝 Вклад в проект

1. Создайте ветку для вашей фичи
2. Убедитесь, что тесты проходят
3. Создайте Pull Request

## 📝 Лицензия

Лицензия будет добавлена после согласования с заказчиком.
