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

function ghci2 () {
  gh issue create -p="$projectProdCluster" -l="l2" -l="enhancement" -m="$projectProdCluster" "$@"
}

function watch_kilo() {
  export KUBECONFIG=/home/ernelson/git/ammosquared/kammo/output/alpha.kubeconfig.yml
  watch 'kubectl get kcp; echo "---"; kubectl get md; echo "---"; kubectl get machines'
}

# Headscale - execs into the headscale pod automatically
function hs() {
  export KUBECONFIG=~/git/ammosquared/kammo/output/kilo.kubeconfig.yml
  kubectl exec -it -c headscale $(kubectl get pods -n headscale --no-headers | awk '{print $1}') -- headscale $@
}
