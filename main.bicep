@description('The name of the managed cluster')
param ClusterName string = 'aks21cluster'

@description('The location where resources should be created')
param location string = resourceGroup().location

@description('Optional DNS prefix to use with hosted Kubernetes API server FQDN.')
param dnsPrefix string = 'aksCluster21'

@description('Disk size (in GB) to provision for each of the agent pool nodes. This value ranges from 0 to 1023. Specifying 0 will apply the default disk size for that agentVMSize.')
@minValue(0)
@maxValue(1023)
param osDiskSizeGB int = 0

@description('Number of nodes for the cluster')
@minValue(1)
@maxValue(50)
param agentCount int = 1

@description('Size of virtual machine')
param agentVMSize string = 'standard_d2s_v3'

@description('The user name for the linux virtual machine')
param linuxAdminUsername string = 'azureUser21'

@description('Configure all linux machines with the SSH RSA public key string. Your key should include three parts, for example \'ssh-rsa AAAAB...snip...UcyupgH azureuser@linuxvm\'')
param sshRSAPublicKey string = 'xxxxxxxxx'

resource aks 'Microsoft.ContainerService/managedClusters@2023-06-01' = {
  name: ClusterName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: dnsPrefix
    agentPoolProfiles: [
      {
        name: 'agentpool'
        osDiskSizeGB: osDiskSizeGB
        count: agentCount
        vmSize: agentVMSize
        osType: 'Linux'
        mode: 'System'
      }
    ]
    linuxProfile: {
      adminUsername: linuxAdminUsername
      ssh: {
        publicKeys: [
          {
            keyData: sshRSAPublicKey
          }
        ]
      }
    }
  }
}
output controlPlaneFQDN string = aks.properties.fqdn
