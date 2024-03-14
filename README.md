# Docker
Learning docker from [this](https://www.udemy.com/course/docker-and-kubernetes-the-complete-guide/) udemy course.

command to run code

> 1) docker build -t <container_name> .
> 2) docker run -p <local_port>:<docker_exposed_port> <container_name>
  example:
    docker run -p 8080:8080 abir/simpleweb

### Command meaning
- `FROM image-name` is used to specify the base image from which you are building.

- `WORKDIR` is used to set the working directory for any `RUN`, `CMD`, `ENTRYPOINT`, `COPY` and `ADD` instructions that follow it in the Dockerfile. 
  - If the WORKDIR doesn't exist, it will be created

- `COPY` is used to copy files or directories from a source to a destination. 

- `RUN` is used to execute a command when the image is being built.

- `EXPOSE` is used to specify the port on which the container will listen for incoming connections.

- `CMD` is used not to run anything when the image is being built, but to run something when a container is being started.

- `ATTACH` is used to attach to a running container.
  - `docker attach <container_id>`

- `logs` is used to fetch the logs of a container.
  - `docker logs <container_id>`
  - `docker logs -f <container_id>` to follow the logs

- `ENV` is used to set the environment variable.
  - `ENV <key> <value>`
  - `docker run --env <key>=<value> <container_name>`

- `--env-file` is used to set the environment variable from a file.
  - `docker run --env-file <file_name e.g .env> <container_name>` 
  