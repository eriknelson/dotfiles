#!/bin/bash

############################################################
# Automated setup script for work environment
############################################################
#
# AUTHOR: Erik Nelson - EM: erik (at) nelsk (dot) com - TW: @enels
# 
# NOTE: Some assumptions are made with this script, namely, we're going to be
# linking all files to the home directory, prependeding their names with a dot (.),
# so as to hide them as normal dotfiles. I had originally planned to allow for
# some configuration, but realized I couldn't come up with a single case to
# justify the requirement.
#
############################################################

scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
me=`basename $0`

ignoreFiles=(
  "$me"
  "iterm"
)

containsElement(){
  # Helper for iterating ignoreFiles
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

manageLinks(){
  if [[ $1 == "_setup" ]]; then
    echo "[ Linking ]"
  else
    echo "[ Removing links ]"
  fi

  for f in *; do
    dotfilePath="$scriptDir/$f"
    destFile=".$f"
    destPath="$HOME/$destFile"

    # Skip ignored files like the manage script itself
    if containsElement "$f" "${ignoreFiles[@]}"; then
      echo "Ignoring $dotfilePath" && continue;
    fi

    if [[ "$1" == "_setup" ]]; then # Setup links

      # Skip linking files that already exist
      [[ -e $destPath ]] && echo "$destPath already exists, skipping..." && continue

      ln -s $dotfilePath $destPath

      if [[ $? -eq 0 ]]; then
        echo "Linked $dotfilePath to $HOME/$destFile"
      else
        echo "ERROR attempting to link $dotfilePath to $destPath"
      fi

    else # Clean links

      if [[ -e $destPath ]] && [[ -L $destPath ]]; then
        echo "Removing link $destPath"
        rm $destPath
      else
        echo "$destPath does not exist, or is not a link, skipping..."
      fi

    fi

  done
}

setup(){
  echo "[ Setting up dotfiles ]"

  # Source bashrc in our bash_profile if not already there
  if [[ -f $HOME/.bash_profile ]]; then
    cat $HOME/.bash_profile | grep -q "source.*bashrc"

    if [[ $? -eq 1 ]]; then
      echo "Sourcing .bashrc in .bash_profile"
      echo "source $HOME/.bashrc" >> $HOME/.bash_profile
    else
      echo ".bashrc already sourced by .bash_profile, skipping..."
    fi

  fi

  manageLinks _setup

  echo "[ Dotfiles setup complete ]"
}

clean(){
  echo "[ Cleaning existing setup ]"

  if [[ -f $HOME/.bash_profile ]]; then
    echo "Snipping .bashrc source from .bash_profile if needed"
    sed -i -e "/source.*bashrc/d" $HOME/.bash_profile
  fi

  manageLinks _clean

  echo "[ Dotfiles cleaned ]"
}

reset(){
  echo "[ Reseting dotfiles ]"

  manageLinks _clean
  manageLinks _setup
}

usage(){
  echo
  echo "Usage: $0 <command>"
  echo
  echo "Commands:"
  echo "  setup - sets up environemnt"
  echo "  clean - cleans any existing setup like dotfile links"
  echo "  reset - runs clean followed by a setup, a fresh start"
  echo
}

case "$1" in
  setup)
    setup
    ;;
  clean)
    clean
    ;;
  reset)
    reset
    ;;
  *)
    usage
esac
