# TF-Smart1Cloud

Automatically deploy a gateway in Azure and connect it to Check Point Smart1 Cloud


## Prerequisites
Smart 1 Cloud Tenant:

[Check Point Infinity Portal] (https://portal.checkpoint.com)

Terraform

Azure CLI

## Usage:

Clone the repository

```hcl
https://github.com/metalstormbass/TF-Smart1Cloud.git
```

Ensure that you have Azure CLI installed. Once installed run the following commands in Powershell.

This logs into the Azure Tenant:

```hcl
az login
```

Accept the licensing agreement:

```hcl
az vm image terms accept --urn checkpoint:check-point-cg-r8040:sg-byol:latest
```

Edit the variables as required. Review terraform.tfvars and vuln_bootstrap.sh

terraform.tfvars

```hcl
company = "MikeNet"

gw-network-vnet-cidr = "10.10.0.0/16"
gw-network-subnet-cidr = "10.10.0.0/24"
gw-network-internal-subnet-cidr = "10.10.1.0/24"

vm-network-vnet-cidr = "10.30.0.0/16"
vm-network-subnet-cidr = "10.30.0.0/24"

environment = "Staging"

username = "mike"
password = "Vpn123vpn123!"

#This is for future use.
sic_key ="Vpn123vpn123"
```




Edit gw-bootstrap.sh and insert you Smart1 Cloud Token

```hcl
#Variables
sicKey="INSERT SIC KEY HERE"
token="INSERT TOKEN HERE"
```


Run the following commands in Terraform:

```hcl
terraform init
```

then:

```hcl
terraform apply
```

Finally, wait until Terraform has completed. Then wait an addtional 5-10 mins for the VM to complete bootstrapping.



To destroy, you need to run:

```hcl
terraform destroy
```

## Issues:

At this point, sometimes you need to run the destroy  command several (~3) times for the environment to be completely removed. This appears to be a bug in the dependency handling within Terraform.