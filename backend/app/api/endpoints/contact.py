from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from typing import Any, List
import uuid

from app.api import deps
from app import repositories, schemas

router = APIRouter()

@router.get("/business/{business_id}", response_model=List[schemas.ContactOut])
async def read_business_contacts(
    *,
    db: AsyncSession = Depends(deps.get_db),
    business_id: uuid.UUID,
) -> Any:
    """
    Get all contacts for a business.
    """
    contacts = await repositories.contact.get_by_business(db=db, business_id=business_id)
    return contacts

@router.post("/", response_model=schemas.ContactOut, status_code=status.HTTP_201_CREATED)
async def create_contact(
    *,
    db: AsyncSession = Depends(deps.get_db),
    contact_in: schemas.ContactCreate,
) -> Any:
    """
    Create new contact.
    """
    business = await repositories.business.get(db=db, id=contact_in.business_id)
    if not business:
        raise HTTPException(status_code=404, detail="Business not found")
        
    contact = await repositories.contact.create(db=db, obj_in=contact_in)
    return contact

@router.put("/{contact_id}", response_model=schemas.ContactOut)
async def update_contact(
    *,
    db: AsyncSession = Depends(deps.get_db),
    contact_id: uuid.UUID,
    contact_in: schemas.ContactUpdate,
) -> Any:
    """
    Update a contact.
    """
    contact = await repositories.contact.get(db=db, id=contact_id)
    if not contact:
        raise HTTPException(status_code=404, detail="Contact not found")
        
    contact = await repositories.contact.update(db=db, db_obj=contact, obj_in=contact_in)
    return contact

@router.delete("/{contact_id}", response_model=schemas.ContactOut)
async def delete_contact(
    *,
    db: AsyncSession = Depends(deps.get_db),
    contact_id: uuid.UUID,
) -> Any:
    """
    Delete a contact.
    """
    contact = await repositories.contact.get(db=db, id=contact_id)
    if not contact:
        raise HTTPException(status_code=404, detail="Contact not found")
    contact = await repositories.contact.remove(db=db, id=contact_id)
    return contact
