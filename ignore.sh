#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
  echo "Running Darwin"

  ignoreFiles=(
    "gulp-autocompletion-zsh"
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
    "pyenv_install.sh"
    "i3"
    "launch"
  )
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
  echo "Running Linux"

  ignoreFiles=(
    "gulp-autocompletion-zsh"
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
    "pyenv_install.sh"
    "launch"
  )
fi
