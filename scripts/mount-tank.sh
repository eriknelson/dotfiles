#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cifsHost="tank.lan.nsk.io"
cifsShareName="tundra"
cifsMountDir="$HOME/tank"
cifsCredentialsFile="$HOME/.secrets/tankCifsCreds"
cifsWorkgroup="NSK"

mountString="//$cifsHost/$cifsShareName $cifsMountDir"
mountString+=" -o credentials=$cifsCredentialsFile,rw,uid=${UID},gid=${UID}"
mountString+=",workgroup=$cifsWorkgroup"

echo $mountString

sudo mount.cifs $mountString
