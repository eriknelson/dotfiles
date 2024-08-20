#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
credsFile=~/.secrets/pia.txt
piactl login $credsFile
piactl connect
piactl get connectionstate
