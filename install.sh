#!/bin/bash

# LuxeLogic Advanced Installer
# The world-class way to install the future of beauty.

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Emojis
CHECK="✅"
SPARKLE="✨"
ROCKET="🚀"
ERROR="❌"
SEARCH="🔍"

clear
echo -e "${PURPLE}------------------------------------------------------------${NC}"
echo -e "${PURPLE}          ${SPARKLE} LUXELOGIC WORLD-CLASS INSTALLER ${SPARKLE}           ${NC}"
echo -e "${PURPLE}------------------------------------------------------------${NC}"
echo -e ""

# 1. Dependency Checks
echo -e "${BLUE}${SEARCH} Step 1: Scanning for digital lifeforms (Dependencies)...${NC}"

check_dep() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${RED}${ERROR} Error: $1 is not installed. Please install it to proceed.${NC}"
        exit 1
    else
        echo -e "${GREEN}${CHECK} $1 found.${NC}"
    fi
}

check_dep docker
check_dep node
check_dep git

if ! docker compose version &> /dev/null; then
    echo -e "${RED}${ERROR} Error: 'docker compose' (V2) is not found. Please upgrade Docker.${NC}"
    exit 1
fi

echo -e ""

# 2. Environment Configuration
echo -e "${BLUE}${SPARKLE} Step 2: Harmonizing your environment...${NC}"

if [ ! -f .env ]; then
    echo -e "${YELLOW}📝 .env file not found. Let's create one.${NC}"
    
    # Prompt for Gemini Key (default if empty for dev mode)
    read -p "🔑 Enter your Gemini API Key (press enter to skip if you have it in .env.example): " GEMINI_KEY
    
    cp .env.example .env
    
    if [ ! -z "$GEMINI_KEY" ]; then
        sed -i "s/YOUR_API_KEY/$GEMINI_KEY/g" .env
    fi
    echo -e "${GREEN}${CHECK} Environment file synchronized.${NC}"
else
    echo -e "${GREEN}${CHECK} Environment file exists. Preserving your secrets.${NC}"
fi

echo -e ""

# 3. System Initialization
echo -e "${BLUE}${ROCKET} Step 3: Igniting beauty engines...${NC}"
docker compose build --quiet
docker compose up -d
echo -e "${GREEN}${CHECK} Engines online and purring.${NC}"

echo -e ""

# 4. Desktop Integration
echo -e "${BLUE}🎨 Step 4: Installing the Master Look shortcut...${NC}"

DESKTOP_FILE="/home/$USER/Desktop/LuxeLogic.desktop"
LOCAL_APP_FILE="/home/$USER/.local/share/applications/LuxeLogic.desktop"

# Fix paths in .desktop file based on current directory
ROOT_DIR=$(pwd)
sed -i "s|Exec=.*|Exec=$ROOT_DIR/luxelogic-launcher.sh|g" LuxeLogic.desktop

cp LuxeLogic.desktop "$DESKTOP_FILE"
cp LuxeLogic.desktop "$LOCAL_APP_FILE"
chmod +x "$DESKTOP_FILE"
chmod +x "$LOCAL_APP_FILE"

# Try to trust the desktop file
if command -v gio &> /dev/null; then
    gio set "$DESKTOP_FILE" metadata::trusted true || true
fi

echo -e "${GREEN}${CHECK} Desktop icon installed. Your master look is one click away.${NC}"

echo -e ""

# 5. Finale
echo -e "${PURPLE}------------------------------------------------------------${NC}"
echo -e "${GREEN}          ${SPARKLE} INSTALLATION COMPLETE ${SPARKLE}             ${NC}"
echo -e "${PURPLE}------------------------------------------------------------${NC}"
echo -e ""
echo -e "${BLUE}LuxeLogic is now ready for your creative touch.${NC}"
echo -e "${BLUE}Launch it from your desktop or run:${NC} ${YELLOW}./luxelogic-launcher.sh${NC}"
echo -e ""
echo -e "${PURPLE}Dedicated to Kehley. Empowering beauty everywhere.${NC}"
echo -e ""
