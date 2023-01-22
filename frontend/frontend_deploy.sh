#!/bin/bash
set +e

cat > .frontend.env <<EOF

EOF

docker network create -d bridge sausage_network || true
docker pull gitlab.praktikum-services.ru:5050/std-009-047/sausage-store/sausage-frontend:latest
docker stop sausage-frontend || true
docker rm sausage-frontend || true
set -e
docker-compose up --env-file .frontend.env -d sausage-frontend