#!/usr/bin/env bash

# Take a screenshot and store it in Wayland clipboard (no file)
hyprshot -m region --clipboard-only

# Create temp file
tmpimg=$(mktemp --suffix=.png)

# Explicitly request PNG data from Wayland clipboard
wl-paste > "$tmpimg" || {
    echo "Failed to get image/png from clipboard."
    rm "$tmpimg"
    exit 1
}

# Confirm it's a PNG
echo "wl-paste img"
file "$tmpimg"

# Input the image from wl-paste from the first file
xclip -selection clipboard -i "$tmpimg" || {
    echo "xclip failed to extract image/png from tmpimg file"
    rm "$tmpimg"
    exit 1
}

# Create temp file for xclip
xtmpimg=$(mktemp --suffix=.png)

# Output the image back from xclip to the new file
xclip -selection clipboard -o > "$xtmpimg" || {
    echo "Failed to extract image/png from xclip"
    rm "$xtmpimg"
    exit 1
}

# Confirm it's a PNG
echo "xclip img"
file "$xtmpimg"

# Clean up
rm "$tmpimg"
rm "$xtmpimg"

