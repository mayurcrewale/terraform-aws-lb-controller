module "irsa" {
  source = "git::git@github.com:mayurcrewale/terraform-aws-irsa.git?ref=v1.0.0"

  role_name            = "${var.cluster_name}-aws-lb-controller"
  oidc_provider_arn    = var.oidc_provider_arn
  oidc_provider_url    = var.oidc_provider_url
  namespace            = var.namespace
  service_account_name = var.service_account_name
  inline_policy_json   = file("${path.module}/iam-policy.json")
  tags                 = var.tags
}

locals {
  helm_values = {
    clusterName                                                 = var.cluster_name
    region                                                      = var.region
    vpcId                                                       = var.vpc_id
    replicaCount                                                = var.replica_count
    "serviceAccount.create"                                     = "true"
    "serviceAccount.name"                                       = var.service_account_name
    "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn" = module.irsa.role_arn
  }
}

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = var.chart_version
  namespace  = var.namespace

  dynamic "set" {
    for_each = local.helm_values
    content {
      name  = set.key
      value = set.value
    }
  }
}
