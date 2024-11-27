function wgace() {
  action=$1
  if [[ "$action" != "up" ]] && [[ "$action" != down ]]; then
    echo "ERROR: first arg must be an action of 'up' or 'down'"
    exit
  fi
  wg-quick $action ~/.wireguard/ace.conf
}

projectProdCluster="ProdCluster v1.0"
function ghci () {
  gh issue create -p "$projectProdCluster" -l="enhancement" -m "$projectProdCluster" "$@"
}

function ghci0 () {
  gh issue create -p="$projectProdCluster" -l="l0" -l="enhancement" -m="$projectProdCluster" "$@"
}

function ghci1 () {
  gh issue create -p="$projectProdCluster" -l="l1" -l="enhancement" -m="$projectProdCluster" "$@"
}
