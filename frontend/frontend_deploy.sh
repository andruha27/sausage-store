#!/bin/bash
set +e


docker network create -d bridge sausage_network || true
docker pull gitlab.praktikum-services.ru:5050/std-009-047/sausage-store/sausage-frontend:latest
docker stop frontend || true
docker rm frontend || true
set -e
docker-compose up -d frontend