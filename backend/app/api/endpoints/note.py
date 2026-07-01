from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from typing import Any, List
import uuid

from app.api import deps
from app import repositories, schemas

router = APIRouter()

@router.get("/business/{business_id}", response_model=List[schemas.NoteOut])
async def read_business_notes(
    *,
    db: AsyncSession = Depends(deps.get_db),
    business_id: uuid.UUID,
) -> Any:
    """
    Get all notes for a business.
    """
    notes = await repositories.note.get_by_business(db=db, business_id=business_id)
    return notes

@router.post("/", response_model=schemas.NoteOut, status_code=status.HTTP_201_CREATED)
async def create_note(
    *,
    db: AsyncSession = Depends(deps.get_db),
    note_in: schemas.NoteCreate,
) -> Any:
    """
    Create new note.
    """
    business = await repositories.business.get(db=db, id=note_in.business_id)
    if not business:
        raise HTTPException(status_code=404, detail="Business not found")
        
    note = await repositories.note.create(db=db, obj_in=note_in)
    return note

@router.put("/{note_id}", response_model=schemas.NoteOut)
async def update_note(
    *,
    db: AsyncSession = Depends(deps.get_db),
    note_id: uuid.UUID,
    note_in: schemas.NoteUpdate,
) -> Any:
    """
    Update a note.
    """
    note = await repositories.note.get(db=db, id=note_id)
    if not note:
        raise HTTPException(status_code=404, detail="Note not found")
        
    note = await repositories.note.update(db=db, db_obj=note, obj_in=note_in)
    return note

@router.delete("/{note_id}", response_model=schemas.NoteOut)
async def delete_note(
    *,
    db: AsyncSession = Depends(deps.get_db),
    note_id: uuid.UUID,
) -> Any:
    """
    Delete a note.
    """
    note = await repositories.note.get(db=db, id=note_id)
    if not note:
        raise HTTPException(status_code=404, detail="Note not found")
    note = await repositories.note.remove(db=db, id=note_id)
    return note
