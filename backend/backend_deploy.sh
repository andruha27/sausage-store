#!/bin/bash
set +e
cat > .backend.env <<EOF
SPRING_DATASOURCE_URL=jdbc:postgresql://${PSQL_HOST}:${PSQL_PORT}/${PSQL_DBNAME}
SPRING_DATASOURCE_USERNAME=${SPRING_DATASOURCE_USERNAME}
SPRING_DATASOURCE_PASSWORD=${SPRING_DATASOURCE_PASSWORD}
SPRING_DATA_MONGODB_URI=mongodb://${MONGO_USER}:${MONGO_PASSWORD}@${MONGO_HOST}:27018/${MONGO_DATABASE}?tls=true&replicaSet=rs01
VIRTUAL_HOST=sausage-backend
EOF

docker network create -d bridge sausage_network || true
docker pull gitlab.praktikum-services.ru:5050/std-009-047/sausage-store/sausage-backend:latest

set -e

if [ "$(docker inspect --format "{{.State.Health.Status}}" $(docker-compose ps -q backend-blue))" == "healthy" ]; then
  docker-compose --env-file .backend.env up -d backend-green
  until [ "$(docker inspect --format "{{.State.Health.Status}}" $(docker-compose ps -q backend-green))" == "healthy" ]; do sleep 1; done
  docker-compose stop backend-blue
else
docker-compose --env-file .backend.env up -d backend-blue
  until [ "$(docker inspect --format "{{.State.Health.Status}}" $(docker-compose ps -q backend-blue))" == "healthy" ]; do sleep 1; done
  docker-compose stop backend-green
fi