#!/bin/bash
set +e
cat > .backend.env <<EOF
SPRING_CLOUD_VAULT_TOKEN=${SPRING_CLOUD_VAULT_TOKEN}		
VAULT_TOKEN=${SPRING_CLOUD_VAULT_TOKEN}		
VAULT_HOST=${VAULT_HOST}
VAULT_PORT=${VAULT_PORT}
VIRTUAL_HOST=sausage-backend
EOF

docker network create -d bridge sausage_network || true
docker pull gitlab.praktikum-services.ru:5050/std-009-047/sausage-store/sausage-backend:latest

set -e

if [ "$(docker inspect --format "{{.State.Health.Status}}" $(docker-compose ps -q backend-blue))" == "healthy" ]; then
  docker-compose --env-file .backend.env up -d backend-green
  until [ "$(docker inspect --format "{{.State.Health.Status}}" $(docker-compose ps -q backend-green))" == "healthy" ]; do sleep 5; done
  docker-compose stop backend-blue
else
  docker-compose --env-file .backend.env up -d backend-blue
  until [ "$(docker inspect --format "{{.State.Health.Status}}" $(docker-compose ps -q backend-blue))" == "healthy" ]; do sleep 5; done
  docker-compose stop backend-green
fi