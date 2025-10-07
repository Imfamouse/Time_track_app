# Запуск проекта без реальных данных

## Назначение
Инструкция для разработчиков по запуску локального окружения с тестовыми параметрами. База данных будет пустой, а аутентификация переключена в режим `SSO_MODE=mock`, поэтому реальные учетные записи не требуются.

## Предварительные условия
- Docker и Docker Compose.
- Node.js 20 и pnpm 8 (при запуске фронтенда вне Docker).
- Python 3.12 с установленным `uv` (при запуске backend вне Docker).

## Шаги запуска
1. Скопируйте шаблоны переменных окружения:
   ```bash
   cp .env.example .env
   cp backend/.env.example backend/.env
   cp frontend/.env.example frontend/.env
   ```
2. Убедитесь, что в `backend/.env` установлены значения по умолчанию:
   ```ini
   SSO_MODE=mock
   SECRET_KEY=<PLACEHOLDER_SECRET>
   DATABASE_URL=postgresql+psycopg://user:password@db:5432/time_track
   ```
3. Запустите окружение в контейнерах:
   ```bash
   docker compose up --build
   ```
4. Backend станет доступен на `http://localhost:${BACKEND_PORT:-8000}/health`, фронтенд — на `http://localhost:${FRONTEND_PORT:-5173}`.

## Что доступно
- `GET /health` возвращает `{ "status": "ok" }` — проверка готовности сервиса.
- Интерфейс фронтенда отображает заголовок приложения и проксирует запросы на backend.

## Дополнительные примечания
- Для чистого запуска без данных достаточно остановить compose и удалить volume `pgdata`:
  ```bash
  docker compose down -v
  ```
- После появления миграций Alembic команды `uv run alembic upgrade head` и `uv run alembic downgrade -1` будут выполняться в контейнере backend.
- Не храните реальные секреты в `.env`; используйте только плейсхолдеры и локальные значения.
