# Инфраструктурная основа

## Локальное окружение
- Docker Compose управляет контейнерами `frontend`, `backend`, `db` (PostgreSQL 16), `redis`, `worker`.
- Используем `.env` для параметров подключения (БД, SMTP, SSO mock).
- Для Python зависимостей применяется `uv` (альтернатива pip) с файлом `pyproject.toml`. Для фронтенда — `pnpm`.

## CI/CD
- GitHub Actions: проверка форматирования (Black, Ruff, Prettier, ESLint), unit-тесты backend/frontend, линтер SQL (sqlfluff) по мере появления.
- Jenkins (prod): оркестрирует сборку Docker-образов, прогон миграций Alembic, деплой на сервер.

## Управление секретами
- Секреты в CI хранятся в GitHub Secrets/корпоративном HashiCorp Vault.
- Для локальных разработчиков предоставляется `.env.example` с плейсхолдерами.

## Мониторинг и логирование
- Логи backend отправляются в ELK (Filebeat → Logstash → Elasticsearch → Kibana).
- Метрики собираются Prometheus агентом; алерты настраиваются в Alertmanager.

## Безопасность
- Политики RBAC через Keycloak (как SSO брокер) при продовом развёртывании.
- TLS завершается на корпоративном реверс-прокси (IIS + ARR).

## Планы дальнейшей детализации
- Подготовить Terraform/Ansible плейбуки (этап 3).
- Согласовать с безопасностью политику хранения логов.
