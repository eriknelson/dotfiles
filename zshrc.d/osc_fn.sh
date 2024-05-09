_doscar_clean() {
  doscarDir=$NSK_GIT_DIR/doscar
  pushd $doscarDir
  doc down
  doc sidecar-remove nsk
  rm -rf $doscarDir/installed_sidecars/nsk.yml
  popd
}

_doscar_bounce_up() {
  _doscar_clean
  pushd $doscarDir
  doc sidecar-add $doscarDir/available_sidecars/nsk.yml nsk
  doc up
  doc shell
  popd
}
