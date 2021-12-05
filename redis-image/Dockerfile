# Use an existing docker as a base

FROM alpine

# Download and install dependency

RUN apk add --update redis

RUN apk add --update gcc
# Telll the image what to do when it starts
# as a container

CMD ["redis-server"]