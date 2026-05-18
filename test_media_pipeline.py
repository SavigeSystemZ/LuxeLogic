import time
import requests
import subprocess
import sys

def main():
    print("Generating test video in video-engine container...")
    subprocess.run([
        "docker", "compose", "exec", "video-engine", 
        "ffmpeg", "-y", "-f", "lavfi", "-i", "color=c=blue:s=320x240:d=2", 
        "-vcodec", "libx264", "-pix_fmt", "yuv420p", "/app/media/test_video.mp4"
    ], check=True)
    
    print("Creating tutorial via API...")
    resp = requests.post(
        "http://127.0.0.1:38289/tutorials/",
        json={
            "title": "E2E Test Tutorial",
            "description": "Testing the transcode pipeline",
            "video_url": "test_video.mp4"
        }
    )
    resp.raise_for_status()
    tut_id = resp.json()["id"]
    print(f"Created tutorial ID: {tut_id}")
    
    print("Waiting for celery worker to process...")
    time.sleep(5)
    
    print("Checking if HLS playlist was generated...")
    res = subprocess.run([
        "docker", "compose", "exec", "video-engine", 
        "ls", f"/app/media/{tut_id}/playlist.m3u8"
    ], capture_output=True, text=True)
    
    if res.returncode == 0:
        print("Success! E2E media pipeline is working.")
        sys.exit(0)
    else:
        print("Failed! HLS playlist not found.")
        print("Worker logs:")
        subprocess.run(["docker", "compose", "logs", "--tail=20", "video-engine"])
        sys.exit(1)

if __name__ == "__main__":
    main()
