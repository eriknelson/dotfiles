echo "========================================"
echo "NSK Doscar Hook"
echo "========================================"

gitconfigFile=~/.gitconfig
nvimConfigDir=~/.config/nvim
nvimInitFile=$nvimConfigDir/init.vim
nvimAutoloadDir="${XDG_DATA_HOME:-$HOME/.local/share}"
tmuxConfigFile=~/.tmux.conf
tmuxConfigFabianFile=~/.tmux.f.conf
tmuxConfigDarwinFile=~/.tmux.conf.darwin
plugFile=$nvimAutoloadDir/plug.vi

################################################################################
# Exports
################################################################################
export GIT_SSH_COMMAND="ssh -i $HOME/.ssh/id.osc"
export PATH=$PATH:$HOME/nsk/bin
export GOPATH=$DATA_REPO/go
export GOROOT=/usr/local/go
export VAULT_CONFIG=~/.vault-config
export DATABASE_Q_DIR=~/nsk/db

################################################################################
# Alias
################################################################################

alias tg='tig HEAD~20..HEAD'
alias vim='~/.nix-profile/bin/nvim'
alias cddb="cd $DATABASE_Q_DIR"
#alias vim='/u'

################################################################################
# Custom installation
################################################################################
command -v tig || nix-env -iA nixpkgs.tig
command -v ag || nix-env -iA nixpkgs.silver-searcher
command -v nvim || nix-env -iA nixpkgs.neovim
unalias tmux
command -v tmux || nix-env -iA nixpkgs.tmux
command -v k9s || nix-env -iA nixpkgs.k9s
#command -v expect || nix-env -iA nixpkgs.expect
#command -v lpass || nix-env -i lastpass-cli
alias tmux='tmux -2'

if [[ ! -e "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vi" ]]; then
  echo "Taking install branch"
  mkdir -p $nvimAutoloadDir
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
else
  echo "Second branch"
fi

[[ -e "$gitconfigFile" ]] || ln -sf ~/.dotfiles/gitconfig $gitconfigFile
[[ -e "$nvimInitFile" ]] || ln -sf ~/.dotfiles/vimrc $nvimInitFile
[[ -e "$tmuxConfigFile" ]] || ln -sf ~/.dotfiles/tmux.conf ~/.tmux.conf
[[ -e "$tmuxConfigFabianFile" ]] || ln -sf ~/.dotfiles/tmux.f.conf ~/.tmux.f.conf
[[ -e "$tmuxConfigDarwinFile" ]] || ln -sf ~/.dotfiles/tmux.conf.darwin ~/.tmux.conf.darwin

echo "========================================"

function _db() {
  pushd $DATA_REPO/ocelot/bin
  pgcli $(./ezvault $1 uri)
  popd
}

function idb() {
  _db $1
}

function dbq() {
  databaseKey=$1
  queryFileName=$2
  queryFile="$DATABASE_Q_DIR/$queryFileName.sql"

  if [[ "$databaseKey" == "" ]]; then
    echo "Must include query file name (sans file suffix, should use *.sql)"
    exit 1
  fi

  if [[ "$queryFile" == "" ]]; then
    echo "Must include query file name (sans file suffix, should use *.sql)"
    exit 1
  fi

  echo "$queryFile"

  pushd $DATA_REPO/ocelot/bin
  salt=`TZ='America/New_York' date +"%Y-%m-%dT%H_%M_%S%z"`
  #salt=$(echo "$salt" | sed 's/:/_/g')
  queryFileOutput=$queryFile.$salt-output.txt
  echo "================================================================================" >> $queryFileOutput
  echo "$queryFile content" >> $queryFileOutput
  echo "================================================================================" >> $queryFileOutput
  cat $queryFile >> $queryFileOutput
  echo "================================================================================" >> $queryFileOutput
  echo "Query Result" >> $queryFileOutput
  echo "================================================================================" >> $queryFileOutput
  psql $(./ezvault $databaseKey uri) -f $queryFile >> $queryFileOutput
  popd
}

dbqo() {
  dbq
}
