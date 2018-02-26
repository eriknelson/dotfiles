# TODO: Script for setting up applications on the correct i3 workspaces on startup.
if [[ "$(hostname)" = *"baldur"* ]]; then
  # mainterm
  i3-msg 'workspace 1; exec /usr/bin/gnome-terminal --command=tmux'
  # rightbrowser
  i3-msg 'workspace 4; exec /usr/bin/firefox --new-window reddit.com/r/linux'
  # audio
  i3-msg 'workspace 7; exec /usr/bin/firefox --new-window play.pocketcasts.com'
  i3-msg 'workspace 7; exec /var/lib/snapd/snap/bin/spotify'
  # mainbrowser
  i3-msg 'workspace 8; exec /usr/bin/firefox --new-window github.com'
  # rightterm
  i3-msg 'workspace 9; exec /usr/bin/gnome-terminal --command=tmux'
  # comms, TODO: Need to correctly stack and layout
  i3-msg 'workspace 10; exec /usr/bin/quasselclient'
  i3-msg 'workspace 10; exec /var/lib/snapd/snap/bin/telegram-sergiusens.telegram'
  i3-msg 'workspace 10; exec /usr/bin/firefox --new-window mail.redhat.com'
fi
