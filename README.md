# Docker
Learning docker from [this](https://www.udemy.com/course/docker-and-kubernetes-the-complete-guide/) udemy course.

command to run code

> 1) docker build -t <container_name> .
> 2) docker run -p <local_port>:<docker_exposed_port> <container_name>
  example:
    docker run -p 8080:8080 abir/simpleweb

> 3) note: `host.docker.internal` works if you install docker desktop. I mean development version.
>   - But if production version installed using `sudo apt-get install ....`  it does not support it.
>   - but we can use it by passing an argument in `docker run --add-host=host.docker.internal:host-gateway ...`

### Docker Commands
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

- `ARG` is used to pass the argument to the dockerfile.
  - `ARG <key>`
  - `docker build --build-arg <key>=<value> .`
  - so it's bind in image building and locked not in container running.

- `host.docker.internal` is used to access the host machine from the container.
  - {mongo: 'host.docker.internal'} rather than {mongo: 'localhost'} to connect to the mongoDB running on the host machine.

- `docker network create <network_name>` is used to create a network.
  - This is how we can connect multiple containers together.
  - `docker run --network <network_name> <container_name>`
  - `docker network connect <network_name> <container_name>` to connect a container to a network.
  - in this case we put the container name in the place of the host name in the connection string.
    - `mongodb://<mongo_container_name>:27017/<db_name>`
  * note: we can connect to other container using the ip address of the container as well.
  * but it's not recommended.

- `-v` is used to mount a volume.
  - `docker run -v /app/node_modules` is anonymous volume. 
  - `docker run -v data:/app` is named volume.
  - `docker run -v $(pwd):/app` is bind mount. 

## Docker Compose notes

> Though when we run docker compose it creates container name with some suffix and prefix.
> - it still refers to the container name we provided in the `docker-compose.yml` file. So we can use the container name in this case service name specified by us in docker-compose in the connection string and for other purposes.
> - But in command line we have to use the container name with the suffix and prefix.
### Docker Compose Commands
- `docker-compose up` is used to start the containers.
  - `docker-compose up -d` to run in the background.
  - `docker-compose up --build` to rebuild the image.
  - it will create a network and connect the containers to the network.
  - it will create a volume and mount the volume to the container.
  - all automatic name will be prefixed with the parent folder name.

- `docker-compose down` is used to stop the containers.
  - `docker-compose down -v/--volumes` to remove the volumes as well.

