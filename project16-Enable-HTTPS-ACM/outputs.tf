output "alb_dns_name" {
 value = aws_lb.app.dns_name
}

output "https_website" {
 value = "https://${var.domain_name}"
}

output "https_www" {
 value = "https://www.${var.domain_name}"
}

output "acm_certificate_arn" {
 value = aws_acm_certificate.cert.arn
}

output "target_group_arn" {
 value = aws_lb_target_group.web.arn
}