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


# Kubernetes

## kube control commands:
- `kubectl create deployment <deployment_name> --image=<image_name>` to create a deployment.
  - local image cannot be used. It has to be pushed to the docker hub. Because the kubernetes cluster is a separate environment. and will through error `ErrImagePull`.
  - `kubectl get deployments` to get the deployments.
  - `kubectl delete deployment <deployment_name>` to delete the deployment.
  - `kubectl get pods` to get the pods.
  - `kubectl describe pod <pod_name>` to get the details of the pod.
- `kubectl expose deployment <deployment_name> --type=TypeName --port=portId` to expose the deployment.
  - type `ClusterIP` is used to expose the deployment to the inside the cluster.
  - type `NodePort` is used to expose the deployment to the outside world but it will expose the deployment to the port range of the worker node.
  - type `LoadBalancer` is used to expose the deployment to the outside world. It will create a load balancer.
  - `kubectl get services` to get the services.
  - `kubectl delete service <service_name>` to delete the service.
- `kubectl scale deployment/<deployment_name> --replicas=<no_of_replica>` to scale up or down the deployment.
  - fact is if we scale down those pods will be deleted which are not in use or has more restarts.

- `kubectl set image deployment/<deployment_name> <container_name>=<new_image_name>` to update the image of the deployment.
  - `kubectl rollout status deployment/<deployment_name>` to check the status of the rollout.
  - `kubectl rollout history deployment/<deployment_name>` to check the history of the rollout.
  - `kubectl rollout undo deployment/<deployment_name>` to undo the latest deployment.
  - `kubectl rollout undo deployment/<deployment_name> --to-revision=<revision_number>` to undo the rollout to a specific revision.
## Minikube commands:
- `minikube start --driver=driverName` to start the kubernetes cluster.
  - drivers for linux can be `docker`, `QEMU`, `kvm2`, `virtualbox`, `Podman`, `none`
- `minikube status` to check the status of the cluster.
- `minikube dashboard` to open the dashboard.
- `minikube service <service_name>` to open the service url in the browser.
- `minikube stop` to stop the cluster.
- `minikube delete` to delete the cluster.

## Kubernetes files [YAML]:
look at [master-deployment.yaml](kub-action-01-starting-setup/master-deployment.yaml) file. which i'll be referencing
- `apiVersion` is used to specify the version of the kubernetes api.
  - `apiVersion: apps/v1` is used to specify the version of the apps. for deployment kind
  - `apiVersion: v1` is used to specify the version of the api. for service kind
- `kind` is used to specify the kind of the object.
- `metadata` is used to specify the metadata of the kind object.
  - `name` is used to specify the name of the kind object.
- `spec` is used to specify the specification of the object.
  - `replicas` is used to specify the number of replicas.
  - `selector` is used to specify the selector of the object.
    - `matchLabels` is used to specify the labels of the object.
  - `template` is used to specify the template of the kind object which is pod.
    - `metadata` is used to specify the metadata of the pod object.
      - `labels` is used to specify the labels of the pod object.
    - `spec` is used to specify the specification of the pods object.
      - `containers` is used to specify the containers of the pods object.
        - `name` is used to specify the name of the container.
        - `image` is used to specify the image of the container.
        - `ports` is used to specify the ports of the container.
          - `containerPort` is used to specify the port of the container.

