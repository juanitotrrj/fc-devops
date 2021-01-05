FROM node:alpine

RUN apk update && apk add supervisor openssh git

WORKDIR /

RUN git clone https://github.com/juanitotrrj/fc-client.git app

WORKDIR /app

RUN npm install --dev

EXPOSE 3000
