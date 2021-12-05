# Specify a base image
# alpine version of a image is as small as possible

# FROM node:alpine
FROM node:alpine
#  Install some dependencies

WORKDIR /usr/app
COPY ./ ./

# COPY ./package.json ./

RUN npm install 

# COPY ./ ./
# # default command

CMD ["npm","start"]