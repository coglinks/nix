#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Searchable enabled keybinds using rofi

# Kill yad to not interfere with this binds
pkill yad || true

# Define the config files
KEYBINDS_CONF="$HOME/st/nix/non-nix/dotfiles/.config/hypr/hyprland-dot-config/keybinds.conf"
LAPTOP_CONF="$HOME/.config/hypr/UserConfigs/Laptop.conf"

# Combine the contents of the keybinds files and filter for keybinds
KEYBINDS=$(grep -E '^\s*(bind[lmer]?|binds)' $KEYBINDS_CONF | sed 's/^\s*bind\s*=\s*//' || echo fail)

# Check if Laptop.conf exists and add its keybinds if present
if [[ -f "$LAPTOP_CONF" ]]; then
    LAPTOP_BINDS=$(grep -E '^(bind|bindl|binde|bindm)' "$LAPTOP_CONF")
    KEYBINDS+=$'\n'"$LAPTOP_BINDS"
fi

# check for any keybinds to display
if [[ -z "$KEYBINDS" ]]; then
    echo "No keybinds found."
    exit 1
fi

# Use rofi to display the keybinds
echo "$KEYBINDS" | rofi -dmenu -i -p "Keybinds" -config ~/.config/rofi/config-keybinds.rasi
