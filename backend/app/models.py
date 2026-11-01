from sqlalchemy import Column, Integer, String, Date, Float, Text
from .database import Base

class CasoEpidemiologico(Base):
    __tablename__ = "casos_epidemiologicos"

    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    folio = Column(String(50), unique=True, index=True, nullable=False)
    
    # Datos Demográficos del Paciente
    paciente_nombre = Column(String(150), nullable=False)
    edad = Column(Integer, nullable=False)
    sexo = Column(String(20), nullable=False)
    
    # Datos Clínicos y Epidemiológicos
    fecha_sintomas = Column(Date, nullable=False)
    fecha_diagnostico = Column(Date, nullable=False)
    especie_plasmodium = Column(String(50), nullable=False)  # Ej. Plasmodium vivax, Plasmodium falciparum
    tipo_caso = Column(String(50), nullable=False)           # Ej. Autóctono, Importado
    estado_salud = Column(String(50), nullable=False)        # Ej. Estable, Hospitalizado, Recuperado
    
    # Ubicación Geográfica (Soporte para análisis espacial en Guerrero)
    localidad = Column(String(100), nullable=False)
    municipio = Column(String(100), nullable=False, default="Guerrero")
    latitud = Column(Float, nullable=True)
    longitud = Column(Float, nullable=True)
    
    # Notas adicionales
    observaciones = Column(Text, nullable=True)