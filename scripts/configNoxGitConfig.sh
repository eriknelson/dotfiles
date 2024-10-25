#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
git config gpg.format ssh
git config user.signingkey /home/ernelson/.ssh/id_ed25519_nox.pub
git config commit.gpgsign true
