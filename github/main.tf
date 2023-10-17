module "repos" {
  # checkov:skip=CKV_TF_1: For now we use Terraform registry source, not git. If switching to git, we should use a commit hash.
  source  = "mineiros-io/repository/github"
  version = "0.18.0"

  for_each = var.repos

  # Main Resource Configuration
  allow_auto_merge   = each.value.allow_auto_merge
  allow_merge_commit = each.value.allow_merge_commit
  allow_rebase_merge = each.value.allow_rebase_merge
  allow_squash_merge = each.value.allow_squash_merge
  archive_on_destroy = each.value.archive_on_destroy
  archived           = each.value.archived
  # NOTE: The configured branch must exist in the repository.
  # If the branch doesn't exist yet, or if you are creating a new repository,
  # please add the desired default branch to the `branches` variable, which will cause Terraform to create it for you.
  default_branch       = each.value.default_branch
  description          = each.value.description
  extra_topics         = each.value.extra_topics
  has_downloads        = each.value.has_downloads
  has_issues           = each.value.has_issues
  has_projects         = each.value.has_projects
  has_wiki             = each.value.has_wiki
  homepage_url         = each.value.homepage_url
  is_template          = each.value.is_template
  name                 = each.key
  pages                = each.value.pages
  topics               = each.value.topics
  visibility           = each.value.visibility
  vulnerability_alerts = each.value.vulnerability_alerts

  # Extended Resource Configuration
  auto_init          = each.value.auto_init
  gitignore_template = each.value.gitignore_template
  license_template   = each.value.license_template
  template           = each.value.template

  # Teams Configuration
  admin_teams    = each.value.admin_teams
  maintain_teams = each.value.maintain_teams
  pull_teams     = each.value.pull_teams
  push_teams     = each.value.push_teams
  triage_teams   = each.value.triage_teams

  # Collaborator Configuration
  admin_collaborators    = each.value.admin_collaborators
  maintain_collaborators = each.value.maintain_collaborators
  pull_collaborators     = each.value.pull_collaborators
  push_collaborators     = each.value.push_collaborators
  triage_collaborators   = each.value.triage_collaborators

  # Branches Configuration
  branches = each.value.branches

  # Deploy Keys Configuration
  deploy_keys          = each.value.deploy_keys
  deploy_keys_computed = each.value.deploy_keys_computed

  # Branch Protections v4 Configuration
  branch_protections_v4 = each.value.branch_protections_v4

  # Issue Labels Configuration
  issue_labels        = each.value.issue_labels
  issue_labels_create = each.value.issue_labels_create

  issue_labels_merge_with_github_labels = each.value.issue_labels_merge_with_github_labels

  # Projects Configuration
  projects = each.value.projects

  # Webhooks Configuration
  webhooks = each.value.webhooks

  # Secrets Configuration
  plaintext_secrets = each.value.plaintext_secrets
  encrypted_secrets = each.value.encrypted_secrets

  # Autolink References Configuration
  autolink_references = each.value.autolink_references

  # App Installations
  app_installations = each.value.app_installations
}
