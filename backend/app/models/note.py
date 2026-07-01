from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy import Text, ForeignKey
from typing import Optional
import uuid

from app.db.base import Base
from app.db.mixins import TimestampMixin, UUIDMixin

class Note(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "notes"

    business_id: Mapped[uuid.UUID] = mapped_column(ForeignKey("businesses.id", ondelete="CASCADE"), index=True, nullable=False)
    author_id: Mapped[uuid.UUID] = mapped_column(ForeignKey("users.id", ondelete="SET NULL"), nullable=True)
    
    content: Mapped[str] = mapped_column(Text, nullable=False)

    # Relationships
    business: Mapped["Business"] = relationship(back_populates="notes")
    author: Mapped[Optional["User"]] = relationship()
