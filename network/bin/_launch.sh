#PEER_MODE=dev
#Command=dev-init.sh -d 
#Generated: Sat Mar  9 02:22:28 UTC 2024 
docker-compose  -f ./compose/docker-compose.base.yaml    -f ./compose/docker-compose.dev.yaml      up -d --remove-orphans
