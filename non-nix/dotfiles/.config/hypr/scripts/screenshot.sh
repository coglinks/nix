#!/usr/bin/env bash

hyprshot -m region --clipboard-only

tmpimg=$(mktemp --suffix=.png)

wl-paste > "$tmpimg"

xclip -selection clipboard -i "$tmpimg"

xclip -selection clipboard -o > "$tmpimg"

file "$tmpimg"

rm "$tmpimg"

