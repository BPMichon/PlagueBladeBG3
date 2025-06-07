#!/bin/bash
# restore.bash: push all BG3 Mod Project files from this repo back to BG3 mod directories
# by mstephenson6, based on backup.bash

set -e;

# === CONFIGURATION ===

# Replace with your actual mod subdir name
MOD_SUBDIR_NAME="ZombieFighter_a3e31384-1a50-bb50-e9ff-dcf64d52485c"

# Path to BG3 Data folder (adjust as necessary)
BG3_DATA="E:/SteamLibrary/steamapps/common/Baldurs Gate 3/Data"

# Mod subdirectories to sync
SUBDIR_LIST=(
	"Projects"
	"Editor/Mods"
	"Mods"
	"Public"
	"Generated/Public"
)

# === VALIDATION ===

if [ -z "$MOD_SUBDIR_NAME" ]; then
	echo "MOD_SUBDIR_NAME must have a value in $(basename $BASH_SOURCE)";
	return 1 2>/dev/null;
	exit 1;
fi

# === RESTORE PROCESS ===

for subdir in "${SUBDIR_LIST[@]}"; do
	SRC_PATH="./$subdir/$MOD_SUBDIR_NAME"
	DEST_PATH="$BG3_DATA/$subdir/$MOD_SUBDIR_NAME"

	if [ ! -d "$SRC_PATH" ]; then
		echo "Skipping missing: $SRC_PATH"
		continue;
	fi

	echo "Copying to: $DEST_PATH"
	rm -rf "$DEST_PATH"
	mkdir -p "$(dirname "$DEST_PATH")"
	cp -a "$SRC_PATH" "$DEST_PATH"
done;

echo "Restore complete."
