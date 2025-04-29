#!/bin/bash

notify-send "Starting Updates"

echo "Running DNF update..."
pkexec dnf up -y
notify-send "DNF Update Completed"

echo "Updating Flatpak..."
flatpak update -y
notify-send "Flatpak Update Completed"

echo "Updating Antidote..."
/usr/local/bin/zsh -i -c '. ~/.antidote/antidote.zsh && antidote update'
notify-send "Antidote Updated"

echo "All updates completed."
notify-send "System Updates Completed"

