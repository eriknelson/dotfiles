#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pushd $AMMOSQ_MAIN
eval "$(direnv export zsh)"

time rake parallel:spec[,'spec\/(?!system)']
