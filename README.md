## Summary

This module can be used to spin up the client side Private Link Endpoint to connect to the W&B Server side Private Link Endpoint Service.

## Requirements
You will need to have Terraform v1.10.0 or greater installed to use this module.

This module also requires that the Private Link Endpoint and Endpoint service is configured in the account where the W&B server is deployed.

To enable the Private Link on a Dedicated Deployment or Customer Managed deployment that is utilizing the W&B Terraform AWS module, you will need to populate the [private_link_allowed_account_ids](https://github.com/wandb/terraform-aws-wandb/blob/main/variables.tf#L289-L293) variable with the AWS account ID that you need to connect from via the Private Link. This will configure the addtional resources needed to enable Private Link on the W&B Server side.

## Variables

| Name | Description | Required |
| :-------: | :------: | :------:|
| endpoint_name | Name to use for the VPC Private Link Endpoint | No |
| destination_service_name | Service name from the Private Link endpoint we are connecting to. | Yes |
| subnet_ids | List of subnets the endpoint will exist in | Yes |
| endpoint_vpc_id | VPC that the endpoint will be created in. | Yes |
| region | AWS region to deploy the resources in. | Yes |
| domain_name | DNS domain of the W&B Server. | Yes |
| subdomain | Subdomain of the W&B Server | Yes |

## Usage

To use this module you will need to clone it locally and create a `terraform.tfvars` file to set the required variables.

Once you have defined the values for your variables you will run the following commands

- `terraform init`
- `terraform plan`
- `terraform apply`