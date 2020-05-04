This to build and deploy into k8s cluster a distributed web api application

# Prerequisites

- Docker
- k8s Minikube
- DockerHub access (or any other service that allows to store images)- Azure DevOps access (optional)
- Helm https://helm.sh/docs/intro/install/ 

> Execute the commands from the TestApi folder.

1. Build Docker image localy
    ```bash
    docker image build --pull -t webapi:v1 .
    ```
2. Run & test the image 
    ```bash
    docker run --rm -it -p 5000:80 webapi:v1
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
4. create new namespace 
    ```bash
    kubectl create ns ame
    ```

5. Install via Helm
    ```bash
    helm install -name webapi ./chart/
    ```
    The Kubernetes deployment will use image [amirelgammal/webapi] & [amirelgammal/nginx ](https://hub.docker.com/r/amirelgammal/ & (https://hub.docker.com/r/amirelgammal/nginx) from Docker Hub.

6. change defualt name space 
    ```bash
    kubectl config set-context --current --namespace=ame
    ```

7.  Get kubernetes resorces 

    ```bash
    kubectl get all --selector app=testapi3core
    ```
8. Port forward 
    ```bash
    kubectl port-forward service/testapirelease-service 9999:8888
    ```
9. Test the url
    ```bash
    curl http://localhost:9999/weatherforecast
    ```
    

# Azure DevOps pipeline build

![alt text](https://docs.microsoft.com/en-us/dotnet/architecture/containerized-lifecycle/docker-devops-workflow/media/docker-workflow-ci-cd-aks.png)
> Please puch this repo to github and azure-pipelines.yml will build, test, push the docker image to my docker hub.

> please go to Settings/Service connections* and add docker hub account to push the image to your docker hub.

___
All above steps are tested and working properly , Please let me know if you need any help or any changes.
