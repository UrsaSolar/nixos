hostname="$(hostname)"
leader="$(docker node inspect "\"$hostname\"" --format '{{ .ManagerStatus.Leader }}')"

if [ "$leader" = "true" ]; then
  readarray -t <<<"$(sudo docker service ls -q)"
  for (( i=0; i<${#MAPFILE[@]}; i++ ))
  do
    echo "Rebalancing ${MAPFILE[$i]}"
    sudo docker service update --force "${MAPFILE[$i]}"
    sleep 10
  done
fi
