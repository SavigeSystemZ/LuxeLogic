#!/bin/bash

# LuxeLogic Launcher
# Bulletproof world-class launcher for the LuxeLogic Beauty App

# --- Robust Environment ---
cd "$(dirname "$0")"
LOG_FILE="launcher.log"
export PATH="/usr/bin:/usr/local/bin:$HOME/.local/bin:$PATH"

# Redirect all output to log file and stdout
exec > >(tee -a "$LOG_FILE") 2>&1

echo "--- LuxeLogic Launch $(date) ---"

# --- Error Handling ---
cleanup() {
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo -e "\n\033[0;31m❌ Error: Launch failed with exit code $exit_code.\033[0m"
        echo "Check $LOG_FILE for details."
        echo "Press Enter to close this window..."
        read
    fi
}
trap cleanup EXIT

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}✨ LuxeLogic is preparing for beauty... ✨${NC}"

# 1. Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo -e "${RED}❌ Error: Docker is not running or accessible. Please start Docker and try again.${NC}"
    exit 1
fi

# 2. Start the stack
echo -e "${BLUE}🚀 Starting beauty engines...${NC}"
docker compose up -d

# 3. Wait for api-gateway to be ready
echo -e "${BLUE}⌛ Awaiting system readiness...${NC}"
MAX_RETRIES=30
COUNT=0
while ! curl -s http://localhost:38280/api/health > /dev/null; do
    sleep 2
    COUNT=$((COUNT+1))
    if [ $COUNT -ge $MAX_RETRIES ]; then
        echo -e "${RED}❌ Error: System timed out waiting for core-service.${NC}"
        exit 1
    fi
done

echo -e "${GREEN}✅ System is ready!${NC}"

# 4. Open browser
echo -e "${BLUE}🎨 Opening LuxeLogic Beauty Interface...${NC}"
if which xdg-open > /dev/null; then
  xdg-open "http://localhost:38280"
elif which open > /dev/null; then
  open "http://localhost:38280"
else
  echo -e "${BLUE}🔗 Please open your browser and visit: http://localhost:38280${NC}"
fi

echo -e "${GREEN}✨ Enjoy your master look! ✨${NC}"
