# Reset PATH to keep it from being clobbered in tmux
if [ -x /usr/libexec/path_helper ]; then
  PATH=''
  source /etc/profile
fi

export PATH=/usr/local/bin:$PATH:$HOME/bin
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

# Rust
#export RUST_ROOT=$HOME/dev/rust/rust
#export RUST_SRC_PATH="$RUST_ROOT/src"
export RUST_INSTALL_PREFIX="$HOME/apps/rust"
alias rustc="DYLD_LIBRARY_PATH=$RUST_INSTALL_PREFIX/lib $RUST_INSTALL_PREFIX/bin/rustc"
alias cargo="DYLD_LIBRARY_PATH=$RUST_INSTALL_PREFIX/lib $RUST_INSTALL_PREFIX/bin/cargo"

alias edita="vim ~/.config/openbox/autostart"
alias edito="vim ~/.config/openbox/rc.xml"
alias editp="vim ~/.bashrc"
alias editz="vim ~/.zshrc"
alias editze="vim ~/.zshenv"
alias editx="vim ~/.xinitrc"
alias editv="vim ~/.vimrc"
alias loadp="source ~/.bashrc"
alias loadz="source ~/.zshrc"
alias loado="openbox --reconfigure"
alias paci="sudo pacman -S"
alias upgrade="sudo pacman -Syyu"
alias c="xclip -selection clipboard"
#alias ls="ls -G"
alias git_submodule_rm="$dotfiles/scripts/git_submodule_rm.sh"
alias sshvb="ssh vistablack@vista.black"

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

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
