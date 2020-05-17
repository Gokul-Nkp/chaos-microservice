# Firewall

When using a Service with `spec.type: LoadBalancer`, the firewall will be opened automatically. 

When using `spec.type: NodePort`, however, the firewall is not opened by default.

You can add a firewall with the gcloud command line tool:

gcloud compute firewall-rules create my-rule --allow=tcp:<port>
