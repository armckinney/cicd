# Version Resolution Guide

This guide describes how to automatically calculate next semantic versions (Major, Minor, or Patch) based on Git history, pull request labels, or branch contexts using the **Verge Version Provider**.

## Use Case

Manually tracking version numbers or hardcoding increments in configuration files is prone to human error and conflicts. 

An automated version resolution pipeline:
1. Examines recent tags in git history.
2. Derives next logical semantic versions (e.g. bumping `1.2.3` to `1.3.0` based on a PR label).
3. Provides dry-run calculations for downstream build tasks (e.g., tagging container images before they are released).
4. Maintains clean, automated version numbers without committing files back to the branch.

## Workflow Implementation

Here is an example setup demonstrating how to resolve and output semantic versions in your pipeline:

```yaml
name: Version Resolution Pipeline

on:
  pull_request:
    branches: [ main ]
  push:
    branches: [ main ]

jobs:
  # Job to calculate version outputs
  resolve-version:
    runs-on: ubuntu-24.04
    outputs:
      next_version: ${{ steps.version_step.outputs.next_version }}
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
        with:
          fetch-depth: 0 # Essential: fetch all tags to calculate next version

      # Step 1: Install and configure Verge CLI
      - name: Setup Verge CLI
        uses: ./.github/actions/verge/setup
        with:
          version: '' # Installs latest Verge version

      # Step 2: Calculate the version resolution
      - name: Resolve SemVer Tag
        id: version_step
        shell: bash
        run: |
          # Calculate dry-run version increment
          calculated_version=$(verge resolve --dry-run)
          echo "next_version=$calculated_version" >> "$GITHUB_OUTPUT"

  # Use the resolved version in downstream build steps
  use-resolved-version:
    needs: [ resolve-version ]
    runs-on: ubuntu-24.04
    steps:
      - name: Build artifact
        run: |
          echo "Building package version: ${{ needs.resolve-version.outputs.next_version }}"
```

## How the Verge Version Provider Resolves Tags

When running Verge version calculation:
* **Pull Request Labels**: If a Pull Request has the label `major`, `minor`, or `patch`, Verge automatically applies the corresponding bump to the last tagged release.
* **Commit Scopes / Branch Context**: On push events, Verge can calculate increments using standard Conventional Commits scopes (e.g., `feat:` triggers minor, `fix:` triggers patch).
* **Environment Separation**: Easily separate release tags (`1.2.0`) from developer preview tags (`1.2.0-dev.1`) dynamically based on branch filters.
