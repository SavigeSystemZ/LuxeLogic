# LuxeLogic TODO

## Current Priority

- [x] Initial scaffolding of all microservices
- [x] Create root `PRODUCT_BRIEF.md` and `PLAN.md` (pivoted to makeup & beauty focus)
- [x] Stabilize `docker-compose.yml` to include `core-service` and `video-engine`
- [x] Implement initial `core-service` (FastAPI) and `video-engine` (Python + FFmpeg skeleton)
- [ ] Establish communication between `core-service` and PostgreSQL/DragonflyDB for beauty profiles
- [ ] Run `docker-compose up` to verify initial build and networking
- [ ] Define shared volumes for makeup tutorial media storage between services
- [ ] Run an enhancement run on the meta-system (`system-doctor.sh`, etc.) to align it with current needs.

## Ready Queue

- [ ] Define initial REST API endpoints in `core-service` for makeup techniques and profiles
- [ ] Configure `api-gateway` (Traefik) for dynamic service discovery
- [ ] Create initial video transcoding test cases for high-res makeup tutorials
- [ ] Test HLS streaming from `media-server`

## Completed This Session

- [x] Scaffolding all 6 microservices with AIAST 1.16.0
- [x] Root-level plan and product brief created and pivoted to the female-oriented makeup application vision.
- [x] Template-level automation lane greened and 1.16.0 fixes pushed
