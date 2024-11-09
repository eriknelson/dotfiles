#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
essentialsFile=$_dir/../arch-pkg-essentials.txt
flatStr=$(cat $essentialsFile | tr '\n' ' ')
echo $flatStr
sudo pacman -S $flatStr
