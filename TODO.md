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

## Ready Queue

- [x] Define initial REST API endpoints in `core-service` for makeup techniques and profiles
- [x] Create initial video transcoding test cases for high-res makeup tutorials
- [x] Configure `api-gateway` (Traefik) for dynamic service discovery
- [ ] Test HLS streaming from `media-server`
- [ ] Ensure end-to-end media upload and processing pipeline using a valid media payload

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