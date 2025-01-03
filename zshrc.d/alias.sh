if [[ -f ~/.zshmac ]]; then
  export SYNC_ROOT="$HOME/Documents"
  export SYNC_DOCS="$SYNC_ROOT"
  alias xclipc="pbcopy"
  #alias docker="DOCKER_HOST=tcp://baldur.lan.nsk.io:2375 docker"
else
  export SYNC_ROOT="$HOME/Sync"
  export SYNC_DOCS="$HOME/Documents"
fi

export SYNC_WORK="$SYNC_DOCS/work/ammo"
export AMMOSQ_WORK="~/documents/work/ammosquared"

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
alias tf="tofu"
alias rr="https --follow"
alias pd="podman"
alias fw='sudo firewall-cmd'
alias fwp='sudo firewall-cmd --permanent'
alias tmux="tmux -2"
alias dirsize="du -sh"
alias riftup="wg-quick up wg0-rift"
alias riftdown="wg-quick down wg0-rift"
alias sshrig="ssh -A nskd.usersys.redhat.com"
alias sshb="ssh -A ernelson@baldur.machine.kotawerks.gg"
alias moshb='mosh --ssh="ssh -A" baldur'
alias ssha="ssh -A tundra"
alias ig="grep -i"
alias ifi="find . -iname"
alias loadz="source ~/.zshrc"
alias youtube-dl='yt-dlp'
alias s="ag"
alias si="ag -i"
alias k="kubectl"
alias kv="kubevpn"
alias tt="talosctl"
alias cc="clusterctl"
alias kx="kubectx"
alias kz="kustomize"
alias kn="kubens"
alias j="jira"
alias mk="minikube"
alias ic="istioctl"
alias rl='rails'

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
alias lll="ls -ltah | less"
alias lv="ls -ltah | vim -"
alias m="make"
alias mr="make run"
alias mt="make test"
alias mb="make build"
alias threedisplay="$HOME/.screenlayout/three-display.sh"
alias watchicsp="watch 'oc describe node -l node-role.kubernetes.io/worker= | grep -e Name: -e rendered'"
alias dumpcors="oc get -n openshift-migration route/migration -o go-template='(?i)//{{ .spec.host }}(:|\z){{ println }}' | sed 's,\.,\\.,g'"
alias jj="jekyll"
alias nskencrypt='gpg -e -r "8B44245824D8272AFAA80B02EDABD990AA12348B"'
alias nskdecrypt='gpg'
alias bbencrypt='gpg -e -r "7862C91E2E5AC311AC8C85675C3E724937994ED3"'
alias nskdecrypt='gpg'
alias tl="trello"
alias ttd="todoist"
alias td="todoist q"
alias tlc="trello add-card -b Swiftline -q top -l Todo"
alias httpsrv="python -m http.server 8000"
alias mediapull='yt-dlp --external-downloader aria2c --external-downloader-args "aria2c:-x 16 -k 1M"'
alias mediapullthrottled='yt-dlp --sleep-requests 1.5 --min-sleep-interval 60 --max-sleep-interval 90'

# git cmd, NOTE: a bunch of aliases are brought in via OMZSH
alias g="git"
alias lg="lazygit"
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
alias cdw="cd $AMMOSQ_WORK"
alias cddocs="cd $NSK_GIT_DIR/docs.nsk.io"
alias fum="cd $NSK_GIT_DIR/fumar"
alias blog="cd $NSK_GIT_DIR/blog.nsk.io"

# Edit shortcuts
alias edita="vim ~/.aerospace.toml"
alias editi="vim ~/.i3/config"
alias editk="vim ~/.config/kitty/kitty.conf"
alias editb="vim ~/.bashrc"
alias editbp="vim ~/.bash_profile"
alias editz="vim ~/.zshrc"
alias editze="vim ~/.zshenv"
alias editv="vim ~/.vimrc"
alias editt="vim $AMMOSQ_WORK/todo.txt"
alias edits="vim ~/Documents/standup/log.txt"
alias editpt="vim $AMMOSQ_WORK/ptodo.txt"

alias kb="cd ~/kb"
[[ "$(hostname)" == *"aurelian"* ]] && alias kb="cd $NSK_GIT_DIR/kb"

# Kubernetes
alias kbash="kubectl run erik-shell -shell --rm -i --tty --image bash -- bash"

# Database Alias
alias pgadmin="PGPASSWORD=$ADMIN_DB_PASSWD pgcli --no-password -h db.lb.legion.kotawerks.gg -u postgres"
alias pgak="PGPASSWORD=$AUTHENTIK_DB_PASSWD pgcli --no-password -h db.lb.legion.kotawerks.gg -u authentik -d authentik"
alias pgsbx="PGPASSWORD=$RAILS_SBX_DB_PASSWD pgcli --no-password -h db.lb.legion.kotawerks.gg -u rails_sbx -d rails_sbx"
alias pgammol="PGPASSWORD=$AMMO_DEV_DB_PASSWD pgcli --no-password -h localhost -u $AMMO_DEV_DB_USER -d $AMMO_DEV_DB_NAME"
alias pgammo="PGPASSWORD=$AMMO_LEGION_DB_PASSWD pgcli --no-password -h db.lb.legion.kotawerks.gg -u $AMMO_LEGION_DB_USER -d ammosq"

# AmmoSquared Helpers
alias rcl='redis-cli -h localhost -p 7379'
alias testlog='ls -1t /tmp/ammo* | head -n 1 | xargs -I{} nvim {}'
alias watchlog='ls -1t /tmp/ammo* | head -n 1 | xargs -I{} tail -f {}'
alias clearlog='rm -rf /tmp/ammo*'
alias amm="cd $NSK_GIT_DIR/ammosquared/web-platform"
alias kamm="cd $NSK_GIT_DIR/ammosquared/kammo"
alias kammw="cd $NSK_GIT_DIR/ammosquared/kammo-workloads"

# Development helpers
alias _activate="source ./.venv/bin/activate"
