# LuxeLogic TODO

## Current Priority

- [x] Initial scaffolding of all microservices
- [x] Create root `PRODUCT_BRIEF.md` and `PLAN.md` (pivoted to makeup & beauty focus)
- [x] Stabilize `docker-compose.yml` to include `core-service` and `video-engine`
- [x] Implement initial `core-service` (FastAPI) and `video-engine` (Python + FFmpeg skeleton)
- [x] Establish communication between `core-service` and PostgreSQL/DragonflyDB for beauty profiles
- [x] Run `docker-compose up` to verify initial build and networking
- [x] Run an enhancement run on the meta-system (`system-doctor.sh`, etc.) to align it with current needs.
- [x] Define shared volumes for makeup tutorial media storage between services
- [x] Implement 3D/AR Beauty Frontend with "Deep Glass" aesthetic
- [x] Integrate MediaPipe Face Mesh for real-time face tracking
- [x] Build virtual jewelry try-on system (Earrings, Necklaces)
- [x] Implement voice-activated Beauty AI with TTS/STT
- [x] Add "Kehley Smith" dedication easter egg with special visual triggers
- [x] Implement actual 3D face mesh triangulation with canonical UV mapping
- [x] Develop GLSL shader for multi-layered makeup application (Foundation, Blush, Lipstick)
- [x] Implement real-time skin tone and undertone analysis from video feed
- [x] Integrate Google Gemini API into `core-service` with "Hollywood Makeup Artist" persona
- [x] Connect frontend AI assistant to Gemini backend with action parsing

## Ready Queue

- [x] Define initial REST API endpoints for beauty techniques and dedications
- [x] Create initial video transcoding test cases for high-res makeup tutorials
- [x] Configure `api-gateway` (Traefik) for dynamic service discovery
- [x] Test HLS streaming from `media-server`
- [x] Ensure end-to-end media upload and processing pipeline using a valid media payload
- [ ] Implement advanced dynamic highlighting for tutorial steps on 3D mesh
- [ ] Develop full product catalog integration for makeup and jewelry
- [ ] Optimize 3D assets and shaders for mobile performance
- [ ] Implement secure user authentication and authorization (JWT) for `beauty-frontend`

## Completed This Session

- [x] Pivoted product brief and plan to a female-oriented app for makeup, look maintenance, and movie-star techniques.
- [x] Ran validation and enhancement steps on the local meta-system copy in `_AGENT_SYSTEM` and fixed integration issues.
- [x] Defined and implemented `core-service/src/models.py` with `UserProfile`, `Tutorial`, and `FavoriteTutorial` schemas.
- [x] Configured DB connections using SQLAlchemy and validated health endpoint in `core-service/src/main.py`.
- [x] Successfully rebuilt and verified Docker Compose stack and backend communication.
- [x] Added shared `media_storage` volume in `docker-compose.yml` for `video-engine` and `mock-media-server`.
- [x] Created `Tutorial` and `FavoriteTutorial` REST endpoints in `core-service/src/main.py`.
- [x] Implemented initial FFmpeg HLS transcoding and thumbnail extraction in `video-engine/src/worker.py`.
- [x] Added dynamic Traefik API gateway labels to route HTTP traffic correctly to `core-service` and `media-server`.
- [x] Integrated `core-service` and `video-engine` using Celery over DragonflyDB for asynchronous media processing tasks.