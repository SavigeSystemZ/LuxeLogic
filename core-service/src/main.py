import os
import logging
from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import text
from pydantic import BaseModel
from typing import List, Optional
from celery import Celery

from src.models import Base, UserProfile, Tutorial, FavoriteTutorial
from src.database import engine, get_db, get_cache

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("core-service")

CACHE_URL = os.getenv("CACHE_URL", "redis://dragonfly-cache:6379/0")
celery_app = Celery('video_tasks', broker=CACHE_URL, backend=CACHE_URL)

# Create tables
Base.metadata.create_all(bind=engine)

app = FastAPI(title="LuxeLogic Core Service", description="Backend for the LuxeLogic Makeup & Beauty App")

class ProfileCreate(BaseModel):
    username: str
    email: str
    skin_tone: Optional[str] = None
    face_shape: Optional[str] = None

class ProfileResponse(ProfileCreate):
    id: int
    class Config:
        from_attributes = True

@app.get("/")
async def root():
    return {"message": "LuxeLogic Beauty Core Service API"}

@app.get("/health")
async def health(db: Session = Depends(get_db)):
    try:
        db.execute(text("SELECT 1"))
        cache = get_cache()
        cache.ping()
        return {"status": "healthy", "database": "connected", "cache": "connected"}
    except Exception as e:
        logger.error(f"Health check failed: {e}")
        return {"status": "unhealthy", "error": str(e)}

@app.post("/profiles/", response_model=ProfileResponse)
def create_profile(profile: ProfileCreate, db: Session = Depends(get_db)):
    db_user = db.query(UserProfile).filter(UserProfile.email == profile.email).first()
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    
    new_profile = UserProfile(
        username=profile.username,
        email=profile.email,
        skin_tone=profile.skin_tone,
        face_shape=profile.face_shape
    )
    db.add(new_profile)
    db.commit()
    db.refresh(new_profile)
    return new_profile

@app.get("/profiles/{profile_id}", response_model=ProfileResponse)
def get_profile(profile_id: int, db: Session = Depends(get_db)):
    profile = db.query(UserProfile).filter(UserProfile.id == profile_id).first()
    if not profile:
        raise HTTPException(status_code=404, detail="Profile not found")
    return profile

class TutorialCreate(BaseModel):
    title: str
    description: Optional[str] = None
    video_url: str
    difficulty_level: Optional[str] = None
    technique_tags: Optional[str] = None

class TutorialResponse(TutorialCreate):
    id: int
    class Config:
        from_attributes = True

class FavoriteCreate(BaseModel):
    user_id: int
    tutorial_id: int

class FavoriteResponse(FavoriteCreate):
    id: int
    class Config:
        from_attributes = True

@app.post("/tutorials/", response_model=TutorialResponse)
def create_tutorial(tutorial: TutorialCreate, db: Session = Depends(get_db)):
    new_tutorial = Tutorial(
        title=tutorial.title,
        description=tutorial.description,
        video_url=tutorial.video_url,
        difficulty_level=tutorial.difficulty_level,
        technique_tags=tutorial.technique_tags
    )
    db.add(new_tutorial)
    db.commit()
    db.refresh(new_tutorial)
    
    # Assume the video_url points to a filename in the shared volume for the mock
    filename = tutorial.video_url.split("/")[-1]
    celery_app.send_task("process_media", args=[str(new_tutorial.id), filename, "transcode"])
    
    return new_tutorial

@app.get("/tutorials/", response_model=List[TutorialResponse])
def list_tutorials(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    return db.query(Tutorial).offset(skip).limit(limit).all()

@app.post("/favorites/", response_model=FavoriteResponse)
def add_favorite(favorite: FavoriteCreate, db: Session = Depends(get_db)):
    # Basic check
    user = db.query(UserProfile).filter(UserProfile.id == favorite.user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    tut = db.query(Tutorial).filter(Tutorial.id == favorite.tutorial_id).first()
    if not tut:
        raise HTTPException(status_code=404, detail="Tutorial not found")

    new_favorite = FavoriteTutorial(
        user_id=favorite.user_id,
        tutorial_id=favorite.tutorial_id
    )
    db.add(new_favorite)
    db.commit()
    db.refresh(new_favorite)
    return new_favorite

@app.get("/profiles/{profile_id}/favorites", response_model=List[FavoriteResponse])
def list_user_favorites(profile_id: int, db: Session = Depends(get_db)):
    favorites = db.query(FavoriteTutorial).filter(FavoriteTutorial.user_id == profile_id).all()
    return favorites

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)