locals {
  gh_token         = try(local.secrets[var.gh_token_secret_name], "")
  gh_token_enabled = length(local.gh_token) > 0 ? true : false

  gh_app_auth_id_enabled              = length(var.gh_app_auth_id) > 0 ? true : false
  gh_app_auth_installation_id_enabled = length(var.gh_app_auth_installation_id) > 0 ? true : false
  gh_app_auth_pem_file                = try(local.secrets["${var.gh_app_auth_pem_file_secret_name}"], "")
  gh_app_auth_pem_file_enabled        = length(local.gh_app_auth_pem_file) > 0 ? true : false
  gh_app_auth_enabled                 = alltrue([local.gh_app_auth_id_enabled, local.gh_app_auth_installation_id_enabled, local.gh_app_auth_pem_file_enabled])
}

# The GitHub provider offers multiple ways to authenticate with GitHub API:
# - GitHub CLI
# - OAuth / Personal Access Token
# - GitHub App Installation
#
# When none configuration is provided, the provider can only access resources available anonymously.
provider "github" {
  base_url = var.gh_base_url
  owner    = var.gh_owner

  token = local.gh_token_enabled ? local.gh_token : null

  dynamic "app_auth" {
    for_each = local.gh_app_auth_enabled ? ["app_auth"] : []
    content {
      id              = var.gh_app_auth_id
      installation_id = var.gh_app_auth_installation_id
      pem_file        = local.gh_app_auth_pem_file
    }
  }
}

variable "gh_app_auth_id" {
  type        = string
  description = "The ID of the GitHub App."
  default     = ""
}

variable "gh_app_auth_installation_id" {
  type        = string
  description = "The ID of the GitHub App installation"
  default     = ""
}

variable "gh_app_auth_pem_file_secret_name" {
  type        = string
  description = <<-EOF
    The name of the secret retrieved by secrets mixin that contains
    the contents of the GitHub App private key PEM file.
  EOF
  default     = null
}

variable "gh_base_url" {
  type        = string
  description = <<-EOF
    (Optional) This is the target GitHub base API endpoint.
    Providing a value is a requirement when working with GitHub Enterprise.
    It is optional to provide this value and it can also be sourced from the GITHUB_BASE_URL environment variable.
    The value must end with a slash, for example: https://terraformtesting-ghe.westus.cloudapp.azure.com/
  EOF
  default     = null
}

variable "gh_owner" {
  type        = string
  description = <<-EOF
    (Optional) This is the target GitHub organization or individual user account to manage.
    For example, `torvalds` and `github` are valid owners. It is optional to provide this value
    and it can also be sourced from the GITHUB_OWNER environment variable.
    When not provided and a token is available, the individual user account owning the token will be used.
    When not provided and no token is available, the provider may not function correctly.
  EOF
  default     = null
}

variable "gh_token_secret_name" {
  type        = string
  description = <<-EOF
    The name of the secret retrieved by secrets mixin that contains the GitHub personal access token.
  EOF
  default     = null
}