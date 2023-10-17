[![Masterpoint Logo](https://i.imgur.com/RDLnuQO.png)](https://masterpoint.io)

# terraform-components [![Latest Release](https://img.shields.io/github/release/masterpointio/terraform-components.svg)](https://github.com/masterpointio/terraform-components/releases/latest)

This is a Masterpoint's reusable and sharable collection of Terraform Root Modules (Components). Each Component is a set of Terraform modules, resources, data sources and local expressions that represent an higher abstraction layer of infrastructure comparing to an average community child module. It can be easily integrated into the architecture and removed if needed.

It's Open Source and licensed under the [APACHE2](LICENSE).

## Components

- [GitHub](./github/README.md): responsible for managing GitHub resources, including repositories, teams, permissions, pages, etc.

## Trunk Linter

To maintain code quality we use a collection of linters, all managed by [Trunk](https://trunk.io).

To install trunk on your machine you can use brew: `brew install trunk-io`. You can also install trunk via the [official instructions](https://docs.trunk.io/docs/install).

### Usage

To run the linters, simply run `trunk check` from the root of the project. This will check any files that you have changed in your current branch.

To automatically apply formatting changes, run `trunk fmt`.

## Automating Trunk

Trunk can manage git hooks, and is configured to run `fmt` on pre-commit and `check` on pre-push. This should help to prevent code being kicked-back by CI.

Trunk is automated in CI using GitHub Actions, and PRs will be blocked if the linters fail.
