######################
# Create The Cluster #
######################

gcloud auth login

# Open https://console.cloud.google.com/cloud-resource-manager to create a new project if you don't have one already

export PROJECT_ID=[...] # Replace [...] with the ID of the project

gcloud container get-server-config \
    --region us-east1

export VERSION=[...] # Replace [...] with k8s version from the `validMasterVersions` section. Make sure that it is v1.14+.

gcloud container clusters \
    create chaos \
    --project $PROJECT_ID \
    --cluster-version $VERSION \
    --region us-east1 \
    --machine-type n1-standard-2 \
    --enable-autoscaling \
    --num-nodes 1 \
    --max-nodes 3 \
    --min-nodes 1

kubectl create clusterrolebinding \
    cluster-admin-binding \
    --clusterrole cluster-admin \
    --user $(gcloud config get-value account)

#################
# Install Istio #
#################

istioctl manifest apply --skip-confirmation

export INGRESS_HOST=$(kubectl \
    --namespace istio-system \
    get service istio-ingressgateway \
    --output jsonpath="{.status.loadBalancer.ingress[0].ip}")

echo $INGRESS_HOST

# Repeat the `export` command if the output of the `echo` command is empty

#####################
# Deploying The App #
#####################

kubectl create namespace sock-shop

kubectl label namespace sock-shop istio-injection=enabled

## After labelling the namespace , deploy the app and the gateway in the namespace ##

##############################
# Destroying What We Created #
##############################

kubectl delete namespace sock-shop

#######################
# Destroy the cluster #
#######################

gcloud container clusters \
    delete chaos \
    --region us-east1 \
    --quiet
