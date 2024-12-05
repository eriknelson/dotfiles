force_destroy_namespace() {
NAMESPACE=$1
oc proxy &
oc get namespace $NAMESPACE -o json |jq '.spec = {"finalizers":[]}' >temp.json
curl -k -H "Content-Type: application/json" -X PUT --data-binary @temp.json 127.0.0.1:8001/api/v1/namespaces/$NAMESPACE/finalize
kill $(ps aux | grep "[oc] proxy" | awk '{print $2}')
}

# NOTE: Really useful when debugging something stuck in terminating
dump_all_resources_in_namespace() {
NAMESPACE=$1
if [[ "$NAMESPACE" == "" ]]; then
  echo "ERROR: Must pass namespace as arg"
else
  kubectl api-resources --verbs=list --namespaced -o name | grep -iv event | xargs -n 1 kubectl get --show-kind --ignore-not-found -n $NAMESPACE
fi
}

function kexec() {
  kubectl exec --stdin --tty $1 -- bash
}

function k8s_skel() {
  kind=$1
  namespace=$2

  if [[ "$kind" == "" ]] || [[ "$namespace" == "" ]]; then
    echo "ERROR: Must provide params"
    echo "Usage: k8s_skel [KIND] [NAMESPACE]"
    exit 1
  fi

  kubectl create ${kind} ${namespace} --dry-run=client -o yaml
}
