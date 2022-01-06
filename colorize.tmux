#!/usr/bin/env bash
#
# Inspired by:
# https://aweirdimagination.net/2015/02/27/hash-based-hostname-colors/

cd "$(dirname "${BASH_SOURCE[0]}")"

tmux_option() {
    local value="$(tmux show-options -gqv "$1")"
    local default="$2"

    [ -n "$value" ] && echo "$value" || echo "$default"
}

host_color="$(
    tmux_option '@status_color_source' "$(tmux display-message -p '#{host}')" \
    | md5sum | head -c 6
)"

text_color="$(awk -f ./scripts/legible_with.awk "$host_color")"

tmux set -g status-style "bg=#$host_color,fg=#$text_color"
