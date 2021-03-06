# Docker NodeJS Example with Docker EE 2.0

### Prerequisites

* Docker EE 2.0
  * 17.06.3-ee-8 Docker Enterprise Engine
  * UCP 3.0.0
  * DTR 2.5.0

### Setup UCP and DTR

Set up UCP and DTR per instructions found here: https://github.com/yongshin/vagrant-docker-ee-ubuntu.

### Create DTR repo

```
engineering/docker-node-app
```

### Build Docker Image
```  
export DTR_IPADDR=dtr.local

git clone git@github.com:yongshin/docker-node-app.git
cd ~/docker-node-app
docker build -t $DTR_IPADDR/engineering/docker-node-app .
docker push $DTR_IPADDR/engineering/docker-node-app
```

### Start Example Application


#### Swarm Mode
The following stack command brings up two Swarm mode services and deploys it with Interlock enabled. Make sure you have the Routing Mesh enabled inside of UCP before deploying.

```
# Source client bundle
docker stack deploy -c deploy/swarm/docker-compose.yml nodeapp
```

#### Kubernetes
```
# Source client bundle
kubectl apply -f deploy/k8s/nodeapp-demo.yaml
```

### Stop all

#### Swarm Mode
This removes the entire stack including services
```
docker stack rm nodeapp
```

#### Kubernetes
This removes all of the K8S resources
```
kubectl delete -f deploy/k8s/nodeapp-demo.yaml
```

### Run app locally for development purposes on Docker CE

This does not utilize Interlock and mainly leverages the internal Swarm Routing Mesh.

```
docker build -t yongshin/docker-node-app .
docker stack deploy -c deploy/swarm/docker-compose-local.yml nodeapp
```
