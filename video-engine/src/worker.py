import logging
import subprocess
import os
from celery import Celery

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("video-engine")

CACHE_URL = os.getenv("CACHE_URL", "redis://dragonfly-cache:6379/0")

celery_app = Celery('video_tasks', broker=CACHE_URL, backend=CACHE_URL)

@celery_app.task(name="process_media")
def process_media(task_id: str, filename: str, action: str):
    logger.info(f"Starting process: {action} for {filename}")
    
    media_dir = "/app/media"
    input_path = os.path.join(media_dir, filename)
    
    # Check if input file exists
    if not os.path.exists(input_path):
        logger.error(f"Input file not found: {input_path}")
        return {"status": "error", "task_id": task_id, "error": "File not found"}

    if action == "transcode":
        # Perform HLS transcoding
        output_dir = os.path.join(media_dir, task_id)
        os.makedirs(output_dir, exist_ok=True)
        output_m3u8 = os.path.join(output_dir, "playlist.m3u8")
        
        # Simple FFmpeg command for HLS
        ffmpeg_cmd = [
            "ffmpeg", "-i", input_path,
            "-profile:v", "baseline",
            "-level", "3.0",
            "-start_number", "0",
            "-hls_time", "10",
            "-hls_list_size", "0",
            "-f", "hls", output_m3u8
        ]

        logger.info(f"Running FFmpeg: {' '.join(ffmpeg_cmd)}")
        try:
            subprocess.run(ffmpeg_cmd, capture_output=True, text=True, check=True)
            logger.info(f"Completed transcoding: {action} for {filename}")
            return {"status": "success", "task_id": task_id, "playlist": output_m3u8}
        except subprocess.CalledProcessError as e:
            logger.error(f"FFmpeg failed with code {e.returncode}: {e.stderr}")
            return {"status": "error", "task_id": task_id, "error": "FFmpeg failed"}
            
    elif action == "thumbnail":
        output_thumbnail = os.path.join(media_dir, f"{task_id}_thumbnail.jpg")
        ffmpeg_cmd = [
            "ffmpeg", "-i", input_path,
            "-ss", "00:00:02",
            "-vframes", "1",
            output_thumbnail
        ]
        try:
            subprocess.run(ffmpeg_cmd, capture_output=True, text=True, check=True)
            return {"status": "success", "task_id": task_id, "thumbnail": output_thumbnail}
        except subprocess.CalledProcessError as e:
            logger.error(f"FFmpeg failed (thumbnail): {e.stderr}")
            return {"status": "error", "task_id": task_id, "error": "FFmpeg failed"}

    else:
        logger.warning(f"Unknown action: {action}")
        return {"status": "error", "task_id": task_id, "error": "Unknown action"}