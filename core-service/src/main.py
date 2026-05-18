import os
import logging
import json
from fastapi import FastAPI, Depends, HTTPException, status, Request, WebSocket, WebSocketDisconnect, File, UploadFile
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from sqlalchemy import text
from pydantic import BaseModel, Field
from typing import List, Optional
from celery import Celery
from google import genai
from prometheus_fastapi_instrumentator import Instrumentator

from src.models import Base, UserProfile, Tutorial, FavoriteTutorial, MakeupTechnique, TechniqueStep, JewelryAsset, SpecialDedication, UserInteraction
from src.database import engine, get_db, get_cache
from src.auth import get_password_hash, verify_password, create_access_token, get_current_user

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("core-service")

CACHE_URL = os.getenv("CACHE_URL", "redis://dragonfly-cache:6379/0")
celery_app = Celery('video_tasks', broker=CACHE_URL, backend=CACHE_URL)

# Create tables
Base.metadata.create_all(bind=engine)

client = genai.Client(api_key=os.getenv("GEMINI_API_KEY", "YOUR_API_KEY"))

app = FastAPI(title="LuxeLogic Core Service", description="Backend for the LuxeLogic Makeup & Beauty App")

# Instrument metrics
Instrumentator().instrument(app).expose(app)

@app.on_event("startup")
def seed_data():
    db = next(get_db())
    # Seed Kehley Smith easter egg
    kehley = db.query(SpecialDedication).filter(SpecialDedication.trigger_key == "kehley").first()
    if not kehley:
        new_dedication = SpecialDedication(
            name="Kehley Smith",
            message="This application is dedicated to Kehley Smith, whose passion for beauty and excellence inspired its creation. May every user find their own inner and outer shine.",
            trigger_key="kehley"
        )
        db.add(new_dedication)
        logger.info("Seeded Kehley Smith dedication easter egg.")
    
    # Seed Professional Techniques
    if not db.query(MakeupTechnique).filter(MakeupTechnique.title == "Hollywood Glow").first():
        tech = MakeupTechnique(
            title="Hollywood Glow",
            description="The signature red-carpet radiance used by movie stars.",
            category="Makeup",
            is_movie_star_technique=True
        )
        db.add(tech)
        db.commit()
        db.refresh(tech)
        
        steps = [
            TechniqueStep(technique_id=tech.id, step_number=1, title="Illuminating Primer", description="Apply a pearl-finish primer to high points of the face."),
            TechniqueStep(technique_id=tech.id, step_number=2, title="Dewy Foundation", description="Mix foundation with a drop of facial oil for maximum glow."),
            TechniqueStep(technique_id=tech.id, step_number=3, title="Liquid Highlight", description="Tap liquid highlighter onto cheekbones and brow bones.")
        ]
        db.add_all(steps)

    # Seed Jewelry Data
    if not db.query(JewelryAsset).first():
        jewelry = [
            JewelryAsset(name="Diamond Drop Earrings", asset_url="/assets/diamond_drop.glb", category="Earrings", anchor_point="earlobe", scaling_factor=1),
            JewelryAsset(name="Gold Hoop Earrings", asset_url="/assets/gold_hoop.glb", category="Earrings", anchor_point="earlobe", scaling_factor=1),
            JewelryAsset(name="Pearl Necklace", asset_url="/assets/pearl_necklace.glb", category="Necklace", anchor_point="neck", scaling_factor=1),
            JewelryAsset(name="Sapphire Choker", asset_url="/assets/sapphire_choker.glb", category="Necklace", anchor_point="neck", scaling_factor=1)
        ]
        db.add_all(jewelry)
    
    db.commit()

class Token(BaseModel):
    access_token: str
    token_type: str

class ProfileCreate(BaseModel):
    username: str = Field(..., min_length=3, max_length=50)
    email: str
    password: str = Field(..., min_length=8)
    skin_tone: Optional[str] = None
    face_shape: Optional[str] = None

class ProfileResponse(BaseModel):
    id: int
    username: str
    email: str
    skin_tone: Optional[str] = None
    face_shape: Optional[str] = None
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

@app.post("/token", response_model=Token)
async def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends(), db: Session = Depends(get_db)):
    user = db.query(UserProfile).filter(UserProfile.username == form_data.username).first()
    if not user or not verify_password(form_data.password, user.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token = create_access_token(data={"sub": user.email})
    return {"access_token": access_token, "token_type": "bearer"}

@app.post("/profiles/", response_model=ProfileResponse)
def create_profile(profile: ProfileCreate, db: Session = Depends(get_db)):
    db_user = db.query(UserProfile).filter(UserProfile.email == profile.email).first()
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    
    new_profile = UserProfile(
        username=profile.username,
        email=profile.email,
        hashed_password=get_password_hash(profile.password),
        skin_tone=profile.skin_tone,
        face_shape=profile.face_shape
    )
    db.add(new_profile)
    db.commit()
    db.refresh(new_profile)
    return new_profile

@app.get("/profiles/me", response_model=ProfileResponse)
async def read_users_me(current_user: UserProfile = Depends(get_current_user)):
    return current_user

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
    
    filename = tutorial.video_url.split("/")[-1]
    celery_app.send_task("process_media", args=[str(new_tutorial.id), filename, "transcode"])
    
    return new_tutorial

@app.get("/tutorials/", response_model=List[TutorialResponse])
def list_tutorials(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    return db.query(Tutorial).offset(skip).limit(limit).all()

@app.post("/favorites/", response_model=FavoriteResponse)
def add_favorite(favorite: FavoriteCreate, db: Session = Depends(get_db)):
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

# --- New Beauty & 3D Endpoints ---

class TechniqueStepResponse(BaseModel):
    id: int
    step_number: int
    title: str
    description: Optional[str]
    image_url: Optional[str]
    video_timestamp: Optional[int]
    class Config:
        from_attributes = True

class MakeupTechniqueResponse(BaseModel):
    id: int
    title: str
    description: Optional[str]
    category: Optional[str]
    is_movie_star_technique: bool
    steps: List[TechniqueStepResponse]
    class Config:
        from_attributes = True

class JewelryAssetResponse(BaseModel):
    id: int
    name: str
    asset_url: str
    category: Optional[str]
    anchor_point: Optional[str]
    scaling_factor: int
    class Config:
        from_attributes = True

class SpecialDedicationResponse(BaseModel):
    name: str
    message: str
    trigger_key: str
    class Config:
        from_attributes = True

@app.get("/techniques/", response_model=List[MakeupTechniqueResponse])
def list_techniques(category: Optional[str] = None, db: Session = Depends(get_db)):
    query = db.query(MakeupTechnique)
    if category:
        query = query.filter(MakeupTechnique.category == category)
    return query.all()

@app.get("/techniques/{tech_id}", response_model=MakeupTechniqueResponse)
def get_technique(tech_id: int, db: Session = Depends(get_db)):
    tech = db.query(MakeupTechnique).filter(MakeupTechnique.id == tech_id).first()
    if not tech:
        raise HTTPException(status_code=404, detail="Technique not found")
    return tech

@app.get("/jewelry/", response_model=List[JewelryAssetResponse])
def list_jewelry(db: Session = Depends(get_db)):
    return db.query(JewelryAsset).all()

@app.get("/dedications/{trigger_key}", response_model=SpecialDedicationResponse)
def get_dedication(trigger_key: str, db: Session = Depends(get_db)):
    dedication = db.query(SpecialDedication).filter(SpecialDedication.trigger_key == trigger_key).first()
    if not dedication:
        raise HTTPException(status_code=404, detail="Dedication not found")
    return dedication

# WebSocket for real-time task updates
@app.websocket("/ws/tasks/{task_id}")
async def websocket_task_updates(websocket: WebSocket, task_id: str):
    await websocket.accept()
    cache = get_cache()
    pubsub = cache.pubsub()
    await pubsub.subscribe(f"task_updates:{task_id}")
    
    try:
        async for message in pubsub.listen():
            if message['type'] == 'message':
                data = message['data'].decode('utf-8')
                await websocket.send_text(data)
                # If task is done, close the connection
                parsed = json.loads(data)
                if parsed.get('status') in ['success', 'error']:
                    break
    except WebSocketDisconnect:
        logger.info(f"WebSocket disconnected for task {task_id}")
    finally:
        await pubsub.unsubscribe(f"task_updates:{task_id}")
        await websocket.close()

# AI Assistant Mock Endpoint
@app.post("/ai/ask")
async def ask_ai(question: str, current_user: UserProfile = Depends(get_current_user), db: Session = Depends(get_db)):
    responses = {
        "makeup": "To apply makeup like a star, start with a high-quality primer and follow our 'Red Carpet' tutorial.",
        "kehley": "Kehley Smith is the heart of this application. Her message is one of beauty and empowerment.",
        "jewelry": "You can try on any jewelry by uploading a 3D model or selecting from our catalog."
    }
    answer = responses.get("makeup") 
    for key in responses:
        if key in question.lower():
            answer = responses[key]
            break
    
    # Save interaction
    db.add(UserInteraction(user_id=current_user.id, role="user", content=question))
    db.add(UserInteraction(user_id=current_user.id, role="assistant", content=answer))
    db.commit()
    
    return {"answer": answer}

# Professional AI Consultation Endpoint
@app.post("/ai/consult")
async def consult_ai(question: str, tone: Optional[str] = None, undertone: Optional[str] = None, current_user: UserProfile = Depends(get_current_user), db: Session = Depends(get_db)):
    cache = get_cache()
    key = f"rate_limit:consult:{current_user.id}"
    # Use standard redis client for now if get_cache is not async
    reqs = cache.incr(key)
    if reqs == 1:
        cache.expire(key, 60)
    if reqs > 10:
        raise HTTPException(status_code=429, detail="Too many AI consultations. Please wait a minute.")

    # Retrieve memory
    history = db.query(UserInteraction).filter(UserInteraction.user_id == current_user.id).order_by(UserInteraction.created_at.desc()).limit(10).all()
    memory_context = "\n".join([f"{h.role}: {h.content}" for h in reversed(history)])

    system_prompt = f"""
    You are a world-class Hollywood Makeup Artist and Beauty Consultant. 
    Your goal is to provide expert, personalized advice to women using the LuxeLogic app.
    The user's analyzed skin tone is {tone or 'unknown'} and undertone is {undertone or 'unknown'}.
    Always be professional, encouraging, and specific with product types and application techniques.
    If asked to apply makeup (lipstick, blush, etc.), return a JSON action in your response exactly like: [ACTION: {{"type": "apply_makeup", "makeup_type": "lipstick", "color": "#HEX"}}]
    
    Recent conversation history:
    {memory_context}
    """
    
    try:
        response = client.models.generate_content(model="gemini-1.5-flash", contents=f"{system_prompt}\n\nUser Question: {question}")
        answer = response.text
        
        # Save interaction
        db.add(UserInteraction(user_id=current_user.id, role="user", content=question))
        db.add(UserInteraction(user_id=current_user.id, role="assistant", content=answer))
        db.commit()
        
        return {"answer": answer}
    except Exception as e:
        logger.error(f"Gemini API error: {e}")
        return {"answer": "I'm currently perfecting my next look. Please try again in a moment, darling."}

@app.post("/ai/recreate-look")
async def recreate_look(file: UploadFile = File(...), current_user: UserProfile = Depends(get_current_user)):
    from PIL import Image, UnidentifiedImageError
    import io

    # Read image and check size
    contents = await file.read()
    if len(contents) > 10 * 1024 * 1024:  # 10MB limit
        raise HTTPException(status_code=400, detail="Image file too large. Maximum size is 10MB.")

    try:
        image = Image.open(io.BytesIO(contents))
        image.verify()  # Verify it's a valid image
        image = Image.open(io.BytesIO(contents)) # Re-open after verify
    except (UnidentifiedImageError, IOError):
        raise HTTPException(status_code=400, detail="Invalid image file uploaded.")

    prompt = """
    Analyze the makeup in this image. 
    Return a list of JSON actions to recreate this look.
    Focus on Lipstick and Blush.
    Format exactly like: [ACTION: {"type": "apply_makeup", "makeup_type": "lipstick", "color": "#HEX"}]
    """
    
    try:
        response = client.models.generate_content(model="gemini-1.5-flash", contents=[prompt, image])
        return {"answer": response.text}
    except Exception as e:
        logger.error(f"Gemini Vision API error: {e}")
        return {"answer": "I couldn't quite see the details of that beautiful look. Could you try another photo?"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
