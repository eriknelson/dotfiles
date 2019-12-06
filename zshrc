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
if [[ "$(hostname)" == "baldur" ]]; then
  export GIT_EDITOR=vim
  export EDITOR=vim
  alias sudov="sudo vim"
else
  export GIT_EDITOR=vimx
  export EDITOR=vimx
  alias sudov="sudo vimx"
fi

export VAGRANT_DEFAULT_PROVIDER=libvirt
export GPG_TTY=$(tty)
export SYSTEMD_PAGER=''
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig

export NSK_GIT_DIR="/git"

# Go configuration
export GOROOT=/usr/local/go
export GOPATH=/git
export GOBIN=$GOPATH/bin
export AGNOSTICD_HOME=/git/mig/agnosticd

############################################################
# Aliases
############################################################
#alias docker=podman
alias tmux="tmux -2"
alias dirsize="du -sh"
alias sshrig="ssh -A nskd.usersys.redhat.com"
alias sshbaldur="ssh -A baldur"
#alias sshrig='mosh --ssh="ssh -A" nskd.usersys.redhat.com'
alias gg="cd $NSK_GIT_DIR"
alias inst="cd $GOPATH/src/github.com/openshift/installer"
alias gopath="cd $GOPATH"
alias sff="$NSK_GIT_DIR/stuff"

alias editi="vim ~/.i3/config"
alias editb="vim ~/.bashrc"
alias editbp="vim ~/.bash_profile"
alias editz="vim ~/.zshrc"
alias editze="vim ~/.zshenv"
alias editv="vim ~/.vimrc"
alias loadz="source ~/.zshrc"
alias gitsync="git fetch --all && git merge upstream/master && git push origin"
alias diffs="git diff --staged"
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
alias pull="git pull"
alias reset="git reset"
alias gd="git diff"
alias gds="git diff --staged"
alias add="git add"

# Mig related aliases
alias mig="cd $NSK_GIT_DIR/mig"
alias migd="cd $NSK_GIT_DIR/mig/mig-dev"
alias migci="cd $NSK_GIT_DIR/mig/mig-ci"
alias mm="cd $NSK_GIT_DIR/mig/mig-ui"
alias o3="cd /git/mig/origin3-dev"
alias migop="cd /git/mig/mig-operator"
alias migdown="cd /git/mig/downstream"
alias agd="cd /git/mig/mig-agnosticd"
alias cpma="cd $GOPATH/src/github.com/fusor/cpma"
alias migc="cd $GOPATH/src/github.com/fusor/mig-controller"

alias admin="oc login -u system:admin"
alias dev="oc login -u developer"

#alias localcluster='export KUBECONFIG=/home/ernelson/tmp/attempt1/auth/kubeconfig'
#alias bind_console='kubectl -n openshift-ingress port-forward svc/router-default 443'
alias files="io.elementary.files"

alias nskencrypt='gpg2 -e -r "Erik Nelson <erik@nsk.io>"'
alias nskdecrypt='gpg2'
############################################################
# Arch Linux Helpers
############################################################
alias paci="sudo pacman -S"
alias pacr="sudo pacman -Rs"
alias pacu="sudo pacman -Syyu"
alias pacs="pacman -Ss"
alias pacinstalled="pacman -Qe"
alias pacfiles="pacman -Ql"
alias pacinfo="pacman -Si"
alias aur="auracle"
############################################################
# Version Managers
############################################################
# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

############################################################
# PATH setup
############################################################
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/local/bin
export PATH=$PATH:$HOME/.local/bin
export PATH="$HOME/.bin-override:$PATH"
export PATH=$PATH:$GOROOT/bin:$GOBIN
export PATH=$PATH:~/.local/opt/postman/

############################################################
# Completion
############################################################
alias gencompletion="kubectl completion zsh > ~/.dotfiles/kubectl_completion.sh && oc completion zsh > ~/.dotfiles/oc_completion.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
source ~/.dotfiles/kubectl_completion.sh
source ~/.dotfiles/oc_completion.sh

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

clean_all_containers(){
  docker rm $(docker ps -a | awk '{print $1}')
}

clean_images(){
  docker rmi -f $(docker images | grep $1 | awk '{print $3}')
}

clean_all_images(){
  docker rmi -f $(docker images | awk '{print $3}')
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

############################################################
# OCP4 helpers
############################################################
export OCP_TEST_CLUSTER_DIR=/git/mig/ocp4-test-cluster
export OCP4_SEMVER='4.2.2'

function install_cluster_versioned(){
installer_version=$1
configdir=$OCP_TEST_CLUSTER_DIR/$installer_version
rundir=$configdir/run

echo "================================================================================"
echo "Installing cluster..."
echo "Installer Version: $installer_version"
echo "Config Dir: $configdir"
echo "Run Dir: $rundir"
echo "================================================================================"

mkdir -p $rundir
cp $configdir/install-config.yaml $rundir
openshift-install-$installer_version create cluster --dir $rundir --log-level debug
}

function destroy_cluster_versioned(){
installer_version=$1
configdir=$OCP_TEST_CLUSTER_DIR/$installer_version
rundir=$configdir/run

echo "================================================================================"
echo "Destroying cluster..."
echo "Installer Version: $installer_version"
echo "Config Dir: $configdir"
echo "Run Dir: $rundir"
echo "================================================================================"

openshift-install-$installer_version destroy cluster --dir $rundir --log-level debug
rm -rf $rundir
}

function bounce_cluster_versioned(){
installer_version=$1
echo "================================================================================"
echo "Bouncing cluster..."
echo "================================================================================"

destroy_cluster_versioned $installer_version
install_cluster_versioned $installer_version
}

alias install_cluster="install_cluster_versioned $OCP4_SEMVER"
alias destroy_cluster="destroy_cluster_versioned $OCP4_SEMVER"
alias bounce_cluster="bounce_cluster_versioned $OCP4_SEMVER"
alias kubeadminpass="cat $OCP_TEST_CLUSTER_DIR/$OCP4_SEMVER/run/auth/kubeadmin-password | xclipc"
