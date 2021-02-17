clean_nsk_secrets() {
  oc get secrets -n openshift-config | grep nsk | awk '{print $1}' | xargs -I{} oc delete secret -n openshift-config {}
}

clean_token_secrets() {
  oc get secrets -n openshift-config | grep nsktoken | awk '{print $1}' | xargs -I{} oc delete secret -n openshift-config {}
}

clean_mig_cluster_scoped() {
  oc get crds | grep 'migration.openshift.io' | awk '{print $1}' | xargs -I{} oc delete crd {}
  oc get crds | grep velero | awk '{print $1}' | xargs -I{} oc delete crd {}
  oc get clusterroles | grep 'migration.openshift.io' | awk '{print $1}' | xargs -I{} oc delete clusterrole {}
  oc get clusterroles | grep velero | awk '{print $1}' | xargs -I{} oc delete clusterrole {}
  oc get clusterrolebindings | grep 'migration.openshift.io' | awk '{print $1}' | xargs -I{} oc delete clusterrolebindings {}
  oc get clusterrolebindings | grep velero | awk '{print $1}' | xargs -I{} oc delete clusterrolebindings {}
}

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
