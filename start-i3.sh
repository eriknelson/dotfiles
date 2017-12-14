#!/bin/bash
if ! cat /etc/redhat-release; then
  # RH Family
  export SSH_ASKPASS=/usr/libexec/openssh/x11-ssh-askpass
else
  # Arch Family
  export SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass
fi

eval $(ssh-agent)
ssh-add
i3
