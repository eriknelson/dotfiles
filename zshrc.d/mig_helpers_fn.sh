build_mig_ui() {
  mig_ui_label=$1
  if [[ "$mig_ui_label" == "" ]]; then
    echo "ERROR: Need to pass mig-ui image label as a first argument, exiting.."
    return 1
  fi

  docker build -f ./Dockerfile -t quay.io/eriknelson/mig-ui:$1 . && docker push quay.io/eriknelson/mig-ui:$1
}
