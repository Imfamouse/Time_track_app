# Backend (FastAPI)

## Содержание
- `app/` — исходный код FastAPI.
- `pyproject.toml` — зависимости и настройки форматтеров/линтеров.
- `.env.example` — параметры подключения к БД, Redis и SMTP.

## Локальный запуск (после установки uv)
```
cp .env.example .env
uv sync --extra dev
uv run fastapi dev app/main.py --host 0.0.0.0 --port 8000
```

## Тесты
```
uv run pytest
```
