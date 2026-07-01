from pydantic import BaseModel, ConfigDict, EmailStr, HttpUrl
from typing import Optional, List
from datetime import datetime
import uuid

# Base schemas
class TagBase(BaseModel):
    name: str
    color: Optional[str] = None

class TagCreate(TagBase):
    pass

class TagUpdate(BaseModel):
    name: Optional[str] = None
    color: Optional[str] = None

class TagOut(TagBase):
    id: uuid.UUID
    created_at: datetime
    
    model_config = ConfigDict(from_attributes=True)

class BusinessBase(BaseModel):
    name: str
    website: Optional[HttpUrl] = None
    industry: Optional[str] = None
    location_city: Optional[str] = None
    location_country: Optional[str] = None
    email: Optional[EmailStr] = None
    phone: Optional[str] = None
    google_rating: Optional[float] = None
    lead_score: int = 0
    status: str = "New Lead"

class BusinessCreate(BusinessBase):
    tag_ids: Optional[List[uuid.UUID]] = []

class BusinessUpdate(BaseModel):
    name: Optional[str] = None
    website: Optional[HttpUrl] = None
    industry: Optional[str] = None
    location_city: Optional[str] = None
    location_country: Optional[str] = None
    email: Optional[EmailStr] = None
    phone: Optional[str] = None
    google_rating: Optional[float] = None
    lead_score: Optional[int] = None
    status: Optional[str] = None
    tag_ids: Optional[List[uuid.UUID]] = None

class BusinessOut(BusinessBase):
    id: uuid.UUID
    created_at: datetime
    updated_at: datetime
    tags: List[TagOut] = []
    
    model_config = ConfigDict(from_attributes=True)
