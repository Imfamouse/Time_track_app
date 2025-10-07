# 🪟 Запуск Time Track App на Windows без Docker

Этот документ содержит подробные инструкции по установке и запуску приложения Time Track на Windows без использования Docker.

## 📋 Требования

### Обязательно

1. **Python 3.12 или выше**
   - Скачать: https://www.python.org/downloads/
   - ⚠️ При установке обязательно отметьте "Add Python to PATH"

2. **Node.js 20 или выше**
   - Скачать: https://nodejs.org/
   - Рекомендуется LTS версия

### Рекомендуется (но не обязательно)

1. **uv** - современный менеджер пакетов Python
   - Установка: `pip install uv`
   - Или скачать с https://github.com/astral-sh/uv

2. **pnpm** - быстрый менеджер пакетов для Node.js
   - Установка: `npm install -g pnpm`
   - Или скачать с https://pnpm.io/

## 🚀 Быстрый старт

### Вариант 1: Автоматическая установка (рекомендуется)

#### Используя Batch файлы (.bat)

1. **Установите все зависимости:**
   ```cmd
   install-all.bat
   ```

2. **Запустите приложение:**
   ```cmd
   start-windows.bat
   ```

#### Используя PowerShell (.ps1)

1. **Разрешите выполнение скриптов PowerShell (если требуется):**
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

2. **Установите все зависимости:**
   ```powershell
   .\Install-All.ps1
   ```

3. **Запустите приложение:**
   ```powershell
   .\Start-Windows.ps1
   ```

### Вариант 2: Ручная установка

#### Backend

1. **Перейдите в директорию backend:**
   ```cmd
   cd backend
   ```

2. **Установите зависимости (выберите один из способов):**

   **Способ A: С использованием uv (рекомендуется):**
   ```cmd
   uv sync --extra dev
   ```

   **Способ B: С использованием pip и venv:**
   ```cmd
   python -m venv venv
   venv\Scripts\activate
   pip install -r requirements.txt
   ```

3. **Запустите backend:**

   **С uv:**
   ```cmd
   uv run uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
   ```

   **С venv:**
   ```cmd
   venv\Scripts\activate
   python -m uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
   ```

#### Frontend

1. **Откройте новое окно командной строки и перейдите в директорию frontend:**
   ```cmd
   cd frontend
   ```

2. **Создайте файл .env:**
   ```cmd
   echo VITE_API_BASE_URL=http://localhost:8000 > .env
   ```

3. **Установите зависимости (выберите один из способов):**

   **Способ A: С использованием pnpm (рекомендуется):**
   ```cmd
   pnpm install
   ```

   **Способ B: С использованием npm:**
   ```cmd
   npm install
   ```

4. **Запустите frontend:**

   **С pnpm:**
   ```cmd
   pnpm dev
   ```

   **С npm:**
   ```cmd
   npm run dev
   ```

## 🌐 Доступ к приложению

После запуска приложение будет доступно по следующим адресам:

- **Frontend (UI):** http://localhost:5173
- **Backend (API):** http://localhost:8000
- **API Документация (Swagger):** http://localhost:8000/docs
- **Альтернативная документация (ReDoc):** http://localhost:8000/redoc

## 🛑 Остановка приложения

### Автоматически

**Batch:**
```cmd
stop-windows.bat
```

**PowerShell:**
```powershell
.\Stop-Windows.ps1
```

### Вручную

Просто закройте окна командной строки или PowerShell, в которых запущены backend и frontend, или нажмите `Ctrl+C` в каждом окне.

## 📝 Доступные скрипты

### Batch файлы (.bat)

| Скрипт | Описание |
|--------|----------|
| `install-all.bat` | Установка всех зависимостей (backend + frontend) |
| `install-backend.bat` | Установка только backend зависимостей |
| `install-frontend.bat` | Установка только frontend зависимостей |
| `start-windows.bat` | Запуск всего приложения (backend + frontend) |
| `start-backend.bat` | Запуск только backend |
| `start-frontend.bat` | Запуск только frontend |
| `stop-windows.bat` | Остановка приложения |

### PowerShell скрипты (.ps1)

| Скрипт | Описание |
|--------|----------|
| `Install-All.ps1` | Установка всех зависимостей (backend + frontend) |
| `Install-Backend.ps1` | Установка только backend зависимостей |
| `Install-Frontend.ps1` | Установка только frontend зависимостей |
| `Start-Windows.ps1` | Запуск всего приложения (backend + frontend) |
| `Start-Backend.ps1` | Запуск только backend |
| `Start-Frontend.ps1` | Запуск только frontend |
| `Stop-Windows.ps1` | Остановка приложения |

## 🧪 Тестирование

### Backend тесты

```cmd
cd backend
uv run pytest
```

Или с venv:
```cmd
cd backend
venv\Scripts\activate
pytest
```

### Frontend тесты

```cmd
cd frontend
pnpm test
```

Или с npm:
```cmd
cd frontend
npm test
```

## ❓ Решение проблем

### Python не найден

**Проблема:** При запуске скрипта появляется ошибка "Python не найден"

**Решение:**
1. Установите Python с https://python.org/downloads/
2. Убедитесь, что отметили "Add Python to PATH" при установке
3. Перезапустите командную строку
4. Проверьте установку: `python --version`

### Node.js не найден

**Проблема:** При запуске скрипта появляется ошибка "Node.js не найден"

**Решение:**
1. Установите Node.js с https://nodejs.org/
2. Перезапустите командную строку
3. Проверьте установку: `node --version`

### Порт уже занят

**Проблема:** Ошибка "Address already in use" при запуске

**Решение:**
1. Закройте другие приложения, использующие порты 8000 или 5173
2. Или измените порт в скрипте запуска:
   - Backend: добавьте `--port 8001` к команде uvicorn
   - Frontend: создайте файл `frontend/.env` с `VITE_PORT=5174`

### PowerShell блокирует выполнение скриптов

**Проблема:** "cannot be loaded because running scripts is disabled on this system"

**Решение:**
Выполните от имени администратора:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Ошибки при установке зависимостей

**Проблема:** Не удается установить пакеты через pip или npm

**Решение:**
1. Обновите pip: `python -m pip install --upgrade pip`
2. Обновите npm: `npm install -g npm@latest`
3. Проверьте подключение к интернету
4. Попробуйте использовать VPN если есть проблемы с доступом к репозиториям

### Backend не может подключиться к frontend

**Проблема:** CORS ошибки в консоли браузера

**Решение:**
1. Убедитесь, что backend запущен на порту 8000
2. Проверьте файл `frontend/.env` - должен содержать `VITE_API_BASE_URL=http://localhost:8000`
3. Перезапустите frontend после изменения .env

## 💡 Полезные советы

1. **Используйте современные инструменты:**
   - `uv` вместо `pip` для Python (быстрее)
   - `pnpm` вместо `npm` для Node.js (экономит место)

2. **Разработка:**
   - Backend автоматически перезагружается при изменении кода (--reload)
   - Frontend поддерживает Hot Module Replacement (HMR)

3. **Проверка API:**
   - Используйте Swagger UI по адресу http://localhost:8000/docs
   - Там можно тестировать все endpoints без написания кода

4. **Просмотр логов:**
   - Все логи отображаются в окнах командной строки
   - Для backend: следите за окном "Time Track Backend"
   - Для frontend: следите за окном "Time Track Frontend"

## 📚 Дополнительная информация

- [README.md](README.md) - Общая информация о проекте
- [DEMO_SETUP.md](DEMO_SETUP.md) - Запуск через Docker
- [backend/README.md](backend/README.md) - Backend документация
- [frontend/README.md](frontend/README.md) - Frontend документация

## 🆘 Поддержка

Если у вас возникли проблемы:
1. Проверьте раздел "Решение проблем" выше
2. Убедитесь, что все требования установлены
3. Проверьте логи в окнах командной строки
4. Создайте issue в репозитории проекта