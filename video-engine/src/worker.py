import logging
import subprocess
import os
import json
import redis
from celery import Celery

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("video-engine")

CACHE_URL = os.getenv("CACHE_URL", "redis://dragonfly-cache:6379/0")

celery_app = Celery('video_tasks', broker=CACHE_URL, backend=CACHE_URL)
redis_client = redis.from_url(CACHE_URL)

def publish_status(task_id: str, status: str, progress: int, message: str):
    data = json.dumps({"task_id": task_id, "status": status, "progress": progress, "message": message})
    redis_client.publish(f"task_updates:{task_id}", data)

@celery_app.task(name="process_media")
def process_media(task_id: str, filename: str, action: str):
    logger.info(f"Starting process: {action} for {filename}")
    publish_status(task_id, "started", 0, f"Initializing {action} for {filename}")
    
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
            subprocess.run(ffmpeg_cmd, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, text=True, check=True)
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
            subprocess.run(ffmpeg_cmd, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, text=True, check=True)
            return {"status": "success", "task_id": task_id, "thumbnail": output_thumbnail}
        except subprocess.CalledProcessError as e:
            logger.error(f"FFmpeg failed (thumbnail): {e.stderr}")
            return {"status": "error", "task_id": task_id, "error": "FFmpeg failed"}

    elif action == "generate_beauty_render":
        # Simulate a high-fidelity 4K makeup render
        # In a real system, this might use Blender or a specialized 3D engine.
        # For now, we'll create a composite high-res image using FFmpeg/ImageMagick
        output_render = os.path.join(media_dir, f"{task_id}_render_4k.jpg")
        
        # We'll use a high-res solid color or filter as a placeholder
        # simulating a detailed closeup of a face with makeup layers
        ffmpeg_cmd = [
            "ffmpeg", "-f", "lavfi", "-i", "color=c=lavenderblush:s=3840x2160:d=1",
            "-vf", "drawtext=text='High-Res Beauty Render Step':x=(w-text_w)/2:y=(h-text_h)/2:fontsize=120:fontcolor=white:shadowcolor=black:shadowx=5:shadowy=5",
            "-vframes", "1",
            output_render
        ]
        
        try:
            subprocess.run(ffmpeg_cmd, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, text=True, check=True)
            logger.info(f"Generated high-res beauty render: {output_render}")
            return {"status": "success", "task_id": task_id, "render_url": output_render}
        except subprocess.CalledProcessError as e:
            logger.error(f"Render generation failed: {e.stderr}")
            return {"status": "error", "task_id": task_id, "error": "Render generation failed"}

    else:
        logger.warning(f"Unknown action: {action}")
        return {"status": "error", "task_id": task_id, "error": "Unknown action"}