# LuxeLogic

## Project Overview
LuxeLogic has been pivoted into a female-oriented makeup application utilizing "Deep Glass" aesthetics.

## Architecture
- **API Gateway**: Stable with Traefik. See [api-gateway/GEMINI.md](api-gateway/GEMINI.md).
- **Video Engine**: Celery-based FFmpeg worker. See [video-engine/GEMINI.md](video-engine/GEMINI.md).
- **Media Storage**: Shared volume media storage across microservices. See [media-server/GEMINI.md](media-server/GEMINI.md).
- **Other Components**: 
  - [core-service/GEMINI.md](core-service/GEMINI.md)
  - [database/GEMINI.md](database/GEMINI.md)
  - [cache/GEMINI.md](cache/GEMINI.md)

## Status & Next Steps
- Next sessions focus: End-to-End valid media testing and Frontend Client Integration.

## References
Load `.ai/PROJECT_RULES.md` and `.ai/CURRENT_STATUS.md` before proceeding.
