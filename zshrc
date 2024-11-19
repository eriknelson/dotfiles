# Early init
export DOTFILES_DIR="$HOME/.dotfiles"
#export GPG_TTY=$(tty)
#export GPGKEY=36A4F07B40793DFF

# Update to nvim from vim or vimx 12/24
export EDITOR=nvim
export GIT_EDITOR=nvim
alias sudov='sudo nvim'

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

if [[ -f ~/.zshmac ]]; then
  plugins=(git brew node npm jsontools)
else
  plugins=(git node npm jsontools)
fi

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
export PATH=$PATH:$HOME/.krew/bin
export PATH=$PATH:$HOME/local/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.venv/bin
export PATH=$PATH:$GOROOT/bin:$GOBIN
if [[ -f ~/.zshmac ]]; then
  export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin"
fi

############################################################
# alias import
source "$DOTFILES_DIR/zshrc.d/alias.sh"
############################################################

############################################################
# Load custom fn
############################################################
#source $DOTFILES_DIR/zshrc.d/bugzilla_fn.sh
#source $DOTFILES_DIR/zshrc.d/iptables_fn.sh
source $DOTFILES_DIR/zshrc.d/docker_fn.sh
source $DOTFILES_DIR/zshrc.d/k8s_fn.sh
source $DOTFILES_DIR/zshrc.d/shell_fn.sh
source $DOTFILES_DIR/zshrc.d/osc_fn.sh
[[ "$(hostname)" == "doscar" ]] && source $DOTFILES_DIR/zshrc.d/doscar_launch_hook.sh
[[ -f $HOME/.local/zshrc ]] && source $HOME/.local/zshrc

############################################################
# Load local env vars
############################################################
[[ -f $HOME/.localvar ]] && source $HOME/.localvar

# 12/31/22 - Commenting this out because although it's a useful script, I've
# seen surprising behavior from it like it not getting activated when it otherwise
# should have activated. Now that I've discovered poetry as well, I think it's
# largely obsolete and "poetry shell" should serve well enough. "poetry run"
# will also run the command within the venv. NOTE: It still depends upon virtualenv.
#[[ -d $DOTFILES_DIR/lib/zsh-autoenv ]] && source $DOTFILES_DIR/lib/zsh-autoenv/autoenv.zsh

############################################################
# Version Managers
############################################################
if [[ "$(hostname)" == *"aurelian"* ]]; then
  export NVM_DIR="$(brew --prefix nvm)"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
elif [[ "$(hostname)" == *"nox"* ]] || [[ "$(hostname)" == *"ferrus"* ]]; then
  export NVM_DIR="/usr/share/nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
else
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

if [[ "$(hostname)" != "doscar" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# RVM loading
export PATH="$HOME/.rvm/bin:$PATH"
#[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
## Squelch the warning by appending ' > /dev/null 2>&1' here
## Handles the warning complaining about missing GEM_HOME
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" &> /dev/null
## RVM fixes whatever it considers the problem to be, on its own, in `rvm use`.
## It also prints some junk we don't care about, so we squelch its output in the same way.
## Actually loads the default
#rvm use default &> /dev/null
# NOTE: Having an issue with some projects that have a ruby version, but no
# gemset attached to that spec that continuously resets my environment from
# my gemset. This should tell rvm to ignore it, and I can use autosrc (see logseq)
# to run some commands in a particular part of the filesystem tree.
#export rvm_ignore_dotfiles=yes
export rvm_ignore_gemfile_ruby=1
export rvm_silence_path_mismatch_check_flag=1

############################################################
# Autocompletion
# NOTE: It's critical that these autoload commands are run first before trying
# to run the completer import. It's the differencce between it working and not
# working.
############################################################
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
############################################################
complete -C '/usr/local/bin/aws_completer' aws
#eval "$(op completion zsh)"; compdef _op op
#source <(kubectl completion zsh)
#source <(talosctl completion zsh)

# Add support for direnv
if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi
