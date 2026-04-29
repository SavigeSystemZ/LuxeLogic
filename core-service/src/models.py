from sqlalchemy import Column, Integer, String, Boolean, DateTime, ForeignKey, Text
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship

Base = declarative_base()

class UserProfile(Base):
    __tablename__ = "user_profiles"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, index=True, nullable=False)
    email = Column(String, unique=True, index=True, nullable=False)
    skin_tone = Column(String, nullable=True)
    face_shape = Column(String, nullable=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    favorites = relationship("FavoriteTutorial", back_populates="user")


class Tutorial(Base):
    __tablename__ = "tutorials"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True, nullable=False)
    description = Column(Text, nullable=True)
    video_url = Column(String, nullable=False)
    difficulty_level = Column(String, nullable=True) # e.g., Beginner, Advanced, Movie-Star
    technique_tags = Column(String, nullable=True) # comma separated tags
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    favorited_by = relationship("FavoriteTutorial", back_populates="tutorial")


class FavoriteTutorial(Base):
    __tablename__ = "favorite_tutorials"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("user_profiles.id"))
    tutorial_id = Column(Integer, ForeignKey("tutorials.id"))
    saved_at = Column(DateTime(timezone=True), server_default=func.now())

    user = relationship("UserProfile", back_populates="favorites")
    tutorial = relationship("Tutorial", back_populates="favorited_by")
