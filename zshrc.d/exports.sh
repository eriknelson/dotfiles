if [[ -f ~/.zshmac ]]; then
  export NSK_GIT_DIR="$HOME/git"
  alias xclipc="pbcopy"
else
  alias xclipc="xclip -selection clipboard"
  alias xclipp="xclip -selection primary"
  export NSK_GIT_DIR="~/git"
fi

if [[ "$(hostname)" == "ferrus" ]]; then
  export NSK_GIT_DIR="$HOME/git"
fi

export VAGRANT_DEFAULT_PROVIDER=libvirt
export GPG_TTY=$(tty)
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export AGNOSTICD_HOME="$NSK_GIT_DIR/mig/agnosticd"

# Go configuration
export GOPATH="$NSK_GIT_DIR"
export GOBIN=$GOPATH/bin
export GOROOT=/usr/lib/go

export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

# Project Nexus
export NSKNX_DIR=$NSK_GIT_DIR/nexus
export NSKNX_CONFIG_DIR=$NSK_GIT_DIR/nexus.config
export NSKNX_STATIC_DIR=/home/ernelson/tank/nexus/static

# Disable telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1
