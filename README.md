# terraform-aws-lb-controller

Installs the [AWS Load Balancer Controller](https://kubernetes-sigs.github.io/aws-load-balancer-controller/)
via the Terraform `helm` provider, with its own IRSA role carrying the
official controller IAM policy (`iam-policy.json`).

Depends on [`terraform-aws-irsa`](../terraform-aws-irsa) — see `main.tf`.

## Usage

```hcl
module "lb_controller" {
  source = "git::https://example.com/your-org/terraform-aws-lb-controller.git?ref=v1.0.0"

  cluster_name      = module.eks_cluster.cluster_name
  region            = "eu-west-1"
  vpc_id            = "vpc-xxxxxxxx"
  oidc_provider_arn = module.eks_cluster.oidc_provider_arn
  oidc_provider_url = module.eks_cluster.oidc_provider_url
}
```

Requires the `helm` provider (pinned `~> 2.12` — v3 changed the `set` block
syntax used here) configured against the target cluster at the root module.

Check `variables.tf`'s `chart_version` and `iam-policy.json` against the
[eks-charts releases](https://github.com/aws/eks-charts) before using a
controller/chart version newer than what's pinned here.
