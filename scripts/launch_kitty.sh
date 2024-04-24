#!/bin/zsh
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ~/.zprofile
source ~/.zshrc
exec /Applications/kitty.app/Contents/MacOS/kitty \
  --session=$HOME/.config/kitty/sessions/default.conf \
  --single-instance
