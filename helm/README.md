## Moon Helm Chart

## Deployment on Minikube

It is ease to deploy free (limited up to 4 parallel session) version of Moon to minikube for local development and testing. Follow these simple steps to get enterprise solution for Selenium testing on your laptop.

1) Install [Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)
2) Start local cluster
```
$ minikube start --cpus=4 --memory=8Gi
```
3) Enable ingress addon
```
$ minikube addons enable ingress
```
4) Install [Helm](https://github.com/helm/helm/releases)
5) Initialize helm on cluster
```
$ helm init
```
5) Clone repository and change directory to helm chart
```
$ git clone https://github.com/aerokube/moon-deploy.git
$ cd moon-deploy/helm
```
6) Add Minikube ip address to /etc/hosts with domain name that will be used as ingress.host
```
$ sudo bash -c "echo $(minikube ip) moon.example.com >> /etc/hosts"
```
7) And finally deploy Moon helm chart
```
$ helm upgrade moon . --install --namespace=moon --set replicaCount=2 --set service.externalIPs={$(minikube ip)} --set ingress.host=moon.example.com
```

Now you are able to run tests using this url:
```
http://moon.example.com:4444/wd/hub
```
And also you have access to web interface by this url:
```
http://moon.example.com
```

Any time you want to upgrade Moon, just modify any values in values.yaml and invoke the same command:
```
$ helm upgrade moon . --install --namespace=moon --set replicaCount=2 --set service.externalIPs={$(minikube ip)} --set ingress.host=moon.example.com
```

