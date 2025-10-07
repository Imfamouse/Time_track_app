"""In-memory database для демо прототипа."""
from datetime import datetime, timedelta
from typing import Optional
from app.models import Project, TimeEntry, User

# Mock данные
projects_db: dict[int, Project] = {
    1: Project(id=1, name="Веб-разработка", description="Разработка веб-приложений", color="#1890ff"),
    2: Project(id=2, name="Мобильная разработка", description="iOS и Android приложения", color="#52c41a"),
    3: Project(id=3, name="Дизайн", description="UI/UX дизайн", color="#fa8c16"),
    4: Project(id=4, name="Тестирование", description="QA и тестирование", color="#eb2f96"),
    5: Project(id=5, name="Документация", description="Техническая документация", color="#722ed1"),
}

users_db: dict[int, User] = {
    1: User(id=1, name="Иван Петров", email="ivan.petrov@example.com", role="employee"),
    2: User(id=2, name="Мария Сидорова", email="maria.sidorova@example.com", role="manager"),
    3: User(id=3, name="Алексей Иванов", email="alexey.ivanov@example.com", role="employee"),
}

# Генерация примеров записей времени
now = datetime.now()
time_entries_db: dict[int, TimeEntry] = {
    1: TimeEntry(
        id=1,
        user_id=1,
        project_id=1,
        description="Разработка API для учета времени",
        start_time=now - timedelta(hours=3),
        end_time=now - timedelta(hours=1),
        duration_minutes=120,
        is_running=False,
    ),
    2: TimeEntry(
        id=2,
        user_id=1,
        project_id=2,
        description="Код-ревью мобильного приложения",
        start_time=now - timedelta(hours=5),
        end_time=now - timedelta(hours=3, minutes=30),
        duration_minutes=90,
        is_running=False,
    ),
    3: TimeEntry(
        id=3,
        user_id=1,
        project_id=3,
        description="Работа над прототипом интерфейса",
        start_time=now - timedelta(days=1, hours=4),
        end_time=now - timedelta(days=1, hours=2),
        duration_minutes=120,
        is_running=False,
    ),
    4: TimeEntry(
        id=4,
        user_id=1,
        project_id=1,
        description="Исправление багов в backend",
        start_time=now - timedelta(days=1, hours=7),
        end_time=now - timedelta(days=1, hours=5),
        duration_minutes=120,
        is_running=False,
    ),
    5: TimeEntry(
        id=5,
        user_id=1,
        project_id=4,
        description="Написание unit тестов",
        start_time=now - timedelta(days=2, hours=3),
        end_time=now - timedelta(days=2, hours=1),
        duration_minutes=120,
        is_running=False,
    ),
}

# Счетчик для новых записей
next_entry_id = max(time_entries_db.keys()) + 1 if time_entries_db else 1


def get_all_projects() -> list[Project]:
    """Получить все проекты."""
    return list(projects_db.values())


def get_project(project_id: int) -> Optional[Project]:
    """Получить проект по ID."""
    return projects_db.get(project_id)


def get_all_users() -> list[User]:
    """Получить всех пользователей."""
    return list(users_db.values())


def get_user(user_id: int) -> Optional[User]:
    """Получить пользователя по ID."""
    return users_db.get(user_id)


def get_time_entries(user_id: Optional[int] = None, limit: int = 100) -> list[TimeEntry]:
    """Получить записи времени."""
    entries = list(time_entries_db.values())
    if user_id is not None:
        entries = [e for e in entries if e.user_id == user_id]
    entries.sort(key=lambda x: x.start_time, reverse=True)
    return entries[:limit]


def get_time_entry(entry_id: int) -> Optional[TimeEntry]:
    """Получить запись времени по ID."""
    return time_entries_db.get(entry_id)


def create_time_entry(entry_data: dict) -> TimeEntry:
    """Создать новую запись времени."""
    global next_entry_id
    entry = TimeEntry(
        id=next_entry_id,
        is_running=entry_data.get("end_time") is None,
        duration_minutes=None if entry_data.get("end_time") is None else _calculate_duration(
            entry_data["start_time"], entry_data["end_time"]
        ),
        **entry_data
    )
    time_entries_db[next_entry_id] = entry
    next_entry_id += 1
    return entry


def update_time_entry(entry_id: int, update_data: dict) -> Optional[TimeEntry]:
    """Обновить запись времени."""
    entry = time_entries_db.get(entry_id)
    if not entry:
        return None
    
    updated_data = entry.model_dump()
    updated_data.update({k: v for k, v in update_data.items() if v is not None})
    
    # Пересчитать продолжительность если задано end_time
    if "end_time" in update_data and update_data["end_time"] is not None:
        updated_data["is_running"] = False
        updated_data["duration_minutes"] = _calculate_duration(
            updated_data["start_time"], updated_data["end_time"]
        )
    
    updated_entry = TimeEntry(**updated_data)
    time_entries_db[entry_id] = updated_entry
    return updated_entry


def delete_time_entry(entry_id: int) -> bool:
    """Удалить запись времени."""
    if entry_id in time_entries_db:
        del time_entries_db[entry_id]
        return True
    return False


def stop_time_entry(entry_id: int) -> Optional[TimeEntry]:
    """Остановить таймер записи времени."""
    entry = time_entries_db.get(entry_id)
    if not entry or not entry.is_running:
        return None
    
    end_time = datetime.now()
    return update_time_entry(entry_id, {"end_time": end_time})


def _calculate_duration(start: datetime, end: datetime) -> int:
    """Вычислить продолжительность в минутах."""
    delta = end - start
    return int(delta.total_seconds() / 60)