# Скрипты для запуска на Windows

Этот файл содержит краткое описание всех скриптов для запуска приложения на Windows.

## 🎯 Рекомендуемый порядок использования

### Первый запуск

1. **Установка:** `install-all.bat` (или `Install-All.ps1`)
2. **Запуск:** `start-windows.bat` (или `Start-Windows.ps1`)

### Последующие запуски

- **Запуск:** `start-windows.bat` (или `Start-Windows.ps1`)
- **Остановка:** `stop-windows.bat` (или `Stop-Windows.ps1`)

## 📝 Batch скрипты (.bat)

### Установка

| Скрипт | Описание |
|--------|----------|
| `install-all.bat` | 🎯 **ГЛАВНЫЙ СКРИПТ** - Устанавливает все зависимости (backend + frontend) |
| `install-backend.bat` | Устанавливает только backend зависимости |
| `install-frontend.bat` | Устанавливает только frontend зависимости |

### Запуск

| Скрипт | Описание |
|--------|----------|
| `start-windows.bat` | 🎯 **ГЛАВНЫЙ СКРИПТ** - Запускает весь проект (backend + frontend) |
| `start-backend.bat` | Запускает только backend сервер |
| `start-frontend.bat` | Запускает только frontend сервер |
| `stop-windows.bat` | Останавливает все процессы приложения |

## 🔷 PowerShell скрипты (.ps1)

### Установка

| Скрипт | Описание |
|--------|----------|
| `Install-All.ps1` | 🎯 **ГЛАВНЫЙ СКРИПТ** - Устанавливает все зависимости (backend + frontend) |
| `Install-Backend.ps1` | Устанавливает только backend зависимости |
| `Install-Frontend.ps1` | Устанавливает только frontend зависимости |

### Запуск

| Скрипт | Описание |
|--------|----------|
| `Start-Windows.ps1` | 🎯 **ГЛАВНЫЙ СКРИПТ** - Запускает весь проект (backend + frontend) |
| `Start-Backend.ps1` | Запускает только backend сервер |
| `Start-Frontend.ps1` | Запускает только frontend сервер |
| `Stop-Windows.ps1` | Останавливает все процессы приложения |

## 🔍 Что делает каждый скрипт

### install-all.bat / Install-All.ps1
- Вызывает install-backend и install-frontend
- Проверяет наличие всех необходимых инструментов
- Устанавливает все зависимости проекта

### install-backend.bat / Install-Backend.ps1
- Проверяет наличие Python
- Использует `uv` если установлен, иначе создает venv и использует pip
- Устанавливает FastAPI, uvicorn, pydantic и dev-зависимости

### install-frontend.bat / Install-Frontend.ps1
- Проверяет наличие Node.js
- Использует `pnpm` если установлен, иначе использует npm
- Устанавливает React, TypeScript, Vite и все зависимости
- Создает файл `.env` если его нет

### start-windows.bat / Start-Windows.ps1
- Запускает backend в отдельном окне
- Ждет 5 секунд для инициализации backend
- Запускает frontend в отдельном окне
- Показывает информацию о доступных URL

### start-backend.bat / Start-Backend.ps1
- Запускает uvicorn сервер на порту 8000
- Использует режим reload для автоматической перезагрузки при изменениях
- Доступен по адресу http://localhost:8000

### start-frontend.bat / Start-Frontend.ps1
- Запускает Vite dev-сервер на порту 5173
- Создает .env файл если его нет
- Доступен по адресу http://localhost:5173

### stop-windows.bat / Stop-Windows.ps1
- Останавливает все процессы python (backend)
- Останавливает все процессы node (frontend)
- Закрывает окна запущенных серверов

### FIX_404.bat / Fix-404.ps1
- Исправляет ошибку 404 на frontend
- Копирует index.html из public/ в корень frontend/
- Используется если frontend показывает 404

## 💡 Советы по использованию

### Batch vs PowerShell

**Используйте Batch (.bat) если:**
- Вы привыкли к классической командной строке Windows
- Хотите простые двойные щелчки для запуска
- Не хотите настраивать политики выполнения скриптов

**Используйте PowerShell (.ps1) если:**
- Вы предпочитаете современный PowerShell
- Хотите красивый цветной вывод
- Вам нужна более продвинутая обработка ошибок

### Первый запуск PowerShell скриптов

Если PowerShell блокирует выполнение скриптов, выполните один раз:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Запуск двойным щелчком

Все `.bat` файлы можно запускать просто двойным щелчком мыши.

Для `.ps1` файлов:
1. Правый клик на файле
2. Выбрать "Выполнить с помощью PowerShell"

### Запуск из командной строки

**Batch:**
```cmd
install-all.bat
start-windows.bat
```

**PowerShell:**
```powershell
.\Install-All.ps1
.\Start-Windows.ps1
```

## 🔧 Расширенное использование

### Запуск только backend

Если вы работаете только с backend API:
```cmd
start-backend.bat
```

### Запуск только frontend

Если backend уже запущен и вы работаете только с UI:
```cmd
start-frontend.bat
```

### Переустановка зависимостей

Если что-то пошло не так с зависимостями:
```cmd
# Удалите папки
rmdir /s /q backend\venv
rmdir /s /q frontend\node_modules

# Установите заново
install-all.bat
```

## ❓ Решение проблем

### "Python не найден"
Установите Python с https://python.org/downloads/
При установке отметьте "Add Python to PATH"

### "Node.js не найден"
Установите Node.js с https://nodejs.org/

### "Порт уже занят"
Закройте другие приложения на портах 8000 или 5173

### PowerShell блокирует скрипты
Выполните от имени администратора:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## 📚 Дополнительная информация

- [WINDOWS_SETUP.md](WINDOWS_SETUP.md) - Полная инструкция по запуску на Windows
- [README.md](README.md) - Общая документация проекта
- [DEMO_SETUP.md](DEMO_SETUP.md) - Запуск через Docker