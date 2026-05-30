# Versioned Release Guide

This guide describes how to configure an automated software release pipeline that increments semantic versions, pushes Git tags, drafts GitHub Releases, and prunes stale development tags.

## Use Case

When merging developer features into the default branch (like `main`), a production release pipeline should:
1. Determine the final release version.
2. Push a permanent Git tag representing that version to the repository.
3. Generate a GitHub Release containing automated changelogs.
4. Prune temporary developer preview tags (e.g. `-dev` tags) to keep the repository Git graph clean.

## Workflow Implementation

Here is an example setup using our reusable Verge tag workflow (`rwf-verge-tag.yaml`):

```yaml
name: Production Release Pipeline

on:
  push:
    branches:
      - main
    tags-ignore:
      - '**' # Prevent recursive trigger when the pipeline pushes tags

jobs:
  # Automated SemVer Tagging and Release
  release-and-tag:
    uses: ./.github/workflows/rwf-verge-tag.yaml
    secrets: inherit
    with:
      # No verge_arguments are required! 
      # The workflow automatically resolves the bump kind (major|minor|patch) from the merged PR labels.
      
      # Prunes all temporary development pre-release tags from history
      prune_dev_tags: true
```

## How It Works

1. **Tag Calculation**: Verge analyzes git commits since the last final tag to automatically calculate the next version bump.
2. **Git Tagging**: It securely signs and pushes the new tag (e.g., `v1.3.0`) directly to your repository.
3. **Draft Release**: It interacts with the GitHub Releases API to create a new draft or pre-release container, automatically compiling commit headers into a clean changelog.
4. **Git Pruning**: If `prune_dev_tags` is `true`, the workflow runs local and remote prune processes (`git push --delete`) to wipe out temporary development tag pointers (e.g., `v1.3.0-dev.45`) that were generated during testing on feature branches.

## Downstream Integration
Once a final release tag is created, you can trigger downstream deployments or package publishing pipelines (e.g. PyPI or NPM publishes) by listening specifically for new tag events:

```yaml
on:
  push:
    tags:
      - 'v*.*.*' # Trigger when a final tag is pushed
```
