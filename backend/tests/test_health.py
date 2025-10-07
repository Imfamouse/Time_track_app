from httpx import AsyncClient
from fastapi import status

from app.main import app


async def test_health_endpoint() -> None:
    """Test health check endpoint."""
    async with AsyncClient(app=app, base_url="http://test") as client:
        response = await client.get("/health")
    assert response.status_code == status.HTTP_200_OK
    assert response.json() == {"status": "ok"}


async def test_get_projects() -> None:
    """Test getting all projects."""
    async with AsyncClient(app=app, base_url="http://test") as client:
        response = await client.get("/api/projects")
    assert response.status_code == status.HTTP_200_OK
    projects = response.json()
    assert isinstance(projects, list)
    assert len(projects) > 0


async def test_get_time_entries() -> None:
    """Test getting time entries."""
    async with AsyncClient(app=app, base_url="http://test") as client:
        response = await client.get("/api/time-entries")
    assert response.status_code == status.HTTP_200_OK
    entries = response.json()
    assert isinstance(entries, list)


async def test_create_time_entry() -> None:
    """Test creating a new time entry."""
    async with AsyncClient(app=app, base_url="http://test") as client:
        response = await client.post(
            "/api/time-entries",
            json={
                "user_id": 1,
                "project_id": 1,
                "description": "Test task",
                "start_time": "2025-10-07T10:00:00",
            },
        )
    assert response.status_code == status.HTTP_201_CREATED
    entry = response.json()
    assert entry["description"] == "Test task"
    assert entry["project_id"] == 1


async def test_get_stats() -> None:
    """Test getting statistics."""
    async with AsyncClient(app=app, base_url="http://test") as client:
        response = await client.get("/api/stats?user_id=1")
    assert response.status_code == status.HTTP_200_OK
    stats = response.json()
    assert "total_hours_today" in stats
    assert "total_hours_week" in stats
    assert "total_hours_month" in stats
