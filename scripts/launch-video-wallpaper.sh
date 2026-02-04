#!/usr/bin/env bash
# Simple Video Wallpaper Launcher for GNOME
# Usage: Run this script to start your Wallpaper Engine video as background

# Video path - change this to use different wallpapers
VIDEO_PATH="$HOME/.steam/steam/steamapps/workshop/content/431960/2902830928/Minecraft Soothing Scenes – Relaxing Fireplace.mp4"

# Check if video exists
if [ ! -f "$VIDEO_PATH" ]; then
    echo "❌ Video not found: $VIDEO_PATH"
    echo "Please check your Wallpaper Engine downloads"
    exit 1
fi

# Kill any existing video wallpaper
pkill -f "mpv.*live-wallpaper" 2>/dev/null

echo "🎬 Starting video wallpaper..."
echo "Video: $(basename "$VIDEO_PATH")"
echo ""
echo "To stop: pkill -f 'mpv.*live-wallpaper'"
echo ""

# Start MPV in fullscreen, looping, no audio
mpv \
    --loop-file=inf \
    --no-audio \
    --fullscreen \
    --no-osc \
    --no-osd-bar \
    --no-input-default-bindings \
    --input-conf=/dev/null \
    --title="live-wallpaper" \
    --really-quiet \
    --hwdec=auto \
    --keep-open=yes \
    "$VIDEO_PATH" &

MPV_PID=$!

echo "✅ Video wallpaper started (PID: $MPV_PID)"
echo ""
echo "💡 Tips:"
echo "  - Press Super+H to minimize the video window"
echo "  - Or use GNOME's window management to send it to background"
echo "  - The video will loop infinitely"
echo ""
echo "To make this auto-start on login:"
echo "  1. Open GNOME Tweaks"
echo "  2. Go to 'Startup Applications'"
echo "  3. Add this script: $0"
