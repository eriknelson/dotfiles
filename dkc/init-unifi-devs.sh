#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

informAddr=""

devHostnames=(
  "switch0"
  "switch1"
  "ap-lounge"
  "ap-living"
  "ap-bonus"
  "ap-master"
)

for dev in ${devHostnames[@]}; do
  ssh $dev sh -c 'set-inform http://unifi.kotawerks.gg:8080/inform'
done
