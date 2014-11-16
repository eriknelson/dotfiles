# Reset PATH to keep it from being clobbered in tmux
if [ -x /usr/libexec/path_helper ]; then
    PATH=''
    source /etc/profile
fi

alias editp="vim ~/.bash_profile"
alias editv="vim ~/.vimrc"
alias loadp="source ~/.bash_profile"
alias ls="ls -G"
alias ll="ls -ltaGFlash"

export PATH=/usr/local/bin:$PATH
export dev=$HOME/dev
export bpweb=$HOME/dev/bobbypin-web/placemark
export bpsites=$bpweb/sites
export bpapi=$bpweb/web
export bpios=$HOME/dev/Bobbypin
export sbweb=$dev/strayboots/strayboots/web

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
eval "$(pyenv virtualenv-init -)"
EDITOR=vim

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
