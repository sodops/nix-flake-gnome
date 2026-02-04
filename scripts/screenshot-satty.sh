#!/usr/bin/env bash
# Screenshot script using GNOME Screenshot + Satty for GNOME Wayland
# Usage: screenshot-satty.sh [area|full]

# Debug log
LOGFILE="/tmp/screenshot-debug.log"
echo "=== Screenshot script started at $(date) ===" >> "$LOGFILE"

# Screenshot saqlanadigan papka
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR" 2>> "$LOGFILE"

# Fayl nomi (vaqt bilan)
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
TEMP_FILE="/tmp/screenshot-$TIMESTAMP.png"
FINAL_FILE="$SCREENSHOT_DIR/screenshot-$TIMESTAMP.png"

MODE="${1:-area}"  # Default: area selection
echo "Mode: $MODE" >> "$LOGFILE"

case "$MODE" in
    "area")
        # Area selection using GNOME Screenshot
        echo "Running gnome-screenshot -a..." >> "$LOGFILE"
        gnome-screenshot -a -f "$TEMP_FILE" >> "$LOGFILE" 2>&1
        RESULT=$?
        echo "gnome-screenshot exit code: $RESULT" >> "$LOGFILE"
        ;;
    "full")
        # Full screen screenshot
        echo "Running gnome-screenshot full..." >> "$LOGFILE"
        gnome-screenshot -f "$TEMP_FILE" >> "$LOGFILE" 2>&1
        RESULT=$?
        echo "gnome-screenshot exit code: $RESULT" >> "$LOGFILE"
        ;;
    *)
        echo "Invalid mode: $MODE" >> "$LOGFILE"
        echo "Usage: $0 [area|full]"
        exit 1
        ;;
esac

# Check if screenshot was taken successfully
if [ ! -f "$TEMP_FILE" ]; then
    echo "Screenshot file not created (user cancelled or error)" >> "$LOGFILE"
    exit 0
fi

echo "Screenshot captured: $TEMP_FILE" >> "$LOGFILE"

# Open in Satty for annotation
echo "Opening satty..." >> "$LOGFILE"
satty --filename "$TEMP_FILE" --output-filename "$FINAL_FILE" --early-exit >> "$LOGFILE" 2>&1
SATTY_RESULT=$?
echo "Satty exit code: $SATTY_RESULT" >> "$LOGFILE"

# Check if user saved the file
if [ -f "$FINAL_FILE" ]; then
    echo "Screenshot saved: $FINAL_FILE" >> "$LOGFILE"
    notify-send "Screenshot Saved" "Screenshot saved to $FINAL_FILE" -i "$FINAL_FILE" 2>/dev/null || true
    # Copy to clipboard
    wl-copy < "$FINAL_FILE" 2>/dev/null || true
    echo "Copied to clipboard" >> "$LOGFILE"
else
    echo "Screenshot not saved (user cancelled in satty)" >> "$LOGFILE"
    notify-send "Screenshot" "Screenshot cancelled" -i dialog-information 2>/dev/null || true
fi

# Clean up temp file
rm -f "$TEMP_FILE"
echo "=== Script completed ===" >> "$LOGFILE"
