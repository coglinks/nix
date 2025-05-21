
#!/bin/bash

# Path to the current wallpaper
current_wallpaper=$(swww query | awk -F'image: ' '/image:/ {print $2}' | xargs)

# Copy the wallpaper to a static location
cp "$current_wallpaper" /tmp/current_wallpaper.png

# Optionally, echo the path for debugging
echo "Current wallpaper path: /tmp/current_wallpaper.png"
