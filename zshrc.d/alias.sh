if [[ -f ~/.zshmac ]]; then
  export SYNC_ROOT="$HOME/Documents"
  export SYNC_DOCS="$SYNC_ROOT"
  alias xclipc="pbcopy"
  #alias docker="DOCKER_HOST=tcp://baldur.lan.nsk.io:2375 docker"
else
  export SYNC_ROOT="$HOME/Sync"
  export SYNC_DOCS="$HOME/Documents"
fi

export SYNC_WORK="$SYNC_DOCS/work"

# Filesystem
alias legion="cd $NSK_GIT_DIR/legion"

# Cmd
# completion
alias gencompletion="kubectl completion zsh > $DOTFILES_DIR/kubectl_completion.sh"
#alias ocompl="source $DOTFILES_DIR/oc_completion.sh"
alias kcompl="source $DOTFILES_DIR/kubectl_completion.sh"

#alias podman="docker"
alias memes='cd ~/tundra/images/Meemees'
alias vim=nvim
alias di=doit
alias bt=bluetoothctl
alias dkc="docker-compose"
alias dk="docker"
alias tf="terraform"
alias rr="https --follow"
alias pd="podman"
alias fw='sudo firewall-cmd'
alias fwp='sudo firewall-cmd --permanent'
alias tmux="tmux -2"
alias dirsize="du -sh"
alias riftup="wg-quick up wg0-rift"
alias riftdown="wg-quick down wg0-rift"
alias sshrig="ssh -A nskd.usersys.redhat.com"
alias sshb="ssh -A ernelson@baldur"
alias moshb='mosh --ssh="ssh -A" baldur'
alias ssha="ssh -A tundra"
alias ig="grep -i"
alias ifi="find . -iname"
alias loadz="source ~/.zshrc"
alias youtube-dl='yt-dlp'
alias s="ag"
alias si="ag -i"
alias k="kubectl"
alias tt="talosctl"
alias cc="clusterctl"
alias kx="kubectx"
alias kz="kustomize"
alias kn="kubens"
alias j="jira"
alias mk="minikube"
alias ic="istioctl"

alias osdk="operator-sdk"
alias o="oc"
alias ipb="ip -br -color"
alias ap="ansible-playbook"
alias agl="ansible-galaxy"
alias av="ansible-vault"
alias kp="kubectl get pods --all-namespaces"
alias kpw="watch 'kubectl get pods --all-namespaces'"
alias uuid="uuidgen | tr -d - | tr -d '\n' | tr '[:upper:]' '[:lower:]'"
alias externalip="curl ipinfo.io/ip"
alias lt="ls -ltah"
alias m="make"
alias mr="make run"
alias mt="make test"
alias mb="make build"
alias threedisplay="$HOME/.screenlayout/three-display.sh"
alias watchicsp="watch 'oc describe node -l node-role.kubernetes.io/worker= | grep -e Name: -e rendered'"
alias dumpcors="oc get -n openshift-migration route/migration -o go-template='(?i)//{{ .spec.host }}(:|\z){{ println }}' | sed 's,\.,\\.,g'"
alias jj="jekyll"
alias nskencrypt='gpg2 -e -r "Erik Nelson <erik@nsk.io>"'
alias nskdecrypt='gpg2'
alias tl="trello"
alias ttd="todoist"
alias td="todoist q"
alias tlc="trello add-card -b Swiftline -q top -l Todo"
alias httpsrv="python -m http.server 8000"

# git cmd, NOTE: a bunch of aliases are brought in via OMZSH
alias g="git"
alias lg="lazygit"
alias fetch="git fetch --all && git fetch --all --tags"
alias gitsync="git fetch --all && git merge upstream/master && git push origin"
#alias com="git commit -S"
alias com="git commit"
#alias amend="git commit -S --amend"
alias amend="git commit --amend"
alias push="git push"
alias pull="git pull"
alias reset="git reset"
alias gd="git diff"
alias gds="git diff --staged"
alias add="git add"
alias goa='git log --pretty=format:"%h%x09%an%x09%ad%x09%s"'

# Arch cmd
alias paci="sudo pacman -S"
alias pacr="sudo pacman -Rns"
alias pacu="sudo pacman -Syyu"
alias pacs="pacman -Ss"
alias pacinstalledexplicit="pacman -Qe"
alias pacinstalled="pacman -Q"
alias pacwhy="pacman -Qi"
alias pacrevdep="pacman -Qii"
alias pacfiles="pacman -Ql"
alias pacinfo="pacman -Si"
alias aur="auracle"

# Filesystem jumps
alias gg="cd $NSK_GIT_DIR"
alias gopath="cd $GOPATH"
alias dotfiles="cd $DOTFILES_DIR"
alias sff="cd $NSK_GIT_DIR/stuff"
alias cdr="cd $SYNC_ROOT"
alias cdd="cd $HOME/Documents"
alias cdw="cd $SYNC_WORK"
alias cddocs="cd $NSK_GIT_DIR/docs.nsk.io"
alias fum="cd $NSK_GIT_DIR/fumar"
alias blog="cd $NSK_GIT_DIR/blog.nsk.io"

# mig filesystem jumps
alias ww="cd $NSK_GIT_DIR/wadsworth"
alias sld="cd $NSK_GIT_DIR/swiftline-dev"

# Edit shortcuts
alias edita="vim ~/.aerospace.toml"
alias editi="vim ~/.i3/config"
alias editk="vim ~/.config/kitty/kitty.conf"
alias editb="vim ~/.bashrc"
alias editbp="vim ~/.bash_profile"
alias editz="vim ~/.zshrc"
alias editze="vim ~/.zshenv"
alias editv="vim ~/.vimrc"
alias editt="vim $SYNC_WORK/todo.txt"
alias edits="vim $SYNC_WORK/personal-standup.txt"
alias editpt="vim $SYNC_DOCS/ptodo.txt"

alias kb="cd ~/kb"

# Kubernetes
alias kbash="kubectl run erik-shell -shell --rm -i --tty --image bash -- bash"

function kexec() {
  kubectl exec --stdin --tty $1 -- bash
}

function activate_sdm_ssh() {
  alias ssh="/usr/local/bin/sdm ssh wrapped-run"
  alias scp="scp -S'/usr/local/bin/sdm' -osdmSCP"
}

function deactivate_sdm_ssh() {
  unalias ssh
  unalias scp
}

################################################################################
# Oscar Overrides
################################################################################
# Just affects the host laptop workstation
if [[ "$(hostname)" == *"aurelian"* ]]; then
  alias doscar="cd $NSK_GIT_DIR/doscar"
fi

# Just affects the doscar container
if [[ "$(hostname)" == "doscar" ]]; then
  unalias vim
fi

# Affects both environments
if [[ "$(hostname)" == *"aurelian"* ]]; then
  alias doscar="cd $NSK_GIT_DIR/doscar"
fi
