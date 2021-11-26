# Early init
export DOTFILES_DIR="$HOME/.dotfiles"
export GPG_TTY=$(tty)
export GPGKEY=36A4F07B40793DFF

command -v vimx >/dev/null 2>&1
if [[ $? -eq 0 ]]; then
  export EDITOR=vimx
  alias vim='vimx'
  alias sudov='sudo vimx'
else
  export EDITOR=vim
  alias sudov='sudo vim'
fi

############################################################
# OH-MY-ZSH CONFIG
############################################################
export DISABLE_AUTO_UPDATE=true
export ZSH=$DOTFILES_DIR/oh-my-zsh
COMPLETION_WAITING_DOTS="true"
ZSH_THEME="nelsk"

# NOTE: A little more conservative on this one. Caused each
# command on a Fedora box to ask if I wanted to install npm
# since it wasn't available in the path and it recognized it
# was available in a repo. Issue here is that we haven't
# yet sourced anything via nvm
#plugins=(git brew node npm jsontools)
plugins=(
  git
  jsontools
)

source $ZSH/oh-my-zsh.sh

############################################################
# Shell theme
############################################################
# Unset LS_COLORS if set on RPM systems to make way for custom colors
if [[ -n "${LS_COLORS}" ]]; then
  unset LS_COLORS
fi

# NOTE: Guake is using a very old vte version, and does not play nicely
# with base16shell, so we'll defer to the guake themes until it's upgraded
# to GTK3 and a newer version of vte.
BASE16_SHELL="$DOTFILES_DIR/base16-shell/scripts/base16-eighties.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

############################################################
# Exports
############################################################
source $DOTFILES_DIR/zshrc.d/exports.sh

############################################################
# PATH setup
############################################################
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/local/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$GOROOT/bin:$GOBIN
if [[ "$(hostname)" == "srt.hollowgate.nsk.io" ]]; then
  export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

############################################################
# alias import
source "$DOTFILES_DIR/zshrc.d/alias.sh"
############################################################

############################################################
# Load custom fn
############################################################
source $DOTFILES_DIR/zshrc.d/bugzilla_fn.sh
source $DOTFILES_DIR/zshrc.d/iptables_fn.sh
source $DOTFILES_DIR/zshrc.d/docker_fn.sh
source $DOTFILES_DIR/zshrc.d/k8s_fn.sh
source $DOTFILES_DIR/zshrc.d/mig_helpers_fn.sh
source $DOTFILES_DIR/zshrc.d/shell_fn.sh
[[ -f $HOME/.local/zshrc ]] && source $HOME/.local/zshrc

############################################################
# Load local env vars
############################################################
[[ -f $HOME/.localvar ]] && source $HOME/.localvar

############################################################
# Version Managers
############################################################
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -f $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
