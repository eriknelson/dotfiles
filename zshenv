############################################################
# Need to be extremely careful with this; it really only makes sense
# when launching a DE manually from a login shell, i.e. w/startx
# Got bit on a Fedora system that had keychain installed --
# caused Gnome launch to hang after logging in via gdm
############################################################
#if type "keychain" > /dev/null; then
  #eval $(keychain --eval --agents ssh -Q \
    #$HOME/.ssh/id_rsa_redhat)
#fi
############################################################

if [[ -z ${DESKTOP_SESSION+x} ]] && [[ $(hostname) = "anonix" ]]; then
  exec $HOME/.launch
fi
