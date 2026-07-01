from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from typing import Any, List
import uuid

from app.api import deps
from app import repositories, schemas

router = APIRouter()

@router.get("/", response_model=List[schemas.BusinessOut])
async def read_businesses(
    db: AsyncSession = Depends(deps.get_db),
    skip: int = 0,
    limit: int = 100,
) -> Any:
    """
    Retrieve businesses.
    """
    businesses = await repositories.business.get_multi(db, skip=skip, limit=limit)
    return businesses

@router.post("/", response_model=schemas.BusinessOut, status_code=status.HTTP_201_CREATED)
async def create_business(
    *,
    db: AsyncSession = Depends(deps.get_db),
    business_in: schemas.BusinessCreate,
) -> Any:
    """
    Create new business.
    """
    tags = []
    if business_in.tag_ids:
        for tag_id in business_in.tag_ids:
            tag = await repositories.tag.get(db=db, id=tag_id)
            if tag:
                tags.append(tag)
                
    business = await repositories.business.create_with_tags(db=db, obj_in=business_in, tags=tags)
    return business

@router.get("/{business_id}", response_model=schemas.BusinessOut)
async def read_business(
    *,
    db: AsyncSession = Depends(deps.get_db),
    business_id: uuid.UUID,
) -> Any:
    """
    Get business by ID with relations.
    """
    business = await repositories.business.get_with_relations(db=db, id=business_id)
    if not business:
        raise HTTPException(status_code=404, detail="Business not found")
    return business

@router.put("/{business_id}", response_model=schemas.BusinessOut)
async def update_business(
    *,
    db: AsyncSession = Depends(deps.get_db),
    business_id: uuid.UUID,
    business_in: schemas.BusinessUpdate,
) -> Any:
    """
    Update a business.
    """
    business = await repositories.business.get(db=db, id=business_id)
    if not business:
        raise HTTPException(status_code=404, detail="Business not found")
        
    business = await repositories.business.update(db=db, db_obj=business, obj_in=business_in)
    return business

@router.delete("/{business_id}", response_model=schemas.BusinessOut)
async def delete_business(
    *,
    db: AsyncSession = Depends(deps.get_db),
    business_id: uuid.UUID,
) -> Any:
    """
    Delete a business.
    """
    business = await repositories.business.get(db=db, id=business_id)
    if not business:
        raise HTTPException(status_code=404, detail="Business not found")
    business = await repositories.business.remove(db=db, id=business_id)
    return business
