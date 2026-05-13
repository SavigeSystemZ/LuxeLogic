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
    hashed_password = Column(String, nullable=False)
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


class MakeupTechnique(Base):
    __tablename__ = "makeup_techniques"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True, nullable=False)
    description = Column(Text, nullable=True)
    category = Column(String, nullable=True) # e.g., Makeup, Hair, Jewelry
    is_movie_star_technique = Column(Boolean, default=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    steps = relationship("TechniqueStep", back_populates="technique", cascade="all, delete-orphan")


class TechniqueStep(Base):
    __tablename__ = "technique_steps"

    id = Column(Integer, primary_key=True, index=True)
    technique_id = Column(Integer, ForeignKey("makeup_techniques.id"))
    step_number = Column(Integer, nullable=False)
    title = Column(String, nullable=False)
    description = Column(Text, nullable=True)
    image_url = Column(String, nullable=True) # High-res render URL
    video_timestamp = Column(Integer, nullable=True) # seconds into tutorial video

    technique = relationship("MakeupTechnique", back_populates="steps")


class JewelryAsset(Base):
    __tablename__ = "jewelry_assets"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True, nullable=False)
    asset_url = Column(String, nullable=False) # GLTF/GLB URL
    category = Column(String, nullable=True) # e.g., Earring, Necklace
    anchor_point = Column(String, nullable=True) # e.g., left_ear_lobe, neck_base
    scaling_factor = Column(Integer, default=100) # percentage


class SpecialDedication(Base):
    __tablename__ = "special_dedications"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, unique=True, index=True, nullable=False)
    message = Column(Text, nullable=False)
    trigger_key = Column(String, unique=True, nullable=False)
