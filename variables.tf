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

variable "endpoint_vpc_id" {
  description = "VPC that the endpoint will be created in."
  type = string
}

variable "region" {
  description = "AWS region to deploy the resources in."
  type = string
}

variable "domain_name" {
  description = "DNS domain of the W&B Server."
  type = string
}

variable "subdomain" {
  description = "Subdomain of the W&B Server"
  type = string
}

variable "allowed_inbound_cidrs" {
  description = "List of allowed inbound IPv4 CIDRs"
  type =  list(string)
  default= [ "0.0.0.0/0" ] 
}

variable "allowed_outbound_cidrs" {
  description = "List of allowed outbound IPv4 CIDRs"
  type =  list(string)
  default= [ "0.0.0.0/0" ] 
}