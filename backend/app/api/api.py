from fastapi import APIRouter
from app.api.endpoints import business, contact, note

api_router = APIRouter()

api_router.include_router(business.router, prefix="/businesses", tags=["businesses"])
api_router.include_router(contact.router, prefix="/contacts", tags=["contacts"])
api_router.include_router(note.router, prefix="/notes", tags=["notes"])
