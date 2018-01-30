# Reset PATH to keep it from being clobbered in tmux
#vf [ -x /usr/libexec/path_helper ]; then
  #PATH=''
  #source /etc/profile
#fi

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
plugins=(jsontools)

source $ZSH/oh-my-zsh.sh

alias grep="grep $GREP_OPTIONS"
unset GREP_OPTIONS

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
if [[ -z "$NSK_GUAKE" ]]; then
  BASE16_SHELL="$HOME/.dotfiles/base16-shell/scripts/base16-eighties.sh"
  [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
else
  echo "Guake environment detected, skipping base16shell..."
fi

export TERM=xterm-256color
export EDITOR=vim

export PATH=$PATH:$HOME/local/bin

export dev=$HOME/dev
export fusor=$dev/fusor
export vm_env=$dev/vm_env
export pluginDir="$HOME/.vim/bundle"
export dotfiles="$HOME/.dotfiles"

export NO_DOCKER=1
export GOROOT=/usr/local/go
export PATH=$GOROOT/bin:$PATH
export GOPATH=/git
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

export GPG_TTY=$(tty)
export SYSTEMD_PAGER=''
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export VAGRANT_DEFAULT_PROVIDER=libvirt

############################################################
# Aliases
############################################################
alias editi="vim ~/.i3/config"
alias editb="vim ~/.bashrc"
alias editbp="vim ~/.bash_profile"
alias editz="vim ~/.zshrc"
alias editze="vim ~/.zshenv"
alias editv="vim ~/.vimrc"
alias loadz="source ~/.zshrc"
alias loadk="source $HOME/cluster/kubedemo/kk.source"
alias gitsync="git fetch --all && git merge upstream/master && git push origin"
alias gotop="cd $GOPATH"
alias keeptrying='while [ $? -ne 0 ] ; do sleep 2 && $(fc -ln -1) ; done'
alias s="ag"
alias com="git commit -S"
alias k="kubectl"
alias erikgo='cd $GOPATH/src/github.com/eriknelson'
alias uuid="uuidgen | tr -d - | tr -d '\n' | tr '[:upper:]' '[:lower:]'"
alias xclipc="xclip -selection clipboard"
alias xclipp="xclip -selection primary"
alias externalip="curl ipinfo.io/ip"

# Haste is a ruby-gem, need to exec with the correct context
alias haste="haste --raw"
alias hc="haste --raw | xclipc"
alias tmux="tmux -2"

alias asb="cd $GOPATH/src/github.com/openshift/ansible-service-broker"
alias catasb="cd $HOME/cluster/catasb"
#
# curl -k https://127.0.0.1:8443/apis/servicecatalog.k8s.io/v1alpha1

alias sc="cd $GOPATH/src/github.com/kubernetes-incubator/service-catalog"
alias bccat="REGISTRY=docker.io/eriknelson/ make images"

alias resetetcd="sudo rm -rf /var/lib/etcd/* && sudo systemctl restart etcd"
alias m="make"
alias mr="make run"
alias resetkc="export KUBECONFIG=$HOME/config"
alias fetch="git fetch --all"
alias com="git commit -S"
alias gg="cd /git"

############################################################
# kube local-cluster-up.sh
############################################################
#export KUBECONFIG=/var/run/kubernetes/admin.kubeconfig
#alias k="/home/ernelson/cluster/src/github.com/kubernetes/kubernetes/cluster/kubectl.sh"
alias gokube="cd $GOPATH/src/github.com/kubernetes/kubernetes"
############################################################

alias admin="oc login -u system:admin"
alias dev="oc login -u developer"

############################################################
# Distro helper aliases
############################################################
alias paci="sudo pacman -S"
alias pacu="sudo pacman -Syyu"
alias pacr="sudo pacman -Rns"
alias apti="sudo apt-get install"
alias aptu="sudo apt-get upgrade && sudo apt-get upgrade"

############################################################
# Custom funcs
############################################################
clean_containers(){
  docker rm $(docker ps -a | grep $1 | awk '{print $1}')
}

clean_images(){
  docker rmi -f $(docker images | grep $1 | awk '{print $3}')
}

bashc(){
  PS1="\u@\h " \
    PROMPT="" \
    bash
}

sudoi(){
  PS1="\[\e[31m\]\u\[\e[m\]@\h " \
    PROMPT="" \
    sudo -i
}

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

daemonize(){
  nohup $@ >/dev/null 2>&1 &
}

setminishiftreg() {
  MINISHIFT_IP=$(minishift ip)
  sudo sed -i "s|192.168.42.[0-9][0-9]*|${MINISHIFT_IP}|g" /etc/sysconfig/docker
  sudo systemctl restart docker
}

_script() {
echo '#!/bin/bash' >> $1
echo '_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"' >> $1
chmod +x $1

if [[ "$2" == "e" ]]; then
  vim $1
fi
} # /_script

export PATH=$PATH:${HOME}/cluster/bin

source <(kubectl completion zsh)
source <(oc completion zsh)

export PATH="$HOME/.bin-override:$PATH"

# NVM
[[ -s "$HOME/.nvm/nvm.sh" ]] && source ~/.nvm/nvm.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

