#!/bin/bash
set +e
cat > .backend.report.env <<EOF
DB=mongodb://${MONGO_USER}:${MONGO_PASSWORD}@${MONGO_HOST}:27018/${MONGO_DATABASE}?tls=true&replicaSet=rs01\&tls=true\&replicaSet=rs01\&tlsAllowInvalidCertificates=true\&tlsCAFile=~/.mongodb/root.crt
PORT=8080
EOF

docker network create -d bridge sausage_network || true
docker pull gitlab.praktikum-services.ru:5050/std-009-047/sausage-store/sausage-report:latest
docker stop backend-report || true
docker rm backend-report || true

set -e
docker-compose --env-file .backend.report.env up -d backend-report