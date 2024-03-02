#PEER_MODE=net
#Command=dev-init.sh -e 
#Generated: Sat Mar  2 15:10:00 UTC 2024 
docker-compose  -f ./compose/docker-compose.base.yaml      -f ./compose/docker-compose.explorer.yaml    up -d --remove-orphans
