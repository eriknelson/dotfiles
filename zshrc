# Early init
export dotfiles="$HOME/.dotfiles"
command -v vimx >/dev/null 2>&1 && alias vim='vimx'

############################################################
# OH-MY-ZSH CONFIG
############################################################
export DISABLE_AUTO_UPDATE=true
export ZSH=$dotfiles/oh-my-zsh
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

# oh-my-zsh adds some extras here
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

############################################################
# Exports
############################################################
export TERM=xterm-256color
export GIT_EDITOR=vimx
export EDITOR=vimx
export VAGRANT_DEFAULT_PROVIDER=libvirt
export GPG_TTY=$(tty)
export SYSTEMD_PAGER=''
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig

export NSK_GIT_DIR="/git"

# Go configuration
export GOROOT=/usr/local/go
export GOPATH=/git
export GOBIN=$GOPATH/bin

############################################################
# Aliases
############################################################
alias tmux="tmux -2"
alias sshrig="ssh -A nskd.usersys.redhat.com"
#alias sshrig='mosh --ssh="ssh -A" nskd.usersys.redhat.com'
alias gg="cd $NSK_GIT_DIR"
alias inst="cd $GOPATH/src/github.com/openshift/installer"
alias gopath="cd $GOPATH"
alias sff="$NSK_GIT_DIR/stuff"
alias kubeadminpass="cat ~/tmp/eriknelson-dev/auth/kubeadmin-password | xclipc"

alias editi="vim ~/.i3/config"
alias editb="vim ~/.bashrc"
alias editbp="vim ~/.bash_profile"
alias editz="vim ~/.zshrc"
alias editze="vim ~/.zshenv"
alias editv="vim ~/.vimrc"
alias loadz="source ~/.zshrc"
alias gitsync="git fetch --all && git merge upstream/master && git push origin"
alias s="ag"
alias k="kubectl"
alias o="oc"
alias kp="kubectl get pods --all-namespaces"
alias kpw="kubectl get pods --all-namespaces -w"
alias uuid="uuidgen | tr -d - | tr -d '\n' | tr '[:upper:]' '[:lower:]'"
alias xclipc="xclip -selection clipboard"
alias xclipp="xclip -selection primary"
alias externalip="curl ipinfo.io/ip"
alias lt="ls -ltah"
alias resetetcd="sudo rm -rf /var/lib/etcd/* && sudo systemctl restart etcd"
alias m="make"
alias mr="make run"
alias mt="make test"
alias mb="make build"
alias resetkc="export KUBECONFIG=$HOME/config"

alias fetch="git fetch --all && git fetch --all --tags"
alias com="git commit -S"
alias amend="git commit -S --amend"
alias push="git push"
alias reset="git reset"
alias gd="git diff"
alias gds="git diff --staged"
alias add="git add"

# Mig related aliases
alias mig="cd $NSK_GIT_DIR/mig"
alias mm="cd $NSK_GIT_DIR/mig/mig-ui"
alias o3="cd /git/origin3-dev"

alias admin="oc login -u system:admin"
alias dev="oc login -u developer"

#alias awscluster='export KUBECONFIG=/home/ernelson/eriknelson-dev/run/auth/kubeconfig'
#alias localcluster='export KUBECONFIG=/home/ernelson/tmp/attempt1/auth/kubeconfig'
#alias bind_console='kubectl -n openshift-ingress port-forward svc/router-default 443'

############################################################
# Version Managers
############################################################
# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

############################################################
# PATH setup
############################################################
export PATH=$PATH:$HOME/local/bin
export PATH="$HOME/.bin-override:$PATH"
export PATH=$PATH:$GOROOT/bin:$GOBIN
export PATH=$PATH:~/.local/opt/postman/

# RVM is really particular about this being found in a certain place in the path
export PATH="$PATH:$HOME/.rvm/bin"

############################################################
# Completion
############################################################
alias gencompletion="k completion zsh > ~/.dotfiles/kubectl_completion.sh && oc completion zsh > ~/.dotfiles/oc_completion.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
#source ~/.dotfiles/kubectl_completion.sh
#source ~/.dotfiles/oc_completion.sh

############################################################
# Load local env vars
############################################################
[[ -f $HOME/.localvar ]] && source $HOME/.localvar

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

daemonize(){
  nohup $@ >/dev/null 2>&1 &
}

_script() {
echo '#!/bin/bash' >> $1
echo '_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"' >> $1
chmod +x $1

if [[ "$2" == "e" ]]; then
  vim $1
fi
} # /_script

function install_cluster(){
mkdir -p $HOME/eriknelson-dev/run
cp $HOME/eriknelson-dev/install-config.yaml $HOME/eriknelson-dev/run
openshift-install-0.11.0 create cluster --dir $HOME/eriknelson-dev/run --log-level debug
}

function destroy_cluster(){
openshift-install-0.11.0 destroy cluster --dir $HOME/eriknelson-dev/run --log-level debug
rm -rf $HOME/eriknelson-dev/run
}

function bounce_cluster_aws(){
destroy_cluster
install_cluster
}
