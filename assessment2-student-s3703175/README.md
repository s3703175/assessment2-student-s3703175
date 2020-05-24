# Servian TechTestApp

### Terraform

This repository is going to deploy the golang todo app straight to the public internet.

The first step was to build to infrastructure with terraform.

To start with we have to create a VPC with 9 subnets (3 public, 3 private and 3 for the data) for high availability

The instance is going to placed in the private layer because we don't want to expose it to internet. The loadbalancer that is in the public layer is going to forward all the request to our private instance.
And then the database is going to be in the data layer for the same reason.

For testing purpose we put the key into the repository but create yours with this command bellow and read the public key into the terraform.tfvars
```bash
ssh-keygen -t rsa -b 2048 -h -C user-ec2 //key pair to access to instance
```

The instance is a linux empty instance with an AMI from AWS

The database is a PGSQL 9.6.16

The loadbalancer is an application loadbalancer

At the and of the terraform deployment, it will generate the ansible inventory automatically.

### Ansible

Into the ansible playbook we are going to make change on the instance that is comming from the inventory.

The playbook is going to :
 1. download the app
 2. unzip it
 3. change the config file
 4. create a service
 5. enable service at boot
 6. create/seed database
 7. start app
 
### Circle CI

Circle ci is part of the pipeline.
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

Then you can make a build on the branch and the CI will deploy the infrastructure store the state into the remote backend.

Then terraform is going to create an inventory with template file for ansible using terraform output.

And finally ansible is going to make change on the instance using the inventory and the ssh key that you create before. 

## cleanup instructions

If you want to destroy the all thing please do :
```bash
cd infra
terraform destroy -auto-approve //destroy the infra
cd remote
terraform destroy -auto-approve // destroy the backend
```
