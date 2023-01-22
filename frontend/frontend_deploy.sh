#!/bin/bash
set +e


docker pull gitlab.praktikum-services.ru:5050/std-009-047/sausage-store/sausage-frontend:latest
docker stop frontend || true
docker rm frontend || true
set -e
docker-compose up -d frontend