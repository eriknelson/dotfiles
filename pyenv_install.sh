#!/bin/bash
if [[ $* == *--install-ubuntu-dep* ]]; then
  sudo apt-get install \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libsqlite3-dev \
    libreadline-dev \
    libbz2-dev
  exit 1
fi

git clone https://github.com/yyuu/pyenv.git ~/.pyenv
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
