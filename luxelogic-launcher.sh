#!/bin/bash

# LuxeLogic Launcher
# World-class launcher for the LuxeLogic Beauty App

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}✨ LuxeLogic is preparing for beauty... ✨${NC}"

# Ensure we are in the script's directory so docker compose finds the yml file
cd "$(dirname "$0")"

# 1. Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo -e "${RED}❌ Error: Docker is not running. Please start Docker and try again.${NC}"
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
# Detect OS and open browser
if which xdg-open > /dev/null; then
  xdg-open "http://localhost:38280"
elif which open > /dev/null; then
  open "http://localhost:38280"
else
  echo -e "${BLUE}🔗 Please open your browser and visit: http://localhost:38280${NC}"
fi

echo -e "${GREEN}✨ Enjoy your master look! ✨${NC}"
