from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from typing import Any, List
import uuid

from app.api import deps
from app import repositories, schemas

router = APIRouter()

@router.get("/", response_model=List[schemas.TagOut])
async def read_tags(
    db: AsyncSession = Depends(deps.get_db),
    skip: int = 0,
    limit: int = 100,
) -> Any:
    """
    Retrieve tags.
    """
    tags = await repositories.tag.get_multi(db, skip=skip, limit=limit)
    return tags

@router.post("/", response_model=schemas.TagOut, status_code=status.HTTP_201_CREATED)
async def create_tag(
    *,
    db: AsyncSession = Depends(deps.get_db),
    tag_in: schemas.TagCreate,
) -> Any:
    """
    Create new tag.
    """
    existing = await repositories.tag.get_by_name(db, name=tag_in.name)
    if existing:
        raise HTTPException(status_code=400, detail="Tag with this name already exists")
    tag = await repositories.tag.create(db=db, obj_in=tag_in)
    return tag

@router.put("/{tag_id}", response_model=schemas.TagOut)
async def update_tag(
    *,
    db: AsyncSession = Depends(deps.get_db),
    tag_id: uuid.UUID,
    tag_in: schemas.TagUpdate,
) -> Any:
    """
    Update a tag.
    """
    tag = await repositories.tag.get(db=db, id=tag_id)
    if not tag:
        raise HTTPException(status_code=404, detail="Tag not found")
    tag = await repositories.tag.update(db=db, db_obj=tag, obj_in=tag_in)
    return tag

@router.delete("/{tag_id}", response_model=schemas.TagOut)
async def delete_tag(
    *,
    db: AsyncSession = Depends(deps.get_db),
    tag_id: uuid.UUID,
) -> Any:
    """
    Delete a tag.
    """
    tag = await repositories.tag.get(db=db, id=tag_id)
    if not tag:
        raise HTTPException(status_code=404, detail="Tag not found")
    tag = await repositories.tag.remove(db=db, id=tag_id)
    return tag
