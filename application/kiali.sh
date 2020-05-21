### Before installing Istio, we need to create a Secret for Kiali ###

## Create variables for username , passphrase and namespace ##

KIALI_USERNAME=$(read -p 'Kiali Username: ' uval && echo -n $uval | base64)   # Enter Username

KIALI_PASSPHRASE=$(read -sp 'Kiali Passphrase: ' pval && echo -n $pval | base64)   # Enter Passphrase

NAMESPACE=istio-system

## Create a namespace ##

kubectl create namespace $NAMESPACE

## Create a Secret with the variables ##

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

## Install Istio and Kiali ##

istioctl manifest apply --set values.kiali.enabled=true --skip-confirmation

### Deploy your application after installing Istio and Kiali ###

## Run Kiali ##

istioctl dashboard kiali

### Click on the URL and login using the entered username and passphrase ###
