#!/bin/zsh
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
touch ~/derp
#source ~/.zprofile
#source ~/.zshrc
open -a 'kitty' --args \
  --session=$HOME/.config/kitty/sessions/default.conf
