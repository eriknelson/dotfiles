setup_good_docker() {
  clean_all_images
  sudo systemctl stop firewalld
  reset_iptables
  sudo systemctl restart docker
}

setup_desired_docker() {
  clean_all_images
  reset_iptables
  sudo systemctl start firewalld
  sudo systemctl restart docker
}

capture_good_docker() {
  setup_good_docker
  cd ~/tundra/fw-testing
  dump_all_iptables > ipt_before.txt
  dump_all_nftables > nft_before.txt
}

capture_desired_docker() {
  setup_desired_docker
  cd ~/tundra/fw-testing
  dump_all_iptables > ipt_after.txt
  dump_all_nftables > nft_after.txt
}

clean_containers(){
  docker rm $(docker ps -a | tail -n +2 | grep $1 | awk '{print $1}')
}

clean_all_containers(){
  docker rm $(docker ps -a | tail -n +2 | awk '{print $1}')
}

clean_images(){
  docker rmi -f $(docker images | tail -n +2 | grep $1 | awk '{print $3}')
}

clean_all_images(){
  docker rmi -f $(docker images | tail -n +2 | awk '{print $3}')
}
