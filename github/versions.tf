terraform {
  required_version = ">= 1.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 5.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = ">= 0.7"
    }
  }
}
