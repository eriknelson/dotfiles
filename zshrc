# Reset PATH to keep it from being clobbered in tmux
if [ -x /usr/libexec/path_helper ]; then
  PATH=''
  source /etc/profile
fi

export PATH=/usr/local/bin:$PATH:$HOME/local/bin
export dev=$HOME/dev
export bpweb=$HOME/dev/bobbypin-web/bobbypin
export bpsites=$bpweb/sites
export bpapi=$bpweb/sites/api
export bpios=$HOME/dev/Bobbypin
export sbweb=$dev/strayboots/strayboots/web
export tas=$dev/taswell.io
export vista=$dev/vista.black
export pluginDir="$HOME/.vim/bundle"
export dotfiles="$HOME/.dotfiles"
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/lib"
export TERM=xterm-256color

# Rust
#export RUST_ROOT=$HOME/dev/rust/rust
#export RUST_SRC_PATH="$RUST_ROOT/src"
#export RUST_INSTALL_PREFIX="$HOME/apps/rust"

alias startx="ssh-agent startx"
alias edita="vim ~/.config/openbox/autostart"
alias edito="vim ~/.config/openbox/rc.xml"
alias editlo="vim ~/.config/openbox/lubuntu-rc.xml"
alias editp="vim ~/.bashrc"
alias editz="vim ~/.zshrc"
alias editze="vim ~/.zshenv"
alias editx="vim ~/.xinitrc"
alias editxr="vim ~/.Xresources"
alias editv="vim ~/.vimrc"
alias loadp="source ~/.bashrc"
alias loadz="source ~/.zshrc"
alias loado="openbox --reconfigure"
alias paci="sudo pacman -S"
alias pacu="sudo pacman -Syyu"
alias upgrade="sudo pacman -Syyu"
alias xclipc="xclip -selection clipboard"
alias xclipp="xclip -selection primary"
#alias ls="ls -G"
alias git_submodule_rm="$dotfiles/scripts/git_submodule_rm.sh"
alias sshvb="ssh vistablack@vista.black"
alias tmux="tmux -2"
alias mux="tmuxinator"
alias em="pump sudo emerge -av"

EDITOR=vim

# Some custom functions
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
# PLATFORM SPECIFIC CONFIG
############################################################
if [[ "$(uname)" == "Darwin" ]]; then
  echo "Running Darwin"
  #alias rustc="DYLD_LIBRARY_PATH=$RUST_INSTALL_PREFIX/lib:$DYLD_LIBRARY_PATH $RUST_INSTALL_PREFIX/bin/rustc"
  #alias cargo="DYLD_LIBRARY_PATH=$RUST_INSTALL_PREFIX/lib:$DYLD_LIBRARY_PATH $RUST_INSTALL_PREFIX/bin/cargo"
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
  echo "Running Linux"
  export NELSON_LOCAL_LIB="$HOME/local/lib"
  export NELSON_LOCAL_INCLUDE="$HOME/local/include"
  #export LDFLAGS="-L $NELSON_LOCAL_LIB"
  #export CFLAGS="-I$NELSON_LOCAL_INCLUDE"
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:$NELSON_LOCAL_LIB
  #alias rustc="LD_LIBRARY_PATH=$RUST_INSTALL_PREFIX/lib:$LD_LIBRARY_PATH $RUST_INSTALL_PREFIX/bin/rustc"
  #alias cargo="LD_LIBRARY_PATH=$RUST_INSTALL_PREFIX/lib:$LD_LIBRARY_PATH $RUST_INSTALL_PREFIX/bin/cargo"
fi

############################################################
# OH-MY-ZSH CONFIG
############################################################

# Path to your oh-my-zsh installation.
export ZSH=$dotfiles/oh-my-zsh

ZSH_THEME="nelsk"

COMPLETION_WAITING_DOTS="true"

# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew node npm jsontools)

source $ZSH/oh-my-zsh.sh

alias grep="grep $GREP_OPTIONS"
unset GREP_OPTIONS

#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

# Base16 Shell
BASE16_SHELL="$HOME/.dotfiles/base16-shell/base16-eighties.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Gulp autocompletion
source $HOME/.dotfiles/gulp-autocompletion-zsh/gulp-autocompletion.zsh
