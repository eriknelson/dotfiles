sudoi(){
  PS1="\[\e[31m\]\u\[\e[m\]@\h " \
    PROMPT="" \
    sudo -i
}

_script() {
echo '#!/bin/bash' >> $1
echo '_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"' >> $1
chmod +x $1

if [[ "$2" == "e" ]]; then
  vim $1
fi
} # /_script
