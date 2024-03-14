FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

ENV PORT 80

EXPOSE $PORT
# make sure your feedback and temp folder present before build
CMD [ "npm", "start" ]