# Implementation Plan - Advanced Perfected Beauty Engine

## Objective
Upgrade LuxeLogic from a point-cloud prototype to a professional-grade 3D beauty engine featuring realistic makeup shaders, automated skin tone analysis, and high-fidelity mesh triangulation.

## Key Files & Context
- `beauty-frontend/src/components/BeautyScene.tsx`: The 3D rendering core.
- `beauty-frontend/src/hooks/useFaceMesh.ts`: Landmark data source.
- `core-service/src/main.py`: AI consultation backend.

## Proposed Solution

### 1. High-Fidelity 3D Face Mesh (Phase 6)
- **FaceMeshConstants**: Create `beauty-frontend/src/lib/faceMeshConstants.ts` to store the 896 triangulation indices and canonical UV coordinates for the 468 landmarks.
- **Triangulated Mesh**: Replace `points` in `FaceMeshGeometry` with a `THREE.Mesh`.
- **Custom Shader Material**: Implement a GLSL shader that supports:
    - **Foundation Layer**: Skin-matching overlay with adjustable coverage.
    - **Blush/Contour Layer**: Region-specific color blending based on UV masks.
    - **Lipstick Layer**: High-gloss or matte finish on the lip region landmarks (indices 61, 291, etc.).

### 2. AI Skin Tone & Undertone Analysis (Phase 7)
- **SkinSampler Utility**: A new helper `beauty-frontend/src/lib/skinAnalysis.ts` that:
    - Creates a hidden canvas from the `videoRef`.
    - Samples RGB values from forehead (landmark 10) and cheeks (landmarks 234, 454).
    - Converts RGB to Lab space to determine Tone (Lightness) and Undertone (A/B channels).
- **Auto-Matching Logic**: Send analysis results to `core-service` to dynamically update the user's `UserProfile`.

### 3. Professional Artist AI (Phase 8)
- **Gemini Integration**: Update `core-service` to use the Google Gemini API (via `google-generative-ai` python package).
- **Beauty Persona**: Define a system prompt for the AI to act as a Hollywood Makeup Artist with knowledge of the user's analyzed skin tone.
- **Action Dispatcher**: Enable the AI to return "UI Actions" (e.g., `{ "action": "apply_makeup", "type": "lipstick", "color": "#FF0000" }`).

## Implementation Steps

### Phase 6: Advanced Rendering Engine
1.  **Static Data**: Create `faceMeshConstants.ts` with triangulation indices.
2.  **Shader Implementation**: Write the `BeautyShader` (vertex and fragment).
3.  **Mesh Upgrade**: Modify `BeautyScene.tsx` to use the triangulated mesh and shader.

### Phase 7: Skin Analysis & AI Integration
1.  **Sampler Logic**: Implement `skinAnalysis.ts`.
2.  **UI Feedback**: Show a "Skin Tone Analyzed" toast in the frontend.
3.  **Gemini Connection**: Add `google-generative-ai` to `core-service` and implement the `/ai/consult` endpoint.

### Phase 8: Final Polish & "Kehley Mode" 2.0
1.  **Refined Visuals**: Add soft shadows and subsurface scattering approximations to the shader.
2.  **Voice Control**: Connect voice commands to the new UI Action system.

## Verification & Testing
- **Visual Fidelity**: Compare the 3D makeup layers against real makeup photos for blending quality.
- **Accuracy**: Test skin tone analysis across diverse lighting conditions.
- **AI Relevance**: Ensure Gemini provides specific advice based on the user's face shape and tone.
