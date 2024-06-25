echo "========================================"
echo "NSK Doscar Hook"
echo "========================================"
echo "Configuring git+ssh to use ~./ssh/id.osc"
export GIT_SSH_COMMAND="ssh -vvv -i $HOME/.ssh/id.osc"
which tig || nix-env -i tig
which ag || nix-env -iA nixpkgs.silver-searcher
export PATH=$PATH:$HOME/nsk/bin
ln -sf ~/.dotfiles/gitconfig ~/.gitconfig
echo "========================================"
