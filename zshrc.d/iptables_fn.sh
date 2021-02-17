reset_iptables() {
  sudo iptables -P INPUT ACCEPT
  sudo iptables -P FORWARD ACCEPT
  sudo iptables -P OUTPUT ACCEPT
  sudo iptables -t nat -F
  sudo iptables -t mangle -F
  sudo iptables -F
  sudo iptables -X
}

dump_all_iptables() {
  tables=(
    filter
    nat
    mangle
    raw
    security
  )
  for table in "${tables[@]}"; do
    sudo iptables --line-numbers -L -t $table
  done
}

dump_all_nftables() {
  tables=(
    inet
    ip
  )
  for table in "${tables[@]}"; do
    sudo nft list ruleset $table
  done
}
