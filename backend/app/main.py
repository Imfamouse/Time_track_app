from datetime import datetime, timedelta
from typing import Optional

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware

from app.models import (
    Project,
    TimeEntry,
    TimeEntryCreate,
    TimeEntryUpdate,
    User,
    TimeStats,
)
from app import database

app = FastAPI(title="Time Track API", version="0.1.0")

# Настройка CORS для работы с frontend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173", "http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/health", tags=["health"])
def read_health() -> dict[str, str]:
    """Проверка готовности сервиса."""
    return {"status": "ok"}


# === Проекты ===
@app.get("/api/projects", response_model=list[Project], tags=["projects"])
def get_projects() -> list[Project]:
    """Получить список всех проектов."""
    return database.get_all_projects()


@app.get("/api/projects/{project_id}", response_model=Project, tags=["projects"])
def get_project(project_id: int) -> Project:
    """Получить проект по ID."""
    project = database.get_project(project_id)
    if not project:
        raise HTTPException(status_code=404, detail="Project not found")
    return project


# === Пользователи ===
@app.get("/api/users", response_model=list[User], tags=["users"])
def get_users() -> list[User]:
    """Получить список всех пользователей."""
    return database.get_all_users()


@app.get("/api/users/me", response_model=User, tags=["users"])
def get_current_user() -> User:
    """Получить текущего пользователя (демо - всегда user_id=1)."""
    user = database.get_user(1)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user


# === Записи времени ===
@app.get("/api/time-entries", response_model=list[TimeEntry], tags=["time-entries"])
def get_time_entries(
    user_id: Optional[int] = None,
    limit: int = 100,
) -> list[TimeEntry]:
    """Получить список записей времени."""
    return database.get_time_entries(user_id=user_id, limit=limit)


@app.get("/api/time-entries/{entry_id}", response_model=TimeEntry, tags=["time-entries"])
def get_time_entry(entry_id: int) -> TimeEntry:
    """Получить запись времени по ID."""
    entry = database.get_time_entry(entry_id)
    if not entry:
        raise HTTPException(status_code=404, detail="Time entry not found")
    return entry


@app.post("/api/time-entries", response_model=TimeEntry, tags=["time-entries"], status_code=201)
def create_time_entry(entry: TimeEntryCreate) -> TimeEntry:
    """Создать новую запись времени."""
    # Проверка существования проекта
    if not database.get_project(entry.project_id):
        raise HTTPException(status_code=404, detail="Project not found")
    
    entry_data = entry.model_dump()
    return database.create_time_entry(entry_data)


@app.patch("/api/time-entries/{entry_id}", response_model=TimeEntry, tags=["time-entries"])
def update_time_entry(entry_id: int, update: TimeEntryUpdate) -> TimeEntry:
    """Обновить запись времени."""
    updated_entry = database.update_time_entry(
        entry_id, 
        update.model_dump(exclude_unset=True)
    )
    if not updated_entry:
        raise HTTPException(status_code=404, detail="Time entry not found")
    return updated_entry


@app.post("/api/time-entries/{entry_id}/stop", response_model=TimeEntry, tags=["time-entries"])
def stop_time_entry(entry_id: int) -> TimeEntry:
    """Остановить таймер записи времени."""
    entry = database.stop_time_entry(entry_id)
    if not entry:
        raise HTTPException(
            status_code=404, 
            detail="Time entry not found or already stopped"
        )
    return entry


@app.delete("/api/time-entries/{entry_id}", status_code=204, tags=["time-entries"])
def delete_time_entry(entry_id: int) -> None:
    """Удалить запись времени."""
    if not database.delete_time_entry(entry_id):
        raise HTTPException(status_code=404, detail="Time entry not found")


# === Статистика ===
@app.get("/api/stats", response_model=TimeStats, tags=["statistics"])
def get_stats(user_id: int = 1) -> TimeStats:
    """Получить статистику по времени."""
    entries = database.get_time_entries(user_id=user_id)
    
    now = datetime.now()
    today_start = now.replace(hour=0, minute=0, second=0, microsecond=0)
    week_start = today_start - timedelta(days=today_start.weekday())
    month_start = today_start.replace(day=1)
    
    # Фильтрация по периодам
    today_entries = [e for e in entries if e.start_time >= today_start and not e.is_running]
    week_entries = [e for e in entries if e.start_time >= week_start and not e.is_running]
    month_entries = [e for e in entries if e.start_time >= month_start and not e.is_running]
    
    # Подсчет часов
    total_today = sum(e.duration_minutes or 0 for e in today_entries) / 60
    total_week = sum(e.duration_minutes or 0 for e in week_entries) / 60
    total_month = sum(e.duration_minutes or 0 for e in month_entries) / 60
    
    # Топ проектов за месяц
    project_hours: dict[int, float] = {}
    for entry in month_entries:
        if entry.duration_minutes:
            project_hours[entry.project_id] = project_hours.get(entry.project_id, 0) + entry.duration_minutes / 60
    
    top_projects = []
    for project_id, hours in sorted(project_hours.items(), key=lambda x: x[1], reverse=True)[:5]:
        project = database.get_project(project_id)
        if project:
            top_projects.append({
                "project_id": project_id,
                "project_name": project.name,
                "hours": round(hours, 1),
                "color": project.color,
            })
    
    return TimeStats(
        total_hours_today=round(total_today, 1),
        total_hours_week=round(total_week, 1),
        total_hours_month=round(total_month, 1),
        entries_count=len(entries),
        top_projects=top_projects,
    )
