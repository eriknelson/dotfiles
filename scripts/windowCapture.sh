#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# 0x2c38c59
ffmpeg -f x11grab -r 30 -s \
  $(xwininfo -id 0x2c38c59 | \
  grep 'geometry' | \
  awk '{print $2;}') \
  -i :0.0+$(xwininfo -id 0x2c38c59 | \
    grep 'Absolute upper-left X' | \
    awk '{print $4;}'\
  ),$(\
    xwininfo -id 0x2c38c59 | \
    grep 'Absolute upper-left Y' | \
    awk '{print $4;}'\
  ) -codec:v libx264 -preset ultrafast -qp 0 -y ~/Documents/AirDNADispute/issue.mp4

#xwininfo -id 0x2c38c59 | \
  #grep 'geometry' | \
  #awk '{print $2;}'
