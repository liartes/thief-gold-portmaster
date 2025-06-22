#!/bin/bash
# PORTMASTER: thiefgold.zip, Thief Gold.sh

#XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

if [ -d "/opt/system/Tools/PortMaster/" ]; then
  controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
  controlfolder="/opt/tools/PortMaster"
elif [ -d "$XDG_DATA_HOME/PortMaster/" ]; then
  controlfolder="$XDG_DATA_HOME/PortMaster"
else
  controlfolder="/roms/ports/PortMaster"
fi

source $controlfolder/control.txt
[ -f "${controlfolder}/mod_${CFW_NAME}.txt" ] && source "${controlfolder}/mod_${CFW_NAME}.txt"
get_controls

# Variables
export WINEPREFIX="/storage/.wine8"
export WINEARCH=win32
export SDL_GAMECONTROLLERCONFIG="$sdl_controllerconfig"
GAMEDIR="/$directory/ports/thiefGold"
WINEDIR="$GAMEDIR/data/wine-8.7-amd64/bin"
WINEBIN="wine"
EXEC="$WINEPREFIX/drive_c/thief/THIEF.EXE"
BASE=$(basename "$EXEC")

# Install custom wine binary
# untar to /tmp as a workaround to symlink in the tar causing errors
if [ ! -d "$WINEDIR" ]; then
curl -L "https://github.com/Kron4ek/Wine-Builds/releases/download/8.7/wine-8.7-amd64.tar.xz" -o "/tmp/wine-8.7-amd64.tar.xz"
cd "/tmp"
tar -xf "wine-8.7-amd64.tar.xz"
cd "$GAMEDIR/data"
mv "/tmp/wine-8.7-amd64" .
rm "/tmp/wine-8.7-amd64.tar.xz"
fi

# set log
> "$GAMEDIR/log.txt" && exec > >(tee "$GAMEDIR/log.txt") 2>&1

$GPTOKEYB "$BASE" -c "$GAMEDIR/ThiefGold.gptk" &

# Change display scale to 960x576
wlr-randr --output DSI-1 --scale 2

#
# Install Thief Gold to the wineprefix. REQUIRE KEYBOARD TO SET INSTALLATION FOLDER 
# Require setup file from GOG and Tfix 1.27 patch file
# Copy controls bindings and default configuration
# (optional) install french patch, require the community file
#
# As an alternative, you can drop your Thief Gold game files to "$WINEPREFIX/drive_c/thief folder
#
if [ ! -f "$EXEC" ]; then
# setup wine prefix
# SETUP MANUALLY : Override ir50_32 dll
# SETUP MANUALLY : emulate virtual desktop, resolution 960x576
box64 "$WINEDIR/$WINEBIN" winecfg
# install Thief Gold to C:\thief
box64 "$WINEDIR/$WINEBIN" "$GAMEDIR/data/setup_thief_gold_1.26_nd_(21948).exe"
# Last TFix
box64 "$WINEDIR/$WINEBIN" "$GAMEDIR/data/TFix_1.27b.exe"
# French patch
if [ -f "$GAMEDIR/data/ThiefGold_FrenchPatch12b5.exe" ]; then
box64 "$WINEDIR/$WINEBIN" "$GAMEDIR/data/ThiefGold_FrenchPatch12b5.exe"
fi
# copy game configuration to installation dir
cp -f "$GAMEDIR/config/cam.cfg" "$WINEPREFIX/drive_c/thief/cam.cfg"
cp -f "$GAMEDIR/config/cam_ext.cfg" "$WINEPREFIX/drive_c/thief/cam_ext.cfg"
# copy bindings and SAVES to installation dir
cp -rf "$GAMEDIR/config/SAVES/." "$WINEPREFIX/drive_c/thief/SAVES/."
fi

# Run the game
cd "$WINEPREFIX/drive_c/thief"
box64 "$WINEDIR/$WINEBIN" "THIEF.EXE"
# Set back display scale to 1920x1152
wlr-randr --output DSI-1 --scale 1

# Kill processes
wineserver -k
pm_finish
