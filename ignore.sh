#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
  echo "Running Darwin"

  ignoreFiles=(
    "iterm2"
    "README.md"
    "scripts"
    "oh-my-zsh"
    "linux_screen_layout.sh"
    "openbox"
    "brew.list"
    "base16-shell"
    "Xresources"
    "tmux.conf.linux"
    "ref"
  )
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
  echo "Running Linux"

  ignoreFiles=(
    "iterm2"
    "README.md"
    "scripts"
    "oh-my-zsh"
    "linux_screen_layout.sh"
    "openbox"
    "brew.list"
    "base16-shell"
    "Xresources"
    "tmux.conf.darwin"
    "ref"
  )
fi
