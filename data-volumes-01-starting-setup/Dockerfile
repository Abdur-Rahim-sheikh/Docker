FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

EXPOSE 8080
# make sure your feedback and temp folder present before build
CMD [ "node", "server.js" ]