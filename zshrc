# Reset PATH to keep it from being clobbered in tmux
#if [ -x /usr/libexec/path_helper ]; then
  #PATH=''
  #source /etc/profile
#fi

export TERM=xterm-256color
export EDITOR=vim

export dev=$HOME/dev
export pluginDir="$HOME/.vim/bundle"
export dotfiles="$HOME/.dotfiles"

############################################################
# Config helper aliases
############################################################
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

############################################################
# Distro specific helper aliases
############################################################
alias paci="sudo pacman -S"
alias pacu="sudo pacman -Syyu"
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
plugins=(git brew node npm jsontools)
source $ZSH/oh-my-zsh.sh

#unset GREP_OPTIONS
#alias grep="grep $GREP_OPTIONS"

# Gulp autocompletion
source $HOME/.dotfiles/gulp-autocompletion-zsh/gulp-autocompletion.zsh

############################################################
# PATH setup && version managers
############################################################

if ! [[ -n "$TMUX" ]]; then
  echo "Setting up PATH and initializing version managers..."
  export PATH=$HOME/local/bin:$PATH
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"

  source $HOME/.nvm/nvm.sh

  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
else
  echo "TMUX environment detected, skipping version manager sourcing..."
fi

############################################################
# Shell theme
############################################################
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
