#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
essentialsFile=$_dir/../nox-arch-pkg-essentials.txt
flatStr=$(cat $essentialsFile | tr '\n' ' ')
echo $flatStr
sudo pacman -S $flatStr

################################################################################
# Modules
################################################################################
# i2c-dev is for detecting the display identifiers in a reliable manner based
# on an "edid" that is embedded within the monitors. It's included in the
# arch linux package, so no extra package install is needed, but it still
# needs to be manually loaded.
echo 'i2c-dev' | sudo tee /etc/modules-load.d/i2c-dev.conf
