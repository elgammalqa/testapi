Task is to build and deploy into k8s cluster a distributed web api application

# Prerequisites

- Docker
- k8s Minikube
- DockerHub access (or any other service that allows to store images)- Azure DevOps access (optional)
- Helm https://helm.sh/docs/intro/install/ 

> Execute the commands from the TestApi folder.

1. Build Docker image localy
    ```bash
    docker image build --pull -t testapi:v1 .
    ```
2. Run & test the image 
    ```bash
    docker run --rm -it -p 5000:80 testapi:v1
    ```
    ```bash
    curl http://localhost:5000/weatherforecast
    ```
3. Bush Docker image to Docker Hub
    ```bash
    docker login
    ```
    ```bash
    docker images
    ```
    ```bash
    docker tag <Image ID> yourhubusername/<repo name>:tag
    ```
    ```bash
    docker push yourhubusername/<repo name>
    ```
4. Install via Helm
    ```bash
    helm install testapirelease ./chart/
    ```
    The Kubernetes deployment will use image [amirelgammal/testapi](https://hub.docker.com/r/amirelgammal/testapi) from Docker Hub.

5.  Get kubernetes resorces 

    ```bash
    kubectl get all --selector app=testapi3core
    ```
6. Port forward 
    ```bash
    kubectl port-forward service/testapirelease-service 9999:8888
    ```
7. Test the url
    ```bash
    curl http://localhost:9999/weatherforecast
    ```
8. Install Nginx
    
> Execute the commands from the Nginx folder.

1. Create service pod 
    ```bash
    kubectl apply -f service.yaml
    ```
2. Create deployment pod
    ```bash
    kubectl apply -f deployment.yaml
    ```
3. Port forward 
    ```bash
    kubectl port-forward service/nginx 8181:80
    ```
4. Test Url
    ```bash
    curl http://localhost:8181/static.jsoncast
    ```
# Azure DevOps pipeline build

![alt text](https://docs.microsoft.com/en-us/dotnet/architecture/containerized-lifecycle/docker-devops-workflow/media/docker-workflow-ci-cd-aks.png)
> Please puch this repo to github and azure-pipelines.yml will build, test, push the docker image to my docker hub.

> please go to Settings/Service connections* and add docker hub account to push the image to your docker hub.

___
All above steps are tested and working properly , Please let me know if you need any help or any changes.