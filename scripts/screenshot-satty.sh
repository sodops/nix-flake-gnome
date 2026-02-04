#!/usr/bin/env bash
# Screenshot script using GNOME Screenshot + Satty for GNOME Wayland
# Usage: screenshot-satty.sh [area|full]

set -e

# Screenshot saqlanadigan papka
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

# Fayl nomi (vaqt bilan)
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
TEMP_FILE="/tmp/screenshot-$TIMESTAMP.png"
FINAL_FILE="$SCREENSHOT_DIR/screenshot-$TIMESTAMP.png"

MODE="${1:-area}"  # Default: area selection

case "$MODE" in
    "area")
        # Area selection using GNOME Screenshot
        gnome-screenshot -a -f "$TEMP_FILE" 2>/dev/null
        ;;
    "full")
        # Full screen screenshot
        gnome-screenshot -f "$TEMP_FILE" 2>/dev/null
        ;;
    *)
        echo "Usage: $0 [area|full]"
        exit 1
        ;;
esac

# Check if screenshot was taken successfully
if [ ! -f "$TEMP_FILE" ]; then
    # User cancelled screenshot
    exit 0
fi

# Open in Satty for annotation
satty --filename "$TEMP_FILE" --output-filename "$FINAL_FILE" --early-exit 2>/dev/null

# Check if user saved the file
if [ -f "$FINAL_FILE" ]; then
    notify-send "Screenshot Saved" "Screenshot saved to $FINAL_FILE" -i "$FINAL_FILE" 2>/dev/null || true
    # Copy to clipboard
    wl-copy < "$FINAL_FILE" 2>/dev/null || true
else
    notify-send "Screenshot" "Screenshot cancelled" -i dialog-information 2>/dev/null || true
fi

# Clean up temp file
rm -f "$TEMP_FILE"

