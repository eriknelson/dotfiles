echo "Configuring git+ssh to use ~./ssh/id.osc"
export GIT_SSH_COMMAND="ssh -vvv -i $HOME/.ssh/id.osc"
#export SSH_CONFIG_PATH=$HOME/.ssh/config.doscar
echo "========================================"
echo "NSK Doscar Hook"
echo "========================================"
nix-env -i tig
