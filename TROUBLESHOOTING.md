# Решение проблем - Time Track App на Windows

Этот документ содержит решения самых частых проблем при запуске приложения на Windows.

## 🔴 Критические проблемы

### 1. Frontend показывает 404 ошибку

**Симптомы:**
- При открытии http://localhost:5173 появляется страница с ошибкой 404
- В логах frontend нет ошибок, сервер запущен нормально

**Причина:**
Vite требует, чтобы файл `index.html` находился в корне проекта (`frontend/`), а не в папке `public/`.

**Решение (автоматическое):**

Запустите скрипт исправления:
```cmd
FIX_404.bat
```

Или в PowerShell:
```powershell
.\Fix-404.ps1
```

**Решение (ручное):**

```cmd
copy frontend\public\index.html frontend\index.html
```

После этого перезапустите frontend.

---

### 2. Python не найден

**Симптомы:**
- Ошибка при запуске: `'python' is not recognized as an internal or external command`

**Решение:**

1. Установите Python 3.12+ с https://python.org/downloads/
2. **ВАЖНО:** При установке отметьте галочку "Add Python to PATH"
3. Перезапустите командную строку
4. Проверьте: `python --version`

Если уже установлен, но не в PATH:
1. Найдите путь к Python (обычно `C:\Python312` или `C:\Users\YourName\AppData\Local\Programs\Python\Python312`)
2. Добавьте в PATH:
   - Windows 10/11: Параметры → Система → О программе → Дополнительные параметры системы → Переменные среды
   - Добавьте путь к Python в переменную PATH

---

### 3. Node.js не найден

**Симптомы:**
- Ошибка при запуске: `'node' is not recognized as an internal or external command`

**Решение:**

1. Установите Node.js 20+ с https://nodejs.org/ (LTS версия)
2. Перезапустите командную строку
3. Проверьте: `node --version`

---

### 4. Порт уже занят

**Симптомы:**
- Backend: `Address already in use: 0.0.0.0:8000`
- Frontend: `Port 5173 is already in use`

**Решение:**

**Вариант A: Освободить порт**
```cmd
# Найти процесс на порту 8000
netstat -ano | findstr :8000

# Завершить процесс (замените PID на номер из предыдущей команды)
taskkill /PID <PID> /F
```

**Вариант B: Изменить порт**

Backend - в файле `start-backend.bat` измените:
```batch
uvicorn app.main:app --host 0.0.0.0 --port 8001 --reload
```

Frontend - создайте/измените `frontend/.env`:
```
VITE_PORT=5174
```

---

## ⚠️ Проблемы установки

### 5. Ошибки при установке через pip

**Симптомы:**
- `ERROR: Could not install packages due to an OSError`
- Таймауты при скачивании пакетов

**Решение:**

1. Обновите pip:
   ```cmd
   python -m pip install --upgrade pip
   ```

2. Попробуйте с флагом --user:
   ```cmd
   pip install --user fastapi uvicorn pydantic
   ```

3. Если проблемы с доступом к PyPI:
   ```cmd
   pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org <package>
   ```

4. Попробуйте установить uv (быстрее и надежнее):
   ```cmd
   pip install uv
   ```

---

### 6. Ошибки при установке через npm/pnpm

**Симптомы:**
- `EACCES: permission denied`
- `ERR_SOCKET_TIMEOUT`

**Решение:**

1. Запустите командную строку от имени администратора

2. Очистите кэш npm:
   ```cmd
   npm cache clean --force
   ```

3. Попробуйте без сохранения package-lock:
   ```cmd
   npm install --no-package-lock
   ```

4. Если используете корпоративный прокси, настройте npm:
   ```cmd
   npm config set proxy http://proxy.company.com:8080
   npm config set https-proxy http://proxy.company.com:8080
   ```

---

### 7. PowerShell блокирует выполнение скриптов

**Симптомы:**
- `cannot be loaded because running scripts is disabled on this system`

**Решение:**

Выполните в PowerShell от имени администратора:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Или используйте .bat файлы вместо .ps1.

---

## 🟡 Проблемы запуска

### 8. Backend запускается, но API не отвечает

**Симптомы:**
- Backend окно показывает "Uvicorn running on http://0.0.0.0:8000"
- Но http://localhost:8000/docs не открывается

**Решение:**

1. Проверьте firewall - возможно блокирует Python
2. Попробуйте другой адрес:
   - http://127.0.0.1:8000/docs
   - http://0.0.0.0:8000/docs
3. Проверьте что не запущено несколько копий backend
4. Перезапустите backend с явным указанием хоста:
   ```cmd
   uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload
   ```

---

### 9. Frontend запущен, но показывает пустую страницу

**Симптомы:**
- http://localhost:5173 открывается, но ничего не отображается
- В консоли браузера ошибки загрузки модулей

**Решение:**

1. Проверьте консоль браузера (F12) на наличие ошибок
2. Убедитесь что файл `frontend/index.html` существует
3. Очистите кэш браузера (Ctrl+Shift+Delete)
4. Перезапустите frontend с очисткой:
   ```cmd
   cd frontend
   rmdir /s /q node_modules\.vite
   pnpm dev
   ```

---

### 10. CORS ошибки в браузере

**Симптомы:**
- В консоли браузера: `Access to XMLHttpRequest at 'http://localhost:8000' ... has been blocked by CORS policy`

**Решение:**

1. Убедитесь что backend запущен
2. Проверьте файл `frontend/.env`:
   ```
   VITE_API_BASE_URL=http://localhost:8000
   ```
3. Проверьте что backend использует правильный порт (8000)
4. Перезапустите оба сервиса

---

## 🔵 Проблемы с зависимостями

### 11. Конфликты версий Python пакетов

**Симптомы:**
- `ERROR: pip's dependency resolver does not currently take into account all the packages that are installed`

**Решение:**

Используйте виртуальное окружение:
```cmd
cd backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
```

Или переключитесь на uv:
```cmd
pip install uv
cd backend
uv sync
```

---

### 12. Несовместимость версий Node.js

**Симптомы:**
- `Error: error:0308010C:digital envelope routines::unsupported`

**Решение:**

1. Проверьте версию Node.js:
   ```cmd
   node --version
   ```
   Должна быть 20.x или выше

2. Если версия старая, обновите Node.js с https://nodejs.org/

3. Или используйте nvm для Windows:
   ```cmd
   nvm install 20
   nvm use 20
   ```

---

## 🟢 Производительность

### 13. Медленная установка зависимостей

**Решение:**

**Для Python:**
```cmd
pip install uv
uv sync --extra dev
```
uv в 10-100 раз быстрее pip

**Для Node.js:**
```cmd
npm install -g pnpm
pnpm install
```
pnpm быстрее npm и экономит место

---

### 14. Медленный запуск приложения

**Причины и решения:**

1. **Антивирус проверяет файлы:**
   - Добавьте папку проекта в исключения антивируса

2. **Windows Defender:**
   - Временно отключите Real-time protection при разработке

3. **Много процессов в фоне:**
   - Закройте ненужные приложения

---

## 🛠️ Инструменты диагностики

### Проверка портов

```cmd
# Показать все используемые порты
netstat -ano

# Показать только порты 8000 и 5173
netstat -ano | findstr :8000
netstat -ano | findstr :5173
```

### Проверка установленных инструментов

```cmd
python --version
node --version
npm --version
pip --version

# Опционально
uv --version
pnpm --version
```

### Проверка процессов

```cmd
# Python процессы
tasklist | findstr python.exe

# Node процессы
tasklist | findstr node.exe
```

### Логи

Все логи отображаются в окнах командной строки. Для сохранения логов:

```cmd
start-backend.bat > backend.log 2>&1
start-frontend.bat > frontend.log 2>&1
```

---

## 📞 Дальнейшая помощь

Если проблема не решена:

1. ✅ Проверьте все пункты выше
2. ✅ Прочитайте [WINDOWS_SETUP.md](WINDOWS_SETUP.md)
3. ✅ Проверьте [SCRIPTS_README.md](SCRIPTS_README.md)
4. ✅ Создайте issue в репозитории с:
   - Описанием проблемы
   - Версиями Python и Node.js
   - Текстом ошибки
   - Логами запуска

---

## ✅ Быстрая диагностика

Запустите эти команды и отправьте результат:

```cmd
echo === Версии ===
python --version
node --version
npm --version

echo === Порты ===
netstat -ano | findstr :8000
netstat -ano | findstr :5173

echo === Файлы ===
dir frontend\index.html
dir frontend\.env
dir backend\venv

echo === Процессы ===
tasklist | findstr python.exe
tasklist | findstr node.exe
```