from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy import String, Text, Integer, Float, ForeignKey, Table, Column
from typing import Optional, List
import uuid

from app.db.base import Base
from app.db.mixins import TimestampMixin, SoftDeleteMixin, UUIDMixin

# Association table for Business <-> Tag many-to-many relationship
business_tags = Table(
    "business_tags",
    Base.metadata,
    Column("business_id", ForeignKey("businesses.id", ondelete="CASCADE"), primary_key=True),
    Column("tag_id", ForeignKey("tags.id", ondelete="CASCADE"), primary_key=True),
)

class Tag(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "tags"

    name: Mapped[str] = mapped_column(String(50), unique=True, index=True, nullable=False)
    color: Mapped[Optional[str]] = mapped_column(String(20))

class Business(Base, UUIDMixin, TimestampMixin, SoftDeleteMixin):
    __tablename__ = "businesses"

    name: Mapped[str] = mapped_column(String(255), index=True, nullable=False)
    website: Mapped[Optional[str]] = mapped_column(String(255))
    industry: Mapped[Optional[str]] = mapped_column(String(100), index=True)
    location_city: Mapped[Optional[str]] = mapped_column(String(100))
    location_country: Mapped[Optional[str]] = mapped_column(String(100))
    email: Mapped[Optional[str]] = mapped_column(String(255))
    phone: Mapped[Optional[str]] = mapped_column(String(50))
    google_rating: Mapped[Optional[float]] = mapped_column(Float)
    lead_score: Mapped[int] = mapped_column(Integer, default=0)
    status: Mapped[str] = mapped_column(String(50), default="New Lead", index=True)
    
    # Relationships
    contacts: Mapped[List["Contact"]] = relationship(back_populates="business", cascade="all, delete-orphan")
    notes: Mapped[List["Note"]] = relationship(back_populates="business", cascade="all, delete-orphan")
    tags: Mapped[List["Tag"]] = relationship(secondary=business_tags)
