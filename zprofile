source $HOME/.zshrc
if [[ "$(hostname)" == "swift.lan.nsk.io" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
