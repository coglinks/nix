#!/usr/bin/env bash

tmpimg=$(mktemp --suffix=.png)

grim -g "$(slurp)" "$tmpimg" && {
    wl-copy < "$tmpimg"
    xclip -selection clipboard -t image/png -i "$tmpimg"
    file "$tmpimg"
    rm "$tmpimg"
}

