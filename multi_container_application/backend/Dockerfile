FROM node

WORKDIR /app

COPY package.json /app

RUN npm install

COPY . .

EXPOSE 80

CMD [ "node", "app.js" ]