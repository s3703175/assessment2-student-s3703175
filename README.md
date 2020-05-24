# Servian TechTestApp

### Terraform

This repository will be deploying the golang todo app to the public via the internet.

To begin, we will be using terraform to build the infrastructure. A VPC with 3 public subnets, 3 private, and 3 data for a better availablity is to be created as well.

The instance will be placed in the private layer as exposure to the internet is not desired at the current stage. All the requests to the private instance will be forwarded by the load balancer in the public layer. After which, the database will be put in the data layer.

We will be putting the key into the repository for training purposes, but the user can create theirs with the below command: 
```bash
ssh-keygen -t rsa -b 2048 -h -C user-ec2 //key pair to access to instance
```

And then read the public key into the terraform.tfvars.

The instance is a linux empty instance with an AMI from AWS.

The database is a PGSQL 9.6.16

The loadbalancer is an application loadbalancer. At the end of the terraform deployment, thye ansible inventory will be automatically generated.

### Ansible

We will be going to make the change on the instance coming from the inventory into the Ansible playbook.

The playbook will :
 1. download the app
 2. unzip the folder
 3. change the config file
 4. create a service
 5. enable service at boot
 6. create/seed database
 7. start app
 
### Circle CI

Circle CI is part of the pipeline.
It will apply change on the terraform infrastructure and use the ansible script the make change against the instance.

## dependencies

For this one we are using Terraform 0.12.21 with the aws provider 2.8 and Ansible 2.9.7

## deploy instructions

### Terraform

1. cd infra/remote
2. terraform init
3. terraform apply-auto-approve

Those command will be used to build the remote backend with s3 and a dynamodb table used to store the statefile and lock it when it is used

### Circle CI

On circle ci please add project environment variable such as :
```bash
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_SESSION_TOKEN
```

After this, the user can make a build on the branch, then the CI will be deploying the infrastructure store, as well as the state towards the remote backend. Afterwards Terraform will create inventory with template file for Ansible using the output from Terraform, then Terraform will be creating an inventory using the template file for Ansible.

Lastly, Ansible will be making a change on the instance with the use of the ssh key and the inventory that was previously created.

##  instructions for cleanup

If you want to destroy the all thing please do :
```bash
cd infra
terraform destroy -auto-approve //destroy the infra
cd remote
terraform destroy -auto-approve // destroy the backend
```
