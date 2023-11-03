# Introduction 
Create infrastructure on Azure (Azure Function App) and deploy Azure Functions written in typescript

# Getting Started
## Run:
### "az login" and note the id and the name of the subscription.
### "az account set --subscription <SUBSCRIPTION_ID>"
### "az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>" and note the output

## Set the following variables according to the previous last command:
### ARM_CLIENT_ID = "<APPID_VALUE>"
### ARM_CLIENT_SECRET = "<PASSWORD_VALUE>"
### ARM_SUBSCRIPTION_ID = "<SUBSCRIPTION_ID>"
### ARM_TENANT_ID = "<TENANT_VALUE>"

## Inside the Terraform folder run the following commands:
### terraform init
### terraform fmt
### terraform validate
### terraform apply

# Build and Test
TODO: Describe and show how to build your code and run the tests. 

# Contribute
TODO: Explain how other users and developers can contribute to make your code better. 

