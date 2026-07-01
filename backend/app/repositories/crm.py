from typing import Optional, List
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from sqlalchemy.orm import selectinload
import uuid

from app.repositories.base import CRUDBase
from app.models.business import Business, Tag
from app.models.contact import Contact
from app.models.note import Note
from app.schemas.crm import (
    BusinessCreate, BusinessUpdate,
    TagCreate, TagUpdate,
    ContactCreate, ContactUpdate,
    NoteCreate, NoteUpdate
)

class CRUDTag(CRUDBase[Tag, TagCreate, TagUpdate]):
    async def get_by_name(self, db: AsyncSession, *, name: str) -> Optional[Tag]:
        result = await db.execute(select(Tag).where(Tag.name == name))
        return result.scalars().first()

class CRUDBusiness(CRUDBase[Business, BusinessCreate, BusinessUpdate]):
    async def create_with_tags(self, db: AsyncSession, *, obj_in: BusinessCreate, tags: List[Tag]) -> Business:
        obj_in_data = obj_in.model_dump(exclude={"tag_ids"})
        db_obj = Business(**obj_in_data)
        db_obj.tags = tags
        db.add(db_obj)
        await db.commit()
        await db.refresh(db_obj)
        return db_obj
        
    async def get_with_relations(self, db: AsyncSession, *, id: uuid.UUID) -> Optional[Business]:
        stmt = (
            select(Business)
            .where(Business.id == id, Business.is_deleted == False)
            .options(selectinload(Business.tags))
            .options(selectinload(Business.contacts))
            .options(selectinload(Business.notes))
        )
        result = await db.execute(stmt)
        return result.scalars().first()

class CRUDContact(CRUDBase[Contact, ContactCreate, ContactUpdate]):
    async def get_by_business(self, db: AsyncSession, *, business_id: uuid.UUID) -> List[Contact]:
        stmt = select(Contact).where(Contact.business_id == business_id, Contact.is_deleted == False)
        result = await db.execute(stmt)
        return list(result.scalars().all())

class CRUDNote(CRUDBase[Note, NoteCreate, NoteUpdate]):
    async def get_by_business(self, db: AsyncSession, *, business_id: uuid.UUID) -> List[Note]:
        stmt = select(Note).where(Note.business_id == business_id)
        result = await db.execute(stmt)
        return list(result.scalars().all())

tag = CRUDTag(Tag)
business = CRUDBusiness(Business)
contact = CRUDContact(Contact)
note = CRUDNote(Note)
