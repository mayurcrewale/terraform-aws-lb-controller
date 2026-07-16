# terraform-aws-lb-controller

Installs the [AWS Load Balancer Controller](https://kubernetes-sigs.github.io/aws-load-balancer-controller/)
via the Terraform `helm` provider, with its own IRSA role carrying the
official controller IAM policy (`iam-policy.json`).

Depends on [`terraform-aws-irsa`](https://github.com/mayurcrewale/terraform-aws-irsa) — see `main.tf`.

## Usage

```hcl
module "lb_controller" {
  source = "git::https://github.com/mayurcrewale/terraform-aws-lb-controller.git?ref=v1.0.0"

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

## CI / Releasing

[`.github/workflows/terraform-ci.yml`](.github/workflows/terraform-ci.yml)
runs `terraform fmt -check` + `terraform init` + `terraform validate` on
every push to `main` and every pull request.

To cut a new release tag: **Actions** tab → **Terraform CI** → **Run
workflow** → pick `patch`/`minor`/`major` from the `bump` dropdown (leave as
`none` for a validate-only run). It reads the latest `vX.Y.Z` tag, bumps it,
and pushes the new tag — using the workflow's built-in `GITHUB_TOKEN`, no
extra credentials to set up. Consumers pin to that tag via `?ref=vX.Y.Z` in
their `source` — see **Usage** above.
