#!/bin/bash
set +e
cat > .backend.env <<EOF
SPRING_DATASOURCE_URL=jdbc:postgresql://${PSQL_HOST}:${PSQL_PORT}/${PSQL_DBNAME}
SPRING_DATASOURCE_USERNAME=${SPRING_DATASOURCE_USERNAME}
SPRING_DATASOURCE_PASSWORD=${SPRING_DATASOURCE_PASSWORD}
SPRING_DATA_MONGODB_URI=mongodb://${MONGO_USER}:${MONGO_PASSWORD}@${MONGO_HOST}:27018/${MONGO_DATABASE}?tls=true&replicaSet=rs01
EOF

docker pull gitlab.praktikum-services.ru:5050/std-009-047/sausage-store/sausage-backend:latest
docker stop backend || true
docker rm backend || true

set -e
docker-compose --env-file .backend.env up -d backend