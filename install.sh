#!/bin/bash

# LUXELOGIC MASTERPIECE INSTALLER
# Re-architected for absolute host reliability and desktop integration.

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Emojis
CHECK="✅"
SPARKLE="✨"
ROCKET="🚀"
ERROR="❌"
SEARCH="🔍"

clear
echo -e "${PURPLE}------------------------------------------------------------${NC}"
echo -e "${PURPLE}          ${SPARKLE} LUXELOGIC SUPREME INSTALLER ${SPARKLE}               ${NC}"
echo -e "${PURPLE}------------------------------------------------------------${NC}"
echo -e ""

ROOT_DIR=$(pwd)

# 1. CLEANUP PREVIOUS INSTALL
echo -e "${BLUE}${SEARCH} Step 1: Purging old relics...${NC}"
./uninstall.sh &>/dev/null || true
echo -e "${GREEN}${CHECK} Environment pristine.${NC}"

# 2. DEPENDENCY VALIDATION
echo -e "\n${BLUE}${SEARCH} Step 2: Validating host capabilities...${NC}"
check_dep() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${RED}${ERROR} Error: $1 not found.${NC}"
        exit 1
    fi
}
check_dep docker
check_dep xdg-open
echo -e "${GREEN}${CHECK} Host validated.${NC}"

# 3. ENVIRONMENT SYNC
echo -e "\n${BLUE}${SPARKLE} Step 3: Harmonizing secrets...${NC}"
if [ ! -f .env ]; then
    cp .env.example .env
    echo -e "${YELLOW}Warning: Using default .env. Please edit it for AI features.${NC}"
fi
echo -e "${GREEN}${CHECK} Secrets synchronized.${NC}"

# 4. ENGINE IGNITION
echo -e "\n${BLUE}${ROCKET} Step 4: Igniting the 9-Engine Stack...${NC}"
docker compose pull --quiet || true
docker compose build --quiet
docker compose up -d
echo -e "${GREEN}${CHECK} Engines online.${NC}"

# 5. DESKTOP MASTERPIECE INTEGRATION
echo -e "\n${BLUE}🎨 Step 5: Forging the Desktop Masterpiece...${NC}"

# Copy icon to a stable system-like path
mkdir -p "$HOME/.local/share/icons"
cp "$ROOT_DIR/beauty-frontend/public/logo.png" "$HOME/.local/share/icons/luxelogic.png"

# Generate the .desktop file dynamically with absolute robustness
CAT_DESKTOP="$HOME/.local/share/applications/LuxeLogic.desktop"

cat <<EOF > LuxeLogic.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=LuxeLogic
Comment=World-Class AI Makeup & Beauty
Exec=$ROOT_DIR/luxelogic-launcher.sh
Path=$ROOT_DIR
Icon=$HOME/.local/share/icons/luxelogic.png
Terminal=true
Categories=Graphics;
StartupNotify=true
X-GNOME-Autostart-enabled=true
EOF

# Deploy to Desktop and Applications Menu
cp LuxeLogic.desktop "$HOME/Desktop/LuxeLogic.desktop"
cp LuxeLogic.desktop "$CAT_DESKTOP"
chmod +x "$HOME/Desktop/LuxeLogic.desktop"
chmod +x "$CAT_DESKTOP"

# Trust the icon (GNOME specific but safe)
if command -v gio &> /dev/null; then
    gio set "$HOME/Desktop/LuxeLogic.desktop" metadata::trusted true || true
fi

# Refresh desktop database
if command -v update-desktop-database &> /dev/null; then
    update-desktop-database "$HOME/.local/share/applications" || true
fi

echo -e "${GREEN}${CHECK} Desktop Masterpiece forged.${NC}"

# 6. SYSTEMD PERSISTENCE
echo -e "\n${BLUE}⚙️  Step 6: Establishing Boot Persistence...${NC}"
mkdir -p "$HOME/.config/systemd/user"
cat <<EOF > "$HOME/.config/systemd/user/luxelogic.service"
[Unit]
Description=LuxeLogic Beauty Engines
After=network.target docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=$ROOT_DIR
ExecStart=/usr/bin/docker compose up -d
ExecStop=/usr/bin/docker compose down

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable luxelogic.service &>/dev/null || true
echo -e "${GREEN}${CHECK} Persistence established.${NC}"

echo -e "\n${PURPLE}------------------------------------------------------------${NC}"
echo -e "${GREEN}          ${SPARKLE} INSTALLATION COMPLETE ${SPARKLE}             ${NC}"
echo -e "${PURPLE}------------------------------------------------------------${NC}"
echo -e "\n${BLUE}LuxeLogic is now part of your system identity.${NC}"
echo -e "${BLUE}Action:${NC} ${YELLOW}Right-click the Desktop icon and select 'Allow Launching' if prompted.${NC}"
echo -e ""
