from fastapi import FastAPI

app = FastAPI(
    title="Malaria Surveillance API",
    description="REST API for Epidemiological Surveillance of Malaria (Guerrero, Mexico)",
    version="1.0.0"
)

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