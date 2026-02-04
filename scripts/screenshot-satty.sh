#!/usr/bin/env bash
# Screenshot script using interactive gnome-screenshot + Satty
# Usage: screenshot-satty.sh [area|full]

# Debug log
LOGFILE="/tmp/screenshot-debug.log"
echo "=== Screenshot script started at $(date) ===" >> "$LOGFILE"

# Screenshot papka
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR" 2>> "$LOGFILE"

MODE="${1:-area}"
echo "Mode: $MODE" >> "$LOGFILE"

# Get timestamp before screenshot for finding new file
BEFORE_TS=$(date +%s)

# Call gnome-screenshot interactively
case "$MODE" in
    "area")
        echo "Launching gnome-screenshot -a (interactive)" >> "$LOGFILE"
        gnome-screenshot -a >> "$LOGFILE" 2>&1
        ;;
    "full")
        echo "Launching gnome-screenshot (interactive)" >> "$LOGFILE"
        gnome-screenshot >> "$LOGFILE" 2>&1
        ;;
    *)
        echo "Invalid mode" >> "$LOGFILE"
        exit 1
        ;;
esac

# Wait a moment
sleep 1

# Find the most recent screenshot in ~/Pictures
# gnome-screenshot saves to ~/Pictures/Screenshot from YYYY-MM-DD HH-MM-SS.png
LATEST_SCREENSHOT=$(find "$HOME/Pictures" -maxdepth 1 -name "Screenshot*.png" -newermt "@$BEFORE_TS" -type f -printf '%T@ %p\n' 2>/dev/null | sort -n | tail -1 | cut -d' ' -f2-)

if [ -z "$LATEST_SCREENSHOT" ] || [ ! -f "$LATEST_SCREENSHOT" ]; then
    echo "No screenshot found (user cancelled)" >> "$LOGFILE"
    exit 0
fi

echo "Found screenshot: $LATEST_SCREENSHOT" >> "$LOGFILE"

# Use Satty to annotate
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
FINAL_FILE="$SCREENSHOT_DIR/screenshot-$TIMESTAMP.png"

echo "Opening satty..." >> "$LOGFILE"
satty --filename "$LATEST_SCREENSHOT" --output-filename "$FINAL_FILE" --early-exit >> "$LOGFILE" 2>&1
SATTY_RESULT=$?
echo "Satty exit code: $SATTY_RESULT" >> "$LOGFILE"

# Check if user saved
if [ -f "$FINAL_FILE" ]; then
    echo "Screenshot saved: $FINAL_FILE" >> "$LOGFILE"
    notify-send "Screenshot Saved" "Saved to Screenshots/" -i "$FINAL_FILE" 2>/dev/null || true
    wl-copy < "$FINAL_FILE" 2>/dev/null || true
    echo "Copied to clipboard" >> "$LOGFILE"
    
    # Remove original gnome-screenshot file
    rm -f "$LATEST_SCREENSHOT"
    echo "Removed original: $LATEST_SCREENSHOT" >> "$LOGFILE"
else
    echo "User cancelled in Satty" >> "$LOGFILE"
fi

echo "=== Script completed ===" >> "$LOGFILE"
