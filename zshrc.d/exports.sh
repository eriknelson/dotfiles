if [[ -f ~/.zshmac ]]; then
  export NSK_GIT_DIR="$HOME/git"
  alias xclipc="pbcopy"
else
  alias xclipc="xclip -selection clipboard"
  alias xclipp="xclip -selection primary"
  export NSK_GIT_DIR="/git"
fi

export VAGRANT_DEFAULT_PROVIDER=libvirt
export GPG_TTY=$(tty)
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export AGNOSTICD_HOME="$NSK_GIT_DIR/mig/agnosticd"

# Go configuration
export GOPATH="$NSK_GIT_DIR"
export GOBIN=$GOPATH/bin
if [[ "$(hostname)" == "baldur" ]]; then
  export GOROOT=/usr/lib/go
else
  export GOROOT=/usr/local/go
fi

# Important as part of the set up process for gnome-kering handling ssh keys
# and their associated passphrases so that it doesn't have to be entered into
# the terminal all the time.
# src: https://wiki.archlinux.org/title/GNOME/Keyring#Enable_the_keyring_ssh_component
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh
