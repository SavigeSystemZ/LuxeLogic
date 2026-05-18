#!/bin/bash

# LUXELOGIC FORCE DESKTOP FIX
# Run this if the desktop icon is not opening.

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🛠️  Forcing Desktop Icon Fix...${NC}"

ROOT_DIR=$(pwd)
DESKTOP_PATH="$HOME/Desktop/LuxeLogic.desktop"

# 1. Ensure the desktop entry is correct
echo -e "${BLUE}📦 Verifying entry...${NC}"
cat <<EOF > "$DESKTOP_PATH"
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
EOF

# 2. Permissions
echo -e "${BLUE}🔐 Setting permissions...${NC}"
chmod +x "$DESKTOP_PATH"
chmod +x "$ROOT_DIR/luxelogic-launcher.sh"

# 3. GNOME/KDE Trusting
echo -e "${BLUE}💎 Attempting to trust icon...${NC}"
if command -v gio &> /dev/null; then
    gio set "$DESKTOP_PATH" metadata::trusted true || true
fi

# 4. Feedback
echo -e "${GREEN}✅ Done. Now, RIGHT-CLICK the LuxeLogic icon on your desktop.${NC}"
echo -e "${YELLOW}Select 'Allow Launching' from the menu.${NC}"
echo -e "${YELLOW}Then double-click to start.${NC}"
