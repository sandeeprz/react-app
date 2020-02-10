FROM node:alpine as builder
ADD https://rpm.nodesource.com/setup_12.x /root/
RUN bash /root/setup_12.x ;\ 
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash ;\
yum -y install nodejs ;\
yum -y install java-1.8.0-openjdk ;\
yum install vim -y



WORKDIR /app

COPY package.json .

RUN npm install

COPY . .



RUN npm run build

FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html
