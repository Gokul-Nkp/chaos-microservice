### Before installing Istio, we need to create a Secret for Kiali ###

## Create variables for username , passphrase and namespace ##

KIALI_USERNAME=$(read -p 'Kiali Username: ' uval && echo -n $uval | base64)   # Enter Username

KIALI_PASSPHRASE=$(read -sp 'Kiali Passphrase: ' pval && echo -n $pval | base64)   # Enter Passphrase

NAMESPACE=istio-system

## Create a namespace ##

kubectl create namespace $NAMESPACE

## Create a Secret with the variables ##
# Works fine with "VERSION=1.15.11-gke.13" in the 'validMasterVersions' #

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: kiali
  namespace: $NAMESPACE
  labels:
    app: kiali
type: Opaque
data:
  username: $KIALI_USERNAME
  passphrase: $KIALI_PASSPHRASE
EOF

## Download Istio and set PATH (Refer: https://istio.io/docs/setup/getting-started/#download) ##

## Install Istio, Kiali, Grafana ##

istioctl manifest apply --set values.kiali.enabled=true --set values.grafana.enabled=true --skip-confirmation 

## Check whether the services kiali, prometheus, grafana are running ##

kubectl get svc -n istio-system

### Deploy your application after installing Istio, Kiali, Grafana ###

## Run Kiali ##

istioctl dashboard kiali

### Click on the URL and login using the entered username and passphrase ###

## Run Grafana ##

istioctl dashboard grafana

### Click on the URL ###
