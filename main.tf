locals {
  endpoint_vpc_id = var.endpoint_vpc_id != null ? var.endpoint_vpc_id : null
}

resource "aws_vpc_endpoint" "primary" {
  service_name      = var.destination_service_name
  subnet_ids        = var.subnet_ids
  vpc_endpoint_type = "Interface"
  vpc_id            = local.endpoint_vpc_id

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