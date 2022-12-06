FROM node:16
# Create app directory
WORKDIR /usr/src/app
COPY . .
RUN npm ci
RUN npm install -g http-server
RUN npm run build
EXPOSE 80
ENTRYPOINT ["http-server", "dist/frontend/", "-p", "80", "--proxy", "http://sausage-backend:8080"]