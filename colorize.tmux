#!/usr/bin/env bash
#
# Inspired by:
# https://aweirdimagination.net/2015/02/27/hash-based-hostname-colors/

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export PATH="$CURRENT_DIR/bin:$PATH"

color="$(hostname | md5sum | head -c 6)"
tmux set -g status-style "bg=#$color,fg=#$(legible_color "$color")"
