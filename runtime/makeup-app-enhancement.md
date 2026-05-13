# Implementation Plan - LuxeLogic 3D/AR & AI Enhancements

## Objective
Transform LuxeLogic into a high-end, female-oriented makeup application featuring real-time 3D face manipulation, high-fidelity beauty tutorials, voice-activated AI, and "Deep Glass" aesthetics.

## Key Files & Context
- `PRODUCT_BRIEF.md`: Core vision and audience.
- `_AGENT_SYSTEM/`: Meta-system for governance and blueprints.
- `core-service/`: Backend for profiles and beauty data.
- `video-engine/`: FFmpeg-based worker for high-res media.

## Proposed Solution

### 1. Hybrid Rendering Strategy (The "Best of Both Worlds")
- **Real-time Interactive (Frontend)**: Use **Three.js** and **MediaPipe** in a new `beauty-frontend` service. This allows users to see makeup applied to their face live or on a 3D model, with interactive manipulation (rotating, zooming).
- **High-Res Static (Backend)**: Enhance the `video-engine` to generate high-fidelity 4K beauty renders using Blender or specialized image-processing libraries. This ensures users can "clearly see" detail that real-time mobile GPUs might miss.

### 2. Service Additions & Changes
#### A. New `beauty-frontend` (Next.js + Three.js + Tailwind)
- **Deep Glass Aesthetic**: Implement frosted glass effects, soft shadows, and pastel-rich palettes.
- **3D Viewer**: A custom component that loads `.gltf` face models.
- **AR Overlay**: MediaPipe Face Mesh integration to map makeup "steps" (textures) onto the user's face landmarks.
- **Jewelry Logic**: 3D asset loader that auto-anchors earrings/necklaces to specific facial landmarks with customizable scaling.

#### B. `core-service` Enhancements
- **Beauty Knowledge Base**: Add tables for "Makeup Techniques" (steps, required products, tutorial links).
- **AI Voice Integration**: REST endpoints to interface with an LLM (e.g., Gemini) for natural language beauty advice.
- **Easter Egg**: A hidden "Kehley Smith" dedication entry in the database and a corresponding UI trigger.

#### C. `video-engine` Enhancements
- **High-Res Pipeline**: Add tasks to render high-fidelity step-by-step images from 3D scenes for the "detailed closeup" feature.

### 3. AIAST Tailoring
- **`PROJECT_PROFILE.md` Updates**: Synchronize identities across all services.
- **New Blueprint**: Create `_AGENT_SYSTEM/TEMPLATE/_system/starter-blueprints/BEAUTY_AR_APP.md`.

## Implementation Steps

### Phase 1: Meta-System & Backend Alignment
1. Update `PROJECT_PROFILE.md` in `core-service`, `video-engine`, and `api-gateway`.
2. Define SQL models for MakeupTechniques and Steps in `core-service/src/models.py`.
3. Create the "Kehley Smith" easter egg route in `core-service`.

### Phase 2: Beauty Frontend Foundation
1. Scaffold `beauty-frontend` using the AIAST `REACT_VITE_TYPESCRIPT` blueprint (adapted for Next.js).
2. Implement the "Deep Glass" theme (CSS/Tailwind).
3. Set up the basic Three.js scene with a generic 3D face model.

### Phase 3: 3D/AR Integration
1. Integrate MediaPipe Face Mesh for landmark detection.
2. Implement "Makeup Layering" logic (applying textures to face mesh).
3. Build the "Jewelry Placement" tool (upload -> scale -> anchor).

### Phase 4: AI Voice & TTS
1. Implement Web Speech API in the frontend for voice input.
2. Connect voice input to a new `/ai/ask` endpoint in `core-service`.
3. Add TTS (Text-to-Speech) for the AI to "speak" instructions back to the user.

### Phase 5: Verification & Polishing
1. End-to-end test: Select tutorial -> See 3D preview -> Ask AI for tip.
2. Validate high-res render generation in `video-engine`.
3. Verify the "Kehley Smith" easter egg works.

## Verification & Testing
- **UI/UX**: Check "Deep Glass" compliance and visual fidelity.
- **AR Accuracy**: Verify makeup textures align correctly with facial features.
- **Voice Response**: Ensure the AI correctly pulls up the requested page/technique.
- **System Health**: Run `system-doctor.sh` to ensure all services remain AIAST-aligned.

## Migration & Rollback
- Database migrations for new beauty tables.
- Docker Compose update to include the new `beauty-frontend`.
- Standard git-revert path for all microservice changes.
