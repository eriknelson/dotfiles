# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Reset PATH to keep it from being clobbered in tmux
#vf [ -x /usr/libexec/path_helper ]; then
  #PATH=''
  #source /etc/profile
#fi

export TERM=xterm-256color
export EDITOR=vim

export dev=$HOME/dev
export fusor=$dev/fusor
export emfus=$fusor/fusor-ember-cli
export vm_env=$dev/vm_env
export pluginDir="$HOME/.vim/bundle"
export dotfiles="$HOME/.dotfiles"
export ggdev="$HOME/git_devel/vm_env/git_devel_env_sat_6.1"
export ffdev="$HOME/git_devel/fusor"
export gdev="$HOME/git_devel"

export GOPATH=$HOME/dev/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

export SYSTEMD_PAGER=''

############################################################
# Config helper aliases
############################################################
alias editi="vim ~/.i3/config"
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
alias editn="nn ~/.config/nvim/init.vim"
alias loadp="source ~/.bashrc"
alias loadz="source ~/.zshrc"
alias loado="openbox --reconfigure"
alias fusorsync="git fetch --all && git merge upstream/master && git push origin"
alias vbomb="ssh -p 10022 nelsk@badcolt.ddns.net"
alias baldur="ssh -A -p 10022 -t nelsk@badcolt.ddns.net ssh -A -t nelsk@baldur"
alias sq="sequelize"
alias mygo="cd /home/nelsk/dev/go/src/github.com/eriknelson"
alias aa="cd /home/nelsk/aa/src/github.com/fusor/ansible-service-broker"
alias aatop="cd /home/nelsk/aa"
alias saa="pushd ~/dev/ansible-service-broker && source ./.gosrc && popd"
alias gotop="cd $GOPATH"
alias asb="cd $GOPATH/src/github.com/fusor/ansible-service-broker"
alias dothing="ansible-container build && ansible-container push --push-to docker.io/ansibleplaybookbundle --tag latest --username eriknelson && ansible-container shipit openshift --pull-from docker.io/ansibleplaybookbundle --tag latest"
alias dohalfthing="ansible-container build && ansible-container push --push-to docker.io/eriknelson --tag latest --username eriknelson"
alias daa='docker run -it -e "OPENSHIFT_TARGET=192.168.156.5:8443" -e "OPENSHIFT_USER=admin" -e "OPENSHIFT_PASS=admin"'
alias clustergo='export GOPATH=/home/nelsk/cluster && export GOBIN=$GOPATH/bin'

alias kk="$HOME/cluster/kubedemo/kubectl --kubeconfig=$HOME/cluster/kubedemo/kubeconfig.yaml"
alias perm-stage="sudo chmod a+r /var/lib/libvirt/images/catasb-stage1_default.img"

#alias cleanbrokercontainers=""
#alias cleanbrokerimages=""

clean_containers(){
  docker rm $(docker ps -a | grep $1 | awk '{print $1}')
}

clean_images(){
  docker rmi -f $(docker images | grep $1 | awk '{print $3}')
}

alias nn="nvim"

# Haste is a ruby-gem, need to exec with the correct context
alias haste="env HASTE_SERVER=http://hastebin.kotabit.zone rvm 2.2 exec \
  haste --raw"
alias hastec="HASTE_SERVER=http://hastebin.kotabit.zone haste --raw | xclipc"

alias chroano='env GTK_DATA_PREFIX="" chromium --user-data-dir=/home/nelsk/.chro/anolade'
alias chroarthas='env GTK_DATA_PREFIX="" chromium-browser --proxy-server=socks://localhost:1337 --user-data-dir=/home/nelsk/.chro/arthas'
alias chrobaldur='env GTK_DATA_PREFIX="" chromium --proxy-server=socks://localhost:1338 --user-data-dir=/home/nelsk/.chro/baldur'
alias chrolucha='env GTK_DATA_PREFIX="" chromium --user-data-dir=/home/nelsk/.chro/lucha'

############################################################
# Distro specific helper aliases
############################################################
alias paci="sudo pacman -S"
alias pacu="sudo pacman -Syyu"
alias pacr="sudo pacman -Rns"
alias apti="sudo apt-get install"
alias aptu="sudo apt-get upgrade && sudo apt-get upgrade"

############################################################
# Convenience aliases
############################################################
alias xclipc="xclip -selection clipboard"
alias xclipp="xclip -selection primary"
alias tmux="tmux -2"
alias mux="tmuxinator"
alias ww="w3m"
alias rr="rtv"

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
plugins=(git jsontools)

source $ZSH/oh-my-zsh.sh

alias less="less -R"
unset GREP_OPTIONS

############################################################
# Completion
############################################################

#source <(oc completion zsh)
#source <(kubectl completion zsh)

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

daemonize(){
  nohup $@ >/dev/null 2>&1 &
}

gs() {
  echo "Searching for $1"
  grep $1 . -r | less
}

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig

############################################################
# anonix settings
############################################################
if [[ ${DESKTOP_SESSION} = "i3" ]] && [[ "$(hostname)" = "anonix" ]]
then
  # Disable tap touch
  synclient MaxTapTime=0
fi

############################################################
# Work
############################################################
export VAGRANT_DEFAULT_PROVIDER=libvirt

[[ -s "$HOME/.nvm/nvm.sh" ]] && source ~/.nvm/nvm.sh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export PATH=$PATH:$HOME/.rvm.bin
export PATH=$PATH:$HOME/local/bin

#source $HOME/cluster/.dockerhub
#source $HOME/.keynote/aws

alias asb="cd $HOME/cluster/ansible-service-broker"
alias catasb="cd $HOME/cluster/catasb"
alias ss="cd $HOME/cluster/svcsbx"
alias resetetcd="sudo rm -rf /var/lib/etcd/* && sudo systemctl restart etcd"
alias m="make"
alias mr="make run"
export PATH=$PATH:${HOME}/cluster/bin
