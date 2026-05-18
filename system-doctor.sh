#!/bin/bash

# LuxeLogic System Doctor
# Diagnoses and repairs common environment issues.

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🩺 Starting LuxeLogic System Doctor...${NC}\n"

# 1. Check Docker Group
echo -n "Checking docker group membership... "
if groups $USER | grep &>/dev/null '\bdocker\b'; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${RED}FAIL${NC}"
    echo -e "${YELLOW}Warning: Your user is not in the 'docker' group. Desktop icons often fail because they can't access the docker socket without sudo.${NC}"
    echo -e "Action: Run 'sudo usermod -aG docker $USER' and REBOOT your computer."
fi

# 2. Check XDG Desktop Utils
echo -n "Checking desktop utilities... "
if command -v xdg-open &>/dev/null && command -v gio &>/dev/null; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${RED}MISSING${NC}"
fi

# 3. Check Desktop File Permissions
DESKTOP_PATH="$HOME/Desktop/LuxeLogic.desktop"
echo -n "Checking Desktop icon permissions... "
if [ -f "$DESKTOP_PATH" ]; then
    if [ -x "$DESKTOP_PATH" ]; then
        echo -e "${GREEN}OK${NC}"
    else
        echo -e "${RED}NOT EXECUTABLE${NC}"
        chmod +x "$DESKTOP_PATH"
        echo -e "${GREEN}Repaired: chmod +x applied.${NC}"
    fi
else
    echo -e "${YELLOW}NOT FOUND on Desktop.${NC}"
fi

# 4. Check Port Availability
echo -n "Checking Port 38280 availability... "
if ! lsof -i :38280 &>/dev/null; then
    echo -e "${GREEN}OK (Available)${NC}"
else
    echo -e "${RED}CONFLICT${NC}"
    echo -e "${YELLOW}Port 38280 is already in use. This may prevent the gateway from starting.${NC}"
fi

echo -e "\n${BLUE}Doctor complete. If issues persist, please REBOOT to apply group changes.${NC}"
