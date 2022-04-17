FROM node:16-alpine

WORKDIR /usr/src/app

COPY package.json ./

RUN npm install --silent

COPY . .

CMD [ "node", "app.js" ]

EXPOSE 3000
