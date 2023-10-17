### initialize

    terraform init

### preview terraform actions

    terraform plan

### executes the actions proposed in a terraform plan without confirmation

    terraform apply -auto-approve

### connect to kubernetes

    aws eks update-kubeconfig --name fleetman --region eu-west-2

### verify 

    kubectl get storageclass 

    kubectl apply -f ebs-example

    kubectl get pvc 

You should see **Bound** state after that

