#!/bin/sh
xrandr \
  --output HDMI-0 --off \
  --output DP-0 --primary --mode 3840x1080 --pos 394x1080 --rotate normal \
  --output DP-1 --off \
  --output DP-2 --off \
  --output DP-3 --mode 1920x1080 --pos 1920x0 --rotate normal \
  --output DP-4 --off \
  --output DP-5 --mode 1920x1080 --pos 0x0 --rotate normal \
  --output HDMI-1-1 --off \
  --output DP-1-1 --off
