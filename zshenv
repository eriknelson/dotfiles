export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

if type "keychain" > /dev/null; then
  eval $(keychain --eval --agents ssh -Q \
    $HOME/.ssh/id_rsa_p \
    $HOME/.ssh/id_rsa_w)
fi
