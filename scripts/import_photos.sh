#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mountdir=$1
outdir=$2
sdcarddev=/dev/mmcblk0p1
importdir=`date +%Y%m%d%H%M%S`
genoutdir="$outdir/$importdir"

if [[ "$mountdir" == "" ]] || [[ "$outdir" == "" ]]; then
  echo "ERROR: Missing args, first is mountdir second is outdir"
  exit 1
fi

mkdir -p $genoutdir

sudo mount $sdcarddev $mountdir

echo "Copying files to: $genoutdir"
find ~/sdcard -iname '*.jpg' -exec rsync -avP {} $genoutdir \;

echo "Cleaning SD card"
sudo find ~/sdcard -iname '*.jpg' -exec rm -rf {} \;

echo "Unmounting SD card"
sudo umount $mountdir
