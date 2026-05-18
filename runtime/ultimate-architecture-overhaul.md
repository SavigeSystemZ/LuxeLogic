# Ultimate Architecture Overhaul

## Background & Motivation
The current LuxeLogic application has an impressive set of backend capabilities (real-time video processing via Celery, GenAI Vision analysis, JWT authentication, and 3D jewelry/makeup endpoints) and a stunning "Deep Glass" frontend aesthetic. However, the frontend currently functions as a congested single-page application with several critical disconnects: missing WebSockets for task updates, dead navigation links, lack of auth headers in API calls, missing 3D `.glb` assets, and no UI to interact with the Vision AI endpoint. To meet the standard of an "ultimate level" makeup application, we need to transition to a scalable, robust, and fully-featured architecture.

## Scope & Impact
This plan impacts the `beauty-frontend` component primarily, with minor asset additions to the public folder. It will transform the UI from a single prototype page into a multi-route Next.js application, introducing proper global state management, real-time connectivity, and advanced multimodal capabilities.

## Proposed Solution
We will execute the "Masterpiece Architecture Path" which includes:
1. **Next.js App Router Expansion**: Creating dedicated routes for `/tutorials`, `/techniques`, `/try-on`, and `/vision-ai`.
2. **Global WebSocket Context**: Implementing a React Context provider for WebSockets to listen to task updates (e.g., video transcode completion) globally.
3. **Secure Auth Interceptor**: Updating all `fetch` calls to automatically include the user's JWT token, utilizing a customized API hook or utility.
4. **Multimodal Vision UI**: Building a sleek "Recreate the Look" interface allowing users to upload an image and have the Gemini Vision API parse and apply the makeup via AR.
5. **Asset Pipeline Stabilization**: Dynamically serving or generating placeholder `.glb` models for jewelry try-on so the 3D scene does not fail when querying missing assets.

## Alternatives Considered
- **Core Stability Path**: Fixing issues directly within the single `page.tsx` file. Rejected because it restricts future growth, leads to a bloated component, and compromises the "ultimate" application feel.

## Implementation Plan

### Phase 1: Architectural Foundation & Routing
- Set up new Next.js route directories (`app/tutorials/page.tsx`, `app/techniques/page.tsx`, `app/vision/page.tsx`).
- Abstract the Navigation and Header into a shared `layout.tsx` component to ensure dead links become active.

### Phase 2: Security & Global State
- Create `lib/apiClient.ts` to wrap all `fetch` requests with `Authorization: Bearer <token>` automatically.
- Refactor existing API calls in `useBeautyAI.ts` and `page.tsx` to use the new client.
- Implement `contexts/WebSocketContext.tsx` to establish and maintain connections to `/ws/tasks/{task_id}`.

### Phase 3: Advanced Multimodal UI
- Build the `VisionUploader` component in `/vision` capable of accepting image uploads and interacting with the backend `/ai/recreate-look` endpoint.
- Pipe the returned AI actions into the `BeautyScene` AR context.

### Phase 4: Asset and Rendering Hardening
- Add fallback geometries in the `JewelryAnchor` component or generate basic placeholder `.glb` files in `public/assets/` to ensure the Three.js canvas never crashes on missing models.

## Verification
- **Routing**: Click all navigation links; ensure they load distinct, styled pages.
- **Real-Time**: Trigger a video upload/tutorial creation and watch the WebSocket context update the UI in real-time.
- **Auth**: Inspect network tabs to ensure JWTs are passed; verify protected endpoints return 200 OK.
- **Vision AI**: Upload an image and verify the AI returns a valid makeup mapping that updates the Three.js shaders.

## Migration & Rollback
- All frontend changes will be made sequentially. We can rely on `git checkout` to restore the previous state if any routing changes critically break the development server.
