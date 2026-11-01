from datetime import date
from typing import Optional
from pydantic import BaseModel, Field

class CasoBase(BaseModel):
    folio: str = Field(..., example="GRO-MAL-2026-001")
    paciente_nombre: str = Field(..., example="Juan Pérez Gómez")
    edad: int = Field(..., ge=0, le=120, example=35)
    sexo: str = Field(..., example="Masculino")
    fecha_sintomas: date
    fecha_diagnostico: date
    especie_plasmodium: str = Field(..., example="Plasmodium vivax")
    tipo_caso: str = Field(..., example="Autóctono")
    estado_salud: str = Field(..., example="Estable")
    localidad: str = Field(..., example="Acapulco de Juárez")
    municipio: str = Field(..., example="Guerrero")
    latitud: Optional[float] = Field(None, example=16.8531)
    longitud: Optional[float] = Field(None, example=-99.8237)
    observaciones: Optional[str] = Field(None, example="Paciente bajo tratamiento supervisado.")

class CasoCreate(CasoBase):
    """Esquema utilizado para la creación de un nuevo caso epidemiológico."""
    pass

class CasoResponse(CasoBase):
    """Esquema de respuesta que incluye el ID generado por la base de datos."""
    id: int

    class Config:
        from_attributes = True