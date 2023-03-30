#!/bin/bash
# Kamatera cloud control
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

action=$1

function _up(){
  echo "Launching cloud nsk cloud..."
}

function _down(){
  echo "Tearing down nsk cloud..."
  cloudcli network list
}

if [[ "$action" == "" ]]; then
  echo "ERROR: Must provide an action (up|down)"
  exit
fi

if [[ "$action" == "up" ]]; then
  _up
elif [[ "$action" == "down " ]]; then
  _down
else
  echo "ERROR: Unknown action"
fi
