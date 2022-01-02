#!/usr/bin/env bash
#
# Inspired by:
# https://aweirdimagination.net/2015/02/27/hash-based-hostname-colors/

cd "$(dirname "${BASH_SOURCE[0]}")"

host_color="$(hostname | md5sum | head -c 6)"
text_color="$(awk -f ./scripts/legible_with.awk "$host_color")"

tmux set -g status-style "bg=#$host_color,fg=#$text_color"
