#!/bin/bash

# Log to system log
logger "Lid closed: Executing custom action"

# Display notification
/usr/bin/notify-send "Lid closed" "Running custom script"

# Lock the screen using swaylock (ensure swaylock is installed, or use your preferred lock screen)
swaylock &

# Add a short sleep to ensure swaylock is initialized before suspending
sleep 0.5

# Suspend the system
systemctl suspend
