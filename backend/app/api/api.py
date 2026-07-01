from fastapi import APIRouter
from app.api.endpoints import auth, business, contact, note, tag

api_router = APIRouter()

api_router.include_router(auth.router, prefix="/auth", tags=["auth"])
api_router.include_router(business.router, prefix="/businesses", tags=["businesses"])
api_router.include_router(contact.router, prefix="/contacts", tags=["contacts"])
api_router.include_router(note.router, prefix="/notes", tags=["notes"])
api_router.include_router(tag.router, prefix="/tags", tags=["tags"])
