# bicep-aks-deploy-app
## This is test application to deploy on Azure AKS
```t
# Create an SSH key pair using Azure CLI
az sshkey create --name "aksDemoSSH" --resource-group "aksTestRG"

```

##Run Bicep file
az deployment group create --resource-group aks-k8s-rg --template-file main.bicep --parameters dnsPrefix=aksCluster21 linuxAdminUsername=azureUser21 sshRSAPublicKey='C:\Users\B714668\.ssh\id_rsa.pub'

az aks get-credentials --resource-group aksTestRG --name aks21cluster
kubectl get nodes

kubectl apply -f azure-vote.yaml
