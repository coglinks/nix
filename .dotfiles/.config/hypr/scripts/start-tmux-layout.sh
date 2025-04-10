#!/usr/bin/env bash

# First tmux session
tmux new-session -d -s main -n yazi "yazi /home/incog267/nixos"
tmux new-window -t main

# Second tmux session
tmux new-session -d -s docker 'docker exec -it arch-docker bash'

# Attach to the first session in window 1
exec tmux attach-session -t main
