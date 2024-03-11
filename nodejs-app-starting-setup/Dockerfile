FROM node

WORKDIR /app

COPY . /app
# COPY . ./app is not same -> cause ./app means from workdir to app
# /app means from current position to app which can be above root


RUN npm install

EXPOSE 80

CMD ["node","server.js"]