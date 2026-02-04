#!/usr/bin/env bash
# Screenshot script using grim + satty for GNOME Wayland
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
        # Area selection using slurp + grim
        grim -g "$(slurp)" "$TEMP_FILE"
        ;;
    "full")
        # Full screen screenshot
        grim "$TEMP_FILE"
        ;;
    *)
        echo "Usage: $0 [area|full]"
        exit 1
        ;;
esac

# Check if screenshot was taken successfully
if [ ! -f "$TEMP_FILE" ]; then
    notify-send "Screenshot" "Screenshot cancelled or failed" -i error
    exit 1
fi

# Open in Satty for annotation
satty --filename "$TEMP_FILE" --output-filename "$FINAL_FILE" --early-exit

# Check if user saved the file
if [ -f "$FINAL_FILE" ]; then
    notify-send "Screenshot Saved" "Screenshot saved to $FINAL_FILE" -i "$FINAL_FILE"
    # Copy to clipboard
    wl-copy < "$FINAL_FILE"
else
    notify-send "Screenshot" "Screenshot cancelled" -i dialog-information
fi

# Clean up temp file
rm -f "$TEMP_FILE"
