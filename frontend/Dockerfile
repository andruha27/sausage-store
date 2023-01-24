FROM node:16 as builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM gitlab.praktikum-services.ru:5050/std-009-047/sausage-store/nginxproxy/nginx-proxy:latest
COPY --from=builder /usr/src/app/dist/frontend /usr/share/nginx/html

EXPOSE 80