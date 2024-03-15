#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [[ "$1" == "" ]]; then
  echo "Uh, no args."
  exit 1
fi

echo "One: $1"
filename=$(basename $1)
echo "Writing to: $filename"
shitpost -f "$1" -b "$2" -o "~/tundra/images/Meemees/shitposts/$filename"
