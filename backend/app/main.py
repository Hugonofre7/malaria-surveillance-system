from fastapi import FastAPI
from app import models
from app.database import Base, engine
from app.routers import casos


Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="Malaria Surveillance API",
    description="REST API for Epidemiological Surveillance of Malaria (Guerrero, Mexico)",
    version="1.0.0"
)

app.include_router(casos.router)

@app.get("/")
def read_root():
    return {
        "project": "Malaria Epidemiological Information System",
        "status": "online",
        "docs": "/docs"
    }

@app.get("/health")
def health_check():
    return {"status": "healthy"}