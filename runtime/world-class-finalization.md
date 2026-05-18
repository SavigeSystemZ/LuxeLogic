# LuxeLogic World-Class Finalization Plan

## Objective
To elevate LuxeLogic to a professional, distribution-ready state by enforcing strict code quality, ensuring cross-platform compatibility (Linux Desktop/Android), and delivering a "one-click" advanced installer.

## Key Files & Context
- `beauty-frontend/`: Next.js application requiring linting and mobile scaffolding.
- `core-service/`: FastAPI backend requiring migration to `google-genai` and strict linting.
- `install.sh`: New top-level installer script.
- `LuxeLogic.desktop`: Linux desktop integration file.

## Implementation Steps

### 1. Code Quality & Linting
- **Backend (Python):**
  - Run `flake8` to detect unused imports and syntax issues.
  - Run `pytest` to ensure all endpoints and models are verified.
  - Upgrade `google-generativeai` to the modern `google-genai` package.
- **Frontend (TypeScript):**
  - Run `npm run lint` and `npm run typecheck`.
  - Resolve any 'any' types or missing interface definitions.

### 2. Desktop Integration
- **Launcher:** Create a `luxelogic-launcher.sh` script that:
  - Checks if Docker is running.
  - Starts the stack in detached mode.
  - Opens the user's default browser to `localhost:38280`.
- **Desktop Entry:** Create `LuxeLogic.desktop` in the root and provide a command to link it to `~/Desktop` and `~/.local/share/applications/`.
- **Icons:** Extract or provide a high-quality icon for the desktop launcher.

### 3. Mobile Distribution (Android)
- **Capacitor Setup:** Initialize `@capacitor/core` and `@capacitor/cli` in `beauty-frontend`.
- **Platform Add:** Add the `android` platform to the frontend.
- **Config:** Set `appId` to `com.luxelogic.app` and `appName` to `LuxeLogic`.

### 4. Advanced Installer (`install.sh`)
- **Interactive CLI:** Use color-coded output and emojis for a "world-class" feel.
- **Dependency Guard:** Check for `docker`, `docker-compose` (V2), `node`, and `git`.
- **Auto-Config:** 
  - Prompt for Gemini API Key.
  - Automatically generate a secure `.env` file.
  - Seed initial database data.
- **Desktop Install:** Automatically install the `.desktop` file to the host environment.
- **Android Ready:** Offer to install Android build dependencies if requested.

## Verification & Testing
- **Linter Pass:** 0 errors from `flake8` and `eslint`.
- **Test Pass:** All `pytest` cases green.
- **Installation Test:** Run `bash install.sh` on a fresh environment and verify the desktop icon appears and the app launches correctly.
- **Android Check:** Verify `npx cap sync android` completes without errors.
