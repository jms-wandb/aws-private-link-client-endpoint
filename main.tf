locals {
  endpoint_vpc_id = var.endpoint_vpc_id != null ? var.endpoint_vpc_id : null
}

resource "aws_vpc_endpoint" "primary" {
  service_name      = var.destination_service_name
  subnet_ids        = var.subnet_ids
  vpc_endpoint_type = "Interface"
  vpc_id            = local.endpoint_vpc_id

  security_group_ids = [
    aws_security_group.wandb_private_link_endpoint_sg.id,
  ]

  tags = {
    Name = var.endpoint_name
  }
}

resource "aws_route53_zone" "private" {
  name = var.domain_name

  vpc {
    vpc_id = local.endpoint_vpc_id
  }
}

resource "aws_route53_record" "wandb" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "${var.subdomain}.${var.domain_name}" 
  type    = "CNAME"
  ttl     = 300
  records = [aws_vpc_endpoint.primary.dns_entry[0].dns_name]
}

resource "aws_security_group" "wandb_private_link_endpoint_sg" {
  name        = "wandb_private_link_endpoint_sg"
  description = "Allow inbound traffic and outbound traffic to W&B Private Link"
  vpc_id      = local.endpoint_vpc_id

  tags = {
    Name = "wandb_private_link_endpoint_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_traffic_ipv4" {
  for_each = toset(var.allowed_inbound_cidrs)

  security_group_id = aws_security_group.wandb_private_link_endpoint_sg.id
  cidr_ipv4         = each.key
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  for_each = toset(var.allowed_outbound_cidrs)

  security_group_id = aws_security_group.wandb_private_link_endpoint_sg.id
  cidr_ipv4         = each.key
  ip_protocol       = "-1" # semantically equivalent to all ports
}