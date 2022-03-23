clean_pm_containers(){
  podman rm $(podman ps -a | tail +2 | grep $1 | awk '{print $1}')
}

clean_all_pm_containers(){
  podman rm $(podman ps -a | tail +2 | awk '{print $1}')
}

clean_pm_images(){
  podman rmi -f $(podman images | tail +2 | grep $1 | awk '{print $3}')
}

clean_all_pm_images(){
  podman rmi -f $(podman images | tail +2 | awk '{print $3}')
}
