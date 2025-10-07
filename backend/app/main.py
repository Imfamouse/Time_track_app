from fastapi import FastAPI

app = FastAPI(title="Time Track API", version="0.1.0")


@app.get("/health", tags=["health"])
def read_health() -> dict[str, str]:
    """Проверка готовности сервиса."""
    return {"status": "ok"}
