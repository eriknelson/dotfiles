#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
wget -O /etc/pacman.d/mirrorlist.new 'https://archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=4&use_mirror_status=on'
sed -i 's/^#//g' /etc/pacman.d/mirrorlist.new
time rankmirrors -n 6 /etc/pacman.d/mirrorlist.new > /etc/pacman.d/mirrorlist
pacman -Syy
