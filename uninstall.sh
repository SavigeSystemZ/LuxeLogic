#!/bin/bash

# LuxeLogic Advanced Uninstaller

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🗑️  Starting LuxeLogic Uninstaller...${NC}"

# 1. Stop and remove Docker containers and volumes
echo -e "${BLUE}📦 Removing container stack and volumes...${NC}"
docker compose down -v || true

# 2. Remove Systemd service
echo -e "${BLUE}⚙️  Disabling systemd auto-start service...${NC}"
systemctl --user stop luxelogic.service 2>/dev/null || true
systemctl --user disable luxelogic.service 2>/dev/null || true
rm -f "$HOME/.config/systemd/user/luxelogic.service"
systemctl --user daemon-reload || true

# 3. Remove Desktop Icons
echo -e "${BLUE}🎨 Removing desktop shortcuts...${NC}"
rm -f "$HOME/Desktop/LuxeLogic.desktop"
rm -f "$HOME/.local/share/applications/LuxeLogic.desktop"

echo -e "${GREEN}✅ LuxeLogic has been uninstalled successfully.${NC}"
