provider "aws" {
  region = var.aws_region
}

# Find the default VPC
data "aws_vpc" "default" {
  default = true
}

# Find public subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Find the Project 15 web server
data "aws_instance" "webserver" {
  filter {
    name   = "tag:Name"
    values = ["Ansible-Managed-Node"]
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }
}


# Find the existing Managed Node security group
data "aws_security_group" "managed_node" {
  name   = "ansible-managed-node-sg"
  vpc_id = data.aws_vpc.default.id
}

# Route 53 hosted zone
data "aws_route53_zone" "domain" {
  name         = var.domain_name
  private_zone = false
}

# ALB Security Group
resource "aws_security_group" "alb_sg" {
  name        = "project16-alb-sg"
  description = "Allow HTTPS traffic to ALB"
  vpc_id      = data.aws_vpc.default.id

  # HTTPS from public internet
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # No public HTTP ingress on port 80

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Project16-ALB-SG"
  }
}

# Allow HTTP only from ALB to EC2
resource "aws_security_group_rule" "alb_to_webserver" {
  type                     = "ingress"
  security_group_id        = data.aws_security_group.managed_node.id
  source_security_group_id = aws_security_group.alb_sg.id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  description = "HTTP only from ALB"
}

# ACM Certificate
resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  subject_alternative_names = [
    "www.${var.domain_name}"
  ]

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Project16-HTTPS-Certificate"
  }
}

# DNS Validation Records
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = data.aws_route53_zone.domain.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

# Validate the certificate
resource "aws_acm_certificate_validation" "cert" {
  certificate_arn = aws_acm_certificate.cert.arn

  validation_record_fqdns = [
    for record in aws_route53_record.cert_validation :
    record.fqdn
  ]
}

# Application Load Balancer
resource "aws_lb" "app" {
  name               = "project16-https-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = data.aws_subnets.default.ids

  tags = {
    Name = "Project16-HTTPS-ALB"
  }
}

# Target Group
resource "aws_lb_target_group" "web" {
  name        = "project16-web-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.default.id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Name = "Project16-Web-TG"
  }
}

# Attach EC2 to Target Group
resource "aws_lb_target_group_attachment" "web" {
  target_group_arn = aws_lb_target_group.web.arn
  target_id        = data.aws_instance.webserver.id
  port             = 80
}

# HTTPS Listener
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.app.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate_validation.cert.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

# Route 53 record for domain
resource "aws_route53_record" "website" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_lb.app.dns_name
    zone_id                = aws_lb.app.zone_id
    evaluate_target_health = true
  }
}

# Route 53 record for www
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.app.dns_name
    zone_id                = aws_lb.app.zone_id
    evaluate_target_health = true
  }
}