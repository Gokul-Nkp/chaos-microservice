# Chaos-Microservice
Chaos Engineering on microservice application

https://github.com/microservices-demo/microservices-demo
##
## Pre-requisites
Create a Kubernetes linux cluster. For instance, see these examples:
AWS - KOPS

Azure - Azure Container Service

Google Cloud - Google Container Engine

Install and configure kubectl to connect to the cluster
## Deploy Sock Shop
Clone the microservices-demo repository
Go to the deploy/kubernetes folder

kubectl create namespace sock-shop

kubectl apply -f complete-demo.yaml
##
https://docs.chaostoolkit.org/reference/usage/install/
##
