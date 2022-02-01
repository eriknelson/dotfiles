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
export dotfiles="$HOME/.dotfiles"

alias editp="vim ~/.bashrc"
alias editv="vim ~/.vimrc"
alias loadp="source ~/.bashrc"
alias ls="ls -G"
alias ll="ls -ltaGFlash"
alias git_submodule_rm="$dotfiles/scripts/git_submodule_rm.sh"

EDITOR=vim

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
