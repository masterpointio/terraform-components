locals {
  gh_token         = try(local.secrets[var.gh_token_secret_name], "")
  gh_token_enabled = length(local.gh_token) > 0 ? true : false

  gh_app_auth_id_enabled              = length(var.gh_app_auth_id) > 0 ? true : false
  gh_app_auth_installation_id_enabled = length(var.gh_app_auth_installation_id) > 0 ? true : false
  gh_app_auth_pem_file                = try(local.secrets[var.gh_app_auth_pem_file_secret_name], "")
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
