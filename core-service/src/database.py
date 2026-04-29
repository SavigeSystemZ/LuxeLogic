import os
import redis
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://luxeadmin:change-me@postgres-db:5432/luxelogic")
CACHE_URL = os.getenv("CACHE_URL", "redis://dragonfly-cache:6379/0")

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

def get_cache():
    return redis.from_url(CACHE_URL)