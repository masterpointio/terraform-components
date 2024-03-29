#######################
# GitHub repositories #
#######################
variable "repos" {
  description = "The GitHub repositories for this organization."
  default     = {}
  type = map(object({
    # Main Resource Configuration
    # https://github.com/mineiros-io/terraform-github-repository/tree/main#main-resource-configuration
    allow_auto_merge       = optional(bool, false)
    allow_merge_commit     = optional(bool, false)
    allow_rebase_merge     = optional(bool, false)
    allow_squash_merge     = optional(bool, true)
    archive_on_destroy     = optional(bool, true)
    archived               = optional(bool, false)
    default_branch         = optional(string, "main")
    delete_branch_on_merge = optional(bool, true)
    description            = optional(string, "")
    extra_topics           = optional(list(string), [])
    has_downloads          = optional(bool, true)
    has_issues             = optional(bool, true)
    has_projects           = optional(bool, true)
    has_wiki               = optional(bool, false)
    homepage_url           = optional(string, "")
    is_template            = optional(bool, false)
    pages = optional(object({
      branch = string
      cname  = optional(string, null)
      path   = optional(string, "/")
    }))
    topics               = optional(list(string), [])
    visibility           = optional(string, "private")
    vulnerability_alerts = optional(bool, true)

    # Extended Resource Configuration

    ## Repository Creation Configuration
    # https://github.com/mineiros-io/terraform-github-repository/tree/main#repository-creation-configuration
    auto_init          = optional(bool, true)
    gitignore_template = optional(string, "")
    license_template   = optional(string, "")
    template = optional(object({
      owner      = string
      repository = string
    }))

    ## Teams Configuration
    # https://github.com/mineiros-io/terraform-github-repository/tree/main#teams-configuration
    admin_teams    = optional(list(string), [])
    maintain_teams = optional(list(string), [])
    pull_teams     = optional(list(string), [])
    push_teams     = optional(list(string), [])
    triage_teams   = optional(list(string), [])

    ## Collaborator Configuration
    # https://github.com/mineiros-io/terraform-github-repository/tree/main#collaborator-configuration
    admin_collaborators    = optional(list(string), [])
    maintain_collaborators = optional(list(string), [])
    pull_collaborators     = optional(list(string), [])
    push_collaborators     = optional(list(string), [])
    triage_collaborators   = optional(list(string), [])

    ## Branches Configuration
    # https://github.com/mineiros-io/terraform-github-repository/tree/main#branches-configuration
    branches = optional(list(object({
      name          = string
      source_branch = optional(string, null)
      source_sha    = optional(bool, null)
    })), [])

    ## Deploy Keys Configuration
    # https://github.com/mineiros-io/terraform-github-repository/tree/main#deploy-keys-configuration
    deploy_keys = optional(list(object({
      id        = optional(string, "md5(key)")
      key       = string
      read_only = optional(bool, true)
      title     = optional(string, null)
    })), [])
    deploy_keys_computed = optional(list(object({
      id        = optional(string, "md5(key)")
      key       = string
      read_only = optional(bool, true)
      title     = optional(string, null)
    })), [])

    ## Branch Protections v4 Configuration
    # https://github.com/mineiros-io/terraform-github-repository/tree/main#branch-protections-v4-configuration
    branch_protections_v4 = optional(list(object({
      pattern                         = string
      allows_deletions                = optional(bool, false)
      allows_force_pushes             = optional(bool, false)
      blocks_creations                = optional(bool, false)
      enforce_admins                  = optional(bool, true)
      push_restrictions               = optional(list(string), [])
      require_conversation_resolution = optional(bool, false)
      require_signed_commits          = optional(bool, false)
      required_linear_history         = optional(bool, false)
      required_pull_request_reviews = optional(object({
        dismiss_stale_reviews           = optional(bool, true)
        restrict_dismissals             = optional(bool, false)
        dismissal_restrictions          = optional(list(string), [])
        pull_request_bypassers          = optional(list(string), [])
        require_code_owner_reviews      = optional(bool, true)
        required_approving_review_count = optional(number, 1)
      }), {})
      required_status_checks = optional(object({
        strict   = optional(bool, false)
        contexts = optional(list(string), [])
      }), {})
    })), [])

    ## Issue Labels Configuration
    # https://github.com/mineiros-io/terraform-github-repository/tree/main#issue-labels-configuration
    issue_labels = optional(list(object({
      color       = string
      description = optional(string, null)
      id          = optional(string, "name")
      name        = string
    })), [])

    issue_labels_merge_with_github_labels = optional(bool)
    issue_labels_create                   = optional(bool)

    ## Projects Configuration
    # https://github.com/mineiros-io/terraform-github-repository/tree/main#projects-configuration
    projects = optional(list(object({
      body = optional(string, "")
      id   = optional(string, "name")
      name = string
    })), [])

    ## Webhooks Configuration
    # https://github.com/mineiros-io/terraform-github-repository/tree/main#webhooks-configuration
    webhooks = optional(list(object({
      active       = optional(bool, true)
      content_type = optional(string, "form")
      insecure_ssl = optional(bool, false)
      events       = list(string)
      name         = optional(string)
      secret       = optional(string)
      url          = string
    })), [])

    ## Secrets Configuration
    # https://github.com/mineiros-io/terraform-github-repository/tree/main#secrets-configuration
    plaintext_secrets = optional(map(string), {})
    encrypted_secrets = optional(map(string), {})

    ## Autolink References Configuration
    # https://github.com/mineiros-io/terraform-github-repository/tree/main#autolink-references-configuration
    autolink_references = optional(list(object({
      key_prefix          = string
      target_url_template = string
    })), [])

    ## App Installations
    # https://github.com/mineiros-io/terraform-github-repository/tree/main#app-installations
    app_installations = optional(set(string), [])

    ## Managing Access
    # https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository#managing-access-for-a-private-repository-in-an-organization
    access_level = optional(string, "")
  }))
}

###################
# GitHub Provider #
###################
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
  The value must end with a slash.
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
  description = "The name of the secret retrieved by secrets mixin that contains the GitHub personal access token."
  default     = null
}
