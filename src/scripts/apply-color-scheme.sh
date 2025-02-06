#!/usr/bin/env bash

xrdb -merge $HOME/.cache/wal/colors.Xresources

# Source the color scheme
source "$HOME/.cache/wal/colors.sh"

# Set bspwm border colors
bspc config normal_border_color "$color1"
bspc config active_border_color "$color2"
bspc config focused_border_color "$color15"
bspc config presel_feedback_color "$color1"

if [ ! -f /tmp/polybarhidden ]; then
  polybar-msg cmd restart
  bspc config top_padding 38
fi