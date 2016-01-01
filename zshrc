# Reset PATH to keep it from being clobbered in tmux
#if [ -x /usr/libexec/path_helper ]; then
  #PATH=''
  #source /etc/profile
#fi

export TERM=xterm-256color
export EDITOR=vim

export dev=$HOME/dev
export fusor=$dev/fusor
export pluginDir="$HOME/.vim/bundle"
export dotfiles="$HOME/.dotfiles"

############################################################
# Config helper aliases
############################################################
alias editi="vim ~/.i3/config"
alias editb="vim ~/.bashrc"
alias editbp="vim ~/.bash_profile"
alias editz="vim ~/.zshrc"
alias editze="vim ~/.zshenv"
alias edita="vim ~/.config/openbox/autostart"
alias edito="vim ~/.config/openbox/rc.xml"
alias editlo="vim ~/.config/openbox/lubuntu-rc.xml"
alias editx="vim ~/.xinitrc"
alias editxr="vim ~/.Xresources"
alias editv="vim ~/.vimrc"
alias loadp="source ~/.bashrc"
alias loadz="source ~/.zshrc"
alias loado="openbox --reconfigure"
alias vbomb="ssh -p 10022 nelsk@badcolt.ddns.net"
alias baldur="ssh -A -p 10022 -t nelsk@badcolt.ddns.net ssh -A -t nelsk@baldur"

############################################################
# Distro specific helper aliases
############################################################
alias paci="sudo pacman -S"
alias pacu="sudo pacman -Syyu"
alias pacr="sudo pacman -Rns"
alias apti="sudo apt-get install"
alias aptu="sudo apt-get upgrade && sudo apt-get upgrade"

############################################################
# Convenience aliases
############################################################
alias xclipc="xclip -selection clipboard"
alias xclipp="xclip -selection primary"
alias tmux="tmux -2"
alias mux="tmuxinator"

############################################################
# OH-MY-ZSH CONFIG
############################################################
export ZSH=$dotfiles/oh-my-zsh
COMPLETION_WAITING_DOTS="true"
ZSH_THEME="nelsk"

# NOTE: A little more conservative on this one. Caused each
# command on a Fedora box to ask if I wanted to install npm
# since it wasn't available in the path and it recognized it
# was available in a repo. Issue here is that we haven't
# yet sourced anything via nvm
#plugins=(git brew node npm jsontools)
plugins=(git jsontools)

source $ZSH/oh-my-zsh.sh

alias grep="grep $GREP_OPTIONS"
unset GREP_OPTIONS

# Gulp autocompletion
source $HOME/.dotfiles/gulp-autocompletion-zsh/gulp-autocompletion.zsh

############################################################
# PATH setup && version managers
############################################################

if [[ -z "$TMUX" ]]; then
  echo "Setting up PATH and initializing version managers..."
  export PATH=$HOME/local/bin:$PATH
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"

  source $HOME/.nvm/nvm.sh
  nvm use sys

  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
else
  echo "TMUX environment detected, skipping version manager sourcing..."
fi

############################################################
# Shell theme
############################################################
# Unset LS_COLORS if set on RPM systems to make way for custom colors
if [[ -n "${LS_COLORS}" ]]; then
  unset LS_COLORS
fi

BASE16_SHELL="$HOME/.dotfiles/base16-shell/base16-eighties.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

############################################################
# Custom funcs
############################################################
install_plugin(){
  # Script to install new vim plugins
  pushd $pluginDir
  git submodule add $1
  popd
}

push_dotfiles(){
  pushd $HOME/.dotfiles
  git add .
  git com -m "'$1'"
  git push
  popd
}

############################################################
# anonix settings
############################################################
if [[ ${DESKTOP_SESSION} = "i3" ]] && [[ "$(hostname)" = "anonix" ]]
then
  # Disable tap touch
  synclient MaxTapTime=0
fi

############################################################
# Work
############################################################
export VAGRANT_DEFAULT_PROVIDER=libvirt
#export VAGRANT_LOG=debug
