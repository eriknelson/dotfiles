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
export GIT_SSH_COMMAND="ssh -vvv -i $HOME/.ssh/id.osc"
export PATH=$PATH:$HOME/nsk/bin
export GOROOT=/usr/local/go

################################################################################
# Alias
################################################################################

alias tg='tig HEAD~20..HEAD'
alias vim='~/.nix-profile/bin/nvim'
#alias vim='/u'

################################################################################
# Custom installation
################################################################################
command -v tig || nix-env -iA nixpkgs.tig
command -v ag || nix-env -iA nixpkgs.silver-searcher
command -v nvim || nix-env -iA nixpkgs.neovim
unalias tmux
command -v tmux || nix-env -iA nixpkgs.tmux
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
