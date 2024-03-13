FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

EXPOSE 8080

VOLUME [ "/app/feedback" ]

CMD [ "node", "server.js" ]