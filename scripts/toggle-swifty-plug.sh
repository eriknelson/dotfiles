#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function toggle_swifty() {
  curl -X POST -d '{"id": "0"}' 'swifty-plug.local/rpc/Switch.Toggle'
}

function blink_light() {
  while true; do
    toggle_swifty
    sleep 2
  done
}

#blink_light

toggle_swifty
