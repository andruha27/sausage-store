#! /bin/bash
set -xe
sudo cp -rf sausage-store-frontend.service /etc/systemd/system/sausage-store-frontend.service && sudo rm -rf /var/www-data/dist/*||true && curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store.tar.gz ${NEXUS_REPO_URL}/sausage-store-vorobyev-andrey-frontend/sausage-store/${VERSION}/sausage-store-${VERSION}.tar.gz && sudo cp ./sausage-store.tar.gz /var/www-data/dist/sausage-store.tar.gz||true && sudo tar -xzf /var/www-data/dist/sausage-store.tar.gz -C /var/www-data/dist/||true && sudo rm -rf /var/www-data/dist/sausage-store.tar.gz && sudo chown -R front-user /var/www-data/dist/ && sudo systemctl daemon-reload && sudo systemctl restart sausage-store-frontend 