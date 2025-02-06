#!/usr/bin/env bash

WALLPAPERS_DIR="$HOME/nixos-configuration/src/wallpapers"

change_wallpaper() {
    local wallpaper
    wallpaper=$(find "$WALLPAPERS_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.webp" \) | shuf -n1)
    
    if [[ -f "$wallpaper" ]]; then
        wal -i "$wallpaper" -q -e
        
        ~/.local/bin/apply-color-scheme.sh
        
        echo "Changed wallpaper to: $(basename "$wallpaper")"
    else
        echo "Error: No wallpapers found in $WALLPAPERS_DIR"
        exit 1
    fi
}

while true; do
    change_wallpaper
    sleep 900
done
