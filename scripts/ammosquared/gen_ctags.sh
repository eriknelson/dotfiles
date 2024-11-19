#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $AMMOSQ_MAIN
ctags -R \
  -f $AMMOSQ_ROOT/.tags \
  --languages=ruby \
  --exclude=.git \
  --exclude=log \
  --exclude=tmp \
  --exclude=node_modules \
  --exclude=.data \
  . $(bundle list --paths)
popd
