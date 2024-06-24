#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
shareNames=(
"tundra"
"private_static"
"matchbox"
"boot_http"
"boot_tftp"
)

cifsHost="tank.machine.kotawerks.gg"
cifsShareName="tundra"
cifsCredentialsFile="/root/.secrets/tankCifsCreds"
#cifsWorkgroup="NSK"

for share in "${shareNames[@]}"; do
  cifsMountDir="/nas/$share"
  mountString="//$cifsHost/$share $cifsMountDir"
  mountString+=" -o credentials=$cifsCredentialsFile,rw,uid=${UID},gid=${UID}"
  #mountString+=",workgroup=$cifsWorkgroup"
done

echo $mountString

sudo mount.cifs $mountString
