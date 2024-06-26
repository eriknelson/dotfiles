echo "========================================"
echo "NSK Doscar Hook"
echo "========================================"

gitconfigFile=~/.gitconfig
nvimConfigDir=~/.config/nvim
nvimInitFile=$nvimConfigDir/init.vim
nvimAutoloadDir=~/.local/share/nvim/site/autoload
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
alias vim='/usr/bin/vim'

################################################################################
# Custom installation
################################################################################
command -v tig || nix-env -iA nixpkgs.tig
command -v ag || nix-env -iA nixpkgs.silver-searcher
command -v nvim || nix-env -iA nixpkgs.neovim

if [[ -e "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vi" ]]; then
  mkdir -p $nvimAutoloadDir
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

[[ -e "$gitconfigFile" ]] || ln -sf ~/.dotfiles/gitconfig $gitconfigFile
[[ -e "$nvimInitFile" ]] || ln -sf ~/.dotfiles/vimrc $nvimInitFile

echo "========================================"
