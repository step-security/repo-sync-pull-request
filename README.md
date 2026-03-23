[![StepSecurity Maintained Action](https://raw.githubusercontent.com/step-security/maintained-actions-assets/main/assets/maintained-action-banner.png)](https://docs.stepsecurity.io/actions/stepsecurity-maintained-actions)

# GitHub Pull Request Action

A GitHub Action to automatically create pull requests.

## Usage

### Basic

Create a pull request from the current branch to `main` on every push:

```yaml
# .github/workflows/pull-request.yml
on:
  push:
    branches:
      - feature/*

permissions:
  contents: read
  pull-requests: write

jobs:
  pull-request:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6
      - uses: step-security/repo-sync-pull-request@v2
        with:
          pr_title: "Merge ${{ github.ref_name }} into main"
          destination_branch: main
          github_token: ${{ secrets.GITHUB_TOKEN }}
```

### With reviewers, labels, and assignees

```yaml
- uses: step-security/repo-sync-pull-request@v2
  with:
    pr_title: "Release: merge develop into main"
    pr_body: "Automated PR to merge latest changes from develop."
    source_branch: develop
    destination_branch: main
    pr_reviewer: "octocat,hubot"
    pr_assignee: "octocat"
    pr_label: "automated,release"
    pr_draft: true
    github_token: ${{ secrets.GITHUB_TOKEN }}
```

### Using outputs

```yaml
steps:
  - uses: actions/checkout@v6
  - uses: step-security/repo-sync-pull-request@v2
    id: create-pr
    with:
      pr_title: "Sync changes"
      destination_branch: main
      github_token: ${{ secrets.GITHUB_TOKEN }}
  - run: echo "PR URL ${{ steps.create-pr.outputs.pr_url }}"
    if: steps.create-pr.outputs.pr_created == 'true'
```

### Cross-repository pull request

```yaml
- uses: step-security/repo-sync-pull-request@v2
  with:
    destination_repository: "owner/other-repo"
    pr_title: "Sync upstream changes"
    destination_branch: main
    github_token: ${{ secrets.PAT_TOKEN }}
```

## Inputs

| Input                    | Required | Default               | Description                                                                 |
| ------------------------ | -------- | --------------------- | --------------------------------------------------------------------------- |
| `github_token`           | Yes      | `${{ github.token }}` | GitHub token for authentication                                             |
| `source_branch`          | No       | Triggered branch      | Branch name to pull from                                                    |
| `destination_branch`     | No       | `master`              | Branch name to create the pull request against                              |
| `destination_repository` | No       | Current repository    | Repository (`owner/repo`) to create the pull request in                     |
| `pr_title`               | No       |                       | Pull request title                                                          |
| `pr_body`                | No       |                       | Pull request body                                                           |
| `pr_template`            | No       |                       | Path to a pull request body template file                                   |
| `pr_reviewer`            | No       |                       | Comma-separated list of reviewers (no spaces)                               |
| `pr_assignee`            | No       |                       | Comma-separated list of assignees (no spaces)                               |
| `pr_label`               | No       |                       | Comma-separated list of labels (no spaces)                                  |
| `pr_milestone`           | No       |                       | Pull request milestone                                                      |
| `pr_draft`               | No       |                       | Set to `true` to create a draft pull request                                |
| `pr_allow_empty`         | No       |                       | Set to `true` to create the PR even if there are no file changes            |
| `working_directory`      | No       |                       | Change the working directory for the action                                 |
| `debug`                  | No       |                       | Set to `true` to enable bash debug mode                                     |

## Outputs

| Output              | Description                                              |
| ------------------- | -------------------------------------------------------- |
| `pr_url`            | URL of the created (or existing) pull request            |
| `pr_number`         | Number of the created (or existing) pull request         |
| `pr_created`        | `true` if a new pull request was created, `false` if one already existed |
| `has_changed_files` | `true` if there are file differences between the branches |
