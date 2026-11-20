locals {
    project_name = "terraform-plan-demo"
}

output "'project_name" {
    value = local.project_name
}