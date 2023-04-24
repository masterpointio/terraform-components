locals {
  aws_account_id = module.account.outputs.full_account_map[var.stage]
  assume_role    = format("arn:aws:iam::${local.aws_account_id}:role/${var.namespace}-${var.stage}-%s", var.run_in_cicd ? "terraform" : "admin")
}

variable "run_in_cicd" {
  type        = bool
  description = "If run in CI/CD platform, use terraform delegated role, otherwise use admin."
  default     = true
}

variable "assume_role_override" {
  type        = string
  description = "Overrides the assumed role for the AWS provider. Useful for local testing and imports."
  default     = null
}

variable "region" {
  type        = string
  description = "AWS region."
}

variable "tailnet" {
  type        = string
  description = "The Tailnet to perform actions in."
}

module "account" {
  source  = "cloudposse/stack-config/yaml//modules/remote-state"
  version = "0.22.3"

  component = "account-map"
  stage     = "root"

  context = module.this.context
}


provider "aws" {
  region = var.region

  assume_role {
    role_arn     = coalesce(var.assume_role_override, local.assume_role)
    session_name = var.run_in_cicd ? "cicd-terraform" : "local-admin"
    external_id  = "terraform"
  }
}

provider "tailscale" {
  tailnet             = var.tailnet
  oauth_client_id     = local.secrets.tailscale_oauth_client_id
  oauth_client_secret = local.secrets.tailscale_oauth_client_secret
}
