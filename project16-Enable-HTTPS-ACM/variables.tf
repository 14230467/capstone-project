variable "aws_region" {
    default = "ap_south_1"
}

variable "domain_name" {
    description = "Domain name registered and hosted in Route 53"
    type = string
}