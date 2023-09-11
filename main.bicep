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
param linuxAdminUsername string = 'xxxxxx'

@description('Configure all linux machines with the SSH RSA public key string. Your key should include three parts, for example \'ssh-rsa AAAAB...snip...UcyupgH azureuser@linuxvm\'')
param sshRSAPublicKey string = 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8vNU1ADsyU+FJ9+pIjPYx0f+p9B4pRmYaEP2EV/4KhUXUm0+MRMGuoEc80y7bcg1P0qw60l+75mLFFbQRDUYuRUqGRE8sgytf+7kORQv6Y2ZnC6/2J7inIeFFJu1cRyczAbgJ9F7VRqLeOAHB+qbG4eO1opV4vwyJ/jRSlRtofoIQGFofePcmr94gqHAsIcfqeKqL7QJFwEW80WTm4vY6PGWMQWJ0J8hKwfevtycLwcpASnI9f1p4LGeIGC1crvR74Sg6jdSeFMSDiliqlt8O8bXAVaIK35UrUrU8CsBsfoxcC6r7Wk8gUAlgHJKMcZFAqwUjJHHrISiU/+CPcwRn0VnTq7/WyIHJ6PU9UMOBHRq6MFUDTrh2JX1xDjEUMN5FO/VD7K0qXNJzLAt3j6Dy6HDg9HF3f7nCDlbmhWbpVJEtmNi4eR208p5iyC+iTGp3gQ+JhLh3a9Zx5Kra5UfB7K3mAiy/nMEZ5xEwSIKFR/h9bCsPp4KbTGMRGMiKrgU= generated-by-azure'

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
