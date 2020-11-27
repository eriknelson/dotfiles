# Early init
dotfiles="$HOME/.dotfiles"

command -v vimx >/dev/null 2>&1
if [[ $? -eq 0 ]]; then
  export EDITOR=vimx
  alias vim='vimx'
  alias sudov='sudo vimx'
else
  export EDITOR=vim
  alias sudov='sudo vim'
fi

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
#alias grep="grep $GREP_OPTIONS"
#unset GREP_OPTIONS

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
BASE16_SHELL="$HOME/.dotfiles/base16-shell/scripts/base16-eighties.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

############################################################
# Exports
############################################################

export VAGRANT_DEFAULT_PROVIDER=libvirt
export GPG_TTY=$(tty)
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export AGNOSTICD_HOME=/git/mig/agnosticd
export NSK_GIT_DIR="/git"

# Go configuration
export GOPATH=/git
export GOBIN=$GOPATH/bin
if [[ "$(hostname)" == "baldur" ]]; then
  export GOROOT=/usr/lib/go
else
  export GOROOT=/usr/local/go
fi

############################################################
# Aliases
############################################################
alias legion="cd $NSK_GIT_DIR/legion"
alias fw='sudo firewall-cmd'
alias fwp='sudo firewall-cmd --permanent'
alias tmux="tmux -2"
alias dirsize="du -sh"
alias riftup="wg-quick up wg0-rift"
alias riftdown="wg-quick down wg0-rift"
alias sshrig="ssh -A nskd.usersys.redhat.com"
alias sshb="ssh -A baldur"
alias ssha="ssh -A tundra"
alias gg="cd $NSK_GIT_DIR"
alias gopath="cd $GOPATH"
alias sff="$NSK_GIT_DIR/stuff"
alias dotfiles="cd $dotfiles"

alias editi="vim ~/.i3/config"
alias editb="vim ~/.bashrc"
alias editbp="vim ~/.bash_profile"
alias editz="vim ~/.zshrc"
alias editze="vim ~/.zshenv"
alias editv="vim ~/.vimrc"
alias editt="vim ~/SparkleShare/onyx-pi.lan.nsk.io/sync.nsk.io/todo.txt"
alias editpt="vim ~/SparkleShare/onyx-pi.lan.nsk.io/sync.nsk.io/ptodo.txt"

alias loadz="source ~/.zshrc"
alias s="ag"
alias k="kubectl"
alias kc="kubectx"
alias kn="kubens"
alias ic="istioctl"
alias kb="kubebuilder"
alias osdk="operator-sdk"
alias g="git"
alias lg="lazygit"
alias o="oc"
alias ipb="ip -br -color"
alias ap="ansible-playbook"
alias kp="kubectl get pods --all-namespaces"
alias kpw="watch 'kubectl get pods --all-namespaces'"
alias uuid="uuidgen | tr -d - | tr -d '\n' | tr '[:upper:]' '[:lower:]'"
alias xclipc="xclip -selection clipboard"
alias xclipp="xclip -selection primary"
alias externalip="curl ipinfo.io/ip"
alias lt="ls -ltah"
alias m="make"
alias mr="make run"
alias mt="make test"
alias mb="make build"
alias resetkc="export KUBECONFIG=$HOME/config"
alias dol="dolphin"
alias threedisplay="$HOME/.screenlayout/three-display.sh"

alias fetch="git fetch --all && git fetch --all --tags"
alias gitsync="git fetch --all && git merge upstream/master && git push origin"
alias com="git commit -S"
alias amend="git commit -S --amend"
alias push="git push"
alias pull="git pull"
alias reset="git reset"
alias gd="git diff"
alias gds="git diff --staged"
alias add="git add"

# Mig related aliases
alias dumpcors="oc get -n openshift-migration route/migration -o go-template='(?i)//{{ .spec.host }}(:|\z){{ println }}' | sed 's,\.,\\.,g'"
alias mig="cd $NSK_GIT_DIR/mig"
alias migd="cd $NSK_GIT_DIR/mig/mig-dev"
alias migci="cd $NSK_GIT_DIR/mig/mig-ci"
alias migen="cd $NSK_GIT_DIR/mig/konveyor-enhancements"
alias mm="cd $NSK_GIT_DIR/mig/mig-ui"
alias kgi="cd $NSK_GIT_DIR/konveyor.github.io"
alias ww="cd $NSK_GIT_DIR/wadsworth"
alias o3="cd /git/mig/origin3-dev"
alias migop="cd /git/mig/mig-operator"
alias migbp="cd /git/mig/openshift-migration-best-practices"
alias migdown="cd /git/mig/downstream"
alias agd="cd /git/mig/mig-agnosticd"
alias cpma="cd $GOPATH/src/github.com/konveyor/cpma"
alias migc="cd $GOPATH/src/github.com/konveyor/mig-controller"
alias blogs="/git/mig/rh-blogs"
alias sps="cd $HOME/SparkleShare/onyx-pi.lan.nsk.io/sync.nsk.io"
alias jj="jekyll"
alias blog="cd $NSK_GIT_DIR/kcac.nsk.io"
alias nskencrypt='gpg2 -e -r "Erik Nelson <erik@nsk.io>"'
alias nskdecrypt='gpg2'

############################################################
# Arch Linux Helpers
############################################################
alias paci="sudo pacmatic -S"
alias pacr="sudo pacmatic -Rns"
alias pacu="sudo pacmatic -Syyu"
alias pacs="pacmatic -Ss"
alias pacinstalled="pacmatic -Qe"
alias pacwhy="pacman -Qi"
alias pacfiles="pacmatic -Ql"
alias pacinfo="pacmatic -Si"
alias aur="auracle"

############################################################
# PATH setup
############################################################
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/local/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$GOROOT/bin:$GOBIN
export PATH="$PATH:/var/lib/flatpak/exports/bin"

############################################################
# Completion
############################################################
alias gencompletion="kubectl completion zsh > ~/.dotfiles/kubectl_completion.sh && oc completion zsh > ~/.dotfiles/oc_completion.sh"
alias ocompl="source ~/.dotfiles/oc_completion.sh"
alias kcompl="source ~/.dotfiles/kubectl_completion.sh"

############################################################
# Load local env vars
############################################################
[[ -f $HOME/.localvar ]] && source $HOME/.localvar

############################################################
# Version Managers
############################################################
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

############################################################
# Custom funcs
############################################################
reset_iptables() {
  sudo iptables -P INPUT ACCEPT
  sudo iptables -P FORWARD ACCEPT
  sudo iptables -P OUTPUT ACCEPT
  sudo iptables -t nat -F
  sudo iptables -t mangle -F
  sudo iptables -F
  sudo iptables -X
}

setup_good_docker() {
  clean_all_images
  sudo systemctl stop firewalld
  reset_iptables
  sudo systemctl restart docker
}

setup_desired_docker() {
  clean_all_images
  reset_iptables
  sudo systemctl start firewalld
  sudo systemctl restart docker
}

dump_all_iptables() {
  tables=(
    filter
    nat
    mangle
    raw
    security
  )
  for table in "${tables[@]}"; do
    sudo iptables --line-numbers -L -t $table
  done
}

dump_all_nftables() {
  tables=(
    inet
    ip
  )
  for table in "${tables[@]}"; do
    sudo nft list ruleset $table
  done
}

capture_good_docker() {
  setup_good_docker
  cd ~/tundra/fw-testing
  dump_all_iptables > ipt_before.txt
  dump_all_nftables > nft_before.txt
}

capture_desired_docker() {
  setup_desired_docker
  cd ~/tundra/fw-testing
  dump_all_iptables > ipt_after.txt
  dump_all_nftables > nft_after.txt
}

clean_nsk_secrets() {
  oc get secrets -n openshift-config | grep nsk | awk '{print $1}' | xargs -I{} oc delete secret -n openshift-config {}
}

clean_token_secrets() {
  oc get secrets -n openshift-config | grep nsktoken | awk '{print $1}' | xargs -I{} oc delete secret -n openshift-config {}
}

clean_mig_cluster_scoped() {
  oc get crds | grep 'migration.openshift.io' | awk '{print $1}' | xargs -I{} oc delete crd {}
  oc get crds | grep velero | awk '{print $1}' | xargs -I{} oc delete crd {}
  oc get clusterroles | grep 'migration.openshift.io' | awk '{print $1}' | xargs -I{} oc delete clusterrole {}
  oc get clusterroles | grep velero | awk '{print $1}' | xargs -I{} oc delete clusterrole {}
  oc get clusterrolebindings | grep 'migration.openshift.io' | awk '{print $1}' | xargs -I{} oc delete clusterrolebindings {}
  oc get clusterrolebindings | grep velero | awk '{print $1}' | xargs -I{} oc delete clusterrolebindings {}
}

force_destroy_namespace() {
NAMESPACE=$1
oc proxy &
oc get namespace $NAMESPACE -o json |jq '.spec = {"finalizers":[]}' >temp.json
curl -k -H "Content-Type: application/json" -X PUT --data-binary @temp.json 127.0.0.1:8001/api/v1/namespaces/$NAMESPACE/finalize
kill $(ps aux | grep "[oc] proxy" | awk '{print $2}')
}

# NOTE: Really useful when debugging something stuck in terminating
dump_all_resources_in_namespace() {
NAMESPACE=$1
if [[ "$NAMESPACE" == "" ]]; then
  echo "ERROR: Must pass namespace as arg"
else
  kubectl api-resources --verbs=list --namespaced -o name | grep -iv event | xargs -n 1 kubectl get --show-kind --ignore-not-found -n $NAMESPACE
fi
}

build_mig_ui() {
  mig_ui_label=$1
  if [[ "$mig_ui_label" == "" ]]; then
    echo "ERROR: Need to pass mig-ui image label as a first argument, exiting.."
    return 1
  fi

  docker build -f ./Dockerfile -t quay.io/eriknelson/mig-ui:$1 . && docker push quay.io/eriknelson/mig-ui:$1
}

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

sudoi(){
  PS1="\[\e[31m\]\u\[\e[m\]@\h " \
    PROMPT="" \
    sudo -i
}

_script() {
echo '#!/bin/bash' >> $1
echo '_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"' >> $1
chmod +x $1

if [[ "$2" == "e" ]]; then
  vim $1
fi
} # /_script

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
