# Firewall-http

When using a Service with `spec.type: LoadBalancer`, the firewall will be opened automatically. 

When using `spec.type: NodePort`, however, the firewall is not opened by default.

You can add a firewall with the `gcloud` command line tool:

`gcloud compute firewall-rules create my-rule --allow=tcp:[port]`
##

`gcloud compute instances list`
##

https://cloud.google.com/kubernetes-engine/docs/how-to/exposing-apps

# Network-Chaos

Curl command to check network-abort

`while true; do curl -s [istio-ingressgateway IP] | grep -E "abort|description"; sleep 0.5; done`
