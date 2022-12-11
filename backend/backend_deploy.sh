#!/bin/bash
set +e
cat > .env <<EOF
SPRING_DATASOURCE_URL=${SPRING_DATASOURCE_URL};
SPRING_DATASOURCE_USERNAME=${SPRING_DATASOURCE_USERNAME};
SPRING_DATASOURCE_PASSWORD=${SPRING_DATASOURCE_PASSWORD};
SPRING_DATA_MONGODB_URI=mongodb://${MONGO_USER}:${MONGO_PASSWORD}@${MONGO_HOST}:27018/${MONGO_DATABASE}?tls=true&replicaSet=rs01;
EOF

cat .env

docker network create -d bridge sausage_network || true
docker pull gitlab.praktikum-services.ru:5050/std-009-047/sausage-store/sausage-backend:latest
docker stop sausage-backend || true
docker rm sausage-backend || true
set -e
docker run -d --name sausage-backend \
    --network=sausage_network \
    --restart always \
    --pull always \
    --env-file .env \
    gitlab.praktikum-services.ru:5050/std-009-047/sausage-store/sausage-backend:latest