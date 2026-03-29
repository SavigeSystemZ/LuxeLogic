# LuxeLogic TODO

## Current Priority

- [x] Initial scaffolding of all microservices
- [x] Create root `PRODUCT_BRIEF.md` and `PLAN.md`
- [x] Stabilize `docker-compose.yml` to include `core-service` and `video-engine`
- [x] Implement initial `core-service` (FastAPI) and `video-engine` (Python + FFmpeg skeleton)
- [ ] Establish communication between `core-service` and PostgreSQL/DragonflyDB
- [ ] Run `docker-compose up` to verify initial build and networking
- [ ] Define shared volumes for media storage between services

## Ready Queue

- [ ] Define initial REST API endpoints in `core-service`
- [ ] Configure `api-gateway` (Traefik) for dynamic service discovery
- [ ] Create initial video transcoding test cases
- [ ] Test HLS streaming from `media-server`

## Completed This Session

- [x] Scaffolding all 6 microservices with AIAST 1.16.0
- [x] Root-level plan and product brief created
- [x] Template-level automation lane greened and 1.16.0 fixes pushed
