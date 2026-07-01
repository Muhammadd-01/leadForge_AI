from datetime import datetime
from sqlalchemy.orm import Mapped, mapped_column
from sqlalchemy import func
import uuid

class TimestampMixin:
    created_at: Mapped[datetime] = mapped_column(default=func.now())
    updated_at: Mapped[datetime] = mapped_column(default=func.now(), onupdate=func.now())

class SoftDeleteMixin:
    deleted_at: Mapped[datetime | None] = mapped_column(default=None, nullable=True)

    def soft_delete(self):
        self.deleted_at = func.now()

    def undelete(self):
        self.deleted_at = None

class UUIDMixin:
    id: Mapped[uuid.UUID] = mapped_column(primary_key=True, default=uuid.uuid4)
