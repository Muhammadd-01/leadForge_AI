from sqlalchemy.orm import Mapped, mapped_column
from sqlalchemy import String, Boolean, Enum
import enum
from typing import Optional

from app.db.base import Base
from app.db.mixins import TimestampMixin, SoftDeleteMixin, UUIDMixin

class Role(str, enum.Enum):
    ADMIN = "admin"
    MANAGER = "manager"
    SALES = "sales"
    FREELANCER = "freelancer"

class User(Base, UUIDMixin, TimestampMixin, SoftDeleteMixin):
    __tablename__ = "users"

    email: Mapped[str] = mapped_column(String(255), unique=True, index=True, nullable=False)
    hashed_password: Mapped[str] = mapped_column(String(255), nullable=False)
    full_name: Mapped[Optional[str]] = mapped_column(String(255))
    role: Mapped[Role] = mapped_column(Enum(Role), default=Role.FREELANCER, nullable=False)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True)
    is_superuser: Mapped[bool] = mapped_column(Boolean, default=False)
    totp_secret: Mapped[Optional[str]] = mapped_column(String(255))
    totp_enabled: Mapped[bool] = mapped_column(Boolean, default=False)
