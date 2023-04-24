terraform {
  required_version = "~> 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = "~> 0.5"
    }
    tailscale = {
      source  = "tailscale/tailscale"
      version = "~> 0.13.7"
    }
  }
}
