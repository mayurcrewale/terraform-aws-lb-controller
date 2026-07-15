output "iam_role_arn" {
  value = module.irsa.role_arn
}

output "service_account_name" {
  value = var.service_account_name
}

output "namespace" {
  value = var.namespace
}

output "helm_release_status" {
  value = helm_release.aws_load_balancer_controller.status
}
