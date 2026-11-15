from typing import List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from .. import crud, schemas
from ..database import get_db

router = APIRouter(
    prefix="/casos",
    tags=["Casos Epidemiológicos"]
)

@router.post("/", response_model=schemas.CasoResponse, status_code=status.HTTP_201_CREATED)
def crear_caso(caso: schemas.CasoCreate, db: Session = Depends(get_db)):
    """Registrar un nuevo caso epidemiológico de paludismo."""
    db_caso = crud.get_caso_by_folio(db, folio=caso.folio)
    if db_caso:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f"Ya existe un caso registrado con el folio: {caso.folio}"
        )
    return crud.create_caso(db=db, caso=caso)

@router.get("/", response_model=List[schemas.CasoResponse])
def listar_casos(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    """Obtener la lista de todos los casos epidemiológicos registrados."""
    casos = crud.get_casos(db, skip=skip, limit=limit)
    return casos

@router.get("/{caso_id}", response_model=schemas.CasoResponse)
def obtener_caso_por_id(caso_id: int, db: Session = Depends(get_db)):
    """Obtener el detalle de un caso epidemiológico específico por su ID."""
    db_caso = crud.get_caso(db, caso_id=caso_id)
    if db_caso is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Caso epidemiológico no encontrado"
        )
    return db_caso
