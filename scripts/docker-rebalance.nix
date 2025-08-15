with import <nixpkgs> {};
writeShellScriptBin "docker-rebalance.sh"  ''
hostname="$(hostname)"
leader="$(docker node inspect "$hostname" --format '{{ .ManagerStatus.Leader }}')"

if [ "$leader" = "true" ]; then
  readarray -t <<<"$(sudo docker service ls -q)"
  a=0
  while [ $a -lt ${#MAPFILE[@]} ]
  do
    echo "Rebalancing ${MAPFILE[$i]}"
    sudo docker service update --force "${MAPFILE[$i++]}"
    sleep 10
  done
else
    echo "Not leader, quitting".
fi
''
