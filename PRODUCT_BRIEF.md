# LuxeLogic Product Brief

## Vision
LuxeLogic is a high-performance microservices-based media processing and distribution platform. It provides a robust API gateway, centralized data management, and specialized engines for video processing and media streaming.

## Core Services
1. **API Gateway (`api-gateway`)**: Entry point for all client requests, handling routing and potentially authentication/authorization. (Powered by Traefik)
2. **Core Service (`core-service`)**: The central business logic layer, managing data entities and orchestrating workflows between other services.
3. **Video Engine (`video-engine`)**: Specialized service for transcoding, thumbnail generation, and video analysis.
4. **Media Server (`media-server`)**: Handles RTMP/HLS streaming and media delivery.
5. **Database (`database`)**: Persistent storage for application state. (PostgreSQL)
6. **Cache (`cache`)**: High-speed transient storage for session data and processing state. (DragonflyDB)

## Target Audience
Media professionals and developers requiring scalable video processing and streaming infrastructure.

## Key Success Criteria
- Low-latency API routing.
- Efficient video transcoding pipelines.
- Stable HLS/RTMP streaming performance.
- Seamless integration between microservices via a shared network.
