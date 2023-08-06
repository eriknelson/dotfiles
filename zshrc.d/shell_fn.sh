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

pull_nexus() {
  dirsToUpdate=(
    "nexus"
    "nexus.config"
    "nexus.workloads"
    "nexus.sbx"
  )

  for _dir in ${dirsToUpdate[@]}; do
    updateDir=$NSK_GIT_DIR/$_dir
    pushd $updateDir
    git pull
    popd
  done
}

