"""Модели данных для демо прототипа."""
from datetime import datetime
from typing import Optional
from pydantic import BaseModel, Field


class Project(BaseModel):
    """Модель проекта."""
    id: int
    name: str
    description: Optional[str] = None
    color: str = "#1890ff"


class TimeEntry(BaseModel):
    """Модель записи времени."""
    id: int
    user_id: int
    project_id: int
    description: str
    start_time: datetime
    end_time: Optional[datetime] = None
    duration_minutes: Optional[int] = None
    is_running: bool = False


class TimeEntryCreate(BaseModel):
    """Модель для создания записи времени."""
    user_id: int = Field(default=1)
    project_id: int
    description: str
    start_time: datetime = Field(default_factory=datetime.now)


class TimeEntryUpdate(BaseModel):
    """Модель для обновления записи времени."""
    description: Optional[str] = None
    end_time: Optional[datetime] = None
    project_id: Optional[int] = None


class User(BaseModel):
    """Модель пользователя."""
    id: int
    name: str
    email: str
    role: str = "employee"


class TimeStats(BaseModel):
    """Статистика по времени."""
    total_hours_today: float
    total_hours_week: float
    total_hours_month: float
    entries_count: int
    top_projects: list[dict]