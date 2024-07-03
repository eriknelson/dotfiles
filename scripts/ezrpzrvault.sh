#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [[ ! $(pgrep ezrpzrvault) ]]; then
  (nohup ./go/bin/ezrpzrvault &)
fi
