FROM node

WORKDIR /app

COPY . ./app
# COPY . ./ same as app is workdir


RUN npm install

EXPOSE 80

CMD ["node","server.js"]