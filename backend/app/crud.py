from sqlalchemy.orm import Session
from . import models, schemas

def get_caso(db: Session, caso_id: int):
    return db.query(models.CasoEpidemiologico).filter(models.CasoEpidemiologico.id == caso_id).first()

def get_caso_by_folio(db: Session, folio: str):
    return db.query(models.CasoEpidemiologico).filter(models.CasoEpidemiologico.folio == folio).first()

def get_casos(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.CasoEpidemiologico).offset(skip).limit(limit).all()

def create_caso(db: Session, caso: schemas.CasoCreate):
    db_caso = models.CasoEpidemiologico(**caso.model_dump())
    db.add(db_caso)
    db.commit()
    db.refresh(db_caso)
    return db_caso

