# tmux status color

Automatically colorize tmux' status bar differently for each host, so you can differentiate them at a glance.

# Installation

## With [tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

Add this plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'crazygolem/tmux-status-color'

Hit `prefix + I` to fetch the plugin and source it.

## Manually

Clone the repo:

    git clone https://github.com/crazygolem/tmux-status-color ~/clone/path

Add the following line to your `.tmux.conf`:

    run-shell ~/clone/path/colorize.tmux

Reload the tmux environment with `tmux source-file ~/.tmux.conf`.
