#! /bin/bash
set -xe
sudo cp -rf sausage-store.service /etc/systemd/system/sausage-store-backend.service && sudo rm -f /var/jarservice/sausage-store.jar||true && curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store.jar ${NEXUS_REPO_URL}/sausage-store-vorobyev-andrey-backend/com/yandex/practicum/devops/sausage-store/${VERSION}/sausage-store-${VERSION}.jar && sudo cp ./sausage-store.jar /var/jarservice/sausage-store.jar||true && sudo chown jarservice /var/jarservice/sausage-store.jar && sudo systemctl daemon-reload && sudo systemctl import-environment restart sausage-store-backend 