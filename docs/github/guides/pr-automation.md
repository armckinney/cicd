# Pull Request Automation Guide

This guide describes how to configure automated Pull Request (PR) creation workflows in GitHub, which is highly useful for automated dependency bumps, configuration syncs, or tag calculations.

## Use Case

When running recurring automation (like a nightly schedule to sync configurations, update lockfiles, or bump package dependencies), you want to:
1. Detect file drifts or updates automatically.
2. Commit the changes to a temporary branch in the background.
3. Open a clean, pre-configured Pull Request to the default branch (`main`).
4. Assign reviewers, add descriptive labels, and include custom descriptions.

## Workflow Implementation

Here is an example setup demonstrating how to automate PR creation when files are modified:

```yaml
name: Automated Configuration Sync

on:
  schedule:
    - cron: '0 0 * * *' # Run nightly at midnight
  workflow_dispatch: # Allow manual triggers

jobs:
  sync-configs:
    runs-on: ubuntu-24.04
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      # Step 1: Run your custom sync scripts or updates
      - name: Fetch and Sync Remote Configurations
        run: |
          ./scripts/sync-external-configs.sh
          # This script modifies files under e.g. terraform/configurations/

      # Step 2: Leverage the reusable auto-PR workflow to handle git changes
      - name: Open Pull Request
        uses: ./.github/workflows/rwf-auto-pull-request.yaml
        with:
          # Title of the Pull Request
          pr_title: 'chore(config): auto-sync external configurations'
          
          # Custom PR body markdown
          pr_body: |
            ## Automated Configuration Sync
            This is an automated pull request triggered by the nightly sync schedule.
            
            Please review the generated diff and approve the merge.
          
          # Labels to add to the Pull Request
          pr_labels: 'automation,config'
          
          # Target branch to merge into
          base_branch: 'main'
```

## How It Works

* **Diff Detection**: The reusable workflow automatically runs a `git diff` check. If no files are modified, it gracefully exits without doing any work.
* **Branch Creation**: If changes are detected, it creates a new branch (e.g. `automation/sync-<timestamp>`), commits the modifications, and pushes it to the remote repository.
* **PR Generation**: It leverages the GitHub API to draft and open a pull request, applying all configured parameters, labels, and descriptions.
* **Auto-Merge (Optional)**: Can be integrated with GitHub branch protection rules to allow automated merging once PR checks pass.
