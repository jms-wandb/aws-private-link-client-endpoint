variable "endpoint_name" {
  description = "Name to use for the VPC Private Link Endpoint"
  type = string
  default = "wandb-client-side-private-link"
}

variable "destination_service_name" {
  description = "Service name from the Private Link endpoint we are connecting to."
  type = string
}

variable "subnet_ids" {
  description = "List of subnets the endpoint will exist in."
  type = list(string)
}

variable "vpc_id" {
  description = "VPC that the endpoint will be created in."
  type = string
}

variable "region" {
  description = "value"
  type = string
  default = "us-east-2"
}

variable "domain_name" {
  description = "DNS domain where the W&B Server lives."
  type = string
}

variable "subdomain" {
  description = "Subdomain of the W&B Server"
  type = string
}