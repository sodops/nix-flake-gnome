#!/usr/bin/env bash
# Wallpaper Engine to GNOME Bridge Script
# This script helps set Wallpaper Engine wallpapers in GNOME

WALLPAPER_DIR="$HOME/.steam/steam/steamapps/workshop/content/431960"
WALLPAPERS_OUTPUT="$HOME/Wallpapers/wallpaper-engine"

# Create output directory if it doesn't exist
mkdir -p "$WALLPAPERS_OUTPUT"

echo "🎨 Wallpaper Engine to GNOME Converter"
echo "======================================"
echo ""
echo "Available wallpapers:"
echo ""

# Find all wallpaper directories
counter=1
declare -a wallpaper_dirs

for dir in "$WALLPAPER_DIR"/*; do
    if [ -d "$dir" ]; then
        wallpaper_id=$(basename "$dir")
        
        # Check for project.json to get wallpaper name
        if [ -f "$dir/project.json" ]; then
            # Try to extract title from project.json
            title=$(grep -o '"title"[[:space:]]*:[[:space:]]*"[^"]*"' "$dir/project.json" | sed 's/"title"[[:space:]]*:[[:space:]]*"\([^"]*\)"/\1/')
            
            if [ -z "$title" ]; then
                title="Wallpaper $wallpaper_id"
            fi
        else
            title="Wallpaper $wallpaper_id"
        fi
        
        # Check what files are available
        has_mp4=$(find "$dir" -maxdepth 1 -name "*.mp4" | head -1)
        has_webm=$(find "$dir" -maxdepth 1 -name "*.webm" | head -1)
        has_jpg=$(find "$dir" -maxdepth 1 -name "*.jpg" -o -name "*.png" | head -1)
        
        type="Unknown"
        if [ -n "$has_mp4" ]; then
            type="Video (MP4)"
        elif [ -n "$has_webm" ]; then
            type="Video (WebM)"
        elif [ -n "$has_jpg" ]; then
            type="Static Image"
        else
            type="Scene (requires export)"
        fi
        
        echo "[$counter] $title"
        echo "    Type: $type"
        echo "    ID: $wallpaper_id"
        echo ""
        
        wallpaper_dirs[$counter]="$dir"
        ((counter++))
    fi
done

if [ ${#wallpaper_dirs[@]} -eq 0 ]; then
    echo "❌ No wallpapers found. Please download wallpapers from Wallpaper Engine first."
    exit 1
fi

echo ""
read -p "Select wallpaper number (1-$((counter-1))): " selection

if [ -z "$selection" ] || [ "$selection" -lt 1 ] || [ "$selection" -ge "$counter" ]; then
    echo "❌ Invalid selection"
    exit 1
fi

selected_dir="${wallpaper_dirs[$selection]}"
echo ""
echo "📁 Selected: $selected_dir"
echo ""

# Check for video files
video_file=$(find "$selected_dir" -maxdepth 1 \( -name "*.mp4" -o -name "*.webm" \) | head -1)

if [ -n "$video_file" ]; then
    echo "🎬 Found video wallpaper: $(basename "$video_file")"
    echo ""
    echo "For GNOME, you have 2 options:"
    echo ""
    echo "1. Copy video to ~/Wallpapers and use a GNOME extension"
    echo "2. Use mpv to play video as background (requires manual setup)"
    echo ""
    read -p "Choose option (1 or 2): " option
    
    if [ "$option" = "1" ]; then
        output_file="$WALLPAPERS_OUTPUT/$(basename "$video_file")"
        cp "$video_file" "$output_file"
        echo "✅ Video copied to: $output_file"
        echo ""
        echo "📝 Next steps:"
        echo "   1. Install a GNOME extension for video wallpapers"
        echo "   2. Or use: gsettings set org.gnome.desktop.background picture-uri \"file://$output_file\""
        echo "      (Note: GNOME doesn't natively support video wallpapers)"
    elif [ "$option" = "2" ]; then
        echo "🎥 To use mpv as background wallpaper:"
        echo ""
        echo "Run this command:"
        echo "mpv --loop --no-audio --wid=0 --no-osc --no-input-default-bindings \\"
        echo "    --input-conf=/dev/null --title=mpvbg --geometry=1920x1080+0+0 \\"
        echo "    --no-border \"$video_file\" &"
        echo ""
        echo "Note: This is a workaround and may not work perfectly on all systems."
    fi
else
    # Check for static images
    image_file=$(find "$selected_dir" -maxdepth 1 \( -name "*.jpg" -o -name "*.png" \) -not -name "preview.*" | head -1)
    
    if [ -z "$image_file" ]; then
        # Use preview if no other image found
        image_file=$(find "$selected_dir" -maxdepth 1 \( -name "preview.jpg" -o -name "preview.png" \) | head -1)
    fi
    
    if [ -n "$image_file" ]; then
        output_file="$WALLPAPERS_OUTPUT/$(basename "$selected_dir").jpg"
        cp "$image_file" "$output_file"
        echo "✅ Image copied to: $output_file"
        echo ""
        echo "Setting as GNOME wallpaper..."
        gsettings set org.gnome.desktop.background picture-uri "file://$output_file"
        gsettings set org.gnome.desktop.background picture-uri-dark "file://$output_file"
        echo "✅ Wallpaper set successfully!"
    else
        echo "⚠️  This wallpaper uses Wallpaper Engine's scene format (.pkg)"
        echo "   It cannot be directly exported. You can:"
        echo "   1. Take a screenshot in Wallpaper Engine"
        echo "   2. Look for alternative wallpapers in Steam Workshop"
        echo "   3. Use the preview image"
        
        preview=$(find "$selected_dir" -maxdepth 1 -name "preview.*" | head -1)
        if [ -n "$preview" ]; then
            read -p "Use preview image as wallpaper? (y/n): " use_preview
            if [ "$use_preview" = "y" ]; then
                output_file="$WALLPAPERS_OUTPUT/$(basename "$selected_dir")_preview.jpg"
                cp "$preview" "$output_file"
                gsettings set org.gnome.desktop.background picture-uri "file://$output_file"
                gsettings set org.gnome.desktop.background picture-uri-dark "file://$output_file"
                echo "✅ Preview set as wallpaper!"
            fi
        fi
    fi
fi

echo ""
echo "✨ Done!"
