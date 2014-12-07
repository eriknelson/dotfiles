# Reset PATH to keep it from being clobbered in tmux
if [ -x /usr/libexec/path_helper ]; then
    PATH=''
    source /etc/profile
fi

export PATH=/usr/local/bin:$PATH
export dev=$HOME/dev
export bpweb=$HOME/dev/bobbypin-web/placemark
export bpsites=$bpweb/sites
export bpapi=$bpweb/web
export bpios=$HOME/dev/Bobbypin
export sbweb=$dev/strayboots/strayboots/web
export tas=$dev/taswell.io
export pluginDir="$HOME/.vim/bundle"
export dotfiles="$HOME/dev/dotfiles"

alias edita="vim ~/.config/openbox/autostart"
alias edito="vim ~/.config/openbox/rc.xml"
alias editp="vim ~/.bashrc"
alias editz="vim ~/.zshrc"
alias editze="vim ~/.zshenv"
alias editv="vim ~/.vimrc"
alias loadp="source ~/.bashrc"
alias loadz="source ~/.zshrc"
alias paci="sudo pacman -S"
alias upgrade="sudo pacman -Syyu"
#alias ls="ls -G"
alias ll="ls -lta"
alias git_submodule_rm="$dotfiles/scripts/git_submodule_rm.sh"

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
<<<<<<< HEAD
export ZSH=$HOME/dev/dotfiles/oh-my-zsh
=======
export ZSH=$dotfiles/oh-my-zsh
>>>>>>> linux

ZSH_THEME="nelsk"

COMPLETION_WAITING_DOTS="true"

# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew node npm jsontools)

source $ZSH/oh-my-zsh.sh
