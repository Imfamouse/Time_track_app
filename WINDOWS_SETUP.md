# 🪟 Запуск Time Track App на Windows

## 📋 Два варианта запуска

1. **С Docker** (рекомендуется) - проще и быстрее
2. **Без Docker** - если Docker недоступен

---

# ⭐ Вариант 1: Запуск с Docker (РЕКОМЕНДУЕТСЯ)

## Шаг 1: Установите Docker Desktop

1. Скачайте Docker Desktop для Windows:
   https://www.docker.com/products/docker-desktop/

2. Запустите установщик и следуйте инструкциям

3. После установки перезагрузите компьютер

4. Запустите Docker Desktop и дождитесь его запуска (иконка в трее)

## Шаг 2: Получите код проекта

### Вариант A: Через Git

Если Git установлен:
```powershell
git clone <URL-вашего-репозитория>
cd time-track-app
```

### Вариант B: Скачать ZIP

1. Скачайте проект как ZIP архив
2. Распакуйте в удобную папку
3. Откройте папку в PowerShell или Command Prompt

## Шаг 3: Запустите приложение

Откройте PowerShell или Command Prompt в папке проекта и выполните:

```powershell
docker compose up --build
```

**Готово!** Дождитесь сообщений:
```
✔ Container time_track_app-backend-1   Started
✔ Container time_track_app-frontend-1  Started
```

## Шаг 4: Откройте в браузере

1. **Frontend:** http://localhost:5173
2. **API Docs:** http://localhost:8000/docs

### Остановка приложения

Нажмите `Ctrl+C` в терминале, затем:
```powershell
docker compose down
```

---

# 🔧 Вариант 2: Запуск без Docker

## Требования

1. **Python 3.12+**
   - Скачать: https://www.python.org/downloads/
   - ⚠️ При установке отметьте "Add Python to PATH"

2. **Node.js 20+**
   - Скачать: https://nodejs.org/
   - LTS версия рекомендуется

## Установка Python и Node.js

### Python
1. Скачайте с https://www.python.org/downloads/
2. При установке **обязательно** отметьте:
   - ☑️ Add Python to PATH
   - ☑️ Install pip
3. Проверка:
   ```powershell
   python --version
   pip --version
   ```

### Node.js
1. Скачайте LTS версию с https://nodejs.org/
2. Установите с настройками по умолчанию
3. Проверка:
   ```powershell
   node --version
   npm --version
   ```

### pnpm (менеджер пакетов для frontend)
```powershell
npm install -g pnpm
```

## Запуск Backend

Откройте **первый терминал** PowerShell:

```powershell
# Перейдите в папку backend
cd backend

# Установите зависимости
pip install fastapi uvicorn pydantic

# Запустите сервер
python -m uvicorn app.main:app --reload
```

Вы должны увидеть:
```
INFO:     Uvicorn running on http://127.0.0.1:8000
INFO:     Application startup complete.
```

✅ Backend запущен на http://localhost:8000

## Запуск Frontend

Откройте **второй терминал** PowerShell (не закрывая первый!):

```powershell
# Перейдите в папку frontend
cd frontend

# Скопируйте файл окружения
copy .env.example .env

# Установите зависимости
pnpm install

# Запустите dev сервер
pnpm dev
```

Вы должны увидеть:
```
  VITE v5.4.20  ready in 300 ms

  ➜  Local:   http://localhost:5173/
```

✅ Frontend запущен на http://localhost:5173

## Откройте в браузере

1. **Frontend:** http://localhost:5173
2. **API Docs:** http://localhost:8000/docs

### Остановка приложения

В каждом терминале нажмите `Ctrl+C`

---

# 🎯 Проверка работоспособности

После запуска откройте браузер и проверьте:

## 1. Frontend (http://localhost:5173)

Вы должны увидеть:
- ✅ Заголовок "Time Track - Учет рабочего времени"
- ✅ 3 карточки статистики (Сегодня/Неделя/Месяц)
- ✅ Форму создания записи
- ✅ Таблицу с историей записей

## 2. Backend API (http://localhost:8000/docs)

Вы должны увидеть:
- ✅ Swagger UI документацию
- ✅ Список всех endpoints
- ✅ Возможность тестировать API прямо в браузере

## 3. Тест функциональности

### Создание записи времени:
1. Выберите проект из dropdown
2. Введите описание: "Тестирование приложения"
3. Нажмите "Добавить запись"
4. Появится уведомление "Запись времени создана!"
5. Запись появится в таблице

### Удаление записи:
1. Найдите запись в таблице
2. Нажмите кнопку с иконкой корзины
3. Подтвердите удаление
4. Запись исчезнет

---

# 🐛 Решение проблем

## Проблема: "docker: command not found"

**Решение:**
1. Убедитесь, что Docker Desktop запущен (иконка в трее)
2. Перезапустите терминал после установки Docker
3. Перезагрузите компьютер если нужно

## Проблема: "python: command not found"

**Решение:**
1. Переустановите Python с галочкой "Add to PATH"
2. Или используйте `py` вместо `python`:
   ```powershell
   py --version
   py -m uvicorn app.main:app --reload
   ```

## Проблема: "Error: Cannot find module"

**Решение для Frontend:**
```powershell
cd frontend
rm -r node_modules
pnpm install
```

## Проблема: "Port 8000 already in use"

**Решение:**
Порт занят другим приложением.

Вариант 1 - Найти и закрыть процесс:
```powershell
# Найти процесс на порту 8000
netstat -ano | findstr :8000

# Завершить процесс (замените PID на найденный)
taskkill /PID <номер_процесса> /F
```

Вариант 2 - Использовать другой порт:
```powershell
# Backend на порту 8001
python -m uvicorn app.main:app --reload --port 8001
```

Тогда измените `frontend/.env`:
```
VITE_API_BASE_URL=http://localhost:8001
```

## Проблема: "Permission denied" при установке пакетов

**Решение:**
Запустите PowerShell от имени администратора:
1. Найдите PowerShell в меню Пуск
2. ПКМ → "Запуск от имени администратора"
3. Выполните команды установки

## Проблема: Frontend показывает пустую страницу

**Решение:**
1. Откройте DevTools (F12)
2. Проверьте консоль на ошибки
3. Убедитесь, что Backend работает (http://localhost:8000/health)
4. Проверьте файл `frontend/.env`:
   ```
   VITE_API_BASE_URL=http://localhost:8000
   ```
5. Перезапустите Frontend:
   ```powershell
   pnpm dev
   ```

---

# 📁 Структура файлов после клонирования

```
time-track-app/
├── backend/
│   ├── app/
│   │   ├── main.py          # API endpoints
│   │   ├── models.py        # Модели данных
│   │   └── database.py      # Mock данные
│   ├── Dockerfile
│   └── pyproject.toml
├── frontend/
│   ├── src/
│   │   ├── components/      # React компоненты
│   │   ├── store/          # Redux state
│   │   ├── api/            # API клиент
│   │   ├── App.tsx
│   │   └── main.tsx
│   ├── Dockerfile
│   └── package.json
├── docker-compose.yml
└── README.md
```

---

# ✅ Контрольный список

Перед запуском убедитесь:

### Для Docker варианта:
- [ ] Docker Desktop установлен и запущен
- [ ] Иконка Docker в системном трее активна
- [ ] Код проекта скачан/клонирован
- [ ] Открыт терминал в папке проекта

### Для варианта без Docker:
- [ ] Python 3.12+ установлен (`python --version`)
- [ ] pip установлен (`pip --version`)
- [ ] Node.js 20+ установлен (`node --version`)
- [ ] pnpm установлен (`pnpm --version`)
- [ ] Код проекта скачан/клонирован

---

# 🎓 Полезные команды Windows

```powershell
# Проверка версий
python --version
node --version
pnpm --version

# Просмотр запущенных процессов на портах
netstat -ano | findstr :8000
netstat -ano | findstr :5173

# Очистка терминала
cls

# Просмотр текущей директории
cd

# Список файлов
dir

# Переход в родительскую папку
cd ..
```

---

# 🆘 Получение помощи

Если ничего не помогло:

1. **Проверьте логи Docker:**
   ```powershell
   docker compose logs backend
   docker compose logs frontend
   ```

2. **Проверьте логи терминала** на красные ошибки

3. **Откройте DevTools в браузере** (F12) → Console

4. **Создайте issue** в репозитории с:
   - Версией ОС (Windows 10/11)
   - Текстом ошибки
   - Скриншотом проблемы

---

# 🎉 Готово!

После успешного запуска вы увидите полнофункциональное приложение для учета рабочего времени с:

- ✅ Красивым UI на базе Ant Design
- ✅ Статистикой по времени
- ✅ Управлением записями
- ✅ 5 проектами с цветовой кодировкой
- ✅ REST API с документацией

**Приятного использования! 🚀**