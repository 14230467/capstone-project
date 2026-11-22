locals {
  project_name = "gitops-infra-deployment"
  environment  = "production"
}

output "deployment_name" {
  value = local.project_name
}

output "environment" {
  value = local.environment
}