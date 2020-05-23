##########################################
# Setting Up Chaos Toolkit In Kubernetes #
##########################################

# NOTE: We could create a ConfigMap through a command and include all the files.

# :: Create Configmap :: #

kubectl apply -f configmap.yaml -n sock-shop

kubectl describe configmap chaostoolkit-experiments -n sock-shop

# :: Create ServiceAccount with Roles [ with required Permissions] :: #

kubectl apply -f serviceaccount.yaml -n sock-shop

########################
# Running Experiments #
########################

# :: Create Job which runs chaos experiments :: #

kubectl apply -f job.yaml -n sock-shop

# :: View the pod created by job :: #

kubectl get pods -n sock-shop --selector app=sock-shop-chaos

kubectl get pods -n sock-shop

    # When `STATUS` is `Completed`, the job gets completed.

# :: Check logs :: #

kubectl logs -n sock-shop --selector app=sock-shop-chaos --tail -1

# :: Delete job :: #

kubectl delete -f job.yaml -n sock-shop

#################################
# Running Scheduled Experiments #
#################################

# :: Create cronjob with schedule timing and job description :: #

kubectl apply -f cronjob.yaml -n sock-shop

# :: View Cronjob and Job :: #

kubectl get cronjobs -n sock-shop

    # Repeat the previous command until `LAST SCHEDULE` is NOT `<none>`

kubectl get jobs -n sock-shop

    # Repeat the previous command until `COMPLETIONS` is `1/1`

kubectl get pods -n sock-shop
