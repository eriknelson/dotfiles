#!/bin/bash
CONNAME="Raleigh (RDU2)"
CONID=$(nmcli con | grep Raleigh | awk '{print $3}')
ACTION=$1

if [[ "$ACTION" != "up" ]] && [[ "$ACTION" != "down" ]]; then
  echo "ERROR: First argument must be 'up' or 'down'"
  exit 1
elif [[ "$ACTION" == "up" ]]; then
  echo "Connecting to RH VPN..."
  nmcli con up --ask $CONID
elif [[ "$ACTION" == "down" ]]; then
  echo "Disconnecting from RH VPN..."
  nmcli con down $CONID
fi

nmcli con
