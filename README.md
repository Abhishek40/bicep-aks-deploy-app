## bicep-aks-deploy-app
## This is test application to deploy on Azure AKS
```t
# Create an SSH key pair using Azure CLI
az sshkey create --name "aksDemoSSH" --resource-group "k8sRG"

```

## Run Bicep file
```t
az deployment group create --resource-group aks-k8s-rg --template-file main.bicep --parameters dnsPrefix=aksCluster21 linuxAdminUsername=azureUser21 sshRSAPublicKey='xxx'
```

## Deploy application on Azure using kubectl
```t
az aks get-credentials --resource-group k8sRG --name aks21cluster
kubectl get nodes

kubectl apply -f azure-vote.yaml
```

## AZ Login
```t
az login --tenant <TenantID>
az group delete --name k8sRG --yes --no-wait
```
## Reference Link
```t
https://learn.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-bicep?tabs=azure-cli
```