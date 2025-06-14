#!/usr/bin/env bash

if [ -f /tmp/polybarhidden ]; then
  polybar-msg cmd restart
  bspc config top_padding 38
  rm /tmp/polybarhidden
else
  polybar-msg cmd hide
  bspc config top_padding 6
  touch /tmp/polybarhidden
fi
