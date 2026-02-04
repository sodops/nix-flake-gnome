#!/usr/bin/env bash
# Video Wallpaper Launcher for GNOME
# This script plays a video as desktop background using mpv

VIDEO_PATH="$1"

if [ -z "$VIDEO_PATH" ]; then
    echo "Usage: $0 <path-to-video>"
    echo "Example: $0 ~/Wallpapers/my-video.mp4"
    exit 1
fi

if [ ! -f "$VIDEO_PATH" ]; then
    echo "Error: Video file not found: $VIDEO_PATH"
    exit 1
fi

# Kill any existing video wallpaper
pkill -f "mpv.*video-wallpaper"

# Get screen resolution
RESOLUTION=$(xrandr | grep '*' | awk '{print $1}' | head -1)

# Start mpv in background mode
mpv \
    --loop-file=inf \
    --no-audio \
    --no-osc \
    --no-osd-bar \
    --no-input-default-bindings \
    --input-conf=/dev/null \
    --no-window-dragging \
    --geometry="$RESOLUTION+0+0" \
    --no-border \
    --ontop=no \
    --no-keepaspect-window \
    --wid=0 \
    --title="video-wallpaper" \
    --x11-name="video-wallpaper" \
    --really-quiet \
    "$VIDEO_PATH" &

echo "Video wallpaper started: $VIDEO_PATH"
echo "To stop: pkill -f 'mpv.*video-wallpaper'"
