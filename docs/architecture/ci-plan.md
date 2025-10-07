# Черновик CI/CD пайплайна

## GitHub Actions (разработка)
- **Триггеры**: pull_request, push в `main`.
- **Шаги**:
  1. Checkout репозитория.
  2. Кеширование зависимостей Python (`uv`) и pnpm.
  3. Установка Python 3.12 и Node.js 20.
  4. Запуск `uv sync` для backend, `pnpm install` для frontend.
  5. Линтеры: `uv run ruff check`, `uv run black --check`, `pnpm lint` (ESLint + Prettier check).
  6. Тесты: `uv run pytest`, `pnpm test -- --runInBand` (Vitest).
  7. Сборка: `uv run task build` (пока заглушка), `pnpm build`.
  8. Генерация и загрузка отчётов покрытия (Codecov или внутренний сервис).

## Jenkins (stage/prod)
- Этапы: `checkout` → `build_backend_image` → `build_frontend_image` → `run_migrations` → `deploy`.
- Образы публикуются в внутренний Docker Registry (`registry.<PLACEHOLDER>.corp`).
- Деплой осуществляется через `docker stack deploy` на Windows сервер.

## Качество кода
- Минимальный порог покрытия тестами: 70% (будет уточнён).
- Строгая политика code review: минимум два аппрува для merge в `main`.

## Дальнейшие действия
- Настроить секреты и окружения в GitHub Actions.
- Интегрировать статический анализ SQL и инфраструктурного кода при его появлении.
